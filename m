Message-ID: <ab9aab99-ec34-497b-abb3-ce6476e7da6a@...2181...>
Date: Mon, 15 Sep 2025 23:51:57 +0200
MIME-Version: 1.0
References: <aMXW3jwQJ9TyvOae@...1296...>
 <20250915110507.20557-1-sebastian-git-2016@...2913...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20250915110507.20557-1-sebastian-git-2016@...2913...>
Subject: Re: [Openvpn-devel] [PATCH v3] Bugfix: Set broadcast address on
 interface.
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
To: Sebastian Marsching <sebastian-git-2016@...2913...>, openvpn-devel@lists.sourceforge.net
Cc: gert@...1296...

Hi,

On 15/09/2025 13:05, Sebastian Marsching wrote:
> This fixes a problem that was introduced in OpenVPN 2.5. Previously,
> the ifconfig utility was used for adding the local address to an
> interface. This utility automatically sets the correct broadcast address
> based on the given unicast address and netmask.
> 
> Due to switching to iproute and Netlink, this does not happen
> automatically any longer, which means that applications that rely on
> broadcasts do not work correctly.
> 

iproute2 was already supported before 2.5 (but probably it needed to be 
explicitly activated at compile time), therefore I'd say this bug 
already existed :)

I went through the kernel code and I can clearly see the difference in 
APIs: the old SIOCSIFADDR ioctl (used by net-tools/ifconfig) takes care 
of computing the broadcast address:

1230                 if (!(dev->flags & IFF_POINTOPOINT)) {
1231                         ifa->ifa_prefixlen = 
inet_abc_len(ifa->ifa_address);
1232                         ifa->ifa_mask = 
inet_make_mask(ifa->ifa_prefixlen);
1233                         if ((dev->flags & IFF_BROADCAST) &&
1234                             ifa->ifa_prefixlen < 31)
1235                                 ifa->ifa_broadcast = ifa->ifa_address |
1236                                                      ~ifa->ifa_mask;
1237                 }

However, this logic does not exist in the more modern netlink code, 
therefore it was a somehow conscious decision.

> This patch fixes this issue both when using iproute (by telling iproute
> to set the broadcast address based on the local address and prefix) and
> when using Netlink (by calculating the correct broadcast address and
> setting it).

I imagine this is the behaviour the average OpenVPN user expects 
(although probably only few of them needs a brd address), therefore 
thanks for fixing this.

> 
> Signed-off-by: Sebastian Marsching <sebastian-git-2016@...2913...>
> ---
>   src/openvpn/networking_iproute2.c | 2 +-
>   src/openvpn/networking_sitnl.c    | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
> index e9be3a45..773571d6 100644
> --- a/src/openvpn/networking_iproute2.c
> +++ b/src/openvpn/networking_iproute2.c
> @@ -150,7 +150,7 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr
>   
>       const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
>   
> -    argv_printf(&argv, "%s addr add dev %s %s/%d", iproute_path, iface, addr_str, prefixlen);
> +    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast +", iproute_path, iface, addr_str, prefixlen);
>       argv_msg(M_INFO, &argv);
>       openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
>   
> diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
> index 4210e92c..00d61067 100644
> --- a/src/openvpn/networking_sitnl.c
> +++ b/src/openvpn/networking_sitnl.c
> @@ -31,6 +31,7 @@
>   #include "misc.h"
>   #include "networking.h"
>   #include "proto.h"
> +#include "route.h"
>   
>   #include <errno.h>
>   #include <string.h>
> @@ -803,6 +804,13 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
>           SITNL_ADDATTR(&req.n, sizeof(req), IFA_LOCAL, local, size);
>       }
>   
> +    if (af_family == AF_INET && local && !remote && prefixlen <= 30)
> +    {
> +        inet_address_t broadcast = *local;
> +        broadcast.ipv4 |= htonl(~netbits_to_netmask(prefixlen));
> +        SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, &broadcast, size);
> +    }
> +

The code looks good and makes sense to me (nice to see how concise a 
patch extending sitnl can be :)).

Thanks Gert for complaining about the style earlier on.

I haven't tested it, but we have a buildbot army which will tell us if 
some esoteric bug is hidden away.

Acked-by: Antonio Quartulli <antonio@...2726...>

Regards,

>       ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
>       if (ret == -EEXIST)
>       {

-- 
Antonio Quartulli


