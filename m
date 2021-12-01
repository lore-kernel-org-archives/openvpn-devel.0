From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:22 +0100
Message-Id: <20211201180727.2496903-4-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/9] Remove cipher_kt_var_key_size and
 remaining --keysize documentation
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

Remove --keysize from the manual page and also remove mentioning
variable key size in output of ciphers as there is no longer a way to
change the keysize.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/protocol-options.rst | 11 -----------
 src/openvpn/crypto.c                  |  7 ++-----
 src/openvpn/crypto_mbedtls.h          |  6 ------
 src/openvpn/crypto_openssl.h          |  6 ------
 4 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 7095b6f4d..f4be6f984 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -183,17 +183,6 @@ configured in a compatible way between both the local and remote side.
   ``--tls-auth`` and ``--secret`` options. Useful when using inline files
   (See section on inline files).
 
---keysize n
-  **DEPRECATED** This option will be removed in OpenVPN 2.6.
-
-  Size of cipher key in bits (optional). If unspecified, defaults to
-  cipher-specific default. The ``--show-ciphers`` option (see below) shows
-  all available OpenSSL ciphers, their default key sizes, and whether the
-  key size can be changed. Use care in changing a cipher's default key
-  size. Many ciphers have not been extensively cryptanalyzed with
-  non-standard key lengths, and a larger key may offer no real guarantee
-  of greater security, or may even reduce security.
-
 --data-ciphers cipher-list
   Restrict the allowed ciphers to be negotiated to the ciphers in
   ``cipher-list``. ``cipher-list`` is a colon-separated list of ciphers,
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 27ed1402c..0d577624e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1626,12 +1626,9 @@ get_random(void)
 void
 print_cipher(const cipher_kt_t *cipher)
 {
-    const char *var_key_size = cipher_kt_var_key_size(cipher) ?
-                               " by default" : "";
-
-    printf("%s  (%d bit key%s, ",
+    printf("%s  (%d bit key, ",
            cipher_kt_name(cipher),
-           cipher_kt_key_size(cipher) * 8, var_key_size);
+           cipher_kt_key_size(cipher) * 8);
 
     if (cipher_kt_block_size(cipher) == 1)
     {
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 758ab1b40..b2e9eceab 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -149,10 +149,4 @@ mbed_log_func_line_lite(unsigned int flags, int errval,
 #define mbed_ok(errval) \
     mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
-static inline bool
-cipher_kt_var_key_size(const cipher_kt_t *cipher)
-{
-    return cipher->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN;
-}
-
 #endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 446f08508..6eb16a906 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -114,12 +114,6 @@ void crypto_print_openssl_errors(const unsigned int flags);
         msg((flags), __VA_ARGS__); \
     } while (false)
 
-static inline bool
-cipher_kt_var_key_size(const cipher_kt_t *cipher)
-{
-    return EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH;
-}
-
 /**
  * Load a key file from an engine
  *
-- 
2.33.0


