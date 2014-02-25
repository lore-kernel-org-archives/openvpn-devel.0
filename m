From: Steffan Karger <steffan@...1856...>
Date: Wed, 26 Feb 2014 00:27:59 +0100
Message-Id: <1393370880-28553-2-git-send-email-steffan@...1856...>
In-Reply-To: <1393370880-28553-1-git-send-email-steffan@...1856...>
References: <1393370880-28553-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Add support for elliptic curve
	diffie-hellmann key exchange (ECDH)
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

This patch is based on Jan Just Keijser's patch from Feb 7, 2012.

When OpenSSL 1.0.2 or newer is used, lets OpenSSL do the heavy lifting.

Otherwise, tries the following things (in order of preference):
 * When supplied, use the ecdh curve specified by the user.
 * Try to extract the curve from the private key, use the same curve.
 * Fall back on secp384r1 curve.

Note that although the curve lookup succeeds, OpenSSL 1.0.0 and older do
*not* support TLSv1.1 or TLSv1.2, which means no that no EC-crypto can be
used.

This patch also bumps the minimum required OpenSSL version to 0.9.8,
because older version do not have all the functions used and would require
adding (more) #ifdefs.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 README.ec                  |  37 ++++++++++++++++
 configure.ac               |   4 +-
 doc/openvpn.8              |  14 ++++++
 src/openvpn/init.c         |   4 +-
 src/openvpn/options.c      |  11 +++++
 src/openvpn/options.h      |   2 +
 src/openvpn/ssl.c          |   4 ++
 src/openvpn/ssl_backend.h  |  15 +++++++
 src/openvpn/ssl_openssl.c  | 107 +++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_polarssl.c |  13 ++++++
 10 files changed, 208 insertions(+), 3 deletions(-)
 create mode 100644 README.ec

diff --git a/README.ec b/README.ec
new file mode 100644
index 0000000..bea3ce1
--- /dev/null
+++ b/README.ec
@@ -0,0 +1,37 @@
+Since 2.4.0, OpenVPN has official support for elliptic curve crypto. Elliptic
+curves are an alternative to RSA for asymmetric encryption.
+
+Elliptic curve crypto ('ECC') can be used for the ('TLS') control channel only
+in OpenVPN; the data channel (encrypting the actual network traffic) uses
+symmetric encryption. ECC can be used in TLS for authentication (ECDSA) and key
+exchange (ECDH).
+
+Note: ECC is available in OpenSSL builds of OpenVPN only. ECC for PolarSSL
+builds will follow soon.
+
+Key exchange (ECDH)
+-------------------
+OpenVPN 2.4.0 and newer automatically initialize ECDH parameters. When ECDSA is
+used for authentication, the curve used for the server certificate will be used
+for ECDH too. When autodetection fails (e.g. when using RSA certificates)
+OpenVPN falls back to the secp384r1 curve.
+
+An administrator can force an OpenVPN server to use a specific curve using the
+--ecdh-curve <curvename> option with one of the curves listed as available by
+the --show-curves option. Clients will use the same curve as selected by the
+server.
+
+Note that not all curves listed by --show-curves are available for use with TLS;
+in that case connecting will fail with a 'no shared cipher' TLS error.
+
+Authentication (ECDSA)
+----------------------
+Since OpenVPN 2.4.0, using ECDSA certificates works 'out of the box'. Which
+specific curves and cipher suites are available depends on your version and
+configuration of the crypto library. The crypto library will automatically
+select a cipher suite for the TLS control channel.
+
+Support for generating an ECDSA certificate chain is available in EasyRSA (in
+spite of it's name) since EasyRSA 3.0. The parameters you're looking for are
+'--use-algo=ec' and '--curve=<curve_name>'. See the EasyRSA documentation for
+more details on generating ECDSA certificates.
diff --git a/configure.ac b/configure.ac
index 380dcdb..4225343 100644
--- a/configure.ac
+++ b/configure.ac
@@ -744,7 +744,7 @@ PKG_CHECK_MODULES(
 
 PKG_CHECK_MODULES(
 	[OPENSSL_CRYPTO],
-	[libcrypto >= 0.9.6],
+	[libcrypto >= 0.9.8],
 	[have_openssl_crypto="yes"],
 	[AC_CHECK_LIB(
 		[crypto],
@@ -758,7 +758,7 @@ PKG_CHECK_MODULES(
 
 PKG_CHECK_MODULES(
 	[OPENSSL_SSL],
-	[libssl >= 0.9.6],
+	[libssl >= 0.9.8],
 	[have_openssl_ssl="yes"],
 	[AC_CHECK_LIB(
 		[ssl],
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d01c935..ce8d09c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4240,6 +4240,13 @@ included with the OpenVPN distribution.  Diffie Hellman parameters
 may be considered public.
 .\"*********************************************************
 .TP
+.B \-\-ecdh-curve name
+Specify the curve to use for elliptic curve Diffie Hellman. Available
+curves can be listed with
+.B \-\-show-curves
+. The specified curve will only be used for ECDH TLS-ciphers.
+.\"*********************************************************
+.TP
 .B \-\-cert file
 Local peer's signed certificate in .pem format \-\- must be signed
 by a certificate authority whose certificate is in
@@ -5021,6 +5028,13 @@ lowest.
 Show currently available hardware-based crypto acceleration
 engines supported by the OpenSSL library.
 .\"*********************************************************
+.TP
+.B \-\-show-curves
+(Standalone)
+Show all available elliptic curves to use with the
+.B \-\-ecdh-curve
+option.
+.\"*********************************************************
 .SS Generate a random key:
 Used only for non-TLS static key encryption mode.
 .\"*********************************************************
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d324166..83d631e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -868,7 +868,7 @@ print_openssl_info (const struct options *options)
 #ifdef ENABLE_CRYPTO
   if (options->show_ciphers || options->show_digests || options->show_engines
 #ifdef ENABLE_SSL
-      || options->show_tls_ciphers
+      || options->show_tls_ciphers || options->show_curves
 #endif
     )
     {
@@ -881,6 +881,8 @@ print_openssl_info (const struct options *options)
 #ifdef ENABLE_SSL
       if (options->show_tls_ciphers)
 	show_available_tls_ciphers (options->cipher_list);
+      if (options->show_curves)
+	show_available_curves();
 #endif
       return true;
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e21d5a..3335946 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -862,6 +862,7 @@ init_options (struct options *o, const bool init_gc)
   o->renegotiate_seconds = 3600;
   o->handshake_window = 60;
   o->transition_window = 3600;
+  o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
   o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
@@ -6495,6 +6496,16 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->show_tls_ciphers = true;
     }
+  else if (streq (p[0], "show-curves"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->show_curves = true;
+    }
+  else if (streq (p[0], "ecdh-curve") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      options->ecdh_curve= p[1];
+    }
   else if (streq (p[0], "tls-server"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bf232f4..b7f4230 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -201,6 +201,7 @@ struct options
   bool show_engines;
 #ifdef ENABLE_SSL
   bool show_tls_ciphers;
+  bool show_curves;
 #endif
   bool genkey;
 #endif
@@ -513,6 +514,7 @@ struct options
   const char *priv_key_file;
   const char *pkcs12_file;
   const char *cipher_list;
+  const char *ecdh_curve;
   const char *tls_verify;
   int verify_x509_type;
   const char *verify_x509_name;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c61701a..ef5f1df 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -542,6 +542,10 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
       tls_ctx_load_extra_certs(new_ctx, options->extra_certs_file, options->extra_certs_file_inline);
     }
 
+  /* Once keys and cert are loaded, load ECDH parameters */
+  if (options->tls_server)
+    tls_ctx_load_ecdh_params(new_ctx, options->ecdh_curve);
+
   /* Allowable ciphers */
   tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6fc3bd..992d370 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -186,6 +186,16 @@ void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
     const char *dh_file_inline);
 
 /**
+ * Load Elliptic Curve Parameters, and load them into the library-specific
+ * TLS context.
+ *
+ * @param ctx          TLS context to use
+ * @param curve_name   The name of the elliptic curve to load.
+ */
+void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
+    );
+
+/**
  * Load PKCS #12 file for key, cert and (optionally) CA certs, and add to
  * library-specific TLS context.
  *
@@ -461,6 +471,11 @@ void print_details (struct key_state_ssl * ks_ssl, const char *prefix);
 void show_available_tls_ciphers (const char *tls_ciphers);
 
 /*
+ * Show the available elliptic curves in the crypto library
+ */
+void show_available_curves (void);
+
+/*
  * The OpenSSL library has a notion of preference in TLS ciphers.  Higher
  * preference == more secure. Return the highest preference cipher.
  */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f079652..151155a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -56,6 +56,7 @@
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
 #include <openssl/crypto.h>
+#include <openssl/ec.h>
 
 /*
  * Allocate space in SSL objects in which to store a struct tls_session
@@ -329,6 +330,73 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
   DH_free (dh);
 }
 
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
+    )
+{
+  int nid = NID_undef;
+  EC_KEY *ecdh = NULL;
+  const char *sname = NULL;
+
+  /* Generate a new ECDH key for each SSL session (for non-ephemeral ECDH) */
+  SSL_CTX_set_options(ctx->ctx, SSL_OP_SINGLE_ECDH_USE);
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L
+  /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter loading */
+  if (NULL == curve_name) {
+    SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
+    return;
+  }
+#endif
+  /* For older OpenSSL, we'll have to do the parameter loading on our own */
+  if (curve_name != NULL)
+    {
+      /* Use user supplied curve if given */
+      msg (D_TLS_DEBUG, "Using user specified ECDH curve (%s)", curve_name);
+      nid = OBJ_sn2nid(curve_name);
+    }
+  else
+    {
+      /* Extract curve from key */
+      EC_KEY *eckey = NULL;
+      const EC_GROUP *ecgrp = NULL;
+      EVP_PKEY *pkey = NULL;
+
+      /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
+      SSL ssl;
+      ssl.cert = ctx->ctx->cert;
+      pkey = SSL_get_privatekey(&ssl);
+
+      msg (D_TLS_DEBUG, "Extracting ECDH curve from private key");
+
+      if (pkey != NULL && (eckey = EVP_PKEY_get1_EC_KEY(pkey)) != NULL &&
+          (ecgrp = EC_KEY_get0_group(eckey)) != NULL)
+        nid = EC_GROUP_get_curve_name(ecgrp);
+    }
+
+  /* Translate NID back to name , just for kicks */
+  sname = OBJ_nid2sn(nid);
+  if (sname == NULL) sname = "(Unknown)";
+
+  /* Create new EC key and set as ECDH key */
+  if (NID_undef == nid || NULL == (ecdh = EC_KEY_new_by_curve_name(nid)))
+    {
+      /* Creating key failed, fall back on sane default */
+      ecdh = EC_KEY_new_by_curve_name(NID_secp384r1);
+      const char *source = (NULL == curve_name) ?
+          "extract curve from certificate" : "use supplied curve";
+      msg (D_TLS_DEBUG_LOW,
+          "Failed to %s (%s), using secp384r1 instead.", source, sname);
+      sname = OBJ_nid2sn(NID_secp384r1);
+    }
+
+  if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
+    msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: cannot add curve");
+
+  msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", sname);
+
+  EC_KEY_free(ecdh);
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     const char *pkcs12_file_inline,
@@ -1303,6 +1371,45 @@ show_available_tls_ciphers (const char *cipher_list)
   SSL_CTX_free (tls_ctx.ctx);
 }
 
+/*
+ * Show the Elliptic curves that are available for us to use
+ * in the OpenSSL library.
+ */
+void
+show_available_curves()
+{
+  EC_builtin_curve *curves = NULL;
+  size_t crv_len = 0;
+  size_t n = 0;
+
+  crv_len = EC_get_builtin_curves(NULL, 0);
+
+  curves = OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
+
+  if (curves == NULL)
+    msg (M_SSLERR, "Cannot create EC_builtin_curve object");
+  else
+  {
+    if (EC_get_builtin_curves(curves, crv_len))
+    {
+      printf ("Available Elliptic curves:\n");
+      for (n = 0; n < crv_len; n++)
+      {
+        const char *sname;
+        sname   = OBJ_nid2sn(curves[n].nid);
+        if (sname == NULL) sname = "";
+
+        printf("%s\n", sname);
+      }
+    }
+    else
+    {
+      msg (M_SSLERR, "Cannot get list of builtin curves");
+    }
+    OPENSSL_free(curves);
+  }
+}
+
 void
 get_highest_preference_tls_cipher (char *buf, int size)
 {
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 9dc4e87..69b356b 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -228,6 +228,13 @@ else
       (counter_type) 8 * mpi_size(&ctx->dhm_ctx->P));
 }
 
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
+    )
+{
+    msg(M_WARN, "Elliptic Curves not yet supported by PolarSSL");
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     const char *pkcs12_file_inline,
@@ -1068,6 +1075,12 @@ show_available_tls_ciphers (const char *cipher_list)
 }
 
 void
+show_available_curves (void)
+{
+  printf("The PolarSSL build of OpenVPN does not support elliptic curves yet");
+}
+
+void
 get_highest_preference_tls_cipher (char *buf, int size)
 {
   const char *cipher_name;
-- 
1.8.3.2


