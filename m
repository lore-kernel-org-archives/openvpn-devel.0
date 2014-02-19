Message-ID: <5304AFE4.2050702@...277...>
Date: Wed, 19 Feb 2014 14:21:40 +0100
From: pietrek -- <pietrek.j@...277...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...> <20140218085500.GU16637@...1296...>
	<530340C4.5060702@...277...>
	<20140218115015.GW16637@...1296...>
In-Reply-To: <20140218115015.GW16637@...1296...>
Content-Type: multipart/mixed; boundary="------------040603000005060405080508"
Subject: Re: [Openvpn-devel] ECDH support
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
--------------040603000005060405080508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/18/14 12:50, Gert Doering wrote:
> Hi,
>
> On Tue, Feb 18, 2014 at 12:15:16PM +0100, pietrek -- wrote:
>>> Which parts of the key handshake does it cover?  Signature/Certificates,
>>> or *only* DH?
>> Handshake only, EC certificates worked for me without doing anything.
>> Also, DH didn't work with EC certificates( no such cipher ).
> I see.
>
> Seems what we need as well is a README file that explains about EC crypto,
> as in
>
>   - how do I generate and use an EC certificate?
>   - how do I use an EC curve for DH?
>   - how do I use EC for session keying?
>
> because otherwise our users will be even more confused than I am.
>
> gert
>
Hi,
I added README.ec to my patch
    Piotr Jarosz


--------------040603000005060405080508
Content-Type: text/x-patch;
 name="ecdh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ecdh.patch"

diff --git a/README.ec b/README.ec
index e69de29..a49a687 100644
--- a/README.ec
+++ b/README.ec
@@ -0,0 +1,22 @@
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
+
+
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e21d5a..c8581e3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -578,6 +578,7 @@ static const char usage_message[] =
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
+  "--ecdh curve    : Eliptic curve ECDH parameters\n"
   "--cert file     : Local certificate in .pem format -- must be signed\n"
   "                  by a Certificate Authority in --ca file.\n"
   "--extra-certs file : one or more PEM certs that complete the cert chain.\n"
@@ -1607,6 +1608,7 @@ show_settings (const struct options *o)
   SHOW_STR (ca_file);
   SHOW_STR (ca_path);
   SHOW_STR (dh_file);
+  SHOW_STR (ecdh_curve);
   SHOW_STR (cert_file);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
@@ -2176,7 +2178,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
   if (options->tls_server)
     {
-      notnull (options->dh_file, "DH file (--dh)");
+      if ( !options->dh_file && !options->ecdh_curve  )
+             msg(M_USAGE, "You must specify DH file (--dh) or ECDH curve name( --ecdh )");
     }
   if (options->tls_server || options->tls_client)
     {
@@ -2308,6 +2311,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (ca_file);
       MUST_BE_UNDEF (ca_path);
       MUST_BE_UNDEF (dh_file);
+      MUST_BE_UNDEF (ecdh_curve);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
 #ifndef ENABLE_CRYPTO_POLARSSL
@@ -2702,7 +2706,8 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** SSL/TLS/crypto related files ** */
 #ifdef ENABLE_SSL
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
+  if ( options->dh_file )
+      errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
   errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
@@ -6530,6 +6535,11 @@ add_option (struct options *options,
 	  options->dh_file_inline = p[2];
 	}
     }
+  else if (streq (p[0], "ecdh") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ecdh_curve = p[1];
+    }
   else if (streq (p[0], "cert") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bf232f4..abf6971 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -508,6 +508,7 @@ struct options
   const char *ca_file;
   const char *ca_path;
   const char *dh_file;
+  const char *ecdh_curve;
   const char *cert_file;
   const char *extra_certs_file;
   const char *priv_key_file;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c61701a..3a84428 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -474,7 +474,10 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   if (options->tls_server)
     {
       tls_ctx_server_new(new_ctx);
-      tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
+      if ( options->dh_file )
+          tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
+         else
+          tls_ctx_load_ecdh_params(new_ctx, options->ecdh_curve );
     }
   else				/* if client */
     {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6fc3bd..37e811a 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -186,6 +186,15 @@ void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
     const char *dh_file_inline);
 
 /**
+ * Generate ECDH Parameters, and load them into the library-specific
+ * TLS context.
+ *
+ * @param ctx           TLS context to use
+ * @param dh_curve      Eliptic Curve name
+ */
+void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *ecdh_curve );
+
+/**
  * Load PKCS #12 file for key, cert and (optionally) CA certs, and add to
  * library-specific TLS context.
  *
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f079652..7476430 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -329,6 +329,28 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
   DH_free (dh);
 }
 
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx,const char *ecdh_curve )
+{
+  EC_KEY *ecdh;
+  
+  int nid = OBJ_sn2nid( ecdh_curve );
+  if ( nid == NID_undef )
+      msg (M_SSLERR, "Invalid ECDH curve name '%s'", ecdh_curve );
+  
+  /* generate EC parameters */
+  ecdh = EC_KEY_new_by_curve_name( nid );
+  if ( !ecdh )
+     msg (M_SSLERR, "Cannot create ECDH params of curve %s", ecdh_curve );
+  
+  msg (D_TLS_DEBUG_LOW, "ECDH params of curve %s initialized", ecdh_curve );
+  
+  if ( !SSL_CTX_set_tmp_ecdh(ctx->ctx,ecdh) )
+      msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh");
+  
+  EC_KEY_free( ecdh );
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     const char *pkcs12_file_inline,

--------------040603000005060405080508--

