Message-ID: <416D3018.4040704@...292...>
From: "Peter 'Luna' Runestig" <peter+openvpn@...292...>
MIME-Version: 1.0
Subject: [Openvpn-devel] PATCH[2/2]: Use certificates from MS Cert Store with CryptoAPI
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 13 06:45:51 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

... and here is the CryptoAPI patch:
-----8<----------8<----------8<----------8<----------8<----------8<----------8<-----
diff -uN openvpn-2.0_beta11.msvc/SSL_CTX_use_CryptoAPI_certificate.c openvpn-2.0_beta11/SSL_CTX_use_CryptoAPI_certificate.c
--- openvpn-2.0_beta11.msvc/SSL_CTX_use_CryptoAPI_certificate.c	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0_beta11/SSL_CTX_use_CryptoAPI_certificate.c	2004-10-13 14:16:41.680180800 +0200
@@ -0,0 +1,428 @@
+/*
+ * Copyright (c) 2004 Peter 'Luna' Runestig <peter@...292...>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without modifi-
+ * cation, are permitted provided that the following conditions are met:
+ *
+ *   o  Redistributions of source code must retain the above copyright notice,
+ *      this list of conditions and the following disclaimer.
+ *
+ *   o  Redistributions in binary form must reproduce the above copyright no-
+ *      tice, this list of conditions and the following disclaimer in the do-
+ *      cumentation and/or other materials provided with the distribution.
+ *
+ *   o  The names of the contributors may not be used to endorse or promote
+ *      products derived from this software without specific prior written
+ *      permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LI-
+ * ABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN-
+ * TIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEV-
+ * ER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABI-
+ * LITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
+ * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#include <windows.h>
+#include <wincrypt.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <assert.h>
+#include <openssl\ssl.h>
+#include <openssl\err.h>
+
+/* Size of an SSL signature: MD5+SHA1 */
+#define SSL_SIG_LENGTH	36
+
+/* try to funnel any Windows/CryptoAPI error messages to OpenSSL ERR_... */
+#define ERR_LIB_CRYPTOAPI (ERR_LIB_USER + 69)	/* 69 is just a number... */
+#define CRYPTOAPIerr(f)   err_put_ms_error(GetLastError(), (f), __FILE__, __LINE__)
+#define CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE		    100
+#define CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE	    101
+#define CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY   102
+#define CRYPTOAPI_F_CRYPT_CREATE_HASH			    103
+#define CRYPTOAPI_F_CRYPT_GET_HASH_PARAM		    104
+#define CRYPTOAPI_F_CRYPT_SET_HASH_PARAM		    105
+#define CRYPTOAPI_F_CRYPT_SIGN_HASH			    106
+
+static ERR_STRING_DATA CRYPTOAPI_str_functs[] =	{
+    { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),				    "microsoft cryptoapi"},
+    { ERR_PACK(0, CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE, 0),		    "CertOpenSystemStore" },
+    { ERR_PACK(0, CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE, 0),	    "CertFindCertificateInStore" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY, 0),    "CryptAcquireCertificatePrivateKey" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_CREATE_HASH, 0),			    "CryptCreateHash" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_GET_HASH_PARAM, 0),			    "CryptGetHashParam" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SET_HASH_PARAM, 0),			    "CryptSetHashParam" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),			    "CryptSignHash" },
+    { 0, NULL }
+};
+
+typedef struct _CAPI_DATA {
+    const CERT_CONTEXT *cert_context;
+    HCRYPTPROV crypt_prov;
+    DWORD key_spec;
+    BOOL free_crypt_prov;
+} CAPI_DATA;
+
+static char *ms_error_text(DWORD ms_err)
+{
+    LPVOID lpMsgBuf = NULL;
+    char *rv = NULL;
+
+    FormatMessage(
+	FORMAT_MESSAGE_ALLOCATE_BUFFER |
+	FORMAT_MESSAGE_FROM_SYSTEM |
+	FORMAT_MESSAGE_IGNORE_INSERTS,
+	NULL, ms_err,
+	MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
+	(LPTSTR) &lpMsgBuf, 0, NULL);
+    if (lpMsgBuf) {
+	char *p;
+	rv = strdup(lpMsgBuf);
+	LocalFree(lpMsgBuf);
+	/* trim to the left */
+	if (rv)
+	    for (p = rv + strlen(rv) - 1; p >= rv; p--) {
+		if (isspace(*p))
+		    *p = '\0';
+		else
+		    break;
+	    }
+    }
+    return rv;
+}
+
+static void err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
+{
+    static int init = 0;
+#   define ERR_MAP_SZ 16
+    static struct {
+	int err;
+	DWORD ms_err;	    /* I don't think we get more than 16 *different* errors */
+    } err_map[ERR_MAP_SZ];  /* in here, before we give up the whole thing...        */
+    int i;
+
+    if (ms_err == 0)
+	/* 0 is not an error */
+	return;
+    if (!init) {
+	ERR_load_strings(ERR_LIB_CRYPTOAPI, CRYPTOAPI_str_functs);
+	memset(&err_map, 0, sizeof(err_map));
+	init++;
+    }
+    /* since MS error codes are 32 bit, and the ones in the ERR_... system is
+     * only 12, we must have a mapping table between them.  */
+    for (i = 0; i < ERR_MAP_SZ; i++) {
+	if (err_map[i].ms_err == ms_err) {
+	    ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
+	    break;
+	} else if (err_map[i].ms_err == 0 ) {
+	    /* end of table, add new entry */
+	    ERR_STRING_DATA *esd = calloc(2, sizeof(*esd));
+	    if (esd == NULL)
+		break;
+	    err_map[i].ms_err = ms_err;
+	    err_map[i].err = esd->error = i + 100;
+	    esd->string = ms_error_text(ms_err);
+	    ERR_load_strings(ERR_LIB_CRYPTOAPI, esd);
+	    ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
+	    break;
+	}
+    }
+}
+
+/* encrypt */
+static int rsa_pub_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+    /* I haven't been able to trigger this one, but I want to know if it happens... */
+    assert(0);
+
+    return 0;
+}
+
+/* verify arbitrary data */
+static int rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+    /* I haven't been able to trigger this one, but I want to know if it happens... */
+    assert(0);
+
+    return 0;
+}
+
+/* sign arbitrary data */
+static int rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+    CAPI_DATA *cd = (CAPI_DATA *) rsa->meth->app_data;
+    HCRYPTHASH hash;
+    DWORD hash_size, len, i;
+    unsigned char *buf;
+
+    if (cd == NULL) {
+	RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
+	return 0;
+    }
+    if (padding != RSA_PKCS1_PADDING) {
+	/* AFAICS, CryptSignHash() *always* uses PKCS1 padding. */
+	RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
+	return 0;
+    }
+    /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
+     * be way to straightforward for M$, I guess... So we have to do it this
+     * tricky way instead, by creating a "Hash", and load the already-made hash
+     * from 'from' into it.  */
+    /* For now, we only support NID_md5_sha1 */
+    if (flen != SSL_SIG_LENGTH) {
+	RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
+	return 0;
+    }
+    if (!CryptCreateHash(cd->crypt_prov, CALG_SSL3_SHAMD5, 0, 0, &hash)) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_CREATE_HASH);
+	return 0;
+    }
+    len = sizeof(hash_size);
+    if (!CryptGetHashParam(hash, HP_HASHSIZE, (BYTE *) &hash_size, &len, 0)) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_GET_HASH_PARAM);
+        CryptDestroyHash(hash);
+	return 0;
+    }
+    if ((int) hash_size != flen) {
+	RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
+        CryptDestroyHash(hash);
+	return 0;
+    }
+    if (!CryptSetHashParam(hash, HP_HASHVAL, (BYTE * ) from, 0)) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_SET_HASH_PARAM);
+        CryptDestroyHash(hash);
+	return 0;
+    }
+
+    len = RSA_size(rsa);
+    buf = malloc(len);
+    if (buf == NULL) {
+	RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, ERR_R_MALLOC_FAILURE);
+        CryptDestroyHash(hash);
+	return 0;
+    }
+    if (!CryptSignHash(hash, cd->key_spec, NULL, 0, buf, &len)) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_SIGN_HASH);
+        CryptDestroyHash(hash);
+        free(buf);
+	return 0;
+    }
+    /* and now, we have to reverse the byte-order in the result from CryptSignHash()... */
+    for (i = 0; i < len; i++)
+	to[i] = buf[len - i - 1];
+    free(buf);
+
+    CryptDestroyHash(hash);
+    return len;
+}
+
+/* decrypt */
+static int rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+    /* I haven't been able to trigger this one, but I want to know if it happens... */
+    assert(0);
+
+    return 0;
+}
+
+/* called at RSA_new */
+static int init(RSA *rsa)
+{
+
+    return 0;
+}
+
+/* called at RSA_free */
+static int finish(RSA *rsa)
+{
+    CAPI_DATA *cd = (CAPI_DATA *) rsa->meth->app_data;
+
+    if (cd == NULL)
+	return 0;
+    if (cd->crypt_prov && cd->free_crypt_prov)
+	CryptReleaseContext(cd->crypt_prov, 0);
+    if (cd->cert_context)
+	CertFreeCertificateContext(cd->cert_context);
+    free(rsa->meth->app_data);
+    free((char *) rsa->meth);
+    rsa->meth = NULL;
+    return 1;
+}
+
+static const CERT_CONTEXT *find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
+{
+    /* Find, and use, the desired certificate from the store. The
+     * 'cert_prop' certificate search string can look like this:
+     * SUBJ:<certificate substring to match>
+     * THUMB:<certificate thumbprint hex value>, e.g.
+     *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9 df 7a b6 28
+     */
+    const CERT_CONTEXT *rv = NULL;
+
+    if (!strncmp(cert_prop, "SUBJ:", 5)) {
+        unsigned short wbuf[255];
+
+	/* skip the tag */
+	cert_prop += 5;
+	MultiByteToWideChar(CP_ACP, 0, cert_prop, -1, wbuf, sizeof(wbuf));
+	rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
+		0, CERT_FIND_SUBJECT_STR, wbuf, NULL);
+
+    } else if (!strncmp(cert_prop, "THUMB:", 6)) {
+	unsigned char hash[255];
+	char *p;
+	int i, x = 0;
+	CRYPT_HASH_BLOB blob;
+
+	/* skip the tag */
+	cert_prop += 6;
+	for (p = (char *) cert_prop, i = 0; *p && i < sizeof(hash); i++) {
+	    if (*p >= '0' && *p <= '9')
+		x = (*p - '0') << 4;
+	    else if (*p >= 'A' && *p <= 'F')
+		x = (*p - 'A' + 10) << 4;
+	    else if (*p >= 'a' && *p <= 'f')
+		x = (*p - 'a' + 10) << 4;
+	    if (!*++p)	/* unexpected end of string */
+		break;
+	    if (*p >= '0' && *p <= '9')
+		x += *p - '0';
+	    else if (*p >= 'A' && *p <= 'F')
+		x += *p - 'A' + 10;
+	    else if (*p >= 'a' && *p <= 'f')
+		x += *p - 'a' + 10;
+	    hash[i] = x;
+	    /* skip any space(s) between hex numbers */
+	    for (p++; *p && *p == ' '; p++);
+	}
+	blob.cbData = i;
+	blob.pbData = (unsigned char *) &hash;
+	rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
+		0, CERT_FIND_HASH, &blob, NULL);
+
+    }
+
+    return rv;
+}
+
+int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
+{
+    HCERTSTORE cs;
+    X509 *cert = NULL;
+    RSA *rsa = NULL, *pub_rsa;
+    CAPI_DATA *cd = calloc(1, sizeof(*cd));
+    RSA_METHOD *my_rsa_method = calloc(1, sizeof(*my_rsa_method));
+
+    if (cd == NULL || my_rsa_method == NULL) {
+	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+	goto err;
+    }
+    /* search CURRENT_USER first, then LOCAL_MACHINE */
+    cs = CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER |
+		       CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+    if (cs == NULL) {
+	CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
+	goto err;
+    }
+    cd->cert_context = find_certificate_in_store(cert_prop, cs);
+    CertCloseStore(cs, 0);
+    if (!cd->cert_context) {
+	cs = CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_LOCAL_MACHINE |
+			   CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+	if (cs == NULL) {
+	    CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
+	    goto err;
+	}
+	cd->cert_context = find_certificate_in_store(cert_prop, cs);
+	CertCloseStore(cs, 0);
+	if (cd->cert_context == NULL) {
+	    CRYPTOAPIerr(CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE);
+	    goto err;
+	}
+    }
+
+    /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
+    cert = d2i_X509(NULL, (unsigned char **) &cd->cert_context->pbCertEncoded,
+		    cd->cert_context->cbCertEncoded);
+    if (cert == NULL) {
+	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_ASN1_LIB);
+	goto err;
+    }
+
+    /* set up stuff to use the private key */
+    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
+	    NULL, &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov)) {
+	/* if we don't have a smart card reader here, and we try to access a
+	 * smart card certificate, we get:
+	 * "Error 1223: The operation was canceled by the user." */
+	CRYPTOAPIerr(CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY);
+	goto err;
+    }
+    /* here we don't need to do CryptGetUserKey() or anything; all necessary key
+     * info is in cd->cert_context, and then, in cd->crypt_prov.  */
+
+    my_rsa_method->name = "CryptoAPI RSA Method";
+    my_rsa_method->rsa_pub_enc = rsa_pub_enc;
+    my_rsa_method->rsa_pub_dec = rsa_pub_dec;
+    my_rsa_method->rsa_priv_enc = rsa_priv_enc;
+    my_rsa_method->rsa_priv_dec = rsa_priv_dec;
+    /* my_rsa_method->init = init; */
+    my_rsa_method->finish = finish;
+    my_rsa_method->flags = RSA_METHOD_FLAG_NO_CHECK;
+    my_rsa_method->app_data = (char *) cd;
+
+    rsa = RSA_new();
+    if (rsa == NULL) {
+	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
+	goto err;
+    }
+
+    /* cert->cert_info->key->pkey is NULL until we call SSL_CTX_use_certificate(),
+     * so we do it here then...  */
+    if (!SSL_CTX_use_certificate(ssl_ctx, cert))
+	goto err;
+    /* the public key */
+    pub_rsa = cert->cert_info->key->pkey->pkey.rsa;
+    /* SSL_CTX_use_certificate() increased the reference count in 'cert', so
+     * we decrease it here with X509_free(), or it will never be cleaned up. */
+    X509_free(cert);
+    cert = NULL;
+
+    /* I'm not sure about what we have to fill in in the RSA, trying out stuff... */
+    /* rsa->n indicates the key size */
+    rsa->n = BN_dup(pub_rsa->n);
+    rsa->flags |= RSA_FLAG_EXT_PKEY;
+    if (!RSA_set_method(rsa, my_rsa_method))
+	goto err;
+
+    if (!SSL_CTX_use_RSAPrivateKey(ssl_ctx, rsa))
+	goto err;
+    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
+     * we decrease it here with RSA_free(), or it will never be cleaned up. */
+    RSA_free(rsa);
+    return 1;
+
+  err:
+    if (cert)
+	X509_free(cert);
+    if (rsa)
+	RSA_free(rsa);
+    else {
+	if (my_rsa_method)
+	    free(my_rsa_method);
+	if (cd) {
+	    if (cd->free_crypt_prov && cd->crypt_prov)
+		CryptReleaseContext(cd->crypt_prov, 0);
+	    if (cd->cert_context)
+		CertFreeCertificateContext(cd->cert_context);
+	    free(cd);
+	}
+    }
+    return 0;
+}
diff -uN openvpn-2.0_beta11.msvc/SSL_CTX_use_CryptoAPI_certificate.h openvpn-2.0_beta11/SSL_CTX_use_CryptoAPI_certificate.h
--- openvpn-2.0_beta11.msvc/SSL_CTX_use_CryptoAPI_certificate.h	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0_beta11/SSL_CTX_use_CryptoAPI_certificate.h	2004-10-06 13:31:54.000000000 +0200
@@ -0,0 +1,7 @@
+#ifndef _SSL_CTX_USE_CRYPTOAPI_CERTIFICATE
+#define _SSL_CTX_USE_CRYPTOAPI_CERTIFICATE
+
+int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop);
+
+
+#endif /* !_SSL_CTX_USE_CRYPTOAPI_CERTIFICATE */
diff -uN openvpn-2.0_beta11.msvc/init.c openvpn-2.0_beta11/init.c
--- openvpn-2.0_beta11.msvc/init.c	2004-08-18 16:23:28.000000000 +0200
+++ openvpn-2.0_beta11/init.c	2004-10-11 14:58:31.000000000 +0200
@@ -931,7 +931,8 @@
 				   options->cert_file,
 				   options->priv_key_file,
 				   options->pkcs12_file,
-				   options->cipher_list);
+				   options->cipher_list,
+				   options);

       /* Get cipher & hash algorithms */
       init_key_type (&c->c1.ks.key_type, options->ciphername,
diff -uN openvpn-2.0_beta11.msvc/makefile.w32 openvpn-2.0_beta11/makefile.w32
--- openvpn-2.0_beta11.msvc/makefile.w32	2004-08-16 20:35:22.000000000 +0200
+++ openvpn-2.0_beta11/makefile.w32	2004-10-12 15:48:42.000000000 +0200
@@ -34,7 +34,7 @@

 INCLUDE_DIRS = -I${OPENSSL}/include -I${LZO}/include

-LIBS = -llzo -lws2_32 -lgdi32 -liphlpapi -lwinmm
+LIBS = -llzo -lcrypt32 -lws2_32 -lgdi32 -liphlpapi -lwinmm

 LIB_DIRS = -L${OPENSSL}/out -L${LZO}/src/.libs

@@ -92,6 +92,7 @@
 	socket.h \
 	socks.h \
 	ssl.h \
+	SSL_CTX_use_CryptoAPI_certificate.h \
         status.h \
 	syshead.h \
         thread.h \
@@ -139,6 +140,7 @@
 	socket.o \
         socks.o \
 	ssl.o \
+	SSL_CTX_use_CryptoAPI_certificate.o \
 	status.o \
 	thread.o \
 	tun.o \
diff -uN openvpn-2.0_beta11.msvc/makefile.w32-vc openvpn-2.0_beta11/makefile.w32-vc
--- openvpn-2.0_beta11.msvc/makefile.w32-vc	2004-10-12 13:29:04.000000000 +0200
+++ openvpn-2.0_beta11/makefile.w32-vc	2004-10-13 14:04:50.507564800 +0200
@@ -24,7 +24,7 @@

 INCLUDE_DIRS = -I$(OPENSSL)/include -I$(LZO)/include

-LIBS = lzo.lib ws2_32.lib iphlpapi.lib winmm.lib gdi32.lib advapi32.lib
+LIBS = lzo.lib ws2_32.lib iphlpapi.lib crypt32.lib winmm.lib gdi32.lib advapi32.lib

 LIB_DIRS = -LIBPATH:$(OPENSSL)\out -LIBPATH:$(LZO)

@@ -96,6 +96,7 @@
 	socket.h \
 	socks.h \
 	ssl.h \
+	SSL_CTX_use_CryptoAPI_certificate.h \
         status.h \
 	syshead.h \
         thread.h \
@@ -143,6 +144,7 @@
 	socket.obj \
         socks.obj \
 	ssl.obj \
+	SSL_CTX_use_CryptoAPI_certificate.obj \
 	status.obj \
 	thread.obj \
 	tun.obj \
diff -uN openvpn-2.0_beta11.msvc/options.c openvpn-2.0_beta11/options.c
--- openvpn-2.0_beta11.msvc/options.c	2004-08-18 16:32:20.000000000 +0200
+++ openvpn-2.0_beta11/options.c	2004-10-12 10:21:34.000000000 +0200
@@ -916,6 +916,7 @@
   SHOW_STR (cert_file);
   SHOW_STR (priv_key_file);
   SHOW_STR (pkcs12_file);
+  SHOW_STR (cryptoapi_cert);
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
   SHOW_STR (tls_remote);
@@ -3290,6 +3291,12 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->cert_file = p[1];
     }
+  else if (streq (p[0], "cryptoapicert") && p[1])
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->cryptoapi_cert = p[1];
+    }
   else if (streq (p[0], "key") && p[1])
     {
       ++i;
diff -uN openvpn-2.0_beta11.msvc/options.h openvpn-2.0_beta11/options.h
--- openvpn-2.0_beta11.msvc/options.h	2004-08-18 16:32:20.000000000 +0200
+++ openvpn-2.0_beta11/options.h	2004-10-11 14:51:46.000000000 +0200
@@ -294,6 +294,7 @@
   const char *ca_file;
   const char *dh_file;
   const char *cert_file;
+  const char *cryptoapi_cert;
   const char *priv_key_file;
   const char *pkcs12_file;
   const char *cipher_list;
diff -uN openvpn-2.0_beta11.msvc/ssl.c openvpn-2.0_beta11/ssl.c
--- openvpn-2.0_beta11.msvc/ssl.c	2004-08-17 16:46:14.000000000 +0200
+++ openvpn-2.0_beta11/ssl.c	2004-10-12 10:14:52.000000000 +0200
@@ -55,6 +55,8 @@

 #include "memdbg.h"

+#include "SSL_CTX_use_CryptoAPI_certificate.h"
+
 #ifdef MEASURE_TLS_HANDSHAKE_STATS

 static int tls_handshake_success; /* GLOBAL */
@@ -575,7 +577,8 @@
 	  const char *cert_file,
 	  const char *priv_key_file,
 	  const char *pkcs12_file,
-	  const char *cipher_list)
+	  const char *cipher_list,
+	  const struct options *options)
 {
   SSL_CTX *ctx;
   DH *dh;
@@ -675,18 +678,33 @@
     {
     /* Use seperate PEM files for key, cert and CA certs */

-      /* Load Certificate */
-      if (!SSL_CTX_use_certificate_file (ctx, cert_file, SSL_FILETYPE_PEM))
-        msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
-
-      /* Load Private Key */
-      if (!SSL_CTX_use_PrivateKey_file (ctx, priv_key_file, SSL_FILETYPE_PEM))
-        msg (M_SSLERR, "Cannot load private key file %s", priv_key_file);
-      warn_if_group_others_accessible (priv_key_file);
-
-      /* Check Private Key */
-      if (!SSL_CTX_check_private_key (ctx))
-        msg (M_SSLERR, "Private key does not match the certificate");
+      if (options->cryptoapi_cert)
+	{
+	  /* Load Certificate and Private Key */
+	  if (!SSL_CTX_use_CryptoAPI_certificate (ctx, options->cryptoapi_cert))
+	    msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft Certificate Store",
+		 options->cryptoapi_cert);
+	}
+      else
+	{
+	  /* Load Certificate */
+	  if (!SSL_CTX_use_certificate_file (ctx, cert_file, SSL_FILETYPE_PEM))
+	    msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
+
+	  /* Load Private Key */
+	  if (!SSL_CTX_use_PrivateKey_file (ctx, priv_key_file, SSL_FILETYPE_PEM))
+	    msg (M_SSLERR, "Cannot load private key file %s", priv_key_file);
+	  warn_if_group_others_accessible (priv_key_file);
+
+	  /* Check Private Key */
+	  if (!SSL_CTX_check_private_key (ctx))
+	    msg (M_SSLERR, "Private key does not match the certificate");
+
+	  /* Enable the use of certificate chains */
+	  if (!SSL_CTX_use_certificate_chain_file (ctx, cert_file))
+	    msg (M_SSLERR, "Cannot load certificate chain file %s (SSL_use_certificate_chain_file)",
+		 cert_file);
+	}

       /* Load CA file for verifying peer supplied certificate */
       if (!SSL_CTX_load_verify_locations (ctx, ca_file, NULL))
@@ -700,10 +718,6 @@
           msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_load_client_CA_file)", ca_file);
         SSL_CTX_set_client_CA_list (ctx, cert_names);
       }
-
-      /* Enable the use of certificate chains */
-      if (!SSL_CTX_use_certificate_chain_file (ctx, cert_file))
-        msg (M_SSLERR, "Cannot load certificate chain file %s (SSL_use_certificate_chain_file)", cert_file);
     }


diff -uN openvpn-2.0_beta11.msvc/ssl.h openvpn-2.0_beta11/ssl.h
--- openvpn-2.0_beta11.msvc/ssl.h	2004-08-15 07:28:36.000000000 +0200
+++ openvpn-2.0_beta11/ssl.h	2004-10-11 14:57:45.000000000 +0200
@@ -42,6 +42,7 @@
 #include "socket.h"
 #include "mtu.h"
 #include "thread.h"
+#include "options.h"

 /*
  * Openvpn Protocol.
@@ -439,7 +440,8 @@
 		   const char *dh_file,
 		   const char *cert_file,
 		   const char *pkcs12_file,
-		   const char *priv_key_file, const char *cipher_list);
+		   const char *priv_key_file, const char *cipher_list,
+		   const struct options *options);

 struct tls_multi *tls_multi_init (struct tls_options *tls_options);

-----8<----------8<----------8<----------8<----------8<----------8<----------8<-----

-- 
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@...292...>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screen name: PRunestig
Yahoo! Messenger profile name: altberg


