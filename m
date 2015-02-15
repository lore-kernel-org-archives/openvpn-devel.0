From: Steffan Karger <steffan@...1856...>
Date: Sun, 15 Feb 2015 15:24:26 +0100
Message-Id: <1424010266-5910-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Disable SSL compression
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

As reported in trac #502, SSL compression can cause problems in some corner
cases.  OpenVPN does not need SSL compression, since the control channel is
low bandwidth.  This does not influence the data channel compressen (i.e.
--comp or --comp-lzo).

Even though this has not yet been relevant for OpenVPN (since an attacker
can not easily control contents of control channel messages), SSL
compression has been used in the CRIME and BREACH attacks on TLS.  TLS 1.3
will probably even remove support for compression all together, for
exactly this reason.

Since we don't need it, and SSL compression causes issues, let's just
disable it in OpenSSL builds.  PolarSSL has no run-time flag to disable
compression, but is by default compiled without compression.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48c0571..d9abc6e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -203,6 +203,10 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
     if (tls_ver_min > TLS_VER_1_2 || tls_ver_max < TLS_VER_1_2)
       sslopt |= SSL_OP_NO_TLSv1_2;
 #endif
+#ifdef SSL_OP_NO_COMPRESSION
+    /* Disable compression - flag not available in OpenSSL 0.9.8 */
+    sslopt |= SSL_OP_NO_COMPRESSION;
+#endif
     SSL_CTX_set_options (ctx->ctx, sslopt);
   }
 
-- 
2.1.0


