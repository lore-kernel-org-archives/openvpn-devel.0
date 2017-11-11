From: Steffan Karger <steffan@...1856...>
Date: Sat, 11 Nov 2017 17:03:59 +0100
Message-Id: <20171111160359.28078-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Use P_DATA_V2 for server->client packets too
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

P_DATA_V2 introduced the peer-id.  This allows clients to float, but as a
side-effect 32-bit aligns the encrypted data.  That alignment improves
performance particularly on cheaper/older CPUs.  So although servers don't
actually have a peer-id, still use the V2 packet format (with a zero-id)
for server->client traffic too.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 1b7455bb..20e89d34 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -496,7 +496,7 @@ encrypt_sign(struct context *c, bool comp_frag)
         /* If using P_DATA_V2, prepend the 1-byte opcode and 3-byte peer-id to the
          * packet before openvpn_encrypt(), so we can authenticate the opcode too.
          */
-        if (c->c2.buf.len > 0 && !c->c2.tls_multi->opt.server && c->c2.tls_multi->use_peer_id)
+        if (c->c2.buf.len > 0 && c->c2.tls_multi->use_peer_id)
         {
             tls_prepend_opcode_v2(c->c2.tls_multi, &b->encrypt_buf);
         }
-- 
2.14.1


