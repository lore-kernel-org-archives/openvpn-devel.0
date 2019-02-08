From: Gert Doering <gert@...1296...>
Date: Fri,  8 Feb 2019 20:40:18 +0100
Message-Id: <20190208194018.20325-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Add unknown-unicast flooding to p2mp tap
 bridge.
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

Enable flooding of "unknown-unicast" packets from the server to
all connected clients (+tap).

These are packets that are sent to an unknown destination MAC address
and which are not broadcast/multicast packets.  "Normal" switches also
flood these packets, which allows client-to-client MAC learning without
having to have an initial broadcast packet.

Without the patch, the p2mp tap server will only forward such packets
to the tap interface on the host.

This is only active if --client-to-client is configured on the server.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 55c167b..aa5ae26 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2689,6 +2689,13 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                                     }
                                     c->c2.to_tun.len = 0;
                                 }
+				else
+				{
+                                    /* flood "unknown unicast" packets */
+                                    msg(D_MULTI_LOW, "MULTI: unknown unicast destination [%s], flood",
+                                        mroute_addr_print(&src, &gc));
+                                    multi_bcast(m, &c->c2.to_tun, m->pending, NULL);
+				}
                             }
                         }
 #ifdef ENABLE_PF
-- 
2.7.3


