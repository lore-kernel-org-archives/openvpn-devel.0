From: Simon Rozman <simon@...2293...>
Date: Fri, 20 Dec 2019 17:11:15 +0100
Message-Id: <20191220161117.1434-5-simon@...2293...>
In-Reply-To: <CAGyAFMXWyKbYTPLDDd3vedDDuFY+GqNu1V=RqGvY_JhevVJBzQ@...278...>
References: <CAGyAFMXWyKbYTPLDDd3vedDDuFY+GqNu1V=RqGvY_JhevVJBzQ@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 5/7] wintun: add support for --dev-node
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f56682ef..18f06bb6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6196,7 +6196,6 @@ static void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid)
 {
     struct gc_arena gc = gc_new();
-    char tuntap_device_path[256];
     const struct tap_reg* tap_reg = get_tap_reg(&gc);
     const struct panel_reg* panel_reg = get_panel_reg(&gc);
     const struct device_instance_id_interface* device_instance_id_interface = get_device_instance_id_interface(&gc);
@@ -6209,31 +6208,34 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
      */
     if (dev_node)
     {
+        bool is_picked_device_wintun = false;
+
         /* Get the device GUID for the device specified with --dev-node. */
-        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
+        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &is_picked_device_wintun, tap_reg, panel_reg, &gc);
 
         if (!*device_guid)
         {
-            msg(M_FATAL, "TAP-Windows adapter '%s' not found", dev_node);
+            msg(M_FATAL, "Adapter '%s' not found", dev_node);
         }
 
-        /* Open Windows TAP-Windows adapter */
-        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
-                         USERMODEDEVICEDIR,
-                         *device_guid,
-                         TAP_WIN_SUFFIX);
-
-        tt->hand = CreateFile(tuntap_device_path,
-                              GENERIC_READ | GENERIC_WRITE,
-                              0,                /* was: FILE_SHARE_READ */
-                              0,
-                              OPEN_EXISTING,
-                              FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                              0);
+        if (tt->wintun)
+        {
+            if (!is_picked_device_wintun)
+            {
+                msg(M_FATAL, "Adapter '%s' is TAP-Windows, Wintun expected. If you want to use this device, remove --windows-driver wintun.", dev_node);
+            }
+        }
+        else
+        {
+            if (is_picked_device_wintun)
+            {
+                msg(M_FATAL, "Adapter '%s' is Wintun, TAP-Windows expected. If you want to use this device, add --windows-driver wintun.", dev_node);
+            }
+        }
 
-        if (tt->hand == INVALID_HANDLE_VALUE)
+        if (!tun_try_open_device(tt, *device_guid, device_instance_id_interface))
         {
-            msg(M_ERR, "CreateFile failed on TAP device: %s", tuntap_device_path);
+            msg(M_FATAL, "Failed to open %s adapter: %s", tt->wintun ? "Wintun" : "TAP-Windows", dev_node);
         }
     }
     else
-- 
2.24.1.windows.2


