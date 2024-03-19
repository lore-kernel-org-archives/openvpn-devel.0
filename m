From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 19 Mar 2024 16:09:39 +0200
Message-ID: <20240319140957.2033-3-lev@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] interactive.c: Fix potential stack overflow
 issue
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

Reported-by: Vladimir Tokarev <vtokarev@...2393...>
Change-Id: Ib5743cba0741ea11f9ee62c4978b2c6789b81ada
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Heiko Hund <heiko@...515...>
---

 src/openvpnserv/interactive.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 32c8996c..24e3f341 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -106,6 +106,18 @@ typedef struct {
     struct tun_ring *receive_ring;
 } ring_buffer_maps_t;
 
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
+    wins_cfg_message_t wins;
+} pipe_message_t;
 
 static DWORD
 AddListItem(list_item_t **pfirst, LPVOID data)
@@ -1610,19 +1622,7 @@ static VOID
 HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
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
-        wins_cfg_message_t wins;
-    } msg;
+    pipe_message_t msg;
     ack_message_t ack = {
         .header = {
             .type = msg_acknowledgement,
@@ -1632,7 +1632,7 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
         .error_number = ERROR_MESSAGE_DATA
     };
 
-    read = ReadPipeAsync(pipe, &msg, bytes, count, events);
+    DWORD read = ReadPipeAsync(pipe, &msg, bytes, count, events);
     if (read != bytes || read < sizeof(msg.header) || read != msg.header.size)
     {
         goto out;
@@ -2059,6 +2059,13 @@ RunOpenvpn(LPVOID p)
             break;
         }
 
+        if (bytes > sizeof(pipe_message_t))
+        {
+            /* process at the other side of the pipe is misbehaving, shut it down */
+            MsgToEventLog(MSG_FLAGS_ERROR, TEXT("OpenVPN process sent too large payload length to the pipe (%lu bytes), it will be terminated"), bytes);
+            break;
+        }
+
         HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &exit_event, &undo_lists);
     }
 
-- 
2.42.0.windows.2


