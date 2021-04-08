From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 16:02:29 +0200
Message-Id: <20210408140229.31824-5-arne@...1227...>
In-Reply-To: <20210408140229.31824-1-arne@...1227...>
References: <20210408140229.31824-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/4] Implement deferred auth for scripts
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

This patch also refactors the if condition that checks the result of
the authentication since that has become quite unreadable. It renames
s1/s2 and extracts some parts of the condition into individual variables
to make the condition better understandle

Patch v2: add refactoring of the if condition
Patch v4: fix documentation not mentioning method as 2nd line
Patch v5: fix deferred auth used by both plugin and script not working
Patch v6: Add missing async inotify for script deferred auth

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                         |  10 +++
 doc/man-sections/script-options.rst |  14 +++-
 src/openvpn/multi.c                 |   6 ++
 src/openvpn/ssl.c                   |   1 +
 src/openvpn/ssl_common.h            |   1 +
 src/openvpn/ssl_verify.c            | 105 ++++++++++++++++++++--------
 6 files changed, 106 insertions(+), 31 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index d6ccc1c92..e7ae6abed 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -30,6 +30,16 @@ TLS mode with self-signed certificates
     become optional. This allows for small OpenVPN setups without setting up
     a PKI with Easy-RSA or similar software.
 
+Deferred auth support for scripts
+    The ``--auth-user-pass-verify`` script supports now deferred authentication.
+
+Pending auth support for plugins and scripts
+    Both auth plugin and script can now signal pending authentication to
+    the client when using deferred authentication. The new ``client-crresponse``
+    script option and ``OPENVPN_PLUGIN_CLIENT_CRRESPONSE`` plugin function can
+    be used to parse a client response to a ``CR_TEXT`` two factor challenge.
+
+    See ``sample/sample-scripts/totpauth.py`` for an example.
 
 Deprecated features
 -------------------
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 03b3dd77b..22990f4f4 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -90,7 +90,19 @@ SCRIPT HOOKS
 
   The script should examine the username and password, returning a success
   exit code (:code:`0`) if the client's authentication request is to be
-  accepted, or a failure code (:code:`1`) to reject the client.
+  accepted, a failure code (:code:`1`) to reject the client, or a that
+  the authentication is deferred (:code:`2`). If the authentication is
+  deferred, the script must fork/start a background or another non-blocking
+  operation to continue the authentication in the background. When finshing
+  the authentication, a :code:`1` or :code:`0` must be written to the
+  file specified by the :code:`auth_control_file`.
+
+  When deferred authentication is in use, the script can also request
+  pending authentication by writing to the file specified by the
+  :code:`auth_pending_file`. The first line must be the timeout in
+  seconds, the required method on the second line (e.g. crtext) and
+  third line must be the EXTRA as documented in the
+  ``client-pending-auth`` section of `doc/management.txt`.
 
   This directive is designed to enable a plugin-style interface for
   extending OpenVPN's authentication capabilities.
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ee3ee6ced..eba80ee59 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2989,6 +2989,12 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
             add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
                                    ks->plugin_auth.auth_control_file);
         }
+        if (ks && ks->script_auth.auth_control_file && was_unauthenticated
+            && (ks->authenticated == KS_AUTH_DEFERRED))
+        {
+            add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
+                                   ks->script_auth.auth_control_file);
+        }
 #endif
 
         if (!IS_SIG(&mi->context))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c28818b6e..6e53a3be4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -994,6 +994,7 @@ key_state_free(struct key_state *ks, bool clear)
     packet_id_free(&ks->crypto_options.packet_id);
 
     key_state_rm_auth_control_files(&ks->plugin_auth);
+    key_state_rm_auth_control_files(&ks->script_auth);
 
     if (clear)
     {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 824dac310..f85131ee7 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -222,6 +222,7 @@ struct key_state
     time_t acf_last_mod;
 
     struct auth_deferred_status plugin_auth;
+    struct auth_deferred_status script_auth;
 };
 
 /** Control channel wrapping (--tls-auth/--tls-crypt) context */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 7608155cd..7c02d46ce 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1102,20 +1102,25 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
             }
             else
             {
-                unsigned int s1 = ACF_DISABLED;
-                unsigned int s2 = ACF_DISABLED;
-                s1 = key_state_test_auth_control_file(&ks->plugin_auth);
+                unsigned int auth_plugin = ACF_DISABLED;
+                unsigned int auth_script = ACF_DISABLED;
+                unsigned int auth_man = ACF_DISABLED;
+                auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth);
+                auth_script = key_state_test_auth_control_file(&ks->script_auth);
 #ifdef ENABLE_MANAGEMENT
-                s2 = man_def_auth_test(ks);
+                auth_man = man_def_auth_test(ks);
 #endif
-                ASSERT(s1 < 4 && s2 < 4);
+                ASSERT(auth_plugin < 4 && auth_script < 4 && auth_man < 4);
 
-                if (s1 == ACF_FAILED || s2 == ACF_FAILED)
+                if (auth_plugin == ACF_FAILED || auth_script == ACF_FAILED
+                   || auth_man == ACF_FAILED)
                 {
                     ks->authenticated = KS_AUTH_FALSE;
                     failed_auth = true;
                 }
-                else if (s1 == ACF_UNDEFINED || s2 == ACF_UNDEFINED)
+                else if (auth_plugin == ACF_UNDEFINED
+                         || auth_script == ACF_UNDEFINED
+                         || auth_man == ACF_UNDEFINED)
                 {
                     if (now < ks->auth_deferred_expire)
                     {
@@ -1124,7 +1129,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                 }
                 else
                 {
-                    /* s1 and s2 are either ACF_DISABLED or ACF_SUCCEDED */
+                    /* auth_plugin and auth_man are either ACF_DISABLED or ACF_SUCCEDED */
                     success = true;
                     ks->authenticated = KS_AUTH_TRUE;
                 }
@@ -1204,14 +1209,15 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
 /*
  * Verify the user name and password using a script
  */
-static bool
+static int
 verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
                         const struct user_pass *up)
 {
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
     const char *tmp_file = "";
-    bool ret = false;
+    int retval = OPENVPN_PLUGIN_FUNC_ERROR;
+    struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
     /* Set environmental variables prior to calling script */
     setenv_str(session->opt->es, "script_type", "user-pass-verify");
@@ -1239,25 +1245,58 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
             /* pass temp file name to script */
             argv_printf_cat(&argv, "%s", tmp_file);
         }
-        else
-        {
-            msg(D_TLS_ERRORS, "TLS Auth Error: could not create write "
-                "username/password to temp file");
-        }
     }
     else
     {
+        setenv_str(session->opt->es, "username", up->username);
         setenv_str(session->opt->es, "password", up->password);
     }
 
+    /* generate filename for deferred auth control file */
+    if (!key_state_gen_auth_control_files(&ks->script_auth, session->opt))
+    {
+        msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
+                          "could not create deferred auth control file", __func__);
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
     /* call command */
-    ret = openvpn_run_script(&argv, session->opt->es, 0,
-                             "--auth-user-pass-verify");
+    int script_ret = openvpn_run_script(&argv, session->opt->es, S_EXITCODE,
+                                        "--auth-user-pass-verify");
+    switch (script_ret)
+    {
+       case 0:
+           retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
+           break;
+       case 2:
+           retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
+           break;
+       default:
+           retval = OPENVPN_PLUGIN_FUNC_ERROR;
+           break;
+    }
+    if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
+    {
+        /* Check if we the plugin has written the pending auth control
+         * file and send the pending auth to the client */
+        if(!key_state_check_auth_pending_file(&ks->script_auth,
+                                              multi))
+        {
+            retval = OPENVPN_PLUGIN_FUNC_ERROR;
+            key_state_rm_auth_control_files(&ks->script_auth);
+        }
 
+    }
+    else
+    {
+        /* purge auth control filename (and file itself) for non-deferred returns */
+        key_state_rm_auth_control_files(&ks->script_auth);
+    }
     if (!session->opt->auth_user_pass_verify_script_via_file)
     {
         setenv_del(session->opt->es, "password");
     }
+
 done:
     if (tmp_file && strlen(tmp_file) > 0)
     {
@@ -1266,7 +1305,7 @@ done:
 
     argv_free(&argv);
     gc_free(&gc);
-    return ret;
+    return retval;
 }
 
 /*
@@ -1387,8 +1426,6 @@ void
 verify_user_pass(struct user_pass *up, struct tls_multi *multi,
                  struct tls_session *session)
 {
-    int s1 = OPENVPN_PLUGIN_FUNC_SUCCESS;
-    bool s2 = true;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
 #ifdef ENABLE_MANAGEMENT
@@ -1448,30 +1485,32 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         }
     }
 
+    int plugin_status = OPENVPN_PLUGIN_FUNC_SUCCESS;
+    int script_status = OPENVPN_PLUGIN_FUNC_SUCCESS;
     /* Set the environment variables used by all auth variants */
     if (!set_verify_user_pass_env(up, multi, session))
     {
         skip_auth = true;
-        s1 = OPENVPN_PLUGIN_FUNC_ERROR;
+        plugin_status = OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
     /* call plugin(s) and/or script */
     if (!skip_auth)
     {
 #ifdef ENABLE_MANAGEMENT
-        if (man_def_auth==KMDA_DEF)
+        if (man_def_auth == KMDA_DEF)
         {
             man_def_auth = verify_user_pass_management(session, multi, up);
         }
 #endif
         if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
         {
-            s1 = verify_user_pass_plugin(session, multi, up);
+            plugin_status = verify_user_pass_plugin(session, multi, up);
         }
 
         if (session->opt->auth_user_pass_verify_script)
         {
-            s2 = verify_user_pass_script(session, multi, up);
+            script_status = verify_user_pass_script(session, multi, up);
         }
     }
 
@@ -1482,19 +1521,25 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         msg(D_TLS_ERRORS,
             "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
             TLS_USERNAME_LEN);
-        s1 = OPENVPN_PLUGIN_FUNC_ERROR;
+        plugin_status = OPENVPN_PLUGIN_FUNC_ERROR;
+        script_status = OPENVPN_PLUGIN_FUNC_ERROR;
     }
     /* auth succeeded? */
-    if ((s1 == OPENVPN_PLUGIN_FUNC_SUCCESS
-         || s1 == OPENVPN_PLUGIN_FUNC_DEFERRED
-         ) && s2
+    bool plugin_ok = plugin_status == OPENVPN_PLUGIN_FUNC_SUCCESS
+        || plugin_status == OPENVPN_PLUGIN_FUNC_DEFERRED;
+
+    bool script_ok =  script_status == OPENVPN_PLUGIN_FUNC_SUCCESS
+        || script_status ==  OPENVPN_PLUGIN_FUNC_DEFERRED;
+
+    if (script_ok && plugin_ok && tls_lock_username(multi, up->username)
 #ifdef ENABLE_MANAGEMENT
         && man_def_auth != KMDA_ERROR
 #endif
-        && tls_lock_username(multi, up->username))
+        )
     {
         ks->authenticated = KS_AUTH_TRUE;
-        if (s1 == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        if (plugin_status == OPENVPN_PLUGIN_FUNC_DEFERRED
+            || script_status == OPENVPN_PLUGIN_FUNC_DEFERRED)
         {
             ks->authenticated = KS_AUTH_DEFERRED;
         }
-- 
2.31.1


