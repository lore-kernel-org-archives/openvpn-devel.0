From: Antonio Quartulli <a@...2181...>
Date: Thu, 12 Jan 2023 01:04:35 +0100
Message-Id: <20230112000435.14119-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: send SIGUSR1 upon ping timeout
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

When a peer is removed with reason "ping expire", we should kill the
instance with SIGUSR1 and not SIGTERM

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
--

Arne, I am not 100% sure why but it seems for ping-restart we always use
SIGUSR1, right? but the DCO handling code was apparently using SIGTERM.

What do you think?
---
 src/openvpn/multi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 99123c39..10efffec 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3234,10 +3234,12 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
                           dco_context_t *dco)
 {
     const char *reason = "ovpn-dco: unknown reason";
+    int signal = SIGTERM;
     switch (dco->dco_del_peer_reason)
     {
         case OVPN_DEL_PEER_REASON_EXPIRED:
             reason = "ovpn-dco: ping expired";
+            signal = SIGUSR1;
             break;
 
         case OVPN_DEL_PEER_REASON_TRANSPORT_ERROR:
@@ -3270,7 +3272,7 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
     mi->context.sig->signal_text = reason;
     mi->context.c2.dco_read_bytes = dco->dco_read_bytes;
     mi->context.c2.dco_write_bytes = dco->dco_write_bytes;
-    multi_signal_instance(m, mi, SIGTERM);
+    multi_signal_instance(m, mi, signal);
 }
 
 bool
-- 
2.38.2


