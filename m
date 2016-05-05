From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 May 2016 15:02:27 +0200
Message-Id: <1462453347-3272-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove trailing newline from verify
	callback error messages
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_mbedtls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index a97161b..d018938 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -76,6 +76,10 @@ verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
 	{
 	  errstr[0] = '\0';
 	}
+      else
+	{
+	  chomp(errstr);
+	}
 
       if (subject)
 	{
-- 
2.7.4


