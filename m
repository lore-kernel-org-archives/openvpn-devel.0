From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 19 Dec 2019 15:29:53 +0200
Message-Id: <20191219132953.375-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] options.c: do not force route delay when
 not using DHCP
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

Route delay may be only necessary when we perform
DHCP handshake. When we use IPAPI / netsh / manual,
no delay needed.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/options.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cebcbb07..a6f40e10 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3001,9 +3001,18 @@ options_postprocess_mutate_invariant(struct options *options)
     }
 
 #ifdef _WIN32
+    /* when using wintun, kernel doesn't send DHCP requests, so use netsh to set IP address and netmask */
+    if (options->wintun)
+    {
+        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
+    }
+
     if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options->route_delay_defined)
     {
-        if (options->mode == MODE_POINT_TO_POINT)
+        /* delay may only be necessary when we perform DHCP handshake */
+        const bool dhcp = (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ)
+                          || (options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE);
+        if ((options->mode == MODE_POINT_TO_POINT) && dhcp)
         {
             options->route_delay_defined = true;
             options->route_delay = 5; /* Vista sometimes has a race without this */
@@ -3016,14 +3025,8 @@ options_postprocess_mutate_invariant(struct options *options)
         options->ifconfig_noexec = false;
     }
 
-    /* for wintun kernel doesn't send DHCP requests, so use netsh to set IP address and netmask */
-    if (options->wintun)
-    {
-        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
-    }
-
     remap_redirect_gateway_flags(options);
-#endif
+#endif /* ifdef _WIN32 */
 
 #if P2MP_SERVER
     /*
-- 
2.17.1


