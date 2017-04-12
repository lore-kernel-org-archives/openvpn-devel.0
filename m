From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 12 Apr 2017 13:35:24 +0200
Message-ID: <1491996924-24576-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
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
v2:
 - add documentation (manpage, Changes.rst and --help)
 - no longer print a warning message on each startup for OpenSSL builds

 Changes.rst               | 28 +++++++++++++++-----------
 doc/openvpn.8             | 19 ++++++++++++++++++
 src/openvpn/options.c     | 14 ++++++++++++-
 src/openvpn/options.h     |  1 +
 src/openvpn/ssl.c         |  3 +++
 src/openvpn/ssl_backend.h | 10 ++++++++++
 src/openvpn/ssl_mbedtls.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_mbedtls.h |  1 +
 src/openvpn/ssl_openssl.c |  6 ++++++
 9 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 2a94990..ffd4ac3 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -306,15 +306,19 @@ Maintainer-visible changes
 
 Version 2.4.1
 =============
- - ``--remote-cert-ku`` now only requires the certificate to have at least the
-   bits set of one of the values in the supplied list, instead of requiring an
-   exact match to one of the values in the list.
- - ``--remote-cert-tls`` now only requires that a keyUsage is present in the
-   certificate, and leaves the verification of the value up to the crypto
-   library, which has more information (i.e. the key exchange method in use)
-   to verify that the keyUsage is correct.
- - ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
-   The nsCertType x509 extension is very old, and barely used.
-   ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
-   extension instead.  Make sure your certificates carry these to be able to
-   use ``--remote-cert-tls``.
+- ``--remote-cert-ku`` now only requires the certificate to have at least the
+  bits set of one of the values in the supplied list, instead of requiring an
+  exact match to one of the values in the list.
+- ``--remote-cert-tls`` now only requires that a keyUsage is present in the
+  certificate, and leaves the verification of the value up to the crypto
+  library, which has more information (i.e. the key exchange method in use)
+  to verify that the keyUsage is correct.
+- ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
+  The nsCertType x509 extension is very old, and barely used.
+  ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
+  extension instead.  Make sure your certificates carry these to be able to
+  use ``--remote-cert-tls``.
+- The new option ``--tls-cert-profile`` can be used to restrict the set of
+  allowed crypto algorithms in TLS certificates in mbed TLS builds.  The
+  'legacy' profile can be used to re-enable support for SHA1 and 1024-bit RSA
+  keys.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index c3248fd..1e46abe 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4878,6 +4878,25 @@ when using PolarSSL or
 OpenSSL.
 .\"*********************************************************
 .TP
+.B \-\-tls\-cert\-profile profile
+Set the allowed cryptographic algorithms for certificates according to
+.B profile\fN.
+
+The following profiles are supported:
+
+.B preferred
+(default): SHA2 and newer, RSA 2048-bit+, any elliptic curve.
+
+.B legacy
+: SHA1 and newer, RSA 2048-bit+, any elliptic curve.
+
+.B suiteb
+: SHA256/SHA384, ECDSA with P-256 or P-384.
+
+This option is only supported for mbed TLS builds.  OpenSSL builds accept any
+certificate that OpenSSL accepts.
+.\"*********************************************************
+.TP
 .B \-\-tls\-timeout n
 Packet retransmit timeout on TLS control channel
 if no acknowledgment from remote within
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dcb6ecf..c6fb2c8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -598,6 +598,8 @@ static const char usage_message[] =
 #endif
     "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
     "                : Use --show-tls to see a list of supported TLS ciphers.\n"
+    "--tls-cert-profile p : Set the allowed certificate crypto algorithm profile\n"
+    "                  (default=%s).\n"
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"
@@ -871,6 +873,7 @@ init_options(struct options *o, const bool init_gc)
     o->renegotiate_seconds = 3600;
     o->handshake_window = 60;
     o->transition_window = 3600;
+    o->tls_cert_profile = "preferred";
     o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
     o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
@@ -1749,6 +1752,7 @@ show_settings(const struct options *o)
     SHOW_STR(cryptoapi_cert);
 #endif
     SHOW_STR(cipher_list);
+    SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
     SHOW_STR(tls_export_cert);
     SHOW_INT(verify_x509_type);
@@ -2723,6 +2727,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(pkcs12_file);
 #endif
         MUST_BE_UNDEF(cipher_list);
+        MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
         MUST_BE_UNDEF(tls_export_cert);
         MUST_BE_UNDEF(verify_x509_name);
@@ -4074,7 +4079,7 @@ usage(void)
             o.verbosity,
             o.authname, o.ciphername,
             o.replay_window, o.replay_time,
-            o.tls_timeout, o.renegotiate_seconds,
+            o.tls_cert_profile, o.tls_timeout, o.renegotiate_seconds,
             o.handshake_window, o.transition_window);
 #else  /* ifdef ENABLE_CRYPTO */
     fprintf(fp, usage_message,
@@ -7797,6 +7802,13 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cipher_list = p[1];
     }
+#ifdef ENABLE_CRYPTO_MBEDTLS
+    else if (streq(p[0], "tls-cert-profile") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_cert_profile = p[1];
+    }
+#endif
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index dc63aed..0934853 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -499,6 +499,7 @@ struct options
     const char *priv_key_file;
     const char *pkcs12_file;
     const char *cipher_list;
+    const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
     int verify_x509_type;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fca1e7c..e865e24 100644
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
index 206400f..3c4cf34 100644
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
+ *                      Defaults to 'preferred' if NULL.
+ */
+void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile);
+
+/**
  * Check our certificate notBefore and notAfter fields, and warn if the cert is
  * either not yet valid or has expired.  Note that this is a non-fatal error,
  * since we compare against the system time, which might be incorrect.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ba8dadf..6e27a83 100644
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
+    if (!profile || 0 == strcmp(profile, "preferred"))
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
index 645ccf5..f2e70f0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -381,6 +381,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 }
 
 void
+tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
+{
+    /* TODO --tls-cert-profile not supported for OpenSSL builds */
+}
+
+void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
     int ret;
-- 
2.7.4


