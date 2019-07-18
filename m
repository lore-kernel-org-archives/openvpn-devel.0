From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 18 Jul 2019 14:41:53 +0300
Message-Id: <1563450113-11225-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1563369608-10240-1-git-send-email-lstipakov@...277...>
References: <1563369608-10240-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v5] openvpnserv: enable interactive service
 to open tun
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

This patch enables interactive service to open tun device.
This is mostly needed by Wintun, which could be opened
only by privileged process.

When interactive service is used, instead of calling
CreateFile() directly by openvpn process we pass tun device path
into service process. There we open device, duplicate handle
and pass it back to openvpn process.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v5:
  - futher strengthen security by passing only device guid from client process
  to service, validating guid and contructing device path on service side 

 v4:
  - strengthen security by adding basic validation to device path
  - reorder fields in msg_open_tun_device_result for backward compatibility

 v3:
  - ensure that device path passed by client is null-terminated
  - support for multiple openvpn processes
  - return proper error code when device handle is invalid

 v2:
  - introduce send_msg_iservice_ex() instead of changing
  signature of existing send_msg_iservice()
  - use wchar_t strings in interactive service code

 include/openvpn-msg.h         | 12 +++++++
 src/openvpn/tun.c             | 83 ++++++++++++++++++++++++++++++++++---------
 src/openvpn/win32.c           |  9 ++++-
 src/openvpn/win32.h           | 30 +++++++++++++---
 src/openvpnserv/interactive.c | 83 +++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 193 insertions(+), 24 deletions(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 66177a2..5dbdca5 100644
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
+    char device_guid[36+2+1]; /* length of guid with dashes + braces + nul terminator */
+} open_tun_device_message_t;
+
+typedef struct {
+    message_header_t header;
+    int error_number;
+    HANDLE handle;
+} open_tun_device_result_message_t;
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8f8f7c6..df26ccf 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5248,6 +5248,43 @@ out:
     return ret;
 }
 
+static HANDLE
+service_open_tun_device(const HANDLE pipe, const char* device_guid)
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
+    strncpynt(open_tun_device.device_guid, device_guid, sizeof(open_tun_device.device_guid));
+
+    if (!send_msg_iservice_ex(pipe, &open_tun_device, sizeof(open_tun_device),
+        &result_msg, sizeof(result_msg), "Open_tun_device"))
+    {
+        goto out;
+    }
+
+    if (result_msg.error_number != NO_ERROR)
+    {
+        msg(D_TUNTAP_INFO, "TUN: opening tun handle using service failed: %s [status=%u device_path=%s]",
+            strerror_win32(result_msg.error_number, &gc), result_msg.error_number, device_guid);
+    }
+    else
+    {
+        msg(M_INFO, "Opened tun device %s using service", device_guid);
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
@@ -5591,15 +5628,22 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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
+            if (tt->options.msg_channel)
+            {
+                tt->hand = service_open_tun_device(tt->options.msg_channel, device_guid);
+            }
+            else
+            {
+                tt->hand = CreateFile(
+                    device_path,
+                    GENERIC_READ | GENERIC_WRITE,
+                    0,                /* was: FILE_SHARE_READ */
+                    0,
+                    OPEN_EXISTING,
+                    FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                    0
                 );
+            }
 
             if (tt->hand == INVALID_HANDLE_VALUE)
             {
@@ -5631,15 +5675,22 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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
+                    tt->hand = service_open_tun_device(tt->options.msg_channel, device_guid);
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
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eb4c030..039c1a4 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1476,12 +1476,19 @@ bool
 send_msg_iservice(HANDLE pipe, const void *data, size_t size,
                   ack_message_t *ack, const char *context)
 {
+    return send_msg_iservice_ex(pipe, data, size, ack, sizeof(*ack), context);
+}
+
+bool
+send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
+                     void *response, size_t response_size, const char *context)
+{
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
index 4814bbc..8ccddc0 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -309,14 +309,36 @@ int win32_version_info(void);
  */
 const char *win32_version_string(struct gc_arena *gc, bool add_name);
 
-/*
- * Send the |size| bytes in buffer |data| to the interactive service |pipe|
- * and read the result in |ack|. Returns false on communication error.
- * The string in |context| is used to prefix error messages.
+
+/**
+ * Send data to interactive service and receive response of type ack_message_t.
+ *
+ * @param  pipe      The handle of communication pipe
+ * @param  data      The data to send
+ * @param  size      The size of data to send
+ * @param  response  The pointer to ack_message_t structure to where response is written
+ * @param  context   The string used to prefix error messages
+ *
+ * @returns True on success, false on failure.
  */
 bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
                        ack_message_t *ack, const char *context);
 
+/**
+ * Send data to interactive service and receive response.
+ *
+ * @param  pipe           The handle of communication pipe
+ * @param  data           The data to send
+ * @param  size           The size of data to send
+ * @param  response       The buffer to where response is written
+ * @param  response_size  The size of response buffer
+ * @param  context        The string used to prefix error messages
+ *
+ * @returns True on success, false on failure.
+ */
+bool send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
+                          void *response, size_t response_size, const char *context);
+
 /*
  * Attempt to simulate fork/execve on Windows
  */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 623c3ff..782c04d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -58,7 +58,6 @@ static settings_t settings;
 static HANDLE rdns_semaphore = NULL;
 #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
 
-
 openvpn_service_t interactive_service = {
     interactive,
     TEXT(PACKAGE_NAME "ServiceInteractive"),
@@ -1198,8 +1197,67 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     return err;
 }
 
+static DWORD
+HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun, HANDLE ovpn_proc, HANDLE *remote_handle)
+{
+    DWORD err = ERROR_SUCCESS;
+    HANDLE local_handle;
+    LPWSTR wguid = NULL;
+    WCHAR device_path[256] = {0};
+    const WCHAR prefix[] = L"\\\\.\\Global\\";
+    const WCHAR tap_suffix[] = L".tap";
+
+    *remote_handle = INVALID_HANDLE_VALUE;
+
+    wguid = utf8to16(open_tun->device_guid);
+    if (!wguid)
+    {
+        err = ERROR_OUTOFMEMORY;
+        goto out;
+    }
+
+    /* validate device guid */
+    const size_t guid_len = wcslen(wguid);
+    for (int i = 0; i < guid_len; ++i)
+    {
+        const WCHAR ch = wguid[i];
+
+        if (!(iswalnum(ch)) && (ch != L'-') && (ch != L'{') && (ch != L'}'))
+        {
+            err = ERROR_MESSAGE_DATA;
+            MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Invalid device guild (%s)"), wguid);
+            goto out;
+        }
+    }
+    
+    openvpn_swprintf(device_path, sizeof(device_path), L"%s%s%s", prefix, wguid, tap_suffix);
+
+    /* open tun device */
+    local_handle = CreateFileW(device_path, GENERIC_READ | GENERIC_WRITE, 0, 0,
+                               OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, 0);
+    if (local_handle == INVALID_HANDLE_VALUE)
+    {
+        err = GetLastError();
+        MsgToEventLog(M_SYSERR, TEXT("Error opening tun device (%s)"), device_path);
+        goto out;
+    }
+
+    /* duplicate tun device handle to openvpn process */
+    if (!DuplicateHandle(GetCurrentProcess(), local_handle, ovpn_proc, remote_handle, 0, FALSE,
+                         DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
+    {
+        err = GetLastError();
+        MsgToEventLog(M_SYSERR, TEXT("Error duplicating tun device handle"));
+    }
+
+out:
+    free(wguid);
+
+    return err;
+}
+
 static VOID
-HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
+HandleMessage(HANDLE pipe, HANDLE ovpn_proc, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
     DWORD read;
     union {
@@ -1210,6 +1268,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
         block_dns_message_t block_dns;
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
+        open_tun_device_message_t open_tun;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1277,6 +1336,24 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
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
+                /* make sure that string passed from user process is null-terminated */
+                msg.open_tun.device_guid[sizeof(msg.open_tun.device_guid) - 1] = '\0';
+                res.error_number = HandleOpenTunDeviceMessage(&msg.open_tun, ovpn_proc, &res.handle);
+                WritePipeAsync(pipe, &res, sizeof(res), count, events);
+                return;
+            }
+            break;
+
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
@@ -1611,7 +1688,7 @@ RunOpenvpn(LPVOID p)
             break;
         }
 
-        HandleMessage(ovpn_pipe, bytes, 1, &exit_event, &undo_lists);
+        HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &exit_event, &undo_lists);
     }
 
     WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);
-- 
2.7.4


