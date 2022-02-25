using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using LeanCode.Chat.Contracts.Notifications;
using LeanCode.Chat.Services.DataAccess.Events;
using LeanCode.Chat.Services.DataAccess.Notifications;
using LeanCode.Chat.Services.DataAccess.Services;
using LeanCode.Firebase.FCM;
using MassTransit;

namespace LeanCode.Chat.Services.Processes
{
    public class SendPNOnNewMessage : IConsumer<MessageSent>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<SendPNOnNewMessage>();
        private readonly ChatConfiguration configuration;
        private readonly FCMClient fcm;
        private readonly IPushNotificationTokenStore pushNotificationTokenStore;
        private readonly IChatPushNotificationsLocalizer pushNotificationsLocalizer;

        public SendPNOnNewMessage(
            ChatConfiguration configuration,
            FCMClient fcm,
            IPushNotificationTokenStore pushNotificationTokenStore,
            IChatPushNotificationsLocalizer pushNotificationsLocalizer)
        {
            this.configuration = configuration;
            this.fcm = fcm;
            this.pushNotificationTokenStore = pushNotificationTokenStore;
            this.pushNotificationsLocalizer = pushNotificationsLocalizer;
        }

        public async Task Consume(ConsumeContext<MessageSent> context)
        {
            if (!configuration.SendNotificationOnNewMessage)
            {
                logger.Information(
                    "Sending default notification for new message is disabled, skipping sending PN for message {MessageId}",
                    context.Message.MessageId);
                return;
            }

            var message = context.Message;

            var conversationId = message.ConversationId;
            var messageId = message.MessageId;
            var recipients = message.ConversationMembers
                .Where(m => m != message.SenderId)
                .ToList();

            var localesMap = await pushNotificationsLocalizer.GetUserLocales(recipients);
            var allLocales = localesMap.Values.Distinct().ToList();

            var localizationData = new NewMessageNotificationData
            {
                Content = message.Content,
                ConversationMetadata = message.ConversationMetadata,
                SenderId = message.SenderId,
            };

            var localizations = await pushNotificationsLocalizer.LocalizeNewMessageNotification(localizationData, allLocales);
            var userTokens = await pushNotificationTokenStore.GetTokensAsync(recipients.ToHashSet(), context.CancellationToken);

            var tokensPerLocale = recipients
                .Select(r =>
                {
                    userTokens.TryGetValue(r, out var tokens);
                    return new
                    {
                        UserId = r,
                        Locale = localesMap[r],
                        Tokens = tokens ?? new List<string>(),
                    };
                })
                .GroupBy(g => g.Locale)
                .ToDictionary(
                    g => g.Key,
                    g => g.SelectMany(x => x.Tokens).ToList());

            foreach (var (locale, tokens) in tokensPerLocale)
            {
                if (!tokens.Any())
                {
                    logger.Information(
                        "No users with tokens for locale {Locale}, skipping sending notification",
                        locale);
                    return;
                }

                var localizedNotification = localizations[locale];

                var content = NewMessageNotificationContentDTO.Create(conversationId, messageId);
                var notificationData = NotificationsMapper.ToNotificationData(content);
                notificationData["click_action"] = "FLUTTER_NOTIFICATION_CLICK";

                var fcmMessage = new MulticastMessage
                {
                    Notification = localizedNotification,
                    Data = notificationData,
                    Tokens = tokens,
                    Android = new AndroidConfig
                    {
                        CollapseKey = conversationId.ToString(),
                        Notification = new AndroidNotification
                        {
                            Tag = conversationId.ToString(),
                        },
                    },
                    Apns = new ApnsConfig
                    {
                        Aps = new Aps
                        {
                            ThreadId = conversationId.ToString(),
                            Sound = "default",
                        },
                    },
                };

                await fcm.SendMulticastAsync(fcmMessage);

                logger.Information(
                        "Notification for message {MessageId} sent to {TokensCount} devices for users with locale {Locale}",
                        message.MessageId,
                        tokens.Count,
                        locale);
            }
        }
    }
}
