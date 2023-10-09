From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  9 Oct 2023 12:55:18 +0200
Message-Id: <20231009105518.34432-1-frank@...2641...>
In-Reply-To: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
References: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Print peer temporary key details
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

From: Arne Schwabe <arne@...1227...>

The peer temporary key in TLS session is related to the PFS
exchange/generation. From the SSL_get_peer_tmp_key manual page:

   For example, if ECDHE is in use, then this represents the
   peer's public ECDHE key.

Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/364
This mail reflects revision 6 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index efc85d4..f487b1b 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -75,6 +75,10 @@
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
 
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)) || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050400fL)
+#define SSL_get_peer_tmp_key SSL_get_server_tmp_key
+#endif
+
 /* Functionality missing in 1.0.2 */
 #if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)
 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b5cc9a7..6ff2c1c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2052,18 +2052,11 @@
     return ret;
 }
 
-/**
- * Print human readable information about the certifcate into buf
- * @param cert      the certificate being used
- * @param buf       output buffer
- * @param buflen    output buffer length
- */
 static void
-print_cert_details(X509 *cert, char *buf, size_t buflen)
+print_pkey_details(EVP_PKEY *pkey, char *buf, size_t buflen)
 {
     const char *curve = "";
     const char *type = "(error getting type)";
-    EVP_PKEY *pkey = X509_get_pubkey(cert);
 
     if (pkey == NULL)
     {
@@ -2126,6 +2119,23 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     }
 
+    openvpn_snprintf(buf, buflen, "%d bits %s%s",
+                     EVP_PKEY_bits(pkey), type, curve);
+}
+
+/**
+ * Print human readable information about the certificate into buf
+ * @param cert      the certificate being used
+ * @param buf       output buffer
+ * @param buflen    output buffer length
+ */
+static void
+print_cert_details(X509 *cert, char *buf, size_t buflen)
+{
+    EVP_PKEY *pkey = X509_get_pubkey(cert);
+    char pkeybuf[128] = { 0 };
+    print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));
+
     char sig[128] = { 0 };
     int signature_nid = X509_get_signature_nid(cert);
     if (signature_nid != 0)
@@ -2134,8 +2144,27 @@
                          OBJ_nid2sn(signature_nid));
     }
 
-    openvpn_snprintf(buf, buflen, ", peer certificate: %d bit %s%s%s",
-                     EVP_PKEY_bits(pkey), type, curve, sig);
+    openvpn_snprintf(buf, buflen, ", peer certificate: %s%s",
+                     pkeybuf, sig);
+
+    EVP_PKEY_free(pkey);
+}
+
+static void
+print_server_tempkey(SSL *ssl, char *buf, size_t buflen)
+{
+    EVP_PKEY *pkey = NULL;
+    SSL_get_peer_tmp_key(ssl, &pkey);
+    if (!pkey)
+    {
+        return;
+    }
+
+    char pkeybuf[128] = { 0 };
+    print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));
+
+    openvpn_snprintf(buf, buflen, ", peer temporary key: %s",
+                     pkeybuf);
 
     EVP_PKEY_free(pkey);
 }
@@ -2153,8 +2182,9 @@
     const SSL_CIPHER *ciph;
     char s1[256];
     char s2[256];
+    char s3[256];
 
-    s1[0] = s2[0] = 0;
+    s1[0] = s2[0] = s3[0] = 0;
     ciph = SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2168,7 +2198,9 @@
         print_cert_details(cert, s2, sizeof(s2));
         X509_free(cert);
     }
-    msg(D_HANDSHAKE, "%s%s", s1, s2);
+    print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
+
+    msg(D_HANDSHAKE, "%s%s%s", s1, s2, s3);
 }
 
 void

