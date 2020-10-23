From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:53 +0200
Message-Id: <20201023120259.29783-1-arne@...1227...>
In-Reply-To: <20201023113244.26295-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/8] Replace key_scan array of static points
 with inline function
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

The key_scan array is an array that is setup as a reference to members
of itself that have static offsets. Replace this pointer indirection
with an inline function. This has also the advantage that the compiler
can inline the function and just just a direct offset into the struct.

Replacing the implicit indirection with the pointer array with an
explicit indirection with the inline function also makes the code a
bit easier to follow.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c        | 20 +++++++-------------
 src/openvpn/ssl_common.h | 26 +++++++++++++++++++++-----
 src/openvpn/ssl_verify.c |  4 ++--
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fb1edd6e..618cc9cc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -832,7 +832,7 @@ print_key_id(struct tls_multi *multi, struct gc_arena *gc)
 
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
-        struct key_state *ks = multi->key_scan[i];
+        struct key_state *ks = get_key_scan(multi, i);
         buf_printf(&out, " [key#%d state=%s id=%d sid=%s]", i,
                    state_name(ks->state), ks->key_id,
                    session_id_print(&ks->session_id_remote, gc));
@@ -1229,12 +1229,6 @@ tls_multi_init(struct tls_options *tls_options)
     /* get command line derived options */
     ret->opt = *tls_options;
 
-    /* set up list of keys to be scanned by data channel encrypt and decrypt routines */
-    ASSERT(SIZE(ret->key_scan) == 3);
-    ret->key_scan[0] = &ret->session[TM_ACTIVE].key[KS_PRIMARY];
-    ret->key_scan[1] = &ret->session[TM_ACTIVE].key[KS_LAME_DUCK];
-    ret->key_scan[2] = &ret->session[TM_LAME_DUCK].key[KS_LAME_DUCK];
-
     /* By default not use P_DATA_V2 */
     ret->use_peer_id = false;
 
@@ -3212,9 +3206,9 @@ tls_multi_process(struct tls_multi *multi,
      */
     if (error)
     {
-        for (int i = 0; i < (int) SIZE(multi->key_scan); ++i)
+        for (int i = 0; i < KEY_SCAN_SIZE; ++i)
         {
-            if (multi->key_scan[i]->state >= S_ACTIVE)
+            if (get_key_scan(multi, i)->state >= S_ACTIVE)
             {
                 goto nohard;
             }
@@ -3229,9 +3223,9 @@ nohard:
         const int throw_level = GREMLIN_CONNECTION_FLOOD_LEVEL(multi->opt.gremlin);
         if (throw_level)
         {
-            for (int i = 0; i < (int) SIZE(multi->key_scan); ++i)
+            for (int i = 0; i < KEY_SCAN_SIZE; ++i)
             {
-                if (multi->key_scan[i]->state >= throw_level)
+                if (get_key_scan(multi, i)->state >= throw_level)
                 {
                     ++multi->n_hard_errors;
                     ++multi->n_soft_errors;
@@ -3269,7 +3263,7 @@ handle_data_channel_packet(struct tls_multi *multi,
     /* data channel packet */
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
-        struct key_state *ks = multi->key_scan[i];
+        struct key_state *ks = get_key_scan(multi, i);
 
         /*
          * This is the basic test of TLS state compatibility between a local OpenVPN
@@ -3878,7 +3872,7 @@ tls_pre_encrypt(struct tls_multi *multi,
     struct key_state *ks_select = NULL;
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
-        struct key_state *ks = multi->key_scan[i];
+        struct key_state *ks = get_key_scan(multi, i);
         if (ks->state >= S_ACTIVE
             && (ks->authenticated == KS_AUTH_TRUE)
             && ks->crypto_options.key_ctx_bi.initialized
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 810aba95..c07c58ac 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -501,11 +501,6 @@ struct tls_multi
     /* const options and config info */
     struct tls_options opt;
 
-    struct key_state *key_scan[KEY_SCAN_SIZE];
-    /**< List of \c key_state objects in the
-     *   order they should be scanned by data
-     *   channel modules. */
-
     /*
      * used by tls_pre_encrypt to communicate the encrypt key
      * to tls_post_encrypt()
@@ -585,4 +580,25 @@ struct tls_multi
      *   sessions with the remote peer. */
 };
 
+/**  gets an item  of \c key_state objects in the
+ *   order they should be scanned by data
+ *   channel modules. */
+static inline struct key_state *
+get_key_scan(struct tls_multi *multi, int index)
+{
+    switch (index)
+    {
+    case 0:
+        return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
+    case 1:
+        return &multi->session[TM_ACTIVE].key[KS_LAME_DUCK];
+    case 2:
+        return &multi->session[TM_LAME_DUCK].key[KS_LAME_DUCK];
+    default:
+        ASSERT(false);
+    }
+
+};
+
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index acc788fc..862a6f56 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -972,7 +972,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
 
         for (i = 0; i < KEY_SCAN_SIZE; ++i)
         {
-            struct key_state *ks = multi->key_scan[i];
+            struct key_state *ks = get_key_scan(multi, i);
             if (DECRYPT_KEY_ENABLED(multi, ks))
             {
                 active = true;
@@ -1045,7 +1045,7 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
         auth_set_client_reason(multi, client_reason);
         for (i = 0; i < KEY_SCAN_SIZE; ++i)
         {
-            struct key_state *ks = multi->key_scan[i];
+            struct key_state *ks = get_key_scan(multi, i);
             if (ks->mda_key_id == mda_key_id)
             {
                 ks->mda_status = auth ? ACF_SUCCEEDED : ACF_FAILED;
-- 
2.26.2


