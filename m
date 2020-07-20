From: Arne Schwabe <arne@...1227...>
Date: Mon, 20 Jul 2020 14:17:04 +0200
Message-Id: <20200720121704.20333-1-arne@...1227...>
In-Reply-To: <E1jxUNh-0007hr-Bd@...2479...>
References: <E1jxUNh-0007hr-Bd@...2479...>
Subject: [Openvpn-devel] [PATCH v3] Require AEAD support in the crypto
 library
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

All supported crypto libraries have AEAD support and with our
ncp/de facto default cipher AES-256-GCM we do not want to support
the obscure corner case of a library with disabled AEAD.

Signed-off-by: Arne Schwabe <arne@...1227...>

Patch V2: Remove three instances of (harmless) #ifdef Steffan spotted
          that can be removed now too.
---
 config-msvc.h                |  1 -
 configure.ac                 |  7 ++-----
 src/openvpn/crypto.c         | 11 -----------
 src/openvpn/crypto_mbedtls.c | 14 --------------
 src/openvpn/crypto_openssl.c | 26 ++------------------------
 src/openvpn/crypto_openssl.h |  4 ----
 src/openvpn/options.c        |  6 ------
 7 files changed, 4 insertions(+), 65 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 875da4a6..8ef48979 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -5,7 +5,6 @@
 #define ENABLE_DEF_AUTH 1
 #define ENABLE_PF 1
 #define ENABLE_CRYPTO_OPENSSL 1
-#define HAVE_AEAD_CIPHER_MODES 1
 #define ENABLE_DEBUG 1
 #define ENABLE_EUREPHIA 1
 #define ENABLE_FRAGMENT 1
diff --git a/configure.ac b/configure.ac
index d1db0a21..43f78fb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -907,11 +907,10 @@ if test "${with_crypto_library}" = "openssl"; then
 		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
 	fi
 
-	have_crypto_aead_modes="yes"
 	AC_CHECK_FUNC(
 		[EVP_aes_256_gcm],
 		,
-		[have_crypto_aead_modes="no"]
+		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)
 
     # All supported OpenSSL version (>= 1.0.2)
@@ -1005,14 +1004,13 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 		[AC_MSG_ERROR([mbed TLS 2.y.z required])]
 	)
 
-	have_crypto_aead_modes="yes"
 	AC_CHECK_FUNCS(
 		[ \
 			mbedtls_cipher_write_tag \
 			mbedtls_cipher_check_tag \
 		],
 		,
-		[have_crypto_aead_modes="no"; break]
+		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]
 	)
 
 	have_export_keying_material="yes"
@@ -1227,7 +1225,6 @@ test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal pack
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
-test "${have_crypto_aead_modes}" = "yes" && AC_DEFINE([HAVE_AEAD_CIPHER_MODES], [1], [Use crypto library])
 if test "${have_export_keying_material}" = "yes"; then
 	AC_DEFINE(
 		[HAVE_EXPORT_KEYING_MATERIAL], [1],
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index bbf47ef7..e92a0dc1 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -64,7 +64,6 @@ static void
 openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
                      struct crypto_options *opt)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     struct gc_arena gc;
     int outlen = 0;
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
@@ -152,9 +151,6 @@ err:
     buf->len = 0;
     gc_free(&gc);
     return;
-#else /* HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-#endif /* ifdef HAVE_AEAD_CIPHER_MODES */
 }
 
 static void
@@ -361,7 +357,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
                      struct crypto_options *opt, const struct frame *frame,
                      const uint8_t *ad_start)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     static const char error_prefix[] = "AEAD Decrypt error";
     struct packet_id_net pin = { 0 };
     const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
@@ -482,10 +477,6 @@ error_exit:
     buf->len = 0;
     gc_free(&gc);
     return false;
-#else /* HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-    return false;
-#endif /* ifdef HAVE_AEAD_CIPHER_MODES */
 }
 
 /*
@@ -1104,7 +1095,6 @@ test_crypto(struct crypto_options *co, struct frame *frame)
     /* init work */
     ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
 
-#ifdef HAVE_AEAD_CIPHER_MODES
     /* init implicit IV */
     {
         const cipher_kt_t *cipher =
@@ -1126,7 +1116,6 @@ test_crypto(struct crypto_options *co, struct frame *frame)
             co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
         }
     }
-#endif /* ifdef HAVE_AEAD_CIPHER_MODES */
 
     msg(M_INFO, "Entering " PACKAGE_NAME " crypto self-test mode.");
     for (i = 1; i <= TUN_MTU_SIZE(frame); ++i)
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index bb752557..19a87eb4 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -530,12 +530,10 @@ cipher_kt_block_size(const mbedtls_cipher_info_t *cipher_kt)
 int
 cipher_kt_tag_size(const mbedtls_cipher_info_t *cipher_kt)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     if (cipher_kt && cipher_kt_mode_aead(cipher_kt))
     {
         return OPENVPN_AEAD_TAG_LENGTH;
     }
-#endif
     return 0;
 }
 
@@ -632,7 +630,6 @@ cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)
 int
 cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     if (tag_len > SIZE_MAX)
     {
         return 0;
@@ -644,9 +641,6 @@ cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
     }
 
     return 1;
-#else  /* ifdef HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-#endif /* HAVE_AEAD_CIPHER_MODES */
 }
 
 int
@@ -688,7 +682,6 @@ cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)
 int
 cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     if (src_len > SIZE_MAX)
     {
         return 0;
@@ -700,9 +693,6 @@ cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
     }
 
     return 1;
-#else  /* ifdef HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-#endif /* HAVE_AEAD_CIPHER_MODES */
 }
 
 int
@@ -741,7 +731,6 @@ int
 cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst,
                            int *dst_len, uint8_t *tag, size_t tag_len)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     size_t olen = 0;
 
     if (MBEDTLS_DECRYPT != ctx->operation)
@@ -773,9 +762,6 @@ cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst,
     }
 
     return 1;
-#else  /* ifdef HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-#endif /* HAVE_AEAD_CIPHER_MODES */
 }
 
 void
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 161a189e..c47c2f3c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -301,9 +301,7 @@ show_available_ciphers(void)
 #ifdef ENABLE_OFB_CFB_MODE
                        || cipher_kt_mode_ofb_cfb(cipher)
 #endif
-#ifdef HAVE_AEAD_CIPHER_MODES
                        || cipher_kt_mode_aead(cipher)
-#endif
                        ))
         {
             cipher_list[num_ciphers++] = cipher;
@@ -710,11 +708,8 @@ bool
 cipher_kt_mode_cbc(const cipher_kt_t *cipher)
 {
     return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
-#ifdef EVP_CIPH_FLAG_AEAD_CIPHER
            /* Exclude AEAD cipher modes, they require a different API */
-           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER)
-#endif
-    ;
+           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
 }
 
 bool
@@ -722,17 +717,13 @@ cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
 {
     return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
                       || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB)
-#ifdef EVP_CIPH_FLAG_AEAD_CIPHER
            /* Exclude AEAD cipher modes, they require a different API */
-           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER)
-#endif
-    ;
+           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
 }
 
 bool
 cipher_kt_mode_aead(const cipher_kt_t *cipher)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     if (cipher)
     {
         switch (EVP_CIPHER_nid(cipher))
@@ -746,7 +737,6 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
                 return true;
         }
     }
-#endif
 
     return false;
 }
@@ -806,11 +796,7 @@ cipher_ctx_iv_length(const EVP_CIPHER_CTX *ctx)
 int
 cipher_ctx_get_tag(EVP_CIPHER_CTX *ctx, uint8_t *tag_buf, int tag_size)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     return EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_GET_TAG, tag_size, tag_buf);
-#else
-    ASSERT(0);
-#endif
 }
 
 int
@@ -841,16 +827,12 @@ cipher_ctx_reset(EVP_CIPHER_CTX *ctx, const uint8_t *iv_buf)
 int
 cipher_ctx_update_ad(EVP_CIPHER_CTX *ctx, const uint8_t *src, int src_len)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     int len;
     if (!EVP_CipherUpdate(ctx, NULL, &len, src, src_len))
     {
         crypto_msg(M_FATAL, "%s: EVP_CipherUpdate() failed", __func__);
     }
     return 1;
-#else  /* ifdef HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-#endif
 }
 
 int
@@ -874,7 +856,6 @@ int
 cipher_ctx_final_check_tag(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
                            uint8_t *tag, size_t tag_len)
 {
-#ifdef HAVE_AEAD_CIPHER_MODES
     ASSERT(tag_len < SIZE_MAX);
     if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_SET_TAG, tag_len, tag))
     {
@@ -882,9 +863,6 @@ cipher_ctx_final_check_tag(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
     }
 
     return cipher_ctx_final(ctx, dst, dst_len);
-#else  /* ifdef HAVE_AEAD_CIPHER_MODES */
-    ASSERT(0);
-#endif
 }
 
 void
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 4694ee08..e6f8f537 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -61,13 +61,9 @@ typedef HMAC_CTX hmac_ctx_t;
 /** Cipher is in CFB mode */
 #define OPENVPN_MODE_CFB        EVP_CIPH_CFB_MODE
 
-#ifdef HAVE_AEAD_CIPHER_MODES
-
 /** Cipher is in GCM mode */
 #define OPENVPN_MODE_GCM        EVP_CIPH_GCM_MODE
 
-#endif /* HAVE_AEAD_CIPHER_MODES */
-
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT      1
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 04518bf5..94308a8e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -104,9 +104,7 @@ const char title_string[] =
     " [MH/RECVDA]"
 #endif
 #endif
-#ifdef HAVE_AEAD_CIPHER_MODES
     " [AEAD]"
-#endif
     " built on " __DATE__
 ;
 
@@ -871,11 +869,7 @@ init_options(struct options *o, const bool init_gc)
     o->scheduled_exit_interval = 5;
 #endif
     o->ciphername = "BF-CBC";
-#ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */
     o->ncp_enabled = true;
-#else
-    o->ncp_enabled = false;
-#endif
     o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
     o->authname = "SHA1";
     o->prng_hash = "SHA1";
-- 
2.26.2


