From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 24 Oct 2011 16:11:14 +0200
Message-ID: <1319465474-26989-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Further removal of des_old.h based calls
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

Replaced des_set_key_unchecked and des_ecb_encrypt functions in cipher_des_encrypt_ecb

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 crypto_openssl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto_openssl.c b/crypto_openssl.c
index fdea326..9906479 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -644,8 +644,8 @@ cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
 {
     DES_key_schedule sched;
 
-    des_set_key_unchecked((DES_cblock*)key, sched);
-    des_ecb_encrypt((DES_cblock *)src, (DES_cblock *)dst, sched, DES_ENCRYPT);
+    DES_set_key_unchecked((DES_cblock*)key, &sched);
+    DES_ecb_encrypt((DES_cblock *)src, (DES_cblock *)dst, &sched, DES_ENCRYPT);
 }
 
 /*
-- 
1.7.5.4


