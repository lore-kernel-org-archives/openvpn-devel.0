From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Jul 2017 12:34:38 +0800
Message-Id: <20170710043441.24770-2-a@...2181...>
In-Reply-To: <20170710043441.24770-1-a@...2181...>
References: <20170710043441.24770-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/4] ntlm: convert binary buffers to uint8_t
 *
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
Cc: Antonio Quartulli <a@...2181...>

several binary buffers in the ntml component are stored
as char *, however this generates a lot of warnings, because
hashing functions expect something unsigned.

Convert binary buffers to uint8_t *, while use explicit cast
for buffers that are really carrying a string inside.

This commit removes several warnings from nmtl.c that you can
catch with "-Wall -std=c99".

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ntlm.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0b1163ee..76dda576 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -71,31 +71,32 @@ create_des_keys(const unsigned char *hash, unsigned char *key)
 }
 
 static void
-gen_md4_hash(const char *data, int data_len, char *result)
+gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result)
 {
     /* result is 16 byte md4 hash */
     const md_kt_t *md4_kt = md_kt_get("MD4");
-    char md[MD4_DIGEST_LENGTH];
+    uint8_t md[MD4_DIGEST_LENGTH];
 
     md_full(md4_kt, data, data_len, md);
     memcpy(result, md, MD4_DIGEST_LENGTH);
 }
 
 static void
-gen_hmac_md5(const char *data, int data_len, const char *key, int key_len,char *result)
+gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key, int key_len,
+             uint8_t *result)
 {
     const md_kt_t *md5_kt = md_kt_get("MD5");
     hmac_ctx_t *hmac_ctx = hmac_ctx_new();
 
     hmac_ctx_init(hmac_ctx, key, key_len, md5_kt);
-    hmac_ctx_update(hmac_ctx, (const unsigned char *)data, data_len);
-    hmac_ctx_final(hmac_ctx, (unsigned char *)result);
+    hmac_ctx_update(hmac_ctx, data, data_len);
+    hmac_ctx_final(hmac_ctx, result);
     hmac_ctx_cleanup(hmac_ctx);
     hmac_ctx_free(hmac_ctx);
 }
 
 static void
-gen_timestamp(unsigned char *timestamp)
+gen_timestamp(uint8_t *timestamp)
 {
     /* Copies 8 bytes long timestamp into "timestamp" buffer.
      * Timestamp is Little-endian, 64-bit signed value representing the number of tenths of a microsecond since January 1, 1601.
@@ -195,19 +196,19 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
      */
 
     char pwbuf[sizeof(p->up.password) * 2]; /* for unicode password */
-    unsigned char buf2[128]; /* decoded reply from proxy */
-    unsigned char phase3[464];
+    uint8_t buf2[128]; /* decoded reply from proxy */
+    uint8_t phase3[464];
 
-    char md4_hash[MD4_DIGEST_LENGTH+5];
-    char challenge[8], ntlm_response[24];
+    uint8_t md4_hash[MD4_DIGEST_LENGTH + 5];
+    uint8_t challenge[8], ntlm_response[24];
     int i, ret_val;
 
-    char ntlmv2_response[144];
+    uint8_t ntlmv2_response[144];
     char userdomain_u[256];     /* for uppercase unicode username and domain */
     char userdomain[128];       /* the same as previous but ascii */
-    char ntlmv2_hash[MD5_DIGEST_LENGTH];
-    char ntlmv2_hmacmd5[16];
-    char *ntlmv2_blob = ntlmv2_response + 16;     /* inside ntlmv2_response, length: 128 */
+    uint8_t ntlmv2_hash[MD5_DIGEST_LENGTH];
+    uint8_t ntlmv2_hmacmd5[16];
+    uint8_t *ntlmv2_blob = ntlmv2_response + 16;     /* inside ntlmv2_response, length: 128 */
     int ntlmv2_blob_size = 0;
     int phase3_bufpos = 0x40;     /* offset to next security buffer data to be added */
     size_t len;
@@ -246,12 +247,13 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
 
 
     /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-    gen_md4_hash(pwbuf, unicodize(pwbuf, p->up.password) - 2, md4_hash);
+    gen_md4_hash((uint8_t *)pwbuf, unicodize(pwbuf, p->up.password) - 2,
+                 md4_hash);
 
     /* pad to 21 bytes */
     memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
 
-    ret_val = openvpn_base64_decode( phase_2, (void *)buf2, -1);
+    ret_val = openvpn_base64_decode(phase_2, buf2, -1);
     if (ret_val < 0)
     {
         return NULL;
@@ -281,15 +283,16 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
             msg(M_INFO, "Warning: Username or domain too long");
         }
         unicodize(userdomain_u, userdomain);
-        gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash, MD5_DIGEST_LENGTH, ntlmv2_hash);
+        gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,
+                     MD5_DIGEST_LENGTH, ntlmv2_hash);
 
         /* NTLMv2 Blob */
         memset(ntlmv2_blob, 0, 128);                        /* Clear blob buffer */
         ntlmv2_blob[0x00] = 1;                              /* Signature */
         ntlmv2_blob[0x01] = 1;                              /* Signature */
         ntlmv2_blob[0x04] = 0;                              /* Reserved */
-        gen_timestamp((unsigned char *)&ntlmv2_blob[0x08]);                  /* 64-bit Timestamp */
-        gen_nonce((unsigned char *)&ntlmv2_blob[0x10]);                      /* 64-bit Client Nonce */
+        gen_timestamp(&ntlmv2_blob[0x08]);                  /* 64-bit Timestamp */
+        gen_nonce(&ntlmv2_blob[0x10]);                      /* 64-bit Client Nonce */
         ntlmv2_blob[0x18] = 0;                              /* Unknown, zero should work */
 
         /* Add target information block to the blob */
@@ -301,8 +304,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
                 tib_len = 96;
             }
             {
-                char *tib_ptr;
-                int tib_pos = buf2[0x2c];
+                uint8_t *tib_ptr;
+                uint8_t tib_pos = buf2[0x2c];
                 if (tib_pos + tib_len > sizeof(buf2))
                 {
                     return NULL;
@@ -335,13 +338,13 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
     {
         unsigned char key1[DES_KEY_LENGTH], key2[DES_KEY_LENGTH], key3[DES_KEY_LENGTH];
 
-        create_des_keys((unsigned char *)md4_hash, key1);
+        create_des_keys(md4_hash, key1);
         cipher_des_encrypt_ecb(key1, challenge, ntlm_response);
 
-        create_des_keys((unsigned char *)&(md4_hash[DES_KEY_LENGTH-1]), key2);
+        create_des_keys(&md4_hash[DES_KEY_LENGTH - 1], key2);
         cipher_des_encrypt_ecb(key2, challenge, &ntlm_response[DES_KEY_LENGTH]);
 
-        create_des_keys((unsigned char *)&(md4_hash[2*(DES_KEY_LENGTH-1)]), key3);
+        create_des_keys(&md4_hash[2 * (DES_KEY_LENGTH - 1)], key3);
         cipher_des_encrypt_ecb(key3, challenge, &ntlm_response[DES_KEY_LENGTH*2]);
     }
 
-- 
2.13.2


