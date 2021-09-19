From: Arne Schwabe <arne@...1227...>
Date: Sun, 19 Sep 2021 18:29:51 +0200
Message-Id: <20210919162956.695496-3-arne@...1227...>
In-Reply-To: <20210919162956.695496-1-arne@...1227...>
References: <20210919162956.695496-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/8] [OSSL 3.0] Implement DES ECB encrypt
 via EVP_CIPHER api
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

Even though DES is super outdated and also NTLM is super outdated,
eliminating the warnings for OpenSSL 3.0 is still a step in the right
direction and using the correct APIs.
---
 src/openvpn/crypto_openssl.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 34a564e46..b4c59557b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -880,10 +880,26 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
                        unsigned char src[DES_KEY_LENGTH],
                        unsigned char dst[DES_KEY_LENGTH])
 {
-    DES_key_schedule sched;
+    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
+    if (!ctx)
+    {
+        crypto_msg(M_FATAL, "%s: EVP_CIPHER_CTX_new() failed", __func__);
+    }
+    if (!EVP_EncryptInit_ex(ctx, EVP_bf_ecb(), NULL, key, 0))
+    {
+        crypto_msg(M_FATAL, "%s: EVP_EncryptInit_ex() failed", __func__);
+    }
 
-    DES_set_key_unchecked((DES_cblock *)key, &sched);
-    DES_ecb_encrypt((DES_cblock *)src, (DES_cblock *)dst, &sched, DES_ENCRYPT);
+    int len;
+    if(!EVP_EncryptUpdate(ctx, dst, &len, src, DES_KEY_LENGTH))
+    {
+        crypto_msg(M_FATAL, "%s: EVP_EncryptUpdate() failed", __func__);
+    }
+
+    if (!EVP_EncryptFinal(ctx, dst + len, &len))
+    {
+        crypto_msg(M_FATAL, "%s: EVP_EncryptFinal() failed", __func__);
+    }
 }
 
 /*
-- 
2.33.0


