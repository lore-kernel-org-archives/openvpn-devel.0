Message-ID: <5381FEFF.1040609@...1856...>
Date: Sun, 25 May 2014 16:32:31 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070707050208090206060708"
Subject: [Openvpn-devel] [PATCH] Use SSL_MODE_RELEASE_BUFFERS if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070707050208090206060708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Attached a very old patch from trac, rebased onto master and
incorporated info from the trac ticket into the commit msg. See:
https://community.openvpn.net/openvpn/ticket/157

The change looks sane, and it passes client and loopback tests, so ACK.

-Steffan

--------------070707050208090206060708
Content-Type: text/x-patch;
	name="Use-SSL_MODE_RELEASE_BUFFERS-if-available.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Use-SSL_MODE_RELEASE_BUFFERS-if-available.patch"

From ffe73c0466e6f52ab7d9c49e5b6b7e77b93200df Mon Sep 17 00:00:00 2001
From: Cristian Rodriguez <crrodriguez@...724...>
Date: Sun, 25 May 2014 15:52:58 +0200
Subject: [PATCH] Use SSL_MODE_RELEASE_BUFFERS if available

Sets SSL_MODE_RELEASE_BUFFERS if available, to keep openSSL memory
usage as low as possible.

For more info, see
http://www.imperialviolet.org/2010/06/25/overclocking-ssl.html
https://www.openssl.org/docs/ssl/SSL_CTX_set_mode.html

Signed-off-by: Cristian Rodriguez <crrodriguez@...724...>
---
 src/openvpn/ssl_openssl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 3a222d8..4862bad 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -198,6 +198,9 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
     SSL_CTX_set_options (ctx->ctx, sslopt);
   }
 
+#ifdef SSL_MODE_RELEASE_BUFFERS
+  SSL_CTX_set_mode (ctx, SSL_MODE_RELEASE_BUFFERS);
+#endif
   SSL_CTX_set_session_cache_mode (ctx->ctx, SSL_SESS_CACHE_OFF);
   SSL_CTX_set_default_passwd_cb (ctx->ctx, pem_password_callback);
 
-- 
1.9.1


--------------070707050208090206060708--

