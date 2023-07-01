From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jul 2023 22:08:38 +0200
Message-Id: <20230701200840.3516314-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Print server temp key details
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

Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0b310de31..da1417b82 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2050,18 +2050,11 @@ key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
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
@@ -2124,6 +2117,23 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     }
 
+    openvpn_snprintf(buf, buflen, "%d bits %s%s",
+                     EVP_PKEY_bits(pkey), type, curve);
+}
+
+/**
+ * Print human readable information about the certifcate into buf
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
@@ -2132,8 +2142,27 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
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
+    openvpn_snprintf(buf, buflen, ", server temp key: %s",
+                     pkeybuf);
 
     EVP_PKEY_free(pkey);
 }
@@ -2151,8 +2180,9 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
     const SSL_CIPHER *ciph;
     char s1[256];
     char s2[256];
+    char s3[256];
 
-    s1[0] = s2[0] = 0;
+    s1[0] = s2[0] = s3[0] = 0;
     ciph = SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2166,7 +2196,9 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
         print_cert_details(cert, s2, sizeof(s2));
         X509_free(cert);
     }
-    msg(D_HANDSHAKE, "%s%s", s1, s2);
+    print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
+
+    msg(D_HANDSHAKE, "%s%s%s", s1, s2, s3);
 }
 
 void
-- 
2.39.2 (Apple Git-143)


