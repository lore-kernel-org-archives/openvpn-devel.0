Message-ID: <54A42616.1060707@...1856...>
Date: Wed, 31 Dec 2014 17:36:38 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
	<1414269324-14102-6-git-send-email-steffan@...1856...>
	<20141231143043.GE8134@...1296...>
In-Reply-To: <20141231143043.GE8134@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="egn57nh1iEsnbopLFE36bdvC4qfTTskCE"
Subject: Re: [Openvpn-devel] [PATCH 5/6] openssl: use crypto_msg(),
 get rid of openssl-specific code in error.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--egn57nh1iEsnbopLFE36bdvC4qfTTskCE
Content-Type: multipart/mixed; boundary="------------060305010104060709000507"

This is a multi-part message in MIME format.
--------------060305010104060709000507
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 31-12-14 15:30, Gert Doering wrote:
> On Sat, Oct 25, 2014 at 10:35:23PM +0200, Steffan Karger wrote:
>> @@ -395,17 +396,20 @@ key_des_check (uint8_t *key, int key_len, int ndc)
>>        DES_cblock *dc =3D (DES_cblock*) buf_read_alloc (&b, sizeof (DES_=
cblock));
>>        if (!dc)
>>  	{
>> -	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key m=
aterial");
>> +	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key "
>> +	      "material");
>>  	  goto err;
>=20
> Shouldn't that be a "crypto_msg()" here?

Yes, fixed.

> In general, I'd prefer to avoid breaking strings into multiple lines if
> it's just for one or two words - I don't think it improves readability,=20
> and so it's "just an extra change"...

I agree, updated. While I was looking at this again, I also made sure
curly braces are used for ifs surrounding multiline crypto_msg() calls.

Attached a v2.

-Steffan

--------------060305010104060709000507
Content-Type: text/x-patch;
	name="0001-openssl-use-crypto_msg-get-rid-of-openssl-specific-c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-openssl-use-crypto_msg-get-rid-of-openssl-specific-c.pa";
	filename*1="tch"

=46rom 0d6c48bc571e76d078903adcbe0f1ba34816de17 Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 20:20:13 +0200
Subject: [PATCH] openssl: use crypto_msg(), get rid of openssl-specific c=
ode
 in error.c

v2 - don't wrap string for a couple of words, and be more consistent
     with wrapping (use curly braces for ifs with wrapping statements)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c |  41 +++++++++------
 src/openvpn/error.c          |  29 -----------
 src/openvpn/error.h          |   5 --
 src/openvpn/ssl_openssl.c    | 117 +++++++++++++++++++++++--------------=
------
 4 files changed, 89 insertions(+), 103 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 336994f..2d81a6d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -103,13 +103,15 @@ setup_engine (const char *engine)
       if ((e =3D ENGINE_by_id (engine)) =3D=3D NULL
 	 && (e =3D try_load_engine (engine)) =3D=3D NULL)
 	{
-	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
+	  crypto_msg (M_FATAL, "OpenSSL error: cannot load engine '%s'",
+	      engine);
 	}
=20
       if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
 	{
-	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s=
'",
-	       engine);
+	  crypto_msg (M_FATAL,
+	      "OpenSSL error: ENGINE_set_default failed on engine '%s'",
+	      engine);
 	}
=20
       msg (M_INFO, "Initializing OpenSSL support for engine '%s'",
@@ -393,17 +395,20 @@ key_des_check (uint8_t *key, int key_len, int ndc)
       DES_cblock *dc =3D (DES_cblock*) buf_read_alloc (&b, sizeof (DES_c=
block));
       if (!dc)
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key ma=
terial");
+	  crypto_msg (D_CRYPT_ERRORS,
+	      "CRYPTO INFO: check_key_DES: insufficient key material");
 	  goto err;
 	}
       if (DES_is_weak_key(dc))
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected")=
;
+	  crypto_msg (D_CRYPT_ERRORS,
+	      "CRYPTO INFO: check_key_DES: weak key detected");
 	  goto err;
 	}
       if (!DES_check_key_parity (dc))
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected=
");
+	  crypto_msg (D_CRYPT_ERRORS,
+	      "CRYPTO INFO: check_key_DES: bad parity detected");
 	  goto err;
 	}
     }
@@ -452,7 +457,7 @@ cipher_kt_get (const char *ciphername)
   cipher =3D EVP_get_cipherbyname (ciphername);
=20
   if (NULL =3D=3D cipher)
-    msg (M_SSLERR, "Cipher algorithm '%s' not found", ciphername);
+    crypto_msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);=

=20
   if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
     msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d byt=
es) which is larger than " PACKAGE_NAME "'s current maximum key size (%d =
bytes)",
@@ -536,13 +541,13 @@ cipher_ctx_init (EVP_CIPHER_CTX *ctx, uint8_t *key,=
 int key_len,
=20
   EVP_CIPHER_CTX_init (ctx);
   if (!EVP_CipherInit (ctx, kt, NULL, NULL, enc))
-    msg (M_SSLERR, "EVP cipher init #1");
+    crypto_msg (M_FATAL, "EVP cipher init #1");
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
   if (!EVP_CIPHER_CTX_set_key_length (ctx, key_len))
-    msg (M_SSLERR, "EVP set key size");
+    crypto_msg (M_FATAL, "EVP set key size");
 #endif
   if (!EVP_CipherInit (ctx, NULL, key, NULL, enc))
-    msg (M_SSLERR, "EVP cipher init #2");
+    crypto_msg (M_FATAL, "EVP cipher init #2");
=20
   /* make sure we used a big enough key */
   ASSERT (EVP_CIPHER_CTX_key_length (ctx) <=3D key_len);
@@ -589,7 +594,9 @@ int
 cipher_ctx_update (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
     uint8_t *src, int src_len)
 {
-  return EVP_CipherUpdate (ctx, dst, dst_len, src, src_len);
+  if (!EVP_CipherUpdate (ctx, dst, dst_len, src, src_len))
+    crypto_msg(M_FATAL, "%s: EVP_CipherUpdate() failed", __func__);
+  return 1;
 }
=20
 int
@@ -624,12 +631,14 @@ md_kt_get (const char *digest)
   ASSERT (digest);
   md =3D EVP_get_digestbyname (digest);
   if (!md)
-    msg (M_SSLERR, "Message hash algorithm '%s' not found", digest);
+    crypto_msg (M_FATAL, "Message hash algorithm '%s' not found", digest=
);
   if (EVP_MD_size (md) > MAX_HMAC_KEY_LENGTH)
-    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size =
(%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash s=
ize (%d bytes)",
-	 digest,
-	 EVP_MD_size (md),
-	 MAX_HMAC_KEY_LENGTH);
+    {
+      crypto_msg (M_FATAL, "Message hash algorithm '%s' uses a default h=
ash "
+	  "size (%d bytes) which is larger than " PACKAGE_NAME "'s current "
+	  "maximum hash size (%d bytes)",
+	  digest, EVP_MD_size (md), MAX_HMAC_KEY_LENGTH);
+    }
   return md;
 }
=20
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index fd9f19d..9d52962 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -43,13 +43,6 @@
 #include "ps.h"
 #include "mstats.h"
=20
-#ifdef ENABLE_CRYPTO
-#ifdef ENABLE_CRYPTO_OPENSSL
-#include <openssl/err.h>
-#endif
-#endif
-
-#include "memdbg.h"
=20
 #if SYSLOG_CAPABILITY
 #ifndef LOG_OPENVPN
@@ -265,28 +258,6 @@ void x_msg_va (const unsigned int flags, const char =
*format, va_list arglist)
       SWAP;
     }
=20
-#ifdef ENABLE_CRYPTO
-#ifdef ENABLE_CRYPTO_OPENSSL
-  if (flags & M_SSL)
-    {
-      int nerrs =3D 0;
-      size_t err;
-      while ((err =3D ERR_get_error ()))
-	{
-	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s: %s",
-			    m1, ERR_error_string (err, NULL));
-	  SWAP;
-	  ++nerrs;
-	}
-      if (!nerrs)
-	{
-	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s (OpenSSL)", m1);
-	  SWAP;
-	}
-    }
-#endif
-#endif
-
   if (flags & M_OPTERR)
     {
       openvpn_snprintf (m2, ERR_BUF_SIZE, "Options error: %s", m1);
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index a977f51..d5204f3 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -93,10 +93,6 @@ extern int x_msg_line_num;
=20
 #define M_ERRNO           (1<<8)	 /* show errno description */
=20
-#ifdef ENABLE_CRYPTO_OPENSSL
-#  define M_SSL             (1<<10)	 /* show SSL error */
-#endif
-
 #define M_NOMUTE          (1<<11)        /* don't do mute processing */
 #define M_NOPREFIX        (1<<12)        /* don't show date/time prefix =
*/
 #define M_USAGE_SMALL     (1<<13)        /* fatal options error, call us=
age_small */
@@ -107,7 +103,6 @@ extern int x_msg_line_num;
=20
 /* flag combinations which are frequently used */
 #define M_ERR     (M_FATAL | M_ERRNO)
-#define M_SSLERR  (M_FATAL | M_SSL)
 #define M_USAGE   (M_USAGE_SMALL | M_NOPREFIX | M_OPTERR)
 #define M_CLIENT  (M_MSG_VIRT_OUT | M_NOMUTE | M_NOIPREFIX)
=20
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 57fcadb..943408e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -104,7 +104,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   ctx->ctx =3D SSL_CTX_new (SSLv23_server_method ());
=20
   if (ctx->ctx =3D=3D NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
+    crypto_msg (M_FATAL, "SSL_CTX_new SSLv23_server_method");
 }
=20
 void
@@ -115,7 +115,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   ctx->ctx =3D SSL_CTX_new (SSLv23_client_method ());
=20
   if (ctx->ctx =3D=3D NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
+    crypto_msg (M_FATAL, "SSL_CTX_new SSLv23_client_method");
 }
=20
 void
@@ -235,7 +235,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, co=
nst char *ciphers)
     {
       /* Use sane default (disable export, and unsupported cipher modes)=
 */
       if(!SSL_CTX_set_cipher_list(ctx->ctx, "DEFAULT:!EXP:!PSK:!SRP"))
-        msg(M_SSLERR, "Failed to set default TLS cipher list.");
+	crypto_msg (M_FATAL, "Failed to set default TLS cipher list.");
       return;
     }
=20
@@ -287,9 +287,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, c=
onst char *ciphers)
 	}
=20
       // Make sure new cipher name fits in cipher string
-      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_=
cipher_len) {
-	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%d)=
=2E", (int)sizeof(openssl_ciphers)-1);
-      }
+      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_=
cipher_len)
+	{
+	  crypto_msg (M_FATAL,
+	      "Failed to set restricted TLS cipher list, too long (>%d).",
+	      (int)sizeof(openssl_ciphers)-1);
+	}
=20
       // Concatenate cipher name to OpenSSL cipher string
       memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, curr=
ent_cipher_len);
@@ -305,7 +308,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, co=
nst char *ciphers)
=20
   // Set OpenSSL cipher list
   if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
-    msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s", openss=
l_ciphers);
+    crypto_msg (M_FATAL, "Failed to set restricted TLS cipher list: %s",=
 openssl_ciphers);
 }
=20
 void
@@ -321,22 +324,22 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, c=
onst char *dh_file,
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
     {
       if (!(bio =3D BIO_new_mem_buf ((char *)dh_file_inline, -1)))
-	msg (M_SSLERR, "Cannot open memory BIO for inline DH parameters");
+	crypto_msg (M_FATAL, "Cannot open memory BIO for inline DH parameters")=
;
     }
   else
     {
       /* Get Diffie Hellman Parameters */
       if (!(bio =3D BIO_new_file (dh_file, "r")))
-	msg (M_SSLERR, "Cannot open %s for DH parameters", dh_file);
+	crypto_msg (M_FATAL, "Cannot open %s for DH parameters", dh_file);
     }
=20
   dh =3D PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
   BIO_free (bio);
=20
   if (!dh)
-    msg (M_SSLERR, "Cannot load DH parameters from %s", dh_file);
+    crypto_msg (M_FATAL, "Cannot load DH parameters from %s", dh_file);
   if (!SSL_CTX_set_tmp_dh (ctx->ctx, dh))
-    msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
+    crypto_msg (M_FATAL, "SSL_CTX_set_tmp_dh");
=20
   msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
        8 * DH_size (dh));
@@ -405,7 +408,7 @@ tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, c=
onst char *curve_name
     }
=20
   if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
-    msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: cannot add curve");
+    crypto_msg (M_FATAL, "SSL_CTX_set_tmp_ecdh: cannot add curve");
=20
   msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", sname);
=20
@@ -441,7 +444,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const c=
har *pkcs12_file,
       BIO_push(b64, bio);
       p12 =3D d2i_PKCS12_bio(b64, NULL);
       if (!p12)
-	msg(M_SSLERR, "Error reading inline PKCS#12 file");
+	crypto_msg (M_FATAL, "Error reading inline PKCS#12 file");
       BIO_free(b64);
       BIO_free(bio);
     }
@@ -449,11 +452,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const=
 char *pkcs12_file,
     {
       /* Load the PKCS #12 file */
       if (!(fp =3D platform_fopen(pkcs12_file, "rb")))
-	msg(M_SSLERR, "Error opening file %s", pkcs12_file);
+	crypto_msg (M_FATAL, "Error opening file %s", pkcs12_file);
       p12 =3D d2i_PKCS12_fp(fp, NULL);
       fclose(fp);
       if (!p12)
-	msg(M_SSLERR, "Error reading PKCS#12 file %s", pkcs12_file);
+	crypto_msg (M_FATAL, "Error reading PKCS#12 file %s", pkcs12_file);
     }
=20
   /* Parse the PKCS #12 file */
@@ -476,16 +479,16 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const=
 char *pkcs12_file,
=20
   /* Load Certificate */
   if (!SSL_CTX_use_certificate (ctx->ctx, cert))
-   msg (M_SSLERR, "Cannot use certificate");
+    crypto_msg (M_FATAL, "Cannot use certificate");
=20
   /* Load Private Key */
   if (!SSL_CTX_use_PrivateKey (ctx->ctx, pkey))
-   msg (M_SSLERR, "Cannot use private key");
+    crypto_msg (M_FATAL, "Cannot use private key");
   warn_if_group_others_accessible (pkcs12_file);
=20
   /* Check Private Key */
   if (!SSL_CTX_check_private_key (ctx->ctx))
-   msg (M_SSLERR, "Private key does not match the certificate");
+    crypto_msg (M_FATAL, "Private key does not match the certificate");
=20
   /* Set Certificate Verification chain */
   if (load_ca_file)
@@ -499,9 +502,9 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const c=
har *pkcs12_file,
 	for (i =3D 0; i < sk_X509_num(ca); i++)
 	  {
 	    if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_value(ca, i))=
)
-	      msg (M_SSLERR, "Cannot add certificate to certificate chain (X509=
_STORE_add_cert)");
+	      crypto_msg (M_FATAL,"Cannot add certificate to certificate chain =
(X509_STORE_add_cert)");
 	    if (!SSL_CTX_add_client_CA(ctx->ctx, sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add certificate to client CA list (SSL_CTX=
_add_client_CA)");
+	      crypto_msg (M_FATAL,"Cannot add certificate to client CA list (SS=
L_CTX_add_client_CA)");
 	  }
       }
    } else {
@@ -515,7 +518,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const c=
har *pkcs12_file,
 	for (i =3D 0; i < sk_X509_num(ca); i++)
 	  {
 	    if (!SSL_CTX_add_extra_chain_cert(ctx->ctx,sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add extra certificate to chain (SSL_CTX_ad=
d_extra_chain_cert)");
+	      crypto_msg (M_FATAL, "Cannot add extra certificate to chain (SSL_=
CTX_add_extra_chain_cert)");
 	  }
       }
    }
@@ -530,8 +533,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, cons=
t char *cryptoapi_cert)
=20
   /* Load Certificate and Private Key */
   if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
-    msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft Certif=
icate Store",
-	   cryptoapi_cert);
+    crypto_msg (M_FATAL, "Cannot load certificate \"%s\" from Microsoft =
Certificate Store", cryptoapi_cert);
 }
 #endif /* WIN32 */
=20
@@ -545,9 +547,9 @@ tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BI=
O *bio)
       if (!PEM_read_bio_X509 (bio, &cert, 0, NULL)) /* takes ownership o=
f cert */
         break;
       if (!cert)
-        msg (M_SSLERR, "Error reading extra certificate");
+	crypto_msg (M_FATAL, "Error reading extra certificate");
       if (SSL_CTX_add_extra_chain_cert(ctx->ctx, cert) !=3D 1)
-        msg (M_SSLERR, "Error adding extra certificate");
+	crypto_msg (M_FATAL, "Error adding extra certificate");
     }
 }
=20
@@ -595,9 +597,9 @@ end:
   if (!ret)
     {
       if (inline_file)
-        msg (M_SSLERR, "Cannot load inline certificate file");
+	crypto_msg (M_FATAL, "Cannot load inline certificate file");
       else
-        msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
+	crypto_msg (M_FATAL, "Cannot load certificate file %s", cert_file);
     }
=20
   if (in !=3D NULL)
@@ -655,14 +657,14 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, c=
onst char *priv_key_file,
       if (management && (ERR_GET_REASON (ERR_peek_error()) =3D=3D EVP_R_=
BAD_DECRYPT))
           management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL=
);
 #endif
-      msg (M_WARN|M_SSL, "Cannot load private key file %s", priv_key_fil=
e);
+      crypto_msg (M_WARN, "Cannot load private key file %s", priv_key_fi=
le);
       goto end;
     }
   warn_if_group_others_accessible (priv_key_file);
=20
   /* Check Private Key */
   if (!SSL_CTX_check_private_key (ssl_ctx))
-    msg (M_SSLERR, "Private key does not match the certificate");
+    crypto_msg (M_FATAL, "Private key does not match the certificate");
   ret =3D 0;
=20
 end:
@@ -813,7 +815,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx=
 *ctx,
       if (rsa_meth)
 	free(rsa_meth);
     }
-  msg (M_SSLERR, "Cannot enable SSL external private key capability");
+  crypto_msg (M_FATAL, "Cannot enable SSL external private key capabilit=
y");
   return 0;
 }
=20
@@ -843,7 +845,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char=
 *ca_file,
=20
   store =3D SSL_CTX_get_cert_store(ctx->ctx);
   if (!store)
-    msg(M_SSLERR, "Cannot get certificate store (SSL_CTX_get_cert_store)=
");
+    crypto_msg (M_FATAL, "Cannot get certificate store");
=20
   /* Try to add certificates and CRLs from ca_file */
   if (ca_file)
@@ -866,7 +868,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char=
 *ca_file,
=20
               if (tls_server && !info->x509)
                 {
-                  msg (M_SSLERR, "X509 name was missing in TLS mode");
+                  crypto_msg (M_FATAL, "X509 name was missing in TLS mod=
e");
                 }
=20
               if (info->x509)
@@ -901,9 +903,12 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const cha=
r *ca_file,
=20
               if (tls_server) {
                 int cnum =3D sk_X509_NAME_num (cert_names);
-                if (cnum !=3D (prev + 1)) {
-                  msg (M_WARN, "Cannot load CA certificate file %s (entr=
y %d did not validate)", np(ca_file), added);
-                }
+                if (cnum !=3D (prev + 1))
+                  {
+		    crypto_msg (M_WARN,
+			"Cannot load CA certificate file %s (entry %d did not validate)",
+			np(ca_file), added);
+                  }
                 prev =3D cnum;
               }
=20
@@ -915,12 +920,20 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const ch=
ar *ca_file,
         SSL_CTX_set_client_CA_list (ctx->ctx, cert_names);
=20
       if (!added)
-        msg (M_SSLERR, "Cannot load CA certificate file %s (no entries w=
ere read)", np(ca_file));
+	{
+	  crypto_msg (M_FATAL,
+	      "Cannot load CA certificate file %s (no entries were read)",
+	      np(ca_file));
+	}
=20
       if (tls_server) {
         int cnum =3D sk_X509_NAME_num (cert_names);
         if (cnum !=3D added)
-          msg (M_SSLERR, "Cannot load CA certificate file %s (only %d of=
 %d entries were valid X509 names)", np(ca_file), cnum, added);
+          {
+            crypto_msg (M_FATAL, "Cannot load CA certificate file %s (on=
ly %d "
+        	"of %d entries were valid X509 names)",
+		np(ca_file), cnum, added);
+          }
       }
=20
       if (in)
@@ -934,7 +947,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char=
 *ca_file,
       if (lookup && X509_LOOKUP_add_dir (lookup, ca_path, X509_FILETYPE_=
PEM))
         msg(M_WARN, "WARNING: experimental option --capath %s", ca_path)=
;
       else
-        msg(M_SSLERR, "Cannot add lookup at --capath %s", ca_path);
+	crypto_msg (M_FATAL, "Cannot add lookup at --capath %s", ca_path);
       X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_C=
RL_CHECK_ALL);
     }
 }
@@ -951,7 +964,7 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, c=
onst char *extra_certs_file
     in =3D BIO_new_file (extra_certs_file, "r");
=20
   if (in =3D=3D NULL)
-    msg (M_SSLERR, "Cannot load extra-certs file: %s", extra_certs_file)=
;
+    crypto_msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs=
_file);
   else
     tls_ctx_add_extra_certs (ctx, in);
=20
@@ -1043,7 +1056,7 @@ getbio (BIO_METHOD * type, const char *desc)
   BIO *ret;
   ret =3D BIO_new (type);
   if (!ret)
-    msg (M_SSLERR, "Error creating %s BIO", desc);
+    crypto_msg (M_FATAL, "Error creating %s BIO", desc);
   return ret;
 }
=20
@@ -1077,16 +1090,15 @@ bio_write (BIO *bio, const uint8_t *data, int siz=
e, const char *desc)
 	    }
 	  else
 	    {
-	      msg (D_TLS_ERRORS | M_SSL, "TLS ERROR: BIO write %s error",
-		   desc);
+	      crypto_msg (D_TLS_ERRORS, "TLS ERROR: BIO write %s error", desc);=

 	      ret =3D -1;
 	      ERR_clear_error ();
 	    }
 	}
       else if (i !=3D size)
 	{
-	  msg (D_TLS_ERRORS | M_SSL,
-	       "TLS ERROR: BIO write %s incomplete %d/%d", desc, i, size);
+	  crypto_msg (D_TLS_ERRORS, "TLS ERROR: BIO write %s incomplete %d/%d",=

+	      desc, i, size);
 	  ret =3D -1;
 	  ERR_clear_error ();
 	}
@@ -1152,8 +1164,7 @@ bio_read (BIO *bio, struct buffer *buf, int maxlen,=
 const char *desc)
 	    }
 	  else
 	    {
-	      msg (D_TLS_ERRORS | M_SSL, "TLS_ERROR: BIO read %s error",
-		   desc);
+	      crypto_msg (D_TLS_ERRORS, "TLS_ERROR: BIO read %s error", desc);
 	      buf->len =3D 0;
 	      ret =3D -1;
 	      ERR_clear_error ();
@@ -1183,7 +1194,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl, co=
nst struct tls_root_ctx *ssl_
=20
   ks_ssl->ssl =3D SSL_new (ssl_ctx->ctx);
   if (!ks_ssl->ssl)
-    msg (M_SSLERR, "SSL_new failed");
+    crypto_msg (M_FATAL, "SSL_new failed");
=20
   /* put session * in ssl object so we can access it
      from verify callback*/
@@ -1358,11 +1369,11 @@ show_available_tls_ciphers (const char *cipher_li=
st)
=20
   tls_ctx.ctx =3D SSL_CTX_new (SSLv23_method ());
   if (!tls_ctx.ctx)
-    msg (M_SSLERR, "Cannot create SSL_CTX object");
+    crypto_msg (M_FATAL, "Cannot create SSL_CTX object");
=20
   ssl =3D SSL_new (tls_ctx.ctx);
   if (!ssl)
-    msg (M_SSLERR, "Cannot create SSL object");
+    crypto_msg (M_FATAL, "Cannot create SSL object");
=20
   tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
=20
@@ -1403,7 +1414,7 @@ show_available_curves()
   curves =3D OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
=20
   if (curves =3D=3D NULL)
-    msg (M_SSLERR, "Cannot create EC_builtin_curve object");
+    crypto_msg (M_FATAL, "Cannot create EC_builtin_curve object");
   else
   {
     if (EC_get_builtin_curves(curves, crv_len))
@@ -1420,7 +1431,7 @@ show_available_curves()
     }
     else
     {
-      msg (M_SSLERR, "Cannot get list of builtin curves");
+      crypto_msg (M_FATAL, "Cannot get list of builtin curves");
     }
     OPENSSL_free(curves);
   }
@@ -1439,10 +1450,10 @@ get_highest_preference_tls_cipher (char *buf, int=
 size)
=20
   ctx =3D SSL_CTX_new (SSLv23_method ());
   if (!ctx)
-    msg (M_SSLERR, "Cannot create SSL_CTX object");
+    crypto_msg (M_FATAL, "Cannot create SSL_CTX object");
   ssl =3D SSL_new (ctx);
   if (!ssl)
-    msg (M_SSLERR, "Cannot create SSL object");
+    crypto_msg (M_FATAL, "Cannot create SSL object");
=20
   cipher_name =3D SSL_get_cipher_list (ssl, 0);
   strncpynt (buf, cipher_name, size);
--=20
2.1.0


--------------060305010104060709000507--

--egn57nh1iEsnbopLFE36bdvC4qfTTskCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUpCYWAAoJEJgCyj0AftKIPSwH/RTztJO4HOZyK7YQ83jV2Pg6
JiHspPCvUDDcpKMN4cblQH7oNg4HeYlIJ8aK3GYJskrPkDGpK88RwH7OKsJ/ffw+
2l8nlIsRaa3dFq/E5O/bVfN8OGKFq3BrbzYRGsGDvy6uzHXX1AjXNs0IgG0vqdeN
wtSjoo2Soqe27/9qQh7YxTVwJWBm+XTBjW7tRADurSbQXGB8Gix48Qx+BhMwT/tN
nl1qDxkXCoKr50ixnX3OuJeeXqbNp4XPCgumWkiLTj2pS2xa8/Z6KNtkQ7TsJqVN
s5tbuoubYfdGkjDC6IUocB7HDGtcfnrBYwTBt+yrOwTpBkrKxvLvup+xovV8i44=
=ny5P
-----END PGP SIGNATURE-----

--egn57nh1iEsnbopLFE36bdvC4qfTTskCE--

