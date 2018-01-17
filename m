From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Jan 2018 11:38:36 +0100
Message-Id: <1516185516-28125-1-git-send-email-arne@...1227...>
In-Reply-To: <608a626b-1aae-0215-ea96-fc3280aaafdd@...1435...>
References: <608a626b-1aae-0215-ea96-fc3280aaafdd@...1435...>
Subject: [Openvpn-devel] [PATCH v2] Replace buffer backed strings for
 management_android_control with simple stack variables
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

This simplifies the code a bit and also silences compiler warnings about uint8_t pointers passed to char pointers without cast

Patch V2: Use openvpn_snprintf instead snprintf
---
 src/openvpn/route.c | 14 +++++++-------
 src/openvpn/tun.c   | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2bd5845b..1e1f204d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1610,17 +1610,17 @@ add_route(struct route_ipv4 *r,
     status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route add command failed");
 
 #elif defined (TARGET_ANDROID)
-    struct buffer out = alloc_buf_gc(128, &gc);
+    char out[128];
 
     if (rgi)
     {
-        buf_printf(&out, "%s %s %s dev %s", network, netmask, gateway, rgi->iface);
+        openvpn_snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, gateway, rgi->iface);
     }
     else
     {
-        buf_printf(&out, "%s %s %s", network, netmask, gateway);
+        openvpn_snprintf(out, sizeof(out), "%s %s %s", network, netmask, gateway);
     }
-    management_android_control(management, "ROUTE", buf_bptr(&out));
+    management_android_control(management, "ROUTE", out);
 
 #elif defined (_WIN32)
     {
@@ -1963,11 +1963,11 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
 #elif defined (TARGET_ANDROID)
-    struct buffer out = alloc_buf_gc(64, &gc);
+    char out[64];
 
-    buf_printf(&out, "%s/%d %s", network, r6->netbits, device);
+    openvpn_snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, device);
 
-    management_android_control(management, "ROUTE6", buf_bptr(&out));
+    management_android_control(management, "ROUTE6", out);
 
 #elif defined (_WIN32)
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6e163489..2644d996 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1031,12 +1031,12 @@ do_ifconfig(struct tuntap *tt,
 
         if (do_ipv6)
         {
-            struct buffer out6 = alloc_buf_gc(64, &gc);
-            buf_printf(&out6, "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
-            management_android_control(management, "IFCONFIG6",buf_bptr(&out6));
+            char out6[64];
+            openvpn_snprintf(out6, sizeof(out6), "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
+            management_android_control(management, "IFCONFIG6", out6);
         }
 
-        struct buffer out = alloc_buf_gc(64, &gc);
+        char out[64];
 
         char *top;
         switch (tt->topology)
@@ -1057,8 +1057,8 @@ do_ifconfig(struct tuntap *tt,
                 top = "undef";
         }
 
-        buf_printf(&out, "%s %s %d %s", ifconfig_local, ifconfig_remote_netmask, tun_mtu, top);
-        management_android_control(management, "IFCONFIG", buf_bptr(&out));
+        openvpn_snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local, ifconfig_remote_netmask, tun_mtu, top);
+        management_android_control(management, "IFCONFIG", out);
 
 #elif defined(TARGET_SOLARIS)
         /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
-- 
2.15.1


