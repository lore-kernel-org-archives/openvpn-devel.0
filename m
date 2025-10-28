From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 19:57:01 +0100
Message-ID: <20251028185706.1247-1-gert@...1296...>
In-Reply-To: <gerrit.1760967063000.I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a@...2715...>
References: <gerrit.1760967063000.I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] crypto_backend: Change len argument of
 md_ctx_update to size_t
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

From: Frank Lichtenheld <frank@...2641...>

The underlying APIs already use size_t and all the
users (only httpdigest and push) already put size_t
into it. So avoid conversion warnings.

Also fix one trivial conversion warning in push.c
to able to easily remove the -Wconversion override
from the affected code paths.

Change-Id: I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1287
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1287
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4d6a96c..e95752a 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -599,7 +599,7 @@
  * @param src           Buffer to digest. May not be NULL.
  * @param src_len       The length of the incoming buffer.
  */
-void md_ctx_update(md_ctx_t *ctx, const uint8_t *src, int src_len);
+void md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len);
 
 /*
  * Output the message digest to the given buffer.
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 076d4ee..2e328c3 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -765,6 +765,10 @@
     return 1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  *
  * Generic message digest information functions
@@ -877,7 +881,7 @@
 }
 
 void
-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len)
 {
     ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
 }
@@ -994,6 +998,11 @@
                                        seed_len, output, output_len));
 }
 #else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1122,10 +1131,10 @@
     gc_free(&gc);
     return true;
 }
-#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 
 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f596b8c..ec0269c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1165,7 +1165,7 @@
 }
 
 void
-md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, int src_len)
+md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)
 {
     EVP_DigestUpdate(ctx, src, src_len);
 }
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index f665b17..be20638 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -61,11 +61,6 @@
     Hex[HASHHEXLEN] = '\0';
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* calculate H(A1) as per spec */
 void
 DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,
@@ -150,8 +145,4 @@
     CvtHex(RespHash, Response);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* if PROXY_DIGEST_AUTH */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2c717c7..6f146fc 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -772,6 +772,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 send_push_reply_auth_token(struct tls_multi *multi)
 {
@@ -1046,7 +1050,7 @@
                             unsigned int *option_types_found, struct buffer *buf)
 {
     int ret = PUSH_MSG_ERROR;
-    const uint8_t ch = buf_read_u8(buf);
+    const int ch = buf_read_u8(buf);
     if (ch == ',')
     {
         struct buffer buf_orig = (*buf);
@@ -1090,10 +1094,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
                           bool honor_received_options, unsigned int permission_mask,

