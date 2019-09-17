From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Sep 2019 15:44:49 +0300
Message-Id: <1568724293-5069-3-git-send-email-lstipakov@...277...>
In-Reply-To: <1568724293-5069-1-git-send-email-lstipakov@...277...>
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 3/7] wintun: implement opening wintun device
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

From: Lev Stipakov <lev@...515...>

To open wintun device, we cannot use "\\.\Global\Wintun<luid>"
path as before. To get device path which we supply to CreateFile,
we have to use SetupAPI to:

 - enumerate network adapters with "wintun" as component id
 - for each adapter save its guid
 - open device information set
 - for each item in set
   - open corresponding registry key to get net_cfg_instance_id
   - get symbolic link name of device interface by instance id
 - path will be symbolic link name of device instance matched with adapter's guid

See https://github.com/OpenVPN/openvpn3/blob/master/openvpn/tun/win/tunutil.hpp and
https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/wintun_windows.go for
implementation examples.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/Makefile.am     |   2 +-
 src/openvpn/openvpn.vcxproj |   4 +-
 src/openvpn/tun.c           | 244 +++++++++++++++++++++++++++++++++++++-------
 src/openvpn/tun.h           |  14 +++
 4 files changed, 222 insertions(+), 42 deletions(-)

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 30caa01..7d4b429 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -137,5 +137,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
 endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3422b64..88be4c2 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -91,7 +91,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -117,7 +117,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0591df6..5415dbb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -58,6 +58,9 @@
 
 #ifdef _WIN32
 
+const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
+const static GUID GUID_DEVINTERFACE_NET = { 0xcac88484, 0x7515, 0x4c03, { 0x82, 0xe6, 0x71, 0xa8, 0x7a, 0xba, 0xc3, 0x61 } };
+
 /* #define SIMULATE_DHCP_FAILED */       /* simulate bad DHCP negotiation */
 
 #define NI_TEST_FIRST  (1<<0)
@@ -3434,7 +3437,123 @@ tun_finalize(
     return ret;
 }
 
-const struct tap_reg *
+static const struct device_instance_id_interface *
+get_device_instance_id_interface(struct gc_arena* gc)
+{
+    HDEVINFO dev_info_set;
+    DWORD err;
+    struct device_instance_id_interface *first = NULL;
+    struct device_instance_id_interface *last = NULL;
+
+    dev_info_set = SetupDiGetClassDevsEx(&GUID_DEVCLASS_NET, NULL, NULL, DIGCF_PRESENT, NULL, NULL, NULL);
+    if (dev_info_set == INVALID_HANDLE_VALUE)
+    {
+        err = GetLastError();
+        msg(M_FATAL, "Error [%u] opening device information set key: %s", (unsigned int)err, strerror_win32(err, gc));
+    }
+
+    for (DWORD i = 0;; ++i)
+    {
+        SP_DEVINFO_DATA device_info_data;
+        BOOL res;
+        HKEY dev_key;
+        char net_cfg_instance_id_string[] = "NetCfgInstanceId";
+        char net_cfg_instance_id[256];
+        char device_instance_id[256];
+        DWORD len;
+        DWORD data_type;
+        LONG status;
+        ULONG dev_interface_list_size;
+        CONFIGRET cr;
+        struct buffer dev_interface_list;
+
+        ZeroMemory(&device_info_data, sizeof(SP_DEVINFO_DATA));
+        device_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
+        res = SetupDiEnumDeviceInfo(dev_info_set, i, &device_info_data);
+        if (!res)
+        {
+            if (GetLastError() == ERROR_NO_MORE_ITEMS)
+            {
+                break;
+            }
+            else
+            {
+                continue;
+            }
+        }
+
+        dev_key = SetupDiOpenDevRegKey(dev_info_set, &device_info_data, DICS_FLAG_GLOBAL, 0, DIREG_DRV, KEY_QUERY_VALUE);
+        if (dev_key == INVALID_HANDLE_VALUE)
+        {
+            continue;
+        }
+
+        len = sizeof(net_cfg_instance_id);
+        data_type = REG_SZ;
+        status = RegQueryValueEx(dev_key,
+                                 net_cfg_instance_id_string,
+                                 NULL,
+                                 &data_type,
+                                 net_cfg_instance_id,
+                                 &len);
+        if (status != ERROR_SUCCESS)
+        {
+            goto next;
+        }
+
+        len = sizeof(device_instance_id);
+        res = SetupDiGetDeviceInstanceId(dev_info_set, &device_info_data, device_instance_id, len, &len);
+        if (!res)
+        {
+            goto next;
+        }
+
+        cr = CM_Get_Device_Interface_List_Size(&dev_interface_list_size,
+                                               (LPGUID)& GUID_DEVINTERFACE_NET,
+                                               device_instance_id,
+                                               CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
+
+        if (cr != CR_SUCCESS)
+        {
+            goto next;
+        }
+
+        dev_interface_list = alloc_buf_gc(dev_interface_list_size, gc);
+        cr = CM_Get_Device_Interface_List((LPGUID)& GUID_DEVINTERFACE_NET, device_instance_id,
+                                          BPTR(&dev_interface_list),
+                                          dev_interface_list_size,
+                                          CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
+        if (cr != CR_SUCCESS)
+        {
+            goto next;
+        }
+
+        struct device_instance_id_interface* dev_if;
+        ALLOC_OBJ_CLEAR_GC(dev_if, struct device_instance_id_interface, gc);
+        dev_if->net_cfg_instance_id = string_alloc(net_cfg_instance_id, gc);
+        dev_if->device_interface_list = string_alloc(BSTR(&dev_interface_list), gc);
+
+        /* link into return list */
+        if (!first)
+        {
+            first = dev_if;
+        }
+        if (last)
+        {
+            last->next = dev_if;
+        }
+        last = dev_if;
+
+    next:
+        RegCloseKey(dev_key);
+    }
+
+    SetupDiDestroyDeviceInfoList(dev_info_set);
+
+    return first;
+}
+
+static const struct tap_reg *
 get_tap_reg(struct gc_arena *gc)
 {
     HKEY adapter_key;
@@ -3531,11 +3650,13 @@ get_tap_reg(struct gc_arena *gc)
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
                     if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
-                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID))
+                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) ||
+                        !strcmp(component_id, WINTUN_COMPONENT_ID))
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
                         reg->guid = string_alloc(net_cfg_instance_id, gc);
+                        reg->wintun = !strcmp(component_id, WINTUN_COMPONENT_ID);
 
                         /* link into return list */
                         if (!first)
@@ -3559,7 +3680,7 @@ get_tap_reg(struct gc_arena *gc)
     return first;
 }
 
-const struct panel_reg *
+static const struct panel_reg *
 get_panel_reg(struct gc_arena *gc)
 {
     LONG status;
@@ -3766,7 +3887,7 @@ show_tap_win_adapters(int msglev, int warnlev)
     const struct tap_reg *tap_reg = get_tap_reg(&gc);
     const struct panel_reg *panel_reg = get_panel_reg(&gc);
 
-    msg(msglev, "Available TAP-WIN32 adapters [name, GUID]:");
+    msg(msglev, "Available TAP-WIN32 / Wintun adapters [name, GUID, driver]:");
 
     /* loop through each TAP-Windows adapter registry entry */
     for (tr = tap_reg; tr != NULL; tr = tr->next)
@@ -3778,7 +3899,7 @@ show_tap_win_adapters(int msglev, int warnlev)
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s", pr->name, tr->guid);
+                msg(msglev, "'%s' %s %s", pr->name, tr->guid, tr->wintun ? "wintun" : "tap-windows6");
                 ++links;
             }
         }
@@ -3897,6 +4018,7 @@ get_unspecified_device_guid(const int device_number,
                             int actual_name_size,
                             const struct tap_reg *tap_reg_src,
                             const struct panel_reg *panel_reg_src,
+                            bool *wintun,
                             struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = tap_reg_src;
@@ -3946,6 +4068,10 @@ get_unspecified_device_guid(const int device_number,
     /* Save GUID for return value */
     ret = alloc_buf_gc(256, gc);
     buf_printf(&ret, "%s", tap_reg->guid);
+    if (wintun != NULL)
+    {
+        *wintun = tap_reg->wintun;
+    }
     return BSTR(&ret);
 }
 
@@ -4723,6 +4849,7 @@ tap_allow_nonadmin_access(const char *dev_node)
                                                       sizeof(actual_buffer),
                                                       tap_reg,
                                                       panel_reg,
+                                                      NULL,
                                                       &gc);
 
             if (!device_guid)
@@ -5257,9 +5384,9 @@ netsh_get_id(const char *dev_node, struct gc_arena *gc)
     }
     else
     {
-        guid = get_unspecified_device_guid(0, BPTR(&actual), BCAP(&actual), tap_reg, panel_reg, gc);
+        guid = get_unspecified_device_guid(0, BPTR(&actual), BCAP(&actual), tap_reg, panel_reg, NULL, gc);
 
-        if (get_unspecified_device_guid(1, NULL, 0, tap_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Windows adapter */
+        if (get_unspecified_device_guid(1, NULL, 0, tap_reg, panel_reg, NULL, gc)) /* ambiguous if more than one TAP-Windows adapter */
         {
             guid = NULL;
         }
@@ -5531,7 +5658,8 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
     struct gc_arena gc = gc_new();
-    char device_path[256];
+    char tuntap_device_path[256];
+    char *path = NULL;
     const char *device_guid = NULL;
     DWORD len;
     bool dhcp_masq = false;
@@ -5561,6 +5689,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         const struct tap_reg *tap_reg = get_tap_reg(&gc);
         const struct panel_reg *panel_reg = get_panel_reg(&gc);
+        const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(&gc);
+
         char actual_buffer[256];
 
         at_least_one_tap_win(tap_reg);
@@ -5576,24 +5706,22 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             }
 
             /* Open Windows TAP-Windows adapter */
-            openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
+            openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
                              USERMODEDEVICEDIR,
                              device_guid,
                              TAP_WIN_SUFFIX);
 
-            tt->hand = CreateFile(
-                device_path,
-                GENERIC_READ | GENERIC_WRITE,
-                0,                /* was: FILE_SHARE_READ */
-                0,
-                OPEN_EXISTING,
-                FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                0
-                );
+            tt->hand = CreateFile(tuntap_device_path,
+                                  GENERIC_READ | GENERIC_WRITE,
+                                  0,                /* was: FILE_SHARE_READ */
+                                  0,
+                                  OPEN_EXISTING,
+                                  FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                                  0);
 
             if (tt->hand == INVALID_HANDLE_VALUE)
             {
-                msg(M_ERR, "CreateFile failed on TAP device: %s", device_path);
+                msg(M_ERR, "CreateFile failed on TAP device: %s", tuntap_device_path);
             }
         }
         else
@@ -5603,43 +5731,78 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             /* Try opening all TAP devices until we find one available */
             while (true)
             {
+                bool is_picked_device_wintun = false;
                 device_guid = get_unspecified_device_guid(device_number,
                                                           actual_buffer,
                                                           sizeof(actual_buffer),
                                                           tap_reg,
                                                           panel_reg,
+                                                          &is_picked_device_wintun,
                                                           &gc);
 
                 if (!device_guid)
                 {
-                    msg(M_FATAL, "All TAP-Windows adapters on this system are currently in use.");
+                    msg(M_FATAL, "All %s adapters on this system are currently in use.", tt->wintun ? "wintun" : "TAP - Windows");
                 }
 
-                /* Open Windows TAP-Windows adapter */
-                openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
-                                 USERMODEDEVICEDIR,
-                                 device_guid,
-                                 TAP_WIN_SUFFIX);
-
-                tt->hand = CreateFile(
-                    device_path,
-                    GENERIC_READ | GENERIC_WRITE,
-                    0,                /* was: FILE_SHARE_READ */
-                    0,
-                    OPEN_EXISTING,
-                    FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                    0
-                    );
+                if (tt->wintun)
+                {
+                    const struct device_instance_id_interface* dev_if;
+
+                    if (!is_picked_device_wintun)
+                    {
+                        /* wintun driver specified but picked adapter is not wintun, proceed to next one */
+                        goto next;
+                    }
+
+                    path = NULL;
+                    for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
+                    {
+                        if (strcmp(dev_if->net_cfg_instance_id, device_guid) == 0)
+                        {
+                            path = (char *)dev_if->device_interface_list;
+                            break;
+                        }
+                    }
+                    if (path == NULL)
+                    {
+                        goto next;
+                    }
+                }
+                else
+                {
+                    if (is_picked_device_wintun)
+                    {
+                        /* tap-windows6 driver specified but picked adapter is wintun, proceed to next one */
+                        goto next;
+                    }
+
+                    /* Open Windows TAP-Windows adapter */
+                    openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
+                                     USERMODEDEVICEDIR,
+                                     device_guid,
+                                     TAP_WIN_SUFFIX);
+                    path = tuntap_device_path;
+                }
+
+                tt->hand = CreateFile(path,
+                                      GENERIC_READ | GENERIC_WRITE,
+                                      0,                /* was: FILE_SHARE_READ */
+                                      0,
+                                      OPEN_EXISTING,
+                                      FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                                      0);
 
                 if (tt->hand == INVALID_HANDLE_VALUE)
                 {
-                    msg(D_TUNTAP_INFO, "CreateFile failed on TAP device: %s", device_path);
+                    msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", tt->wintun ? "wintun" : "TAP", tuntap_device_path);
                 }
                 else
                 {
                     break;
                 }
 
+            next:
                 device_number++;
             }
         }
@@ -5649,10 +5812,11 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         tt->actual_name = string_alloc(actual_buffer, NULL);
     }
 
-    msg(M_INFO, "TAP-WIN32 device [%s] opened: %s", tt->actual_name, device_path);
+    msg(M_INFO, "%s device [%s] opened: %s", tt->wintun ? "Wintun" : "TAP-WIN32", tt->actual_name, path);
     tt->adapter_index = get_adapter_index(device_guid);
 
     /* get driver version info */
+    if (!tt->wintun)
     {
         ULONG info[3];
         CLEAR(info);
@@ -5692,6 +5856,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     }
 
     /* get driver MTU */
+    if (!tt->wintun)
     {
         ULONG mtu;
         if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
@@ -5751,7 +5916,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     /* set point-to-point mode if TUN device */
 
-    if (tt->type == DEV_TYPE_TUN)
+    if ((tt->type == DEV_TYPE_TUN) && !tt->wintun)
     {
         if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
         {
@@ -5806,7 +5971,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     /* should we tell the TAP-Windows driver to masquerade as a DHCP server as a means
      * of setting the adapter address? */
-    if (dhcp_masq)
+    if (dhcp_masq && !tt->wintun)
     {
         uint32_t ep[4];
 
@@ -5884,6 +6049,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     }
 
     /* set driver media status to 'connected' */
+    if (!tt->wintun)
     {
         ULONG status = TRUE;
         if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index a61aa22..18eb1b0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -27,6 +27,8 @@
 #ifdef _WIN32
 #include <winioctl.h>
 #include <tap-windows.h>
+#include <setupapi.h>
+#include <cfgmgr32.h>
 #endif
 
 #include "buffer.h"
@@ -38,6 +40,10 @@
 #include "misc.h"
 #include "networking.h"
 
+#ifdef _WIN32
+#define WINTUN_COMPONENT_ID "wintun"
+#endif
+
 #if defined(_WIN32) || defined(TARGET_ANDROID)
 
 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
@@ -342,6 +348,7 @@ route_order(void)
 struct tap_reg
 {
     const char *guid;
+    bool wintun;
     struct tap_reg *next;
 };
 
@@ -352,6 +359,13 @@ struct panel_reg
     struct panel_reg *next;
 };
 
+struct device_instance_id_interface
+{
+    const char *net_cfg_instance_id;
+    const char *device_interface_list;
+    struct device_instance_id_interface *next;
+};
+
 int ascii2ipset(const char *name);
 
 const char *ipset2ascii(int index);
-- 
2.7.4


