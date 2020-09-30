From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:15 +0200
Message-Id: <20200930131317.1299-11-arne@...1227...>
In-Reply-To: <20200930131317.1299-1-arne@...1227...>
References: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 09/11] Implement deferred auth for scripts
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
 Changes.rst                         |  9 +++++
 doc/man-sections/script-options.rst | 14 +++++++-
 src/openvpn/ssl_verify.c            | 56 ++++++++++++++++++++++++-----
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index f67e1d76..7e60eb64 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,3 +1,12 @@
+Overview of changes in 2.6
+==========================
+
+
+New features
+------------
+Deferred auth support for scripts
+    The ``--auth-user-pass-verify`` script supports now deferred authentication.
+
 Overview of changes in 2.5
 ==========================
 
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index a4df6732..e0cc10c2 100644
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
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index fc3a1116..5e15fa32 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1189,14 +1189,14 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
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
-    bool ret = OPENVPN_PLUGIN_FUNC_ERROR;
+    int retval = OPENVPN_PLUGIN_FUNC_ERROR;
 
     /* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
@@ -1247,10 +1247,45 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
         argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
         argv_printf_cat(&argv, "%s", tmp_file);
 
+        /* Add files needed for deferred auth */
+        key_state_gen_auth_control_files(&session->key[KS_PRIMARY],
+                                         session->opt);
+
         /* call command */
-        ret = openvpn_run_script(&argv, session->opt->es, 0,
-                                 "--auth-user-pass-verify");
+        int script_ret = openvpn_run_script(&argv, session->opt->es, S_EXITCODE,
+                                            "--auth-user-pass-verify");
+
+        switch (script_ret)
+        {
+           case 0:
+               retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
+               break;
+           case 2:
+               retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
+               break;
+           default:
+               retval = OPENVPN_PLUGIN_FUNC_ERROR;
+               break;
+           }
+#ifdef ENABLE_DEF_AUTH
+        if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        {
+            /* Check if we the plugin has written the pending auth control
+             * file and send the pending auth to the client */
+            if(!key_state_check_auth_pending_file(&session->key[KS_PRIMARY],
+                                                  multi))
+            {
+                retval = OPENVPN_PLUGIN_FUNC_ERROR;
+                key_state_rm_auth_control_files(&session->key[KS_PRIMARY]);
+            }
 
+        }
+        else
+        {
+            /* purge auth control filename (and file itself) for non-deferred returns */
+            key_state_rm_auth_control_files(&session->key[KS_PRIMARY]);
+        }
+#endif
         if (!session->opt->auth_user_pass_verify_script_via_file)
         {
             setenv_del(session->opt->es, "password");
@@ -1269,7 +1304,7 @@ done:
 
     argv_free(&argv);
     gc_free(&gc);
-    return ret;
+    return retval;
 }
 
 /*
@@ -1406,7 +1441,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
                  struct tls_session *session)
 {
     int s1 = OPENVPN_PLUGIN_FUNC_SUCCESS;
-    bool s2 = true;
+    int s2 = OPENVPN_PLUGIN_FUNC_SUCCESS;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
 #ifdef MANAGEMENT_DEF_AUTH
@@ -1499,7 +1534,11 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
 #ifdef PLUGIN_DEF_AUTH
          || s1 == OPENVPN_PLUGIN_FUNC_DEFERRED
 #endif
-         ) && s2
+         ) &&
+        ((s2 == OPENVPN_PLUGIN_FUNC_SUCCESS)
+#ifdef ENABLE_DEF_AUTH
+         || s2 ==  OPENVPN_PLUGIN_FUNC_DEFERRED)
+#endif
 #ifdef MANAGEMENT_DEF_AUTH
         && man_def_auth != KMDA_ERROR
 #endif
@@ -1507,7 +1546,8 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     {
         ks->authenticated = KS_AUTH_TRUE;
 #ifdef PLUGIN_DEF_AUTH
-        if (s1 == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        if (s1 == OPENVPN_PLUGIN_FUNC_DEFERRED
+            || s2 == OPENVPN_PLUGIN_FUNC_DEFERRED)
         {
             ks->authenticated = KS_AUTH_DEFERRED;
         }
-- 
2.26.2


