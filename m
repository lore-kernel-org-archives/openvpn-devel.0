From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Jan 2014 21:10:21 +0100
Message-Id: <1388607026-12297-2-git-send-email-steffan@...1856...>
In-Reply-To: <1388607026-12297-1-git-send-email-steffan@...1856...>
References: <20131230205032.GH226@...1296...>
	<1388607026-12297-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/6] Also update TLSv1_method() calls in
	support code to SSLv23_method() calls.
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

Commit 4b67f98 changed calls to TLSv1_{sever,client}_method() to
SSLv23_{client,server}_method() to enable TLS version negotiation. This
commit does the same for two calls of TLSv1_method() from support code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f41bb71..2e5d9cd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1282,7 +1282,7 @@ show_available_tls_ciphers ()
   const tls_cipher_name_pair *pair;
   int priority = 0;
 
-  ctx = SSL_CTX_new (TLSv1_method ());
+  ctx = SSL_CTX_new (SSLv23_method ());
   if (!ctx)
     msg (M_SSLERR, "Cannot create SSL_CTX object");
 
@@ -1317,7 +1317,7 @@ get_highest_preference_tls_cipher (char *buf, int size)
   SSL *ssl;
   const char *cipher_name;
 
-  ctx = SSL_CTX_new (TLSv1_method ());
+  ctx = SSL_CTX_new (SSLv23_method ());
   if (!ctx)
     msg (M_SSLERR, "Cannot create SSL_CTX object");
   ssl = SSL_new (ctx);
-- 
1.8.3.2


