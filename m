From: Steffan Karger <steffan@...1856...>
Date: Mon,  2 Jun 2014 21:23:39 +0200
Message-Id: <1401737019-15702-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix --disable-ssl builds,
	were broken by cleanup in 63dc03d.
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

Wrap ssl_verify.h in "#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)" to
make it empty for --disable-ssl builds.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 601d863..84554f8 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -30,6 +30,8 @@
 #ifndef SSL_VERIFY_H_
 #define SSL_VERIFY_H_
 
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
+
 #include "syshead.h"
 #include "misc.h"
 #include "ssl_common.h"
@@ -234,5 +236,6 @@ tls_client_reason (struct tls_multi *multi)
 #endif
 }
 
-#endif /* SSL_VERIFY_H_ */
+#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) */
 
+#endif /* SSL_VERIFY_H_ */
-- 
1.9.1


