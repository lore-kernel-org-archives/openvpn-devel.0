From: Arne Schwabe <arne@...1227...>
Date: Thu, 17 Feb 2022 19:19:43 +0100
Message-Id: <20220217181943.33531-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove unused function cipher_var_key_size
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

This function has been accidentially not been deleted during the removal
of last bits of variable key size.
---
 src/openvpn/crypto_openssl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 8bc41792..1c99db0f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -612,15 +612,6 @@ out:
     return ret;
 }
 
-bool cipher_var_key_size(const char *ciphername)
-{
-    evp_cipher_type *cipher = cipher_get(ciphername);
-    bool ret = EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH;
-    EVP_CIPHER_free(cipher);
-    return ret;
-}
-
-
 const char *
 cipher_kt_name(const char *ciphername)
 {
-- 
2.33.0


