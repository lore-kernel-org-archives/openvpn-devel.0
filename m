References: <20210413122006.3960-2-themiron@...2010...>
 <20210415230545.22317-1-themiron@...2010...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0710d0e2-1d97-5f2d-1b56-6772094d8769@...2181...>
Date: Fri, 16 Apr 2021 11:11:20 +0200
MIME-Version: 1.0
In-Reply-To: <20210415230545.22317-1-themiron@...2010...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Fix IPv4 default gateway with
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
Content-Transfer-Encoding: 7bit
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 16/04/2021 01:05, Vladislav Grishenko wrote:
> Current default gateway selection for zero destination address just
> dumps and parses all the routing tables. If any of non-main table
> with default route comes first, wrong default gateway can be picked.
> Since adding/removing routes currently handles only main table,
> let's stick to RT_TABLE_MAIN while selecting default route too.
> 
> Reported-By: Donald Sharp <donaldsharp72@...277...>
> Signed-off-by: Vladislav Grishenko <themiron@...2010...>
> ---
>  src/openvpn/networking_sitnl.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
> index 2bc70a50..402d3303 100644
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
> +    inet_address_t gw;
>  
>      /* filter-out non-zero dst prefixes */
>      if (res->default_only && r->rtm_dst_len != 0)
> @@ -443,6 +445,11 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
>          return 1;
>      }
>  
> +    /* route table, ignored with RTA_TABLE */
> +    table = r->rtm_table;
> +    /* initial route gateway  */
> +    gw = res->gw;
> +
>      while (RTA_OK(rta, len))
>      {
>          switch (rta->rta_type)
> @@ -458,19 +465,31 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
>  
>              /* GW for the route */
>              case RTA_GATEWAY:
> -                memcpy(&res->gw, RTA_DATA(rta), res->addr_size);
> +                memcpy(&gw, RTA_DATA(rta), res->addr_size);
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
> +    {
> +        return 1;
> +    }
> +
>      if (!if_indextoname(ifindex, res->iface))
>      {
>          msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index %d",
>              __func__, ifindex);
>          return -1;
>      }
> +    res->gw = gw;

We would be potentially copying the GW value 3 times now.
How about simplifying this back and forth with the following?


diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 402d3303..cc80ca29 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -437,7 +437,7 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
     struct rtattr *rta = RTM_RTA(r);
     int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex = 0;
-    inet_address_t gw;
+    uint8_t *gw = NULL;

     /* filter-out non-zero dst prefixes */
     if (res->default_only && r->rtm_dst_len != 0)
@@ -447,8 +447,6 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)

     /* route table, ignored with RTA_TABLE */
     table = r->rtm_table;
-    /* initial route gateway  */
-    gw = res->gw;

     while (RTA_OK(rta, len))
     {
@@ -465,7 +463,7 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)

             /* GW for the route */
             case RTA_GATEWAY:
-                memcpy(&gw, RTA_DATA(rta), res->addr_size);
+                gw = RTA_DATA(rta);
                 break;

             /* route table */
@@ -489,7 +487,11 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
             __func__, ifindex);
         return -1;
     }
-    res->gw = gw;
+
+    if (gw)
+    {
+           memcpy(&res->gw, gw, res->addr_size);
+    }

     return 0;
 }



What do you think?



Best Regards,


>  
>      return 0;
>  }
> @@ -507,6 +526,7 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
>              {
>                  req.n.nlmsg_flags |= NLM_F_DUMP;
>                  res.default_only = true;
> +                res.table = RT_TABLE_MAIN;
>              }
>              else
>              {
> 

-- 
Antonio Quartulli

