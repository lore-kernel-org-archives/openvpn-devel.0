From: Arne Schwabe <arne@...1227...>
Date: Sat, 19 Nov 2016 16:51:00 +0100
Message-Id: <1479570660-23630-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix warning that RAND_bytes is undeclared
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

---
 src/openvpn/crypto_openssl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1ea06bb..306b6c6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -47,6 +47,7 @@
 #include <openssl/err.h>
 #include <openssl/evp.h>
 #include <openssl/objects.h>
+#include <openssl/rand.h>
 #include <openssl/ssl.h>
 
 /*
-- 
2.9.3 (Apple Git-75)


