Message-ID: <54861A21.4060809@...1856...>
Date: Mon, 08 Dec 2014 22:37:37 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1418074541-24987-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1418074541-24987-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] plugin, down-root: Fix compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

ACK

-Steffan

On 08-12-14 22:35, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
> 
> Removed a few compiler warnings:
>   down-root.c:164:4: warning: implicit declaration of function 'warn' [-Wimplicit-function-declaration]
>   down-root.c:239:5: warning: implicit declaration of function 'err' [-Wimplicit-function-declaration]
>   down-root.c:461:7: warning: unused variable 'i' [-Wunused-variable]
>   down-root.c:460:15: warning: unused variable 'p' [-Wunused-variable]
> 
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  src/plugins/down-root/down-root.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
> index ed2636a..f7a49a0 100644
> --- a/src/plugins/down-root/down-root.c
> +++ b/src/plugins/down-root/down-root.c
> @@ -42,6 +42,7 @@
>  #include <signal.h>
>  #include <syslog.h>
>  #include <errno.h>
> +#include <err.h>
>  
>  #include <openvpn-plugin.h>
>  
> @@ -457,9 +458,6 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
>  static void
>  down_root_server (const int fd, char * const *argv, char * const *envp, const int verb)
>  {
> -  const char *p[3];
> -  int i;
> -
>    /*
>     * Do initialization
>     */
> 

