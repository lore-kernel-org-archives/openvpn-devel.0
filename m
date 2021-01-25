From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Jan 2021 13:56:26 +0100
Message-Id: <20210125125628.30364-10-arne@...1227...>
In-Reply-To: <20210125125628.30364-1-arne@...1227...>
References: <20210125125628.30364-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 09/11] Implement deferred auth for scripts
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

Patch V2: add refactoring of the if condition

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                         | 12 ++++
 doc/man-sections/script-options.rst | 14 ++++-
 src/openvpn/ssl.c                   |  2 -
 src/openvpn/ssl_verify.c            | 86 +++++++++++++++++++++--------
 4 files changed, 89 insertions(+), 25 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 2a2829e7..188bd8ab 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -9,6 +9,18 @@ Keying Material Exporters (RFC 5705) based key generation
     the RFC5705 based key material generation to the current custom
     OpenVPN PRF. This feature requires OpenSSL or mbed TLS 2.18+.
 
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
+
+
 Overview of changes in 2.5
 ==========================
 
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 03b3dd77..50edd986 100644
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
+  seconds and the second line the EXTRA as documented in the
+  ``client-pending-auth`` section of `doc/management.txt`.
+
 
   This directive is designed to enable a plugin-style interface for
   extending OpenVPN's authentication capabilities.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b8e77f0e..699b7347 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -992,9 +992,7 @@ key_state_free(struct key_state *ks, bool clear)
 
     packet_id_free(&ks->crypto_options.packet_id);
 
-#ifdef PLUGIN_DEF_AUTH
     key_state_rm_auth_control_files(ks);
-#endif
 
     if (clear)
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index b9647c1a..fc9f1d2e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1188,14 +1188,14 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
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
 
     /* Set environmental variables prior to calling script */
     setenv_str(session->opt->es, "script_type", "user-pass-verify");
@@ -1223,25 +1223,61 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
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
+    if (!key_state_gen_auth_control_files(&session->key[KS_PRIMARY],
+                                         session->opt))
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
+#ifdef ENABLE_DEF_AUTH
+    if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
+    {
+        /* Check if we the plugin has written the pending auth control
+         * file and send the pending auth to the client */
+        if(!key_state_check_auth_pending_file(&session->key[KS_PRIMARY],
+                                              multi))
+        {
+            retval = OPENVPN_PLUGIN_FUNC_ERROR;
+            key_state_rm_auth_control_files(&session->key[KS_PRIMARY]);
+        }
 
+    }
+    else
+    {
+        /* purge auth control filename (and file itself) for non-deferred returns */
+        key_state_rm_auth_control_files(&session->key[KS_PRIMARY]);
+    }
+#endif
     if (!session->opt->auth_user_pass_verify_script_via_file)
     {
         setenv_del(session->opt->es, "password");
     }
+
 done:
     if (tmp_file && strlen(tmp_file) > 0)
     {
@@ -1250,7 +1286,7 @@ done:
 
     argv_free(&argv);
     gc_free(&gc);
-    return ret;
+    return retval;
 }
 
 /*
@@ -1371,8 +1407,6 @@ void
 verify_user_pass(struct user_pass *up, struct tls_multi *multi,
                  struct tls_session *session)
 {
-    int s1 = OPENVPN_PLUGIN_FUNC_SUCCESS;
-    bool s2 = true;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
 #ifdef ENABLE_MANAGEMENT
@@ -1432,30 +1466,32 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
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
 
@@ -1466,19 +1502,25 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
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
2.30.0


