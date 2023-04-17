Message-ID: <ba595b06-846a-707e-b4ed-ba10bff613e7@...1227...>
Date: Mon, 17 Apr 2023 16:24:59 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
References: <20230417134046.81761-1-arne@...1227...>
In-Reply-To: <20230417134046.81761-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix compile error on TARGET_ANDROID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 17.04.23 um 15:40 schrieb Arne Schwabe:
> Commit 3132bead49 accidentially was submitted with a missing semicolon
> at the end of the line. Whoops.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/socket.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index ab8cc754..fc643c1c 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1165,7 +1165,7 @@ protect_fd_nonlocal(int fd, const struct sockaddr *addr)
>   {
>       if (!management)
>       {
> -        msg(M_FATAL, "Required management interface not available.")
> +        msg(M_FATAL, "Required management interface not available.");
>       }
>   
>       /* pass socket FD to management interface to pass on to VPNService API

Note that this patch is uncrusity clean on my own machine but fails on 
github for some reason. Diff is:

--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1103,7 +1103,7 @@ redirect_default_route_to_vpn(struct route_list 
*rl, const struct tuntap *tt,
                      ret = add_route3(0, 0, rl->spec.remote_endpoint, tt,
                                       flags, &rl->rgi, es, ctx) && ret;
                  }
-#endif
+#endif /* ifdef TARGET_ANDROID */
              }

              /* set a flag so we can undo later */

