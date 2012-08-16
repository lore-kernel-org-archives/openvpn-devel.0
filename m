From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:21 +0200
Message-ID: <1345106302-22850-7-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/7] do MACs using EVP_MD_CTX with openssl
	>= 1.0.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Using EVP_MD_CTX for MAC calculation allows to use other algorithms
than HMAC. In this particular case it allows the GOST-MAC to be used.
GOST-MAC uses a 256 bit key and produces a 32 bit signature.

Unfortunately OpenSSL has no API for querying a MAC's key length, so
the key length is returned statically in the case of GOST-MAC.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/crypto_openssl.c |   62 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.h |    4 +++
 2 files changed, 66 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5665e29..b5f3cef 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -714,6 +714,66 @@ md_ctx_final (EVP_MD_CTX *ctx, uint8_t *dst)
  *
  */
 
+#if SSLEAY_VERSION_NUMBER >= 0x10000000L
+
+int
+hmac_key_size (const EVP_MD *kt)
+{
+  if (NULL == kt)
+    return 0;
+  return (EVP_MD_type (kt) == NID_id_Gost28147_89_MAC ? 32 : md_kt_size (kt));
+}
+
+void
+hmac_ctx_init (EVP_MD_CTX *ctx, const uint8_t *key, int key_len,
+    const EVP_MD *kt)
+{
+  int pkey_id;
+
+  ASSERT (NULL != kt && NULL != ctx);
+
+  pkey_id = ( EVP_MD_type (kt) == NID_id_Gost28147_89_MAC
+              ? NID_id_Gost28147_89_MAC : EVP_PKEY_HMAC );
+
+  EVP_MD_CTX_init (ctx);
+  EVP_DigestSignInit (ctx, NULL, kt, NULL,
+              EVP_PKEY_new_mac_key (pkey_id, NULL, (uint8_t *)key, key_len));
+}
+
+void
+hmac_ctx_cleanup (EVP_MD_CTX *ctx)
+{
+  /* frees the key implicitly */
+  EVP_MD_CTX_cleanup (ctx);
+}
+
+int
+hmac_ctx_size (const EVP_MD_CTX *ctx)
+{
+  return EVP_MD_CTX_size (ctx);
+}
+
+void
+hmac_ctx_reset (EVP_MD_CTX *ctx)
+{
+  EVP_DigestInit_ex (ctx, EVP_MD_CTX_md (ctx), NULL);
+}
+
+void
+hmac_ctx_update (EVP_MD_CTX *ctx, const uint8_t *src, int src_len)
+{
+  EVP_DigestSignUpdate (ctx, src, src_len);
+}
+
+void
+hmac_ctx_final (EVP_MD_CTX *ctx, uint8_t *dst)
+{
+  size_t mac_len = hmac_ctx_size (ctx);
+  EVP_DigestSignFinal (ctx, dst, &mac_len);
+}
+
+#else /* SSLEAY_VERSION_NUMBER >= 0x10000000L */
+
 int
 hmac_key_size (const EVP_MD *kt)
 {
@@ -769,4 +829,6 @@ hmac_ctx_final (HMAC_CTX *ctx, uint8_t *dst)
   HMAC_Final (ctx, dst, &in_hmac_len);
 }
 
+#endif /* SSLEAY_VERSION_NUMBER >= 0x10000000L */
+
 #endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index f883c2a..d7c9dd8 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -47,7 +47,11 @@ typedef EVP_CIPHER_CTX cipher_ctx_t;
 typedef EVP_MD_CTX md_ctx_t;
 
 /** Generic HMAC %context. */
+#if OPENSSL_VERSION_NUMBER >= 0x10000000L
+typedef EVP_MD_CTX hmac_ctx_t;
+#else
 typedef HMAC_CTX hmac_ctx_t;
+#endif
 
 /** Maximum length of an IV */
 #define OPENVPN_MAX_IV_LENGTH 	EVP_MAX_IV_LENGTH
-- 
1.7.9.5


