From: Arne Schwabe <arne@...1227...>
Date: Fri,  5 Oct 2018 15:05:00 +0200
Message-Id: <20181005130500.32130-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Skip error about ioctl(SIOCGIFCONF) failed
 on Android
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
 src/openvpn/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index cadd34e1..a1d4ade1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3258,6 +3258,10 @@ get_default_gateway(struct route_gateway_info *rgi)
     rgi->gateway.addr = 127 << 24 | 'd' << 16 | 'g' << 8 | 'w';
     rgi->flags |= RGI_ADDR_DEFINED;
     strcpy(best_name, "android-gw");
+
+    // Skip scanning/fetching interface from loopback inteface
+    // It always fails and ioctl(SIOCGIFCONF) failed" confuses users
+    goto done;
 #endif /* ifndef TARGET_ANDROID */
 
     /* scan adapter list */
-- 
2.19.0


