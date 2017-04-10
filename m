From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 10 Apr 2017 11:15:55 +0200
Message-ID: <1491815755-17637-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add --tls-cert-profile option for mbedtls
	builds
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

This allows the user to specify what certificate crypto algorithms to
support.  The supported profiles are 'preferred' (default), 'legacy' and
'suiteb', as discussed in <84590a17-1c48-9df2-c48e-4160750b2e33@...1435...>
(https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14214.html).

This only implements the feature for mbed TLS builds, because for mbed it
is both more easy to implement and the most relevant because mbed TLS 2+
is by default somewhat restrictive by requiring 2048-bit+ for RSA keys.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/options.c     |  8 ++++++++
 src/openvpn/options.h     |  1 +
 src/openvpn/ssl.c         |  3 +++
 src/openvpn/ssl_backend.h | 10 ++++++++++
 src/openvpn/ssl_mbedtls.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_mbedtls.h |  1 +
 src/openvpn/ssl_openssl.c |  6 ++++++
 7 files changed, 80 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9fef394..7142243 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -873,6 +873,7 @@ init_options(struct options *o, const bool init_gc)
     o->renegotiate_seconds = 3600;
     o->handshake_window = 60;
     o->transition_window = 3600;
+    o->tls_cert_profile = "preferred";
     o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
     o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
@@ -1752,6 +1753,7 @@ show_settings(const struct options *o)
     SHOW_STR(cryptoapi_cert);
 #endif
     SHOW_STR(cipher_list);
+    SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
     SHOW_STR(tls_export_cert);
     SHOW_INT(verify_x509_type);
@@ -2734,6 +2736,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(pkcs12_file);
 #endif
         MUST_BE_UNDEF(cipher_list);
+        MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
         MUST_BE_UNDEF(tls_export_cert);
         MUST_BE_UNDEF(verify_x509_name);
@@ -7813,6 +7816,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cipher_list = p[1];
     }
+    else if (streq(p[0], "tls-cert-profile") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_cert_profile = p[1];
+    }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b3ab029..9085413 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -500,6 +500,7 @@ struct options
     const char *priv_key_file;
     const char *pkcs12_file;
     const char *cipher_list;
+    const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
     int verify_x509_type;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1033e58..72dbec3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -702,6 +702,9 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     /* Allowable ciphers */
     tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
 
+    /* Restrict allowed certificate crypto algorithms */
+    tls_ctx_set_cert_profile(new_ctx, options->tls_cert_profile);
+
 #ifdef ENABLE_CRYPTO_MBEDTLS
     /* Personalise the random by mixing in the certificate */
     tls_ctx_personalise_random(new_ctx);
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 206400f..3b14908 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -178,6 +178,16 @@ void tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags);
 void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers);
 
 /**
+ * Set the TLS certificate profile.  The profile defines which crypto
+ * algorithms may be used in the supplied certificate.
+ *
+ * @param ctx           TLS context to restrict, must be valid.
+ * @param profile       The profile name ('preferred', 'legacy' or 'suiteb').
+ *                      May NOT be NULL.
+ */
+void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile);
+
+/**
  * Check our certificate notBefore and notAfter fields, and warn if the cert is
  * either not yet valid or has expired.  Note that this is a non-fatal error,
  * since we compare against the system time, which might be incorrect.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ba8dadf..1fcee72 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -63,6 +63,34 @@
 #include <mbedtls/pem.h>
 #include <mbedtls/sha256.h>
 
+static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
+{
+    /* Hashes from SHA-1 and above */
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    0xFFFFFFF, /* Any PK alg    */
+    0xFFFFFFF, /* Any curve     */
+    1024,      /* RSA-1024 and larger */
+};
+
+static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_preferred =
+{
+    /* SHA-2 and above */
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    0xFFFFFFF, /* Any PK alg    */
+    0xFFFFFFF, /* Any curve     */
+    2048,      /* RSA-2048 and larger */
+};
+
+#define openvpn_x509_crt_profile_suiteb mbedtls_x509_crt_profile_suiteb;
+
 void
 tls_init_lib()
 {
@@ -252,6 +280,27 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
+tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
+{
+    if (0 == strcmp(profile, "preferred"))
+    {
+        ctx->cert_profile = openvpn_x509_crt_profile_preferred;
+    }
+    else if (0 == strcmp(profile, "legacy"))
+    {
+        ctx->cert_profile = openvpn_x509_crt_profile_legacy;
+    }
+    else if (0 == strcmp(profile, "suiteb"))
+    {
+        ctx->cert_profile = openvpn_x509_crt_profile_suiteb;
+    }
+    else
+    {
+        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
+    }
+}
+
+void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
     ASSERT(ctx);
@@ -918,6 +967,8 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     mbedtls_ssl_conf_rng(&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
                          rand_ctx_get());
 
+    mbedtls_ssl_conf_cert_profile(&ks_ssl->ssl_config, &ssl_ctx->cert_profile);
+
     if (ssl_ctx->allowed_ciphers)
     {
         mbedtls_ssl_conf_ciphersuites(&ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index d8f717c..0a4ad17 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -83,6 +83,7 @@ struct tls_root_ctx {
     struct external_context *external_key; /**< Management external key */
 #endif
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
+    mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
 };
 
 struct key_state_ssl {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d7cc2ba..348b83a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -384,6 +384,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
+tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
+{
+    msg (M_WARN, "WARNING: --tls-cert-profile not supported for OpenSSL");
+}
+
+void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
     int ret;
-- 
2.7.4


