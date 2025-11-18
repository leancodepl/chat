using LeanCode.Chat.Services.DataAccess;
using Microsoft.Extensions.DependencyInjection;

namespace LeanCode.Chat
{
    public static class ChatModule
    {
        public static void AddLeanChat(this IServiceCollection services)
        {
            services.AddTransient<ChatService>();
        }
    }
}
