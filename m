From: Steffan Karger <steffan@...1856...>
Date: Thu,  3 Dec 2020 16:49:50 +0100
Message-Id: <20201203154951.29382-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] tls-crypt-v2: fix server memory leak
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

tls-crypt-v2 was developed in parallel with the changes that allowed to
use tls-auth/tls-crypt in connection blocks. The tls-crypt-v2 patch set
was never updated to the new reality after commit 5817b49b, causing a
memory leak of about 600 bytes for each connecting client.

It would be nicer to not reload the tls-crypt-v2 server key for each
connecting client, but that requires more refactoring (and thus more time
to get right). So for now just plug the leak by free'ing the memory when
we close a client connection.

To test this easily, compile openvpn with -fsanity=address, run a server
with tls-crypt-v2, connect a client, stop the server.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 27a4170d..5cde8a4b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3619,6 +3619,7 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
      * always free the tls_auth/crypt key. If persist_key is true, the key will
      * be reloaded from memory (pre-cached)
      */
+    free_key_ctx(&c->c1.ks.tls_crypt_v2_server_key);
     free_key_ctx_bi(&c->c1.ks.tls_wrap_key);
     CLEAR(c->c1.ks.tls_wrap_key);
     buf_clear(&c->c1.ks.tls_crypt_v2_wkc);
-- 
2.25.1


