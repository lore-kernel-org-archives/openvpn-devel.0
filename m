From: Arne Schwabe <arne@...1227...>
Date: Sat, 23 Nov 2013 13:40:34 +0100
Message-Id: <1385210434-28364-1-git-send-email-arne@...1227...>
In-Reply-To: <20131123121335.GA27496@...1296...>
References: <20131123121335.GA27496@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix compile error in ssl_openssl introduced
	by polar external-management patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d6e194a..120aa66 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -534,7 +534,7 @@ void
 tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
     const char *cert_file_inline)
 {
-  tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, NULL);
+  tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline, NULL);
 }
 
 void
@@ -684,7 +684,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
   ASSERT (NULL != ctx);
   ASSERT (NULL != cert);
 
-  tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, &cert);
+  tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline, &cert);
 
   /* allocate custom RSA method object */
   ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);
-- 
1.8.3.4 (Apple Git-47)


