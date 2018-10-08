From: Arne Schwabe <arne@...1227...>
Date: Mon,  8 Oct 2018 23:49:23 +0200
Message-Id: <20181008214923.11058-3-arne@...1227...>
In-Reply-To: <20181008214923.11058-1-arne@...1227...>
References: <20181008214923.11058-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 3/3] Implement the nopadding option to
 management-external-key for mbed TLS
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

Although mbed TLS does not have a TLS 1.3 API yet and we do not really
know how mbed TLS will handle querying for TLS 1.3 signatures, being
able to use the same API with OpenSSL and mbed TLS is a nice feature.

Since mbed TLS does not expose a way to do pkcs1 padding, copy the
trimmed down version of the pkcs1 copy to the OpenVPN source code.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c     | 11 ++----
 src/openvpn/ssl_mbedtls.c | 72 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61762791..fb7d8333 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3025,11 +3025,11 @@ options_postprocess_verify(const struct options *o)
     }
 }
 
-#if defined(ENABLE_CRYPTOAPI) || (defined(ENABLE_CRYPTO_OPENSSL) && defined(ENABLE_MANAGEMENT))
+#if defined(ENABLE_CRYPTOAPI) || defined(ENABLE_MANAGEMENT)
 static void
 disable_tls13_if_avilable(struct options *o, const char* msg)
 {
-#if OPENSSL_VERSION_NUMBER >= 0x10100000L
+#if OPENSSL_VERSION_NUMBER >= 0x10100000L && !defined(ENABLE_CRYPTO_MBEDTLS)
     const int tls_version_max =
         (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
             SSLF_TLS_VERSION_MAX_MASK;
@@ -3134,13 +3134,6 @@ options_postprocess_mutate(struct options *o)
     }
 #endif
 
-#if defined(ENABLE_CRYPTO_MBEDTLS) && defined(MANAGMENT_EXTERNAL_KEY)
-    if (o->management_flags & MF_EXTERNAL_KEY_NOPADDING)
-    {
-        msg(M_FATAL, "mbed TLS does not support the 'nopadding' argument for the --management-external-key option");
-    }
-#endif
-
 #if defined(ENABLE_CRYPTOAPI)
     if (o->cryptoapi_cert)
     {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 6b4ddaf4..3e97a329 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -619,6 +619,59 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
 }
 
 #ifdef ENABLE_MANAGEMENT
+/*
+ * Construct a PKCS v1.5 encoding of a hashed message.
+ *
+ * Taken and trimmed down version (only MBEDTLS_MD_NONE) of
+ * rsa_rsassa_pkcs1_v15_encode from mbedTLS 2.13.1 (53546ea0)
+ *
+ * This is used both for signature generation and verification.
+ *
+ * Parameters:
+ * - hashlen: Length of hash in case hashlen is MBEDTLS_MD_NONE.
+ * - hash:    Buffer containing the hashed message or the raw data.
+ * - dst_len: Length of the encoded message.
+ * - dst:     Buffer to hold the encoded message.
+ *
+ * Assumptions:
+ * - hash has size hashlen
+  * - dst points to a buffer of size at least dst_len.
+ *
+ */
+static int rsa_pkcs1_v15_pad(size_t hashlen, const unsigned char *hash,
+                             size_t dst_len, unsigned char *dst)
+{
+    size_t nb_pad    = dst_len;
+    unsigned char *p = dst;
+
+    if (nb_pad < hashlen)
+        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
+
+    nb_pad -= hashlen;
+
+
+    /* Need space for signature header and padding delimiter (3 bytes),
+     * and 8 bytes for the minimal padding */
+    if (nb_pad < 3 + 8)
+    {
+        return (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);
+    }
+    nb_pad -= 3;
+
+    /* Now nb_pad is the amount of memory to be filled
+     * with padding, and at least 8 bytes long. */
+
+    /* Write signature header and padding */
+    *p++ = 0;
+    *p++ = MBEDTLS_RSA_SIGN;
+    memset(p, 0xFF, nb_pad);
+    p += nb_pad;
+    *p++ = 0;
+
+    /* we are signing raw data? */
+    memcpy(p, hash, hashlen);
+    return 0;
+}
 
 /** Query the management interface for a signature, see external_sign_func. */
 static bool
@@ -629,7 +682,24 @@ management_sign_func(void *sign_ctx, const void *src, size_t src_len,
     char *src_b64 = NULL;
     char *dst_b64 = NULL;
 
-    if (!management || (openvpn_base64_encode(src, src_len, &src_b64) <= 0))
+
+    if (!management)
+    {
+        goto cleanup;
+    }
+    if (management->settings.flags & MF_EXTERNAL_KEY_NOPADDING)
+    {
+        /*
+         * Add PKCS1 signature and replace input with it
+         * Use our output buffer also als temporary buffer
+         */
+        if ((!mbed_ok(rsa_pkcs1_v15_pad(src_len, src, dst_len, dst)))
+            || (openvpn_base64_encode(dst, dst_len, &src_b64) <= 0 ))
+        {
+            goto cleanup;
+        }
+    }
+    else if (openvpn_base64_encode(src, src_len, &src_b64) <= 0)
     {
         goto cleanup;
     }
-- 
2.19.0


