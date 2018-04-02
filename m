From: Steffan Karger <steffan@...1856...>
Date: Mon,  2 Apr 2018 13:44:36 +0200
Message-Id: <20180402114436.13662-1-steffan@...1856...>
In-Reply-To: <CAKuzo_hYvB2JjxZ3S8W4dB1+AOJqQW3VZJ2FgRXQJrDArkcFAQ@...278...>
References: <CAKuzo_hYvB2JjxZ3S8W4dB1+AOJqQW3VZJ2FgRXQJrDArkcFAQ@...278...>
Subject: [Openvpn-devel] [PATCH v3] Improve management-external-key/cert
 error handling
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

Check the return values of management_query_cert() and
tls_ctx_use_external_private_key(), and error out with a more descriptive
error message.  To do so, we make the openssl-backed implementation of
tls_ctx_use_external_private_key() not throw fatal error anymore.

(And fix line wrapping while touching this code.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: error out with M_FATAL as suggested by Selva.
v3: rebase on master (without extra patches)

 src/openvpn/ssl.c         | 28 ++++++++++++++++++++--------
 src/openvpn/ssl_openssl.c |  2 +-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 669f941b..b06820ba 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -660,18 +660,30 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     else if ((options->management_flags & MF_EXTERNAL_KEY)
              && (options->cert_file || options->management_flags & MF_EXTERNAL_CERT))
     {
-        if (options->cert_file)
+        if (options->cert_file
+            && 0 != tls_ctx_use_external_private_key(new_ctx,
+                                                     options->cert_file,
+                                                     options->cert_file_inline))
         {
-            tls_ctx_use_external_private_key(new_ctx, options->cert_file,
-                                             options->cert_file_inline);
+            msg(M_FATAL, "Failed to initialize management-external-key");
         }
         else
         {
-            char *external_certificate = management_query_cert(management,
-                                                               options->management_certificate);
-            tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
-                                             external_certificate);
-            free(external_certificate);
+            char *external_cert = management_query_cert(
+                            management, options->management_certificate);
+
+            if (!external_cert)
+            {
+                msg(M_FATAL, "Failed to initialize management-external-cert");
+            }
+
+            if (0 != tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
+                                                      external_cert))
+            {
+                msg(M_FATAL, "Failed to initialize management-external-key");
+            }
+
+            free(external_cert);
         }
     }
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8ef68ebd..4d434fa2 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1330,7 +1330,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     return 0;
 
 err:
-    crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
+    crypto_msg(M_WARN, "Cannot enable SSL external private key capability");
     return 1;
 }
 
-- 
2.14.1


