From: selva.nair@...277...
Date: Sat, 29 Sep 2018 09:53:48 -0400
Message-Id: <1538229228-10620-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Enable dhcp on tap adapter using
 interactive service
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

From: Selva Nair <selva.nair@...277...>

Currently, if dhcp on the TAP interface is disabled, OpenVPN
on Windows tries to enable it using netsh but that succeeds only when
run with admin privileges.

When interactive service is available, delegate this task to the
service.

Trac #1111
Tested on Windows 7

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 include/openvpn-msg.h         |  8 ++++++-
 src/openvpn/tun.c             | 53 ++++++++++++++++++++++++++++++++++++++++++-
 src/openvpnserv/interactive.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 82ecfe8..66177a2 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -37,7 +37,8 @@ typedef enum {
     msg_flush_neighbors,
     msg_add_block_dns,
     msg_del_block_dns,
-    msg_register_dns
+    msg_register_dns,
+    msg_enable_dhcp,
 } message_type_t;
 
 typedef struct {
@@ -111,4 +112,9 @@ typedef struct {
     interface_t iface;
 } block_dns_message_t;
 
+typedef struct {
+    message_header_t header;
+    interface_t iface;
+} enable_dhcp_message_t;
+
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 50f158c..9bf7b27 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5203,6 +5203,49 @@ netsh_enable_dhcp(const struct tuntap_options *to,
     argv_reset(&argv);
 }
 
+/* Enable dhcp on tap adapter using iservice */
+static bool
+service_enable_dhcp(const struct tuntap *tt)
+{
+    DWORD len;
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+    HANDLE pipe = tt->options.msg_channel;
+
+    enable_dhcp_message_t dhcp = {
+        .header = {
+            msg_enable_dhcp,
+            sizeof(enable_dhcp_message_t),
+            0
+        },
+        .iface = { .index = tt->adapter_index, .name = "" }
+    };
+
+    if (!WriteFile(pipe, &dhcp, sizeof(dhcp), &len, NULL)
+        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    {
+        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
+            strerror_win32(GetLastError(), &gc), GetLastError());
+        goto out;
+    }
+
+    if (ack.error_number != NO_ERROR)
+    {
+        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%u if_index=%d]",
+            strerror_win32(ack.error_number, &gc), ack.error_number, dhcp.iface.index);
+    }
+    else
+    {
+        msg(M_INFO, "DHCP enabled on interface %d using service", dhcp.iface.index);
+        ret = true;
+    }
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 /*
  * Return a TAP name for netsh commands.
  */
@@ -5683,7 +5726,15 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
              */
             if (dhcp_status(tt->adapter_index) == DHCP_STATUS_DISABLED)
             {
-                netsh_enable_dhcp(&tt->options, tt->actual_name);
+                /* try using the service if available, else directly execute netsh */
+                if (tt->options.msg_channel)
+                {
+                    service_enable_dhcp(tt);
+                }
+                else
+                {
+                    netsh_enable_dhcp(&tt->options, tt->actual_name);
+                }
             }
             dhcp_masq = true;
             dhcp_masq_post = true;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 861f5e7..d0bb120 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1176,6 +1176,50 @@ out:
     return err;
 }
 
+static DWORD
+HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
+{
+    DWORD err = 0;
+    DWORD timeout = 5000; /* in milli seconds */
+    wchar_t argv0[MAX_PATH+1];
+
+    /* Path of netsh */
+    int n = GetSystemDirectory(argv0, MAX_PATH);
+    if (n > 0 && n < MAX_PATH) /* got system directory */
+    {
+        wcsncat(argv0, L"\\netsh.exe", MAX_PATH - n - 1);
+    }
+    else
+    {
+        wcsncpy(argv0, L"C:\\Windows\\system32\\netsh.exe", MAX_PATH);
+    }
+
+    /* cmd template:
+     * netsh interface ipv4 set address name=$if_index source=dhcp
+     */
+    const wchar_t *fmt = L"netsh interface ipv4 set address name=\"%d\" source=dhcp";
+
+    /* max cmdline length in wchars -- include room for if index */
+    size_t ncmdline = wcslen(fmt) + 10 + 1;
+    wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
+    if (!cmdline)
+    {
+        err = ERROR_OUTOFMEMORY;
+        return err;
+    }
+
+    openvpn_sntprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
+
+    err = ExecCommand(argv0, cmdline, timeout);
+
+    /* Note: This could fail if dhcp is already enabled, so the caller
+     * may not want to treat errors as FATAL.
+     */
+
+    free(cmdline);
+    return err;
+}
+
 static VOID
 HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
@@ -1187,6 +1231,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
         flush_neighbors_message_t flush_neighbors;
         block_dns_message_t block_dns;
         dns_cfg_message_t dns;
+        enable_dhcp_message_t dhcp;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1247,6 +1292,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
             ack.error_number = HandleDNSConfigMessage(&msg.dns, lists);
             break;
 
+        case msg_enable_dhcp:
+            if (msg.header.size == sizeof(msg.dhcp))
+            {
+                ack.error_number = HandleEnableDHCPMessage(&msg.dhcp);
+            }
+            break;
+
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
-- 
2.1.4


