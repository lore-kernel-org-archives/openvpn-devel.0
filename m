From: Antonio Quartulli <a@...2181...>
Date: Wed, 28 Apr 2021 10:10:54 +0200
Message-Id: <20210428081054.29081-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] crypto: respect ECB argument type from
 prototype
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Crypto backends are implementing the cipher_des_encrypt_ecb()
function without fully respecting the type of the argumentis as described
in the function prototype.

All ECB arguments (key, input block and output block) are expected to
be 8 bytes long, for this reason the prototype specifies the arguments
as 3 arrays of 8 bytes in size.

Convert the implementations to also explicitly mention the size of the
array they expect to receive in input.

Fixes these warnings:

crypto_openssl.c:866:39: warning: argument 2 of type ‘unsigned char *’ declared as a pointer [-Warray-parameter=]
  866 |                        unsigned char *src,
      |                        ~~~~~~~~~~~~~~~^~~
In file included from crypto.h:125,
                 from crypto_openssl.c:42:
crypto_backend.h:202:43: note: previously declared as an array ‘unsigned char[8]’
  202 |                             unsigned char src[DES_KEY_LENGTH],
      |                             ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
crypto_openssl.c:867:39: warning: argument 3 of type ‘unsigned char *’ declared as a pointer [-Warray-parameter=]
  867 |                        unsigned char *dst)
      |                        ~~~~~~~~~~~~~~~^~~
In file included from crypto.h:125,
                 from crypto_openssl.c:42:
crypto_backend.h:203:43: note: previously declared as an array ‘unsigned char[8]’
  203 |                             unsigned char dst[DES_KEY_LENGTH]);
      |                             ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/crypto_mbedtls.c | 4 ++--
 src/openvpn/crypto_openssl.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index f960d0ae..836e80ac 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -768,8 +768,8 @@ cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst,
 
 void
 cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
-                       unsigned char *src,
-                       unsigned char *dst)
+                       unsigned char src[DES_KEY_LENGTH],
+                       unsigned char dst[DES_KEY_LENGTH])
 {
     mbedtls_des_context ctx;
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f8b36bf8..af7311ec 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -863,8 +863,8 @@ cipher_ctx_final_check_tag(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
 
 void
 cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
-                       unsigned char *src,
-                       unsigned char *dst)
+                       unsigned char src[DES_KEY_LENGTH],
+                       unsigned char dst[DES_KEY_LENGTH])
 {
     DES_key_schedule sched;
 
-- 
2.26.3


