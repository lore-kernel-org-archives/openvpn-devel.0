From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 12 Mar 2020 08:08:29 +0200
Message-Id: <20200312060829.19468-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.c: fix "use after free" error
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

Commit 509c45f has factored out code blocks of open_tun()
into separate functions and introduced "use after free" bug:

Variable "device_guid" is allocated inside tun_open_device()
function and used outside of it. Allocation happens with
local gc_arena, which is freed at the end of tun_open_device(),
making futher access to "device_guid" invalid.

Fix by ensuring that gc_arena scope covers all access to "device_guid".

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 42193d97..c976055e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6226,12 +6226,11 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
 }
 
 static void
-tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid)
+tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid, struct gc_arena *gc)
 {
-    struct gc_arena gc = gc_new();
-    const struct tap_reg *tap_reg = get_tap_reg(&gc);
-    const struct panel_reg *panel_reg = get_panel_reg(&gc);
-    const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(&gc);
+    const struct tap_reg *tap_reg = get_tap_reg(gc);
+    const struct panel_reg *panel_reg = get_panel_reg(gc);
+    const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(gc);
     char actual_buffer[256];
 
     at_least_one_tap_win(tap_reg);
@@ -6244,7 +6243,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
         enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
 
         /* Get the device GUID for the device specified with --dev-node. */
-        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &windows_driver, tap_reg, panel_reg, &gc);
+        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &windows_driver, tap_reg, panel_reg, gc);
 
         if (!*device_guid)
         {
@@ -6276,7 +6275,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
                                                        tap_reg,
                                                        panel_reg,
                                                        &windows_driver,
-                                                       &gc);
+                                                       gc);
 
             if (!*device_guid)
             {
@@ -6304,8 +6303,6 @@ next:
 
     msg(M_INFO, "%s device [%s] opened", print_windows_driver(tt->windows_driver), tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
-
-    gc_free(&gc);
 }
 
 static void
@@ -6411,13 +6408,16 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         msg(M_FATAL|M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
     }
 
-    tun_open_device(tt, dev_node, &device_guid);
+    struct gc_arena gc = gc_new(); /* used also for device_guid allocation */
+    tun_open_device(tt, dev_node, &device_guid, &gc);
 
     if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         tuntap_post_open(tt, device_guid);
     }
 
+    gc_free(&gc);
+
     /*netcmd_semaphore_release ();*/
 }
 
-- 
2.17.1


