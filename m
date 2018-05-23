From: Antonio Quartulli <a@...2181...>
Date: Thu, 24 May 2018 03:28:02 +0800
Message-Id: <20180523192802.31611-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] do not push route-ipv6 entries that are
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

Apparently this patch has been pending in Gert's endless TODO
list since a while. I thought it could be nice to help him to
get rid of some items :)

 src/openvpn/push.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6a30e479..9199e1f0 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -776,7 +776,7 @@ process_incoming_push_msg(struct context *c,
 void
 remove_iroutes_from_push_route_list(struct options *o)
 {
-    if (o && o->push_list.head && o->iroutes)
+    if (o && o->push_list.head && (o->iroutes || o->iroutes_ipv6))
     {
         struct gc_arena gc = gc_new();
         struct push_entry *e = o->push_list.head;
@@ -816,6 +816,29 @@ remove_iroutes_from_push_route_list(struct options *o)
                         }
                     }
                 }
+                else if (p[0] && !strcmp(p[0], "route-ipv6") && !p[2])
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
2.17.0


