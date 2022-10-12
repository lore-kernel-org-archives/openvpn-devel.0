From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Oct 2022 15:34:56 +0200
Message-Id: <20221012133457.1927871-3-arne@...1227...>
In-Reply-To: <20221012133457.1927871-1-arne@...1227...>
References: <20221012133457.1927871-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Call dco_p2p_add_new_peer again if the
 peer id changes
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

This allows a reconnect in p2p mode and has the side effect of updating
the peer address with the peerid

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8db4f2ce1..e56028c0c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -150,6 +150,13 @@ check_dco_key_status(struct context *c)
         return;
     }
 
+    /* If the DCO peer id changed, we need to readd the peer */
+    if (c->c2.tls_multi->dco_peer_id != -1
+        && c->c2.tls_multi->peer_id != c->c2.tls_multi->dco_peer_id)
+    {
+        dco_p2p_add_new_peer(c);
+    }
+
     dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi);
 }
 
-- 
2.37.0 (Apple Git-136)


