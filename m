From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 23:26:38 +0200
Message-Id: <1332797200-9295-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH 4/6] cleanup: warnings at src/openvpn/ntlm.c
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/ntlm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 3390bdd..bd09d88 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -77,9 +77,9 @@ gen_md4_hash (const char* data, int data_len, char *result)
 {
   /* result is 16 byte md4 hash */
   const md_kt_t *md4_kt = md_kt_get("MD4");
-  char md[MD4_DIGEST_LENGTH];
+  unsigned char md[MD4_DIGEST_LENGTH];
 
-  md_full(md4_kt, data, data_len, md);
+  md_full(md4_kt, (uint8_t *)data, data_len, md);
   memcpy (result, md, MD4_DIGEST_LENGTH);
 }
 
@@ -90,7 +90,7 @@ gen_hmac_md5 (const char* data, int data_len, const char* key, int key_len,char
 	hmac_ctx_t hmac_ctx;
 	CLEAR(hmac_ctx);
 
-	hmac_ctx_init(&hmac_ctx, key, key_len, md5_kt);
+	hmac_ctx_init(&hmac_ctx, (uint8_t *)key, key_len, md5_kt);
 	hmac_ctx_update(&hmac_ctx, (const unsigned char *)data, data_len);
 	hmac_ctx_final(&hmac_ctx, (unsigned char *)result);
 	hmac_ctx_cleanup(&hmac_ctx);
@@ -307,13 +307,13 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 		unsigned char key1[DES_KEY_LENGTH], key2[DES_KEY_LENGTH], key3[DES_KEY_LENGTH];
 
 		create_des_keys ((unsigned char *)md4_hash, key1);
-		cipher_des_encrypt_ecb (key1, challenge, ntlm_response);
+		cipher_des_encrypt_ecb (key1, (uint8_t *)challenge, (uint8_t *)ntlm_response);
 
 		create_des_keys ((unsigned char *)&(md4_hash[DES_KEY_LENGTH-1]), key2);
-		cipher_des_encrypt_ecb (key2, challenge, &ntlm_response[DES_KEY_LENGTH]);
+		cipher_des_encrypt_ecb (key2, (uint8_t *)challenge, (uint8_t *)&ntlm_response[DES_KEY_LENGTH]);
 
 		create_des_keys ((unsigned char *)&(md4_hash[2*(DES_KEY_LENGTH-1)]), key3);
-		cipher_des_encrypt_ecb (key3, challenge, &ntlm_response[DES_KEY_LENGTH*2]);
+		cipher_des_encrypt_ecb (key3, (uint8_t *)challenge, (uint8_t *)&ntlm_response[DES_KEY_LENGTH*2]);
 	}
 
 
-- 
1.7.3.4


