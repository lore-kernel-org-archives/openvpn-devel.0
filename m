From: James Yonan <james@...515...>
Date: Sun, 16 Mar 2014 18:49:36 -0600
Message-Id: <1395017376-24554-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL context
	for OpenSSL builds, to disable TLS stateless session resumption.
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

OpenVPN doesn't want or need SSL session renegotiation or
resumption, as it handles renegotiation on its own.

For this reason, OpenVPN always disables the SSL session cache:

SSL_CTX_set_session_cache_mode (ctx, SSL_SESS_CACHE_OFF)

However, even with the above code, stateless session resumption
is still possible unless explicitly disabled with the
SSL_OP_NO_TICKET flag.  This patch does this.
---
 src/openvpn/ssl_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0dc1e81..938e9d4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -208,7 +208,7 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 
   /* process SSL options including minimum TLS version we will accept from peer */
   {
-    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
+    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
     const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
     if (tls_version_min > TLS_VER_UNSPEC)
       {
-- 
1.8.5.3


