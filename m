From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 17:33:28 +0200
Message-ID: <20250402153337.5262-1-gert@...1296...>
In-Reply-To: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
References: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Use SSL_get0_peer_signature_name instead
 of SSL_get_peer_signature_nid
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

SSL_get0_peer_signature_name returns a string instead of hardcoded NIDs.
NIDS do not work with provider provided signatures or the new PQ
signatures introduced in OpenSSL 3.5.

Remove also the comment that was added earlier that says that there
is no proper API replacement for SSL_get_peer_signature_nid yet as
OpenSSL 3.5.0 has now introduced it.

Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/927
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 3e3b406..e2bd9bf 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -173,4 +173,30 @@
 
 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
 
+#if OPENSSL_VERSION_NUMBER < 0x30500000 && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL)
+static inline int
+SSL_get0_peer_signature_name(SSL *ssl, const char **sigalg)
+{
+    int peer_sig_nid;
+    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
+        && peer_sig_nid != NID_undef)
+    {
+        *sigalg = OBJ_nid2sn(peer_sig_nid);
+        return 1;
+    }
+    return 0;
+}
+#elif defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x3050400fL
+/* The older LibreSSL version do not implement any variant of getting the peer
+ * signature */
+static inline int
+SSL_get0_peer_signature_name(const SSL *ssl, const char **sigalg)
+{
+    *sigalg = NULL;
+    return 0;
+}
+#endif /* if OPENSSL_VERSION_NUMBER < 0x30500000 && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL) */
+
+
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index aad79a4..23b0266 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2454,20 +2454,17 @@
 static void
 print_peer_signature(SSL *ssl, char *buf, size_t buflen)
 {
-    int peer_sig_nid = NID_undef, peer_sig_type_nid = NID_undef;
-    const char *peer_sig = "unknown";
+    int peer_sig_type_nid = NID_undef;
+    const char *peer_sig_unknown = "unknown";
+    const char *peer_sig = peer_sig_unknown;
     const char *peer_sig_type = "unknown type";
 
-    /* Even though these methods use the deprecated NIDs instead of using
-     * string as new OpenSSL APIs do, there seem to be no API that replaces
-     * it yet */
-#if !defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL
-    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
-        && peer_sig_nid != NID_undef)
+    const char *signame = NULL;
+    SSL_get0_peer_signature_name(ssl, &signame);
+    if (signame)
     {
-        peer_sig = OBJ_nid2sn(peer_sig_nid);
+        peer_sig = signame;
     }
-#endif
 
 #if !defined(LIBRESSL_VERSION_NUMBER) \
     || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >= 0x3090000fL)
@@ -2480,7 +2477,7 @@
     }
 #endif
 
-    if (peer_sig_nid == NID_undef && peer_sig_type_nid == NID_undef)
+    if (peer_sig == peer_sig_unknown && peer_sig_type_nid == NID_undef)
     {
         return;
     }

