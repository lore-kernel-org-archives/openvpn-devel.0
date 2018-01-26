References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
Date: Fri, 26 Jan 2018 14:11:52 +0100
MIME-Version: 1.0
In-Reply-To: <1516815105-17882-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

the patch works as expected but I did notice something in the openvpn log :

Fri Jan 26 14:08:09 2018 do_ifconfig, tt->did_ifconfig_ipv6_setup=1
Fri Jan 26 14:08:10 2018 NETSH: C:\Windows\system32\netsh.exe interface 
ipv6 set address interface=17 2001:610:120::200:0:1001 store=active
Fri Jan 26 14:08:10 2018 add_route_ipv6(2001:610:120::200:0:0/112 -> 
2001:610:120::200:0:1001 metric 0) dev vpn0
Fri Jan 26 14:08:10 2018 C:\Windows\system32\netsh.exe interface ipv6 
add route 2001:610:120::200:0:0/112 interface=17 fe80::8 store=active
Fri Jan 26 14:08:10 2018 env_block: add 
PATH=C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem

the route was added with the default GW of fe80::8 : should I be worried ?
Note that this also happened with the regular 2.4.4 version of OpenVPN 
and also note that the TAP adapter on my Win7 laptop is named 'vpn0'

JJK


On 24-Jan-18 18:31, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>
> Currently a route addition using IPAPI or service is skipped if the
> route gateway is reachable by multiple interfaces. This changes that
> to use the interface with lowest metric. Implemented by
>
> (i)  Do not over-write the return value with TUN_ADAPTER_INDEX_INVALID in
>       windows_route_find_if_index() if multiple interfaces match a route.
> (ii) Select the interface with lowest metric in adapter_index_of_ip()
>       instead of the first one found when multiple interfaces match.
>
> Reported by Jan Just Keijser <janjust@...1147...>
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
>
> ---
> NOTE: depends on https://patchwork.openvpn.net/patch/136/
>
> v3: Simpliyfy the patch using get_interface_metric from block_dns.c
>      Simpler is also easier to review :)
>      (requires patch 136 https://patchwork.openvpn.net/patch/136/)
> v2:
>      - Revert an unintented edit of route.c (a_index = ...)
>      - Improve the commit message
>
>   src/openvpn/route.c |  1 -
>   src/openvpn/tun.c   | 17 +++++++++++++++--
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index f121d3f..218ca96 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2785,7 +2785,6 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
>           msg(M_WARN, "Warning: route gateway is ambiguous: %s (%d matches)",
>               print_in_addr_t(r->gateway, 0, &gc),
>               count);
> -        ret = TUN_ADAPTER_INDEX_INVALID;
>       }
>   
>       dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d",
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2644d99..f424f82 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -45,6 +45,7 @@
>   #include "manage.h"
>   #include "route.h"
>   #include "win32.h"
> +#include "block_dns.h"
>   
>   #include "memdbg.h"
>   
> @@ -4480,6 +4481,7 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>       struct gc_arena gc = gc_new();
>       DWORD ret = TUN_ADAPTER_INDEX_INVALID;
>       in_addr_t highest_netmask = 0;
> +    int lowest_metric = INT_MAX;
>       bool first = true;
>   
>       if (count)
> @@ -4493,9 +4495,14 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>   
>           if (is_ip_in_adapter_subnet(list, ip, &hn))
>           {
> +            int metric = get_interface_metric(list->Index, AF_INET, NULL);
>               if (first || hn > highest_netmask)
>               {
>                   highest_netmask = hn;
> +                if (metric >= 0)
> +                {
> +                    lowest_metric = metric;
> +                }
>                   if (count)
>                   {
>                       *count = 1;
> @@ -4509,16 +4516,22 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
>                   {
>                       ++*count;
>                   }
> +                if (metric >= 0 && metric < lowest_metric)
> +                {
> +                    ret = list->Index;
> +                    lowest_metric = metric;
> +                }
>               }
>           }
>           list = list->Next;
>       }
>   
> -    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d",
> +    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d metric=%d",
>            print_in_addr_t(ip, 0, &gc),
>            print_in_addr_t(highest_netmask, 0, &gc),
>            (int)ret,
> -         count ? *count : -1);
> +         count ? *count : -1,
> +         lowest_metric);
>   
>       if (ret == TUN_ADAPTER_INDEX_INVALID && count)
>       {


