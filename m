References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3c76be60-dd30-cc3d-f401-013f3465341e@...2080...>
Date: Fri, 15 Feb 2019 23:10:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190122150333.1061-5-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 5/6] Sent indication that a session
 is expired to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

On 22/01/2019 16:03, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This allows OpenVPN 3 core to fall back to the original authentication
> method.
> 
> This commit changes man_def_auth_set_client_reason to
> auth_set_client_reason since it now used in more contexts.
> 
> Also remove a FIXME about client_reason not being freed, as it is freed
> in tls_multi_free with auth_set_client_reason(multi, NULL);
> ---
>  src/openvpn/auth_token.c |  3 +++
>  src/openvpn/ssl.c        |  6 ++----
>  src/openvpn/ssl_common.h | 10 +++++-----
>  src/openvpn/ssl_verify.c |  8 ++++----
>  src/openvpn/ssl_verify.h | 15 ++++++++++-----
>  5 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index 12bb724a..74a76b72 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -15,6 +15,7 @@
>  #include "push.h"
>  #include "integer.h"
>  #include "ssl.h"
> +#include "ssl_verify.h"
>  
>  const char *auth_token_pem_name = "OpenVPN auth-token server key";
>  
> @@ -356,6 +357,8 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>  
>      if (ret & AUTH_TOKEN_EXPIRED)
>      {
> +        /* Tell client that the session token is expired */
> +        auth_set_client_reason(multi, "SESSION: token expired");
>          msg(M_INFO, "--auth-token-gen: auth-token from client expired");
Feature-ACK!  Code change looks sane, but need to test this more carefully -
where it would be good to have the changes from previous comments implemented.

But, we should fix the incorrect msg() above.  It should say --auth-gen-token.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


