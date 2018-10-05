From: Arne Schwabe <arne@...1227...>
Date: Fri,  5 Oct 2018 15:04:42 +0200
Message-Id: <20181005130442.32075-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Always use a 0.0.0.0/0 default on Android
 instead of def1 and do not try to delete routes
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

---
 src/openvpn/route.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ff392308..cadd34e1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1050,6 +1050,16 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
 
             if (rl->flags & RG_REROUTE_GW)
             {
+#ifdef TARGET_ANDROID
+                add_route3 (0,
+                            0,
+                            rl->spec.remote_endpoint,
+                            tt,
+                            flags,
+                            &rl->rgi,
+                            es);
+
+#else
                 if (rl->flags & RG_DEF1)
                 {
                     /* add new default route (1st component) */
@@ -1089,6 +1099,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                                &rl->rgi,
                                es);
                 }
+#endif
             }
 
             /* set a flag so we can undo later */
-- 
2.19.0


