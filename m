From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 26 Aug 2022 10:54:25 +0200
Message-Id: <20220826085427.25302-5-frank@...2641...>
In-Reply-To: <20220826085427.25302-1-frank@...2641...>
References: <20220826085427.25302-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/6] reformat for sp_arith_additive=add
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/buffer.c                      |  6 +--
 src/openvpn/buffer.h                      |  2 +-
 src/openvpn/console_systemd.c             |  2 +-
 src/openvpn/crypto.c                      |  6 +--
 src/openvpn/crypto_mbedtls.c              | 10 ++---
 src/openvpn/cryptoapi.c                   |  2 +-
 src/openvpn/dhcp.c                        | 14 +++----
 src/openvpn/env_set.c                     |  2 +-
 src/openvpn/event.c                       |  8 ++--
 src/openvpn/gremlin.c                     |  8 ++--
 src/openvpn/httpdigest.c                  |  4 +-
 src/openvpn/httpdigest.h                  |  2 +-
 src/openvpn/init.c                        |  4 +-
 src/openvpn/list.h                        |  2 +-
 src/openvpn/manage.c                      | 14 +++----
 src/openvpn/mbuf.h                        |  2 +-
 src/openvpn/misc.c                        | 12 +++---
 src/openvpn/mroute.h                      |  8 ++--
 src/openvpn/mss.c                         |  6 +--
 src/openvpn/ntlm.c                        | 10 ++---
 src/openvpn/openvpn.c                     |  2 +-
 src/openvpn/options.c                     | 48 +++++++++++------------
 src/openvpn/otime.c                       |  2 +-
 src/openvpn/pkcs11.c                      |  2 +-
 src/openvpn/pkcs11_openssl.c              |  2 +-
 src/openvpn/plugin.c                      |  2 +-
 src/openvpn/pool.c                        |  2 +-
 src/openvpn/proto.c                       |  2 +-
 src/openvpn/proxy.c                       | 16 ++++----
 src/openvpn/push.c                        |  8 ++--
 src/openvpn/reliable.c                    |  4 +-
 src/openvpn/route.c                       | 10 ++---
 src/openvpn/route.h                       |  2 +-
 src/openvpn/schedule.c                    |  8 ++--
 src/openvpn/socket.c                      |  6 +--
 src/openvpn/ssl.c                         |  4 +-
 src/openvpn/ssl_mbedtls.c                 |  2 +-
 src/openvpn/ssl_openssl.c                 |  2 +-
 src/openvpn/ssl_pkt.c                     |  2 +-
 src/openvpn/ssl_verify.c                  |  2 +-
 src/openvpn/ssl_verify_mbedtls.c          | 12 +++---
 src/openvpn/ssl_verify_openssl.c          |  4 +-
 src/openvpn/status.c                      |  2 +-
 src/openvpn/tun.c                         | 10 ++---
 src/openvpn/win32.c                       |  2 +-
 src/openvpnmsica/openvpnmsica.c           |  2 +-
 src/openvpnserv/interactive.c             | 10 ++---
 src/openvpnserv/service.c                 |  4 +-
 src/plugins/auth-pam/auth-pam.c           |  8 ++--
 src/plugins/auth-pam/utils.c              |  6 +--
 src/plugins/down-root/down-root.c         |  2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c | 10 ++---
 52 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 575d45a1..d3a299e5 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -862,7 +862,7 @@ buf_parse(struct buffer *buf, const int delim, char *line, const int size)
     }
     while (c);
 
-    line[size-1] = '\0';
+    line[size - 1] = '\0';
     return !(eol && !strlen(line));
 }
 
@@ -1148,7 +1148,7 @@ valign4(const struct buffer *buf, const char *file, const int line)
         int msglevel = D_ALIGN_DEBUG;
         const unsigned int u = (unsigned int) BPTR(buf);
 
-        if (u & (PAYLOAD_ALIGN-1))
+        if (u & (PAYLOAD_ALIGN - 1))
         {
             msglevel = D_ALIGN_ERRORS;
         }
@@ -1216,7 +1216,7 @@ buffer_list_push(struct buffer_list *ol, const char *str)
     if (str)
     {
         const size_t len = strlen((const char *)str);
-        struct buffer_entry *e = buffer_list_push_data(ol, str, len+1);
+        struct buffer_entry *e = buffer_list_push_data(ol, str, len + 1);
         if (e)
         {
             e->buf.len = (int)len; /* Don't count trailing '\0' as part of length */
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index fece6336..25c484b2 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -349,7 +349,7 @@ strncpynt(char *dest, const char *src, size_t maxlen)
 {
     if (maxlen > 0)
     {
-        strncpy(dest, src, maxlen-1);
+        strncpy(dest, src, maxlen - 1);
         dest[maxlen - 1] = 0;
     }
 }
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index c7cf1ada..3ef0038c 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -78,7 +78,7 @@ get_console_input_systemd(const char *prompt, const bool echo, char *input, cons
         return false;
     }
     memset(input, 0, capacity);
-    if (read(std_out, input, capacity-1) != 0)
+    if (read(std_out, input, capacity - 1) != 0)
     {
         chomp(input);
         ret = true;
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 397f4cdb..d582cc8f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -720,8 +720,8 @@ unsigned int
 crypto_max_overhead(void)
 {
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH
-           +OPENVPN_MAX_CIPHER_BLOCK_SIZE
-           +max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+           + OPENVPN_MAX_CIPHER_BLOCK_SIZE
+           + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
 static void
@@ -1535,7 +1535,7 @@ verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared
         if (!check_key(&key2->keys[i], kt))
         {
             msg(M_FATAL, "Key #%d in '%s' is bad.  Try making a new key with --genkey.",
-                i+1, shared_secret_file);
+                i + 1, shared_secret_file);
         }
     }
 }
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2c748f7c..f036744d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -235,8 +235,8 @@ crypto_pem_encode(const char *name, struct buffer *dst,
                   const struct buffer *src, struct gc_arena *gc)
 {
     /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000+1] = { 0 };
-    char footer[1000+1] = { 0 };
+    char header[1000 + 1] = { 0 };
+    char footer[1000 + 1] = { 0 };
 
     if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
     {
@@ -260,7 +260,7 @@ crypto_pem_encode(const char *name, struct buffer *dst,
     *dst = alloc_buf_gc(out_len, gc);
     if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src),
                                           BPTR(dst), BCAP(dst), &out_len))
-        || !buf_inc_len(dst, out_len-1))
+        || !buf_inc_len(dst, out_len - 1))
     {
         CLEAR(*dst);
         return false;
@@ -274,8 +274,8 @@ crypto_pem_decode(const char *name, struct buffer *dst,
                   const struct buffer *src)
 {
     /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000+1] = { 0 };
-    char footer[1000+1] = { 0 };
+    char header[1000 + 1] = { 0 };
+    char footer[1000 + 1] = { 0 };
 
     if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
     {
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 661a9a6d..355a1149 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -279,7 +279,7 @@ ecdsa_bin2sig(unsigned char *buf, int len)
     ECDSA_SIG *ecsig = NULL;
     DWORD rlen = len/2;
     BIGNUM *r = BN_bin2bn(buf, rlen, NULL);
-    BIGNUM *s = BN_bin2bn(buf+rlen, rlen, NULL);
+    BIGNUM *s = BN_bin2bn(buf + rlen, rlen, NULL);
     if (!r || !s)
     {
         goto err;
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index b1274255..a169c4cd 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -56,9 +56,9 @@ get_dhcp_message_type(const struct dhcp *dhcp, const int optlen)
         {
             if (room >= 3)
             {
-                if (p[i+1] == 1)      /* option length should be 1 */
+                if (p[i + 1] == 1)      /* option length should be 1 */
                 {
-                    return p[i+2];    /* return message type */
+                    return p[i + 2];    /* return message type */
                 }
             }
             return -1;
@@ -67,7 +67,7 @@ get_dhcp_message_type(const struct dhcp *dhcp, const int optlen)
         {
             if (room >= 2)
             {
-                const int len = p[i+1]; /* get option length */
+                const int len = p[i + 1]; /* get option length */
                 i += (len + 1);       /* advance to next option */
             }
         }
@@ -98,13 +98,13 @@ do_extract(struct dhcp *dhcp, int optlen)
         {
             if (room >= 2)
             {
-                const int len = p[i+1]; /* get option length */
-                if (len <= (room-2))
+                const int len = p[i + 1]; /* get option length */
+                if (len <= (room - 2))
                 {
                     /* get router IP address */
                     if (!ret && len >= 4 && (len & 3) == 0)
                     {
-                        memcpy(&ret, p+i+2, 4);
+                        memcpy(&ret, p + i + 2, 4);
                         ret = ntohl(ret);
                     }
                     {
@@ -135,7 +135,7 @@ do_extract(struct dhcp *dhcp, int optlen)
         {
             if (room >= 2)
             {
-                const int len = p[i+1]; /* get option length */
+                const int len = p[i + 1]; /* get option length */
                 i += (len + 2);         /* advance to next option */
             }
             else
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 12d83643..09ec29e1 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -438,7 +438,7 @@ make_env_array(const struct env_set *es,
     }
 
     /* alloc return array */
-    ALLOC_ARRAY_CLEAR_GC(ret, char *, n+1, gc);
+    ALLOC_ARRAY_CLEAR_GC(ret, char *, n + 1, gc);
 
     /* fill return array */
     if (es)
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 8546dff7..4d3bf1a1 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -179,8 +179,8 @@ we_del_index(struct we_set *wes, int index)
     ASSERT(index >= 0 && index < wes->n_events);
     for (i = index; i < wes->n_events - 1; ++i)
     {
-        wes->events[i] = wes->events[i+1];
-        wes->esr[i] = wes->esr[i+1];
+        wes->events[i] = wes->events[i + 1];
+        wes->esr[i] = wes->esr[i + 1];
     }
     --wes->n_events;
 }
@@ -734,8 +734,8 @@ po_del(struct event_set *es, event_t event)
             int j;
             for (j = i; j < pos->n_events - 1; ++j)
             {
-                pos->events[j] = pos->events[j+1];
-                pos->args[j] = pos->args[j+1];
+                pos->events[j] = pos->events[j + 1];
+                pos->args[j] = pos->args[j + 1];
             }
             --pos->n_events;
             break;
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index aca48fc4..60668080 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -150,12 +150,12 @@ ask_gremlin(int flags)
             int delta;
             if (up)
             {
-                delta = roll(down_low[up_down_level-1], down_high[up_down_level-1]);
+                delta = roll(down_low[up_down_level - 1], down_high[up_down_level - 1]);
                 up = false;
             }
             else
             {
-                delta = roll(up_low[up_down_level-1], up_high[up_down_level-1]);
+                delta = roll(up_low[up_down_level - 1], up_high[up_down_level - 1]);
                 up = true;
             }
 
@@ -169,7 +169,7 @@ ask_gremlin(int flags)
 
     if (drop_level)
     {
-        if (up && flip(drop_freq[drop_level-1]))
+        if (up && flip(drop_freq[drop_level - 1]))
         {
             dmsg(D_GREMLIN_VERBOSE, "GREMLIN: Random packet drop");
             return false;
@@ -188,7 +188,7 @@ corrupt_gremlin(struct buffer *buf, int flags)
     const int corrupt_level = GREMLIN_CORRUPT_LEVEL(flags);
     if (corrupt_level)
     {
-        if (flip(corrupt_freq[corrupt_level-1]))
+        if (flip(corrupt_freq[corrupt_level - 1]))
         {
             do
             {
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index f2821886..833315ce 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -57,11 +57,11 @@ CvtHex(
         j = Bin[i] & 0xf;
         if (j <= 9)
         {
-            Hex[i*2+1] = (j + '0');
+            Hex[i*2 + 1] = (j + '0');
         }
         else
         {
-            Hex[i*2+1] = (j + 'a' - 10);
+            Hex[i*2 + 1] = (j + 'a' - 10);
         }
     }
     Hex[HASHHEXLEN] = '\0';
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index b3909a65..66372de3 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -26,7 +26,7 @@
 #define HASHLEN 16
 typedef unsigned char HASH[HASHLEN];
 #define HASHHEXLEN 32
-typedef unsigned char HASHHEX[HASHHEXLEN+1];
+typedef unsigned char HASHHEX[HASHHEXLEN + 1];
 #undef IN
 #undef OUT
 #define IN const
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 907c975f..598b4df2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2977,8 +2977,8 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     {
         /* Add user-specified jitter to reneg-sec */
         to.renegotiate_seconds = options->renegotiate_seconds
-                                 -(get_random() % max_int(options->renegotiate_seconds
-                                                          - options->renegotiate_seconds_min, 1));
+                                 - (get_random() % max_int(options->renegotiate_seconds
+                                                           - options->renegotiate_seconds_min, 1));
     }
     to.single_session = options->single_session;
     to.mode = options->mode;
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index e66f6052..8260bd94 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -40,7 +40,7 @@
 #include "buffer.h"
 
 #define hashsize(n) ((uint32_t)1<<(n))
-#define hashmask(n) (hashsize(n)-1)
+#define hashmask(n) (hashsize(n) - 1)
 
 struct hash_element
 {
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 43048eb9..a691c69d 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1952,7 +1952,7 @@ man_process_command(struct management *man, const char *line)
     struct gc_arena gc = gc_new();
     struct status_output *so;
     int nparms;
-    char *parms[MAX_PARMS+1];
+    char *parms[MAX_PARMS + 1];
 
     CLEAR(parms);
     so = status_open(NULL, 0, -1, &man->persist.vout, 0);
@@ -2108,7 +2108,7 @@ management_android_control(struct management *man, const char *command, const ch
 {
     struct user_pass up;
     CLEAR(up);
-    strncpy(up.username, msg, sizeof(up.username)-1);
+    strncpy(up.username, msg, sizeof(up.username) - 1);
 
     management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *) 0);
     return strcmp("ok", up.password) == 0;
@@ -3536,12 +3536,12 @@ management_query_multiline(struct management *man,
 
         if (b64_data)
         {
-            alert_msg = alloc_buf_gc(strlen(b64_data)+strlen(prompt)+3, &gc);
+            alert_msg = alloc_buf_gc(strlen(b64_data) + strlen(prompt) + 3, &gc);
             buf_printf(&alert_msg, ">%s:%s", prompt, b64_data);
         }
         else
         {
-            alert_msg = alloc_buf_gc(strlen(prompt)+3, &gc);
+            alert_msg = alloc_buf_gc(strlen(prompt) + 3, &gc);
             buf_printf(&alert_msg, ">%s", prompt);
         }
 
@@ -3608,7 +3608,7 @@ management_query_multiline_flatten_newline(struct management *man,
         buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
-            result = (char *) malloc(BLEN(buf)+1);
+            result = (char *) malloc(BLEN(buf) + 1);
             check_malloc_return(result);
             memcpy(result, buf->data, BLEN(buf));
             result[BLEN(buf)] = '\0';
@@ -3637,7 +3637,7 @@ management_query_multiline_flatten(struct management *man,
         buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
-            result = (char *) malloc(BLEN(buf)+1);
+            result = (char *) malloc(BLEN(buf) + 1);
             check_malloc_return(result);
             memcpy(result, buf->data, BLEN(buf));
             result[BLEN(buf)] = '\0';
@@ -3684,7 +3684,7 @@ management_query_cert(struct management *man, const char *cert_name)
     const char prompt_1[] = "NEED-CERTIFICATE:";
     struct buffer buf_prompt = alloc_buf(strlen(cert_name) + 20);
     buf_write(&buf_prompt, prompt_1, strlen(prompt_1));
-    buf_write(&buf_prompt, cert_name, strlen(cert_name)+1); /* +1 for \0 */
+    buf_write(&buf_prompt, cert_name, strlen(cert_name) + 1); /* +1 for \0 */
 
     char *result;
     result = management_query_multiline_flatten_newline(management,
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index e6b68507..c7b21aa3 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -36,7 +36,7 @@
 
 struct multi_instance;
 
-#define MBUF_INDEX(head, offset, size) (((head) + (offset)) & ((size)-1))
+#define MBUF_INDEX(head, offset, size) (((head) + (offset)) & ((size) - 1))
 
 struct mbuf_buffer
 {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 07f6e202..0ec806fc 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -87,7 +87,7 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
 
     uint8_t rnd_bytes[n_rnd_bytes];
     const char *rnd_str;
-    struct buffer hname = alloc_buf_gc(strlen(hostname)+sizeof(rnd_bytes)*2+4, gc);
+    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes)*2 + 4, gc);
 
     prng_bytes(rnd_bytes, sizeof(rnd_bytes));
     rnd_str = format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
@@ -289,7 +289,7 @@ get_user_pass_cr(struct user_pass *up,
                     char *response = (char *) gc_malloc(USER_PASS_LEN, false, &gc);
                     struct buffer packed_resp, challenge;
 
-                    challenge = alloc_buf_gc(14+strlen(ac->challenge_text), &gc);
+                    challenge = alloc_buf_gc(14 + strlen(ac->challenge_text), &gc);
                     buf_printf(&challenge, "CHALLENGE: %s", ac->challenge_text);
                     buf_set_write(&packed_resp, (uint8_t *)up->password, USER_PASS_LEN);
 
@@ -348,7 +348,7 @@ get_user_pass_cr(struct user_pass *up,
                     struct buffer packed_resp, challenge;
                     char *pw64 = NULL, *resp64 = NULL;
 
-                    challenge = alloc_buf_gc(14+strlen(auth_challenge), &gc);
+                    challenge = alloc_buf_gc(14 + strlen(auth_challenge), &gc);
                     buf_printf(&challenge, "CHALLENGE: %s", auth_challenge);
 
                     if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challenge),
@@ -401,7 +401,7 @@ get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
     {
         struct auth_challenge_info *ac;
         const int len = strlen(auth_challenge);
-        char *work = (char *) gc_malloc(len+1, false, gc);
+        char *work = (char *) gc_malloc(len + 1, false, gc);
         char *cp;
 
         struct buffer b;
@@ -449,7 +449,7 @@ get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
         {
             return NULL;
         }
-        ac->user = (char *) gc_malloc(strlen(work)+1, true, gc);
+        ac->user = (char *) gc_malloc(strlen(work) + 1, true, gc);
         openvpn_base64_decode(work, (void *)ac->user, -1);
 
         /* parse challenge text */
@@ -655,7 +655,7 @@ make_extended_arg_array(char **p, bool is_inline, struct gc_arena *gc)
 const char *
 sanitize_control_message(const char *src, struct gc_arena *gc)
 {
-    char *ret = gc_malloc(strlen(src)+1, false, gc);
+    char *ret = gc_malloc(strlen(src) + 1, false, gc);
     char *dest = ret;
     bool redact = false;
     int skip = 0;
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8eb20249..6268d218 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -40,10 +40,10 @@
 #define MROUTE_EXTRACT_MCAST     (1<<2)
 #define MROUTE_EXTRACT_IGMP      (1<<3)
 
-#define MROUTE_SEC_EXTRACT_SUCCEEDED (1<<(0+MROUTE_SEC_SHIFT))
-#define MROUTE_SEC_EXTRACT_BCAST     (1<<(1+MROUTE_SEC_SHIFT))
-#define MROUTE_SEC_EXTRACT_MCAST     (1<<(2+MROUTE_SEC_SHIFT))
-#define MROUTE_SEC_EXTRACT_IGMP      (1<<(3+MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_SUCCEEDED (1<<(0 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_BCAST     (1<<(1 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_MCAST     (1<<(2 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_IGMP      (1<<(3 + MROUTE_SEC_SHIFT))
 
 #define MROUTE_SEC_SHIFT         4
 
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 381e61a2..d0a83090 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -102,7 +102,7 @@ mss_fixup_ipv6(struct buffer *buf, int maxmss)
     /* do we have the full IPv6 packet?
      * "payload_len" does not include IPv6 header (+40 bytes)
      */
-    if (BLEN(buf) != (int) ntohs(pip6->payload_len)+40)
+    if (BLEN(buf) != (int) ntohs(pip6->payload_len) + 40)
     {
         return;
     }
@@ -132,7 +132,7 @@ mss_fixup_ipv6(struct buffer *buf, int maxmss)
         struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR(&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
         {
-            mss_fixup_dowork(&newbuf, (uint16_t) maxmss-20);
+            mss_fixup_dowork(&newbuf, (uint16_t) maxmss - 20);
         }
     }
 }
@@ -193,7 +193,7 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
                 {
                     continue;
                 }
-                mssval = (opt[2]<<8)+opt[3];
+                mssval = (opt[2]<<8) + opt[3];
                 if (mssval > maxmss)
                 {
                     dmsg(D_MSS, "MSS: %d -> %d", (int) mssval, (int) maxmss);
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index ddd725bd..d7d7f264 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -228,14 +228,14 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
     separator = strchr(p->up.username, '\\');
     if (separator == NULL)
     {
-        strncpy(username, p->up.username, sizeof(username)-1);
-        username[sizeof(username)-1] = 0;
+        strncpy(username, p->up.username, sizeof(username) - 1);
+        username[sizeof(username) - 1] = 0;
         domain[0] = 0;
     }
     else
     {
-        strncpy(username, separator+1, sizeof(username)-1);
-        username[sizeof(username)-1] = 0;
+        strncpy(username, separator + 1, sizeof(username) - 1);
+        username[sizeof(username) - 1] = 0;
         len = separator - p->up.username;
         if (len > sizeof(domain) - 1)
         {
@@ -265,7 +265,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
     /* extract the challenge from bytes 24-31 */
     for (i = 0; i < 8; i++)
     {
-        challenge[i] = buf2[i+24];
+        challenge[i] = buf2[i + 24];
     }
 
     if (ntlmv2_enabled)      /* Generate NTLMv2 response */
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 15e21452..86a0bc07 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -363,7 +363,7 @@ wmain(int argc, wchar_t *wargv[])
     int ret;
     int i;
 
-    if ((argv = calloc(argc+1, sizeof(char *))) == NULL)
+    if ((argv = calloc(argc + 1, sizeof(char *))) == NULL)
     {
         return 1;
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e866c57d..d3ebe056 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1008,7 +1008,7 @@ setenv_settings(struct env_set *es, const struct options *o)
         int i;
         for (i = 0; i < o->connection_list->len; ++i)
         {
-            setenv_connection_entry(es, o->connection_list->array[i], i+1);
+            setenv_connection_entry(es, o->connection_list->array[i], i + 1);
         }
     }
     else
@@ -2768,7 +2768,7 @@ options_postprocess_verify_ce(const struct options *options,
      * SSL/TLS mode sanity checks.
      */
     if (options->tls_server + options->tls_client
-        +(options->shared_secret_file != NULL) > 1)
+        + (options->shared_secret_file != NULL) > 1)
     {
         msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
     }
@@ -2935,7 +2935,7 @@ options_postprocess_verify_ce(const struct options *options,
                 const int sum =
 #ifdef ENABLE_MANAGEMENT
                     ((options->cert_file != NULL) || (options->management_flags & MF_EXTERNAL_CERT))
-                    +((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
+                    + ((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
 #else
                     (options->cert_file != NULL) + (options->priv_key_file != NULL);
 #endif
@@ -4531,13 +4531,13 @@ options_string_extract_option(const char *options_string, const char *opt_name,
     while (p)
     {
         if (0 == strncmp(p, opt_name, opt_name_len)
-            && strlen(p) > (opt_name_len+1) && p[opt_name_len] == ' ')
+            && strlen(p) > (opt_name_len + 1) && p[opt_name_len] == ' ')
         {
             /* option found, extract value */
-            const char *start = &p[opt_name_len+1];
+            const char *start = &p[opt_name_len + 1];
             const char *end = strchr(p, ',');
             size_t val_len = end ? end - start : strlen(start);
-            ret = gc_malloc(val_len+1, true, gc);
+            ret = gc_malloc(val_len + 1, true, gc);
             memcpy(ret, start, val_len);
             break;
         }
@@ -5065,7 +5065,7 @@ read_inline_file(struct in_src *is, const char *close_tag,
             endtagfound = true;
             break;
         }
-        if (!buf_safe(&buf, strlen(line)+1))
+        if (!buf_safe(&buf, strlen(line) + 1))
         {
             /* Increase buffer size */
             struct buffer buf2 = alloc_buf(buf.capacity * 2);
@@ -5095,7 +5095,7 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
     if (p[0] && !p[1])
     {
         char *arg = p[0];
-        if (arg[0] == '<' && arg[strlen(arg)-1] == '>')
+        if (arg[0] == '<' && arg[strlen(arg) - 1] == '>')
         {
             struct buffer close_tag;
 
@@ -5156,8 +5156,8 @@ read_config_file(struct options *options,
     const int max_recursive_levels = 10;
     FILE *fp;
     int line_num;
-    char line[OPTION_LINE_SIZE+1];
-    char *p[MAX_PARMS+1];
+    char line[OPTION_LINE_SIZE + 1];
+    char *p[MAX_PARMS + 1];
 
     ++level;
     if (level <= max_recursive_levels)
@@ -5189,7 +5189,7 @@ read_config_file(struct options *options,
                 {
                     offset = 3;
                 }
-                if (parse_line(line + offset, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
+                if (parse_line(line + offset, p, SIZE(p) - 1, file, line_num, msglevel, &options->gc))
                 {
                     bypass_doubledash(&p[0]);
                     int lines_inline = check_inline_file_via_fp(fp, p, &options->gc);
@@ -5234,10 +5234,10 @@ read_config_string(const char *prefix,
 
     while (buf_parse(&multiline, '\n', line, sizeof(line)))
     {
-        char *p[MAX_PARMS+1];
+        char *p[MAX_PARMS + 1];
         CLEAR(p);
         ++line_num;
-        if (parse_line(line, p, SIZE(p)-1, prefix, line_num, msglevel, &options->gc))
+        if (parse_line(line, p, SIZE(p) - 1, prefix, line_num, msglevel, &options->gc))
         {
             bypass_doubledash(&p[0]);
             int lines_inline = check_inline_file_via_buf(&multiline, p, &options->gc);
@@ -5372,14 +5372,14 @@ apply_push_options(struct options *options,
 
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        char *p[MAX_PARMS+1];
+        char *p[MAX_PARMS + 1];
         CLEAR(p);
         ++line_num;
         if (!apply_pull_filter(options, line))
         {
             return false; /* Cause push/pull error and stop push processing */
         }
-        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
+        if (parse_line(line, p, SIZE(p) - 1, file, line_num, msglevel, &options->gc))
         {
             add_option(options, p, false, file, line_num, 0, msglevel,
                        permission_mask, option_types_found, es);
@@ -6051,7 +6051,7 @@ add_option(struct options *options,
         }
 
         /* Allocate array */
-        ALLOC_ARRAY_GC(ignore, const char *, numignored+1, &options->gc);
+        ALLOC_ARRAY_GC(ignore, const char *, numignored + 1, &options->gc);
         for (i = 0; options->ignore_unknown_option
              && options->ignore_unknown_option[i]; i++)
         {
@@ -6065,7 +6065,7 @@ add_option(struct options *options,
             /* Allow the user to specify ignore-unknown-option --opt too */
             if (p[j][0] == '-' && p[j][1] == '-')
             {
-                options->ignore_unknown_option[i] = (p[j]+2);
+                options->ignore_unknown_option[i] = (p[j] + 2);
             }
             else
             {
@@ -8900,7 +8900,7 @@ add_option(struct options *options,
         size_t j;
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            sscanf(p[j], "%x", &(options->remote_cert_ku[j-1]));
+            sscanf(p[j], "%x", &(options->remote_cert_ku[j - 1]));
         }
         if (j == 1)
         {
@@ -9090,11 +9090,11 @@ add_option(struct options *options,
                         "configuration", p[j]);
                 }
             }
-            else if (!x509_username_field_ext_supported(s+4))
+            else if (!x509_username_field_ext_supported(s + 4))
             {
                 msg(msglevel, "Unsupported x509-username-field extension: %s", s);
             }
-            options->x509_username_field[j-1] = p[j];
+            options->x509_username_field[j - 1] = p[j];
         }
     }
 #endif /* ENABLE_X509ALTUSERNAME */
@@ -9143,7 +9143,7 @@ add_option(struct options *options,
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            options->pkcs11_providers[j-1] = p[j];
+            options->pkcs11_providers[j - 1] = p[j];
         }
     }
     else if (streq(p[0], "pkcs11-protected-authentication"))
@@ -9154,7 +9154,7 @@ add_option(struct options *options,
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            options->pkcs11_protected_authentication[j-1] = atoi(p[j]) != 0 ? 1 : 0;
+            options->pkcs11_protected_authentication[j - 1] = atoi(p[j]) != 0 ? 1 : 0;
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -9165,7 +9165,7 @@ add_option(struct options *options,
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            sscanf(p[j], "%x", &(options->pkcs11_private_mode[j-1]));
+            sscanf(p[j], "%x", &(options->pkcs11_private_mode[j - 1]));
         }
     }
     else if (streq(p[0], "pkcs11-cert-private"))
@@ -9176,7 +9176,7 @@ add_option(struct options *options,
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            options->pkcs11_cert_private[j-1] = atoi(p[j]) != 0 ? 1 : 0;
+            options->pkcs11_cert_private[j - 1] = atoi(p[j]) != 0 ? 1 : 0;
         }
     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 80eac149..a507796c 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -126,7 +126,7 @@ time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc)
     struct tm *tm = localtime(&t);
 
     buf_printf(&out, "%04d-%02d-%02d %02d:%02d:%02d",
-               tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
+               tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
                tm->tm_hour, tm->tm_min, tm->tm_sec);
 
     if (show_usec && tv.tv_usec)
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 7cf04335..a2f7b52a 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -178,7 +178,7 @@ _pkcs11_openvpn_log(
     (void)global_data;
 
     vsnprintf(Buffer, sizeof(Buffer), szFormat, args);
-    Buffer[sizeof(Buffer)-1] = 0;
+    Buffer[sizeof(Buffer) - 1] = 0;
 
     msg(_pkcs11_msg_pkcs112openvpn(flags), "%s", Buffer);
 }
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 8b594346..de492ddd 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -431,7 +431,7 @@ pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial,
     }
 
     i2a_ASN1_INTEGER(bio, X509_get_serialNumber(x509));
-    n = BIO_read(bio, serial, serial_len-1);
+    n = BIO_read(bio, serial, serial_len - 1);
 
     if (n < 0)
     {
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 51136fea..9190a43b 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -152,7 +152,7 @@ plugin_mask_string(const unsigned int type_mask, struct gc_arena *gc)
 static inline unsigned int
 plugin_supported_types(void)
 {
-    return ((1<<OPENVPN_PLUGIN_N)-1);
+    return ((1<<OPENVPN_PLUGIN_N) - 1);
 }
 
 struct plugin_option_list *
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 88af4b55..2bbedfcc 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -809,7 +809,7 @@ ifconfig_pool_test(in_addr_t start, in_addr_t end)
         ifconfig_pool_handle h;
         in_addr_t local, remote;
         char buf[256];
-        snprintf(buf, sizeof(buf), "common-name-%d", i+24);
+        snprintf(buf, sizeof(buf), "common-name-%d", i + 24);
 #ifdef DUP_CN
         cn = NULL;
 #else
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 88abd199..31ce0b00 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -135,7 +135,7 @@ ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_payload,
     for (int i = 0; i < len_payload; i += 2)
     {
         sum +=  (uint16_t)(((payload[i] << 8) & 0xFF00)
-                           +((i + 1 < len_payload) ? (payload[i + 1] & 0xFF) : 0));
+                           + ((i + 1 < len_payload) ? (payload[i + 1] & 0xFF) : 0));
 
     }
 
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ed720161..a7263f57 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -337,22 +337,22 @@ get_proxy_authenticate(socket_descriptor_t sd,
         }
         if (ret == HTTP_AUTH_NONE && !strncmp(buf, "Proxy-Authenticate: ", 20))
         {
-            if (!strncmp(buf+20, "Basic ", 6))
+            if (!strncmp(buf + 20, "Basic ", 6))
             {
                 msg(D_PROXY, "PROXY AUTH BASIC: '%s'", buf);
-                *data = string_alloc(buf+26, NULL);
+                *data = string_alloc(buf + 26, NULL);
                 ret = HTTP_AUTH_BASIC;
             }
 #if PROXY_DIGEST_AUTH
-            else if (!strncmp(buf+20, "Digest ", 7))
+            else if (!strncmp(buf + 20, "Digest ", 7))
             {
                 msg(D_PROXY, "PROXY AUTH DIGEST: '%s'", buf);
-                *data = string_alloc(buf+27, NULL);
+                *data = string_alloc(buf + 27, NULL);
                 ret = HTTP_AUTH_DIGEST;
             }
 #endif
 #if NTLM
-            else if (!strncmp(buf+20, "NTLM", 4))
+            else if (!strncmp(buf + 20, "NTLM", 4))
             {
                 msg(D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
                 *data = NULL;
@@ -386,7 +386,7 @@ get_key_value(const char *str,       /* source string */
     bool starts_with_quote = false;
     bool escape = false;
 
-    for (c = max_key_len-1; (*str && (*str != '=') && c--); )
+    for (c = max_key_len - 1; (*str && (*str != '=') && c--); )
     {
         *key++ = *str++;
     }
@@ -405,7 +405,7 @@ get_key_value(const char *str,       /* source string */
         starts_with_quote = true;
     }
 
-    for (c = max_value_len-1; *str && c--; str++)
+    for (c = max_value_len - 1; *str && c--; str++)
     {
         switch (*str)
         {
@@ -900,7 +900,7 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
 
                 if (opaque)
                 {
-                    const int len = strlen(opaque)+16;
+                    const int len = strlen(opaque) + 16;
                     opaque_kv = gc_malloc(len, false, &gc);
                     openvpn_snprintf(opaque_kv, len, ", opaque=\"%s\"", opaque);
                 }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 121ea691..b24550b3 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -353,7 +353,7 @@ send_auth_failed(struct context *c, const char *client_reason)
 
     schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
 
-    len = (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_failed);
+    len = (client_reason ? strlen(client_reason) + 1 : 0) + sizeof(auth_failed);
     if (len > PUSH_BUNDLE_SIZE)
     {
         len = PUSH_BUNDLE_SIZE;
@@ -699,7 +699,7 @@ send_push_reply(struct context *c, struct push_list *per_client_push_list)
         buf_printf(&buf, ",push-continuation 1");
     }
 
-    if (BLEN(&buf) > sizeof(push_reply_cmd)-1)
+    if (BLEN(&buf) > sizeof(push_reply_cmd) - 1)
     {
         const bool status = send_control_channel_string(c, BSTR(&buf), D_PUSH);
         if (!status)
@@ -802,7 +802,7 @@ push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
     va_start(arglist, format);
     len = vsnprintf(tmp, sizeof(tmp), format, arglist);
     va_end(arglist);
-    if (len > sizeof(tmp)-1)
+    if (len > sizeof(tmp) - 1)
     {
         return false;
     }
@@ -916,7 +916,7 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
         {
             continue;
         }
-        md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
+        md_ctx_update(ctx, (const uint8_t *) line, strlen(line) + 1);
     }
 }
 
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 73473625..7856d6a2 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -58,7 +58,7 @@ reliable_pid_in_range1(const packet_id_type test,
     }
     else
     {
-        if ((test+0x80000000u) - (base+0x80000000u) < extent)
+        if ((test + 0x80000000u) - (base + 0x80000000u) < extent)
         {
             return true;
         }
@@ -84,7 +84,7 @@ reliable_pid_in_range2(const packet_id_type test,
     }
     else
     {
-        if ((test+0x80000000u) < (base+0x80000000u) + extent)
+        if ((test + 0x80000000u) < (base + 0x80000000u) + extent)
         {
             return true;
         }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 5d9bd7ca..33d2812b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -563,11 +563,11 @@ add_block_local_item(struct route_list *rl,
         ALLOC_OBJ_GC(r2, struct route_ipv4, &rl->gc);
 
         /* split a route into two smaller blocking routes, and direct them to target */
-        l2 = ((~gateway->netmask)+1)>>1;
+        l2 = ((~gateway->netmask) + 1)>>1;
         r1->flags = RT_DEFINED;
         r1->gateway = target;
         r1->network = gateway->addr & gateway->netmask;
-        r1->netmask = ~(l2-1);
+        r1->netmask = ~(l2 - 1);
         r1->next = rl->routes;
         rl->routes = r1;
 
@@ -757,7 +757,7 @@ route_ipv6_match_host( const struct route_ipv6 *r6,
         return true;
     }
 
-    mask = 0xff << (8-bits);
+    mask = 0xff << (8 - bits);
 
     if ( (r6->network.s6_addr[i] & mask) == (host->s6_addr[i] & mask ))
     {
@@ -1907,7 +1907,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     if (r6->iface != NULL && gateway_needed
         && IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )        /* fe80::...%intf */
     {
-        int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
+        int len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp = gc_malloc( len, true, &gc );
         snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
         gateway = tmp;
@@ -2378,7 +2378,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     if (r6->iface != NULL && gateway_needed
         && IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )        /* fe80::...%intf */
     {
-        int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
+        int len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp = gc_malloc( len, true, &gc );
         snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
         gateway = tmp;
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 33f2b28e..1afd0dbb 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -380,7 +380,7 @@ netbits_to_netmask(const int netbits)
     in_addr_t mask = 0;
     if (netbits > 0 && netbits <= addrlen)
     {
-        mask = IPV4_NETMASK_HOST << (addrlen-netbits);
+        mask = IPV4_NETMASK_HOST << (addrlen - netbits);
     }
     return mask;
 }
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 0027d198..1deab680 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -496,13 +496,13 @@ schedule_debug_entry(const struct schedule_entry *e,
             *least = e->tv;
         }
 
-        d = schedule_debug_entry(e->lt, depth+1, count, least, min, &e->tv);
+        d = schedule_debug_entry(e->lt, depth + 1, count, least, min, &e->tv);
         if (d > maxdepth)
         {
             maxdepth = d;
         }
 
-        d = schedule_debug_entry(e->gt, depth+1, count, least, &e->tv, max);
+        d = schedule_debug_entry(e->gt, depth + 1, count, least, &e->tv, max);
         if (d > maxdepth)
         {
             maxdepth = d;
@@ -634,8 +634,8 @@ schedule_print_work(struct schedule_entry *e, int indent)
                (ptr_type)e->parent,
                (ptr_type)e->lt,
                (ptr_type)e->gt);
-        schedule_print_work(e->lt, indent+1);
-        schedule_print_work(e->gt, indent+1);
+        schedule_print_work(e->lt, indent + 1);
+        schedule_print_work(e->gt, indent + 1);
     }
     else
     {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b0f84647..c05704f1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2921,7 +2921,7 @@ print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
     if (memcmp(&a6, &in6addr_any, sizeof(a6)) != 0
         || !(flags & IA_EMPTY_IF_UNDEF))
     {
-        inet_ntop(AF_INET6, &a6, tmp_out_buf, sizeof(tmp_out_buf)-1);
+        inet_ntop(AF_INET6, &a6, tmp_out_buf, sizeof(tmp_out_buf) - 1);
         buf_printf(&out, "%s", tmp_out_buf );
     }
     return BSTR(&out);
@@ -2956,7 +2956,7 @@ add_in6_addr( struct in6_addr base, uint32_t add )
         register uint32_t h;
 
         h = (unsigned char) base.s6_addr[i];
-        base.s6_addr[i] = (h+add) & UINT8_MAX;
+        base.s6_addr[i] = (h + add) & UINT8_MAX;
 
         /* using explicit carry for the 8-bit additions will catch
          * 8-bit and(!) 32-bit overruns nicely
@@ -3814,7 +3814,7 @@ sockethandle_finalize(sockethandle_t sh,
                 case sizeof(struct sockaddr_in6):
                 /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INET6
                  * under _WIN32*/
-                case sizeof(struct sockaddr_in6)-4:
+                case sizeof(struct sockaddr_in6) - 4:
                     break;
 
                 default:
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33e145b3..d13556b2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1885,7 +1885,7 @@ read_string(struct buffer *buf, char *str, const unsigned int capacity)
     {
         return false;
     }
-    str[len-1] = '\0';
+    str[len - 1] = '\0';
     return true;
 }
 
@@ -1906,7 +1906,7 @@ read_string_alloc(struct buffer *buf)
         free(str);
         return NULL;
     }
-    str[len-1] = '\0';
+    str[len - 1] = '\0';
     return str;
 }
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b0785bae..87bee0f5 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -307,7 +307,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
     int cipher_count = get_num_elements(ciphers, ':');
 
     /* Allocate an array for them */
-    ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count+1)
+    ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count + 1)
 
     /* Parse allowed ciphers, getting IDs */
     int i = 0;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 710c9c06..0ff39c35 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -429,7 +429,7 @@ convert_tls_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphe
 
     if (openssl_ciphers_len > 0)
     {
-        openssl_ciphers[openssl_ciphers_len-1] = '\0';
+        openssl_ciphers[openssl_ciphers_len - 1] = '\0';
     }
 }
 
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 0083fc47..bbce6259 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -485,7 +485,7 @@ calculate_session_id_hmac(struct session_id client_sid,
     /* Get the valid time quantisation for our hmac,
      * we divide time by handwindow/2 and allow the previous
      * and future session time if specified by offset */
-    uint32_t session_id_time = now/((handwindow+1)/2) + offset;
+    uint32_t session_id_time = now/((handwindow + 1)/2) + offset;
 
     hmac_ctx_reset(hmac);
     /* We do not care about endian here since it does not need to be
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 147ff67b..da55b4e6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -657,7 +657,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     struct buffer buf = alloc_buf_gc(256, &gc);
     for (int i = 0; opt->x509_username_field[i] != NULL; i++)
     {
-        char username[TLS_USERNAME_LEN+1] = {0}; /* null-terminated */
+        char username[TLS_USERNAME_LEN + 1] = {0}; /* null-terminated */
 
         if (SUCCESS != backend_x509_get_username(username, sizeof(username),
                                                  opt->x509_username_field[i], cert))
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index b2af70c2..0ae66e33 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -86,7 +86,7 @@ verify_callback(void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
         char *subject = x509_get_subject(cert, &gc);
         char *serial = backend_x509_get_serial(cert, &gc);
 
-        ret = mbedtls_x509_crt_verify_info(errstr, sizeof(errstr)-1, "", *flags);
+        ret = mbedtls_x509_crt_verify_info(errstr, sizeof(errstr) - 1, "", *flags);
         if (ret <= 0 && !openvpn_snprintf(errstr, sizeof(errstr),
                                           "Could not retrieve error string, flags=%" PRIx32, *flags))
         {
@@ -164,7 +164,7 @@ backend_x509_get_username(char *cn, int cn_len,
     else
     {
         memcpy( cn, name->val.p, cn_len);
-        cn[cn_len-1] = '\0';
+        cn[cn_len - 1] = '\0';
     }
 
     return SUCCESS;
@@ -211,7 +211,7 @@ backend_x509_get_serial_hex(mbedtls_x509_crt *cert, struct gc_arena *gc)
 
     buf = gc_malloc(len, true, gc);
 
-    if (mbedtls_x509_serial_gets(buf, len-1, &cert->serial) < 0)
+    if (mbedtls_x509_serial_gets(buf, len - 1, &cert->serial) < 0)
     {
         buf = NULL;
     }
@@ -252,7 +252,7 @@ x509_get_subject(mbedtls_x509_crt *cert, struct gc_arena *gc)
 
     int ret = 0;
 
-    ret = mbedtls_x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
+    ret = mbedtls_x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH - 1, &cert->subject );
     if (ret > 0)
     {
         /* Allocate the required space for the subject */
@@ -299,7 +299,7 @@ asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
             return string_alloc("ERROR: embedded null value", gc);
         }
     }
-    val = gc_malloc(orig->len+1, false, gc);
+    val = gc_malloc(orig->len + 1, false, gc);
     memcpy(val, orig->p, orig->len);
     val[orig->len] = '\0';
     return val;
@@ -392,7 +392,7 @@ x509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
 
     while (name != NULL)
     {
-        char name_expand[64+8];
+        char name_expand[64 + 8];
         const char *shortname;
 
         if (0 == mbedtls_oid_get_attr_short_name(&name->oid, &shortname) )
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 0a879f2e..501cb621 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -264,7 +264,7 @@ backend_x509_get_username(char *common_name, int cn_len,
 #ifdef ENABLE_X509ALTUSERNAME
     if (strncmp("ext:", x509_username_field, 4) == 0)
     {
-        if (!extract_x509_extension(peer_cert, x509_username_field+4, common_name, cn_len))
+        if (!extract_x509_extension(peer_cert, x509_username_field + 4, common_name, cn_len))
         {
             return FAILURE;
         }
@@ -276,7 +276,7 @@ backend_x509_get_username(char *common_name, int cn_len,
         char *serial = format_hex_ex(asn1_i->data, asn1_i->length,
                                      0, 1 | FHE_CAPS, NULL, &gc);
 
-        if (!serial || cn_len <= strlen(serial)+2)
+        if (!serial || cn_len <= strlen(serial) + 2)
         {
             gc_free(&gc);
             return FAILURE;
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 071eb62b..d1a00b53 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -225,7 +225,7 @@ status_printf(struct status_output *so, const char *format, ...)
 {
     if (so && (so->flags & STATUS_OUTPUT_WRITE))
     {
-        char buf[STATUS_PRINTF_MAXLEN+2]; /* leave extra bytes for CR, LF */
+        char buf[STATUS_PRINTF_MAXLEN + 2]; /* leave extra bytes for CR, LF */
         va_list arglist;
         int stat;
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9d789408..8ad031e6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -991,7 +991,7 @@ create_arbitrary_remote( struct tuntap *tt )
 {
     in_addr_t remote;
 
-    remote = (tt->local & tt->remote_netmask) +1;
+    remote = (tt->local & tt->remote_netmask) + 1;
 
     if (remote == tt->local)
     {
@@ -1867,7 +1867,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                     msg(M_FATAL, "Cannot query NetBSD TAP device name");
                 }
                 CLEAR(dynamic_name);
-                strncpy( dynamic_name, ifr.ifr_name, sizeof(dynamic_name)-1 );
+                strncpy( dynamic_name, ifr.ifr_name, sizeof(dynamic_name) - 1 );
                 dynamic_opened = true;
                 openvpn_snprintf(tunname, sizeof(tunname), "/dev/%s", dynamic_name );
             }
@@ -3193,7 +3193,7 @@ utun_open_helper(struct ctl_info ctlInfo, int utunnum)
     sc.sc_family = AF_SYSTEM;
     sc.ss_sysaddr = AF_SYS_CONTROL;
 
-    sc.sc_unit = utunnum+1;
+    sc.sc_unit = utunnum + 1;
 
 
     /* If the connect is successful, a utun%d device will be created, where "%d"
@@ -4151,7 +4151,7 @@ show_valid_win32_tun_subnets(void)
 
     for (i = 0; i < 256; i += 4)
     {
-        printf("[%3d,%3d] ", i+1, i+2);
+        printf("[%3d,%3d] ", i + 1, i + 2);
         if (++col > 4)
         {
             col = 0;
@@ -5877,7 +5877,7 @@ write_dhcp_search_str(struct buffer *buf, const int type, const char *const *str
         {
             if (*ptr == '.' || *ptr == '\0')
             {
-                tmp_buf[label_length_pos] = (len-label_length_pos)-1;
+                tmp_buf[label_length_pos] = (len - label_length_pos) - 1;
                 label_length_pos = len;
                 if (*ptr == '\0')
                 {
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 82f0c73f..d3fb2686 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -917,7 +917,7 @@ env_block(const struct env_set *es)
             nchars += strlen(e->string) + 1;
         }
 
-        nchars += strlen(force_path)+1;
+        nchars += strlen(force_path) + 1;
 
         ret = (char *) malloc(nchars);
         check_malloc_return(ret);
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 538cdbaa..9235a8ed 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -114,7 +114,7 @@ setup_sequence(
 static void
 _debug_popup(_In_z_ LPCSTR szFunctionName)
 {
-    TCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
+    TCHAR szTitle[0x100], szMessage[0x100 + MAX_PATH], szProcessPath[MAX_PATH];
 
     /* Compose pop-up title. The dialog title will contain function name to ease the process
      * locating. Mind that Visual Studio displays window titles on the process list. */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5b396e01..5f460173 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -416,11 +416,11 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options, WCHAR *
             continue;
         }
 
-        if (!CheckOption(workdir, argc-i, &argv[i], &settings))
+        if (!CheckOption(workdir, argc - i, &argv[i], &settings))
         {
-            if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
+            if (wcscmp(L"--config", argv[i]) == 0 && argc - i > 1)
             {
-                openvpn_swprintf(errmsg, capacity, msg1, argv[i+1], workdir,
+                openvpn_swprintf(errmsg, capacity, msg1, argv[i + 1], workdir,
                                  settings.ovpn_admin_group);
             }
             else
@@ -1198,8 +1198,8 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
     /* use a non-const reference with limited scope to enforce null-termination of strings from client */
     {
         dns_cfg_message_t *msgptr = (dns_cfg_message_t *) msg;
-        msgptr->iface.name[_countof(msg->iface.name)-1] = '\0';
-        msgptr->domains[_countof(msg->domains)-1] = '\0';
+        msgptr->iface.name[_countof(msg->iface.name) - 1] = '\0';
+        msgptr->domains[_countof(msg->domains) - 1] = '\0';
     }
 
     wchar_t *wide_name = utf8to16(msg->iface.name); /* utf8 to wide-char */
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index a71f5c69..6ea6aa95 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -260,7 +260,7 @@ _tmain(int argc, TCHAR *argv[])
             }
             else if (argc > i + 2 && _wcsicmp(TEXT("instance"), argv[i] + 1) == 0)
             {
-                if (_wcsicmp(TEXT("interactive"), argv[i+1]) == 0)
+                if (_wcsicmp(TEXT("interactive"), argv[i + 1]) == 0)
                 {
                     dispatchTable = dispatchTable_interactive;
                     service_instance = argv[i + 2];
@@ -268,7 +268,7 @@ _tmain(int argc, TCHAR *argv[])
                 }
                 else
                 {
-                    MsgToEventLog(M_ERR, L"Invalid argument to -instance <%s>. Service not started.", argv[i+1]);
+                    MsgToEventLog(M_ERR, L"Invalid argument to -instance <%s>. Service not started.", argv[i + 1]);
                     return 1;
                 }
             }
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 70339445..2ba7272d 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -172,7 +172,7 @@ recv_string(int fd, char *buffer, int len)
         ssize_t size;
         memset(buffer, 0, len);
         size = read(fd, buffer, len);
-        buffer[len-1] = 0;
+        buffer[len - 1] = 0;
         if (size >= 1)
         {
             return (int)size;
@@ -322,11 +322,11 @@ split_scrv1_password(struct user_pass *up)
     }
     *resp++ = '\0';
 
-    int n = plugin_base64_decode(pass, up->password, sizeof(up->password)-1);
+    int n = plugin_base64_decode(pass, up->password, sizeof(up->password) - 1);
     if (n >= 0)
     {
         up->password[n] = '\0';
-        n = plugin_base64_decode(resp, up->response, sizeof(up->response)-1);
+        n = plugin_base64_decode(resp, up->response, sizeof(up->response) - 1);
         if (n >= 0)
         {
             up->response[n] = '\0';
@@ -427,7 +427,7 @@ openvpn_plugin_open_v3(const int v3structver,
         {
             const int base = base_parms + i * 2;
             name_value_list.data[i].name = argv[base];
-            name_value_list.data[i].value = argv[base+1];
+            name_value_list.data[i].value = argv[base + 1];
         }
     }
 
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index e65ed21b..ce8698bf 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -68,7 +68,7 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
     const char *searching = tosearch;
     char *scratch;
 
-    char temp[templen+1];
+    char temp[templen + 1];
     temp[0] = 0;
 
     scratch = strstr(searching, searchfor);
@@ -79,10 +79,10 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
 
     while (scratch)
     {
-        strncat(temp, searching, scratch-searching);
+        strncat(temp, searching, scratch - searching);
         strcat(temp, replacewith);
 
-        searching = scratch+strlen(searchfor);
+        searching = scratch + strlen(searchfor);
         scratch = strstr(searching, searchfor);
     }
     return strdup(temp);
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 95a8b52d..d2a3aafa 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -322,7 +322,7 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
     /* Ignore argv[0], as it contains just the plug-in file name */
     for (i = 1; i < string_array_len(argv); i++)
     {
-        context->command[i-1] = (char *) argv[i];
+        context->command[i - 1] = (char *) argv[i];
     }
 
     /*
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 82bb0a26..dff74ef8 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -357,10 +357,10 @@ test_tls_crypt_v2_setup(void **state)
     ctx->gc = gc_new();
 
     /* Slightly longer buffers to be able to test too-long data */
-    ctx->metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN+16, &ctx->gc);
-    ctx->unwrapped_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN+16,
+    ctx->metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN + 16, &ctx->gc);
+    ctx->unwrapped_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN + 16,
                                            &ctx->gc);
-    ctx->wkc = alloc_buf_gc(TLS_CRYPT_V2_MAX_WKC_LEN+16, &ctx->gc);
+    ctx->wkc = alloc_buf_gc(TLS_CRYPT_V2_MAX_WKC_LEN + 16, &ctx->gc);
 
     /* Generate server key */
     rand_bytes((void *)ctx->server_key2.keys, sizeof(ctx->server_key2.keys));
@@ -469,7 +469,7 @@ tls_crypt_v2_wrap_too_long_metadata(void **state)
     struct test_tls_crypt_v2_context *ctx =
         (struct test_tls_crypt_v2_context *) *state;
 
-    assert_true(buf_inc_len(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN+1));
+    assert_true(buf_inc_len(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN + 1));
     assert_false(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
                                               &ctx->metadata,
                                               &ctx->server_keys.encrypt,
@@ -531,7 +531,7 @@ tls_crypt_v2_wrap_unwrap_dst_too_small(void **state)
 
     struct key2 unwrapped_client_key2 = { 0 };
     struct buffer unwrapped_metadata =
-        alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN-1, &ctx->gc);
+        alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN - 1, &ctx->gc);
     assert_false(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2,
                                                 &unwrapped_metadata, ctx->wkc,
                                                 &ctx->server_keys.decrypt));
-- 
2.34.1


