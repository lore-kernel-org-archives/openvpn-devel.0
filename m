From: Antonio Quartulli <a@...2181...>
Date: Tue,  3 Jan 2023 21:23:28 +0100
Message-Id: <20230103202330.1835-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] dco: properly re-initialize
 dco_del_peer_reason
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

After processing a message, all fields of the dco object should be
re-initialized so that future processings are not affected by stale
values.

This includes dco_del_peer_reason.

Since its values can start at 0, re-initialize it with -1.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3658e1d5..27676de5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3301,6 +3301,7 @@ multi_process_incoming_dco(struct multi_context *m)
 
     dco->dco_message_type = 0;
     dco->dco_message_peer_id = -1;
+    dco->dco_del_peer_reason = -1;
     dco->dco_read_bytes = 0;
     dco->dco_write_bytes = 0;
     return ret > 0;
-- 
2.38.2


