From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 20 Mar 2024 10:19:45 +0200
Message-ID: <20240320082000.284-2-lev@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH release/2.5] interactive.c: Fix potential
 stack overflow issue
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
Cc: Lev Stipakov <lev@...515...>, Vladimir Tokarev <vtokarev@...2393...>, Heiko Hund <heiko@...515...>

When reading message from the pipe, we first peek the pipe to get the size
of the message waiting to be read and then read the message. A compromised
OpenVPN process could send an excessively large message, which would result
in a stack-allocated message buffer overflow.

To address this, we terminate the misbehaving process if the peeked message
size exceeds the maximum allowable size.

This commit is backported from 9b2693f in release/2.6 branch, fixing
merge conflicts around &ring_buffer_handles and wins_cfg_message_t.

CVE: 2024-27459
Microsoft case number: 85932

Reported-by: Vladimir Tokarev <vtokarev@...2393...>
Change-Id: Ib5743cba0741ea11f9ee62c4978b2c6789b81ada
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Heiko Hund <heiko@...515...>
---
 src/openvpnserv/interactive.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5e3ff125..933b5c8c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -111,6 +111,17 @@ typedef struct {
     HANDLE device;
 } ring_buffer_handles_t;
 
+typedef union {
+    message_header_t header;
+    address_message_t address;
+    route_message_t route;
+    flush_neighbors_message_t flush_neighbors;
+    block_dns_message_t block_dns;
+    dns_cfg_message_t dns;
+    enable_dhcp_message_t dhcp;
+    register_ring_buffers_message_t rrb;
+    set_mtu_message_t mtu;
+} pipe_message_t;
 
 static DWORD
 AddListItem(list_item_t **pfirst, LPVOID data)
@@ -1444,18 +1455,7 @@ static VOID
 HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_handles,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
-    DWORD read;
-    union {
-        message_header_t header;
-        address_message_t address;
-        route_message_t route;
-        flush_neighbors_message_t flush_neighbors;
-        block_dns_message_t block_dns;
-        dns_cfg_message_t dns;
-        enable_dhcp_message_t dhcp;
-        register_ring_buffers_message_t rrb;
-        set_mtu_message_t mtu;
-    } msg;
+    pipe_message_t msg;
     ack_message_t ack = {
         .header = {
             .type = msg_acknowledgement,
@@ -1465,7 +1465,7 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_
         .error_number = ERROR_MESSAGE_DATA
     };
 
-    read = ReadPipeAsync(pipe, &msg, bytes, count, events);
+    DWORD read = ReadPipeAsync(pipe, &msg, bytes, count, events);
     if (read != bytes || read < sizeof(msg.header) || read != msg.header.size)
     {
         goto out;
@@ -1884,6 +1884,13 @@ RunOpenvpn(LPVOID p)
             break;
         }
 
+        if (bytes > sizeof(pipe_message_t))
+        {
+            /* process at the other side of the pipe is misbehaving, shut it down */
+            MsgToEventLog(MSG_FLAGS_ERROR, TEXT("OpenVPN process sent too large payload length to the pipe (%lu bytes), it will be terminated"), bytes);
+            break;
+        }
+
         HandleMessage(ovpn_pipe, proc_info.hProcess, &ring_buffer_handles, bytes, 1, &exit_event, &undo_lists);
     }
 
-- 
2.42.0.windows.2


