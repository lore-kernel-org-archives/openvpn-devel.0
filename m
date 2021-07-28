References: <20210727143741.29039-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4197f2e9-dcdb-d7f6-74ac-0a2f9400bcfe@...2181...>
Date: Wed, 28 Jul 2021 10:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <20210727143741.29039-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Use more C99 initialization in
 add_route/add_route_ipv6().
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 27/07/2021 16:37, Gert Doering wrote:
> This gets rid of a few #ifdef and also removes the need for
> commit a11bea18b1c93 (argv is only initialized after the
> early exit check on RT_DEFINED).
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index e429e8c0..bec5d6ff 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1570,32 +1570,24 @@ add_route(struct route_ipv4 *r,
>            const struct env_set *es,
>            openvpn_net_ctx_t *ctx)
>  {
> -    struct gc_arena gc;
> -    struct argv argv = argv_new();
> -#if !defined(TARGET_LINUX)
> -    const char *network;
> -#if !defined(TARGET_AIX)
> -    const char *netmask;
> -#endif
> -    const char *gateway;
> -#endif
>      bool status = false;
>      int is_local_route;
>  
>      if (!(r->flags & RT_DEFINED))
>      {
> -        argv_free(&argv);
>          return;
>      }
> +    struct argv argv = argv_new();
>  

isn't it nicer to attach the two declarations and leave an empty line
between them and the upper block? :-)

> +    struct gc_arena gc;
>      gc_init(&gc);

Since you are here, why not compressing these two lines in one:

   struct gc_arena gc = gc_new();

?

>  
>  #if !defined(TARGET_LINUX)
> -    network = print_in_addr_t(r->network, 0, &gc);
> +    const char *network = print_in_addr_t(r->network, 0, &gc);
>  #if !defined(TARGET_AIX)
> -    netmask = print_in_addr_t(r->netmask, 0, &gc);
> +    const char *netmask = print_in_addr_t(r->netmask, 0, &gc);
>  #endif
> -    gateway = print_in_addr_t(r->gateway, 0, &gc);
> +    const char *gateway = print_in_addr_t(r->gateway, 0, &gc);
>  #endif
>  
>      is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
> @@ -1879,23 +1871,18 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
>                 openvpn_net_ctx_t *ctx)
>  {
>      struct gc_arena gc;

why not moving this gc declaration like you did above?

> -    struct argv argv = argv_new();
>  
> -    const char *network;
> -    const char *gateway;
>      bool status = false;
>      const char *device = tt->actual_name;
> -#if defined(TARGET_LINUX)
> -    int metric;
> -#endif
>      bool gateway_needed = false;
>  
>      if (!(r6->flags & RT_DEFINED) )
>      {
> -        argv_free(&argv);
>          return;
>      }
>  
> +    struct argv argv = argv_new();
> +
>  #ifndef _WIN32
>      if (r6->iface != NULL)              /* vpn server special route */
>      {
> @@ -1910,9 +1897,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
>      gc_init(&gc);
>  
>      route_ipv6_clear_host_bits(r6);
> -
> -    network = print_in6_addr( r6->network, 0, &gc);
> -    gateway = print_in6_addr( r6->gateway, 0, &gc);
> +    const char *network = print_in6_addr( r6->network, 0, &gc);
> +    const char *gateway = print_in6_addr( r6->gateway, 0, &gc);
>  
>  #if defined(TARGET_DARWIN)    \
>      || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
> @@ -1963,7 +1949,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
>      }
>  
>  #if defined(TARGET_LINUX)
> -    metric = -1;
> +    int metric = -1;
>      if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
>      {
>          metric = r6->metric;
> 

The rest looks good!

I have compiled it on Linux and Windows, but I presume you've compiled
it on other platforms as well.

Regards,

-- 
Antonio Quartulli

