From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 17:02:55 +0200
Message-ID: <20250924150300.29318-1-gert@...1296...>
In-Reply-To: <gerrit.1758719391000.I9ea87531afb553f789289787403900a4758b8e1c@...2715...>
References: <gerrit.1758719391000.I9ea87531afb553f789289787403900a4758b8e1c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] ssl_openssl: Use uint16_t internally for
 TLS versions
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

From: Frank Lichtenheld <frank@...2641...>

libressl changed the API for the involved functions. Since
uint16_t is a true subset of int it should be safe to switch
to that for all OpenSSL variants.

One trivial drive-by fix in unrelated code to be able
to enable -Wconversion fully for the file. This just
adds a cast where the comment says we intend a cast.

Change-Id: I9ea87531afb553f789289787403900a4758b8e1c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1212
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1212
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 89deeaa..434df7d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -235,8 +235,8 @@
 }
 
 /** Convert internal version number to openssl version number */
-static int
-openssl_tls_version(int ver)
+static uint16_t
+openssl_tls_version(unsigned int ver)
 {
     if (ver == TLS_VER_1_0)
     {
@@ -272,23 +272,18 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
-    int tls_ver_min =
+    uint16_t tls_ver_min =
         openssl_tls_version((ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK);
-    int tls_ver_max =
+    uint16_t tls_ver_max =
         openssl_tls_version((ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK);
 
     if (!tls_ver_min)
     {
         /* Enforce at least TLS 1.0 */
-        int cur_min = SSL_CTX_get_min_proto_version(ctx->ctx);
+        uint16_t cur_min = (uint16_t)SSL_CTX_get_min_proto_version(ctx->ctx);
         tls_ver_min = cur_min < TLS1_VERSION ? TLS1_VERSION : cur_min;
     }
 
@@ -387,7 +382,7 @@
             /* %.*s format specifier expects length of type int, so guarantee */
             /* that length is small enough and cast to int. */
             msg(D_LOW, "No valid translation found for TLS cipher '%.*s'",
-                constrain_int(current_cipher_len, 0, 256), current_cipher);
+                constrain_int((int)current_cipher_len, 0, 256), current_cipher);
         }
         else
         {
@@ -429,10 +424,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -2522,11 +2513,6 @@
     msg(D_HANDSHAKE, "%s%s%s%s%s", s1, s2, s3, s4, s5);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 show_available_tls_ciphers_list(const char *cipher_list, const char *tls_cert_profile, bool tls13)
 {
@@ -2541,7 +2527,7 @@
 #if defined(TLS1_3_VERSION)
     if (tls13)
     {
-        SSL_CTX_set_min_proto_version(tls_ctx.ctx, openssl_tls_version(TLS_VER_1_3));
+        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
         tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
     else
@@ -2594,10 +2580,6 @@
     SSL_CTX_free(tls_ctx.ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Show the Elliptic curves that are available for us to use
  * in the OpenSSL library.

