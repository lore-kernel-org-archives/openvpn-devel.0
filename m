From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 11 Aug 2022 11:35:49 +0300
Message-Id: <20220811083549.101-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun: properly handle device interface list
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

Some adapters create multiple device interfaces
and we need to enumerate all of them.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 37 +++++++++++++++++++++----------------
 src/openvpn/tun.h |  2 +-
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8a31bb04..76774e51 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3788,21 +3788,27 @@ get_device_instance_id_interface(struct gc_arena *gc)
             goto next;
         }
 
-        struct device_instance_id_interface *dev_if;
-        ALLOC_OBJ_CLEAR_GC(dev_if, struct device_instance_id_interface, gc);
-        dev_if->net_cfg_instance_id = (unsigned char *)string_alloc((char *)net_cfg_instance_id, gc);
-        dev_if->device_interface_list = string_alloc(BSTR(&dev_interface_list), gc);
-
-        /* link into return list */
-        if (!first)
-        {
-            first = dev_if;
-        }
-        if (last)
+        char *dev_if = BSTR(&dev_interface_list);
+        while (strlen(dev_if) > 0)
         {
-            last->next = dev_if;
+            struct device_instance_id_interface* dev_iif;
+            ALLOC_OBJ_CLEAR_GC(dev_iif, struct device_instance_id_interface, gc);
+            dev_iif->net_cfg_instance_id = (unsigned char*)string_alloc((char*)net_cfg_instance_id, gc);
+            dev_iif->device_interface = string_alloc(dev_if, gc);
+
+            /* link into return list */
+            if (!first)
+            {
+                first = dev_iif;
+            }
+            if (last)
+            {
+                last->next = dev_iif;
+            }
+            last = dev_iif;
+
+            dev_if += strlen(dev_if) + 1;
         }
-        last = dev_if;
 
 next:
         RegCloseKey(dev_key);
@@ -6484,12 +6490,11 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     {
         const struct device_instance_id_interface *dev_if;
 
-        /* Open Wintun adapter */
         for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
         {
             if (strcmp((const char *)dev_if->net_cfg_instance_id, device_guid) == 0)
             {
-                path = dev_if->device_interface_list;
+                path = dev_if->device_interface;
                 break;
             }
         }
@@ -6500,7 +6505,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     }
     else
     {
-        /* Open TAP-Windows or dco-win adapter */
+        /* Open TAP-Windows adapter */
         openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
                          USERMODEDEVICEDIR,
                          device_guid,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 10792eff..effcfca4 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -392,7 +392,7 @@ struct panel_reg
 struct device_instance_id_interface
 {
     LPBYTE net_cfg_instance_id;
-    const char *device_interface_list;
+    const char *device_interface;
     struct device_instance_id_interface *next;
 };
 
-- 
2.23.0.windows.1


