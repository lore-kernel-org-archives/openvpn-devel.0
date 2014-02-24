Message-ID: <530A9219.8050809@...277...>
Date: Mon, 24 Feb 2014 01:28:09 +0100
From: pietrek -- <pietrek.j@...277...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>	<530917A4.4050905@...1528...>	<53093043.9080808@...277...>
	<5309B31C.50208@...1856...>
In-Reply-To: <5309B31C.50208@...1856...>
Content-Type: multipart/mixed; boundary="------------080008030901070506010100"
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
--------------080008030901070506010100
Content-Type: multipart/alternative;
	boundary="------------000601030301050605050205"

--------------000601030301050605050205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steffan,
I modified my patch again. And thanks for your code - it helped me.
1) In such case server will set ecdh=auto.

2)That's a good idea.
I added initializing both ECDH and DH on server side if they're 
specified in config.

3)It works for me without specifying anything on client side.
I can also specify different curve for ECDH than used in certificates 
without any errors.

I added warning if DH isn't specified - old client may not support ECDH.
Autodetecting ecdh is a good idea - I made option ecdh=auto.
Most of the curves secp, prime, sect work, but some of them ( eg. 
wap-wsg-idm-ecid-wtls10 ) cause ssl error 'no shared cipher'.

Working curves examples:
secp192k1
secp160k1
secp224k1
secp521r1
prime192v1
prime256v1
sect233k1
sect283r1
sect409r1
sect571k1

Failing examples:
prime239v1
sect113r1
secp128r2
c2pnb304w1

I also copied from your code option --show-curves, manual entries and EC 
curve autodetection.

Piotr Jarosz

On 02/23/14 09:36, Steffan Karger wrote:
> Hi Piotr,
>
> On 23-02-14 00:18, pietrek -- wrote:
>> I added such a comment to the readme.
> First of all, thank you for writing the patch and responding to
> questions on the mailinglist! I've found a bit of time to look at your
> patch.
>
> There are a couple things I would like to note:
>
> 1) This patch allows for not supplying a dh-file, also when no ecdh
> curve is specified. This makes it easier for users to end up with a less
> secure (TLS without (EC)DH) setup. I don't think that is a good idea.
>
> 2) When a curve is specified, the DH parameters will no longer be
> initialized. One could argue this is no longer needed when having ECDH,
> but when the other party does not support ECDH, this would cause OpenVPN
> to fall back to a non-DH, non-ECDH control channel; not good.
>
> 3) This implementation requires both endpoints user to specify the same
> curve to make it work. RFC 4492, 'ECC Cipher Suites for TLS', tells to
> use the same curve for ECDH as is used for ECDSA. The nice thing here is
> that a user does not need to specify the curve; it just works.
>
> I wrote some code that does this already (the link I referred to in this
> threat earlier). As you have dug into the OpenSSL ECDH stuff too, could
> you please take a look at the ECDH-enabling code I wrote (also attached
> as patch files):
> https://github.com/syzzer/openvpn/compare/OpenVPN:master...ecdh-squashed
>
> It does the get-the-curve-from-the-private-key thing, and allows for
> simultaneous support of DH and ECDH. It also allows for the
> user-specified curve approach, and uses a sane default fallback when
> autodetection fails.
>
> Once again, thank you for contributing. Your input is very welcome!
>
> Regards,
> -Steffan
>
>
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------000601030301050605050205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Steffan,<br>
      I modified my patch again. And thanks for your code - it helped
      me.<br>
      1) In such case server will set ecdh=auto.<br>
      <br>
      2)That's a good idea.<br>
      I added initializing both ECDH and DH on server side if they're
      specified in config.<br>
      <br>
      3)It works for me without specifying anything on client side.<br>
      I can also specify different curve for ECDH than used in
      certificates without any errors.<br>
      <br>
      I added warning if DH isn't specified - old client may not support
      ECDH.<br>
      Autodetecting ecdh is a good idea - I made option ecdh=auto.<br>
      Most of the curves secp, prime, sect work, but some of them ( eg.
      wap-wsg-idm-ecid-wtls10 ) cause ssl error 'no shared cipher'.<br>
      <br>
      Working curves examples:<br>
      secp192k1<br>
      secp160k1<br>
      secp224k1<br>
      secp521r1<br>
      prime192v1<br>
      prime256v1<br>
      sect233k1<br>
      sect283r1<br>
      sect409r1<br>
      sect571k1<br>
      <br>
      Failing examples:<br>
      prime239v1<br>
      sect113r1<br>
      secp128r2<br>
      c2pnb304w1<br>
      <br>
      I also copied from your code option --show-curves, manual entries
      and EC curve autodetection.<br>
      <br>
      Piotr Jarosz<br>
      <br>
      On 02/23/14 09:36, Steffan Karger wrote:<br>
    </div>
    <blockquote cite="mid:5309B31C.50208@...1856..." type="cite">
      <pre wrap="">Hi Piotr,

On 23-02-14 00:18, pietrek -- wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">I added such a comment to the readme.
</pre>
      </blockquote>
      <pre wrap="">
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
<a class="moz-txt-link-freetext" href="https://github.com/syzzer/openvpn/compare/OpenVPN:master...ecdh-squashed">https://github.com/syzzer/openvpn/compare/OpenVPN:master...ecdh-squashed</a>

It does the get-the-curve-from-the-private-key thing, and allows for
simultaneous support of DH and ECDH. It also allows for the
user-specified curve approach, and uses a sane default fallback when
autodetection fails.

Once again, thank you for contributing. Your input is very welcome!

Regards,
-Steffan
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
<a class="moz-txt-link-freetext" href="http://pubads.g.doubleclick.net/gampad/clk?id=121054471&amp;iu=/4140/ostg.clktrk">http://pubads.g.doubleclick.net/gampad/clk?id=121054471&amp;iu=/4140/ostg.clktrk</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000601030301050605050205--

--------------080008030901070506010100
Content-Type: text/x-patch;
 name="ecdh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ecdh.patch"

diff --git a/README.ec b/README.ec
index e69de29..c76e0bd 100644
--- a/README.ec
+++ b/README.ec
@@ -0,0 +1,36 @@
+Now OpenVPN supports eliptic curves cryptography.
+It's advetages:
+ -very fast key generation
+ -smaller keys than using RSA
+ -wide range of curves you can use
+
+To support EC crypto OpenVPN uses openssl.
+You can get list of available curves typing:
+openssl ecparam -list_curves
+
+EC key generation is very easy:
+openssl ecparam -out ec.key -name curve_name -genkey
+You can also extract public key:
+openssl ec -in ec.key -pubout -out ec.pubkey
+You can use such key as well as RSA one in certificates generation.
+
+EC certificates don't work with DH.
+You have to use ECDH.
+Add to your OpenVPN server option:
+--ecdh curve_name
+Currently some of the curves produce SSL error 'no shared cipher' during handshake.
+Some working curves:
+secp192k1
+secp160k1
+secp224k1
+secp521r1
+prime192v1
+prime256v1
+sect233k1
+sect283r1
+sect409r1
+sect571k1
+
+You can also use ECDH with other types of certs.
+It's convenient because you don't have to generate any Diffie-Hellman file.
+
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
index d01c935..78b053f 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4240,6 +4240,28 @@ included with the OpenVPN distribution.  Diffie Hellman parameters
 may be considered public.
 .\"*********************************************************
 .TP
+.B \-\-ecdh curve_name
+Specify the curve to use for elliptic curve Diffie Hellman. Available
+curves can be listed with
+.B \-\-show-curves
+The specified curve will only be used for ECDH TLS-ciphers.
+Currently, most of the curves work, but some of them generate ssl error: 'no shared cipher'.
+If you see this, try using another curve.
+
+.B Some examples of working curves:
+
+secp192k1,
+secp160k1,
+secp224k1,
+secp521r1,
+prime192v1,
+prime256v1,
+sect233k1,
+sect283r1,
+sect409r1,
+sect571k1
+.\"*********************************************************
+.TP
 .B \-\-cert file
 Local peer's signed certificate in .pem format \-\- must be signed
 by a certificate authority whose certificate is in
@@ -5021,6 +5043,13 @@ lowest.
 Show currently available hardware-based crypto acceleration
 engines supported by the OpenSSL library.
 .\"*********************************************************
+.TP
+.B \-\-show-curves
+(Standalone)
+Show all available elliptic curves to use with the
+.B \-\-ecdh
+option.
+.\"*********************************************************
 .SS Generate a random key:
 Used only for non-TLS static key encryption mode.
 .\"*********************************************************
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d324166..d2a7770 100644
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
+    if (options->show_curves)
+       show_available_curves();
 #endif
       return true;
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e21d5a..859712d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -578,6 +578,9 @@ static const char usage_message[] =
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
+  "--ecdh curve    : Eliptic curve name for ECDH \n"
+  "--show-curves   : Show all available elliptic curves to use with the\n"
+  "                  --ecdh-curve option.\n"
   "--cert file     : Local certificate in .pem format -- must be signed\n"
   "                  by a Certificate Authority in --ca file.\n"
   "--extra-certs file : one or more PEM certs that complete the cert chain.\n"
@@ -862,6 +865,7 @@ init_options (struct options *o, const bool init_gc)
   o->renegotiate_seconds = 3600;
   o->handshake_window = 60;
   o->transition_window = 3600;
+  o->ecdh_curve = NULL;
 #ifdef ENABLE_X509ALTUSERNAME
   o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
@@ -1607,6 +1611,7 @@ show_settings (const struct options *o)
   SHOW_STR (ca_file);
   SHOW_STR (ca_path);
   SHOW_STR (dh_file);
+  SHOW_STR (ecdh_curve);
   SHOW_STR (cert_file);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
@@ -2174,10 +2179,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       (options->shared_secret_file != NULL) > 1)
     msg (M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
 
-  if (options->tls_server)
-    {
-      notnull (options->dh_file, "DH file (--dh)");
-    }
   if (options->tls_server || options->tls_client)
     {
 #ifdef ENABLE_PKCS11
@@ -2308,6 +2309,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (ca_file);
       MUST_BE_UNDEF (ca_path);
       MUST_BE_UNDEF (dh_file);
+      MUST_BE_UNDEF (ecdh_curve);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
 #ifndef ENABLE_CRYPTO_POLARSSL
@@ -2702,7 +2704,8 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** SSL/TLS/crypto related files ** */
 #ifdef ENABLE_SSL
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
+  if ( options->dh_file )
+      errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
   errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
@@ -6530,6 +6533,16 @@ add_option (struct options *options,
 	  options->dh_file_inline = p[2];
 	}
     }
+   else if (streq (p[0], "show-curves"))
+     {
+       VERIFY_PERMISSION (OPT_P_GENERAL);
+       options->show_curves = true;
+     }
+  else if (streq (p[0], "ecdh"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ecdh_curve = p[1];
+    }
   else if (streq (p[0], "cert") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bf232f4..eadc758 100644
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
@@ -508,6 +509,7 @@ struct options
   const char *ca_file;
   const char *ca_path;
   const char *dh_file;
+  const char *ecdh_curve;
   const char *cert_file;
   const char *extra_certs_file;
   const char *priv_key_file;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c61701a..3ff9712 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -474,7 +474,6 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   if (options->tls_server)
     {
       tls_ctx_server_new(new_ctx);
-      tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
     }
   else				/* if client */
     {
@@ -541,6 +540,30 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
     {
       tls_ctx_load_extra_certs(new_ctx, options->extra_certs_file, options->extra_certs_file_inline);
     }
+  
+  if ( options->tls_server )
+    {
+        bool has_dh = false;
+        
+        if ( options->dh_file || options->dh_file_inline )
+           {
+               tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
+               has_dh = true;
+           } else
+             msg(M_WARN,"You didn't specify --dh. It may cause handshake without (EC)DH in communucation with older openVPN clients.");
+        
+        if ( options->ecdh_curve )
+           {
+               tls_ctx_load_ecdh_params(new_ctx, options->ecdh_curve );
+               has_dh = true;
+           }
+        
+        if ( !has_dh )
+           {
+               msg(M_WARN, "You didn't specify any DH. ecdh=auto will be used as default.");
+               tls_ctx_load_ecdh_params(new_ctx, "auto" );
+           }
+    }
 
   /* Allowable ciphers */
   tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6fc3bd..594a402 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -186,6 +186,15 @@ void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
     const char *dh_file_inline);
 
 /**
+ * Generate ECDH Parameters, and load them into the library-specific
+ * TLS context.
+ *
+ * @param ctx           TLS context to use
+ * @param ecdh_curve    Eliptic Curve name
+ */
+void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *ecdh_curve );
+
+/**
  * Load PKCS #12 file for key, cert and (optionally) CA certs, and add to
  * library-specific TLS context.
  *
@@ -461,6 +470,11 @@ void print_details (struct key_state_ssl * ks_ssl, const char *prefix);
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
index f079652..7ce106e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -56,6 +56,7 @@
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
 #include <openssl/crypto.h>
+#include <openssl/ec.h>
 
 /*
  * Allocate space in SSL objects in which to store a struct tls_session
@@ -329,6 +330,70 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
   DH_free (dh);
 }
 
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx,const char *ecdh_curve )
+{
+  /* Generate a new ECDH key for each SSL session (for non-ephemeral ECDH) */
+  SSL_CTX_set_options(ctx->ctx, SSL_OP_SINGLE_ECDH_USE);
+  
+  int nid = NID_undef;
+  
+  if ( !ecdh_curve || streq( ecdh_curve, "auto" ) )
+     { /* autodetect ecdh curve */
+        msg (D_TLS_DEBUG_LOW, "Detecting ECDH curve automatically...");
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L
+        /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter loading */
+        SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
+        return;
+#else /* OPENSSL_VERSION_NUMBER >= 0x10002000L */
+       /* Extract curve from key */
+       EC_KEY *eckey = NULL;
+       const EC_GROUP *ecgrp = NULL;
+       EVP_PKEY *pkey = NULL;
+
+       /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
+       SSL ssl;
+       ssl.cert = ctx->ctx->cert;
+       pkey = SSL_get_privatekey(&ssl);
+
+       msg (D_TLS_DEBUG, "Extracting ECDH curve from private key");
+
+       if (pkey && (eckey = EVP_PKEY_get1_EC_KEY(pkey)) &&
+           (ecgrp = EC_KEY_get0_group(eckey)) )
+             nid = EC_GROUP_get_curve_name(ecgrp);
+       
+       if ( nid == NID_undef )
+          msg (D_TLS_DEBUG, "Detecting ECDH curve failed. Maybe you are using certificates without EC?");
+#endif /* OPENSSL_VERSION_NUMBER >= 0x10002000L */
+     } else
+     {
+         nid = OBJ_sn2nid( ecdh_curve );
+         if ( nid == NID_undef )
+            msg (D_TLS_ERRORS, "Invalid ECDH curve name '%s'", ecdh_curve );
+     }
+  
+  if ( nid == NID_undef )
+     {
+         nid = ECDH_CURVE_DEFAULT;
+         msg( D_TLS_ERRORS, "Using ECDH default curve" );
+     }
+  
+  ecdh_curve = OBJ_nid2sn( nid );
+  if ( !ecdh_curve ) ecdh_curve = "(Unknown)";
+  
+  /* generate EC parameters */
+  EC_KEY *eckey = EC_KEY_new_by_curve_name( nid );
+  if ( !eckey )
+     msg (M_SSLERR, "Cannot create ECDH params of curve '%s'", ecdh_curve );
+  
+  msg (D_TLS_DEBUG_LOW, "ECDH params of curve '%s' initialized", ecdh_curve );
+  
+  if ( !SSL_CTX_set_tmp_ecdh(ctx->ctx,eckey) )
+      msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh ");
+  
+  EC_KEY_free( eckey );
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     const char *pkcs12_file_inline,
@@ -1303,6 +1368,45 @@ show_available_tls_ciphers (const char *cipher_list)
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
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index fc2052c..050a065 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -32,6 +32,9 @@
 
 #include <openssl/ssl.h>
 
+/* default eliptic curve for ecdh */
+#define ECDH_CURVE_DEFAULT NID_secp384r1
+
 /**
  * Structure that wraps the TLS context. Contents differ depending on the
  * SSL library used.
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 9dc4e87..d20485d 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -228,6 +228,12 @@ else
       (counter_type) 8 * mpi_size(&ctx->dhm_ctx->P));
 }
 
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx,const char *ecdh_curve )
+{
+    msg( M_SSLERR, "ECDH is currently not suppored by polarssl" );
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     const char *pkcs12_file_inline,
@@ -1068,6 +1074,12 @@ show_available_tls_ciphers (const char *cipher_list)
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

--------------080008030901070506010100--

