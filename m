From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 24 Oct 2011 10:46:00 +0200
Message-ID: <1319445962-21686-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Got rid of a few magic numbers in ntlm.c
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 crypto_backend.h  |    6 +++---
 crypto_openssl.c  |    2 +-
 crypto_openssl.h  |    3 +++
 crypto_polarssl.c |    2 +-
 crypto_polarssl.h |    2 ++
 ntlm.c            |   30 +++++++++++++++---------------
 6 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/crypto_backend.h b/crypto_backend.h
index f16dc35..8622962 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -135,9 +135,9 @@ void key_des_fixup (uint8_t *key, int key_len, int ndc);
  * @param src		Buffer containing the 8-byte source.
  * @param dst		Buffer containing the 8-byte destination
  */
-void cipher_des_encrypt_ecb (const unsigned char key[8],
-    unsigned char src[8],
-    unsigned char dst[8]);
+void cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
+    unsigned char src[DES_KEY_LENGTH],
+    unsigned char dst[DES_KEY_LENGTH]);
 
 /*
  *
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 7250782..4f14ce2 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -636,7 +636,7 @@ cipher_ctx_final (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len)
 
 
 void
-cipher_des_encrypt_ecb (const unsigned char key[8],
+cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
     unsigned char *src,
     unsigned char *dst)
 {
diff --git a/crypto_openssl.h b/crypto_openssl.h
index 9bc106a..f883c2a 100644
--- a/crypto_openssl.h
+++ b/crypto_openssl.h
@@ -67,4 +67,7 @@ typedef HMAC_CTX hmac_ctx_t;
 /** Cipher should decrypt */
 #define OPENVPN_OP_DECRYPT 	0
 
+#define DES_KEY_LENGTH 8
+#define MD4_DIGEST_LENGTH 	16
+
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/crypto_polarssl.c b/crypto_polarssl.c
index 7ae8973..293a1fd 100644
--- a/crypto_polarssl.c
+++ b/crypto_polarssl.c
@@ -397,7 +397,7 @@ int cipher_ctx_final (cipher_context_t *ctx, uint8_t *dst, int *dst_len)
 }
 
 void
-cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_SIZE],
+cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
     unsigned char *src,
     unsigned char *dst)
 {
diff --git a/crypto_polarssl.h b/crypto_polarssl.h
index 3ac2c96..358483a 100644
--- a/crypto_polarssl.h
+++ b/crypto_polarssl.h
@@ -66,7 +66,9 @@ typedef md_context_t hmac_ctx_t;
 /** Cipher should decrypt */
 #define OPENVPN_OP_DECRYPT 	POLARSSL_DECRYPT
 
+#define MD4_DIGEST_LENGTH 	16
 #define MD5_DIGEST_LENGTH 	16
 #define SHA_DIGEST_LENGTH 	20
+#define DES_KEY_LENGTH 8
 
 #endif /* CRYPTO_POLARSSL_H_ */
diff --git a/ntlm.c b/ntlm.c
index ee33bd4..217173f 100644
--- a/ntlm.c
+++ b/ntlm.c
@@ -71,10 +71,10 @@ gen_md4_hash (const char* data, int data_len, char *result)
 {
   /* result is 16 byte md4 hash */
   const md_kt_t *md4_kt = md_kt_get("MD4");
-  char md[16];
+  char md[MD4_DIGEST_LENGTH];
 
   md_full(md4_kt, data, data_len, md);
-  memcpy (result, md, 16);
+  memcpy (result, md, MD4_DIGEST_LENGTH);
 }
 
 static void
@@ -190,14 +190,14 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
   char buf2[128]; /* decoded reply from proxy */
   unsigned char phase3[464];
 
-  char md4_hash[21];
+  char md4_hash[MD4_DIGEST_LENGTH+5];
   char challenge[8], ntlm_response[24];
   int i, ret_val;
 
 	char ntlmv2_response[144];
 	char userdomain_u[256]; /* for uppercase unicode username and domain */
 	char userdomain[128];   /* the same as previous but ascii */
-	char ntlmv2_hash[16];
+	char ntlmv2_hash[MD5_DIGEST_LENGTH];
 	char ntlmv2_hmacmd5[16];
 	char *ntlmv2_blob = ntlmv2_response + 16; /* inside ntlmv2_response, length: 128 */
 	int ntlmv2_blob_size=0;
@@ -235,7 +235,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
   gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
 
   /* pad to 21 bytes */
-  memset (md4_hash + 16, 0, 5);
+  memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
 
   ret_val = openvpn_base64_decode( phase_2, (void *)buf2, -1);
   if (ret_val < 0)
@@ -260,7 +260,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 		else
 			msg (M_INFO, "Warning: Username or domain too long");
 		unicodize (userdomain_u, userdomain);
-		gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash, 16, ntlmv2_hash);
+		gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash, MD5_DIGEST_LENGTH, ntlmv2_hash);
 
 		/* NTLMv2 Blob */
 		memset(ntlmv2_blob, 0, 128);                /* Clear blob buffer */ 
@@ -292,25 +292,25 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 		memcpy(&ntlmv2_response[8], challenge, 8);
 
 		/* hmac-md5 */
-		gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash, 16, ntlmv2_hmacmd5);
+		gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash, MD5_DIGEST_LENGTH, ntlmv2_hmacmd5);
 		
 		/* Add hmac-md5 result to the blob */
-		memcpy(ntlmv2_response, ntlmv2_hmacmd5, 16); /* Note: This overwrites challenge previously written at ntlmv2_response[8..15] */
+		memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH); /* Note: This overwrites challenge previously written at ntlmv2_response[8..15] */
 	
 	} else { /* Generate NTLM response */
-		unsigned char key1[8], key2[8], key3[8];
+		unsigned char key1[DES_KEY_LENGTH], key2[DES_KEY_LENGTH], key3[DES_KEY_LENGTH];
 
 		create_des_keys ((unsigned char *)md4_hash, key1);
 		cipher_des_encrypt_ecb (key1, challenge, ntlm_response);
 
-		create_des_keys ((unsigned char *)&(md4_hash[7]), key2);
-		cipher_des_encrypt_ecb (key2, challenge, &ntlm_response[8]);
+		create_des_keys ((unsigned char *)&(md4_hash[DES_KEY_LENGTH-1]), key2);
+		cipher_des_encrypt_ecb (key2, challenge, &ntlm_response[DES_KEY_LENGTH]);
 
-		create_des_keys ((unsigned char *)&(md4_hash[14]), key3);
-		cipher_des_encrypt_ecb (key3, challenge, &ntlm_response[16]);
+		create_des_keys ((unsigned char *)&(md4_hash[2*(DES_KEY_LENGTH-1)]), key3);
+		cipher_des_encrypt_ecb (key3, challenge, &ntlm_response[DES_KEY_LENGTH*2]);
 	}
-	
-	
+
+
 	memset (phase3, 0, sizeof (phase3)); /* clear reply */
 
 	strcpy ((char *)phase3, "NTLMSSP\0"); /* signature */
-- 
1.7.5.4


