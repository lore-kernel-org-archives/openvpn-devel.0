From: Arne Schwabe <arne@...1227...>
Date: Thu, 16 Apr 2020 17:26:19 +0200
Message-Id: <20200416152619.5465-2-arne@...1227...>
In-Reply-To: <20200416152619.5465-1-arne@...1227...>
References: <4f3b6d5e-5354-558d-2e58-c8f588fbd18f@...2181...>
 <20200416152619.5465-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 3/3] Implement tls-groups option to
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 README.ec                 |  7 ++---
 doc/openvpn.8             | 33 ++++++++++++++++++++++-
 src/openvpn/options.c     | 10 ++++++-
 src/openvpn/options.h     |  1 +
 src/openvpn/ssl.c         |  6 +++++
 src/openvpn/ssl_backend.h | 10 +++++++
 src/openvpn/ssl_mbedtls.c | 46 ++++++++++++++++++++++++++++++++
 src/openvpn/ssl_mbedtls.h |  1 +
 src/openvpn/ssl_openssl.c | 56 ++++++++++++++++++++++++++++++++++++++-
 9 files changed, 164 insertions(+), 6 deletions(-)

diff --git a/README.ec b/README.ec
index 32938017..2f830972 100644
--- a/README.ec
+++ b/README.ec
@@ -12,14 +12,15 @@ OpenVPN 2.4.0 and newer automatically initialize ECDH parameters. When ECDSA is
 used for authentication, the curve used for the server certificate will be used
 for ECDH too. When autodetection fails (e.g. when using RSA certificates)
 OpenVPN lets the crypto library decide if possible, or falls back to the
-secp384r1 curve.
+secp384r1 curve. The list of groups/curves that the crypto library will choose
+from can be set with the --tls-groups <grouplist> configuration.
 
 An administrator can force an OpenVPN/OpenSSL server to use a specific curve
 using the --ecdh-curve <curvename> option with one of the curves listed as
-available by the --show-curves option. Clients will use the same curve as
+available by the --show-groups option. Clients will use the same curve as
 selected by the server.
 
-Note that not all curves listed by --show-curves are available for use with TLS;
+Note that not all curves listed by --show-groups are available for use with TLS;
 in that case connecting will fail with a 'no shared cipher' TLS error.
 
 Authentication (ECDSA)
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f0796e52..76633900 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5098,6 +5098,8 @@ Use
 to see a list of TLS ciphers supported by your crypto library.
 
 Warning!
+.B \-\-tls\-groups
+,
 .B \-\-tls\-cipher
 and
 .B \-\-tls\-ciphersuites
@@ -5113,6 +5115,33 @@ OpenSSL.
 The default for \-\-tls\-ciphersuites is to use the crypto library's default.
 .\"*********************************************************
 .TP
+.B \-\-tls\-groups l
+A list
+.B l
+of allowable groups/curves in order of preference.
+
+Set the allowed elictipic curves/groups for the TLS session.
+These groups are  allowed to be used in signatures and key exchange.
+
+mbed TLS currently allows all known curves per default.
+
+OpenSSL 1.1+ restricts the list per default to
+"X25519:secp256r1:X448:secp521r1:secp384r1".
+
+If you use certificates that use non-standard curves, you
+might need to add them here. If you do not force the ecdh curve
+by using
+.B \-\-ecdh\-curve
+, the groups for ecdh will also be picked from this list.
+
+OpenVPN maps the curve name secp256r1 to prime256v1 to allow
+specifying the tls-groups option for mbed TLS and OpenSSL.
+
+Warning: this option not only affects eliptic curve certificates
+but also the key exchange in TLS 1.3 and using this option improperly
+will disable TLS 1.3.
+.\"*********************************************************
+.TP
 .B \-\-tls\-cert\-profile profile
 Set the allowed cryptographic algorithms for certificates according to
 .B profile\fN.
@@ -5878,8 +5907,10 @@ engines supported by the OpenSSL library.
 .TP
 .B \-\-show\-curves
 (Standalone)
-Show all available elliptic curves to use with the
+Show all available elliptic groups/curves to use with the
 .B \-\-ecdh\-curve
+and
+.B \-\-tls\-groups
 option.
 .\"*********************************************************
 .SS Generating key material:
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 49df8df1..57bc0abb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7895,7 +7895,7 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->show_tls_ciphers = true;
     }
-    else if (streq(p[0], "show-curves") && !p[1])
+    else if ((streq(p[0], "show-curves") || streq(p[0], "show-groups")) && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->show_curves = true;
@@ -7903,6 +7903,9 @@ add_option(struct options *options,
     else if (streq(p[0], "ecdh-curve") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        msg(M_WARN, "Consider setting groups/curves preference with "
+            "tls-groups instead of forcing a specific curve with "
+            "ecdh-curve.");
         options->ecdh_curve = p[1];
     }
     else if (streq(p[0], "tls-server") && !p[1])
@@ -8091,6 +8094,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->cipher_list_tls13 = p[1];
     }
+    else if (streq(p[0], "tls-groups") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_groups = p[1];
+    }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f1f6faf..3732a3a5 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -537,6 +537,7 @@ struct options
     const char *pkcs12_file;
     const char *cipher_list;
     const char *cipher_list_tls13;
+    const char *tls_groups;
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 56d0576a..ef153d37 100644
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
index 1c244ece..d95e8320 100644
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
index 51669278..f133ae39 100644
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
@@ -342,6 +347,42 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
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
+    const char *token = strsep(&tmp_groups, ":");
+    while (token)
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
+        mbedtls_ssl_conf_curves(&ks_ssl->ssl_config, ssl_ctx->groups);
+    }
+
     /* Disable record splitting (for now).  OpenVPN assumes records are sent
      * unfragmented, and changing that will require thorough review and
      * testing.  Since OpenVPN is not susceptible to BEAST, we can just
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 92381f1a..1dc28313 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -105,6 +105,7 @@ struct tls_root_ctx {
 #endif
     struct external_context external_key; /**< External key context */
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
+    mbedtls_ecp_group_id *groups;                /**< List of allowed groups for this connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
 };
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d7bd6aa2..06971d63 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -557,6 +557,58 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
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
+    const char *token = strsep(&tmp_groups, ":");
+    while (token)
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
+        token = strsep(&tmp_groups, ":");
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
@@ -2179,6 +2231,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
 void
 show_available_curves(void)
 {
+    printf("Consider using openssl ecparam -list_curves as\n"
+           "alternative to running this command.");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves = NULL;
     size_t crv_len = 0;
@@ -2188,7 +2242,7 @@ show_available_curves(void)
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     if (EC_get_builtin_curves(curves, crv_len))
     {
-        printf("Available Elliptic curves:\n");
+        printf("\nAvailable Elliptic curves/groups:\n");
         for (n = 0; n < crv_len; n++)
         {
             const char *sname;
-- 
2.26.0


