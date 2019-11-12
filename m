From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 12 Nov 2019 15:26:37 +0200
Message-Id: <20191112132637.1290-1-lstipakov@...277...>
In-Reply-To: <1573148729-27339-6-git-send-email-lstipakov@...277...>
References: <1573148729-27339-6-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v3 5/7] wintun: interactive service support
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

Wintun requires ring buffers registration to be
performed by privileged process. In order to use
openvpn with wintun by non-Administrator, we
need to use interactive service and shared memory
to register buffers.

Openvpn process creates memory mapping object and event
for send and receive ring and passes handles to interactive
service. There handles are duplicated and memory mapped
object is mapped into the address space of service process.
Then address of mapped view and event handle is passed to
wintun kernel driver.

After interactive service preformed registration,
openvpn process maps memory mapped object into
own address space. Thus mapped views in openvpn
and service process represent the same memory region.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 While v2 has been ACKed, it had to be rebased on
 top of previous patch in series, which required some
 manual work.

 v3:
  - rebased on top of PATCH v4 4/7 "wintun: ring buffers based I/O"
  - added doxygen comments to ring_buffer.h

 v2:
  - rebased on top of master

 include/openvpn-msg.h                       |  10 ++
 src/openvpn/Makefile.am                     |   2 +-
 src/openvpn/openvpn.vcxproj                 |   2 +
 src/openvpn/openvpn.vcxproj.filters         |   8 +-
 src/openvpn/ring_buffer.c                   |  54 ++++++++
 src/openvpn/ring_buffer.h                   | 105 +++++++++++++++
 src/openvpn/tun.c                           |  82 ++++++++++--
 src/openvpn/tun.h                           |   3 +
 src/openvpn/win32.c                         |  25 ----
 src/openvpn/win32.h                         |  47 -------
 src/openvpnserv/Makefile.am                 |   3 +-
 src/openvpnserv/interactive.c               | 141 +++++++++++++++++++-
 src/openvpnserv/openvpnserv.vcxproj         |   2 +
 src/openvpnserv/openvpnserv.vcxproj.filters |   6 +
 14 files changed, 398 insertions(+), 92 deletions(-)
 create mode 100644 src/openvpn/ring_buffer.c
 create mode 100644 src/openvpn/ring_buffer.h

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 66177a21..3ed62069 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -39,6 +39,7 @@ typedef enum {
     msg_del_block_dns,
     msg_register_dns,
     msg_enable_dhcp,
+    msg_register_ring_buffers
 } message_type_t;
 
 typedef struct {
@@ -117,4 +118,13 @@ typedef struct {
     interface_t iface;
 } enable_dhcp_message_t;
 
+typedef struct {
+    message_header_t header;
+    HANDLE device;
+    HANDLE send_ring_handle;
+    HANDLE receive_ring_handle;
+    HANDLE send_tail_moved;
+    HANDLE receive_tail_moved;
+} register_ring_buffers_message_t;
+
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a091ffc2..d1bb99c2 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -138,6 +138,6 @@ openvpn_LDADD = \
 	$(OPTIONAL_SYSTEMD_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
-openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
+openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.c ring_buffer.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
 endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 7446d97d..614d720a 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -181,6 +181,7 @@
     <ClCompile Include="ps.c" />
     <ClCompile Include="push.c" />
     <ClCompile Include="reliable.c" />
+    <ClCompile Include="ring_buffer.c" />
     <ClCompile Include="route.c" />
     <ClCompile Include="run_command.c" />
     <ClCompile Include="schedule.c" />
@@ -265,6 +266,7 @@
     <ClInclude Include="push.h" />
     <ClInclude Include="pushlist.h" />
     <ClInclude Include="reliable.h" />
+    <ClInclude Include="ring_buffer.h" />
     <ClInclude Include="route.h" />
     <ClInclude Include="run_command.h" />
     <ClInclude Include="schedule.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 653e892c..41e62d14 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -240,6 +240,9 @@
     <ClCompile Include="vlan.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="ring_buffer.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -500,10 +503,13 @@
     <ClInclude Include="vlan.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="ring_buffer.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
       <Filter>Resource Files</Filter>
     </ResourceCompile>
   </ItemGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/ring_buffer.c b/src/openvpn/ring_buffer.c
new file mode 100644
index 00000000..482e3336
--- /dev/null
+++ b/src/openvpn/ring_buffer.c
@@ -0,0 +1,54 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *                2019 Lev Stipakov <lev@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include "ring_buffer.h"
+
+#ifdef _WIN32
+
+bool
+register_ring_buffers(HANDLE device,
+                      struct tun_ring *send_ring,
+                      struct tun_ring *receive_ring,
+                      HANDLE send_tail_moved,
+                      HANDLE receive_tail_moved)
+{
+    struct tun_register_rings rr;
+    BOOL res;
+
+    ZeroMemory(&rr, sizeof(rr));
+
+    rr.send.ring = send_ring;
+    rr.send.ring_size = sizeof(send_ring->data);
+    rr.send.tail_moved = send_tail_moved;
+
+    rr.receive.ring = receive_ring;
+    rr.receive.ring_size = sizeof(receive_ring->data);
+    rr.receive.tail_moved = receive_tail_moved;
+
+    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr), NULL, 0, NULL, NULL);
+
+    return res == TRUE;
+}
+
+#endif /* ifdef _WIN32 */
\ No newline at end of file
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
new file mode 100644
index 00000000..5095af5b
--- /dev/null
+++ b/src/openvpn/ring_buffer.h
@@ -0,0 +1,105 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
+ *                2019 Lev Stipakov <lev@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef _WIN32
+#ifndef OPENVPN_RING_BUFFER_H
+#define OPENVPN_RING_BUFFER_H
+
+#include <windows.h>
+#include <winioctl.h>
+
+#include <stdint.h>
+#include <stdbool.h>
+
+/*
+ * Values below are taken from Wireguard Windows client
+ * https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_windows.go#L14
+ */
+#define WINTUN_RING_CAPACITY        0x800000
+#define WINTUN_RING_TRAILING_BYTES  0x10000
+#define WINTUN_RING_FRAMING_SIZE    12
+#define WINTUN_MAX_PACKET_SIZE      0xffff
+#define WINTUN_PACKET_ALIGN         4
+
+#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
+
+/**
+ * Wintun ring buffer
+ * See https://github.com/WireGuard/wintun#ring-layout
+ */
+struct tun_ring
+{
+    volatile ULONG head;
+    volatile ULONG tail;
+    volatile LONG alertable;
+    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES + WINTUN_RING_FRAMING_SIZE];
+};
+
+/**
+ * Struct for ring buffers registration
+ * See https://github.com/WireGuard/wintun#registering-rings
+ */
+struct tun_register_rings
+{
+    struct
+    {
+        ULONG ring_size;
+        struct tun_ring *ring;
+        HANDLE tail_moved;
+    } send, receive;
+};
+
+struct TUN_PACKET_HEADER
+{
+    uint32_t size;
+};
+
+struct TUN_PACKET
+{
+    uint32_t size;
+    UCHAR data[WINTUN_MAX_PACKET_SIZE];
+};
+
+/**
+ * Registers ring buffers used to exchange data between
+ * userspace openvpn process and wintun kernel driver,
+ * see https://github.com/WireGuard/wintun#registering-rings
+ *
+ * @param device              handle to opened wintun device
+ * @param send_ring           pointer to send ring
+ * @param receive_ring        pointer to receive ring
+ * @param send_tail_moved     event set by wintun to signal openvpn
+ *                            that data is available for reading in send ring
+ * @param receive_tail_moved  event set by openvpn to signal wintun
+ *                            that data has been written to receive ring
+ * @return                    true if registration is successful, false otherwise
+ */
+bool register_ring_buffers(HANDLE device,
+                           struct tun_ring *send_ring,
+                           struct tun_ring *receive_ring,
+                           HANDLE send_tail_moved,
+                           HANDLE receive_tail_moved);
+
+#endif /* ifndef OPENVPN_RING_BUFFER_H */
+#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6522c6b6..f97dc936 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -799,17 +799,29 @@ init_tun_post(struct tuntap *tt,
 
     if (tt->wintun)
     {
-        tt->wintun_send_ring = malloc(sizeof(struct tun_ring));
-        tt->wintun_receive_ring = malloc(sizeof(struct tun_ring));
-        if ((tt->wintun_send_ring == NULL) || (tt->wintun_receive_ring == NULL))
+        tt->wintun_send_ring_handle = CreateFileMapping(INVALID_HANDLE_VALUE, NULL,
+                                                        PAGE_READWRITE,
+                                                        0,
+                                                        sizeof(struct tun_ring),
+                                                        NULL);
+        tt->wintun_receive_ring_handle = CreateFileMapping(INVALID_HANDLE_VALUE,
+                                                           NULL,
+                                                           PAGE_READWRITE,
+                                                           0,
+                                                           sizeof(struct tun_ring),
+                                                           NULL);
+        if ((tt->wintun_send_ring_handle == NULL) || (tt->wintun_receive_ring_handle == NULL))
         {
             msg(M_FATAL, "Cannot allocate memory for ring buffer");
         }
-        ZeroMemory(tt->wintun_send_ring, sizeof(struct tun_ring));
-        ZeroMemory(tt->wintun_receive_ring, sizeof(struct tun_ring));
 
         tt->rw_handle.read = CreateEvent(NULL, FALSE, FALSE, NULL);
         tt->rw_handle.write = CreateEvent(NULL, FALSE, FALSE, NULL);
+
+        if ((tt->rw_handle.read == NULL) || (tt->rw_handle.write == NULL))
+        {
+            msg(M_FATAL, "Cannot create events for ring buffer");
+        }
     }
     else
     {
@@ -5634,6 +5646,44 @@ register_dns_service(const struct tuntap *tt)
     gc_free(&gc);
 }
 
+static void
+service_register_ring_buffers(const struct tuntap *tt)
+{
+    HANDLE msg_channel = tt->options.msg_channel;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+
+    register_ring_buffers_message_t msg = {
+        .header = {
+            msg_register_ring_buffers,
+            sizeof(register_ring_buffers_message_t),
+            0
+        },
+        .device = tt->hand,
+        .send_ring_handle = tt->wintun_send_ring_handle,
+        .receive_ring_handle = tt->wintun_receive_ring_handle,
+        .send_tail_moved = tt->rw_handle.read,
+        .receive_tail_moved = tt->rw_handle.write
+    };
+
+    if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack, "Register ring buffers"))
+    {
+        gc_free(&gc);
+        return;
+    }
+    else if (ack.error_number != NO_ERROR)
+    {
+        msg(M_FATAL, "Register ring buffers failed using service: %s [status=0x%x]",
+            strerror_win32(ack.error_number, &gc), ack.error_number);
+    }
+    else
+    {
+        msg(M_INFO, "Ring buffers registered via service");
+    }
+
+    gc_free(&gc);
+}
+
 void
 fork_register_dns_action(struct tuntap *tt)
 {
@@ -6228,9 +6278,20 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     if (tt->wintun)
     {
+        tt->wintun_send_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_send_ring_handle,
+                                                                FILE_MAP_ALL_ACCESS,
+                                                                0,
+                                                                0,
+                                                                sizeof(struct tun_ring));
+        tt->wintun_receive_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_receive_ring_handle,
+                                                                   FILE_MAP_ALL_ACCESS,
+                                                                   0,
+                                                                   0,
+                                                                   sizeof(struct tun_ring));
+
         if (tt->options.msg_channel)
         {
-            /* TODO */
+            service_register_ring_buffers(tt);
         }
         else
         {
@@ -6395,13 +6456,12 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     {
         CloseHandle(tt->rw_handle.read);
         CloseHandle(tt->rw_handle.write);
+        UnmapViewOfFile(tt->wintun_send_ring);
+        UnmapViewOfFile(tt->wintun_receive_ring);
+        CloseHandle(tt->wintun_send_ring_handle);
+        CloseHandle(tt->wintun_receive_ring_handle);
     }
 
-    free(tt->wintun_receive_ring);
-    free(tt->wintun_send_ring);
-
-    tt->wintun_receive_ring = NULL;
-    tt->wintun_send_ring = NULL;
 
     clear_tuntap(tt);
     free(tt);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 784bde1a..f9970900 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -39,6 +39,7 @@
 #include "proto.h"
 #include "misc.h"
 #include "networking.h"
+#include "ring_buffer.h"
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
@@ -184,6 +185,8 @@ struct tuntap
     bool wintun; /* true if wintun is used instead of tap-windows6 */
     int standby_iter;
 
+    HANDLE wintun_send_ring_handle;
+    HANDLE wintun_receive_ring_handle;
     struct tun_ring *wintun_send_ring;
     struct tun_ring *wintun_receive_ring;
 #else  /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e9e0258f..b2f2a19f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1588,29 +1588,4 @@ impersonate_as_system()
     return true;
 }
 
-bool
-register_ring_buffers(HANDLE device,
-                      struct tun_ring* send_ring,
-                      struct tun_ring* receive_ring,
-                      HANDLE send_tail_moved,
-                      HANDLE receive_tail_moved)
-{
-    struct tun_register_rings rr;
-    BOOL res;
-
-    ZeroMemory(&rr, sizeof(rr));
-
-    rr.send.ring = send_ring;
-    rr.send.ring_size = sizeof(send_ring->data);
-    rr.send.tail_moved = send_tail_moved;
-
-    rr.receive.ring = receive_ring;
-    rr.receive.ring_size = sizeof(receive_ring->data);
-    rr.receive.tail_moved = receive_tail_moved;
-
-    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr), NULL, 0, NULL, NULL);
-
-    return res == TRUE;
-}
-
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index f6d45bdc..4b508c56 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -325,54 +325,7 @@ bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
-/*
- * Values below are taken from Wireguard Windows client
- * https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_windows.go#L14
- */
-#define WINTUN_RING_CAPACITY 0x800000
-#define WINTUN_RING_TRAILING_BYTES 0x10000
-#define WINTUN_RING_FRAMING_SIZE 12
-#define WINTUN_MAX_PACKET_SIZE 0xffff
-#define WINTUN_PACKET_ALIGN 4
-
-struct tun_ring
-{
-    volatile ULONG head;
-    volatile ULONG tail;
-    volatile LONG alertable;
-    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES + WINTUN_RING_FRAMING_SIZE];
-};
-
-struct tun_register_rings
-{
-    struct
-    {
-        ULONG ring_size;
-        struct tun_ring *ring;
-        HANDLE tail_moved;
-    } send, receive;
-};
-
-struct TUN_PACKET_HEADER
-{
-    uint32_t size;
-};
-
-struct TUN_PACKET
-{
-    uint32_t size;
-    UCHAR data[WINTUN_MAX_PACKET_SIZE];
-};
-
-#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
-
 bool impersonate_as_system();
 
-bool register_ring_buffers(HANDLE device,
-                           struct tun_ring *send_ring,
-                           struct tun_ring *receive_ring,
-                           HANDLE send_tail_moved,
-                           HANDLE receive_tail_moved);
-
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index bc65070b..f8d3319c 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -36,4 +36,5 @@ openvpnserv_SOURCES = \
 	service.c service.h \
 	validate.c validate.h \
 	$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns.h \
-	openvpnserv_resources.rc
+	openvpnserv_resources.rc \
+	$(top_srcdir)/src/openvpn/ring_buffer.c $(top_srcdir)/src/openvpn/ring_buffer.h
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 623c3ff7..6e72a141 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -43,13 +43,15 @@
 #include "openvpn-msg.h"
 #include "validate.h"
 #include "block_dns.h"
+#include "ring_buffer.h"
 
 #define IO_TIMEOUT  2000 /*ms*/
 
-#define ERROR_OPENVPN_STARTUP  0x20000000
-#define ERROR_STARTUP_DATA     0x20000001
-#define ERROR_MESSAGE_DATA     0x20000002
-#define ERROR_MESSAGE_TYPE     0x20000003
+#define ERROR_OPENVPN_STARTUP        0x20000000
+#define ERROR_STARTUP_DATA           0x20000001
+#define ERROR_MESSAGE_DATA           0x20000002
+#define ERROR_MESSAGE_TYPE           0x20000003
+#define ERROR_REGISTER_RING_BUFFERS  0x20000004
 
 static SERVICE_STATUS_HANDLE service;
 static SERVICE_STATUS status = { .dwServiceType = SERVICE_WIN32_SHARE_PROCESS };
@@ -58,6 +60,7 @@ static settings_t settings;
 static HANDLE rdns_semaphore = NULL;
 #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
 
+#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
 
 openvpn_service_t interactive_service = {
     interactive,
@@ -100,6 +103,14 @@ typedef struct {
     int metric_v6;
 } block_dns_data_t;
 
+typedef struct {
+    HANDLE send_ring_handle;
+    HANDLE receive_ring_handle;
+    HANDLE send_tail_moved;
+    HANDLE receive_tail_moved;
+    HANDLE device;
+} ring_buffer_handles_t;
+
 
 static DWORD
 AddListItem(list_item_t **pfirst, LPVOID data)
@@ -154,6 +165,26 @@ CloseHandleEx(LPHANDLE handle)
     return INVALID_HANDLE_VALUE;
 }
 
+static HANDLE
+OvpnUnmapViewOfFile(LPHANDLE handle)
+{
+    if (handle && *handle && *handle != INVALID_HANDLE_VALUE)
+    {
+        UnmapViewOfFile(*handle);
+        *handle = INVALID_HANDLE_VALUE;
+    }
+    return INVALID_HANDLE_VALUE;
+}
+
+static void
+CloseRingBufferHandles(ring_buffer_handles_t *ring_buffer_handles)
+{
+    CloseHandleEx(&ring_buffer_handles->device);
+    CloseHandleEx(&ring_buffer_handles->receive_tail_moved);
+    CloseHandleEx(&ring_buffer_handles->send_tail_moved);
+    OvpnUnmapViewOfFile(&ring_buffer_handles->send_ring_handle);
+    OvpnUnmapViewOfFile(&ring_buffer_handles->receive_ring_handle);
+}
 
 static HANDLE
 InitOverlapped(LPOVERLAPPED overlapped)
@@ -1198,8 +1229,95 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     return err;
 }
 
+static DWORD
+OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE* new_handle)
+{
+    DWORD err = ERROR_SUCCESS;
+
+    if (!DuplicateHandle(ovpn_proc, orig_handle, GetCurrentProcess(), new_handle, 0, FALSE, DUPLICATE_SAME_ACCESS))
+    {
+        err = GetLastError();
+        MsgToEventLog(M_SYSERR, TEXT("Could not duplicate handle"));
+        return err;
+    }
+
+    return err;
+}
+
+static DWORD
+DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle, struct tun_ring **ring)
+{
+    DWORD err = ERROR_SUCCESS;
+
+    err = OvpnDuplicateHandle(ovpn_proc, orig_handle, new_handle);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+    *ring = (struct tun_ring *)MapViewOfFile(*new_handle, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(struct tun_ring));
+    if (*ring == NULL)
+    {
+        err = GetLastError();
+        MsgToEventLog(M_SYSERR, TEXT("Could not map shared memory"));
+        return err;
+    }
+
+    return err;
+}
+
+static DWORD
+HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovpn_proc,
+                          ring_buffer_handles_t *ring_buffer_handles)
+{
+    DWORD err = 0;
+    struct tun_ring *send_ring;
+    struct tun_ring *receive_ring;
+
+    CloseRingBufferHandles(ring_buffer_handles);
+
+    err = OvpnDuplicateHandle(ovpn_proc, rrb->device, &ring_buffer_handles->device);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+
+    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_handles->send_ring_handle, &send_ring);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+
+    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_handles->receive_ring_handle, &receive_ring);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+
+    err = OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved, &ring_buffer_handles->send_tail_moved);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+
+    err = OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved, &ring_buffer_handles->receive_tail_moved);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+
+    if (!register_ring_buffers(ring_buffer_handles->device, send_ring, receive_ring,
+                               ring_buffer_handles->send_tail_moved, ring_buffer_handles->receive_tail_moved))
+    {
+        MsgToEventLog(M_SYSERR, TEXT("Could not register ring buffers"));
+        err = ERROR_REGISTER_RING_BUFFERS;
+    }
+
+    return err;
+}
+
 static VOID
-HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
+HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_handles,
+              DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
     DWORD read;
     union {
@@ -1210,6 +1328,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
         block_dns_message_t block_dns;
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
+        register_ring_buffers_message_t rrb;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1277,6 +1396,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
             }
             break;
 
+        case msg_register_ring_buffers:
+            if (msg.header.size == sizeof(msg.rrb))
+            {
+                ack.error_number = HandleRegisterRingBuffers(&msg.rrb, ovpn_proc, ring_buffer_handles);
+            }
+            break;
+
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
@@ -1360,6 +1486,7 @@ RunOpenvpn(LPVOID p)
     WCHAR *cmdline = NULL;
     size_t cmdline_size;
     undo_lists_t undo_lists;
+    ring_buffer_handles_t ring_buffer_handles;
 
     SECURITY_ATTRIBUTES inheritable = {
         .nLength = sizeof(inheritable),
@@ -1380,6 +1507,7 @@ RunOpenvpn(LPVOID p)
     ZeroMemory(&startup_info, sizeof(startup_info));
     ZeroMemory(&undo_lists, sizeof(undo_lists));
     ZeroMemory(&proc_info, sizeof(proc_info));
+    ZeroMemory(&ring_buffer_handles, sizeof(ring_buffer_handles));
 
     if (!GetStartupData(pipe, &sud))
     {
@@ -1611,7 +1739,7 @@ RunOpenvpn(LPVOID p)
             break;
         }
 
-        HandleMessage(ovpn_pipe, bytes, 1, &exit_event, &undo_lists);
+        HandleMessage(ovpn_pipe, proc_info.hProcess, &ring_buffer_handles, bytes, 1, &exit_event, &undo_lists);
     }
 
     WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);
@@ -1638,6 +1766,7 @@ out:
     free(cmdline);
     DestroyEnvironmentBlock(user_env);
     FreeStartupData(&sud);
+    CloseRingBufferHandles(&ring_buffer_handles);
     CloseHandleEx(&proc_info.hProcess);
     CloseHandleEx(&proc_info.hThread);
     CloseHandleEx(&stdin_read);
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 7061b7b1..c5a34b87 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -115,6 +115,7 @@
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
+    <ClCompile Include="..\openvpn\ring_buffer.c" />
     <ClCompile Include="automatic.c" />
     <ClCompile Include="common.c" />
     <ClCompile Include="interactive.c" />
@@ -123,6 +124,7 @@
     <ClCompile Include="..\openvpn\block_dns.c" />
   </ItemGroup>
   <ItemGroup>
+    <ClInclude Include="..\openvpn\ring_buffer.h" />
     <ClInclude Include="service.h" />
     <ClInclude Include="validate.h" />
     <ClInclude Include="..\openvpn\block_dns.h" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
index 3ce9bb24..3cb14ef6 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -33,6 +33,9 @@
     <ClCompile Include="..\openvpn\block_dns.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="..\openvpn\ring_buffer.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="service.h">
@@ -44,6 +47,9 @@
     <ClInclude Include="..\openvpn\block_dns.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="..\openvpn\ring_buffer.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpnserv_resources.rc">
-- 
2.17.1


