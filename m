From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Mar 2021 14:03:11 +0100
Message-Id: <20210317130312.8585-1-arne@...1227...>
In-Reply-To: <20210310154754.GH976@...1296...>
References: <20210310154754.GH976@...1296...>
Subject: [Openvpn-devel] [PATCH v5 1/2] Move auth deferred related members
 into its own struct
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

This structures the code a bit nicer and also prepares for deferred
scripts that needs their own set of files.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c        |  4 +--
 src/openvpn/ssl_common.h | 12 ++++++--
 src/openvpn/ssl_verify.c | 63 ++++++++++++++++++++--------------------
 src/openvpn/ssl_verify.h |  7 +++--
 4 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 893e5753..b6c553be 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -992,9 +992,7 @@ key_state_free(struct key_state *ks, bool clear)
 
     packet_id_free(&ks->crypto_options.packet_id);
 
-#ifdef PLUGIN_DEF_AUTH
-    key_state_rm_auth_control_files(ks);
-#endif
+    key_state_rm_auth_control_files(&ks->plugin_auth);
 
     if (clear)
     {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 2e3c98db..0773376e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -145,6 +145,13 @@ enum ks_auth_state {
                                 */
 };
 
+struct auth_deferred_status
+{
+    char *auth_control_file;
+    char *auth_pending_file;
+    unsigned int auth_control_status;
+};
+
 /**
  * Security parameter state of one TLS and data channel %key session.
  * @ingroup control_processor
@@ -212,10 +219,9 @@ struct key_state
     unsigned int mda_key_id;
     unsigned int mda_status;
 #endif
-    unsigned int auth_control_status;
     time_t acf_last_mod;
-    char *auth_control_file;
-    char *auth_pending_file;
+
+    struct auth_deferred_status plugin_auth;
 };
 
 /** Control channel wrapping (--tls-auth/--tls-crypt) context */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4b120f7b..c9983d66 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -870,13 +870,13 @@ man_def_auth_test(const struct key_state *ks)
  *  and key_state structure
  */
 static void
-key_state_rm_auth_pending_file(struct key_state *ks)
+key_state_rm_auth_pending_file(struct auth_deferred_status *ads)
 {
-    if (ks && ks->auth_pending_file)
+    if (ads && ads->auth_pending_file)
     {
-        platform_unlink(ks->auth_pending_file);
-        free(ks->auth_pending_file);
-        ks->auth_pending_file = NULL;
+        platform_unlink(ads->auth_pending_file);
+        free(ads->auth_pending_file);
+        ads->auth_pending_file = NULL;
     }
 }
 
@@ -921,13 +921,13 @@ check_auth_pending_method(const char *peer_info, const char *method)
  *  @returns false  The file had an invlaid format or another error occured
  */
 static bool
-key_state_check_auth_pending_file(struct key_state *ks,
+key_state_check_auth_pending_file(struct auth_deferred_status *ads,
                                   struct tls_multi *multi)
 {
     bool ret = true;
-    if (ks && ks->auth_pending_file)
+    if (ads->auth_pending_file)
     {
-        struct buffer_list *lines = buffer_list_file(ks->auth_pending_file,
+        struct buffer_list *lines = buffer_list_file(ads->auth_pending_file,
                                                      1024);
         if (lines && lines->head)
         {
@@ -977,7 +977,7 @@ key_state_check_auth_pending_file(struct key_state *ks,
 
         buffer_list_free(lines);
     }
-    key_state_rm_auth_pending_file(ks);
+    key_state_rm_auth_pending_file(ads);
     return ret;
 }
 
@@ -987,15 +987,15 @@ key_state_check_auth_pending_file(struct key_state *ks,
  *  and key_state structure
  */
 void
-key_state_rm_auth_control_files(struct key_state *ks)
+key_state_rm_auth_control_files(struct auth_deferred_status *ads)
 {
-    if (ks && ks->auth_control_file)
+    if (ads->auth_control_file)
     {
-        platform_unlink(ks->auth_control_file);
-        free(ks->auth_control_file);
-        ks->auth_control_file = NULL;
+        platform_unlink(ads->auth_control_file);
+        free(ads->auth_control_file);
+        ads->auth_control_file = NULL;
     }
-    key_state_rm_auth_pending_file(ks);
+    key_state_rm_auth_pending_file(ads);
 }
 
 /**
@@ -1005,20 +1005,21 @@ key_state_rm_auth_control_files(struct key_state *ks)
  * @return  true if file creation was successful
  */
 static bool
-key_state_gen_auth_control_files(struct key_state *ks, const struct tls_options *opt)
+key_state_gen_auth_control_files(struct auth_deferred_status *ads,
+                                 const struct tls_options *opt)
 {
     struct gc_arena gc = gc_new();
 
-    key_state_rm_auth_control_files(ks);
+    key_state_rm_auth_control_files(ads);
     const char *acf = platform_create_temp_file(opt->tmp_dir, "acf", &gc);
     const char *apf = platform_create_temp_file(opt->tmp_dir, "apf", &gc);
 
     if (acf && apf)
     {
-        ks->auth_control_file = string_alloc(acf, NULL);
-        ks->auth_pending_file = string_alloc(apf, NULL);
-        setenv_str(opt->es, "auth_control_file", ks->auth_control_file);
-        setenv_str(opt->es, "auth_pending_file", ks->auth_pending_file);
+        ads->auth_control_file = string_alloc(acf, NULL);
+        ads->auth_pending_file = string_alloc(apf, NULL);
+        setenv_str(opt->es, "auth_control_file", ads->auth_control_file);
+        setenv_str(opt->es, "auth_pending_file", ads->auth_pending_file);
     }
 
     gc_free(&gc);
@@ -1026,14 +1027,14 @@ key_state_gen_auth_control_files(struct key_state *ks, const struct tls_options
 }
 
 static unsigned int
-key_state_test_auth_control_file(struct key_state *ks)
+key_state_test_auth_control_file(struct auth_deferred_status *ads)
 {
-    if (ks && ks->auth_control_file)
+    if (ads->auth_control_file)
     {
-        unsigned int ret = ks->auth_control_status;
+        unsigned int ret = ads->auth_control_status;
         if (ret == ACF_UNDEFINED)
         {
-            FILE *fp = fopen(ks->auth_control_file, "r");
+            FILE *fp = fopen(ads->auth_control_file, "r");
             if (fp)
             {
                 const int c = fgetc(fp);
@@ -1046,7 +1047,7 @@ key_state_test_auth_control_file(struct key_state *ks)
                     ret = ACF_FAILED;
                 }
                 fclose(fp);
-                ks->auth_control_status = ret;
+                ads->auth_control_status = ret;
             }
         }
         return ret;
@@ -1088,7 +1089,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
             {
                 unsigned int s1 = ACF_DISABLED;
                 unsigned int s2 = ACF_DISABLED;
-                s1 = key_state_test_auth_control_file(ks);
+                s1 = key_state_test_auth_control_file(&ks->plugin_auth);
 #ifdef ENABLE_MANAGEMENT
                 s2 = man_def_auth_test(ks);
 #endif
@@ -1267,7 +1268,7 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
     setenv_str(session->opt->es, "password", up->password);
 
     /* generate filename for deferred auth control file */
-    if (!key_state_gen_auth_control_files(ks, session->opt))
+    if (!key_state_gen_auth_control_files(&ks->plugin_auth, session->opt))
     {
         msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
             "could not create deferred auth control file", __func__);
@@ -1281,16 +1282,16 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
     {
         /* Check if the plugin has written the pending auth control
          * file and send the pending auth to the client */
-        if(!key_state_check_auth_pending_file(ks, multi))
+        if(!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
-            key_state_rm_auth_control_files(ks);
+            key_state_rm_auth_control_files(&ks->plugin_auth);
         }
     }
     else
     {
         /* purge auth control filename (and file itself) for non-deferred returns */
-        key_state_rm_auth_control_files(ks);
+        key_state_rm_auth_control_files(&ks->plugin_auth);
     }
 
     setenv_del(session->opt->es, "password");
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 0221e81f..874d2dcb 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -113,11 +113,12 @@ tls_authentication_status(struct tls_multi *multi, const int latency);
 #define TLS_AUTHENTICATED(multi, ks) ((ks)->state >= (S_GOT_KEY - (multi)->opt.server))
 
 /**
- * Remove the given key state's auth control file, if it exists.
+ * Remove the given key state's auth deferred status auth control file,
+ * if it exists.
  *
- * @param ks    The key state the remove the file for
+ * @param ads    The key state the remove the file for
  */
-void key_state_rm_auth_control_files(struct key_state *ks);
+void key_state_rm_auth_control_files(struct auth_deferred_status *ads);
 
 /**
  * Frees the given set of certificate hashes.
-- 
2.30.1


