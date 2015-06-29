From: Steffan Karger <steffan@...1856...>
Date: Mon, 29 Jun 2015 22:59:42 +0200
Message-Id: <1435611582-26553-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Increase control channel packet size for
	faster handshakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Instead of limiting the control channel TCP/UDP packet payload size at
'100 bytes + real control channel overhead' (~140 bytes ethernet payload),
increase the max TCP/UDP payload size to '1250 bytes - calculated overhead'
(~1210 bytes ethernet payload).  This decreases the number of packets
required to establish a connection by a factor 10, but still has a
comfortable enough margin to succeed for lower-MTU connections.

This should especially help out for complex configs (trac #545), but also
for high-latency connections (trac #543).

Note that this patch does *not* yield an optimal solution, but it is a
simple and rather safe change that will improve connection setup times
significantly.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index bc17fd0..cde820d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -299,8 +299,9 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
   reliable_ack_adjust_frame_parameters (frame, CONTROL_SEND_ACK_MAX);
   frame_add_to_extra_frame (frame, SID_SIZE + sizeof (packet_id_type));
 
-  /* set dynamic link MTU to minimum value */
-  frame_set_mtu_dynamic (frame, 0, SET_MTU_TUN);
+  /* set dynamic link MTU to cap control channel packets at 1250 bytes */
+  ASSERT(TUN_LINK_DELTA(frame) < 1250);
+  frame->link_mtu_dynamic = 1250 - TUN_LINK_DELTA(frame);
 }
 
 void
-- 
2.1.4


