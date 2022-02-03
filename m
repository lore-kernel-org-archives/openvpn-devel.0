From: Antonio Quartulli <a@...2181...>
Date: Thu,  3 Feb 2022 20:36:54 +0100
Message-Id: <20220203193655.28791-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/2] crypto: move validation logic from
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, David Sommerseth <davids@...515...>

With cipher validation performed in cipher_get(), a cipher is never
returned in any case if some check fails.

This prevents OpenVPN from operating on all ciphers provided by the SSL
library, like printing them to the user.

Move the validation logic to cipher_valid() so that checks are performed
only when OpenVPN really want to know if a cipher is usable or not.

Fixes: ce2954a0 ("Remove cipher_kt_t and change type to const char* in API")
Cc: Arne Schwabe <arne@...1227...>
Cc: David Sommerseth <davids@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* properly release cipher in case of error in cipher_valid();


 src/openvpn/crypto_openssl.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a725306c..6f3fbacd 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -565,16 +565,21 @@ rand_bytes(uint8_t *output, int len)
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
+bool
+cipher_valid(const char *ciphername)
+{
+    bool ret = false;
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    if (!cipher)
     {
-        return NULL;
+        crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
+        goto out;
     }
 
 #ifdef OPENSSL_FIPS
@@ -585,7 +590,7 @@ cipher_get(const char *ciphername)
     {
         msg(D_LOW, "Cipher algorithm '%s' is known by OpenSSL library but "
                     "currently disabled by running in FIPS mode.", ciphername);
-        return NULL;
+        goto out;
     }
 #endif
     if (EVP_CIPHER_key_length(cipher) > MAX_CIPHER_KEY_LENGTH)
@@ -594,22 +599,13 @@ cipher_get(const char *ciphername)
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)", ciphername, EVP_CIPHER_key_length(cipher),
             MAX_CIPHER_KEY_LENGTH);
-        return NULL;
+        goto out;
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
+    ret = true;
+out:
     EVP_CIPHER_free(cipher);
-    return valid;
+    return ret;
 }
 
 bool cipher_var_key_size(const char *ciphername)
-- 
2.34.1


