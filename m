From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 25 Jun 2019 22:34:01 +0300
Message-Id: <1561491241-16380-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service to
 open tun
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

This patch enables interactive service to open tun device.
This is mostly needed by Wintun, which could be opened
only by privileged process.

When interactive service is used, instead of calling
CreateFile() directly by openvpn process we pass tun device path
into service process. There we open device, duplicate handle
and pass it back to openvpn process.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 include/openvpn-msg.h         | 12 ++++++++
 src/openvpn/route.c           |  2 +-
 src/openvpn/tun.c             | 70 +++++++++++++++++++++++++++++++++++--------
 src/openvpn/win32.c           |  6 ++--
 src/openvpn/win32.h           |  6 ++--
 src/openvpnserv/interactive.c | 59 +++++++++++++++++++++++++++++++++++-
 6 files changed, 134 insertions(+), 21 deletions(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 66177a2..273d9a6 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -39,6 +39,8 @@ typedef enum {
     msg_del_block_dns,
     msg_register_dns,
     msg_enable_dhcp,
+    msg_open_tun_device,
+    msg_open_tun_device_result,
 } message_type_t;
 
 typedef struct {
@@ -117,4 +119,14 @@ typedef struct {
     interface_t iface;
 } enable_dhcp_message_t;
 
+typedef struct {
+    message_header_t header;
+    char device_path[512];
+} open_tun_device_message_t;
+
+typedef struct {
+    message_header_t header;
+    HANDLE handle;
+    int error_number;
+} open_tun_device_result_message_t;
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 4cdc4a9..27fa18c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2992,7 +2992,7 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
     ack_message_t ack;
     struct gc_arena gc = gc_new();
 
-    if (!send_msg_iservice(pipe, rt, size, &ack, "ROUTE"))
+    if (!send_msg_iservice(pipe, rt, size, &ack, sizeof(ack), "ROUTE"))
     {
         goto out;
     }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8f8f7c6..2d7bd0d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -115,7 +115,7 @@ do_address_service(const bool add, const short family, const struct tuntap *tt)
         addr.prefix_len = tt->netbits_ipv6;
     }
 
-    if (!send_msg_iservice(pipe, &addr, sizeof(addr), &ack, "TUN"))
+    if (!send_msg_iservice(pipe, &addr, sizeof(addr), &ack, sizeof(ack), "TUN"))
     {
         goto out;
     }
@@ -181,7 +181,7 @@ do_dns6_service(bool add, const struct tuntap *tt)
     msg(D_LOW, "%s IPv6 dns servers on '%s' (if_index = %d) using service",
         (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
 
-    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
+    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, sizeof(ack), "TUN"))
     {
         goto out;
     }
@@ -5227,7 +5227,7 @@ service_enable_dhcp(const struct tuntap *tt)
         .iface = { .index = tt->adapter_index, .name = "" }
     };
 
-    if (!send_msg_iservice(pipe, &dhcp, sizeof(dhcp), &ack, "Enable_dhcp"))
+    if (!send_msg_iservice(pipe, &dhcp, sizeof(dhcp), &ack, sizeof(ack), "Enable_dhcp"))
     {
         goto out;
     }
@@ -5248,6 +5248,43 @@ out:
     return ret;
 }
 
+static HANDLE
+service_open_tun_device(const HANDLE pipe, const char* device_path)
+{
+    open_tun_device_result_message_t result_msg;
+    struct gc_arena gc = gc_new();
+    open_tun_device_message_t open_tun_device = {
+        .header = {
+            msg_open_tun_device,
+            sizeof(open_tun_device_message_t),
+            0
+        }
+    };
+    result_msg.handle = INVALID_HANDLE_VALUE;
+
+    strncpynt(open_tun_device.device_path, device_path, sizeof(open_tun_device.device_path));
+
+    if (!send_msg_iservice(pipe, &open_tun_device, sizeof(open_tun_device),
+        &result_msg, sizeof(result_msg), "Open_tun_device"))
+    {
+        goto out;
+    }
+
+    if (result_msg.error_number != NO_ERROR)
+    {
+        msg(D_TUNTAP_INFO, "TUN: opening tun handle using service failed: %s [status=%u device_path=%s]",
+            strerror_win32(result_msg.error_number, &gc), result_msg.error_number, device_path);
+    }
+    else
+    {
+        msg(M_INFO, "Opened tun device %s using service", device_path);
+    }
+
+out:
+    gc_free(&gc);
+    return result_msg.handle;
+}
+
 /*
  * Return a TAP name for netsh commands.
  */
@@ -5469,7 +5506,7 @@ register_dns_service(const struct tuntap *tt)
 
     message_header_t rdns = { msg_register_dns, sizeof(message_header_t), 0 };
 
-    if (!send_msg_iservice(msg_channel, &rdns, sizeof(rdns), &ack, "Register_dns"))
+    if (!send_msg_iservice(msg_channel, &rdns, sizeof(rdns), &ack, sizeof(ack), "Register_dns"))
     {
         gc_free(&gc);
         return;
@@ -5631,15 +5668,22 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                                  device_guid,
                                  TAP_WIN_SUFFIX);
 
-                tt->hand = CreateFile(
-                    device_path,
-                    GENERIC_READ | GENERIC_WRITE,
-                    0,                /* was: FILE_SHARE_READ */
-                    0,
-                    OPEN_EXISTING,
-                    FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                    0
+                if (tt->options.msg_channel)
+                {
+                    tt->hand = service_open_tun_device(tt->options.msg_channel, device_path);
+                }
+                else
+                {
+                    tt->hand = CreateFile(
+                        device_path,
+                        GENERIC_READ | GENERIC_WRITE,
+                        0,                /* was: FILE_SHARE_READ */
+                        0,
+                        OPEN_EXISTING,
+                        FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                        0
                     );
+                }
 
                 if (tt->hand == INVALID_HANDLE_VALUE)
                 {
@@ -5937,7 +5981,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                 };
 
                 if (send_msg_iservice(tt->options.msg_channel, &msg, sizeof(msg),
-                                      &ack, "TUN"))
+                                      &ack, sizeof(ack), "TUN"))
                 {
                     status = ack.error_number;
                 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eb4c030..80d2025 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1280,7 +1280,7 @@ win_block_dns_service(bool add, int index, const HANDLE pipe)
         .iface = { .index = index, .name = "" }
     };
 
-    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "Block_DNS"))
+    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, sizeof(ack), "Block_DNS"))
     {
         goto out;
     }
@@ -1474,14 +1474,14 @@ win32_version_string(struct gc_arena *gc, bool add_name)
 
 bool
 send_msg_iservice(HANDLE pipe, const void *data, size_t size,
-                  ack_message_t *ack, const char *context)
+                  void *response, size_t response_size, const char *context)
 {
     struct gc_arena gc = gc_new();
     DWORD len;
     bool ret = true;
 
     if (!WriteFile(pipe, data, size, &len, NULL)
-        || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
+        || !ReadFile(pipe, response, response_size, &len, NULL))
     {
         msg(M_WARN, "%s: could not talk to service: %s [%lu]",
             context ? context : "Unknown",
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4814bbc..6602552 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -311,11 +311,11 @@ const char *win32_version_string(struct gc_arena *gc, bool add_name);
 
 /*
  * Send the |size| bytes in buffer |data| to the interactive service |pipe|
- * and read the result in |ack|. Returns false on communication error.
- * The string in |context| is used to prefix error messages.
+ * and read the result in |response| of size |response_size|. Returns false
+ * on communication error. The string in |context| is used to prefix error messages.
  */
 bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
-                       ack_message_t *ack, const char *context);
+                       void *response, size_t response_size, const char *context);
 
 /*
  * Attempt to simulate fork/execve on Windows
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 623c3ff..f530c82 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -57,7 +57,7 @@ static HANDLE exit_event = NULL;
 static settings_t settings;
 static HANDLE rdns_semaphore = NULL;
 #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
-
+static HANDLE ovpn_process = NULL; /* used by DuplicateHandle() when passing tun device handle to openvpn process */
 
 openvpn_service_t interactive_service = {
     interactive,
@@ -1198,6 +1198,44 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     return err;
 }
 
+static DWORD
+HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun, HANDLE *remote_handle)
+{
+    DWORD err = 0;
+
+    *remote_handle = INVALID_HANDLE_VALUE;
+
+    HANDLE local_handle = CreateFileA(open_tun->device_path, GENERIC_READ | GENERIC_WRITE, 0, 0,
+                                      OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, 0);
+
+    if (local_handle == INVALID_HANDLE_VALUE)
+    {
+        WCHAR *device_path_wchar = NULL;
+        int size = sizeof(open_tun->device_path);
+        err = GetLastError();
+
+        device_path_wchar = malloc(size * sizeof(WCHAR));
+        if (device_path_wchar)
+        {
+            MultiByteToWideChar(CP_UTF8, 0, open_tun->device_path, size, device_path_wchar, size);
+            device_path_wchar[size - 1] = 0;
+        }
+        MsgToEventLog(M_SYSERR, TEXT("Error opening tun device (%s)"), device_path_wchar);
+        free(device_path_wchar);
+        return err;
+    }
+
+    if (!DuplicateHandle(GetCurrentProcess(), local_handle, ovpn_process, remote_handle, 0, FALSE,
+            DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
+    {
+        err = GetLastError();
+        MsgToEventLog(M_SYSERR, TEXT("Error duplicating tun device handle"));
+        return err;
+    }
+
+    return err;
+}
+
 static VOID
 HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
@@ -1210,6 +1248,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
         block_dns_message_t block_dns;
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
+        open_tun_device_message_t open_tun;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1277,6 +1316,22 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
             }
             break;
 
+        case msg_open_tun_device:
+            if (msg.header.size == sizeof(msg.open_tun))
+            {
+                open_tun_device_result_message_t res = {
+                    .header = {
+                        .type = msg_open_tun_device_result,
+                        .size = sizeof(res),
+                        .message_id = msg.header.message_id
+                    }
+                };
+                res.error_number = HandleOpenTunDeviceMessage(&msg.open_tun, &res.handle);
+                WritePipeAsync(pipe, &res, sizeof(res), count, events);
+                return;
+            }
+            break;
+
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
@@ -1603,6 +1658,8 @@ RunOpenvpn(LPVOID p)
         free(input);
     }
 
+    ovpn_process = proc_info.hProcess;
+
     while (TRUE)
     {
         DWORD bytes = PeekNamedPipeAsync(ovpn_pipe, 1, &exit_event);
-- 
2.7.4


