Message-ID: <890909ef-8e23-be40-65ae-46eda6ebe7bd@...2181...>
Date: Wed, 13 Jul 2022 14:08:29 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220712220917.4114-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220712220917.4114-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] networking_sitnl: standardize returned
 error when no ifindex can be retrieved
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

let's drop this patch as using errno after another syscall has been made 
is not clean.

Will send a patch that fixes the errno/-errno alone.

Cheers,

On 13/07/2022 00:09, Antonio Quartulli wrote:
> if_nametoindex() sets errno to the related error code in case of
> failure.
> 
> For this reason the caller function should rather propagate this value
> instead of coming up with its own.
> 
> Right now instead we have:
> * return -1
> * return -ENOENT
> * return errno (positive value!!)
> 
> Make all code behave the same and always return -errno in case of
> failure. Most common error will still be -ENODEV, when no device with
> the provided name could be found.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   src/openvpn/networking_sitnl.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
> index b2f3ac72..29b7d8c2 100644
> --- a/src/openvpn/networking_sitnl.c
> +++ b/src/openvpn/networking_sitnl.c
> @@ -660,7 +660,7 @@ net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
>       {
>           msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface,
>               strerror(errno));
> -        return -ENOENT;
> +        return -errno;
>       }
>   
>       req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
> @@ -698,7 +698,7 @@ net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface,
>       {
>           msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
>               iface);
> -        return -1;
> +        return -errno;
>       }
>   
>       req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
> @@ -731,7 +731,7 @@ net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
>       {
>           msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
>               iface);
> -        return -1;
> +        return -errno;
>       }
>   
>       req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
> @@ -839,7 +839,7 @@ sitnl_addr_ptp_add(sa_family_t af_family, const char *iface,
>       {
>           msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(iface),
>               strerror(errno));
> -        return -ENOENT;
> +        return -errno;
>       }
>   
>       return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
> @@ -872,7 +872,7 @@ sitnl_addr_ptp_del(sa_family_t af_family, const char *iface,
>       if (ifindex == 0)
>       {
>           msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
> -        return -ENOENT;
> +        return -errno;
>       }
>   
>       return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
> @@ -979,7 +979,7 @@ sitnl_addr_add(sa_family_t af_family, const char *iface,
>       {
>           msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
>               iface);
> -        return -ENOENT;
> +        return -errno;
>       }
>   
>       return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
> @@ -1013,7 +1013,7 @@ sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr,
>       {
>           msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
>               iface);
> -        return -ENOENT;
> +        return -errno;
>       }
>   
>       return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL,
> @@ -1163,7 +1163,7 @@ sitnl_route_add(const char *iface, sa_family_t af_family, const void *dst,
>           {
>               msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s",
>                   __func__, iface);
> -            return -ENOENT;
> +            return -errno;
>           }
>       }
>   
> @@ -1256,7 +1256,7 @@ sitnl_route_del(const char *iface, sa_family_t af_family, inet_address_t *dst,
>           {
>               msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s",
>                   __func__, iface);
> -            return -ENOENT;
> +            return -errno;
>           }
>       }
>   
> @@ -1483,7 +1483,7 @@ net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
>   
>       if (!ifindex)
>       {
> -        return errno;
> +        return -errno;
>       }
>   
>       req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));

-- 
Antonio Quartulli

