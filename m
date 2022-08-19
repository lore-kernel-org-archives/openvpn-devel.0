From: Arne Schwabe <arne@...1227...>
Date: Fri, 19 Aug 2022 11:51:32 +0200
Message-Id: <20220819095132.94873-1-arne@...1227...>
In-Reply-To: <20210125125628.30364-11-arne@...1227...>
References: <20210125125628.30364-11-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Implement --client-crresponse script
 options and plugin interface
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

This is allows scripts and pluginsto parse/react to a CR_RESPONSE message

Patch V2: doc fixes, do not put script under ENABLE_PLUGIN
Patch V3: rebase
Patch V4: fix else branch of the verify_crresponse_script function

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/script-options.rst | 28 +++++++++++-
 include/openvpn-plugin.h.in         |  7 ++-
 src/openvpn/init.c                  |  1 +
 src/openvpn/options.c               | 15 +++++++
 src/openvpn/options.h               |  1 +
 src/openvpn/plugin.c                |  5 ++-
 src/openvpn/push.c                  |  4 ++
 src/openvpn/ssl_common.h            |  1 +
 src/openvpn/ssl_verify.c            | 67 +++++++++++++++++++++++++++++
 src/openvpn/ssl_verify.h            | 23 ++++++++++
 10 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 6be0686d7..74c6a1fc6 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -52,6 +52,11 @@ Script Order of Execution
    Executed in ``--mode server`` mode on new client connections, when the
    client is still untrusted.
 
+#. ``--client-crresponse``
+
+    Execute in ``--mode server`` whenever a client sends a
+    :code:`CR_RESPONSE` message
+
 SCRIPT HOOKS
 ------------
 
@@ -72,7 +77,7 @@ SCRIPT HOOKS
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
 
-  If ``method`` is set to :code:`via-env`, OpenVPN will call ``script``
+  If ``method`` is set to :code:`via-env`, OpenVPN will call ``cmd``
   with the environmental variables :code:`username` and :code:`password`
   set to the username/password strings provided by the client. *Beware*
   that this method is insecure on some platforms which make the environment
@@ -80,7 +85,7 @@ SCRIPT HOOKS
 
   If ``method`` is set to :code:`via-file`, OpenVPN will write the username
   and password to the first two lines of a temporary file. The filename
-  will be passed as an argument to ``script``, and the file will be
+  will be passed as an argument to ``cmd``, and the file will be
   automatically deleted by OpenVPN after the script returns. The location
   of the temporary file is controlled by the ``--tmp-dir`` option, and
   will default to the current directory if unspecified. For security,
@@ -123,6 +128,25 @@ SCRIPT HOOKS
   For a sample script that performs PAM authentication, see
   :code:`sample-scripts/auth-pam.pl` in the OpenVPN source distribution.
 
+--client-crresponse
+    Executed when the client sends a text based challenge response.
+
+    Valid syntax:
+    ::
+
+        client-crresponse cmd
+
+  OpenVPN will write the response of the client into a temporary file.
+  The filename will be passed as an argument to ``cmd``, and the file will be
+  automatically deleted by OpenVPN after the script returns.
+
+  The response is passed as is from the client. The script needs to check
+  itself if the input is valid, e.g. if the input is valid base64 encoding.
+
+  The script can either directly write the result of the verification to
+  :code:`auth_control_file or further defer it. See ``--auth-user-pass-verify``
+  for details.
+
 --client-connect cmd
   Run command ``cmd`` on client connection.
 
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index dc7c5306f..e498f94db 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -83,6 +83,10 @@ extern "C" {
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_CLIENT_CONNECT_V2
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_LEARN_ADDRESS
  *
+ * The OPENVPN_PLUGIN_CLIENT_CRRESPONSE function is called when the client sends
+ * the CR_RESPONSE message, this is *typically* after OPENVPN_PLUGIN_TLS_FINAL
+ * but may also occur much later.
+ *
  * [Client session ensues]
  *
  * For each "TLS soft reset", according to reneg-sec option (or similar):
@@ -128,7 +132,8 @@ extern "C" {
 #define OPENVPN_PLUGIN_ROUTE_PREDOWN            12
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER     13
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2  14
-#define OPENVPN_PLUGIN_N                        15
+#define OPENVPN_PLUGIN_CLIENT_CRRESPONSE        15
+#define OPENVPN_PLUGIN_N                        16
 
 /*
  * Build a mask out of a set of plug-in types.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 05c2ee9bc..b06406b95 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3029,6 +3029,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
 
     to.auth_user_pass_verify_script = options->auth_user_pass_verify_script;
     to.auth_user_pass_verify_script_via_file = options->auth_user_pass_verify_script_via_file;
+    to.client_crresponse_script = options->client_crresponse_script;
     to.tmp_dir = options->tmp_dir;
     if (options->ccd_exclusive)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2415c1a84..5d181f6b8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1525,6 +1525,7 @@ show_p2mp_parms(const struct options *o)
     SHOW_STR(client_connect_script);
     SHOW_STR(learn_address_script);
     SHOW_STR(client_disconnect_script);
+    SHOW_STR(client_crresponse_script);
     SHOW_STR(client_config_dir);
     SHOW_BOOL(ccd_exclusive);
     SHOW_STR(tmp_dir);
@@ -2684,6 +2685,10 @@ options_postprocess_verify_ce(const struct options *options,
         {
             msg(M_USAGE, "--client-connect requires --mode server");
         }
+        if (options->client_crresponse_script)
+        {
+            msg(M_USAGE, "--client-crresponse requires --mode server");
+        }
         if (options->client_disconnect_script)
         {
             msg(M_USAGE, "--client-disconnect requires --mode server");
@@ -7441,6 +7446,16 @@ add_option(struct options *options,
         set_user_script(options, &options->client_connect_script,
                         p[1], "client-connect", true);
     }
+    else if (streq(p[0], "client-crresponse") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        if (!no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))
+        {
+            goto err;
+        }
+        set_user_script(options, &options->client_crresponse_script,
+                        p[1], "client-crresponse", true);
+    }
     else if (streq(p[0], "client-disconnect") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SCRIPT);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 83c97ded1..b4f4dfc17 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -473,6 +473,7 @@ struct options
     const char *client_connect_script;
     const char *client_disconnect_script;
     const char *learn_address_script;
+    const char *client_crresponse_script;
     const char *client_config_dir;
     bool ccd_exclusive;
     bool disable;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 51136feae..4c2fec068 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -102,7 +102,7 @@ plugin_type_name(const int type)
             return "PLUGIN_CLIENT_CONNECT";
 
         case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
-            return "PLUGIN_CLIENT_CONNECT";
+            return "PLUGIN_CLIENT_CONNECT_V2";
 
         case OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER:
             return "PLUGIN_CLIENT_CONNECT_DEFER";
@@ -122,6 +122,9 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_ROUTE_PREDOWN:
             return "PLUGIN_ROUTE_PREDOWN";
 
+        case OPENVPN_PLUGIN_CLIENT_CRRESPONSE:
+            return "PLUGIN_CRRESPONSE";
+
         default:
             return "PLUGIN_???";
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 121ea691a..4cbc89e4c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -229,6 +229,10 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
 
     management_notify_client_cr_response(key_id, mda, es, m);
 #endif
+#if ENABLE_PLUGIN
+    verify_crresponse_plugin(c->c2.tls_multi, m);
+#endif
+    verify_crresponse_script(c->c2.tls_multi, m);
     msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index c565d78c1..bf3ac67a5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -362,6 +362,7 @@ struct tls_options
 
     /* used for username/password authentication */
     const char *auth_user_pass_verify_script;
+    const char *client_crresponse_script;
     bool auth_user_pass_verify_script_via_file;
     const char *tmp_dir;
     const char *auth_user_pass_file;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index c01841fa9..5152eb4f3 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1352,6 +1352,73 @@ done:
     return retval;
 }
 
+#ifdef ENABLE_PLUGIN
+void
+verify_crresponse_plugin(struct tls_multi *multi, const char *cr_response)
+{
+    struct tls_session *session = &multi->session[TM_ACTIVE];
+    setenv_str(session->opt->es, "crresponse", cr_response);
+
+    plugin_call(session->opt->plugins, OPENVPN_PLUGIN_CLIENT_CRRESPONSE, NULL,
+                NULL, session->opt->es);
+
+    setenv_del(session->opt->es, "crresponse");
+}
+#endif
+
+void
+verify_crresponse_script(struct tls_multi *multi, const char *cr_response)
+{
+
+    struct tls_session *session = &multi->session[TM_ACTIVE];
+
+    if (!session->opt->client_crresponse_script)
+    {
+        return;
+    }
+    struct argv argv = argv_new();
+    struct gc_arena gc = gc_new();
+
+    setenv_str(session->opt->es, "script_type", "client-crresponse");
+
+    /* Since cr response might be sensitive, like a stupid way to query
+     * a password via 2FA, we pass it via file instead environment */
+    const char *tmp_file = platform_create_temp_file(session->opt->tmp_dir, "cr", &gc);
+    if (tmp_file)
+    {
+        struct status_output *so = status_open(tmp_file, 0, -1, NULL,
+                                               STATUS_OUTPUT_WRITE);
+        status_printf(so, "%s", cr_response);
+        if (!status_close(so))
+        {
+            msg(D_TLS_ERRORS, "TLS CR Response Error: could not write cr"
+                "responsed to file: %s",
+                tmp_file);
+            tls_deauthenticate(multi);
+            goto done;
+        }
+    }
+    else
+    {
+        msg(D_TLS_ERRORS, "TLS Auth Error: could not write "
+            "username/password to cr response temp file");
+        tls_deauthenticate(multi);
+        goto done;
+    }
+
+    argv_parse_cmd(&argv, session->opt->client_crresponse_script);
+    argv_printf_cat(&argv, "%s", tmp_file);
+
+
+    if (!openvpn_run_script(&argv, session->opt->es, 0, "--client-crresponse"))
+    {
+        tls_deauthenticate(multi);
+    }
+done:
+    argv_free(&argv);
+    gc_free(&gc);
+}
+
 /*
  * Verify the username and password using a plugin
  */
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 15ef0b40d..30dfc9bc3 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -177,6 +177,29 @@ bool cert_hash_compare(const struct cert_hash_set *chs1, const struct cert_hash_
 void verify_user_pass(struct user_pass *up, struct tls_multi *multi,
                       struct tls_session *session);
 
+
+
+/**
+ * Runs the --client-crresponse script if one is defined.
+ *
+ * As with the management interface the script is stateless in the sense that
+ * it does not directly participate in the authentication but rather should set
+ * the files for the deferred auth like the management commands.
+ *
+ */
+void
+verify_crresponse_script(struct tls_multi *multi, const char *cr_response);
+
+/**
+ * Call the plugin OPENVPN_PLUGIN_CLIENT_CRRESPONSE.
+ *
+ * As with the management interface calling the plugin is stateless in the sense
+ * that it does not directly participate in the authentication but rather
+ * should set the files for the deferred auth like the management commands.
+ */
+void
+verify_crresponse_plugin(struct tls_multi *multi, const char *cr_response);
+
 /**
  * Perform final authentication checks, including locking of the cn, the allowed
  * certificate hashes, and whether a client config entry exists in the
-- 
2.32.1 (Apple Git-133)


