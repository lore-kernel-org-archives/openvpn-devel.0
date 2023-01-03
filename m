From: Antonio Quartulli <a@...2181...>
Date: Tue,  3 Jan 2023 21:23:29 +0100
Message-Id: <20230103202330.1835-2-a@...2181...>
In-Reply-To: <20230103202330.1835-1-a@...2181...>
References: <20230103202330.1835-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] dco: bail out when no peer-specific
 message is delivered
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

multi_process_incoming_dco() is currently partly processing
messages that were actually discarded. This results in a bogus
message being printed:

"Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 2"

Change the flow so that we bail out immediately when we know that no
message was truly delivered by DCO.
Currently this can be verified by chacking that the peed_is is greater
than -1.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 27676de5..b10a6d8d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3270,7 +3270,15 @@ multi_process_incoming_dco(struct multi_context *m)
 
     int peer_id = dco->dco_message_peer_id;
 
-    if ((peer_id >= 0) && (peer_id < m->max_clients) && (m->instances[peer_id]))
+    /* no peer-specific message delivered -> nothing to process.
+     * bail out right away
+     */
+    if (peer_id < 0)
+    {
+        return ret > 0;
+    }
+
+    if ((peer_id < m->max_clients) && (m->instances[peer_id]))
     {
         mi = m->instances[peer_id];
         if (dco->dco_message_type == OVPN_CMD_PACKET)
-- 
2.38.2


