From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Apr 2021 14:34:15 +0200
Message-Id: <20210421123415.1942917-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Allow all GCM ciphers
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

OpenSSL also allows ARIA-GCM and that works well with our implementation
While the handpicked list was needed for earlier OpenSSL versions (and
is still needed for Chacha20-Poly1305), the API nowadays with OpenSSL
1.0.2 and 1.1.x works as expected.

Patch V2: Remove special cases for AES-GCM ciphers.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f8b36bf85..57731ed79 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -728,16 +728,17 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
 {
     if (cipher)
     {
-        switch (EVP_CIPHER_nid(cipher))
+        if (EVP_CIPHER_mode(cipher) == OPENVPN_MODE_GCM)
         {
-            case NID_aes_128_gcm:
-            case NID_aes_192_gcm:
-            case NID_aes_256_gcm:
+            return true;
+        }
+
 #ifdef NID_chacha20_poly1305
-            case NID_chacha20_poly1305:
-#endif
-                return true;
+        if (EVP_CIPHER_nid(cipher) == NID_chacha20_poly1305)
+        {
+            return true;
         }
+#endif
     }
 
     return false;
-- 
2.31.1


