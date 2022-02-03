From: Antonio Quartulli <a@...2181...>
Date: Thu,  3 Feb 2022 20:36:55 +0100
Message-Id: <20220203193655.28791-2-a@...2181...>
In-Reply-To: <20220203193655.28791-1-a@...2181...>
References: <20220203193655.28791-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/2] crypto: move OpenSSL specific FIPS
 check to its backend
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
Cc: Antonio Quartulli <a@...2181...>, David Sommerseth <davids@...515...>

Our crypto API already provides a function performing a validity check
on the specified ciphername. The OpenSSL counterpart also checks for the
cipher being FIPS-enabled.

This API is cipher_valid(). Extend it so that it can provide a reason
whenever the cipher is not valid and use it in crypto.c.

This way we move any OpenSSL specific bit to its own
backend and directly use the new cipher_valid_reason() API in the
generic code.

This patch fixes compilations with mbedTLS when some OpenSSL is also
installed. The issue was introduced with:
544330fe ("crypto: Fix OPENSSL_FIPS enabled builds")

Cc: David Sommerseth <davids@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* rebased
* don't return cipher, but true in cipher_valid_reason()

 src/openvpn/crypto.c         | 11 +++--------
 src/openvpn/crypto_backend.h | 21 ++++++++++++++++++++-
 src/openvpn/crypto_mbedtls.c | 13 +++++++++----
 src/openvpn/crypto_openssl.c |  6 +++++-
 4 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7fc7f8e7..461cfb8c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -34,7 +34,6 @@
 #include "error.h"
 #include "integer.h"
 #include "platform.h"
-#include "openssl_compat.h"
 
 #include "memdbg.h"
 
@@ -1698,16 +1697,12 @@ print_cipher(const char *ciphername)
     {
         printf(", TLS client/server mode only");
     }
-#ifdef OPENSSL_FIPS
-    evp_cipher_type *cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
 
-    if (FIPS_mode() && cipher
-        && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
+    const char *reason;
+    if (!cipher_valid_reason(ciphername, &reason))
     {
-        printf(", disabled by FIPS mode");
+        printf(", %s", reason);
     }
-    EVP_CIPHER_free(cipher);
-#endif
 
     printf(")\n");
 }
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 7beaf9c3..abf1b876 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -187,6 +187,21 @@ void cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
  */
 #define MAX_CIPHER_KEY_LENGTH 64
 
+/**
+ * Returns if the cipher is valid, based on the given cipher name and provides a
+ * reason if invalid.
+ *
+ * @param ciphername    Name of the cipher to check for validity (e.g.
+ *                      \c AES-128-CBC). Will be translated to the library name
+ *                      from the openvpn config name if needed.
+ * @param reason        Pointer where a static string indicating the reason
+ *                      for rejecting the cipher should be stored. It is set to
+ *                      NULL if the cipher is valid.
+ *
+ * @return              if the cipher is valid
+ */
+bool cipher_valid_reason(const char *ciphername, const char **reason);
+
 /**
  * Returns if the cipher is valid, based on the given cipher name.
  *
@@ -196,7 +211,11 @@ void cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
  *
  * @return              if the cipher is valid
  */
-bool cipher_valid(const char *ciphername);
+static inline bool cipher_valid(const char *ciphername)
+{
+    const char *reason;
+    return cipher_valid_reason(ciphername, &reason);
+}
 
 /**
  * Checks if the cipher is defined and is not the null (none) cipher
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 01bfa020..a771777e 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -403,14 +403,17 @@ cipher_get(const char* ciphername)
 }
 
 bool
-cipher_valid(const char *ciphername)
+cipher_valid_reason(const char *ciphername, const char **reason)
 {
+    ASSERT(reason);
+
     const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
 
     if (NULL == cipher)
     {
         msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
-        return NULL;
+        *reason = "disabled because unknown";
+        return false;
     }
 
     if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
@@ -418,10 +421,12 @@ cipher_valid(const char *ciphername)
         msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
-        return NULL;
+        *reason = "disabled due to key size too large";
+        return false;
     }
 
-    return cipher != NULL;
+    *reason = NULL;
+    return true;
 }
 
 const char *
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 6f3fbacd..8bc41792 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -572,13 +572,14 @@ cipher_get(const char *ciphername)
 }
 
 bool
-cipher_valid(const char *ciphername)
+cipher_valid_reason(const char *ciphername, const char **reason)
 {
     bool ret = false;
     evp_cipher_type *cipher = cipher_get(ciphername);
     if (!cipher)
     {
         crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
+        *reason = "disabled because unknown";
         goto out;
     }
 
@@ -590,6 +591,7 @@ cipher_valid(const char *ciphername)
     {
         msg(D_LOW, "Cipher algorithm '%s' is known by OpenSSL library but "
                     "currently disabled by running in FIPS mode.", ciphername);
+        *reason = "disabled by FIPS mode";
         goto out;
     }
 #endif
@@ -599,10 +601,12 @@ cipher_valid(const char *ciphername)
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)", ciphername, EVP_CIPHER_key_length(cipher),
             MAX_CIPHER_KEY_LENGTH);
+        *reason = "disabled due to key size too large";
         goto out;
     }
 
     ret = true;
+    *reason = NULL;
 out:
     EVP_CIPHER_free(cipher);
     return ret;
-- 
2.34.1


