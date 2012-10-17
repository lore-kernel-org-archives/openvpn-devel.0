From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 17 Oct 2012 11:39:25 +0200
Message-ID: <1350466765-23301-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed a bug where PolarSSL gave an error
	when using an inline file tag.
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 src/openvpn/ssl_polarssl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 6995958..12318b3 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -338,7 +338,7 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
     {
-      if (0 != x509parse_crt(ctx->ca_chain, ca_file_inline, strlen(ca_file_inline)));
+      if (0 != x509parse_crt(ctx->ca_chain, ca_file_inline, strlen(ca_file_inline)))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
-- 
1.7.9.5


