using Autofac;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.Components;

namespace LeanCode.Chat
{
    public class ChatModule : AppModule
    {
        protected override void Load(ContainerBuilder builder)
        {
            builder.RegisterType<ChatService>()
                .AsSelf();
        }
    }
}
