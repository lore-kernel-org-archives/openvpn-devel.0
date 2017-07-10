From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Jul 2017 12:34:41 +0800
Message-Id: <20170710043441.24770-5-a@...2181...>
In-Reply-To: <20170710043441.24770-1-a@...2181...>
References: <20170710043441.24770-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 4/4] ntlm: improve code style and readability
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

This patch does not introduce any functional or behavioural change.

The code in ntlm.c has been restyled to better to obey to the
new coding style and its readability has been a improved a bit.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ntlm.c | 74 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index f18e0371..c0319287 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -60,13 +60,13 @@ static void
 create_des_keys(const unsigned char *hash, unsigned char *key)
 {
     key[0] = hash[0];
-    key[1] = ((hash[0]&1)<<7)|(hash[1]>>1);
-    key[2] = ((hash[1]&3)<<6)|(hash[2]>>2);
-    key[3] = ((hash[2]&7)<<5)|(hash[3]>>3);
-    key[4] = ((hash[3]&15)<<4)|(hash[4]>>4);
-    key[5] = ((hash[4]&31)<<3)|(hash[5]>>5);
-    key[6] = ((hash[5]&63)<<2)|(hash[6]>>6);
-    key[7] = ((hash[6]&127)<<1);
+    key[1] = ((hash[0] & 1) << 7) | (hash[1] >> 1);
+    key[2] = ((hash[1] & 3) << 6) | (hash[2] >> 2);
+    key[3] = ((hash[2] & 7) << 5) | (hash[3] >> 3);
+    key[4] = ((hash[3] & 15) << 4) | (hash[4] >> 4);
+    key[5] = ((hash[4] & 31) << 3) | (hash[5] >> 5);
+    key[6] = ((hash[5] & 63) << 2) | (hash[6] >> 6);
+    key[7] = ((hash[6] & 127) << 1);
     key_des_fixup(key, 8, 1);
 }
 
@@ -99,7 +99,8 @@ static void
 gen_timestamp(uint8_t *timestamp)
 {
     /* Copies 8 bytes long timestamp into "timestamp" buffer.
-     * Timestamp is Little-endian, 64-bit signed value representing the number of tenths of a microsecond since January 1, 1601.
+     * Timestamp is Little-endian, 64-bit signed value representing the
+     * number of tenths of a microsecond since January 1, 1601.
      */
 
     UINTEGER64 timestamp_ull;
@@ -151,16 +152,17 @@ unicodize(char *dst, const char *src)
     {
         dst[i++] = *src;
         dst[i++] = 0;
-    }
-    while (*src++);
+    } while (*src++);
 
     return i;
 }
 
 static void
-add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos)
+add_security_buffer(int sb_offset, void *data, int length,
+                    unsigned char *msg_buf, int *msg_bufpos)
 {
-    /* Adds security buffer data to a message and sets security buffer's offset and length */
+    /* Adds security buffer data to a message and sets security buffer's
+     * offset and length */
     msg_buf[sb_offset] = (unsigned char)length;
     msg_buf[sb_offset + 2] = msg_buf[sb_offset];
     msg_buf[sb_offset + 4] = (unsigned char)(*msg_bufpos & 0xff);
@@ -187,7 +189,8 @@ ntlm_phase_1(const struct http_proxy_info *p, struct gc_arena *gc)
 }
 
 const char *
-ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_arena *gc)
+ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
+             struct gc_arena *gc)
 {
     /* NTLM handshake
      *
@@ -296,13 +299,16 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
         ntlmv2_blob[0x18] = 0;                              /* Unknown, zero should work */
 
         /* Add target information block to the blob */
-        if (( *((long *)&buf2[0x14]) & 0x00800000) == 0x00800000)          /* Check for Target Information block */
+
+        /* Check for Target Information block */
+        if ((*((long *)&buf2[0x14]) & 0x00800000) == 0x00800000)
         {
             tib_len = buf2[0x28];            /* Get Target Information block size */
             if (tib_len > 96)
             {
                 tib_len = 96;
             }
+
             {
                 uint8_t *tib_ptr;
                 uint8_t tib_pos = buf2[0x2c];
@@ -310,8 +316,10 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
                 {
                     return NULL;
                 }
-                tib_ptr = buf2 + tib_pos;                               /* Get Target Information block pointer */
-                memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);           /* Copy Target Information block into the blob */
+                /* Get Target Information block pointer */
+                tib_ptr = buf2 + tib_pos;
+                /* Copy Target Information block into the blob */
+                memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
             }
         }
         else
@@ -319,7 +327,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
             tib_len = 0;
         }
 
-        ntlmv2_blob[0x1c + tib_len] = 0;                    /* Unknown, zero works */
+        /* Unknown, zero works */
+        ntlmv2_blob[0x1c + tib_len] = 0;
 
         /* Get blob length */
         ntlmv2_blob_size = 0x20 + tib_len;
@@ -328,15 +337,18 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
         memcpy(&ntlmv2_response[8], challenge, 8);
 
         /* hmac-md5 */
-        gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash, MD5_DIGEST_LENGTH, ntlmv2_hmacmd5);
-
-        /* Add hmac-md5 result to the blob */
-        memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);         /* Note: This overwrites challenge previously written at ntlmv2_response[8..15] */
+        gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash,
+                     MD5_DIGEST_LENGTH, ntlmv2_hmacmd5);
 
+        /* Add hmac-md5 result to the blob.
+         * Note: This overwrites challenge previously written at
+         * ntlmv2_response[8..15] */
+        memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);
     }
-    else         /* Generate NTLM response */
+    else /* Generate NTLM response */
     {
-        unsigned char key1[DES_KEY_LENGTH], key2[DES_KEY_LENGTH], key3[DES_KEY_LENGTH];
+        unsigned char key1[DES_KEY_LENGTH], key2[DES_KEY_LENGTH];
+        unsigned char key3[DES_KEY_LENGTH];
 
         create_des_keys(md4_hash, key1);
         cipher_des_encrypt_ecb(key1, challenge, ntlm_response);
@@ -345,7 +357,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
         cipher_des_encrypt_ecb(key2, challenge, &ntlm_response[DES_KEY_LENGTH]);
 
         create_des_keys(&md4_hash[2 * (DES_KEY_LENGTH - 1)], key3);
-        cipher_des_encrypt_ecb(key3, challenge, &ntlm_response[DES_KEY_LENGTH*2]);
+        cipher_des_encrypt_ecb(key3, challenge,
+                               &ntlm_response[DES_KEY_LENGTH * 2]);
     }
 
 
@@ -356,7 +369,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
 
     if (ntlmv2_enabled)      /* NTLMv2 response */
     {
-        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16, phase3, &phase3_bufpos);
+        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
+                            phase3, &phase3_bufpos);
     }
     else       /* NTLM response */
     {
@@ -364,12 +378,13 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
     }
 
     /* username in ascii */
-    add_security_buffer(0x24, username, strlen(username), phase3, &phase3_bufpos);
+    add_security_buffer(0x24, username, strlen(username), phase3,
+                        &phase3_bufpos);
 
-    /* Set domain. If <domain> is empty, default domain will be used (i.e. proxy's domain) */
+    /* Set domain. If <domain> is empty, default domain will be used
+     * (i.e. proxy's domain) */
     add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufpos);
 
-
     /* other security buffers will be empty */
     phase3[0x10] = phase3_bufpos;     /* lm not used */
     phase3[0x30] = phase3_bufpos;     /* no workstation name supplied */
@@ -379,7 +394,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
     phase3[0x3c] = 0x02; /* negotiate oem */
     phase3[0x3d] = 0x02; /* negotiate ntlm */
 
-    return ((const char *)make_base64_string2((unsigned char *)phase3, phase3_bufpos, gc));
+    return ((const char *)make_base64_string2((unsigned char *)phase3,
+                                              phase3_bufpos, gc));
 }
 
 #else  /* if NTLM */
-- 
2.13.2


