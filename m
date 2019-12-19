From: Simon Rozman <simon@...2293...>
Date: Thu, 19 Dec 2019 23:39:14 +0100
Message-Id: <20191219223917.1614-4-simon@...2293...>
In-Reply-To: <20191219223917.1614-1-simon@...2293...>
References: <20191219223917.1614-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] wintun: register ring buffers when
 iterating adapters
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

Wintun adapters may be considered available if ring buffer registration
succeeded. Therefore, we must attempt to register ring buffers when
iterating adapters and continue on failure.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 110 +++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 46 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 220dee87..9dc9b3a2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6129,11 +6129,71 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
     gc_free(&gc);
 }
 
+static bool
+tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct device_instance_id_interface *device_instance_id_interface)
+{
+    const char *path = NULL;
+    char tuntap_device_path[256];
+
+    if (tt->wintun)
+    {
+        const struct device_instance_id_interface *dev_if;
+
+        /* Open Wintun adapter */
+        for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
+        {
+            if (strcmp(dev_if->net_cfg_instance_id, device_guid) == 0)
+            {
+                path = dev_if->device_interface_list;
+                break;
+            }
+        }
+        if (path == NULL)
+        {
+            return false;
+        }
+    }
+    else
+    {
+        /* Open TAP-Windows adapter */
+        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
+                            USERMODEDEVICEDIR,
+                            device_guid,
+                            TAP_WIN_SUFFIX);
+        path = tuntap_device_path;
+    }
+
+    tt->hand = CreateFile(path,
+                          GENERIC_READ | GENERIC_WRITE,
+                          0,                /* was: FILE_SHARE_READ */
+                          0,
+                          OPEN_EXISTING,
+                          FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                          0);
+
+    if (tt->hand == INVALID_HANDLE_VALUE)
+    {
+        msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", tt->wintun ? "Wintun" : "TAP-Windows", path);
+        return false;
+    }
+
+    if (tt->wintun)
+    {
+        /* Wintun adapter may be considered "open" after ring buffers are successfuly registered. */
+        if (!wintun_register_ring_buffer(tt))
+        {
+            msg(D_TUNTAP_INFO, "Failed to register %s adapter ring buffers", device_guid);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid)
 {
     struct gc_arena gc = gc_new();
-    char *path = NULL;
     char tuntap_device_path[256];
     const struct tap_reg* tap_reg = get_tap_reg(&gc);
     const struct panel_reg* panel_reg = get_panel_reg(&gc);
@@ -6197,27 +6257,11 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
 
             if (tt->wintun)
             {
-                const struct device_instance_id_interface* dev_if;
-
                 if (!is_picked_device_wintun)
                 {
                     /* wintun driver specified but picked adapter is not wintun, proceed to next one */
                     goto next;
                 }
-
-                path = NULL;
-                for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
-                {
-                    if (strcmp(dev_if->net_cfg_instance_id, *device_guid) == 0)
-                    {
-                        path = (char*)dev_if->device_interface_list;
-                        break;
-                    }
-                }
-                if (path == NULL)
-                {
-                    goto next;
-                }
             }
             else
             {
@@ -6226,28 +6270,9 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
                     /* tap-windows6 driver specified but picked adapter is wintun, proceed to next one */
                     goto next;
                 }
-
-                /* Open Windows TAP-Windows adapter */
-                openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
-                                 USERMODEDEVICEDIR,
-                                 *device_guid,
-                                 TAP_WIN_SUFFIX);
-                path = tuntap_device_path;
             }
 
-            tt->hand = CreateFile(path,
-                                  GENERIC_READ | GENERIC_WRITE,
-                                  0,                /* was: FILE_SHARE_READ */
-                                  0,
-                                  OPEN_EXISTING,
-                                  FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                                  0);
-
-            if (tt->hand == INVALID_HANDLE_VALUE)
-            {
-                msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", tt->wintun ? "wintun" : "TAP", tuntap_device_path);
-            }
-            else
+            if (tun_try_open_device(tt, *device_guid, device_instance_id_interface))
             {
                 break;
             }
@@ -6261,7 +6286,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
      * GUID using the registry */
     tt->actual_name = string_alloc(actual_buffer, NULL);
 
-    msg(M_INFO, "%s device [%s] opened: %s", tt->wintun ? "Wintun" : "TAP-WIN32", tt->actual_name, path);
+    msg(M_INFO, "%s device [%s] opened", tt->wintun ? "Wintun" : "TAP-WIN32", tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
 
     gc_free(&gc);
@@ -6372,14 +6397,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     tun_open_device(tt, dev_node, &device_guid);
 
-    if (tt->wintun)
-    {
-        if (!wintun_register_ring_buffer(tt))
-        {
-            msg(M_FATAL, "Failed to register ring buffers");
-        }
-    }
-    else
+    if (!tt->wintun)
     {
         tuntap_post_open(tt, device_guid);
     }
-- 
2.24.1.windows.2


