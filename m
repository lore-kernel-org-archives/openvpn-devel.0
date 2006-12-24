Date: Sun, 24 Dec 2006 23:29:18 +0200
From: Faidon Liambotis <paravoid@...334...>
Message-ID: <20061224212918.GA6271@...997...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use CryptoAPI CA store
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

Hello,

Below you will find a patch that creates a new configuration option
--cryptoapicastore (the naming sucks, I know...) which enables certificate
verification using Windows Certificate Stores (CA and ROOT).
It can be used in addition to --cafile and --capath or standalone.
I have compile and briefly runtime tested it and it works as intended.
It should be used with care -and this should probably be noted
somewhere- and preferrably in conjuction with tls-verify or tls-remote
and/or password authentication.
I have a couple of improvements in mind (e.g. optionally filtering by
certificate subject) and the documentation for the manpage is missing,
but I'm posting this early since I will be on vacation for the next
week.

Happy holidays :-)

Best regards,
Faidon 

diff -Nur openvpn-2.1_rc1/cryptoapi.c openvpn-2.1_rc1-void/cryptoapi.c
--- openvpn-2.1_rc1/cryptoapi.c	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1_rc1-void/cryptoapi.c	2006-12-22 19:20:34.000000000 +0200
@@ -48,6 +48,8 @@
 static HINSTANCE crypt32dll = NULL;
 static BOOL WINAPI (*CryptAcquireCertificatePrivateKey) (PCCERT_CONTEXT pCert, DWORD dwFlags,
     void *pvReserved, HCRYPTPROV *phCryptProv, DWORD *pdwKeySpec, BOOL *pfCallerFreeProv) = NULL;
+static PCCERT_CONTEXT WINAPI (*CertEnumCertificatesInStore) (HCERTSTORE hCertStore,
+     PCCERT_CONTEXT pPrevCertContext) = NULL;
 #endif
 
 /* Size of an SSL signature: MD5+SHA1 */
@@ -364,7 +366,8 @@
     }
 
     /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
-    cert = d2i_X509(NULL, (unsigned char **) &cd->cert_context->pbCertEncoded,
+    cert = d2i_X509(NULL,
+    		    (const unsigned char **) &cd->cert_context->pbCertEncoded,
 		    cd->cert_context->cbCertEncoded);
     if (cert == NULL) {
 	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
@@ -461,3 +464,57 @@
     }
     return 0;
 }
+
+int SSL_CTX_add_CryptoAPI_certificate_store(SSL_CTX *ssl_ctx, const char *store)
+{
+    HCERTSTORE cs;
+    PCCERT_CONTEXT ctx = NULL;
+    X509 *cert = NULL;
+
+    cs = CertOpenSystemStore(0, store);
+    if (cs == NULL) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
+	goto err;
+    }
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
+    if (CertEnumCertificatesInStore == NULL) {
+	CertEnumCertificatesInStore = GetProcAddress(crypt32dll,
+		"CertEnumCertificatesInStore");
+	if (CertEnumCertificatesInStore == NULL) {
+	    CRYPTOAPIerr(CRYPTOAPI_F_GET_PROC_ADDRESS);
+	    goto err;
+	}
+    }
+#endif
+
+    while ((ctx = CertEnumCertificatesInStore(cs, ctx))) {
+	cert = d2i_X509(NULL, (const unsigned char **) &ctx->pbCertEncoded,
+			ctx->cbCertEncoded);
+	if (cert == NULL) {
+	    SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
+	    goto err;
+	}
+
+	if (!X509_STORE_add_cert(ssl_ctx->cert_store, cert)) {
+	  goto err;
+	}
+	X509_free(cert);
+    }
+    CertCloseStore(cs, 0);
+    return 1;
+
+  err:
+    if (cert)
+	X509_free(cert);
+    return 0;
+}
diff -Nur openvpn-2.1_rc1/cryptoapi.h openvpn-2.1_rc1-void/cryptoapi.h
--- openvpn-2.1_rc1/cryptoapi.h	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1_rc1-void/cryptoapi.h	2006-12-22 05:24:19.000000000 +0200
@@ -2,6 +2,7 @@
 #define _CRYPTOAPI_H_
 
 int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop);
+int SSL_CTX_add_CryptoAPI_certificate_store(SSL_CTX *ssl_ctx, const char *store);
 
 
 #endif /* !_CRYPTOAPI_H_ */
diff -Nur openvpn-2.1_rc1/options.c openvpn-2.1_rc1-void/options.c
--- openvpn-2.1_rc1/options.c	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1_rc1-void/options.c	2006-12-22 06:51:37.000000000 +0200
@@ -447,6 +447,7 @@
 #ifdef WIN32
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
+  "--cryptoapicastore : Add Windows Certificate Store Certificate Authorities.\n"
 #endif
   "--tls-cipher l  : A list l of allowable TLS ciphers separated by : (optional).\n"
   "                : Use --show-tls to see a list of supported TLS ciphers.\n"
@@ -1233,6 +1234,7 @@
   SHOW_STR (pkcs12_file);
 #ifdef WIN32
   SHOW_STR (cryptoapi_cert);
+  SHOW_BOOL (cryptoapi_castore);
 #endif
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
@@ -1806,8 +1808,8 @@
 #ifdef WIN32
       if (options->cryptoapi_cert)
 	{
-	  if ((!(options->ca_file)) && (!(options->ca_path)))
-	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+	  if ((!(options->ca_file)) && (!(options->ca_path)) && (!(options->cryptoapi_castore)))
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath) or CryptoAPI CAs (--cryptoapicastore");
           if (options->cert_file)
 	    msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
           if (options->priv_key_file)
@@ -1828,8 +1830,12 @@
         }
       else
         {
-	  if ((!(options->ca_file)) && (!(options->ca_path)))
+	  if ((!(options->ca_file)) && (!(options->ca_path)) && (!(options->cryptoapi_castore)))
+#ifdef WIN32
+	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath) or CryptoAPI CAs (--cryptoapicastore");
+#else
 	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
+#endif
 	  if (pull)
 	    {
 	      const int sum = (options->cert_file != NULL) + (options->priv_key_file != NULL);
@@ -4886,6 +4892,11 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->cryptoapi_cert = p[1];
     }
+  else if (streq (p[0], "cryptoapicastore"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->cryptoapi_castore = true;
+    }
 #endif
   else if (streq (p[0], "key") && p[1])
     {
diff -Nur openvpn-2.1_rc1/options.h openvpn-2.1_rc1-void/options.h
--- openvpn-2.1_rc1/options.h	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1_rc1-void/options.h	2006-12-22 06:51:05.000000000 +0200
@@ -424,6 +424,7 @@
 
 #ifdef WIN32
   const char *cryptoapi_cert;
+  bool cryptoapi_castore;
 #endif
 
   /* data channel key exchange method */
diff -Nur openvpn-2.1_rc1/ssl.c openvpn-2.1_rc1-void/ssl.c
--- openvpn-2.1_rc1/ssl.c	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1_rc1-void/ssl.c	2006-12-22 06:55:45.000000000 +0200
@@ -1276,6 +1276,17 @@
       }
     }
 
+#ifdef WIN32
+      if (options->cryptoapi_castore)
+	{
+	  /* Add CAs from Windows' certification stores to our store */
+	  if (!SSL_CTX_add_CryptoAPI_certificate_store(ctx, "CA"))
+	    msg (M_SSLERR, "Cannot load CA certificates from Microsoft Certificate Store");
+	  if (!SSL_CTX_add_CryptoAPI_certificate_store(ctx, "ROOT"))
+	    msg (M_SSLERR, "Cannot load Root certificates from Microsoft Certificate Store");
+	}
+#endif
+
   /* Enable the use of certificate chains */
   if (using_cert_file)
     {

