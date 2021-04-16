References: <20210415230545.22317-1-themiron@...2010...>
 <20210416120708.1532-1-themiron@...2010...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <022e18d6-67ae-8975-9d41-49d19c41a0be@...2181...>
Date: Fri, 16 Apr 2021 16:01:25 +0200
MIME-Version: 1.0
In-Reply-To: <20210416120708.1532-1-themiron@...2010...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] Fix IPv4 default gateway with
 multiple route tables
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
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

Hi,

On 16/04/2021 14:07, Vladislav Grishenko wrote:
> Current default gateway selection for zero destination address just
> dumps and parses all the routing tables. If any of non-main table
> with default route comes first, wrong default gateway can be picked.
> Since adding/removing routes currently handles only main table,
> let's stick to RT_TABLE_MAIN while selecting default route too.
> 
> v2: keep gateway address unchanged on lookup error
> v3: reduce ammout of gateway address copying
> 
> Reported-by: Donald Sharp <donaldsharp72@...277...>
> Signed-off-by: Vladislav Grishenko <themiron@...2010...>
> ---
>  src/openvpn/networking_sitnl.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
> index 2bc70a50..ea1621ed 100644
> --- a/src/openvpn/networking_sitnl.c
> +++ b/src/openvpn/networking_sitnl.c
> @@ -426,6 +426,7 @@ typedef struct {
>      inet_address_t gw;
>      char iface[IFNAMSIZ];
>      bool default_only;
> +    unsigned int table;
>  } route_res_t;
>  
>  static int
> @@ -435,7 +436,8 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
>      struct rtmsg *r = NLMSG_DATA(n);
>      struct rtattr *rta = RTM_RTA(r);
>      int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
> -    unsigned int ifindex = 0;
> +    unsigned int table, ifindex = 0;
> +    void *gw = NULL;
>  
>      /* filter-out non-zero dst prefixes */
>      if (res->default_only && r->rtm_dst_len != 0)
> @@ -443,6 +445,9 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
>          return 1;
>      }
>  
> +    /* route table, ignored with RTA_TABLE */
> +    table = r->rtm_table;
> +
>      while (RTA_OK(rta, len))
>      {
>          switch (rta->rta_type)
> @@ -458,13 +463,24 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
>  
>              /* GW for the route */
>              case RTA_GATEWAY:
> -                memcpy(&res->gw, RTA_DATA(rta), res->addr_size);
> +                gw = RTA_DATA(rta);
> +                break;
> +
> +            /* route table */
> +            case RTA_TABLE:
> +                table = *(unsigned int *)RTA_DATA(rta);
>                  break;
>          }
>  
>          rta = RTA_NEXT(rta, len);
>      }
>  
> +    /* filter out any route not coming from the selected table */
> +    if (res->table && res->table != table)

Today I was wondering if 0 could be a meaningful table ID, since this
code uses 0 as "no table was selected for filtering" (thus creating a
false negative).

After checking rtnetlink.h, I could see that 0 is indeed the UNSPEC
value (RT_TABLE_UNSPEC=0), therefore your patch is correct.

However, to prevent the next casual reader from asking the same
question, wouldn't it make sense to change this comparison with:

if (res->table != RT_TABLE_UNSPEC && res->table != table)


> +    {
> +        return 1;
> +    }
> +
>      if (!if_indextoname(ifindex, res->iface))
>      {
>          msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index %d",
> @@ -472,6 +488,11 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
>          return -1;
>      }
>  
> +    if (gw)
> +    {
> +        memcpy(&res->gw, gw, res->addr_size);
> +    }
> +
>      return 0;
>  }
>  
> @@ -507,6 +528,7 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
>              {
>                  req.n.nlmsg_flags |= NLM_F_DUMP;
>                  res.default_only = true;
> +                res.table = RT_TABLE_MAIN;

Another question: why restricting the research to the MAIN table only
for IPv4 and only when searching a default route?

Like you said in the commit message: OpenVPN only operates on the MAIN
routing table for the time being, therefore, shouldn't we just set
"res.table = RT_TABLE_MAIN" by default *all the time* for now?

Otherwise we are fixing this problem only for the ipv4/default search,
but the function remains "buggy" for the other cases.


>              }
>              else
>              {
> 


Regards,

-- 
Antonio Quartulli

