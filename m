From: Steffan Karger <steffan@...1856...>
Date: Tue,  9 Oct 2018 22:43:15 +0200
Message-Id: <20181009204315.8262-1-steffan@...1856...>
In-Reply-To: <9b927c56-b850-b019-2385-2e9e199389b0@...2181...>
References: <9b927c56-b850-b019-2385-2e9e199389b0@...2181...>
Subject: [Openvpn-devel] [PATCH v3 2/2] List ChaCha20-Poly1305 as stream
 cipher
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

As Antonio pointed out, "8-bit block cipher" is a bit funny. So teach
print_cipher() to print such cipher as "stream cipher".

Because I didn't want to write the same code twice, I decided to merge the
two print_cipher() implementations into one shared function. That should
make it easier to keep both backends consistent.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c         | 27 +++++++++++++++++++++++++++
 src/openvpn/crypto.h         |  3 +++
 src/openvpn/crypto_mbedtls.c | 24 +++---------------------
 src/openvpn/crypto_mbedtls.h |  4 ++++
 src/openvpn/crypto_openssl.c | 15 ---------------
 src/openvpn/crypto_openssl.h |  4 ++++
 6 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6d34acd7..e81399b7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1769,6 +1769,33 @@ get_random(void)
     return l;
 }
 
+void
+print_cipher(const cipher_kt_t *cipher)
+{
+    const char *var_key_size = cipher_kt_var_key_size(cipher) ?
+        " by default" : "";
+
+    printf("%s  (%d bit key%s, ",
+           translate_cipher_name_to_openvpn(cipher_kt_name(cipher)),
+           cipher_kt_key_size(cipher) * 8, var_key_size);
+
+    if (cipher_kt_block_size(cipher) == 1)
+    {
+        printf("stream cipher");
+    }
+    else
+    {
+        printf("%d bit block", cipher_kt_block_size(cipher) * 8);
+    }
+
+    if (!cipher_kt_mode_cbc(cipher))
+    {
+        printf(", TLS client/server mode only");
+    }
+
+    printf(")\n");
+}
+
 static const cipher_name_pair *
 get_cipher_name_pair(const char *cipher_name)
 {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index f4b3dca3..cf87cb49 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -465,6 +465,9 @@ void prng_uninit(void);
 /* an analogue to the random() function, but use prng_bytes */
 long int get_random(void);
 
+/** Print a cipher list entry */
+void print_cipher(const cipher_kt_t *cipher);
+
 void test_crypto(struct crypto_options *co, struct frame *f);
 
 
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 0c39eccc..46c3c606 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -39,6 +39,7 @@
 #include "errlevel.h"
 #include "basic.h"
 #include "buffer.h"
+#include "crypto.h"
 #include "integer.h"
 #include "crypto_backend.h"
 #include "otime.h"
@@ -140,26 +141,6 @@ const cipher_name_pair cipher_name_translation_table[] = {
 const size_t cipher_name_translation_table_count =
     sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
 
-static void
-print_cipher(const cipher_kt_t *info)
-{
-    if (info && (cipher_kt_mode_cbc(info)
-#ifdef HAVE_AEAD_CIPHER_MODES
-                 || cipher_kt_mode_aead(info)
-#endif
-                 ))
-    {
-        const char *ssl_only = cipher_kt_mode_cbc(info) ?
-                               "" : ", TLS client/server mode only";
-        const char *var_key_size = info->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN ?
-                                   " by default" : "";
-
-        printf("%s  (%d bit key%s, %d bit block%s)\n",
-               cipher_kt_name(info), cipher_kt_key_size(info) * 8, var_key_size,
-               cipher_kt_block_size(info) * 8, ssl_only);
-    }
-}
-
 void
 show_available_ciphers(void)
 {
@@ -175,7 +156,8 @@ show_available_ciphers(void)
     while (*ciphers != 0)
     {
         const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && !cipher_kt_insecure(info))
+        if (info && !cipher_kt_insecure(info)
+            && (cipher_kt_mode_aead(info) || cipher_kt_mode_cbc(info)))
         {
             print_cipher(info);
         }
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 452b06ed..81b542bc 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -146,5 +146,9 @@ mbed_log_func_line_lite(unsigned int flags, int errval,
 #define mbed_ok(errval) \
     mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
+static inline bool cipher_kt_var_key_size(const cipher_kt_t *cipher)
+{
+    return cipher->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN;
+}
 
 #endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1c0fae86..7989127b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -265,21 +265,6 @@ cipher_name_cmp(const void *a, const void *b)
     return strcmp(cipher_name_a, cipher_name_b);
 }
 
-static void
-print_cipher(const EVP_CIPHER *cipher)
-{
-    const char *var_key_size =
-        (EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
-        " by default" : "";
-    const char *ssl_only = cipher_kt_mode_cbc(cipher) ?
-                           "" : ", TLS client/server mode only";
-
-    printf("%s  (%d bit key%s, %d bit block%s)\n",
-           translate_cipher_name_to_openvpn(EVP_CIPHER_name(cipher)),
-           EVP_CIPHER_key_length(cipher) * 8, var_key_size,
-           cipher_kt_block_size(cipher) * 8, ssl_only);
-}
-
 void
 show_available_ciphers(void)
 {
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 0a413705..1ea3e858 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -101,5 +101,9 @@ void crypto_print_openssl_errors(const unsigned int flags);
         msg((flags), __VA_ARGS__); \
     } while (false)
 
+static inline bool cipher_kt_var_key_size(const cipher_kt_t *cipher)
+{
+    return EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH;
+}
 
 #endif /* CRYPTO_OPENSSL_H_ */
-- 
2.17.1


