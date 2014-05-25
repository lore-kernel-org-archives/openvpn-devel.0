From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 May 2014 21:18:21 +0200
Message-Id: <1401045501-12343-4-git-send-email-steffan@...1856...>
In-Reply-To: <1401045501-12343-1-git-send-email-steffan@...1856...>
References: <1401045501-12343-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/3] Remove unneeded defines (were needed
	for pre-0.9.7 OpenSSL).
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

Since we now require OpenSSL 0.9.8, we don't need these anymore.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 22bb7c9..c3480e0 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -57,14 +57,6 @@
 #warning Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH -- consider increasing MAX_HMAC_KEY_LENGTH
 #endif
 
-#ifndef EVP_CIPHER_name
-#define EVP_CIPHER_name(e)		OBJ_nid2sn(EVP_CIPHER_nid(e))
-#endif
-
-#ifndef EVP_MD_name
-#define EVP_MD_name(e)			OBJ_nid2sn(EVP_MD_type(e))
-#endif
-
 #if HAVE_OPENSSL_ENGINE
 #include <openssl/engine.h>
 
-- 
1.9.1


