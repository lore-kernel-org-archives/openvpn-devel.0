From: Gert Doering <gert@...1296...>
Date: Mon,  9 Jan 2023 21:00:11 +0100
Message-Id: <20230109200011.2525342-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Reduce logspam about 'dco_update_keys:
 peer_id=-1' in p2p server mode
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

p2p --tls-server with no active client/peer logs once per second

  "dco_update_keys: peer_id=-1"

which does exactly nothing, except fill the disk.  So skip the call to
dco_update_keys() if peer_id == -1.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/forward.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ae0512fc..2ba8b0fa 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -151,6 +151,12 @@ check_dco_key_status(struct context *c)
         return;
     }
 
+    /* no active peer (p2p tls-server mode) */
+    if (c->c2.tls_multi->dco_peer_id == -1 )
+    {
+        return;
+    }
+
     if (!dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi))
     {
         /* Something bad happened. Kill the connection to
-- 
2.25.1


