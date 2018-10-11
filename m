From: Arne Schwabe <arne@...1227...>
Date: Fri, 12 Oct 2018 00:06:39 +0200
Message-Id: <20181011220639.7316-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Use right function to set TLS1.3
 restrictions in show-tls
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

The last version of the patch used the TLS1.2 version
tls_ctx_restrict_ciphers to set the restrictions for both
TLS 1.3 and TLS1.2 instead of using tls_ctx_restrict_ciphers_tls13
for TLS1.3.

Also fix minor style problem while I am touching the function
---
 src/openvpn/ssl_openssl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6717ded0..da573cfa 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2002,15 +2002,16 @@ show_available_tls_ciphers_list(const char *cipher_list,
     if (tls13)
     {
         SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
+        tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
     else
 #endif
     {
         SSL_CTX_set_max_proto_version(tls_ctx.ctx, TLS1_2_VERSION);
+        tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
     }
 
     tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
-    tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
     SSL *ssl = SSL_new(tls_ctx.ctx);
     if (!ssl)
@@ -2039,7 +2040,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
         else if (NULL == pair)
         {
             /* No translation found, print warning */
-            printf("%s (No IANA name known to OpenVPN, use OpenSSL name.)\n", cipher_name);
+            printf("%s (No IANA name known to OpenVPN, use OpenSSL name.)\n",
+                   cipher_name);
         }
         else
         {
-- 
2.19.0


