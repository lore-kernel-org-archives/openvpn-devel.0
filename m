From: Shubham Mittal <smittals@...2857...>
Date: Mon, 27 Jan 2025 15:50:14 -0800
Message-ID: <20250127235014.355-1-smittals@...2857...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add compatibility to build OpenVPN with
 AWS-LC.
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

Additional context from PR on Github about changes in ssl_openssl.c around line 1900:
This change addresses a subtle behavioral difference between AWS-LC and OpenSSL regarding object ownership semantics in SSL_CTX_set_client_CA_list(ctx->ctx, cert_names).

OpenSSL Behavior:
Stores a reference to the provided cert_names stack
cert_names remains valid after SSL_CTX_set_client_CA_list

AWS-LC Behavior:
Creates a copy of the parameter cert_names (which is a stack of type X509_NAME) and converts it to a stack of CRYPTO_BUFFER (how we internally represent X509_NAME, it's an opaque byte string).
Then frees the original passed in cert_names
After SSL_CTX_set_client_CA_list, cert_names no longer points to valid memory

The proposed changes reorder operations to getting the size of the stack before the set operation as opposed to after the set operation. No operations between the setter and stack size check modify cert_names. Therefore, the logical outcome should remain the same - and this would also handle the subtle behavioral difference in AWS-LC.

URL: https://github.com/OpenVPN/openvpn/pull/672
Acked-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Shubham Mittal <smittals@...2857...>
---
 README.awslc                 | 23 +++++++++++++++++++++++
 src/openvpn/crypto_openssl.c |  7 +++++++
 src/openvpn/openssl_compat.h |  2 +-
 src/openvpn/ssl_openssl.c    | 10 +++++++---
 4 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 README.awslc

diff --git a/README.awslc b/README.awslc
new file mode 100644
index 00000000..c0ee7768
--- /dev/null
+++ b/README.awslc
@@ -0,0 +1,23 @@
+This version of OpenVPN supports AWS-LC (AWS Libcrypto), AWS's open-source cryptographic library.
+
+If you encounter bugs in OpenVPN while using AWS-LC:
+1. Try compiling OpenVPN with OpenSSL to determine if the issue is specific to AWS-LC
+2. For AWS-LC-specific issues, please report them at: https://github.com/aws/aws-lc
+
+To build and install OpenVPN with AWS-LC:
+
+    OPENSSL_CFLAGS="-I/${AWS_LC_INSTALL_FOLDER}/include" \
+    OPENSSL_LIBS="-L/${AWS_LC_INSTALL_FOLDER}/lib -lssl -lcrypto" \
+    ./configure --with-crypto-library=openssl
+    make 
+    make install
+
+    export LD_LIBRARY_PATH="${AWS_LC_INSTALL_FOLDER}/lib"
+
+When running tests, LD_LIBRARY_PATH must be passed in again: 
+
+    LD_LIBRARY_PATH="${AWS_LC_INSTALL_FOLDER}/lib" make check
+
+*************************************************************************
+Due to limitations in AWS-LC, the following features are missing
+* Windows CryptoAPI support
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 914b1c4f..070225d3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1398,6 +1398,13 @@ out:
 
     return ret;
 }
+#elif defined(OPENSSL_IS_AWSLC) 
+bool
+ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
+             int slen, uint8_t *out1, int olen)
+{
+    CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_len, NULL, 0, NULL, 0);
+}
 #elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 89f22d13..3e3b406a 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -76,7 +76,7 @@ X509_OBJECT_free(X509_OBJECT *obj)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
 
-#if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050400fL
+#if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050400fL || defined(OPENSSL_IS_AWSLC)
 #define SSL_get_peer_tmp_key SSL_get_server_tmp_key
 #endif
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 89d0328e..aad79a4b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1669,7 +1669,11 @@ tls_ctx_use_external_ec_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 
     /* Among init methods, we only need the finish method */
     EC_KEY_METHOD_set_init(ec_method, NULL, openvpn_extkey_ec_finish, NULL, NULL, NULL, NULL);
+#ifdef OPENSSL_IS_AWSLC
+    EC_KEY_METHOD_set_sign(ec_method, ecdsa_sign, NULL, ecdsa_sign_sig);
+#else
     EC_KEY_METHOD_set_sign(ec_method, ecdsa_sign, ecdsa_sign_setup, ecdsa_sign_sig);
+#endif
 
     ec = EC_KEY_dup(EVP_PKEY_get0_EC_KEY(pkey));
     if (!ec)
@@ -1895,9 +1899,10 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
-
+        int cnum;
         if (tls_server)
         {
+            cnum = sk_X509_NAME_num(cert_names);
             SSL_CTX_set_client_CA_list(ctx->ctx, cert_names);
         }
 
@@ -1910,7 +1915,6 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
         if (tls_server)
         {
-            int cnum = sk_X509_NAME_num(cert_names);
             if (cnum != added)
             {
                 crypto_msg(M_FATAL, "Cannot load CA certificate file %s (only %d "
@@ -2558,7 +2562,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if OPENSSL_VERSION_NUMBER < 0x1010000fL
+#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_AWSLC)
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
-- 
2.39.5 (Apple Git-154)


