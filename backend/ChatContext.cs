using System;
using System.Security.Claims;
using System.Threading;
using LeanCode.Correlation;
using LeanCode.CQRS.Security;
using LeanCode.Pipelines;
using Microsoft.AspNetCore.Http;

namespace LeanCode.Chat
{
    public class ChatContext : ISecurityContext, ICorrelationContext
    {
        IPipelineScope IPipelineContext.Scope { get; set; } = null!;
        ClaimsPrincipal ISecurityContext.User => user;
        Guid ICorrelationContext.CorrelationId { get; set; }
        Guid ICorrelationContext.ExecutionId { get; set; }
        public CancellationToken CancellationToken { get; }
        public Guid UserId { get; }

        private readonly ClaimsPrincipal user;

        private ChatContext(ClaimsPrincipal user, CancellationToken cancellationToken)
        {
            this.user = user;
            CancellationToken = cancellationToken;
            UserId = ParseUserClaim(DefaultChatClaims.UserId);
        }

        public static ChatContext FromHttp(HttpContext httpContext)
        {
            return new ChatContext(httpContext.User, httpContext.RequestAborted);
        }

        private Guid ParseUserClaim(string claimType)
        {
            if (user?.Identity?.IsAuthenticated ?? false)
            {
                var str = user.FindFirstValue(claimType);

                if (Guid.TryParse(str, out var res))
                {
                    return res;
                }
            }

            return Guid.Empty;
        }
    }
}
