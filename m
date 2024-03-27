From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 27 Mar 2024 17:26:21 +0100
Message-Id: <20240327162621.1792414-1-frank@...2641...>
In-Reply-To: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
References: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] crypto_backend: fix type of enc parameter
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

We had parts of a abstraction, but it wasn't consistent.
GCC 13 now complains about the type mismatch with mbedtls now:

crypto_mbedtls.c:568:1: error:
conflicting types for ‘cipher_ctx_init’ due to enum/integer mismatch;
have ‘void(mbedtls_cipher_context_t *, const uint8_t *, const char *, const mbedtls_operation_t)’
[...] [-Werror=enum-int-mismatch]
crypto_backend.h:341:6: note:
previous declaration of ‘cipher_ctx_init’ with type
‘void(cipher_ctx_t *, const uint8_t *, const char *, int)’ [...]

Previous compiler versions did not complain.

v2:
 - clean solution instead of quick solution. Fix the actual API
   definition

Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/548
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8d37e64..c454c64 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -336,10 +336,10 @@
  * @param key           Buffer containing the key to use
  * @param ciphername    Ciphername of the cipher to use
  * @param enc           Whether to encrypt or decrypt (either
- *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
+ *                      \c OPENVPN_OP_ENCRYPT or \c OPENVPN_OP_DECRYPT).
  */
 void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,
-                     const char *cipername, int enc);
+                     const char *cipername, crypto_operation_t enc);
 
 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 1a39752..c230292 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -566,7 +566,7 @@
 
 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
-                const char *ciphername, const mbedtls_operation_t operation)
+                const char *ciphername, crypto_operation_t enc)
 {
     ASSERT(NULL != ciphername && NULL != ctx);
     CLEAR(*ctx);
@@ -580,7 +580,7 @@
         msg(M_FATAL, "mbed TLS cipher context init #1");
     }
 
-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, operation)))
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
     {
         msg(M_FATAL, "mbed TLS cipher set key");
     }
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 46f76e2..48d1e20 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -63,6 +63,8 @@
 /** Cipher is in GCM mode */
 #define OPENVPN_MODE_GCM        MBEDTLS_MODE_GCM
 
+typedef mbedtls_operation_t crypto_operation_t;
+
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT      MBEDTLS_ENCRYPT
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 50683b6..bfc5e37 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -840,7 +840,7 @@
 
 void
 cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key,
-                const char *ciphername, int enc)
+                const char *ciphername, crypto_operation_t enc)
 {
     ASSERT(NULL != ciphername && NULL != ctx);
     evp_cipher_type *kt = cipher_get(ciphername);
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index c0e95b4..4cd988a 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -85,6 +85,8 @@
 /** Cipher is in GCM mode */
 #define OPENVPN_MODE_GCM        EVP_CIPH_GCM_MODE
 
+typedef int crypto_operation_t;
+
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT      1
 

