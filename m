Date: Sat, 22 Sep 2007 20:25:45 +0300
From: Faidon Liambotis <paravoid@...334...>
Message-ID: <20070922172545.GA6614@...997...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Use CryptoAPI CA store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,
Below you will find a revised version of a patch that I sent almost 9
months before.

It allows OpenVPN to verify certificates agains the Windows Certificate Store.

Changed since v2:
 * Replace the global variable by a TLS options variable
 * Added relevant man page entry
 * Minor bugfixes (more #ifdef WIN32 to guard the variable declaration,
   spelling error etc.)
 * diff against 2.1-rc4 instead of rc1

Please review and apply :-)

Regards,
Faidon

--

diff -urp openvpn-2.1_rc4.orig/cryptoapi.c openvpn-2.1_rc4/cryptoapi.c
--- openvpn-2.1_rc4.orig/cryptoapi.c	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/cryptoapi.c	2007-09-22 14:08:09.000000000 +0300
@@ -48,6 +48,8 @@
 static HINSTANCE crypt32dll = NULL;
 static BOOL WINAPI (*CryptAcquireCertificatePrivateKey) (PCCERT_CONTEXT pCert, DWORD dwFlags,
     void *pvReserved, HCRYPTPROV *phCryptProv, DWORD *pdwKeySpec, BOOL *pfCallerFreeProv) = NULL;
+static PCCERT_CONTEXT WINAPI (*CertCreateCertificateContext) (DWORD dwCertEncodingType,
+     const BYTE *pbCertEncoded, DWORD cbCertEncoded) = NULL;
 #endif
 
 /* Size of an SSL signature: MD5+SHA1 */
@@ -65,6 +67,8 @@ static BOOL WINAPI (*CryptAcquireCertifi
 #define CRYPTOAPI_F_CRYPT_SIGN_HASH			    106
 #define CRYPTOAPI_F_LOAD_LIBRARY			    107
 #define CRYPTOAPI_F_GET_PROC_ADDRESS			    108
+#define CRYPTOAPI_F_CERT_CREATE_CERT_CONTEXT		    109
+#define CRYPTOAPI_F_CERT_GET_CERT_CHAIN			    110
 
 static ERR_STRING_DATA CRYPTOAPI_str_functs[] =	{
     { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),				    "microsoft cryptoapi"},
@@ -77,6 +81,8 @@ static ERR_STRING_DATA CRYPTOAPI_str_fun
     { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),			    "CryptSignHash" },
     { ERR_PACK(0, CRYPTOAPI_F_LOAD_LIBRARY, 0),			    	    "LoadLibrary" },
     { ERR_PACK(0, CRYPTOAPI_F_GET_PROC_ADDRESS, 0),			    "GetProcAddress" },
+    { ERR_PACK(0, CRYPTOAPI_F_CERT_CREATE_CERT_CONTEXT, 0),		    "CertCreateCertificateContext" },
+    { ERR_PACK(0, CRYPTOAPI_F_CERT_GET_CERT_CHAIN, 0),			    "CertGetCertificateChain" },
     { 0, NULL }
 };
 
@@ -364,7 +370,7 @@ int SSL_CTX_use_CryptoAPI_certificate(SS
     }
 
     /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
-    cert = d2i_X509(NULL, (unsigned char **) &cd->cert_context->pbCertEncoded,
+    cert = d2i_X509(NULL, (const unsigned char **) &cd->cert_context->pbCertEncoded,
 		    cd->cert_context->cbCertEncoded);
     if (cert == NULL) {
 	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
@@ -461,3 +467,81 @@ int SSL_CTX_use_CryptoAPI_certificate(SS
     }
     return 0;
 }
+
+int CryptoAPI_verify_certificate(X509 *x509)
+{
+  int ret = -1;
+  int len;
+  unsigned char *buf = NULL;
+
+  PCCERT_CONTEXT pCertContext = NULL;
+  PCCERT_CHAIN_CONTEXT pChainContext = NULL;
+  CERT_ENHKEY_USAGE EnhkeyUsage;
+  CERT_USAGE_MATCH CertUsage;  
+  CERT_CHAIN_PARA ChainPara;
+
+  /* Convert from internal X509 format to DER */
+  len = i2d_X509(x509, &buf);
+  if (len < 0) {
+	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
+	goto err;
+  }
+
+#ifdef __MINGW32_VERSION
+    /* MinGW w32api is incomplete when it comes to CryptoAPI, as per version 3.1
+     * anyway. This is a hack around that problem. */
+    if (crypt32dll == NULL) {
+	crypt32dll = LoadLibrary("crypt32");
+	if (crypt32dll == NULL) {
+	    CRYPTOAPIerr(CRYPTOAPI_F_LOAD_LIBRARY);
+	    goto err;
+	}
+    }
+    if (CertCreateCertificateContext == NULL) {
+	CertCreateCertificateContext = GetProcAddress(crypt32dll,
+		"CertCreateCertificateContext");
+	if (CertCreateCertificateContext == NULL) {
+	    CRYPTOAPIerr(CRYPTOAPI_F_GET_PROC_ADDRESS);
+	    goto err;
+	}
+    }
+#endif
+
+  /* Create a certificate context based on the above certificate */
+  pCertContext = CertCreateCertificateContext(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
+  	buf, len);
+  if (pCertContext == NULL) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CERT_CREATE_CERT_CONTEXT);
+	goto err;
+  }
+
+  /* Create an empty issuer list */
+  EnhkeyUsage.cUsageIdentifier = 0;
+  EnhkeyUsage.rgpszUsageIdentifier = NULL;
+  CertUsage.dwType = USAGE_MATCH_TYPE_AND;
+  CertUsage.Usage  = EnhkeyUsage;
+
+  /* Searching and matching criteria to be used when building the chain */
+  ChainPara.cbSize = sizeof(CERT_CHAIN_PARA);
+  ChainPara.RequestedUsage = CertUsage;
+
+  /* Get the certificate chain of our certificate */
+  if (!CertGetCertificateChain(NULL, pCertContext, NULL, NULL, &ChainPara,
+	0, NULL, &pChainContext)) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CERT_GET_CERT_CHAIN);
+	goto err;
+  }
+
+  /* return 1 when the certificate is trusted, 0 when it's not; -1 on error */
+  ret = (pChainContext->TrustStatus.dwErrorStatus == CERT_TRUST_NO_ERROR);
+
+  err:
+    if (buf)
+	OPENSSL_free(buf);
+    if (pChainContext)
+	CertFreeCertificateChain(pChainContext);
+    if (pCertContext)
+	CertFreeCertificateContext(pCertContext);
+
+  return ret;
+}
diff -urp openvpn-2.1_rc4.orig/cryptoapi.h openvpn-2.1_rc4/cryptoapi.h
--- openvpn-2.1_rc4.orig/cryptoapi.h	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/cryptoapi.h	2007-09-22 14:08:09.000000000 +0300
@@ -2,6 +2,7 @@
 #define _CRYPTOAPI_H_
 
 int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop);
+int CryptoAPI_verify_certificate(X509 *x509);
 
 
 #endif /* !_CRYPTOAPI_H_ */
diff -urp openvpn-2.1_rc4.orig/init.c openvpn-2.1_rc4/init.c
--- openvpn-2.1_rc4.orig/init.c	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/init.c	2007-09-22 14:08:09.000000000 +0300
@@ -1558,6 +1558,10 @@ do_init_crypto_tls (struct context *c, c
   to.remote_cert_eku = options->remote_cert_eku;
   to.es = c->c2.es;
 
+#ifdef WIN32
+  to.cryptoapi_ca = options->cryptoapi_ca;
+#endif
+
 #ifdef ENABLE_DEBUG
   to.gremlin = c->options.gremlin;
 #endif
diff -urp openvpn-2.1_rc4.orig/openvpn.8 openvpn-2.1_rc4/openvpn.8
--- openvpn-2.1_rc4.orig/openvpn.8	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/openvpn.8	2007-09-22 14:33:27.000000000 +0300
@@ -124,6 +124,7 @@ openvpn \- secure IP tunnel daemon.
 [\ \fB\-\-connect\-retry\-max\fR\ \fIn\fR\ ]
 [\ \fB\-\-crl\-verify\fR\ \fIcrl\fR\ ]
 [\ \fB\-\-cryptoapicert\fR\ \fIselect\-string\fR\ ]
+[\ \fB\-\-cryptoapica\fR\ ]
 [\ \fB\-\-daemon\fR\ \fI[progname]\fR\ ]
 [\ \fB\-\-dev\-node\fR\ \fInode\fR\ ]
 [\ \fB\-\-dev\-type\fR\ \fIdevice\-type\fR\ ]
@@ -3769,7 +3770,26 @@ To select a certificate, based on certif
 
 The thumbprint hex string can easily be copy-and-pasted from the Windows
 Certificate Store GUI.
+.\"*********************************************************
+.TP
+.B --cryptoapica
+Use the Windows Certficate System Store to verify presented certificates
+(Windows Only).
+
+Use this option instead of or in addition to
+.B --ca.
+
+This makes it possible to verify certificates against the Certificate Store
+instead of having OpenVPN read the certificate authority (CA) file.
+Windows Certificate Store checks Certificate Revocation Lists (CRLs)
+automatically and will reject revoked certificates.
 
+The Certificate Store includes by default many known Certificate Authorities.
+Use this setting with extreme caution and preferrably in combination with
+.B --tls-verify
+or
+.B --tls-remote
+options.
 .\"*********************************************************
 .TP
 .B --key-method m
diff -urp openvpn-2.1_rc4.orig/options.c openvpn-2.1_rc4/options.c
--- openvpn-2.1_rc4.orig/options.c	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/options.c	2007-09-22 14:15:41.000000000 +0300
@@ -450,6 +450,8 @@ static const char usage_message[] =
 #ifdef WIN32
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
+  "--cryptoapica   : Check against Certificate Authorities stored in Windows\n"
+  "                  Certificate System Store.\n"
 #endif
   "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
   "                : Use --show-tls to see a list of supported TLS ciphers.\n"
@@ -1236,6 +1238,7 @@ show_settings (const struct options *o)
   SHOW_STR (pkcs12_file);
 #ifdef WIN32
   SHOW_STR (cryptoapi_cert);
+  SHOW_BOOL (cryptoapi_ca);
 #endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
@@ -1809,8 +1812,8 @@ options_postprocess (struct options *opt
 #ifdef WIN32
       if (options->cryptoapi_cert)
 	{
-	  if ((!(options->ca_file)) && (!(options->ca_path)))
-	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+	  if ((!(options->ca_file)) && (!(options->ca_path)) && (!(options->cryptoapi_ca)))
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath) or CryptoAPI CA (--cryptoapica)");
           if (options->cert_file)
 	    msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
           if (options->priv_key_file)
@@ -1831,8 +1834,13 @@ options_postprocess (struct options *opt
         }
       else
         {
+#ifdef WIN32
+	  if ((!(options->ca_file)) && (!(options->ca_path)) && (!(options->cryptoapi_ca)))
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath) or CryptoAPI CAs (--cryptoapica)");
+#else
 	  if ((!(options->ca_file)) && (!(options->ca_path)))
 	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+#endif
 	  if (pull)
 	    {
 	      const int sum = (options->cert_file != NULL) + (options->priv_key_file != NULL);
@@ -4889,6 +4897,11 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->cryptoapi_cert = p[1];
     }
+  else if (streq (p[0], "cryptoapica"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->cryptoapi_ca = true;
+    }
 #endif
   else if (streq (p[0], "key") && p[1])
     {
diff -urp openvpn-2.1_rc4.orig/options.h openvpn-2.1_rc4/options.h
--- openvpn-2.1_rc4.orig/options.h	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/options.h	2007-09-22 14:08:09.000000000 +0300
@@ -424,6 +424,7 @@ struct options
 
 #ifdef WIN32
   const char *cryptoapi_cert;
+  bool cryptoapi_ca;
 #endif
 
   /* data channel key exchange method */
diff -urp openvpn-2.1_rc4.orig/proxy.c openvpn-2.1_rc4/proxy.c
--- openvpn-2.1_rc4.orig/proxy.c	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/proxy.c	2007-09-22 14:08:09.000000000 +0300
@@ -39,7 +39,7 @@
 #include "base64.h"
 #include "ntlm.h"
 
-#ifdef WIN32
+#if defined(WIN32) && !defined(__MINGW32__)
 #include "ieproxy.h"
 #endif
 
diff -urp openvpn-2.1_rc4.orig/ssl.c openvpn-2.1_rc4/ssl.c
--- openvpn-2.1_rc4.orig/ssl.c	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/ssl.c	2007-09-22 14:20:24.000000000 +0300
@@ -543,13 +543,19 @@ verify_callback (int preverify_ok, X509_
   msg (D_LOW, "X509: %s", subject);
 #endif
 
-  /* did peer present cert which was signed our root cert? */
+  /* did peer present cert which was signed by our root cert? */
   if (!preverify_ok)
     {
-      /* Remote site specified a certificate, but it's not correct */
-      msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
-	   ctx->error_depth, X509_verify_cert_error_string (ctx->error), subject);
-      goto err;			/* Reject connection */
+#ifdef WIN32
+     /* if cryptoapica was not enabled, fail; otherwise check against the CA Store */
+     if (!(opt->cryptoapi_ca && CryptoAPI_verify_certificate(ctx->current_cert)))
+#endif
+      {
+        /* Remote site specified a certificate, but it's not correct */
+        msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
+	     ctx->error_depth, X509_verify_cert_error_string (ctx->error), subject);
+        goto err;			/* Reject connection */
+      }
     }
 
   /* warn if cert chain is too deep */
diff -urp openvpn-2.1_rc4.orig/ssl.h openvpn-2.1_rc4/ssl.h
--- openvpn-2.1_rc4.orig/ssl.h	2007-04-26 00:38:46.000000000 +0300
+++ openvpn-2.1_rc4/ssl.h	2007-09-22 14:21:06.000000000 +0300
@@ -415,6 +415,9 @@ struct tls_options
   int ns_cert_type;
   unsigned remote_cert_ku[MAX_PARMS];
   const char *remote_cert_eku;
+#ifdef WIN32
+  bool cryptoapi_ca;
+#endif
 
   /* allow openvpn config info to be
      passed over control channel */

