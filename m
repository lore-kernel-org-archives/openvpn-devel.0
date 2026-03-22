From: Gert Doering <gert@...1296...>
Date: Sun, 22 Mar 2026 12:12:01 +0100
Message-ID: <20260322111207.8346-1-gert@...1296...>
In-Reply-To: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
References: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Do not support tls_ctx_set_cert_profile
 on AWS-LC
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

SSL_CTX_set_security_level does nothing on AWS-LC and gives a deprecated
warning on compile. It is better to give the user a warning than to
effectively silently ignore it as well.

Change-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1579
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1579
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48cbaa8..a26663a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -518,8 +518,9 @@
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSION_NUMBER > 0x10100000L \
-    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3060000fL)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L                                            \
+    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3060000fL) \
+    && !defined(OPENSSL_IS_AWSLC)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something similar.
      * For now, use OpenSSL's security levels to achieve similar (but not equal)
@@ -549,8 +550,8 @@
     if (profile)
     {
         msg(M_WARN,
-            "WARNING: OpenSSL 1.1.0 and LibreSSL do not support "
-            "--tls-cert-profile, ignoring user-set profile: '%s'",
+            "WARNING: OpenSSL 1.1.0, AWS-LC and LibreSSL < 3.6.0 do not "
+            "support --tls-cert-profile, ignoring user-set profile: '%s'",
             profile);
     }
 #endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */

