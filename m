From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Aug 2012 11:52:16 +0200
Message-ID: <1345197136-24708-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove stale _openssl_get_subject()
	prototype
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

The _openssl_get_subject() function was removed in commit
00b973f8af85c3ea8fa3cef80eec55e8dc139b27. The functionality
moved to x509_get_subject().

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/ssl_verify_openssl.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index afd6110..5a7e0a1 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -73,6 +73,4 @@ int verify_callback (int preverify_ok, X509_STORE_CTX * ctx);
 
 /** @} name Function for authenticating a new connection from a remote OpenVPN peer */
 
-char *_openssl_get_subject (X509 *cert, char *buf, int size);
-
 #endif /* SSL_VERIFY_OPENSSL_H_ */
-- 
1.7.9.5


