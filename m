From: Arne Schwabe <arne@...1227...>
Date: Wed, 18 May 2022 11:32:12 +0200
Message-Id: <20220518093212.2802495-5-arne@...1227...>
In-Reply-To: <20220518093212.2802495-1-arne@...1227...>
References: <20220518093212.2802495-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Allow scripts and plugins to set a
 custom AUTH_FAILED message
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

This is currently only possible when using the management interface
and the client-deny functionality.
---
 src/openvpn/ssl_common.h |  1 +
 src/openvpn/ssl_verify.c | 74 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index cef2611b9..433563068 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -155,6 +155,7 @@ struct auth_deferred_status
 {
     char *auth_control_file;
     char *auth_pending_file;
+    char *auth_failed_reason_file;
     unsigned int auth_control_status;
 };
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index c01841fa9..4cf772fef 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -989,6 +989,12 @@ key_state_rm_auth_control_files(struct auth_deferred_status *ads)
         free(ads->auth_control_file);
         ads->auth_control_file = NULL;
     }
+    if (ads->auth_failed_reason_file)
+    {
+        platform_unlink(ads->auth_failed_reason_file);
+        free(ads->auth_failed_reason_file);
+        ads->auth_failed_reason_file = NULL;
+    }
     key_state_rm_auth_pending_file(ads);
 }
 
@@ -1007,19 +1013,47 @@ key_state_gen_auth_control_files(struct auth_deferred_status *ads,
     key_state_rm_auth_control_files(ads);
     const char *acf = platform_create_temp_file(opt->tmp_dir, "acf", &gc);
     const char *apf = platform_create_temp_file(opt->tmp_dir, "apf", &gc);
+    const char *afr = platform_create_temp_file(opt->tmp_dir, "afr", &gc);
 
     if (acf && apf)
     {
         ads->auth_control_file = string_alloc(acf, NULL);
         ads->auth_pending_file = string_alloc(apf, NULL);
+        ads->auth_failed_reason_file = string_alloc(afr, NULL);
+
         setenv_str(opt->es, "auth_control_file", ads->auth_control_file);
         setenv_str(opt->es, "auth_pending_file", ads->auth_pending_file);
+        setenv_str(opt->es, "auth_failed_reason_file", ads->auth_failed_reason_file);
     }
 
     gc_free(&gc);
     return (acf && apf);
 }
 
+/**
+ * Checks if the auth failed reason file has any content and if yes it will
+ * be returned as string allocated in gc to the caller.
+ */
+static char *
+key_state_check_auth_failed_message_file(const struct auth_deferred_status *ads,
+                                         struct tls_multi *multi,
+                                         struct gc_arena *gc)
+{
+    char *ret = NULL;
+    if (ads->auth_failed_reason_file)
+    {
+        struct buffer reason = buffer_read_from_file(ads->auth_failed_reason_file, gc);
+
+        if (BLEN(&reason))
+        {
+            ret = BSTR(&reason);
+        }
+
+    }
+    return ret;
+}
+
+
 /**
  * Checks the auth control status from a file. The function will try
  * to read and update the cached status if the status is still pending
@@ -1184,6 +1218,20 @@ tls_authentication_status(struct tls_multi *multi)
 #endif
     if (failed_auth)
     {
+        struct gc_arena gc = gc_new();
+        const struct key_state *ks = get_primary_key(multi);
+        const char *plugin_message = key_state_check_auth_failed_message_file(&ks->plugin_auth, multi, &gc);
+        const char *script_message = key_state_check_auth_failed_message_file(&ks->script_auth, multi, &gc);
+
+        if (plugin_message)
+        {
+            auth_set_client_reason(multi, plugin_message);
+        }
+        if (script_message)
+        {
+            auth_set_client_reason(multi, script_message);
+        }
+
         /* We have at least one session that failed authentication. There
          * might be still another session with valid keys.
          * Although our protocol allows keeping the VPN session alive
@@ -1248,6 +1296,21 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
  * this is the place to start.
  *************************************************************************** */
 
+/**
+ * Check if the script/plugin left a message in the auth failed message
+ * file and rely it to the user */
+static void
+check_for_client_reason(struct tls_multi *multi,
+                        struct auth_deferred_status *status)
+{
+    struct gc_arena gc = gc_new();
+    const char *msg = key_state_check_auth_failed_message_file(status, multi, &gc);
+    if (msg)
+    {
+        auth_set_client_reason(multi, msg);
+    }
+    gc_free(&gc);
+}
 /*
  * Verify the user name and password using a script
  */
@@ -1316,6 +1379,7 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
             break;
 
         default:
+            check_for_client_reason(multi, &ks->script_auth);
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
             break;
     }
@@ -1376,6 +1440,7 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
     /* call command */
     retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
 
+
     if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
     {
         /* Check if the plugin has written the pending auth control
@@ -1383,10 +1448,15 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
         if (!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
-            key_state_rm_auth_control_files(&ks->plugin_auth);
         }
     }
-    else
+
+    if (retval == OPENVPN_PLUGIN_FUNC_ERROR)
+    {
+        check_for_client_reason(multi, &ks->plugin_auth);
+    }
+
+    if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
     {
         /* purge auth control filename (and file itself) for non-deferred returns */
         key_state_rm_auth_control_files(&ks->plugin_auth);
-- 
2.32.0 (Apple Git-132)


