References: <20170707195941.61773-1-thomas.veerman@...1862...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e243395d-f494-0262-fd29-2759391d907c@...1227...>
Date: Fri, 7 Jul 2017 23:01:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170707195941.61773-1-thomas.veerman@...1862...>
Subject: Re: [Openvpn-devel] [PATCH] Fix socks_proxy_port pointing to
 invalid data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Thomas Veerman <thomas.veerman@...1862...>, openvpn-devel@lists.sourceforge.net

Am 07.07.17 um 21:59 schrieb Thomas Veerman via Openvpn-devel:
> When setting the SOCKS proxy through the management interface, the
> socks_proxy_port pointer would be set to a value that's no longer valid
> by the time it's used by do_preresolve_host.
> 
> Signed-off-by: Thomas Veerman <thomas.veerman@...1862...>
> ---
>  src/openvpn/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a54307ad..80a8f5fa 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -150,7 +150,7 @@ management_callback_proxy_cmd(void *arg, const char **p)
>          else if (streq(p[1], "SOCKS"))
>          {
>              ce->socks_proxy_server = string_alloc(p[2], gc);
> -            ce->socks_proxy_port = p[3];
> +            ce->socks_proxy_port = string_alloc(p[3], gc);
>              ret = true;
>          }
>      }
> 


ACK. Probably my fault, when I changed that from int to string.

Arne

