Message-ID: <5309B31C.50208@...1856...>
Date: Sun, 23 Feb 2014 09:36:44 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>	<530917A4.4050905@...1528...>
	<53093043.9080808@...277...>
In-Reply-To: <53093043.9080808@...277...>
Content-Type: multipart/mixed; boundary="------------090709050600000603050708"
Subject: Re: [Openvpn-devel] [Patch] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090709050600000603050708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Piotr,

On 23-02-14 00:18, pietrek -- wrote:
> I added such a comment to the readme.


First of all, thank you for writing the patch and responding to
questions on the mailinglist! I've found a bit of time to look at your
patch.

There are a couple things I would like to note:

1) This patch allows for not supplying a dh-file, also when no ecdh
curve is specified. This makes it easier for users to end up with a less
secure (TLS without (EC)DH) setup. I don't think that is a good idea.

2) When a curve is specified, the DH parameters will no longer be
initialized. One could argue this is no longer needed when having ECDH,
but when the other party does not support ECDH, this would cause OpenVPN
to fall back to a non-DH, non-ECDH control channel; not good.

3) This implementation requires both endpoints user to specify the same
curve to make it work. RFC 4492, 'ECC Cipher Suites for TLS', tells to
use the same curve for ECDH as is used for ECDSA. The nice thing here is
that a user does not need to specify the curve; it just works.

I wrote some code that does this already (the link I referred to in this
threat earlier). As you have dug into the OpenSSL ECDH stuff too, could
you please take a look at the ECDH-enabling code I wrote (also attached
as patch files):
https://github.com/syzzer/openvpn/compare/OpenVPN:master...ecdh-squashed

It does the get-the-curve-from-the-private-key thing, and allows for
simultaneous support of DH and ECDH. It also allows for the
user-specified curve approach, and uses a sane default fallback when
autodetection fails.

Once again, thank you for contributing. Your input is very welcome!

Regards,
-Steffan

--------------090709050600000603050708
Content-Type: text/x-patch;
	name="0001-Add-support-for-elliptic-curve-diffie-hellmann-key-e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Add-support-for-elliptic-curve-diffie-hellmann-key-e.pa";
	filename*1="tch"

From d9c2dfc272d8c9bf3a2e256655a72db19ee81cc9 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Thu, 16 Jan 2014 23:27:10 +0100
Subject: [PATCH 1/2] Add support for elliptic curve diffie-hellmann key
 exchange (ECDH)

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
 configure.ac               |   4 +-
 doc/openvpn.8              |  14 ++++++
 src/openvpn/init.c         |   4 +-
 src/openvpn/options.c      |  11 +++++
 src/openvpn/options.h      |   2 +
 src/openvpn/ssl.c          |   4 ++
 src/openvpn/ssl_backend.h  |  15 +++++++
 src/openvpn/ssl_openssl.c  | 105 +++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_polarssl.c |  13 ++++++
 9 files changed, 169 insertions(+), 3 deletions(-)

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
index f079652..e74b730 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -56,6 +56,7 @@
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
 #include <openssl/crypto.h>
+#include <openssl/ec.h>
 
 /*
  * Allocate space in SSL objects in which to store a struct tls_session
@@ -329,6 +330,71 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
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
+  SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
+#else
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
+#endif
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     const char *pkcs12_file_inline,
@@ -1303,6 +1369,45 @@ show_available_tls_ciphers (const char *cipher_list)
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


--------------090709050600000603050708
Content-Type: text/x-patch;
	name="0002-Add-an-elliptic-curve-testing-cert-chain-to-the-samp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-Add-an-elliptic-curve-testing-cert-chain-to-the-samp.pa";
	filename*1="tch"

From 960f018a69fe087513a62ad55229abfd86b9c1c5 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sun, 19 Jan 2014 18:34:38 +0100
Subject: [PATCH 2/2] Add an elliptic curve testing cert chain to the sample
 keys

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 sample/sample-keys/README        |  6 ++--
 sample/sample-keys/ec-ca.crt     | 13 +++++++++
 sample/sample-keys/ec-ca.key     |  6 ++++
 sample/sample-keys/ec-client.crt | 61 ++++++++++++++++++++++++++++++++++++++++
 sample/sample-keys/ec-client.key |  6 ++++
 sample/sample-keys/ec-server.crt | 61 ++++++++++++++++++++++++++++++++++++++++
 sample/sample-keys/ec-server.key |  6 ++++
 7 files changed, 156 insertions(+), 3 deletions(-)
 create mode 100644 sample/sample-keys/ec-ca.crt
 create mode 100644 sample/sample-keys/ec-ca.key
 create mode 100644 sample/sample-keys/ec-client.crt
 create mode 100644 sample/sample-keys/ec-client.key
 create mode 100644 sample/sample-keys/ec-server.crt
 create mode 100644 sample/sample-keys/ec-server.key

diff --git a/sample/sample-keys/README b/sample/sample-keys/README
index 1cd473a..9f4f918 100644
--- a/sample/sample-keys/README
+++ b/sample/sample-keys/README
@@ -1,7 +1,6 @@
-Sample RSA keys.
+Sample RSA and EC keys.
 
-See the examples section of the man page
-for usage examples.
+See the examples section of the man page for usage examples.
 
 NOTE: THESE KEYS ARE FOR TESTING PURPOSES ONLY.
       DON'T USE THEM FOR ANY REAL WORK BECAUSE
@@ -12,3 +11,4 @@ client.{crt,key} -- sample client key/cert
 server.{crt,key} -- sample server key/cert (nsCertType=server)
 pass.{crt,key}   -- sample client key/cert with password-encrypted key
                     password = "password"
+ec-*.{crt,key}   -- sample elliptic curve variants of the above
diff --git a/sample/sample-keys/ec-ca.crt b/sample/sample-keys/ec-ca.crt
new file mode 100644
index 0000000..e190801
--- /dev/null
+++ b/sample/sample-keys/ec-ca.crt
@@ -0,0 +1,13 @@
+-----BEGIN CERTIFICATE-----
+MIIB4jCCAWmgAwIBAgIJALGEGB2g6cAXMAoGCCqGSM49BAMCMBUxEzARBgNVBAMT
+CkVDLVRlc3QgQ0EwHhcNMTQwMTE4MTYwMTUzWhcNMjQwMTE2MTYwMTUzWjAVMRMw
+EQYDVQQDEwpFQy1UZXN0IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE2S4AZT7j
+ZlPG/CXpT12CzCNSySyKmJt+fWyW/wzbRulVJpGHXRHpZZj2VNOUE72kqGUeshh6
+Um1o7lHGDSAkHOJpeW5FtryiKhwFc+4dsOCLTNLVFXQsEtY3gY14Uquio4GEMIGB
+MB0GA1UdDgQWBBS0mkFcuCZ8SLWZRAD/8LpBQcgGPDBFBgNVHSMEPjA8gBS0mkFc
+uCZ8SLWZRAD/8LpBQcgGPKEZpBcwFTETMBEGA1UEAxMKRUMtVGVzdCBDQYIJALGE
+GB2g6cAXMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMAoGCCqGSM49BAMCA2cA
+MGQCMHWlVTi0xNZstR8ZNH+7z0WlyIXyZe23ne3EXkO0thZLdv86kpxFMPW/llB+
+RMRKuQIweN97n7FQy5DTenr91U98KDFJ5Av4mDFRL1mkXiu3W1//4XD8yEYDQTRz
+/GARuOLL
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/ec-ca.key b/sample/sample-keys/ec-ca.key
new file mode 100644
index 0000000..51a72e1
--- /dev/null
+++ b/sample/sample-keys/ec-ca.key
@@ -0,0 +1,6 @@
+-----BEGIN PRIVATE KEY-----
+MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDASU6X/mh2m2PayviL3
+teoml5soyIUcZfwZpVn6oNtnrLcAbIRsAJbM4xyGVp77G/6hZANiAATZLgBlPuNm
+U8b8JelPXYLMI1LJLIqYm359bJb/DNtG6VUmkYddEellmPZU05QTvaSoZR6yGHpS
+bWjuUcYNICQc4ml5bkW2vKIqHAVz7h2w4ItM0tUVdCwS1jeBjXhSq6I=
+-----END PRIVATE KEY-----
diff --git a/sample/sample-keys/ec-client.crt b/sample/sample-keys/ec-client.crt
new file mode 100644
index 0000000..9372800
--- /dev/null
+++ b/sample/sample-keys/ec-client.crt
@@ -0,0 +1,61 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 2 (0x2)
+    Signature Algorithm: ecdsa-with-SHA256
+        Issuer: CN=EC-Test CA
+        Validity
+            Not Before: Jan 18 16:02:37 2014 GMT
+            Not After : Jan 16 16:02:37 2024 GMT
+        Subject: CN=ec-client
+        Subject Public Key Info:
+            Public Key Algorithm: id-ecPublicKey
+                Public-Key: (384 bit)
+                pub: 
+                    04:40:d9:b9:a2:44:1b:01:39:2c:14:ee:aa:70:6b:
+                    31:98:28:44:c9:61:bc:b7:0b:b5:53:49:c2:c0:0a:
+                    43:b0:08:50:cd:80:2f:5d:a4:89:f1:ff:7d:11:78:
+                    f5:0c:b2:86:e2:59:f8:17:76:1b:22:f2:23:67:e7:
+                    55:90:ea:ce:0a:aa:da:05:f4:85:19:c9:ed:ae:6d:
+                    a3:ad:56:7a:f6:33:c6:cf:bb:c7:39:fa:e4:d3:67:
+                    df:f0:b8:4a:88:57:98
+                ASN1 OID: secp384r1
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            X509v3 Subject Key Identifier: 
+                D8:E2:35:7B:CA:66:71:6B:D8:5B:F5:12:13:82:2D:ED:CD:E5:ED:7F
+            X509v3 Authority Key Identifier: 
+                keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
+                DirName:/CN=EC-Test CA
+                serial:B1:84:18:1D:A0:E9:C0:17
+
+            X509v3 Extended Key Usage: 
+                TLS Web Client Authentication
+            X509v3 Key Usage: 
+                Digital Signature
+            Netscape Comment: 
+                Easy-RSA Generated Certificate
+            Netscape Cert Type: 
+                SSL Client
+    Signature Algorithm: ecdsa-with-SHA256
+         30:64:02:30:41:8b:1a:fd:97:a8:bb:7c:d0:eb:1c:a2:ba:c0:
+         ac:2f:6d:80:07:5b:5c:ef:55:59:1a:92:56:66:94:ce:49:6a:
+         a9:57:49:b2:41:73:64:7e:01:ac:31:3a:7c:2a:bf:a5:02:30:
+         2b:c4:a6:b1:0c:03:82:e3:e4:03:39:fb:19:d7:76:21:1b:7e:
+         7f:aa:22:5d:90:a4:e1:2e:cd:ca:92:0f:b6:3f:80:dc:26:d2:
+         09:34:8c:d1:61:bb:9d:ac:6d:8f:68:f0
+-----BEGIN CERTIFICATE-----
+MIICLTCCAbSgAwIBAgIBAjAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
+IENBMB4XDTE0MDExODE2MDIzN1oXDTI0MDExNjE2MDIzN1owFDESMBAGA1UEAxMJ
+ZWMtY2xpZW50MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEQNm5okQbATksFO6qcGsx
+mChEyWG8twu1U0nCwApDsAhQzYAvXaSJ8f99EXj1DLKG4ln4F3YbIvIjZ+dVkOrO
+CqraBfSFGcntrm2jrVZ69jPGz7vHOfrk02ff8LhKiFeYo4HYMIHVMAkGA1UdEwQC
+MAAwHQYDVR0OBBYEFNjiNXvKZnFr2Fv1EhOCLe3N5e1/MEUGA1UdIwQ+MDyAFLSa
+QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
+sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMC0GCWCG
+SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
+AYb4QgEBBAQDAgeAMAoGCCqGSM49BAMCA2cAMGQCMEGLGv2XqLt80OscorrArC9t
+gAdbXO9VWRqSVmaUzklqqVdJskFzZH4BrDE6fCq/pQIwK8SmsQwDguPkAzn7Gdd2
+IRt+f6oiXZCk4S7NypIPtj+A3CbSCTSM0WG7naxtj2jw
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/ec-client.key b/sample/sample-keys/ec-client.key
new file mode 100644
index 0000000..60636ed
--- /dev/null
+++ b/sample/sample-keys/ec-client.key
@@ -0,0 +1,6 @@
+-----BEGIN PRIVATE KEY-----
+MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD9Agj8nr/8sIr0XHky
+mcn1oMb3vqOh2axFBaIvmOHYmqs11SIH1tKYelkNYy9zHTChZANiAARA2bmiRBsB
+OSwU7qpwazGYKETJYby3C7VTScLACkOwCFDNgC9dpInx/30RePUMsobiWfgXdhsi
+8iNn51WQ6s4KqtoF9IUZye2ubaOtVnr2M8bPu8c5+uTTZ9/wuEqIV5g=
+-----END PRIVATE KEY-----
diff --git a/sample/sample-keys/ec-server.crt b/sample/sample-keys/ec-server.crt
new file mode 100644
index 0000000..f255aeb
--- /dev/null
+++ b/sample/sample-keys/ec-server.crt
@@ -0,0 +1,61 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 1 (0x1)
+    Signature Algorithm: ecdsa-with-SHA256
+        Issuer: CN=EC-Test CA
+        Validity
+            Not Before: Jan 18 16:02:31 2014 GMT
+            Not After : Jan 16 16:02:31 2024 GMT
+        Subject: CN=ec-server
+        Subject Public Key Info:
+            Public Key Algorithm: id-ecPublicKey
+                Public-Key: (384 bit)
+                pub: 
+                    04:bd:8c:3a:af:2e:2f:2e:de:cf:d2:39:8d:b9:a6:
+                    13:96:80:6d:b5:b2:ee:97:62:3b:a2:32:38:77:1e:
+                    fb:2a:ef:86:4b:d0:9e:4b:55:e0:9b:07:f9:64:2f:
+                    6b:a7:17:fd:65:dd:50:3f:1c:fa:fa:2f:39:2e:97:
+                    d4:86:e5:4e:5a:d2:50:0b:f4:d7:08:62:67:53:44:
+                    62:e3:25:f2:fa:36:84:87:1d:03:e3:e9:9d:d9:66:
+                    51:dd:b4:c4:db:0b:05
+                ASN1 OID: secp384r1
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            X509v3 Subject Key Identifier: 
+                EA:DF:7E:A3:D4:61:73:D7:01:AF:6E:0A:38:8D:33:D0:BD:24:4B:E1
+            X509v3 Authority Key Identifier: 
+                keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
+                DirName:/CN=EC-Test CA
+                serial:B1:84:18:1D:A0:E9:C0:17
+
+            X509v3 Extended Key Usage: 
+                TLS Web Server Authentication
+            X509v3 Key Usage: 
+                Digital Signature, Key Encipherment
+            Netscape Comment: 
+                Easy-RSA Generated Certificate
+            Netscape Cert Type: 
+                SSL Server
+    Signature Algorithm: ecdsa-with-SHA256
+         30:64:02:30:20:39:12:92:cc:a2:ca:45:b9:1a:8f:e0:c1:e7:
+         b7:4a:79:4d:07:07:81:72:08:b4:d4:7b:46:53:d7:72:32:d0:
+         d7:3e:e8:88:2b:c9:ba:8b:d5:94:4f:41:6c:d0:2e:a4:02:30:
+         75:ff:c3:8a:c1:f5:79:1c:1a:08:16:31:c2:c1:6e:d4:33:dc:
+         9f:04:0f:90:94:d9:75:c1:6d:71:28:62:cc:f6:89:7c:91:86:
+         a4:96:45:34:a0:8d:92:7e:dd:e3:da:4d
+-----BEGIN CERTIFICATE-----
+MIICLTCCAbSgAwIBAgIBATAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
+IENBMB4XDTE0MDExODE2MDIzMVoXDTI0MDExNjE2MDIzMVowFDESMBAGA1UEAxMJ
+ZWMtc2VydmVyMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEvYw6ry4vLt7P0jmNuaYT
+loBttbLul2I7ojI4dx77Ku+GS9CeS1Xgmwf5ZC9rpxf9Zd1QPxz6+i85LpfUhuVO
+WtJQC/TXCGJnU0Ri4yXy+jaEhx0D4+md2WZR3bTE2wsFo4HYMIHVMAkGA1UdEwQC
+MAAwHQYDVR0OBBYEFOrffqPUYXPXAa9uCjiNM9C9JEvhMEUGA1UdIwQ+MDyAFLSa
+QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
+sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMC0GCWCG
+SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
+AYb4QgEBBAQDAgZAMAoGCCqGSM49BAMCA2cAMGQCMCA5EpLMospFuRqP4MHnt0p5
+TQcHgXIItNR7RlPXcjLQ1z7oiCvJuovVlE9BbNAupAIwdf/DisH1eRwaCBYxwsFu
+1DPcnwQPkJTZdcFtcShizPaJfJGGpJZFNKCNkn7d49pN
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/ec-server.key b/sample/sample-keys/ec-server.key
new file mode 100644
index 0000000..bb3cdf1
--- /dev/null
+++ b/sample/sample-keys/ec-server.key
@@ -0,0 +1,6 @@
+-----BEGIN PRIVATE KEY-----
+MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD8bQlwrFrXHPmem0bt
+cBcU6nYfaZQbPdIDAB7edOOyevvzYH0qMtbaW95iSZLMRVWhZANiAAS9jDqvLi8u
+3s/SOY25phOWgG21su6XYjuiMjh3Hvsq74ZL0J5LVeCbB/lkL2unF/1l3VA/HPr6
+Lzkul9SG5U5a0lAL9NcIYmdTRGLjJfL6NoSHHQPj6Z3ZZlHdtMTbCwU=
+-----END PRIVATE KEY-----
-- 
1.8.3.2


--------------090709050600000603050708--

