From: Arne Schwabe <arne@...1227...>
Date: Fri, 19 Mar 2021 12:46:31 +0100
Message-Id: <20210319114631.20459-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix multiple problems when compiling with
 LLVM/Windows (clang-cl)
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

When using the LLVM clang compiler instead the MSVC cl.exe but with
the same build environment as MSVC, clang encounters a few errors:

src\openvpn\socket.c(3550,23): warning: assigning to 'CHAR *' (aka 'char *') from 'uint8_t *' (aka 'unsigned char *') converts between pointers to integer types with different sign [-Wpointer-sign]
        wsabuf[0].buf = BPTR(&sock->reads.buf);
                      ^ ~~~~~~~~~~~~~~~~~~~~~~
src\openvpn\socket.c(3670,23): warning: assigning to 'CHAR *' (aka 'char *') from 'uint8_t *' (aka 'unsigned char *') converts between pointers to integer types with different sign [-Wpointer-sign]
        wsabuf[0].buf = BPTR(&sock->writes.buf);
                      ^ ~~~~~~~~~~~~~~~~~~~~~~~

Use BSTR instead of BPTR, which casts to the correct type that is
expected.

src\compat\compat-gettimeofday.c(105,18): error: assignment to cast is illegal, lvalue casts are not supported
    tv->tv_sec = (long)last_sec = (long)sec;

Split into two assignments to avoid the illegal cast

include\stdint.h(18,28): error: typedef redefinition with different types ('signed char' vs 'char')
typedef signed char        int8_t;
                           ^
openvpn\config-msvc.h(162,16): note: previous definition is here
typedef __int8 int8_t;

Removes our custom int type typdefs from config-msvc.h and replace it
with an include of inttypes.h.

C:\Program Files (x86)\Windows Kits\10\include\10.0.19041.0\shared\tcpmib.h(56,3): error: typedef redefinition with different types ('enum MIB_TCP_STATE' vs 'int')
} MIB_TCP_STATE;
  ^
C:\Users\User\source\repos\openvpn\src\openvpn/syshead.h(369,13): note: previous definition is here
typedef int MIB_TCP_STATE;
            ^
1 error generated.

This seems to be for mingw32 only, so guard this with a mingw32
compiler guard.

\src\openvpn\tun.c(3727,34): warning: passing 'char [256]' to parameter of type 'LPBYTE' (aka 'unsigned char *') converts between pointers to integer types with different sign [-Wpointer-sign]
                                 net_cfg_instance_id,
                                 ^~~~~~~~~~~~~~~~~~~
C:\Program Files (x86)\Windows Kits\10\include\10.0.19041.0\um\winreg.h(955,88): note: passing argument to parameter 'lpData' here

This is windows specific code, use the Windows LPBTYE in the
definitions. (long pointer to BYTE (long pointer as far/near pointer
relict from windows 16 bit times, in moddern words (unsigned char *))

Fix also a few other char vs uint8/unisgned char/BYTE issues in tun.c

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h                    |  9 +--------
 src/compat/compat-gettimeofday.c |  3 ++-
 src/openvpn/socket.c             |  4 ++--
 src/openvpn/syshead.h            |  4 ++--
 src/openvpn/tun.c                | 28 ++++++++++++++--------------
 src/openvpn/tun.h                |  2 +-
 6 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 40ad7889..e430ca96 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -152,14 +152,7 @@
 #define SIGUSR2   12
 #define SIGTERM   15
 
-typedef unsigned __int64 uint64_t;
-typedef unsigned __int32 uint32_t;
-typedef unsigned __int16 uint16_t;
-typedef unsigned __int8 uint8_t;
-typedef __int64 int64_t;
-typedef __int32 int32_t;
-typedef __int16 int16_t;
-typedef __int8 int8_t;
+#include <inttypes.h>
 typedef uint16_t in_port_t;
 
 #ifdef HAVE_CONFIG_MSVC_LOCAL_H
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 7cae641d..117aee7d 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -102,7 +102,8 @@ gettimeofday(struct timeval *tv, void *tz)
         bt = 1;
     }
 
-    tv->tv_sec = (long)last_sec = (long)sec;
+    last_sec = sec;
+    tv->tv_sec = (long)sec;
     tv->tv_usec = (last_msec = msec) * 1000;
 
     if (bt && !bt_last)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 891f63b0..ebe8c85c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3547,7 +3547,7 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         }
 
         /* Win32 docs say it's okay to allocate the wsabuf on the stack */
-        wsabuf[0].buf = BPTR(&sock->reads.buf);
+        wsabuf[0].buf = BSTR(&sock->reads.buf);
         wsabuf[0].len = maxsize ? maxsize : BLEN(&sock->reads.buf);
 
         /* check for buffer overflow */
@@ -3648,7 +3648,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         ASSERT(buf_copy(&sock->writes.buf, buf));
 
         /* Win32 docs say it's okay to allocate the wsabuf on the stack */
-        wsabuf[0].buf = BPTR(&sock->writes.buf);
+        wsabuf[0].buf = BSTR(&sock->writes.buf);
         wsabuf[0].len = BLEN(&sock->writes.buf);
 
         /* the overlapped write will signal this event on I/O completion */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index a20de1f6..5ee9bf1e 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -365,9 +365,9 @@
 
 #ifdef _WIN32
 /* Missing declarations for MinGW 32. */
-/* #if !defined(__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 2 */
+#if defined(__MINGW32__)
 typedef int MIB_TCP_STATE;
-/* #endif */
+#endif
 #include <naptypes.h>
 #include <ntddndis.h>
 #include <iphlpapi.h>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1a523c7b..6c51a52d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3659,7 +3659,7 @@ get_device_instance_id_interface(struct gc_arena *gc)
         BOOL res;
         HKEY dev_key;
         char net_cfg_instance_id_string[] = "NetCfgInstanceId";
-        char net_cfg_instance_id[256];
+        BYTE net_cfg_instance_id[256];
         char device_instance_id[256];
         DWORD len;
         DWORD data_type;
@@ -3721,7 +3721,7 @@ get_device_instance_id_interface(struct gc_arena *gc)
 
         dev_interface_list = alloc_buf_gc(dev_interface_list_size, gc);
         cr = CM_Get_Device_Interface_List((LPGUID)&GUID_DEVINTERFACE_NET, device_instance_id,
-                                          BPTR(&dev_interface_list),
+                                          BSTR(&dev_interface_list),
                                           dev_interface_list_size,
                                           CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
         if (cr != CR_SUCCESS)
@@ -3731,7 +3731,7 @@ get_device_instance_id_interface(struct gc_arena *gc)
 
         struct device_instance_id_interface *dev_if;
         ALLOC_OBJ_CLEAR_GC(dev_if, struct device_instance_id_interface, gc);
-        dev_if->net_cfg_instance_id = string_alloc(net_cfg_instance_id, gc);
+        dev_if->net_cfg_instance_id = (unsigned char *)string_alloc((char *)net_cfg_instance_id, gc);
         dev_if->device_interface_list = string_alloc(BSTR(&dev_interface_list), gc);
 
         /* link into return list */
@@ -3784,7 +3784,7 @@ get_tap_reg(struct gc_arena *gc)
         char component_id_string[] = "ComponentId";
         char component_id[256];
         char net_cfg_instance_id_string[] = "NetCfgInstanceId";
-        char net_cfg_instance_id[256];
+        BYTE net_cfg_instance_id[256];
         DWORD data_type;
 
         len = sizeof(enum_name);
@@ -3829,7 +3829,7 @@ get_tap_reg(struct gc_arena *gc)
                 component_id_string,
                 NULL,
                 &data_type,
-                component_id,
+                (LPBYTE)component_id,
                 &len);
 
             if (status != ERROR_SUCCESS || data_type != REG_SZ)
@@ -3866,7 +3866,7 @@ get_tap_reg(struct gc_arena *gc)
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
-                        reg->guid = string_alloc(net_cfg_instance_id, gc);
+                        reg->guid = string_alloc((char *)net_cfg_instance_id, gc);
                         reg->windows_driver = windows_driver;
 
                         /* link into return list */
@@ -4225,7 +4225,7 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
  */
 static const char *
 get_unspecified_device_guid(const int device_number,
-                            char *actual_name,
+                            uint8_t *actual_name,
                             int actual_name_size,
                             const struct tap_reg *tap_reg_src,
                             const struct panel_reg *panel_reg_src,
@@ -4292,7 +4292,7 @@ get_unspecified_device_guid(const int device_number,
  */
 static const char *
 get_device_guid(const char *name,
-                char *actual_name,
+                uint8_t *actual_name,
                 int actual_name_size,
                 enum windows_driver_type *windows_driver,
                 const struct tap_reg *tap_reg,
@@ -5023,7 +5023,7 @@ tap_allow_nonadmin_access(const char *dev_node)
     const struct panel_reg *panel_reg = get_panel_reg(&gc);
     const char *device_guid = NULL;
     HANDLE hand;
-    char actual_buffer[256];
+    uint8_t actual_buffer[256];
     char device_path[256];
 
     at_least_one_tap_win(tap_reg);
@@ -5673,9 +5673,9 @@ netsh_get_id(const char *dev_node, struct gc_arena *gc)
     {
         return "NULL";     /* not found */
     }
-    else if (strcmp(BPTR(&actual), "NULL"))
+    else if (strcmp(BSTR(&actual), "NULL"))
     {
-        return BPTR(&actual); /* control panel name */
+        return BSTR(&actual); /* control panel name */
     }
     else
     {
@@ -6462,7 +6462,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
         /* Open Wintun adapter */
         for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
         {
-            if (strcmp(dev_if->net_cfg_instance_id, device_guid) == 0)
+            if (strcmp((const char *)dev_if->net_cfg_instance_id, device_guid) == 0)
             {
                 path = dev_if->device_interface_list;
                 break;
@@ -6517,7 +6517,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
     const struct tap_reg *tap_reg = get_tap_reg(gc);
     const struct panel_reg *panel_reg = get_panel_reg(gc);
     const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(gc);
-    char actual_buffer[256];
+    uint8_t actual_buffer[256];
 
     at_least_one_tap_win(tap_reg);
 
@@ -6585,7 +6585,7 @@ next:
 
     /* translate high-level device name into a device instance
      * GUID using the registry */
-    tt->actual_name = string_alloc(actual_buffer, NULL);
+    tt->actual_name = string_alloc((const char*)actual_buffer, NULL);
 
     msg(M_INFO, "%s device [%s] opened", print_windows_driver(tt->windows_driver), tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 99826cf7..9d995dd4 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -390,7 +390,7 @@ struct panel_reg
 
 struct device_instance_id_interface
 {
-    const char *net_cfg_instance_id;
+    LPBYTE net_cfg_instance_id;
     const char *device_interface_list;
     struct device_instance_id_interface *next;
 };
-- 
2.30.1


