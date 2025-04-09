From: Gert Doering <gert@...1296...>
Date: Wed,  9 Apr 2025 14:24:03 +0200
Message-ID: <20250409122409.17616-1-gert@...1296...>
In-Reply-To: <gerrit.1744197804000.I90d54853fe1b1d820661cc2c099e07ec5d31ed05@...2715...>
References: <gerrit.1744197804000.I90d54853fe1b1d820661cc2c099e07ec5d31ed05@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Also print key agreement when printing
 negotiated details
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

With TLS 1.0 to 1.2, the used key agreement was depended on the certificates
themselves. With TLS 1.3 is no longer the case but basically always X25519
was used. So this information has been very interesting so far. But with
OpenSSL 3.5.0 and the new X25519MLKEM768 hybrid key agreement, the used
key agreement group actually becomes interesting information.

This commit adds printing this information for OpenSSL 3.0.0+ and uses
a compat version for OpenSSL 3.0-3.1 to avoid an additional ifdef in the
code itself.

Example output with ML-DSA-65 certificates on the server (client output):

   Control Channel: TLSv1.3, cipher
   TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 15616
   bits ML-DSA-65, signature: id-ml-dsa-65, peer signing
   digest/type: mldsa65 id-ml-dsa-65,
   key agreement: X25519MLKEM768

with an secp384r1 certificate:

  Control Channel: TLSv1.3, cipher
  TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384
  bits ECsecp384r1, signature: ecdsa-with-SHA256, peer signing
  digest/type: ecdsa_secp384r1_sha384 ECDSA,
  key agreement: X25519MLKEM768

Change-Id: I90d54853fe1b1d820661cc2c099e07ec5d31ed05
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/938
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index e2bd9bf..bd6f09c 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -197,6 +197,13 @@
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30500000 && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL) */
 
-
+#if OPENSSL_VERSION_NUMBER < 0x30200000L && OPENSSL_VERSION_NUMBER >= 0x30000000L
+static inline const char *
+SSL_get0_group_name(SSL *s)
+{
+    int nid = SSL_get_negotiated_group(s);
+    return SSL_group_to_name(s, nid);
+}
+#endif
 
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 23b0266..d1d5d3e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2486,7 +2486,21 @@
              peer_sig, peer_sig_type);
 }
 
-
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+void
+print_tls_key_agreement_group(SSL *ssl, char *buf, size_t buflen)
+{
+    const char *groupname = SSL_get0_group_name(ssl);
+    if (!groupname)
+    {
+        snprintf(buf, buflen, ", key agreement: (error fetching group)");
+    }
+    else
+    {
+        snprintf(buf, buflen, ", key agreement: %s", groupname);
+    }
+}
+#endif
 
 /* **************************************
  *
@@ -2503,8 +2517,9 @@
     char s2[256];
     char s3[256];
     char s4[256];
+    char s5[256];
 
-    s1[0] = s2[0] = s3[0] = s4[0] = 0;
+    s1[0] = s2[0] = s3[0] = s4[0] = s5[0] = 0;
     ciph = SSL_get_current_cipher(ks_ssl->ssl);
     snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
              prefix,
@@ -2520,8 +2535,11 @@
     }
     print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
     print_peer_signature(ks_ssl->ssl, s4, sizeof(s4));
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    print_tls_key_agreement_group(ks_ssl->ssl, s5, sizeof(s5));
+#endif
 
-    msg(D_HANDSHAKE, "%s%s%s%s", s1, s2, s3, s4);
+    msg(D_HANDSHAKE, "%s%s%s%s%s", s1, s2, s3, s4, s5);
 }
 
 void

