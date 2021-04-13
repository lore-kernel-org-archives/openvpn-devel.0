From: Vladislav Grishenko <themiron@...2010...>
Date: Tue, 13 Apr 2021 17:20:05 +0500
Message-Id: <20210413122006.3960-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH 1/2] Fix IPv4 default gateway with multiple
 route tables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Current default gateway selection for zero destignation address just
dumps and parses all the routing tables. If any of non-main table
with default route comes first, wrong default gateway can be picked.
Since adding/removing routes currently handles only main table,
let's stick to RT_TABLE_MAIN while selecting default route too.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/networking_sitnl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 2bc70a50..56543648 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -426,6 +426,7 @@ typedef struct {
     inet_address_t gw;
     char iface[IFNAMSIZ];
     bool default_only;
+    unsigned int table;
 } route_res_t;
 
 static int
@@ -435,7 +436,7 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
     struct rtmsg *r = NLMSG_DATA(n);
     struct rtattr *rta = RTM_RTA(r);
     int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
-    unsigned int ifindex = 0;
+    unsigned int table, ifindex = 0;
 
     /* filter-out non-zero dst prefixes */
     if (res->default_only && r->rtm_dst_len != 0)
@@ -443,6 +444,9 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
         return 1;
     }
 
+    /* route table, ignored with RTA_TABLE */
+    table = r->rtm_table;
+
     while (RTA_OK(rta, len))
     {
         switch (rta->rta_type)
@@ -460,11 +464,22 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
             case RTA_GATEWAY:
                 memcpy(&res->gw, RTA_DATA(rta), res->addr_size);
                 break;
+
+            /* route table */
+            case RTA_TABLE:
+                table = *(unsigned int *)RTA_DATA(rta);
+                break;
         }
 
         rta = RTA_NEXT(rta, len);
     }
 
+    /* filter-out zero dns prefixes from other tables */
+    if (res->table && res->table != table)
+    {
+        return 1;
+    }
+
     if (!if_indextoname(ifindex, res->iface))
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index %d",
@@ -507,6 +522,7 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
             {
                 req.n.nlmsg_flags |= NLM_F_DUMP;
                 res.default_only = true;
+                res.table = RT_TABLE_MAIN;
             }
             else
             {
-- 
2.17.1


