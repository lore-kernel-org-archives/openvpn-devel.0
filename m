Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Mon, 12 Jun 2017 15:43:23 +0200
Message-Id: <20170612134330.20971-2-logout@...260...>
In-Reply-To: <20170612134330.20971-1-logout@...260...>
References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
Subject: [Openvpn-devel] [PATCH 1/8] OpenSSL: don't use direct access to the
 internal of X509
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

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including X509. We have to use the defined
functions to do so.

In x509_verify_ns_cert_type() in particular, this means that we
cannot directly check for the extended flags to find whether the
certificate should be used as a client or as a server certificate.
We need to leverage the X509_check_purpose() API yet this API is
far stricter than the currently implemented check. So far, I have
not been able to find a situation where this stricter test fails
(although I must admit that I haven't tested that very well).

We double-check the certificate purpose using "direct access" to the
internal of the certificate object (of course, this is not a real
direct access, but we still fetch ASN1 strings within the X509 object
and we check the internal value of these strings). This allow us to
warn the user if there is a discrepancy between the X509_check_purpose()
return value and our internal, less strict check.

We use these changes to make peer_cert a non-const parameter to
x509_verify_ns_cert_type(). The underlying library waits for a
non-const pointer, and forcing it to be a const pointer does not make
much sense (please note that this has an effect on the mbedtls part
too).

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                     |  1 +
 src/openvpn/openssl_compat.h     | 15 +++++++++
 src/openvpn/ssl_openssl.c        |  3 +-
 src/openvpn/ssl_verify_backend.h |  2 +-
 src/openvpn/ssl_verify_mbedtls.c |  2 +-
 src/openvpn/ssl_verify_openssl.c | 68 ++++++++++++++++++++++++++++++++++------
 6 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7d3fce5b..9d5e340b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -922,6 +922,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		[ \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
+			X509_get0_pubkey \
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
 			X509_OBJECT_get_type \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 92f014d5..29a7588c 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -74,6 +74,21 @@ SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
 }
 #endif
 
+#if !defined(HAVE_X509_GET0_PUBKEY)
+/**
+ * Get the public key from a X509 certificate
+ *
+ * @param x                  X509 certificate
+ * @return                   The certificate public key
+ */
+static inline EVP_PKEY *
+X509_get0_pubkey(const X509 *x)
+{
+    return (x && x->cert_info && x->cert_info->key) ?
+           x->cert_info->key->pkey : NULL;
+}
+#endif
+
 #if !defined(HAVE_X509_STORE_GET0_OBJECTS)
 /**
  * Fetch the X509 object stack from the X509 store
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 645ccf51..a082c3cd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1070,7 +1070,8 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     }
 
     /* get the public key */
-    ASSERT(cert->cert_info->key->pkey); /* NULL before SSL_CTX_use_certificate() is called */
+    EVP_PKEY *pkey = X509_get0_pubkey(cert);
+    ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
     pub_rsa = cert->cert_info->key->pkey->pkey.rsa;
 
     /* initialize RSA object */
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index c4330ba3..7e72ed30 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -211,7 +211,7 @@ void x509_setenv_track(const struct x509_track *xt, struct env_set *es,
  *                      the expected bit set. \c FAILURE if the certificate does
  *                      not have NS cert type verification or the wrong bit set.
  */
-result_t x509_verify_ns_cert_type(const openvpn_x509_cert_t *cert, const int usage);
+result_t x509_verify_ns_cert_type(openvpn_x509_cert_t *cert, const int usage);
 
 /*
  * Verify X.509 key usage extension field.
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c32e4815..c36393a8 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -411,7 +411,7 @@ x509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
 }
 
 result_t
-x509_verify_ns_cert_type(const mbedtls_x509_crt *cert, const int usage)
+x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)
 {
     if (usage == NS_CERT_CHECK_NONE)
     {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 9b1533bc..7d5fcfb1 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -294,18 +294,20 @@ backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
 struct buffer
 x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)
 {
-    struct buffer hash = alloc_buf_gc(sizeof(cert->sha1_hash), gc);
-    memcpy(BPTR(&hash), cert->sha1_hash, sizeof(cert->sha1_hash));
-    ASSERT(buf_inc_len(&hash, sizeof(cert->sha1_hash)));
+    const EVP_MD *sha1 = EVP_sha1();
+    struct buffer hash = alloc_buf_gc(EVP_MD_size(sha1), gc);
+    X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
+    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));
     return hash;
 }
 
 struct buffer
 x509_get_sha256_fingerprint(X509 *cert, struct gc_arena *gc)
 {
-    struct buffer hash = alloc_buf_gc((EVP_sha256())->md_size, gc);
+    const EVP_MD *sha256 = EVP_sha256();
+    struct buffer hash = alloc_buf_gc(EVP_MD_size(sha256), gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, (EVP_sha256())->md_size));
+    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha256)));
     return hash;
 }
 
@@ -570,7 +572,7 @@ x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)
 }
 
 result_t
-x509_verify_ns_cert_type(const openvpn_x509_cert_t *peer_cert, const int usage)
+x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)
 {
     if (usage == NS_CERT_CHECK_NONE)
     {
@@ -578,13 +580,59 @@ x509_verify_ns_cert_type(const openvpn_x509_cert_t *peer_cert, const int usage)
     }
     if (usage == NS_CERT_CHECK_CLIENT)
     {
-        return ((peer_cert->ex_flags & EXFLAG_NSCERT)
-                && (peer_cert->ex_nscert & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
+        /*
+         * Unfortunately, X509_check_purpose() does some wierd thing that
+         * prevent it to take a const argument
+         */
+        result_t result = X509_check_purpose(peer_cert, X509_PURPOSE_SSL_CLIENT, 0) ?
+	       SUCCESS : FAILURE;
+
+        /*
+         * old versions of OpenSSL allow us to make the less strict check we used to
+         * do. If this less strict check pass, warn user that this might not be the
+         * case when its distribution will update to OpenSSL 1.1
+         */
+        if (result == FAILURE)
+        {
+            ASN1_BIT_STRING *ns;
+            ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
+            result = (ns && ns->length > 0 && (ns->data[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
+            if (result == SUCCESS)
+            {
+                msg(M_WARN, "X509: Certificate is a client certificate yet it's purpose "
+                    "cannot be verified (check may fail in the future)");
+            }
+            ASN1_BIT_STRING_free(ns);
+        }
+        return result;
     }
     if (usage == NS_CERT_CHECK_SERVER)
     {
-        return ((peer_cert->ex_flags & EXFLAG_NSCERT)
-                && (peer_cert->ex_nscert & NS_SSL_SERVER))  ? SUCCESS : FAILURE;
+        /*
+         * Unfortunately, X509_check_purpose() does some wierd thing that
+         * prevent it to take a const argument
+         */
+        result_t result = X509_check_purpose(peer_cert, X509_PURPOSE_SSL_SERVER, 0) ?
+	       SUCCESS : FAILURE;
+
+        /*
+         * old versions of OpenSSL allow us to make the less strict check we used to
+         * do. If this less strict check pass, warn user that this might not be the
+         * case when its distribution will update to OpenSSL 1.1
+         */
+        if (result == FAILURE)
+        {
+            ASN1_BIT_STRING *ns;
+            ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
+            result = (ns && ns->length > 0 && (ns->data[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
+            if (result == SUCCESS)
+            {
+                msg(M_WARN, "X509: Certificate is a server certificate yet it's purpose "
+                    "cannot be verified (check may fail in the future)");
+            }
+            ASN1_BIT_STRING_free(ns);
+        }
+        return result;
     }
 
     return FAILURE;
-- 
2.11.0


