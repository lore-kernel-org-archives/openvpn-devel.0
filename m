From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:17 +0200
Message-Id: <20191009143422.9419-5-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/9] VLAN: filter multicast and
 client-to-client unicast traffic
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
Cc: Antonio Quartulli <a@...2181...>, Fabian Knittel <fabian.knittel@...1547...>

With this change, client-to-client communications are possible only if
clients were configured with the same PVID.

At the same time also broadcast packets are now forwarded only to hosts
belonging to the originator VLAN.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 95b33e7a..e733ca9a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2643,10 +2643,12 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
             }
             else if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TAP)
             {
+                uint16_t vid = 0;
 #ifdef ENABLE_PF
                 struct mroute_addr edest;
                 mroute_addr_reset(&edest);
 #endif
+
                 if (m->top.options.vlan_tagging)
                 {
                     if (vlan_is_tagged(&c->c2.to_tun))
@@ -2655,6 +2657,10 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
                         c->c2.to_tun.len = 0;
                     }
+                    else
+                    {
+                        vid = c->options.vlan_pvid;
+                    }
                 }
                 /* extract packet source and dest addresses */
                 mroute_flags = mroute_extract_addr_from_packet(&src,
@@ -2665,7 +2671,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
 #else
                                                                NULL,
 #endif
-                                                               0,
+                                                               vid,
                                                                &c->c2.to_tun,
                                                                DEV_TYPE_TAP);
 
@@ -2678,7 +2684,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         {
                             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
                             {
-                                multi_bcast(m, &c->c2.to_tun, m->pending, NULL, 0);
+                                multi_bcast(m, &c->c2.to_tun, m->pending, NULL,
+                                            vid);
                             }
                             else /* try client-to-client routing */
                             {
-- 
2.23.0


