From: Gert Doering <gert@...1296...>
Date: Mon, 14 Aug 2023 08:04:09 +0200
Message-ID: <20230814060409.50742-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make received OCC exit messages more
 visible in log.
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

Currently, OCC exit messages are only logged at some high debug level
(and if OpenVPN compiled with DEBUG), while control-channel EEN messages
are logged on verb 1.  Make this consistent, both in wording and in
log level.

Both messages are prefixed with the "channel" where the exit message
came in.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/occ.c  | 2 +-
 src/openvpn/push.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 8541f6ec..2871449e 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -427,7 +427,7 @@ process_received_occ_msg(struct context *c)
             break;
 
         case OCC_EXIT:
-            dmsg(D_PACKET_CONTENT, "RECEIVED OCC_EXIT");
+            dmsg(D_STREAM_ERRORS, "OCC exit message received by peer");
             register_signal(c->sig, SIGUSR1, "remote-exit");
             break;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 01e7cd6e..5f5755ab 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -190,7 +190,7 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
 void
 receive_exit_message(struct context *c)
 {
-    dmsg(D_STREAM_ERRORS, "Exit message received by peer");
+    dmsg(D_STREAM_ERRORS, "CC-EEN exit message received by peer");
     /* With control channel exit notification, we want to give the session
      * enough time to handle retransmits and acknowledgment, so that eventual
      * retries from the client to resend the exit or ACKs will not trigger
-- 
2.41.0


