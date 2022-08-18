From: Antonio Quartulli <a@...2181...>
Date: Thu, 18 Aug 2022 16:44:31 +0200
Message-Id: <20220818144431.208337-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: trigger ping timeout event only if the
 peer expired
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
Cc: Antonio Quartulli <a@...2181...>

DEL_PEER events can be sent by ovpn-dco to userspace for various reasons.
We should trigger the ping timeout reaction only if the reason was
"peer has expired".

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/forward.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d70b4f52..970be3bf 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1119,7 +1119,8 @@ process_incoming_dco(struct context *c)
 
     dco_do_read(dco);
 
-    if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+    if ((dco->dco_message_type == OVPN_CMD_DEL_PEER)
+        && (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED))
     {
         trigger_ping_timeout_signal(c);
         return;
-- 
2.30.2


