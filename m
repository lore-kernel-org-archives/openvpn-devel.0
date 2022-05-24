From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 May 2022 12:19:16 +0300
Message-Id: <20220524091916.145-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Set o->use_peer_id flag for p2p mode
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

There are two flags to indicate peer-id usage, one is
in tls_multi struct and another one is in options.

For P2P mode we don't set this flag in options,
which is used in MTU calculation. As a result,
automatically calculated MSS value in P2P mode is wrong,

Fix by bring use_peer_id flag in options and tls_multi
into sync for P2P.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b0c62a85..bf01d3d6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2144,6 +2144,8 @@ do_deferred_p2p_ncp(struct context *c)
         return true;
     }
 
+    c->options.use_peer_id = c->c2.tls_multi->use_peer_id;
+
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
 
     const char *ncp_cipher = get_p2p_ncp_cipher(session, c->c2.tls_multi->peer_info,
-- 
2.23.0.windows.1


