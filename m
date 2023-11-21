From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Nov 2023 11:10:40 +0100
Message-Id: <20231121101040.13528-1-frank@...2641...>
In-Reply-To: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
References: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Various fixes for -Wconversion errors
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

These are all fixes I considered "safe". They either

- Have sufficient checks/shifts for a cast to be safe
- Fix the type of a variable without requiring code changes
- Are in non-critical unittest code

v2:
 - add min_size instead of abusing min_int

Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/267
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 24f1ef2..a32e7d2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -352,7 +352,7 @@
         return false;
     }
 
-    const int size = write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size = write(fd, BPTR(buf), BLEN(buf));
     if (size != BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -889,7 +889,7 @@
         {
             break;
         }
-        line[n++] = c;
+        line[n++] = (char)c;
     }
     while (c);
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e4452d7..7768b9e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -26,6 +26,8 @@
 #include "config.h"
 #endif
 
+#include <inttypes.h>
+
 #include "syshead.h"
 
 #include "crypto.h"
@@ -1263,8 +1265,8 @@
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
@@ -1526,13 +1528,13 @@
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
index a012524..a0e421d 100644
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
 
 static inline int
@@ -72,6 +72,19 @@
     }
 }
 
+static inline size_t
+min_size(size_t x, size_t y)
+{
+    if (x < y)
+    {
+        return x;
+    }
+    else
+    {
+        return y;
+    }
+}
+
 static inline int
 max_int(int x, int y)
 {
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 1566c64..108b370 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -165,7 +165,7 @@
         return;
     }
 
-    for (olen = hlen - sizeof(struct openvpn_tcphdr),
+    for (olen = hlen - (int) sizeof(struct openvpn_tcphdr),
          opt = (uint8_t *)(tc + 1);
          olen > 1;
          olen -= optlen, opt += optlen)
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index b28a90f..e751246 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -105,7 +105,7 @@
 /* format a time_t as ascii, or use current time if 0 */
 
 const char *
-time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc)
+time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
     struct timeval tv;
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index c27be89..d795c3c 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -43,7 +43,7 @@
 bool frequency_limit_event_allowed(struct frequency_limit *f);
 
 /* format a time_t as ascii, or use current time if 0 */
-const char *time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc);
+const char *time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc);
 
 /* struct timeval functions */
 
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index ef83248..3d6f3ee 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -588,14 +588,14 @@
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
index e7d4d5f..0e26f98 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -257,8 +257,7 @@
                    struct buffer *buf,
                    const struct session_id *sid, int max, bool prepend)
 {
-    int i, j;
-    uint8_t n;
+    int i, j, n;
     struct buffer sub;
 
     n = ack->len;
@@ -270,9 +269,9 @@
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
index bfc1253..a4acc5d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1181,7 +1181,7 @@
 }
 
 /* write a TCP or UDP packet to link */
-static inline int
+static inline size_t
 link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
@@ -1198,7 +1198,7 @@
     else
     {
         ASSERT(0);
-        return -1; /* NOTREACHED */
+        return 0; /* NOTREACHED */
     }
 }
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 975d31f..f0946cb 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -634,7 +634,7 @@
     memcpy(&net_len, BEND(&wrapped_client_key) - sizeof(net_len),
            sizeof(net_len));
 
-    size_t wkc_len = ntohs(net_len);
+    uint16_t wkc_len = ntohs(net_len);
     if (!buf_advance(&wrapped_client_key, BLEN(&wrapped_client_key) - wkc_len))
     {
         msg(D_TLS_ERRORS, "Can not locate tls-crypt-v2 client key");
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 40839f2..fcf8c2e 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -292,7 +292,7 @@
  * @return              false on error, true  on success
  *
  * On return enc_len is  set to actual size of the result.
- * enc is NULL or enc_len is not enough to store the result, it is set
+ * If enc is NULL or enc_len is not enough to store the result, it is set
  * to the required size and false is returned.
  */
 bool
@@ -337,8 +337,8 @@
                         MAKE_DI(sha512), MAKE_DI(sha224), MAKE_DI(sha512_224),
                         MAKE_DI(sha512_256), {0, NULL, 0}};
 
-    int out_len = 0;
-    int ret = 0;
+    size_t out_len = 0;
+    bool ret = false;
 
     int nid = OBJ_sn2nid(mdname);
     if (nid == NID_undef)
@@ -354,7 +354,7 @@
 
     if (tbslen != EVP_MD_size(EVP_get_digestbyname(mdname)))
     {
-        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%d>", (int)tbslen);
+        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%zu>", tbslen);
         goto done;
     }
 
@@ -383,13 +383,13 @@
 
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
index 787b5e3..dfc7287 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -41,6 +41,6 @@
 {
     for (int i = 0; i < len; i++)
     {
-        output[i] = rand();
+        output[i] = (uint8_t)rand();
     }
 }
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 5564524..9cfa9dc 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -97,8 +97,8 @@
 
     for (int i = 0; i < strlen(ciphername); i++)
     {
-        upper[i] = toupper(ciphername[i]);
-        lower[i] = tolower(ciphername[i]);
+        upper[i] = (char)toupper((unsigned char)ciphername[i]);
+        lower[i] = (char)tolower((unsigned char)ciphername[i]);
         if (rand() & 0x1)
         {
             random_case[i] = upper[i];
@@ -160,7 +160,7 @@
 
 
     uint8_t out[32];
-    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
+    ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secret_len, out, sizeof(out));
 
     assert_memory_equal(good_prf, out, sizeof(out));
 }
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 90c67ac..c351858 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -94,7 +94,7 @@
     assert(data->pis.id == 1);
     assert(data->pis.time == now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl(now));
+    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
 
 static void
@@ -121,7 +121,7 @@
     assert(data->pis.id == 1);
     assert(data->pis.time == now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl(now));
+    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
 
 static void
@@ -152,7 +152,7 @@
     assert(data->pis.id == 1);
     assert(data->pis.time == now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl(now));
+    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
 
 static void
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 335fca2..5e57f33 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -365,7 +365,7 @@
     }
 
     /* return a predefined string as sig */
-    memcpy(sig, good_sig, min_int(sizeof(good_sig), *siglen));
+    memcpy(sig, good_sig, min_size(sizeof(good_sig), *siglen));
 
     return 1;
 }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index ed7c794..3b885ab 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -138,7 +138,7 @@
 {
     for (int i = 0; i < len; i++)
     {
-        output[i] = i;
+        output[i] = (uint8_t)i;
     }
     return true;
 }

