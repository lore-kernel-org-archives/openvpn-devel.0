From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 11:23:35 +0200
Message-Id: <1442309019-7586-5-git-send-email-arne@...1227...>
In-Reply-To: <1442309019-7586-1-git-send-email-arne@...1227...>
References: <1442309019-7586-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/8] Use pseudo gw as default gw on Android
	as a workaround for not being able to read /proc/net/route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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
 src/openvpn/route.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 03f8332..56cce07 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2474,6 +2474,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 
   CLEAR(*rgi);
 
+#ifndef TARGET_ANDROID
   /* get default gateway IP addr */
   {
     FILE *fp = fopen ("/proc/net/route", "r");
@@ -2530,6 +2531,19 @@ get_default_gateway (struct route_gateway_info *rgi)
 	  }
       }
   }
+#else
+  /* Android, set some pseudo GW, addr is in host byte order,
+   * Determining the default GW on Android 5.0+ is non trivial
+   * and serves almost no purpose since OpenVPN only uses the
+   * default GW address to add routes for networks that should
+   * NOT be routed over the VPN. Using a well known address
+   * (127.'d'.'g'.'w') for the default GW make detecting
+   * these routes easier from the controlling app.
+   */
+  rgi->gateway.addr = 127 << 24 | 'd' << 16 | 'g' << 8 | 'w';
+  rgi->flags |= RGI_ADDR_DEFINED;
+  strcpy(best_name, "android-gw");
+#endif
 
   /* scan adapter list */
   if (rgi->flags & RGI_ADDR_DEFINED)
-- 
2.3.2 (Apple Git-55)


