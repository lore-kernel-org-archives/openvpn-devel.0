From: Steffan Karger <steffan@...1856...>
Date: Thu,  7 Jan 2016 21:24:33 +0100
Message-Id: <1452198273-26493-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: remove now redundant 128-bit
	blowfish key override
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

As of 1.3.0, polarssl/mbedtls now by default uses a 128 bit key for the
blowfish cipher (as opposed to the 32-bit (!) default they had previously).
Since we require polar 1.3+, we no longer need this fixup code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index f0ad81a..407a176 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -415,8 +415,6 @@ cipher_kt_key_size (const cipher_info_t *cipher_kt)
 {
   if (NULL == cipher_kt)
     return 0;
-  if (POLARSSL_CIPHER_ID_BLOWFISH == cipher_kt->base->cipher)
-    return 128/8; /* Override PolarSSL 32 bit default key size with sane 128 bit default */
 
   return cipher_kt->key_length/8;
 }
-- 
2.5.0


