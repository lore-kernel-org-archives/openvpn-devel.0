From: Antonio Quartulli <a@...2181...>
Date: Wed, 26 Jan 2022 17:28:29 +0100
Message-Id: <20220126162830.20952-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] crypto: move validation logic from
 cipher_get to cipher_valid
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

With cipher validation performed in cipher_get(), a cipher is never
returned in any case if some check fails.

This prevents OpenVPN from operating on all ciphers provided by the SSL
library, like printing them to the user.

Move the validation logic to cipher_valid() so that checks are performed
only when OpenVPN really want to know if a cipher is usable or not.

Fixes: ce2954a0 ("Remove cipher_kt_t and change type to const char* in API")
Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

NOTE: mbedtls already follows this approach and did not require
any change.

 src/openvpn/crypto_openssl.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a725306c..ea0147db 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -565,16 +565,19 @@ rand_bytes(uint8_t *output, int len)
 static evp_cipher_type *
 cipher_get(const char *ciphername)
 {
-    evp_cipher_type *cipher = NULL;
-
     ASSERT(ciphername);
 
     ciphername = translate_cipher_name_from_openvpn(ciphername);
-    cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
+    return EVP_CIPHER_fetch(NULL, ciphername, NULL);
+}
 
-    if (NULL == cipher)
+bool cipher_valid(const char *ciphername)
+{
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    if (!cipher)
     {
-        return NULL;
+        crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
+        return false;
     }
 
 #ifdef OPENSSL_FIPS
@@ -585,7 +588,7 @@ cipher_get(const char *ciphername)
     {
         msg(D_LOW, "Cipher algorithm '%s' is known by OpenSSL library but "
                     "currently disabled by running in FIPS mode.", ciphername);
-        return NULL;
+        return false;
     }
 #endif
     if (EVP_CIPHER_key_length(cipher) > MAX_CIPHER_KEY_LENGTH)
@@ -594,22 +597,11 @@ cipher_get(const char *ciphername)
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)", ciphername, EVP_CIPHER_key_length(cipher),
             MAX_CIPHER_KEY_LENGTH);
-        return NULL;
+        return false;
     }
 
-    return cipher;
-}
-
-bool cipher_valid(const char *ciphername)
-{
-    evp_cipher_type *cipher = cipher_get(ciphername);
-    bool valid = (cipher != NULL);
-    if (!valid)
-    {
-        crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
-    }
     EVP_CIPHER_free(cipher);
-    return valid;
+    return true;
 }
 
 bool cipher_var_key_size(const char *ciphername)
-- 
2.34.1


