From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:53 +0200
Message-Id: <20200810143707.5834-4-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 03/17] Clean up a number of leftover C89
 initialisations in ssl.c
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 56 +++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2354a017..3bf0dcf8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -831,10 +831,9 @@ session_index_name(int index)
 static const char *
 print_key_id(struct tls_multi *multi, struct gc_arena *gc)
 {
-    int i;
     struct buffer out = alloc_buf_gc(256, gc);
 
-    for (i = 0; i < KEY_SCAN_SIZE; ++i)
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = multi->key_scan[i];
         buf_printf(&out, " [key#%d state=%s id=%d sid=%s]", i,
@@ -1315,8 +1314,6 @@ tls_multi_init_set_options(struct tls_multi *multi,
 void
 tls_multi_free(struct tls_multi *multi, bool clear)
 {
-    int i;
-
     ASSERT(multi);
 
     auth_set_client_reason(multi, NULL);
@@ -1339,7 +1336,7 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 
     free(multi->remote_ciphername);
 
-    for (i = 0; i < TM_SIZE; ++i)
+    for (int i = 0; i < TM_SIZE; ++i)
     {
         tls_session_free(&multi->session[i], false);
     }
@@ -1367,11 +1364,10 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 static bool
 swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
 {
-    const struct key_ctx *ctx;
-
     ASSERT(co);
 
-    ctx = (incoming ? &co->key_ctx_bi.decrypt : &co->key_ctx_bi.encrypt);
+    const struct key_ctx *ctx = (incoming ? &co->key_ctx_bi.decrypt :
+                                 &co->key_ctx_bi.encrypt);
     ASSERT(ctx->hmac);
 
     {
@@ -1623,25 +1619,21 @@ tls1_P_hash(const md_kt_t *md_kt,
             int olen)
 {
     struct gc_arena gc = gc_new();
-    int chunk;
-    hmac_ctx_t *ctx;
-    hmac_ctx_t *ctx_tmp;
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
-    unsigned int A1_len;
 
 #ifdef ENABLE_DEBUG
     const int olen_orig = olen;
     const uint8_t *out_orig = out;
 #endif
 
-    ctx = hmac_ctx_new();
-    ctx_tmp = hmac_ctx_new();
+    hmac_ctx_t *ctx = hmac_ctx_new();
+    hmac_ctx_t *ctx_tmp = hmac_ctx_new();
 
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
 
-    chunk = md_kt_size(md_kt);
-    A1_len = md_kt_size(md_kt);
+    int chunk = md_kt_size(md_kt);
+    unsigned int A1_len = md_kt_size(md_kt);
 
     hmac_ctx_init(ctx, sec, sec_len, md_kt);
     hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
@@ -1711,21 +1703,18 @@ tls1_PRF(const uint8_t *label,
     struct gc_arena gc = gc_new();
     const md_kt_t *md5 = md_kt_get("MD5");
     const md_kt_t *sha1 = md_kt_get("SHA1");
-    int len,i;
-    const uint8_t *S1,*S2;
-    uint8_t *out2;
 
-    out2 = (uint8_t *) gc_malloc(olen, false, &gc);
+    uint8_t *out2 = (uint8_t *) gc_malloc(olen, false, &gc);
 
-    len = slen/2;
-    S1 = sec;
-    S2 = &(sec[len]);
+    int len = slen/2;
+    const uint8_t *S1 = sec;
+    const uint8_t *S2 = &(sec[len]);
     len += (slen&1); /* add for odd, make longer */
 
     tls1_P_hash(md5,S1,len,label,label_len,out1,olen);
     tls1_P_hash(sha1,S2,len,label,label_len,out2,olen);
 
-    for (i = 0; i<olen; i++)
+    for (int i = 0; i<olen; i++)
     {
         out1[i] ^= out2[i];
     }
@@ -2198,7 +2187,6 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
     if (session->opt->push_peer_info_detail > 0)
     {
         struct env_set *es = session->opt->es;
-        struct env_item *e;
         struct buffer out = alloc_buf_gc(512*3, &gc);
 
         /* push version */
@@ -2271,7 +2259,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         }
 
         /* push env vars that begin with UV_, IV_PLAT_VER and IV_GUI_VER */
-        for (e = es->list; e != NULL; e = e->next)
+        for (struct env_item *e = es->list; e != NULL; e = e->next)
         {
             if (e->string)
             {
@@ -3004,10 +2992,8 @@ tls_multi_process(struct tls_multi *multi,
                   interval_t *wakeup)
 {
     struct gc_arena gc = gc_new();
-    int i;
     int active = TLSMP_INACTIVE;
     bool error = false;
-    int tas;
 
     perf_push(PERF_TLS_MULTI_PROCESS);
 
@@ -3018,7 +3004,7 @@ tls_multi_process(struct tls_multi *multi,
      * and which has a defined remote IP addr.
      */
 
-    for (i = 0; i < TM_SIZE; ++i)
+    for (int i = 0; i < TM_SIZE; ++i)
     {
         struct tls_session *session = &multi->session[i];
         struct key_state *ks = &session->key[KS_PRIMARY];
@@ -3093,7 +3079,7 @@ tls_multi_process(struct tls_multi *multi,
 
     update_time();
 
-    tas = tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
+    int tas = tls_authentication_status(multi, TLS_MULTI_AUTH_STATUS_INTERVAL);
 
     /*
      * If lame duck session expires, kill it.
@@ -3126,7 +3112,7 @@ tls_multi_process(struct tls_multi *multi,
      */
     if (error)
     {
-        for (i = 0; i < (int) SIZE(multi->key_scan); ++i)
+        for (int i = 0; i < (int) SIZE(multi->key_scan); ++i)
         {
             if (multi->key_scan[i]->state >= S_ACTIVE)
             {
@@ -3143,7 +3129,7 @@ nohard:
         const int throw_level = GREMLIN_CONNECTION_FLOOD_LEVEL(multi->opt.gremlin);
         if (throw_level)
         {
-            for (i = 0; i < (int) SIZE(multi->key_scan); ++i)
+            for (int i = 0; i < (int) SIZE(multi->key_scan); ++i)
             {
                 if (multi->key_scan[i]->state >= throw_level)
                 {
@@ -3957,13 +3943,11 @@ void
 tls_update_remote_addr(struct tls_multi *multi, const struct link_socket_actual *addr)
 {
     struct gc_arena gc = gc_new();
-    int i, j;
-
-    for (i = 0; i < TM_SIZE; ++i)
+    for (int i = 0; i < TM_SIZE; ++i)
     {
         struct tls_session *session = &multi->session[i];
 
-        for (j = 0; j < KS_SIZE; ++j)
+        for (int j = 0; j < KS_SIZE; ++j)
         {
             struct key_state *ks = &session->key[j];
 
-- 
2.26.2


