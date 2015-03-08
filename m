Message-ID: <54FC52BB.8070205@...1856...>
Date: Sun, 08 Mar 2015 14:46:35 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1425819401-18465-1-git-send-email-gert@...1296...>
In-Reply-To: <1425819401-18465-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix incorrect use of get_ipv6_addr()
 for iroute options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 08-03-15 13:56, Gert Doering wrote:
> get_ipv6_addr() returns "bool/false", not "int < 0" to signal error.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 20b37db..df9a641 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1254,7 +1254,7 @@ option_iroute_ipv6 (struct options *o,
>
>     ALLOC_OBJ_GC (ir, struct iroute_ipv6, &o->gc);
>
> -  if ( get_ipv6_addr (prefix_str, &ir->network, &ir->netbits, NULL, msglevel ) < 0 )
> +  if ( !get_ipv6_addr (prefix_str, &ir->network, &ir->netbits, NULL, msglevel ))
>       {
>         msg (msglevel, "in --iroute-ipv6 %s: Bad IPv6 prefix specification",
>   	   prefix_str);

ACK

-Steffan

