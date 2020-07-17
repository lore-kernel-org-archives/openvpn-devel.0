From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Jul 2020 15:47:34 +0200
Message-Id: <20200717134739.21168-4-arne@...1227...>
In-Reply-To: <20200717134739.21168-1-arne@...1227...>
References: <20200717134739.21168-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v5 4/9] Implement tls-groups option to
 specify eliptic curves/groups
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

By default OpenSSL 1.1+ only allows signatures and ecdh/ecdhx from the
default list of X25519:secp256r1:X448:secp521r1:secp384r1. In
TLS1.3 key exchange is independent from the signature/key of the
certificates, so allowing all groups per default is not a sensible
choice anymore and instead a shorter list is reasonable.

However, when using certificates with exotic curves that are not on
the group list, the signatures of these certificates will no longer
be accepted.

The tls-groups  option allows to modify the group list to account
for these corner cases.

Patch V2: Uses local gc_arena instead of malloc/free, reword commit
          message. Fix other typos/clarify messages

Patch V3: Style fixes, adjust code to changes from mbed tls session
          fix

Patch V5: Fix compilation with OpenSSL 1.0.2

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 README.ec                               |  7 ++--
 configure.ac                            |  1 +
 doc/man-sections/encryption-options.rst |  6 +--
 doc/man-sections/tls-options.rst        | 27 +++++++++++-
 src/openvpn/openssl_compat.h            |  6 +++
 src/openvpn/options.c                   | 10 ++++-
 src/openvpn/options.h                   |  1 +
 src/openvpn/ssl.c                       |  6 +++
 src/openvpn/ssl_backend.h               | 10 +++++
 src/openvpn/ssl_mbedtls.c               | 46 +++++++++++++++++++++
 src/openvpn/ssl_mbedtls.h               |  1 +
 src/openvpn/ssl_openssl.c               | 55 ++++++++++++++++++++++++-
 12 files changed, 167 insertions(+), 9 deletions(-)

diff --git a/README.ec b/README.ec
index 32938017..61f23b2e 100644
--- a/README.ec
+++ b/README.ec
@@ -12,14 +12,15 @@ OpenVPN 2.4.0 and newer automatically initialize ECDH parameters. When ECDSA is
 used for authentication, the curve used for the server certificate will be used
 for ECDH too. When autodetection fails (e.g. when using RSA certificates)
 OpenVPN lets the crypto library decide if possible, or falls back to the
-secp384r1 curve.
+secp384r1 curve. The list of groups/curves that the crypto library will choose
+from can be set with the --tls-groups <grouplist> option.
 
 An administrator can force an OpenVPN/OpenSSL server to use a specific curve
 using the --ecdh-curve <curvename> option with one of the curves listed as
-available by the --show-curves option. Clients will use the same curve as
+available by the --show-groups option. Clients will use the same curve as
 selected by the server.
 
-Note that not all curves listed by --show-curves are available for use with TLS;
+Note that not all curves listed by --show-groups are available for use with TLS;
 in that case connecting will fail with a 'no shared cipher' TLS error.
 
 Authentication (ECDSA)
diff --git a/configure.ac b/configure.ac
index a8535b70..dee2c4f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -927,6 +927,7 @@ if test "${with_crypto_library}" = "openssl"; then
 			OpenSSL_version \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
+			SSL_CTX_set1_groups \
 			SSL_CTX_set_security_level \
 			X509_get0_notBefore \
 			X509_get0_notAfter \
diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encryption-options.rst
index a59f636c..ee34f14e 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -27,9 +27,9 @@ SSL Library information
   (Standalone) Show currently available hardware-based crypto acceleration
   engines supported by the OpenSSL library.
 
---show-curves
-  (Standalone) Show all available elliptic curves to use with the
-  ``--ecdh-curve`` option.
+--show-groups
+  (Standalone) Show all available elliptic curves/groups to use with the
+  ``--ecdh-curve`` and ``tls-groups`` options.
 
 Generating key material
 -----------------------
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 92b832cd..ccc90ac9 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -338,6 +338,31 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   Use ``--tls-crypt`` instead if you want to use the key file to not only
   authenticate, but also encrypt the TLS control channel.
 
+--tls-groups list
+    A list of allowable groups/curves in order of preference.
+
+    Set the allowed elictipic curves/groups for the TLS session.
+    These groups are  allowed to be used in signatures and key exchange.
+
+    mbed TLS currently allows all known curves per default.
+
+    OpenSSL 1.1+ restricts the list per default to
+    ::
+
+      "X25519:secp256r1:X448:secp521r1:secp384r1".
+
+    If you use certificates that use non-standard curves, you
+    might need to add them here. If you do not force the ecdh curve
+    by using ``--ecdh-curve``, the groups for ecdh will also be picked
+    from this list.
+
+    OpenVPN maps the curve name `secp256r1` to `prime256v1` to allow
+    specifying the same tls-groups option for mbed TLS and OpenSSL.
+
+    Warning: this option not only affects eliptic curve certificates
+    but also the key exchange in TLS 1.3 and using this option improperly
+    will disable TLS 1.3.
+
 --tls-cert-profile profile
   Set the allowed cryptographic algorithms for certificates according to
   ``profile``.
@@ -368,7 +393,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   OpenVPN will migrate to 'preferred' as default in the future. Please
   ensure that your keys already comply.
 
-*WARNING:* ``--tls-ciphers`` and ``--tls-ciphersuites``
+*WARNING:* ``--tls-ciphers``, ``--tls-ciphersuites`` and ``tls-groups``
     These options are expert features, which - if used correctly - can
     improve the security of your VPN connection. But it is also easy to
     unwittingly use them to carefully align a gun with your foot, or just
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index d35251fb..eb6c9c90 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -183,6 +183,12 @@ SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
 }
 #endif
 
+/* This function is implemented as macro, so the configure check for the
+ * function may fail, so we check for both variants here */
+#if !defined(HAVE_SSL_CTX_SET1_GROUPS) && !defined(SSL_CTX_set1_groups)
+#define SSL_CTX_set1_groups SSL_CTX_set1_curves
+#endif
+
 #if !defined(HAVE_X509_GET0_PUBKEY)
 /**
  * Get the public key from a X509 certificate
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a35d91e7..15173db2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8058,7 +8058,7 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->show_tls_ciphers = true;
     }
-    else if (streq(p[0], "show-curves") && !p[1])
+    else if ((streq(p[0], "show-curves") || streq(p[0], "show-groups")) && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->show_curves = true;
@@ -8066,6 +8066,9 @@ add_option(struct options *options,
     else if (streq(p[0], "ecdh-curve") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        msg(M_WARN, "Consider setting groups/curves preference with "
+            "tls-groups instead of forcing a specific curve with "
+            "ecdh-curve.");
         options->ecdh_curve = p[1];
     }
     else if (streq(p[0], "tls-server") && !p[1])
@@ -8236,6 +8239,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cipher_list_tls13 = p[1];
     }
+    else if (streq(p[0], "tls-groups") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_groups = p[1];
+    }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || !p[2]))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c37006d3..1b038c91 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -542,6 +542,7 @@ struct options
     bool pkcs12_file_inline;
     const char *cipher_list;
     const char *cipher_list_tls13;
+    const char *tls_groups;
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 04d78a81..00b97352 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -630,6 +630,12 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
     tls_ctx_restrict_ciphers_tls13(new_ctx, options->cipher_list_tls13);
 
+    /* Set the allow groups/curves for TLS if we want to override them */
+    if (options->tls_groups)
+    {
+        tls_ctx_set_tls_groups(new_ctx, options->tls_groups);
+    }
+
     if (!tls_ctx_set_options(new_ctx, options->ssl_flags))
     {
         goto err;
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a1770bd4..75692797 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -198,6 +198,16 @@ void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *cipher
  */
 void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile);
 
+/**
+ * Set the allowed (eliptic curve) group allowed for signatures and
+ * key exchange.
+ *
+ * @param ctx       TLS context to restrict, must be valid.
+ * @param groups    List of groups that will be allowed, in priority,
+ *                  separated by :
+ */
+void tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups);
+
 /**
  * Check our certificate notBefore and notAfter fields, and warn if the cert is
  * either not yet valid or has expired.  Note that this is a non-fatal error,
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 977ff5c3..9b10e9e4 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -176,6 +176,11 @@ tls_ctx_free(struct tls_root_ctx *ctx)
             free(ctx->allowed_ciphers);
         }
 
+        if (ctx->groups)
+        {
+            free(ctx->groups);
+        }
+
         CLEAR(*ctx);
 
         ctx->initialised = false;
@@ -343,6 +348,42 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
     }
 }
 
+void
+tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
+{
+    ASSERT(ctx);
+    struct gc_arena gc = gc_new();
+
+    /* Get number of groups and allocate an array in ctx */
+    int groups_count = get_num_elements(groups, ':');
+    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
+
+    /* Parse allowed ciphers, getting IDs */
+    int i = 0;
+    char *tmp_groups = string_alloc(groups, &gc);
+
+    const char *token;
+    while ((token = strsep(&tmp_groups, ":")))
+    {
+        const mbedtls_ecp_curve_info *ci =
+            mbedtls_ecp_curve_info_from_name(token);
+        if (!ci)
+        {
+            msg(M_WARN, "Warning unknown curve/group specified: %s", token);
+        }
+        else
+        {
+            ctx->groups[i] = ci->grp_id;
+            i++;
+        }
+        token = strsep(&tmp_groups, ":");
+    }
+    ctx->groups[i] = MBEDTLS_ECP_DP_NONE;
+
+    gc_free(&gc);
+}
+
+
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -1043,6 +1084,11 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
         mbedtls_ssl_conf_ciphersuites(ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
     }
 
+    if (ssl_ctx->groups)
+    {
+        mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
+    }
+
     /* Disable record splitting (for now).  OpenVPN assumes records are sent
      * unfragmented, and changing that will require thorough review and
      * testing.  Since OpenVPN is not susceptible to BEAST, we can just
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 92381f1a..0525134f 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -105,6 +105,7 @@ struct tls_root_ctx {
 #endif
     struct external_context external_key; /**< External key context */
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
+    mbedtls_ecp_group_id *groups;     /**< List of allowed groups for this connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
 };
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 14d52bfa..5ba74402 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -563,6 +563,57 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 #endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
 }
 
+void
+tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
+{
+    ASSERT(ctx);
+    struct gc_arena gc = gc_new();
+    /* This method could be as easy as
+     *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
+     * but OpenSSL does not like the name secp256r1 for prime256v1
+     * This is one of the important curves.
+     * To support the same name for OpenSSL and mbedTLS, we do
+     * this dance.
+     */
+
+    int groups_count = get_num_elements(groups, ':');
+
+    int *glist;
+    /* Allocate an array for them */
+    ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &gc);
+
+    /* Parse allowed ciphers, getting IDs */
+    int glistlen = 0;
+    char *tmp_groups = string_alloc(groups, &gc);
+
+    const char *token;
+    while ((token = strsep(&tmp_groups, ":")))
+    {
+        if (streq(token, "secp256r1"))
+        {
+            token = "prime256v1";
+        }
+        int nid = OBJ_sn2nid(token);
+
+        if (nid == 0)
+        {
+            msg(M_WARN, "Warning unknown curve/group specified: %s", token);
+        }
+        else
+        {
+            glist[glistlen] = nid;
+            glistlen++;
+        }
+    }
+
+    if (!SSL_CTX_set1_groups(ctx->ctx, glist, glistlen))
+    {
+        crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",
+                   groups);
+    }
+    gc_free(&gc);
+}
+
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -2135,6 +2186,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
 void
 show_available_curves(void)
 {
+    printf("Consider using openssl 'ecparam -list_curves' as\n"
+           "alternative to running this command.\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves = NULL;
     size_t crv_len = 0;
@@ -2144,7 +2197,7 @@ show_available_curves(void)
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     if (EC_get_builtin_curves(curves, crv_len))
     {
-        printf("Available Elliptic curves:\n");
+        printf("\nAvailable Elliptic curves/groups:\n");
         for (n = 0; n < crv_len; n++)
         {
             const char *sname;
-- 
2.26.2


