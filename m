From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:02 +0200
Message-ID: <1308909312-17824-10-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 18/28] Refactored NTLM DES key generation
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
 crypto_backend.h |   11 +++++++++++
 crypto_openssl.c |   11 +++++++++++
 ntlm.c           |   12 ++++--------
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/crypto_backend.h b/crypto_backend.h
index f0e7b18..6c2bd0c 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -126,6 +126,17 @@ bool key_des_check (uint8_t *key, int key_len, int ndc);
  */
 void key_des_fixup (uint8_t *key, int key_len, int ndc);
 
+/**
+ * Encrypt the given block, using DES ECB mode
+ *
+ * @param key		DES key to use.
+ * @param src		Buffer containing the 8-byte source.
+ * @param dst		Buffer containing the 8-byte destination
+ */
+void cipher_des_encrypt_ecb (const unsigned char key[8],
+    unsigned char src[8],
+    unsigned char dst[8]);
+
 /*
  *
  * Generic cipher key type functions
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 9fbbf11..3842463 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -441,3 +441,14 @@ key_des_fixup (uint8_t *key, int key_len, int ndc)
 }
 
 
+void
+cipher_des_encrypt_ecb (const unsigned char key[8],
+    unsigned char *src,
+    unsigned char *dst)
+{
+    des_key_schedule sched;
+
+    des_set_key_unchecked((des_cblock*)key, sched);
+    des_ecb_encrypt((des_cblock *)src, (des_cblock *)dst, sched, DES_ENCRYPT);
+}
+
diff --git a/ntlm.c b/ntlm.c
index 3440c12..40a11b9 100644
--- a/ntlm.c
+++ b/ntlm.c
@@ -196,8 +196,6 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
   char md4_hash[21];
   char challenge[8], ntlm_response[24];
   int i, ret_val;
-  des_cblock key1, key2, key3;
-  des_key_schedule sched1, sched2, sched3;
 
 	char ntlmv2_response[144];
 	char userdomain_u[256]; /* for uppercase unicode username and domain */
@@ -303,18 +301,16 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 		memcpy(ntlmv2_response, ntlmv2_hmacmd5, 16); /* Note: This overwrites challenge previously written at ntlmv2_response[8..15] */
 	
 	} else { /* Generate NTLM response */
+		unsigned char key1[8], key2[8], key3[8];
 
 		create_des_keys ((unsigned char *)md4_hash, key1);
-		des_set_key_unchecked ((des_cblock *)key1, sched1);
-		des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)ntlm_response, sched1, DES_ENCRYPT);
+		cipher_des_encrypt_ecb (key1, challenge, ntlm_response);
 
 		create_des_keys ((unsigned char *)&(md4_hash[7]), key2);
-		des_set_key_unchecked ((des_cblock *)key2, sched2);
-		des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)&(ntlm_response[8]), sched2, DES_ENCRYPT);
+		cipher_des_encrypt_ecb (key2, challenge, &ntlm_response[8]);
 
 		create_des_keys ((unsigned char *)&(md4_hash[14]), key3);
-		des_set_key_unchecked ((des_cblock *)key3, sched3);
-		des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)&(ntlm_response[16]), sched3, DES_ENCRYPT);
+		cipher_des_encrypt_ecb (key3, challenge, &ntlm_response[16]);
 	}
 	
 	
-- 
1.7.4.1


