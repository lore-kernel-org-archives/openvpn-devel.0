From: Arne Schwabe <arne@...1227...>
Date: Mon, 22 May 2023 11:12:31 +0200
Message-Id: <20230522091231.2837468-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Print a more user-friendly error when
 tls-crypt-v2 client auth fails
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

While it might be clear to people being (too?) well versed in
typical crypto applications that an authentication failure probably
mean wrong decryption key, this is not really obvious for the typical
user/server admin.

Change-Id: If0f0e7d53f915d39ab69aaaac43dc73bb9c26ae9
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tls_crypt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 88b2d6d7c..73542368e 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -524,6 +524,8 @@ tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,
         dmsg(D_CRYPTO_DEBUG, "tag_check: %s",
              format_hex(tag_check, sizeof(tag_check), 0, &gc));
         CRYPT_ERROR("client key authentication error");
+        msg(D_TLS_DEBUG_LOW, "This might be a client-key that was generated for "
+            "a different tls-crypt-v2 server key)");
     }
 
     if (buf_len(&plaintext) < sizeof(client_key->keys))
-- 
2.39.2 (Apple Git-143)


