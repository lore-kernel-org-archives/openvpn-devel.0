Date: Thu, 13 Apr 2023 16:04:38 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZDgL9gmU4NFYJJWT@...2685...>
References: <20230403131750.4730-1-gianmarco@...2726...>
 <20230404083226.18751-1-gianmarco@...2726...>
MIME-Version: 1.0
In-Reply-To: <20230404083226.18751-1-gianmarco@...2726...>
Subject: Re: [Openvpn-devel] [PATCH v3] Route: add support for user defined
 routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Apr 04, 2023 at 10:32:26AM +0200, Gianmarco De Gregori wrote:
> Add the ability for users to specify a custom
> routing table where routes should be installed in.
> As of now routes are always installed in the main
> routing table of the operating system, however,
> with the new --route-table option it is possibile
> to specify the ID of the default routing table
> to be used by --route(-ipv6).
> 
> The --route(-ipv6) directives have been extended
> with an additional argument (5th for --route)
> (4th for --route-ipv6) so that each of them
> can possibly use an independent routing table.
> 
> Please note: this feature is currently supported
> only by Linux/SITNL.
> Support for other platforms should be added in related backends.
> 
> Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
> ---
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2680f268..3914ab23 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
[...]
> @@ -6998,7 +7020,22 @@ add_option(struct options *options,
>              }
>              /* p[3] is metric, if present */
>          }
> -        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3]);
> +
> +        /* at the moment the routing table id is supported only by Linux/SITNL */
> +#ifndef ENABLE_SITNL
> +        if (p[5])

p[4]

> +        {
> +            static bool route6_table_warned = false;
> +
> +            if (!route6_table_warned)
> +            {
> +                msg(M_WARN, "NOTE: table specified for --route-ipv6, but not supported on this platform");
> +                route6_table_warned = true;
> +            }
> +        }
> +#endif
> +
> +        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3], p[4]);
>      }
>      else if (streq(p[0], "max-routes") && !p[2])
>      {
[...]
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 3798bc65..00419dce 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
[...]
> @@ -437,6 +436,27 @@ init_route(struct route_ipv4 *r,
>  
>      r->flags |= RT_DEFINED;
>  
> +    /* routing table id */
> +
> +    r->table_id = 0;
> +    if (ro->table_id)
> +    {
> +        r->table_id = atoi(ro->table_id);
> +        if (r->table_id < 0)

Isn't r->table_id an uint32 ?

> +        {
> +            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network %s (%s) must be >= 0",
> +                ro->network,
> +                ro->table_id);
> +            goto fail;
> +        }
> +        r->flags |= RT_TABLE_DEFINED;
> +    }
> +    else if (rl->spec.flags & RTSA_DEFAULT_TABLE_ID)
> +    {
> +        r->table_id = rl->spec.table_id;
> +        r->flags |= RT_TABLE_DEFINED;
> +    }
> +
>      return true;
>  
>  fail:
> @@ -493,6 +513,27 @@ init_route_ipv6(struct route_ipv6 *r6,
>  
>      r6->flags |= RT_DEFINED;
>  
> +    /* routing table id */
> +
> +    r6->table_id = 0;
> +    if (r6o->table_id)
> +    {
> +        r6->table_id = atoi(r6o->table_id);
> +        if (r6->table_id < 0)

Isn't r6->table_id an uint32 ?

> +        {
> +            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network %s (%s) must be >= 0",
> +                r6o->prefix,
> +                r6o->table_id);
> +            goto fail;
> +        }
> +        r6->flags |= RT_TABLE_DEFINED;
> +    }
> +    else if (rl6->spec_flags & RTSA_DEFAULT_TABLE_ID)
> +    {
> +        r6->table_id = rl6->default_route_table_id;
> +        r6->flags |= RT_TABLE_DEFINED;
> +    }
> +
>      return true;
>  
>  fail:
[...]
> @@ -1978,10 +2043,16 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
>          metric = r6->metric;
>      }
>  
> +    uint32_t table_id = 0;
> +    if ((r6->flags & RT_TABLE_DEFINED) && (r6->table_id > 0))

Isn't r6->table_id an uint32 ?

> +    {
> +        table_id = r6->table_id;
> +    }
> +
>      status = RTA_SUCCESS;
>      int ret = net_route_v6_add(ctx, &r6->network, r6->netbits,
>                                 gateway_needed ? &r6->gateway : NULL,
> -                               device, 0, metric);
> +                               device, table_id, metric);
>      if (ret == -EEXIST)
>      {
>          msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
[...]


Regards,
-- 
  Frank Lichtenheld

