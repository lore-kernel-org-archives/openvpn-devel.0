From: Arne Schwabe <arne@...1227...>
Date: Fri, 29 Oct 2021 13:11:08 +0200
Message-Id: <20211029111109.2003101-1-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] [OSSL 3.0] Implement DES ECB encrypt via
 EVP_CIPHER api
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
direction and using the correct APIs. We cheat a bit by using 3DES instead
of DES to avoid needing legacy provider for DES encryption for now.

Patch v4: add unit test, use 3DES to avoid legacy provider for now

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c           | 40 ++++++++++++++++++++++++--
 tests/unit_tests/openvpn/test_crypto.c | 27 ++++++++++++++++-
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 6b18551ea..999805e88 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -867,10 +867,44 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
                        unsigned char src[DES_KEY_LENGTH],
                        unsigned char dst[DES_KEY_LENGTH])
 {
-    DES_key_schedule sched;
+    /* We are using 3DES here with three times the same key to cheat
+     * and emulate DES as 3DES is better supported than DES */
+    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
+    if (!ctx)
+    {
+        crypto_msg(M_FATAL, "%s: EVP_CIPHER_CTX_new() failed", __func__);
+    }
+
+    unsigned char key3[DES_KEY_LENGTH*3];
+    for (int i = 0;i < 3;i++)
+    {
+        memcpy(key3 + (i * DES_KEY_LENGTH), key, DES_KEY_LENGTH);
+    }
 
-    DES_set_key_unchecked((DES_cblock *)key, &sched);
-    DES_ecb_encrypt((DES_cblock *)src, (DES_cblock *)dst, &sched, DES_ENCRYPT);
+    if (!EVP_EncryptInit_ex(ctx, EVP_des_ede3_ecb(), NULL, key3, 0))
+    {
+        crypto_msg(M_FATAL, "%s: EVP_EncryptInit_ex() failed", __func__);
+    }
+
+    int len;
+
+    /* The EVP_EncryptFinal method will write to the dst+len pointer even
+     * though there is nothing to encrypt anymore, provide space for that to
+     * not overflow the stack */
+    unsigned char dst2[DES_KEY_LENGTH * 2];
+    if(!EVP_EncryptUpdate(ctx, dst2, &len, src, DES_KEY_LENGTH))
+    {
+        crypto_msg(M_FATAL, "%s: EVP_EncryptUpdate() failed", __func__);
+    }
+
+    if (!EVP_EncryptFinal(ctx, dst2 + len, &len))
+    {
+        crypto_msg(M_FATAL, "%s: EVP_EncryptFinal() failed", __func__);
+    }
+
+    memcpy(dst, dst2, DES_KEY_LENGTH);
+
+    EVP_CIPHER_CTX_free(ctx);
 }
 
 /*
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 66f53a020..6d8d40896 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -212,6 +212,30 @@ crypto_test_hmac(void **state)
     hmac_ctx_free(hmac);
 }
 
+void
+test_des_encrypt(void **state)
+{
+    /* We have a small des encrypt method that is only for NTLMv1. This unit
+     * test ensures that it is not accidentally broken */
+
+    const unsigned char des_key[DES_KEY_LENGTH] = {0x42, 0x23};
+
+    const char *src = "MoinWelt";
+
+    /* cipher_des_encrypt_ecb wants a non const */
+    unsigned char *src2 = (unsigned char *) strdup(src);
+
+    unsigned char dst[DES_KEY_LENGTH];
+    cipher_des_encrypt_ecb(des_key, src2, dst);
+
+    const unsigned char dst_good[DES_KEY_LENGTH] = {0xd3, 0x8f, 0x61, 0xf7, 0xbe, 0x27, 0xb6, 0xa2};
+
+    assert_memory_equal(dst, dst_good, DES_KEY_LENGTH);
+
+    free(src2);
+}
+
+
 int
 main(void)
 {
@@ -219,7 +243,8 @@ main(void)
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
         cmocka_unit_test(crypto_translate_cipher_names),
         cmocka_unit_test(crypto_test_tls_prf),
-        cmocka_unit_test(crypto_test_hmac)
+        cmocka_unit_test(crypto_test_hmac),
+        cmocka_unit_test(test_des_encrypt)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.33.0


