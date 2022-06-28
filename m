From: Antonio Quartulli <a@...2181...>
Date: Tue, 28 Jun 2022 10:20:24 +0200
Message-Id: <20220628082024.19059-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] do not push route-ipv6 entries that are
 also in the iroute-ipv6 list
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
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

A server should push a route to a client only if there is no matching
iroute for the same client.

While this logic works fine for IPv4, there is no IPv6 counterpart.

Implement the same check for IPv6 routes and discard matching ones
from the push list.

Trac: #354
Cc: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* add "&& o->iroutes{,_ipv6}" check before attempting to traverse
  iroutes list. This way we avoid executing getaddr or get_ipv6_addr if
  we already know that we have no iroutes to compare to.


 src/openvpn/push.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 63257348..e5b588bb 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1002,7 +1002,7 @@ process_incoming_push_msg(struct context *c,
 void
 remove_iroutes_from_push_route_list(struct options *o)
 {
-    if (o && o->push_list.head && o->iroutes)
+    if (o && o->push_list.head && (o->iroutes || o->iroutes_ipv6))
     {
         struct gc_arena gc = gc_new();
         struct push_entry *e = o->push_list.head;
@@ -1019,7 +1019,7 @@ remove_iroutes_from_push_route_list(struct options *o)
                 && parse_line(e->option, p, SIZE(p), "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG, &gc))
             {
                 /* is the push item a route directive? */
-                if (p[0] && !strcmp(p[0], "route") && !p[3])
+                if (p[0] && !strcmp(p[0], "route") && !p[3] && o->iroutes)
                 {
                     /* get route parameters */
                     bool status1, status2;
@@ -1042,6 +1042,30 @@ remove_iroutes_from_push_route_list(struct options *o)
                         }
                     }
                 }
+                else if (p[0] && !strcmp(p[0], "route-ipv6") && !p[2]
+                         && o->iroutes_ipv6)
+                {
+                    /* get route parameters */
+                    struct in6_addr network;
+                    unsigned int netbits;
+
+                    /* parse route-ipv6 arguments */
+                    if (get_ipv6_addr(p[1], &network, &netbits, D_ROUTE_DEBUG))
+                    {
+                        struct iroute_ipv6 *ir;
+
+                        /* does this route-ipv6 match an iroute-ipv6? */
+                        for (ir = o->iroutes_ipv6; ir != NULL; ir = ir->next)
+                        {
+                            if (!memcmp(&network, &ir->network, sizeof(network))
+                                && netbits == ir->netbits)
+                            {
+                                enable = false;
+                                break;
+                            }
+                        }
+                    }
+                }
 
                 /* should we copy the push item? */
                 e->enable = enable;
-- 
2.35.1


