From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  9 Feb 2024 12:10:00 +0100
Message-Id: <20240209111000.16258-1-frank@...2641...>
In-Reply-To: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
References: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Print SSL peer signature information in
 handshake debug details
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

This is more SSL debug information that most people do not really need
or care about. OpenSSL's own s_client also logs them:

Peer signing digest: SHA256
Peer signature type: ECDSA

The complete message looks like this:

   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bits RSA, signature: RSA-SHA256, server temp key: 253 bits X25519, peer signing digest/type: SHA256 RSASSA-PSS

or when forcing a specific group via tls-groups X448 with a ECDSA server:

   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bits ECsecp384r1, signature: ecdsa-with-SHA256, server temp key: 448 bits X448, peer signing digest/type: SHA384 ECDSA

Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/365
This mail reflects revision 9 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c30e6a9..9b6027c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2166,6 +2166,83 @@
     EVP_PKEY_free(pkey);
 }
 
+#if !defined(LIBRESSL_VERSION_NUMBER)  && OPENSSL_VERSION_NUMBER >= 0x1010000fL
+/**
+ * Translate an OpenSSL NID into a more human readable name
+ * @param nid
+ * @return
+ */
+static const char *
+get_sigtype(int nid)
+{
+    /* Fix a few OpenSSL names to be better understandable */
+    switch (nid)
+    {
+        case EVP_PKEY_RSA:
+            /* will otherwise say rsaEncryption */
+            return "RSA";
+
+        case EVP_PKEY_DSA:
+            /* dsaEncryption otherwise */
+            return "DSA";
+
+        case EVP_PKEY_EC:
+            /* will say id-ecPublicKey */
+            return "ECDSA";
+
+        case -1:
+            return "(error getting name)";
+
+        default:
+            return OBJ_nid2sn(nid);
+    }
+}
+#endif /* ifndef LIBRESSL_VERSION_NUMBER */
+
+/**
+ * Get the type of the signature that is used by the peer during the
+ * TLS handshake
+ */
+static void
+print_peer_signature(SSL *ssl, char *buf, size_t buflen)
+{
+    int peer_sig_nid = NID_undef, peer_sig_type_nid = NID_undef;
+    const char *peer_sig = "unknown";
+    const char *peer_sig_type = "unknown type";
+
+    /* Even though these methods use the deprecated NIDs instead of using
+     * string as new OpenSSL APIs do, there seem to be no API that replaces
+     * it yet */
+#if !defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL
+    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
+        && peer_sig_nid != NID_undef)
+    {
+        peer_sig = OBJ_nid2sn(peer_sig_nid);
+    }
+#endif
+
+#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x1010000fL) \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >= 0x3090000fL)
+    /* LibreSSL 3.7.x and 3.8.x implement this function but do not export it
+     * and fail linking with an unresolved symbol */
+    if (SSL_get_peer_signature_type_nid(ssl, &peer_sig_type_nid)
+        && peer_sig_type_nid != NID_undef)
+    {
+        peer_sig_type = get_sigtype(peer_sig_type_nid);
+    }
+#endif
+
+    if (peer_sig_nid == NID_undef && peer_sig_type_nid == NID_undef)
+    {
+        return;
+    }
+
+    openvpn_snprintf(buf, buflen, ", peer signing digest/type: %s %s",
+                     peer_sig, peer_sig_type);
+}
+
+
+
 /* **************************************
  *
  * Information functions
@@ -2180,8 +2257,9 @@
     char s1[256];
     char s2[256];
     char s3[256];
+    char s4[256];
 
-    s1[0] = s2[0] = s3[0] = 0;
+    s1[0] = s2[0] = s3[0] = s4[0] = 0;
     ciph = SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2196,8 +2274,9 @@
         X509_free(cert);
     }
     print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
+    print_peer_signature(ks_ssl->ssl, s4, sizeof(s4));
 
-    msg(D_HANDSHAKE, "%s%s%s", s1, s2, s3);
+    msg(D_HANDSHAKE, "%s%s%s%s", s1, s2, s3, s4);
 }
 
 void

