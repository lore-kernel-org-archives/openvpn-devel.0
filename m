Date: Wed, 3 Jan 2007 09:37:06 +0200
From: Faidon Liambotis <paravoid@...334...>
Message-ID: <20070103073706.GA11588@...997...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Use CryptoAPI to verify certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Ok, here's another try, even though I didn't get any comments on the
first one :-)

This is a totally different approach; the previous one was flawed in at
least two aspects:
- A certificate signed by an CA stored in the "Intermediate CA store"
but not trusted would be considered acceptable by OpenVPN.
- There wasn't any CRL checking.

This time, instead of importing CryptoAPI stores into OpenSSL, I'm using
CryptoAPI functions to actually check for the trust status of the
certificate in OpenSSL's verify callback. This way, we are submitting
the server's certificate to the same criteria as any other native
Windows (i.e. non-OpenSSL) application would.

As always, the patch has been compile and runtime tested. No manpage
documentation yet -even though it's fairly obvious-, I'm still waiting for
comments.

Best regards,
Faidon

diff -Nurp openvpn-2.1_rc1/cryptoapi.c openvpn-2.1_rc1-void/cryptoapi.c
--- openvpn-2.1_rc1/cryptoapi.c	Mon Oct 16 01:30:21 2006
+++ openvpn-2.1_rc1-void/cryptoapi.c	Wed Jan  3 09:09:52 2007
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
@@ -460,4 +466,82 @@ int SSL_CTX_use_CryptoAPI_certificate(SS
 	}
     }
     return 0;
+}
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
 }
diff -Nurp openvpn-2.1_rc1/cryptoapi.h openvpn-2.1_rc1-void/cryptoapi.h
--- openvpn-2.1_rc1/cryptoapi.h	Mon Oct 16 01:30:21 2006
+++ openvpn-2.1_rc1-void/cryptoapi.h	Wed Jan  3 09:01:13 2007
@@ -2,6 +2,7 @@
 #define _CRYPTOAPI_H_
 
 int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop);
+int CryptoAPI_verify_certificate(X509 *x509);
 
 
 #endif /* !_CRYPTOAPI_H_ */
diff -Nurp openvpn-2.1_rc1/options.c openvpn-2.1_rc1-void/options.c
--- openvpn-2.1_rc1/options.c	Mon Oct 16 01:30:21 2006
+++ openvpn-2.1_rc1-void/options.c	Wed Jan  3 09:01:13 2007
@@ -447,6 +447,7 @@ static const char usage_message[] =
 #ifdef WIN32
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
+  "--cryptoapica : Add Windows Certificate Store Certificate Authorities.\n"
 #endif
   "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
   "                : Use --show-tls to see a list of supported TLS ciphers.\n"
@@ -1233,6 +1234,7 @@ show_settings (const struct options *o)
   SHOW_STR (pkcs12_file);
 #ifdef WIN32
   SHOW_STR (cryptoapi_cert);
+  SHOW_BOOL (cryptoapi_ca);
 #endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
@@ -1806,8 +1808,8 @@ options_postprocess (struct options *opt
 #ifdef WIN32
       if (options->cryptoapi_cert)
 	{
-	  if ((!(options->ca_file)) && (!(options->ca_path)))
-	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+	  if ((!(options->ca_file)) && (!(options->ca_path)) && (!(options->cryptoapi_ca)))
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath) or CryptoAPI CAs (--cryptoapica");
           if (options->cert_file)
 	    msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
           if (options->priv_key_file)
@@ -1828,8 +1830,12 @@ options_postprocess (struct options *opt
         }
       else
         {
-	  if ((!(options->ca_file)) && (!(options->ca_path)))
+	  if ((!(options->ca_file)) && (!(options->ca_path)) && (!(options->cryptoapi_ca)))
+#ifdef WIN32
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath) or CryptoAPI CAs (--cryptoapica");
+#else
 	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+#endif
 	  if (pull)
 	    {
 	      const int sum = (options->cert_file != NULL) + (options->priv_key_file != NULL);
@@ -4885,6 +4891,11 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->cryptoapi_cert = p[1];
+    }
+  else if (streq (p[0], "cryptoapica"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->cryptoapi_ca = true;
     }
 #endif
   else if (streq (p[0], "key") && p[1])
diff -Nurp openvpn-2.1_rc1/options.h openvpn-2.1_rc1-void/options.h
--- openvpn-2.1_rc1/options.h	Mon Oct 16 01:30:21 2006
+++ openvpn-2.1_rc1-void/options.h	Wed Jan  3 09:01:13 2007
@@ -424,6 +424,7 @@ struct options
 
 #ifdef WIN32
   const char *cryptoapi_cert;
+  bool cryptoapi_ca;
 #endif
 
   /* data channel key exchange method */
diff -Nurp openvpn-2.1_rc1/ssl.c openvpn-2.1_rc1-void/ssl.c
--- openvpn-2.1_rc1/ssl.c	Mon Oct 16 01:30:21 2006
+++ openvpn-2.1_rc1-void/ssl.c	Wed Jan  3 09:01:13 2007
@@ -56,6 +56,7 @@
 
 #ifdef WIN32
 #include "cryptoapi.h"
+static bool cryptoapi_ca; /* GLOBAL */
 #endif
 
 #include "memdbg.h"
@@ -537,13 +538,18 @@ verify_callback (int preverify_ok, X509_
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
+     if (!(cryptoapi_ca && CryptoAPI_verify_certificate(ctx->current_cert)))
+#endif
+      {
+        /* Remote site specified a certificate, but it's not correct */
+        msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
+	     ctx->error_depth, X509_verify_cert_error_string (ctx->error), subject);
+        goto err;			/* Reject connection */
+      }
     }
 
   /* warn if cert chain is too deep */
@@ -1275,6 +1281,12 @@ init_ssl (const struct options *options)
         SSL_CTX_set_client_CA_list (ctx, cert_names);
       }
     }
+
+#ifdef WIN32
+  /* Set a global variable so verify_callback can check it */
+  if (options->cryptoapi_ca)
+    cryptoapi_ca = true;
+#endif
 
   /* Enable the use of certificate chains */
   if (using_cert_file)

