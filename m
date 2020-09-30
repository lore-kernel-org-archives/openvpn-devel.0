From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:14 +0200
Message-Id: <20200930131317.1299-10-arne@...1227...>
In-Reply-To: <20200930131317.1299-1-arne@...1227...>
References: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 08/11] Allow pending auth to be send from a
 auth plugin
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
 doc/man-sections/generic-options.rst |   3 +-
 include/openvpn-plugin.h.in          |   8 ++
 src/openvpn/ssl.c                    |   2 +-
 src/openvpn/ssl_common.h             |   1 +
 src/openvpn/ssl_verify.c             | 165 ++++++++++++++++++++++++---
 src/openvpn/ssl_verify.h             |   2 +-
 6 files changed, 165 insertions(+), 16 deletions(-)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index d5f08839..32eeda68 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -409,7 +409,8 @@ which mode OpenVPN is configured as.
 
   * :code:`OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` plug-in hooks returns
     success/failure via :code:`auth_control_file` when using deferred auth
-    method
+    method and pending authentification via :code:`pending_auth_file`.
+
 
   * :code:`OPENVPN_PLUGIN_ENABLE_PF` plugin hook to pass filtering rules
     via ``pf_file``
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 64b20886..bb561643 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -567,6 +567,14 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
  * auth_control_file/client_connect_deferred_file
  * in the environmental variable list (envp).
  *
+ * Additionally the auth_pending_file can be written, which causes the openvpn
+ * server to send a pending auth request to the client. See doc/management.txt
+ * for more details on this authentication mechanism. The format of the
+ * auth_pending_file is
+ * line 1: timeout in seconds
+ * line 2: Pending auth method the client needs to support (e.g. openurl)
+ * line 3: EXTRA (e.g. OPEN_URL:http://www.example.com)
+ *
  * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and
  * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to
  * get the deferred result. For a V2 call implementing this function is
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a125afa2..815f896e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -994,7 +994,7 @@ key_state_free(struct key_state *ks, bool clear)
     packet_id_free(&ks->crypto_options.packet_id);
 
 #ifdef PLUGIN_DEF_AUTH
-    key_state_rm_auth_control_file(ks);
+    key_state_rm_auth_control_files(ks);
 #endif
 
     if (clear)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 7ccd1abb..98afc88c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -216,6 +216,7 @@ struct key_state
     unsigned int auth_control_status;
     time_t acf_last_mod;
     char *auth_control_file;
+    char *auth_pending_file;
 #endif
 };
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e7e62afa..fc3a1116 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -843,13 +843,129 @@ man_def_auth_test(const struct key_state *ks)
 #endif /* ifdef MANAGEMENT_DEF_AUTH */
 
 #ifdef PLUGIN_DEF_AUTH
+/**
+ *  Removes auth_pending file from the file system
+ *  and key_state structure
+ */
+static void
+key_state_rm_auth_pending_file(struct key_state *ks)
+{
+    if (ks && ks->auth_pending_file)
+    {
+        platform_unlink(ks->auth_pending_file);
+        free(ks->auth_pending_file);
+        ks->auth_pending_file = NULL;
+    }
+}
 
-/*
- * auth_control_file functions
+/**
+ * Check peer_info if the client supports the requested pending auth method
  */
+static bool
+check_auth_pending_method(const char *peer_info, const char *method)
+{
+    struct gc_arena gc = gc_new();
+
+    char *iv_sso = extract_var_peer_info(peer_info, "IV_SSO=", &gc);
+    if (!iv_sso)
+    {
+        gc_free(&gc);
+        return false;
+    }
+
+    const char *client_method = strtok(iv_sso, ",");
+    bool supported = false;
+
+    while (client_method)
+    {
+        if (0 == strcmp(client_method, method))
+        {
+            supported = true;
+            break;
+        }
+        client_method = strtok(NULL, ":");
+    }
+
+    gc_free(&gc);
+    return supported;
+}
+
+/**
+ *  Checks if the deferred state should also send auth pending
+ *  request to the client. Also removes the auth_pending control file
+ *
+ *  @returns true   if file was either processed sucessfully or did not
+ *                  exist at all
+ *  @returns false  The file had an invlaid format or another error occured
+ */
+static bool
+key_state_check_auth_pending_file(struct key_state *ks,
+                                  struct tls_multi *multi)
+{
+    bool ret = true;
+    if (ks && ks->auth_pending_file)
+    {
+        struct buffer_list *lines = buffer_list_file(ks->auth_pending_file,
+                                                     1024);
+        if (lines && lines->head)
+        {
+            /* Must have at least three lines. further lines are ignored for
+             * forward compatibility */
+            if (!lines->head || !lines->head->next || !lines->head->next->next)
+            {
+                msg(M_WARN, "auth pending control file is not at least "
+                            "three lines long.");
+                buffer_list_free(lines);
+                return false;
+            }
+            struct buffer *timeout_buf = &lines->head->buf;
+            struct buffer *iv_buf = &lines->head->next->buf;
+            struct buffer *extra_buf = &lines->head->next->next->buf;
+
+            /* Remove newline chars at the end of the lines */
+            buf_chomp(timeout_buf);
+            buf_chomp(iv_buf);
+            buf_chomp(extra_buf);
+
+            long timeout = strtol(BSTR(timeout_buf), NULL, 10);
+            if (timeout == 0)
+            {
+                msg(M_WARN, "could not parse auth pending file timeout");
+                buffer_list_free(lines);
+                return false;
+            }
+
+            const char* pending_method = BSTR(iv_buf);
+            if (!check_auth_pending_method(multi->peer_info, pending_method))
+            {
+                char buf[128];
+                openvpn_snprintf(buf, sizeof(buf),
+                                 "Authentication failed, required pending auth "
+                                 "method '%s' not supported", pending_method);
+                auth_set_client_reason(multi, buf);
+                msg(M_INFO, "Client does not supported auth pending method "
+                            "'%s'", pending_method);
+                ret = false;
+            }
+            else
+            {
+                send_auth_pending_messages(multi, BSTR(extra_buf), timeout);
+            }
+        }
+
+        buffer_list_free(lines);
+    }
+    key_state_rm_auth_pending_file(ks);
+    return ret;
+}
 
+
+/**
+ *  Removes auth_pending and auth_control files from file system
+ *  and key_state structure
+ */
 void
-key_state_rm_auth_control_file(struct key_state *ks)
+key_state_rm_auth_control_files(struct key_state *ks)
 {
     if (ks && ks->auth_control_file)
     {
@@ -857,23 +973,34 @@ key_state_rm_auth_control_file(struct key_state *ks)
         free(ks->auth_control_file);
         ks->auth_control_file = NULL;
     }
+    key_state_rm_auth_pending_file(ks);
 }
 
+/**
+ * Generates and creates the control files used for deferred authentification
+ * in the temporary directory.
+ *
+ * @return  true if file creation was successful
+ */
 static bool
-key_state_gen_auth_control_file(struct key_state *ks, const struct tls_options *opt)
+key_state_gen_auth_control_files(struct key_state *ks, const struct tls_options *opt)
 {
     struct gc_arena gc = gc_new();
 
-    key_state_rm_auth_control_file(ks);
+    key_state_rm_auth_control_files(ks);
     const char *acf = platform_create_temp_file(opt->tmp_dir, "acf", &gc);
-    if (acf)
+    const char *apf = platform_create_temp_file(opt->tmp_dir, "apf", &gc);
+
+    if (acf && apf)
     {
         ks->auth_control_file = string_alloc(acf, NULL);
+        ks->auth_pending_file = string_alloc(apf, NULL);
         setenv_str(opt->es, "auth_control_file", ks->auth_control_file);
+        setenv_str(opt->es, "auth_pending_file", ks->auth_pending_file);
     }
 
     gc_free(&gc);
-    return acf;
+    return (acf && apf);
 }
 
 static unsigned int
@@ -905,6 +1032,8 @@ key_state_test_auth_control_file(struct key_state *ks)
     return ACF_DISABLED;
 }
 
+
+
 #endif /* ifdef PLUGIN_DEF_AUTH */
 
 /*
@@ -1067,7 +1196,7 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
     const char *tmp_file = "";
-    bool ret = false;
+    bool ret = OPENVPN_PLUGIN_FUNC_ERROR;
 
     /* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
@@ -1172,7 +1301,7 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
         add_session_token_env(session, multi, up);
 #ifdef PLUGIN_DEF_AUTH
         /* generate filename for deferred auth control file */
-        if (!key_state_gen_auth_control_file(ks, session->opt))
+        if (!key_state_gen_auth_control_files(ks, session->opt))
         {
             msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
                 "could not create deferred auth control file", __func__);
@@ -1184,10 +1313,20 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
         retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
 
 #ifdef PLUGIN_DEF_AUTH
-        /* purge auth control filename (and file itself) for non-deferred returns */
-        if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
+        if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        {
+            /* Check if we the plugin has written the pending auth control
+             * file and send the pending auth to the client */
+            if(!key_state_check_auth_pending_file(ks, multi))
+            {
+                retval = OPENVPN_PLUGIN_FUNC_ERROR;
+                key_state_rm_auth_control_files(ks);
+            }
+        }
+        else
         {
-            key_state_rm_auth_control_file(ks);
+            /* purge auth control filename (and file itself) for non-deferred returns */
+            key_state_rm_auth_control_files(ks);
         }
 #endif
 
@@ -1256,7 +1395,7 @@ verify_user_pass_management(struct tls_session *session,
 #endif /* ifdef MANAGEMENT_DEF_AUTH */
 
 
-/*
+/**
  * Main username/password verification entry point
  *
  * Will set session->ks[KS_PRIMARY].authenticated according to
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index b1ced956..5b413c57 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -93,7 +93,7 @@ int tls_authentication_status(struct tls_multi *multi, const int latency);
  *
  * @param ks    The key state the remove the file for
  */
-void key_state_rm_auth_control_file(struct key_state *ks);
+void key_state_rm_auth_control_files(struct key_state *ks);
 
 /**
  * Frees the given set of certificate hashes.
-- 
2.26.2


