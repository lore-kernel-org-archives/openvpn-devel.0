From: Arne Schwabe <arne@...1227...>
Date: Mon,  5 Oct 2020 13:16:14 +0200
Message-Id: <20201005111614.29325-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add function for common env setting of
 verify user/pass calls
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

This removes the code duplication in verify_user_pass_script,
verify_user_pass_plugin and verify_user_pass_management.

In most of these function it also removes a

This also fixes a bug that username is not set if auth-gen-token is
used without the external-auth flag as without calling any external auth
method, the environment would not be setup for connect-client calls.

This patch also removes an indentation level in most of touched functions
so diffing without whitespaces is recommended for review.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_verify.c | 176 +++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 98 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 76260967..a619c554 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1095,69 +1095,50 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
     const char *tmp_file = "";
     bool ret = false;
 
-    /* Is username defined? */
-    if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
+    /* Set environmental variables prior to calling script */
+    setenv_str(session->opt->es, "script_type", "user-pass-verify");
+
+    if (session->opt->auth_user_pass_verify_script_via_file)
     {
-        /* Set environmental variables prior to calling script */
-        setenv_str(session->opt->es, "script_type", "user-pass-verify");
+        struct status_output *so;
 
-        if (session->opt->auth_user_pass_verify_script_via_file)
+        tmp_file = platform_create_temp_file(session->opt->tmp_dir, "up",
+                                             &gc);
+        if (tmp_file)
         {
-            struct status_output *so;
-
-            tmp_file = platform_create_temp_file(session->opt->tmp_dir, "up",
-                                                 &gc);
-            if (tmp_file)
+            so = status_open(tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
+            status_printf(so, "%s", up->username);
+            status_printf(so, "%s", up->password);
+            if (!status_close(so))
             {
-                so = status_open(tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
-                status_printf(so, "%s", up->username);
-                status_printf(so, "%s", up->password);
-                if (!status_close(so))
-                {
-                    msg(D_TLS_ERRORS, "TLS Auth Error: could not write username/password to file: %s",
-                        tmp_file);
-                    goto done;
-                }
-            }
-            else
-            {
-                msg(D_TLS_ERRORS, "TLS Auth Error: could not create write "
-                    "username/password to temp file");
+                msg(D_TLS_ERRORS, "TLS Auth Error: could not write username/password to file: %s",
+                    tmp_file);
+                goto done;
             }
         }
         else
         {
-            setenv_str(session->opt->es, "username", up->username);
-            setenv_str(session->opt->es, "password", up->password);
-        }
-
-        /* setenv incoming cert common name for script */
-        setenv_str(session->opt->es, "common_name", session->common_name);
-
-        /* setenv client real IP address */
-        setenv_untrusted(session);
-
-        /* add auth-token environment */
-        add_session_token_env(session, multi, up);
-
-        /* format command line */
-        argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
-        argv_printf_cat(&argv, "%s", tmp_file);
-
-        /* call command */
-        ret = openvpn_run_script(&argv, session->opt->es, 0,
-                                 "--auth-user-pass-verify");
-
-        if (!session->opt->auth_user_pass_verify_script_via_file)
-        {
-            setenv_del(session->opt->es, "password");
+            msg(D_TLS_ERRORS, "TLS Auth Error: could not create write "
+                "username/password to temp file");
         }
     }
     else
     {
-        msg(D_TLS_ERRORS, "TLS Auth Error: peer provided a blank username");
+        setenv_str(session->opt->es, "password", up->password);
     }
 
+    /* format command line */
+    argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
+    argv_printf_cat(&argv, "%s", tmp_file);
+
+    /* call command */
+    ret = openvpn_run_script(&argv, session->opt->es, 0,
+                             "--auth-user-pass-verify");
+
+    if (!session->opt->auth_user_pass_verify_script_via_file)
+    {
+        setenv_del(session->opt->es, "password");
+    }
 done:
     if (tmp_file && strlen(tmp_file) > 0)
     {
@@ -1181,48 +1162,31 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 #endif
 
-    /* Is username defined? */
-    if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
-    {
-        /* set username/password in private env space */
-        setenv_str(session->opt->es, "username", up->username);
-        setenv_str(session->opt->es, "password", up->password);
-
-        /* setenv incoming cert common name for script */
-        setenv_str(session->opt->es, "common_name", session->common_name);
+    /* set password in private env space */
+    setenv_str(session->opt->es, "password", up->password);
 
-        /* setenv client real IP address */
-        setenv_untrusted(session);
-
-        /* add auth-token environment */
-        add_session_token_env(session, multi, up);
 #ifdef PLUGIN_DEF_AUTH
-        /* generate filename for deferred auth control file */
-        if (!key_state_gen_auth_control_file(ks, session->opt))
-        {
-            msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
-                "could not create deferred auth control file", __func__);
-            return retval;
-        }
+    /* generate filename for deferred auth control file */
+    if (!key_state_gen_auth_control_file(ks, session->opt))
+    {
+        msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
+            "could not create deferred auth control file", __func__);
+        return retval;
+    }
 #endif
 
-        /* call command */
-        retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
+    /* call command */
+    retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
 
 #ifdef PLUGIN_DEF_AUTH
-        /* purge auth control filename (and file itself) for non-deferred returns */
-        if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
-        {
-            key_state_rm_auth_control_file(ks);
-        }
-#endif
-
-        setenv_del(session->opt->es, "password");
-    }
-    else
+    /* purge auth control filename (and file itself) for non-deferred returns */
+    if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
     {
-        msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): peer provided a blank username");
+        key_state_rm_auth_control_file(ks);
     }
+#endif
+
+    setenv_del(session->opt->es, "password");
 
     return retval;
 }
@@ -1245,12 +1209,30 @@ verify_user_pass_management(struct tls_session *session,
     int retval = KMDA_ERROR;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
+    /* set username/password in private env space */
+    setenv_str(session->opt->es, "password", up->password);
+
+    if (management)
+    {
+        management_notify_client_needing_auth(management, ks->mda_key_id, session->opt->mda_context, session->opt->es);
+    }
+
+    setenv_del(session->opt->es, "password");
+
+    retval = KMDA_SUCCESS;
+
+    return retval;
+}
+#endif /* ifdef MANAGEMENT_DEF_AUTH */
+
+static bool
+set_verify_user_pass_env(struct user_pass *up, struct tls_multi *multi,
+                         struct tls_session *session)
+{
     /* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
     {
-        /* set username/password in private env space */
         setenv_str(session->opt->es, "username", up->username);
-        setenv_str(session->opt->es, "password", up->password);
 
         /* setenv incoming cert common name for script */
         setenv_str(session->opt->es, "common_name", session->common_name);
@@ -1263,24 +1245,14 @@ verify_user_pass_management(struct tls_session *session,
          * allow the management to figure out if it is a new session or a continued one
          */
         add_session_token_env(session, multi, up);
-        if (management)
-        {
-            management_notify_client_needing_auth(management, ks->mda_key_id, session->opt->mda_context, session->opt->es);
-        }
-
-        setenv_del(session->opt->es, "password");
-
-        retval = KMDA_SUCCESS;
+        return true;
     }
     else
     {
-        msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_management): peer provided a blank username");
+        msg(D_TLS_ERRORS, "TLS Auth Error: peer provided a blank username");
+        return false;
     }
-
-    return retval;
 }
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
-
 
 /*
  * Main username/password verification entry point
@@ -1352,6 +1324,14 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             return;
         }
     }
+
+    /* Set the environment variables used by all auth variants */
+    if (!set_verify_user_pass_env(up, multi, session))
+    {
+        skip_auth = true;
+        s1 = OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
     /* call plugin(s) and/or script */
     if (!skip_auth)
     {
-- 
2.26.2


