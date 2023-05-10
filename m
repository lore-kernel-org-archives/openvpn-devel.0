From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 May 2023 13:22:34 +0200
Message-Id: <20230510112236.248026-2-frank@...2641...>
In-Reply-To: <20230510112236.248026-1-frank@...2641...>
References: <20230510112236.248026-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Various fixes for -Wconversion errors
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

These are all fixes I considered "safe". They either

- Have sufficient checks/shifts for a cast to be safe
- Fix the type of a variable without requiring code changes
- Are in non-critical unittest code

Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/buffer.c                       |  4 ++--
 src/openvpn/crypto.c                       | 10 ++++++----
 src/openvpn/integer.h                      |  4 ++--
 src/openvpn/mss.c                          |  2 +-
 src/openvpn/otime.c                        |  2 +-
 src/openvpn/otime.h                        |  2 +-
 src/openvpn/packet_id.c                    |  4 ++--
 src/openvpn/reliable.c                     |  7 +++----
 src/openvpn/socket.h                       |  4 ++--
 src/openvpn/tls_crypt.c                    |  2 +-
 src/openvpn/xkey_helper.c                  | 14 +++++++-------
 tests/unit_tests/openvpn/mock_get_random.c |  2 +-
 tests/unit_tests/openvpn/test_crypto.c     |  6 +++---
 tests/unit_tests/openvpn/test_packet_id.c  |  6 +++---
 tests/unit_tests/openvpn/test_provider.c   |  2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c  |  2 +-
 16 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index d099795b..7ca9dd4f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -354,7 +354,7 @@ buffer_write_file(const char *filename, const struct buffer *buf)
         return false;
     }
 
-    const int size = write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size = write(fd, BPTR(buf), BLEN(buf));
     if (size != BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -891,7 +891,7 @@ buf_parse(struct buffer *buf, const int delim, char *line, const int size)
         {
             break;
         }
-        line[n++] = c;
+        line[n++] = (char)c;
     }
     while (c);
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b5ae17ec..0eaebba2 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -28,6 +28,8 @@
 #include "config-msvc.h"
 #endif
 
+#include <inttypes.h>
+
 #include "syshead.h"
 
 #include "crypto.h"
@@ -1293,8 +1295,8 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
                     hex_byte[hb_index++] = c;
                     if (hb_index == 2)
                     {
-                        unsigned int u;
-                        ASSERT(sscanf((const char *)hex_byte, "%x", &u) == 1);
+                        uint8_t u;
+                        ASSERT(sscanf((const char *)hex_byte, "%" SCNx8, &u) == 1);
                         *out++ = u;
                         hb_index = 0;
                         if (++count == keylen)
@@ -1556,13 +1558,13 @@ write_key(const struct key *key, const struct key_type *kt,
     ASSERT(cipher_kt_key_size(kt->cipher) <= MAX_CIPHER_KEY_LENGTH
            && md_kt_size(kt->digest) <= MAX_HMAC_KEY_LENGTH);
 
-    const uint8_t cipher_length = cipher_kt_key_size(kt->cipher);
+    const uint8_t cipher_length = (uint8_t)cipher_kt_key_size(kt->cipher);
     if (!buf_write(buf, &cipher_length, 1))
     {
         return false;
     }
 
-    uint8_t hmac_length = md_kt_size(kt->digest);
+    uint8_t hmac_length = (uint8_t)md_kt_size(kt->digest);
 
     if (!buf_write(buf, &hmac_length, 1))
     {
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 215c159f..2551428e 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -28,12 +28,12 @@
 
 #ifndef htonll
 #define htonll(x) ((1==htonl(1)) ? (x) : \
-                   ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >> 32))
+                   ((uint64_t)htonl((uint32_t)((x) & 0xFFFFFFFF)) << 32) | htonl((uint32_t)((x) >> 32)))
 #endif
 
 #ifndef ntohll
 #define ntohll(x) ((1==ntohl(1)) ? (x) : \
-                   ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >> 32))
+                   ((uint64_t)ntohl((uint32_t)((x) & 0xFFFFFFFF)) << 32) | ntohl((uint32_t)((x) >> 32)))
 #endif
 
 /*
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 98d54068..fd2d3c1d 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -167,7 +167,7 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
         return;
     }
 
-    for (olen = hlen - sizeof(struct openvpn_tcphdr),
+    for (olen = hlen - (int) sizeof(struct openvpn_tcphdr),
          opt = (uint8_t *)(tc + 1);
          olen > 1;
          olen -= optlen, opt += optlen)
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 0bbed81d..1694bc54 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -107,7 +107,7 @@ tv_string_abs(const struct timeval *tv, struct gc_arena *gc)
 /* format a time_t as ascii, or use current time if 0 */
 
 const char *
-time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc)
+time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
     struct timeval tv;
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index c27be892..d795c3c3 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -43,7 +43,7 @@ void frequency_limit_free(struct frequency_limit *f);
 bool frequency_limit_event_allowed(struct frequency_limit *f);
 
 /* format a time_t as ascii, or use current time if 0 */
-const char *time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc);
+const char *time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc);
 
 /* struct timeval functions */
 
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index bb790f03..6239bada 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -590,14 +590,14 @@ packet_id_debug_print(int msglevel,
         }
         else
         {
-            diff = (int) prev_now - v;
+            diff = (int)(prev_now - v);
             if (diff < 0)
             {
                 c = 'N';
             }
             else if (diff < 10)
             {
-                c = '0' + diff;
+                c = (char)('0' + diff);
             }
             else
             {
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 32b346b4..0df7072c 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -259,8 +259,7 @@ reliable_ack_write(struct reliable_ack *ack,
                    struct buffer *buf,
                    const struct session_id *sid, int max, bool prepend)
 {
-    int i, j;
-    uint8_t n;
+    int i, j, n;
     struct buffer sub;
 
     n = ack->len;
@@ -272,9 +271,9 @@ reliable_ack_write(struct reliable_ack *ack,
     copy_acks_to_mru(ack, ack_mru, n);
 
     /* Number of acks we can resend that still fit into the packet */
-    uint8_t total_acks = min_int(max, ack_mru->len);
+    uint8_t total_acks = (uint8_t)min_int(max, ack_mru->len);
 
-    sub = buf_sub(buf, ACK_SIZE(total_acks), prepend);
+    sub = buf_sub(buf, (int)ACK_SIZE(total_acks), prepend);
     if (!BDEF(&sub))
     {
         goto error;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bfc1253b..a4acc5dd 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1181,7 +1181,7 @@ link_socket_write_udp(struct link_socket *sock,
 }
 
 /* write a TCP or UDP packet to link */
-static inline int
+static inline size_t
 link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
@@ -1198,7 +1198,7 @@ link_socket_write(struct link_socket *sock,
     else
     {
         ASSERT(0);
-        return -1; /* NOTREACHED */
+        return 0; /* NOTREACHED */
     }
 }
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 88b2d6d7..e8ff6c6b 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -634,7 +634,7 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
     memcpy(&net_len, BEND(&wrapped_client_key) - sizeof(net_len),
            sizeof(net_len));
 
-    size_t wkc_len = ntohs(net_len);
+    uint16_t wkc_len = ntohs(net_len);
     if (!buf_advance(&wrapped_client_key, BLEN(&wrapped_client_key) - wkc_len))
     {
         msg(D_TLS_ERRORS, "Can not locate tls-crypt-v2 client key");
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index ee9677ab..214d43a4 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -294,7 +294,7 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
  * @return              false on error, true  on success
  *
  * On return enc_len is  set to actual size of the result.
- * enc is NULL or enc_len is not enough to store the result, it is set
+ * If enc is NULL or enc_len is not enough to store the result, it is set
  * to the required size and false is returned.
  */
 bool
@@ -339,8 +339,8 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
                         MAKE_DI(sha512), MAKE_DI(sha224), MAKE_DI(sha512_224),
                         MAKE_DI(sha512_256), {0, NULL, 0}};
 
-    int out_len = 0;
-    int ret = 0;
+    size_t out_len = 0;
+    bool ret = false;
 
     int nid = OBJ_sn2nid(mdname);
     if (nid == NID_undef)
@@ -356,7 +356,7 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
 
     if (tbslen != EVP_MD_size(EVP_get_digestbyname(mdname)))
     {
-        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%d>", (int)tbslen);
+        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%zu>", tbslen);
         goto done;
     }
 
@@ -385,13 +385,13 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
 
     out_len = tbslen + di->sz;
 
-    if (enc && (out_len <= (int) *enc_len))
+    if (enc && (out_len <= *enc_len))
     {
         /* combine header and digest */
         memcpy(enc, di->header, di->sz);
         memcpy(enc + di->sz, tbs, tbslen);
-        dmsg(D_XKEY, "encode_pkcs1: digest length = %d encoded length = %d",
-             (int) tbslen, (int) out_len);
+        dmsg(D_XKEY, "encode_pkcs1: digest length = %zu encoded length = %zu",
+             tbslen, out_len);
         ret = true;
     }
 
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index 787b5e33..dfc72874 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -41,6 +41,6 @@ prng_bytes(uint8_t *output, int len)
 {
     for (int i = 0; i < len; i++)
     {
-        output[i] = rand();
+        output[i] = (uint8_t)rand();
     }
 }
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index aec4e049..fc367dac 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -99,8 +99,8 @@ test_cipher_names(const char *ciphername, const char *openvpn_name)
 
     for (int i = 0; i < strlen(ciphername); i++)
     {
-        upper[i] = toupper(ciphername[i]);
-        lower[i] = tolower(ciphername[i]);
+        upper[i] = (char)toupper((unsigned char)ciphername[i]);
+        lower[i] = (char)tolower((unsigned char)ciphername[i]);
         if (rand() & 0x1)
         {
             random_case[i] = upper[i];
@@ -162,7 +162,7 @@ crypto_test_tls_prf(void **state)
 
 
     uint8_t out[32];
-    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
+    ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secret_len, out, sizeof(out));
 
     assert_memory_equal(good_prf, out, sizeof(out));
 }
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 9b653a8b..a576a576 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -96,7 +96,7 @@ test_packet_id_write_long(void **state)
     assert(data->pis.id == 1);
     assert(data->pis.time == now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl(now));
+    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
 
 static void
@@ -123,7 +123,7 @@ test_packet_id_write_long_prepend(void **state)
     assert(data->pis.id == 1);
     assert(data->pis.time == now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl(now));
+    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
 
 static void
@@ -154,7 +154,7 @@ test_packet_id_write_long_wrap(void **state)
     assert(data->pis.id == 1);
     assert(data->pis.time == now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl(now));
+    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
 
 static void
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 255067c7..79db9155 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -367,7 +367,7 @@ xkey_sign(void *handle, unsigned char *sig, size_t *siglen,
     }
 
     /* return a predefined string as sig */
-    memcpy(sig, good_sig, min_int(sizeof(good_sig), *siglen));
+    memcpy(sig, good_sig, min_int((int)sizeof(good_sig), (int)*siglen));
 
     return 1;
 }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 19ae29cc..2966ebb2 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -140,7 +140,7 @@ __wrap_rand_bytes(uint8_t *output, int len)
 {
     for (int i = 0; i < len; i++)
     {
-        output[i] = i;
+        output[i] = (uint8_t)i;
     }
     return true;
 }
-- 
2.34.1


