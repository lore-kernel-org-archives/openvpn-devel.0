From: selva.nair@...277...
Date: Tue,  2 Oct 2018 16:01:14 -0400
Message-Id: <1538510474-27602-3-git-send-email-selva.nair@...277...>
In-Reply-To: <1538510474-27602-1-git-send-email-selva.nair@...277...>
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
 <1538510474-27602-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 3/3] Refactor sending commands to
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

Move writing the message buffer to the interactive service pipe and
reading acknowledgement to a function.

A minor bug in open_tun where the ack data could be read even after
a communication error is fixed.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c |  6 +-----
 src/openvpn/tun.c   | 34 +++++++++-------------------------
 src/openvpn/win32.c | 27 ++++++++++++++++++++++-----
 src/openvpn/win32.h |  9 +++++++++
 4 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ff39230..8a3e8b4 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2991,16 +2991,12 @@ del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt)
 static bool
 do_route_service(const bool add, const route_message_t *rt, const size_t size, HANDLE pipe)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
 
-    if (!WriteFile(pipe, rt, size, &len, NULL)
-        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    if (!send_msg_iservice(pipe, rt, size, &ack, "ROUTE"))
     {
-        msg(M_WARN, "ROUTE: could not talk to service: %s [%lu]",
-            strerror_win32(GetLastError(), &gc), GetLastError());
         goto out;
     }
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a2d5315..948fd17 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -82,7 +82,6 @@ static DWORD get_adapter_index_flexible(const char *name);
 static bool
 do_address_service(const bool add, const short family, const struct tuntap *tt)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
@@ -115,11 +114,8 @@ do_address_service(const bool add, const short family, const struct tuntap *tt)
         addr.prefix_len = tt->netbits_ipv6;
     }
 
-    if (!WriteFile(pipe, &addr, sizeof(addr), &len, NULL)
-        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    if (!send_msg_iservice(pipe, &addr, sizeof(addr), &ack, "TUN"))
     {
-        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
-            strerror_win32(GetLastError(), &gc), GetLastError());
         goto out;
     }
 
@@ -141,7 +137,6 @@ out:
 static bool
 do_dns6_service(bool add, const struct tuntap *tt)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
@@ -185,11 +180,8 @@ do_dns6_service(bool add, const struct tuntap *tt)
     msg(D_LOW, "%s IPv6 dns servers on '%s' (if_index = %d) using service",
         (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
 
-    if (!WriteFile(pipe, &dns, sizeof(dns), &len, NULL)
-        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
     {
-        msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
-            strerror_win32(GetLastError(), &gc), GetLastError());
         goto out;
     }
 
@@ -5222,11 +5214,8 @@ service_enable_dhcp(const struct tuntap *tt)
         .iface = { .index = tt->adapter_index, .name = "" }
     };
 
-    if (!WriteFile(pipe, &dhcp, sizeof(dhcp), &len, NULL)
-        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    if (!send_msg_iservice(pipe, &dhcp, sizeof(dhcp), &ack, "Enable_dhcp"))
     {
-        msg(M_WARN, "Enable_dhcp: could not talk to service: %s [%lu]",
-            strerror_win32(GetLastError(), &gc), GetLastError());
         goto out;
     }
 
@@ -5461,18 +5450,16 @@ fork_dhcp_action(struct tuntap *tt)
 static void
 register_dns_service(const struct tuntap *tt)
 {
-    DWORD len;
     HANDLE msg_channel = tt->options.msg_channel;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
 
     message_header_t rdns = { msg_register_dns, sizeof(message_header_t), 0 };
 
-    if (!WriteFile(msg_channel, &rdns, sizeof(rdns), &len, NULL)
-        || !ReadFile(msg_channel, &ack, sizeof(ack), &len, NULL))
+    if (!send_msg_iservice(msg_channel, &rdns, sizeof(rdns), &ack, "Register_dns"))
     {
-        msg(M_WARN, "Register_dns: could not talk to service: %s [status=0x%lx]",
-            strerror_win32(GetLastError(), &gc), GetLastError());
+        gc_free(&gc);
+        return;
     }
 
     else if (ack.error_number != NO_ERROR)
@@ -5936,14 +5923,11 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                     .iface = { .index = index, .name = "" }
                 };
 
-                if (!WriteFile(tt->options.msg_channel, &msg, sizeof(msg), &len, NULL)
-                    || !ReadFile(tt->options.msg_channel, &ack, sizeof(ack), &len, NULL))
+                if (send_msg_iservice(tt->options.msg_channel, &msg, sizeof(msg),
+                    &ack, "TUN"))
                 {
-                    msg(M_WARN, "TUN: could not talk to service: %s [%lu]",
-                        strerror_win32(GetLastError(), &gc), GetLastError());
+                    status = ack.error_number;
                 }
-
-                status = ack.error_number;
             }
             else
             {
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 3905524..e43296e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1264,7 +1264,6 @@ win_get_tempdir(void)
 static bool
 win_block_dns_service(bool add, int index, const HANDLE pipe)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
@@ -1278,11 +1277,8 @@ win_block_dns_service(bool add, int index, const HANDLE pipe)
         .iface = { .index = index, .name = "" }
     };
 
-    if (!WriteFile(pipe, &data, sizeof(data), &len, NULL)
-        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "Block_DNS"))
     {
-        msg(M_WARN, "Block_DNS: could not talk to service: %s [%lu]",
-            strerror_win32(GetLastError(), &gc), GetLastError());
         goto out;
     }
 
@@ -1473,4 +1469,25 @@ win32_version_string(struct gc_arena *gc, bool add_name)
     return (const char *)out.data;
 }
 
+bool
+send_msg_iservice(HANDLE pipe, const void *data, size_t size,
+                  ack_message_t *ack, const char *context)
+{
+    struct gc_arena gc = gc_new();
+    DWORD len;
+    bool ret = true;
+
+    if (!WriteFile(pipe, data, size, &len, NULL)
+        || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
+    {
+        msg(M_WARN, "%s: could not talk to service: %s [%lu]",
+            context? context : "Unknown",
+            strerror_win32(GetLastError(), &gc), GetLastError());
+        ret = false;
+    }
+
+    gc_free(&gc);
+    return ret;
+}
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4b99a5e..b5cbe25 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -26,6 +26,7 @@
 #define OPENVPN_WIN32_H
 
 #include "mtu.h"
+#include "openvpn-msg.h"
 
 /* location of executables */
 #define SYS_PATH_ENV_VAR_NAME "SystemRoot"  /* environmental variable name that normally contains the system path */
@@ -307,5 +308,13 @@ int win32_version_info(void);
  */
 const char *win32_version_string(struct gc_arena *gc, bool add_name);
 
+/*
+ * Send the |size| bytes in buffer |data| to the interactive service |pipe|
+ * and read the result in |ack|. Returns false on communication error.
+ * The string in |context| is used to prefix error messages.
+ */
+bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
+                       ack_message_t *ack, const char *context);
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
-- 
2.1.4


