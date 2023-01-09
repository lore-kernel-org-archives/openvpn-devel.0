From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  9 Jan 2023 13:30:46 +0200
Message-Id: <20230109113046.1678-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tun: move print_windows_driver() out of
 tun.h
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

We got warnings from MinGW about function being defined
but not used when compiling modules which include tun.h.

This function is not defined as inline, so its definition
should not be in header. Since this is not a performance
critical, no need to make it inline.

Leave declaration in tun.h and move definition to tun.c.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 19 +++++++++++++++++++
 src/openvpn/tun.h | 20 ++------------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a83ec9e6..6947312e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -7028,6 +7028,25 @@ ipset2ascii_all(struct gc_arena *gc)
     return BSTR(&out);
 }
 
+const char *
+print_windows_driver(enum windows_driver_type windows_driver)
+{
+    switch (windows_driver)
+    {
+        case WINDOWS_DRIVER_TAP_WINDOWS6:
+            return "tap-windows6";
+
+        case WINDOWS_DRIVER_WINTUN:
+            return "wintun";
+
+        case WINDOWS_DRIVER_DCO:
+            return "ovpn-dco";
+
+        default:
+            return "unspecified";
+    }
+}
+
 #else /* generic */
 
 void
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 24d52670..ed22770a 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -661,24 +661,8 @@ tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED);
 }
 
-static const char *
-print_windows_driver(enum windows_driver_type windows_driver)
-{
-    switch (windows_driver)
-    {
-        case WINDOWS_DRIVER_TAP_WINDOWS6:
-            return "tap-windows6";
-
-        case WINDOWS_DRIVER_WINTUN:
-            return "wintun";
-
-        case WINDOWS_DRIVER_DCO:
-            return "ovpn-dco";
-
-        default:
-            return "unspecified";
-    }
-}
+const char *
+print_windows_driver(enum windows_driver_type windows_driver);
 
 #else  /* ifdef _WIN32 */
 
-- 
2.38.1.windows.1


