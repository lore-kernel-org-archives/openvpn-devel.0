From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 14 Aug 2022 23:53:03 +0200
Message-Id: <20220814215303.305-1-lstipakov@...277...>
In-Reply-To: <20220811084330.187-1-lstipakov@...277...>
References: <20220811084330.187-1-lstipakov@...277...>
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

Device interface is a path which is used by userspace
to access device. A driver can create one or more device
interfaces and specify "reference string", so that userspace
could enumerate all device interfaces in the list and pick
the corrct one which ends with reference string.

Before our code had an assumption that either driver
creates only one device interface or the "right" interface
is alwways first in the list. As it turned out, that assumtion
does not always hold, so here we iterate through all device
interfaces in the list.

In follow-up dco-win patch we pick the device interface
from the list which ends with specific reference string.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v3: use gc_malloc() and "char *" instead of buffer and improve commit message

 v2: uncrustify


 src/openvpn/tun.c | 40 +++++++++++++++++++++++-----------------
 src/openvpn/tun.h |  2 +-
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 11025267..50193939 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3722,7 +3722,6 @@ get_device_instance_id_interface(struct gc_arena *gc)
         LONG status;
         ULONG dev_interface_list_size;
         CONFIGRET cr;
-        struct buffer dev_interface_list;
 
         ZeroMemory(&device_info_data, sizeof(SP_DEVINFO_DATA));
         device_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
@@ -3775,9 +3774,9 @@ get_device_instance_id_interface(struct gc_arena *gc)
             goto next;
         }
 
-        dev_interface_list = alloc_buf_gc(dev_interface_list_size, gc);
+        char *dev_interface_list = gc_malloc(dev_interface_list_size, false, gc);
         cr = CM_Get_Device_Interface_List((LPGUID)&GUID_DEVINTERFACE_NET, device_instance_id,
-                                          BSTR(&dev_interface_list),
+                                          dev_interface_list,
                                           dev_interface_list_size,
                                           CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
         if (cr != CR_SUCCESS)
@@ -3785,21 +3784,29 @@ get_device_instance_id_interface(struct gc_arena *gc)
             goto next;
         }
 
-        struct device_instance_id_interface *dev_if;
-        ALLOC_OBJ_CLEAR_GC(dev_if, struct device_instance_id_interface, gc);
-        dev_if->net_cfg_instance_id = (unsigned char *)string_alloc((char *)net_cfg_instance_id, gc);
-        dev_if->device_interface_list = string_alloc(BSTR(&dev_interface_list), gc);
+        char *dev_if = dev_interface_list;
 
-        /* link into return list */
-        if (!first)
+        /* device interface list ends with empty string */
+        while (strlen(dev_if) > 0)
         {
-            first = dev_if;
-        }
-        if (last)
-        {
-            last->next = dev_if;
+            struct device_instance_id_interface *dev_iif;
+            ALLOC_OBJ_CLEAR_GC(dev_iif, struct device_instance_id_interface, gc);
+            dev_iif->net_cfg_instance_id = (unsigned char *)string_alloc((char *)net_cfg_instance_id, gc);
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
@@ -6475,12 +6482,11 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
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
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ea4946e9..661e4d01 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -388,7 +388,7 @@ struct panel_reg
 struct device_instance_id_interface
 {
     LPBYTE net_cfg_instance_id;
-    const char *device_interface_list;
+    const char *device_interface;
     struct device_instance_id_interface *next;
 };
 
-- 
2.23.0.windows.1


