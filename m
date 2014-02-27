From: <steffan.karger@...1435...>
Date: Thu, 27 Feb 2014 20:40:07 +0100
Message-ID: <1393530007-6225-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
References: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Improve error reporting during key/cert
	loading with PolarSSL.
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

From: Steffan Karger <steffan.karger@...1435...>

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_polarssl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 3a0d8a0..2df1b30 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -261,8 +261,13 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
     }
   else
     {
-      if (0 != x509_crt_parse_file(ctx->crt_chain, cert_file))
-	msg (M_FATAL, "Cannot load certificate file %s", cert_file);
+      int retval = x509_crt_parse_file(ctx->crt_chain, cert_file);
+      if (0 != retval)
+	{
+	  char errstr[128];
+	  polarssl_strerror(retval, errstr, sizeof(errstr));
+	  msg (M_FATAL, "Cannot load certificate file %s (%s)", cert_file, errstr);
+	}
     }
 }
 
@@ -475,8 +480,13 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
   else
     {
       /* Load CA file for verifying peer supplied certificate */
-      if (0 != x509_crt_parse_file(ctx->ca_chain, ca_file))
-	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
+      int retval = x509_crt_parse_file(ctx->ca_chain, ca_file);
+      if (0 != retval)
+	{
+	  char errstr[128];
+	  polarssl_strerror(retval, errstr, sizeof(errstr));
+	  msg (M_FATAL, "Cannot load CA certificate file %s (%s)", ca_file, errstr);
+	}
     }
 }
 
-- 
1.8.3.2


