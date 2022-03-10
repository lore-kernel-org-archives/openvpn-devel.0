From: Gert Doering <gert@...1296...>
Date: Thu, 10 Mar 2022 12:57:18 +0100
Message-Id: <20220310115718.11188-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Enable deferred auth for multiple plugins
 (RFC).
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
Cc: Gert Doering <gert@...1296...>

Without this patch, OpenVPN behaviour if more than one plugin wants
to do deferred user/password authentication not well-defined, as
there is just one set of auth control files and a single plugin state.

This patch changes "key state -> plugin_auth" from a single struct
to an array of MAX_PLUGINS elements that have per-plugin auth-control
files and auth status.

All direct access is changed to iterating over this array.

The actual plugin calls are no longer done with the "do them all"
function plugin_call() (or plugin_call_ssl()) but plugin.c/plugin.h
is changed to expose the "call one" function plugin_call_item(), and
verify_user_pass_plugin() calls this for each loaded plugin,
keeping track of "overall" state.

key_state_test_plugin_auth() is introduced to do the
"key_state_test_auth_control_file()" test for all plugins, and
return "FAIL if one fails, PENDING if one is pending, SUCCESS
if one was pending and succeeded now".

This was tested with the "auth-multi" test plugin, with 5-7 plugins
loaded (some deferred, some direct) and "some of them failing" or
"all succeeding".  Testing included "will it leak files if multiple
deferred plugins are ongoing, and one of the earlier ones rejects
authentication".

This patch is not suitable for production use:
 - it's full of debug output
 - it will break compilation without ENABLE_PLUGINS
 - it stands to argue whether plugin_call_item() should be exposed,
   or key_state_test_plugin_auth() might be moved to plugin.c instead
   (with a null function if ENABLE_PLUGINS is not defined)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/plugin.c     |   2 +-
 src/openvpn/plugin.h     |   9 +++
 src/openvpn/ssl.c        |   5 +-
 src/openvpn/ssl_common.h |   4 +-
 src/openvpn/ssl_verify.c | 127 ++++++++++++++++++++++++++++++++-------
 5 files changed, 123 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index e3a89293..74b57033 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -518,7 +518,7 @@ plugin_open_item(struct plugin *p,
     }
 }
 
-static int
+int
 plugin_call_item(const struct plugin *p,
                  void *per_client_context,
                  const int type,
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index c6fa206a..799a646e 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -132,6 +132,15 @@ int plugin_call_ssl(const struct plugin_list *pl,
                     int current_cert_depth,
                     openvpn_x509_cert_t *current_cert
                     );
+int plugin_call_item(const struct plugin *p,
+                     void *per_client_context,
+                     const int type,
+                     const struct argv *av,
+                     struct openvpn_plugin_string_list **retlist,
+                     const char **envp,
+                     int certdepth,
+                     openvpn_x509_cert_t *current_cert
+                     );
 
 void plugin_list_close(struct plugin_list *pl);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 14a943a7..ce6de9a0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1036,7 +1036,10 @@ key_state_free(struct key_state *ks, bool clear)
 
     packet_id_free(&ks->crypto_options.packet_id);
 
-    key_state_rm_auth_control_files(&ks->plugin_auth);
+    for (int i=0; i<MAX_PLUGINS; i++)
+    {
+        key_state_rm_auth_control_files(&ks->plugin_auth[i]);
+    }
     key_state_rm_auth_control_files(&ks->script_auth);
 
     if (clear)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 8a077c74..0de3290a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -37,6 +37,8 @@
 
 #include "ssl_backend.h"
 
+#include "plugin.h"
+
 /* passwords */
 #define UP_TYPE_AUTH        "Auth"
 #define UP_TYPE_PRIVATE_KEY "Private Key"
@@ -239,7 +241,7 @@ struct key_state
 #endif
     time_t acf_last_mod;
 
-    struct auth_deferred_status plugin_auth;
+    struct auth_deferred_status plugin_auth[MAX_PLUGINS];
     struct auth_deferred_status script_auth;
 };
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 3b6b58fa..38c8a830 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1059,6 +1059,50 @@ key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
     return ACF_DISABLED;
 }
 
+/**
+ * Checks the auth control status for all plugins.
+ *
+ * returns:
+ * - ACF_PENDING  if any plugin is still waiting for results.
+ * - ACF_SUCCEEDED if there were pending plugins AND all succeeded
+ * - ACF_FAILED   if any plugin fails
+ * - ACF_DISABLED if no plugin is waiting
+ *
+ * @param ads       array of deferred status control structures
+ * @param cached    Return only cached status
+ * @return          ACF_* as per enum
+ */
+static enum auth_deferred_result
+key_state_test_plugin_auth(struct auth_deferred_status *ads, bool cached)
+{
+    unsigned int ret = ACF_DISABLED;
+
+    for (int i=0;i<MAX_PLUGINS;i++)
+    {
+        unsigned int ret_one = key_state_test_auth_control_file(&(ads[i]), cached);
+msg(M_INFO, "GERT(9a): kstpa: i=%d, ret_one=%d", i, ret_one);
+
+        /* if at least one plugin fails, we fail all */
+        if ( ret_one == ACF_FAILED )
+        {
+            ret = ret_one;
+            break;
+        }
+        /* if at least one plugin is still pending, we're still pending */
+        if ( ret_one == ACF_PENDING )
+        {
+            ret = ret_one;
+        }
+        /* if no plugins are pending AND we have success, we succeed */
+        if ( ret_one == ACF_SUCCEEDED && ret != ACF_PENDING )
+        {
+            ret = ret_one;
+        }
+    }
+msg(M_INFO, "GERT(9b): kstpa: ret=%d", ret);
+    return ret;
+}
+
 /**
  * This method takes a key_state and if updates the state
  * of the key if it is deferred.
@@ -1069,6 +1113,7 @@ key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
 static void
 update_key_auth_status(bool cached, struct key_state *ks)
 {
+msg(M_INFO, "GERT(10) update_key_auth_status authenticated=%d", ks->authenticated);
     if (ks->authenticated == KS_AUTH_FALSE)
     {
         return;
@@ -1078,7 +1123,7 @@ update_key_auth_status(bool cached, struct key_state *ks)
         enum auth_deferred_result auth_plugin = ACF_DISABLED;
         enum auth_deferred_result auth_script = ACF_DISABLED;
         enum auth_deferred_result auth_man = ACF_DISABLED;
-        auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth, cached);
+        auth_plugin = key_state_test_plugin_auth(ks->plugin_auth, cached);
         auth_script = key_state_test_auth_control_file(&ks->script_auth, cached);
 #ifdef ENABLE_MANAGEMENT
         auth_man = man_def_auth_test(ks);
@@ -1357,40 +1402,80 @@ static int
 verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
                         const struct user_pass *up)
 {
-    int retval = OPENVPN_PLUGIN_FUNC_ERROR;
+    int retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
+    struct gc_arena gc = gc_new();
+
     /* set password in private env space */
     setenv_str(session->opt->es, "password", up->password);
 
-    /* generate filename for deferred auth control file */
-    if (!key_state_gen_auth_control_files(&ks->plugin_auth, session->opt))
+    /* iterate over list of plugins here, because deferred auth needs
+     * per-plugin auth control files
+     */
+    const struct plugin_list *pl = session->opt->plugins;
+    int plugins_active = plugin_n(pl);
+    ASSERT( plugins_active < SIZE(ks->plugin_auth) );
+    msg(M_INFO, "GERT(1): plugins_active=%d, SIZE=%d", plugins_active, (int)SIZE(ks->plugin_auth) );
+
+    for (int i=0; i<plugins_active; i++)
     {
-        msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
-            "could not create deferred auth control file", __func__);
-        return retval;
-    }
+        /* generate filename for deferred auth control file */
+        if (!key_state_gen_auth_control_files(&ks->plugin_auth[i], session->opt))
+        {
+            msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
+                "could not create deferred auth control file", __func__);
+            retval = OPENVPN_PLUGIN_FUNC_ERROR;
+            break;
+        }
 
-    /* call command */
-    retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
+        msg(M_INFO, "GERT(4): plugin #%d, acf=%s acp=%s", i, 
+                ks->plugin_auth[i].auth_control_file, ks->plugin_auth[i].auth_pending_file);
 
-    if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
-    {
-        /* Check if the plugin has written the pending auth control
-         * file and send the pending auth to the client */
-        if(!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
+        /* call command */
+        // retval = plugin_call_item(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
+        //                                pl                    type                             av    pr    es   [crt -1, NULL]
+
+        const char **envp = make_env_array(session->opt->es, false, &gc);
+        const int status = plugin_call_item(&pl->common->plugins[i],
+                                            pl->per_client.per_client_context[i],
+                                            OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY,
+                                            NULL, NULL, envp, -1, NULL );
+
+        if (status == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        {
+            /* Check if the plugin has written the pending auth control
+             * file and send the pending auth to the client */
+            if(!key_state_check_auth_pending_file(&(ks->plugin_auth[i]), multi))
+            {
+                retval = OPENVPN_PLUGIN_FUNC_ERROR;
+                key_state_rm_auth_control_files(&(ks->plugin_auth[i]));
+                break;
+            }
+            else
+            {
+                retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
+            }
+        }
+        else
+        {
+            /* purge auth control filename (and file itself) for non-deferred returns */
+            key_state_rm_auth_control_files(&(ks->plugin_auth[i]));
+            ks->plugin_auth[i].auth_control_status = ACF_DISABLED;
+        }
+
+        /* if a single plugin fails, we fail all */
+        if (status == OPENVPN_PLUGIN_FUNC_ERROR)
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
-            key_state_rm_auth_control_files(&ks->plugin_auth);
+            break;
         }
-    }
-    else
-    {
-        /* purge auth control filename (and file itself) for non-deferred returns */
-        key_state_rm_auth_control_files(&ks->plugin_auth);
+
+        msg(M_INFO, "GERT(3): plugin #%d status=%d -> retval=%d", i, status, retval );
     }
 
     setenv_del(session->opt->es, "password");
+    gc_free(&gc);
 
     return retval;
 }
-- 
2.34.1


