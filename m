From: Arne Schwabe <arne@...1227...>
Date: Tue,  3 Jul 2018 18:17:51 +0200
Message-Id: <20180703161751.7680-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add MTU to Android IFCONFIG6 control command
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

Since OpenVPN nows supports IPv6 only connections, OpenVPN for Android
cannot longer rely on IFCONFIG to send the MTU. Add sending the MTU to
IFCONFIG6 too.
---
 src/openvpn/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f9b9c716..26baa206 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -910,8 +910,8 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
 #elif defined(TARGET_ANDROID)
     char out6[64];
 
-    openvpn_snprintf(out6, sizeof(out6), "%s/%d",
-                     ifconfig_ipv6_local,tt->netbits_ipv6);
+    openvpn_snprintf(out6, sizeof(out6), "%s/%d %d",
+                     ifconfig_ipv6_local,tt->netbits_ipv6, tun_mtu);
     management_android_control(management, "IFCONFIG6", out6);
 #elif defined(TARGET_SOLARIS)
     argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, ifname);
-- 
2.17.1


