From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 24 Oct 2011 13:11:32 +0200
Message-ID: <1319454692-28954-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Removed obsolete des_cblock and
	des_keyschedule
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

To allow building on NetBSD.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 crypto_openssl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto_openssl.c b/crypto_openssl.c
index e43d73c..fdea326 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -642,10 +642,10 @@ cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
     unsigned char *src,
     unsigned char *dst)
 {
-    des_key_schedule sched;
+    DES_key_schedule sched;
 
-    des_set_key_unchecked((des_cblock*)key, sched);
-    des_ecb_encrypt((des_cblock *)src, (des_cblock *)dst, sched, DES_ENCRYPT);
+    des_set_key_unchecked((DES_cblock*)key, sched);
+    des_ecb_encrypt((DES_cblock *)src, (DES_cblock *)dst, sched, DES_ENCRYPT);
 }
 
 /*
-- 
1.7.5.4


