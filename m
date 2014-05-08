From: James Yonan <james@...515...>
Date: Thu,  8 May 2014 16:50:34 -0600
Message-Id: <1399589436-8730-5-git-send-email-james@...515...>
In-Reply-To: <1399589436-8730-1-git-send-email-james@...515...>
References: <1399589436-8730-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 4/6] MSVC 2008 doesn't support dimensioning
	an array with a const var nor using %z as a printf format specifier.
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
Cc: James Yonan <james@...515...>

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/ssl_openssl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 481600a..d845fd7 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -261,8 +261,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
   const tls_cipher_name_pair *cipher_pair;
 
-  const size_t openssl_ciphers_size = 4096;
-  char openssl_ciphers[openssl_ciphers_size];
+  char openssl_ciphers[4096];
   size_t openssl_ciphers_len = 0;
   openssl_ciphers[0] = '\0';
 
@@ -301,8 +300,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 	}
 
       // Make sure new cipher name fits in cipher string
-      if (((openssl_ciphers_size-1) - openssl_ciphers_len) < current_cipher_len) {
-	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%zu).", openssl_ciphers_size-1);
+      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len) {
+	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%d).", (int)sizeof(openssl_ciphers)-1);
       }
 
       // Concatenate cipher name to OpenSSL cipher string
-- 
1.8.5.5


