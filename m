From: Arne Schwabe <arne@...1227...>
Date: Fri, 26 Mar 2021 18:57:50 +0100
Message-Id: <20210326175750.4772-1-arne@...1227...>
In-Reply-To: <20200907160224.18670-1-arne@...1227...>
References: <20200907160224.18670-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Cleanup print_details and add
 signature/ED certificate print
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

This commit cleans up the logic in the function a bit. It also makes it
more clear the the details printed in the second part of the message are
details about the peer certificate and not the TLS connection as such.
Also print the signature algorithm as this might help to identify
peer certificate that still use SHA1.

The new format with for TLS 1.3 and an EC certificate.

Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bit EC, curve secp384r1, signature: ecdsa-with-SHA256

Using the more generic OpenSSL functions also allows use to correctly
print details about ED certificates:

Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 253 bit ED25519, signature: ED25519

Patch v2: Cleanup multiple calls to EVP_PKEY_id, minor code restructuring

Patch v3: Always initialise sig.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 118 +++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d161f48b8..b85f95be1 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2001,6 +2001,80 @@ key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf,
     return ret;
 }
 
+/**
+ * Print human readable information about the certifcate into buf
+ * @param cert      the certificate being used
+ * @param buf       output buffer
+ * @param buflen    output buffer length
+ */
+static void
+print_cert_details(X509 *cert, char *buf, size_t buflen)
+{
+    const char *curve = "";
+    const char *type = "(error getting type)";
+    EVP_PKEY *pkey = X509_get_pubkey(cert);
+
+    if (pkey == NULL)
+    {
+        buf[0] = 0;
+        return;
+    }
+
+    int typeid = EVP_PKEY_id(pkey);
+
+#ifndef OPENSSL_NO_EC
+    if (typeid == EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) != NULL)
+    {
+        EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+        const EC_GROUP *group = EC_KEY_get0_group(ec);
+
+        int nid = EC_GROUP_get_curve_name(group);
+        if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
+        {
+            curve = "(error getting curve name)";
+        }
+    }
+#endif
+    if (EVP_PKEY_id(pkey) != 0)
+    {
+        int typeid = EVP_PKEY_id(pkey);
+        type = OBJ_nid2sn(typeid);
+
+        /* OpenSSL reports rsaEncryption, dsaEncryption and
+        * id-ecPublicKey, map these values to nicer ones */
+        if (typeid == EVP_PKEY_RSA)
+        {
+            type = "RSA";
+        }
+        else if (typeid == EVP_PKEY_DSA)
+        {
+            type = "DSA";
+        }
+        else if (typeid == EVP_PKEY_EC)
+        {
+            /* EC gets the curve appended after the type */
+            type = "EC, curve ";
+        }
+        else if (type == NULL)
+        {
+            type = "unknown type";
+        }
+    }
+
+    char sig[128] = { 0 };
+    int signature_nid = X509_get_signature_nid(cert);
+    if (signature_nid != 0)
+    {
+        openvpn_snprintf(sig, sizeof(sig), ", signature: %s",
+                         OBJ_nid2sn(signature_nid));
+    }
+
+    openvpn_snprintf(buf, buflen, ", peer certificate: %d bit %s%s%s",
+                     EVP_PKEY_bits(pkey), type, curve, sig);
+
+    EVP_PKEY_free(pkey);
+}
+
 /* **************************************
  *
  * Information functions
@@ -2012,7 +2086,6 @@ void
 print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 {
     const SSL_CIPHER *ciph;
-    X509 *cert;
     char s1[256];
     char s2[256];
 
@@ -2023,48 +2096,13 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
                      SSL_get_version(ks_ssl->ssl),
                      SSL_CIPHER_get_version(ciph),
                      SSL_CIPHER_get_name(ciph));
-    cert = SSL_get_peer_certificate(ks_ssl->ssl);
-    if (cert != NULL)
-    {
-        EVP_PKEY *pkey = X509_get_pubkey(cert);
-        if (pkey != NULL)
-        {
-            if ((EVP_PKEY_id(pkey) == EVP_PKEY_RSA) && (EVP_PKEY_get0_RSA(pkey) != NULL))
-            {
-                RSA *rsa = EVP_PKEY_get0_RSA(pkey);
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
-                                 RSA_bits(rsa));
-            }
-            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_DSA) && (EVP_PKEY_get0_DSA(pkey) != NULL))
-            {
-                DSA *dsa = EVP_PKEY_get0_DSA(pkey);
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
-                                 DSA_bits(dsa));
-            }
-#ifndef OPENSSL_NO_EC
-            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
-            {
-                EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
-                const EC_GROUP *group = EC_KEY_get0_group(ec);
-                const char *curve;
+    X509 *cert = SSL_get_peer_certificate(ks_ssl->ssl);
 
-                int nid = EC_GROUP_get_curve_name(group);
-                if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
-                {
-                    curve = "Error getting curve name";
-                }
-
-                openvpn_snprintf(s2, sizeof(s2), ", %d bit EC, curve: %s",
-                                 EC_GROUP_order_bits(group), curve);
-
-            }
-#endif
-            EVP_PKEY_free(pkey);
-        }
+    if (cert)
+    {
+        print_cert_details(cert, s2, sizeof(s2));
         X509_free(cert);
     }
-    /* The SSL API does not allow us to look at temporary RSA/DH keys,
-     * otherwise we should print their lengths too */
     msg(D_HANDSHAKE, "%s%s", s1, s2);
 }
 
-- 
2.30.1


