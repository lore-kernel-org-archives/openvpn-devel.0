From: Arne Schwabe <arne@...1227...>
Date: Thu,  9 Mar 2023 13:00:31 +0100
Message-Id: <20230309120031.3780130-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure n = 2 is set in key2 structer in
 tls_crypt_v2_unwrap_client_key
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

The ASSERT in xor_key2 assumes that all methods that load a key2 struct
correctly set n=2. However, tls_crypt_v2_unwrap_client_key loads a key
without setting n = 2, trigerring the assert.

Closes and reported in https://github.com/OpenVPN/openvpn/issues/272

Change-Id: Iaeb163d83b95818e0b26faf9d25e7737dc8ecb23
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tls_crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 8882d5de0..4f22f8af7 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -533,6 +533,7 @@ tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,
     }
     memcpy(&client_key->keys, BPTR(&plaintext), sizeof(client_key->keys));
     ASSERT(buf_advance(&plaintext, sizeof(client_key->keys)));
+    client_key->n = 2;
 
     if (!buf_copy(metadata, &plaintext))
     {
-- 
2.37.1 (Apple Git-137.1)


