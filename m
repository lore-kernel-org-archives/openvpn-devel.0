From: Antonio Quartulli <a@...2181...>
Date: Sat, 17 Sep 2022 15:48:32 +0200
Message-Id: <20220917134832.16359-1-a@...2181...>
In-Reply-To: <20220914185937.31423-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/2] auth-user-pass: add support for
 inline credentials
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
Cc: Antonio Quartulli <a@...2181...>

--auth-user-pass is probably the only option expecting a filename as
argument that cannot be inline'd as of today.

This patch allows specifying username and password inline in the config
file within the <auth-user-pass></auth-user-pass> tag.

This logic was already implemented for --http-proxy-user-pass, therefore
it was just about applying it to this specific option as well.
Note that the current logic expects username and password to always be
specified when inline. Therefore omitting the password will result in
storing an empty password.

A later patch will change this behaviour to make it consistent with the
classic case (username writte in file), where the password is requested
via stdin when missing.

While a it, add an empty line between prototypes in init.c to make
uncrustify happy.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* properly add _inline suffix to 2nd argument of auth_user_pass_setup()
---
 Changes.rst              |  4 ++++
 src/openvpn/init.c       |  9 +++++++--
 src/openvpn/options.c    | 12 +++++++-----
 src/openvpn/options.h    |  1 +
 src/openvpn/ssl.c        | 24 ++++++++++++++++++------
 src/openvpn/ssl.h        |  6 ++++--
 src/openvpn/ssl_common.h |  1 +
 7 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 275f8d64..2967533a 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -87,6 +87,10 @@ Data channel offloading with ovpn-dco
     this implies that peers must be running 2.6.0+ in order to have P2P-NCP
     which brings DATA_V2 packet support.
 
+Inline auth username and password
+    Username and password can now be specified inline in the configuration file
+    within the <auth-user-pass></auth-user-pass> tags.
+
 
 Deprecated features
 -------------------
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f3770477..f2db8dd9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -71,6 +71,7 @@ static const char *saved_pid_file_name; /* GLOBAL */
 #define CF_INIT_TLS_AUTH_STANDALONE (1<<2)
 
 static void do_init_first_time(struct context *c);
+
 static bool do_deferred_p2p_ncp(struct context *c);
 
 void
@@ -593,9 +594,12 @@ init_query_passwords(const struct context *c)
     if (c->options.auth_user_pass_file)
     {
 #ifdef ENABLE_MANAGEMENT
-        auth_user_pass_setup(c->options.auth_user_pass_file, &c->options.sc_info);
+        auth_user_pass_setup(c->options.auth_user_pass_file,
+                             c->options.auth_user_pass_file_inline,
+                             &c->options.sc_info);
 #else
-        auth_user_pass_setup(c->options.auth_user_pass_file, NULL);
+        auth_user_pass_setup(c->options.auth_user_pass_file,
+                             c->options.auth_user_pass_file_inline, NULL);
 #endif
     }
 }
@@ -3061,6 +3065,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.client_config_dir_exclusive = options->client_config_dir;
     }
     to.auth_user_pass_file = options->auth_user_pass_file;
+    to.auth_user_pass_file_inline = options->auth_user_pass_file_inline;
     to.auth_token_generate = options->auth_token_generate;
     to.auth_token_lifetime = options->auth_token_lifetime;
     to.auth_token_call_auth = options->auth_token_call_auth;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 765695da..2786c28b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1556,7 +1556,7 @@ show_p2mp_parms(const struct options *o)
 
     SHOW_BOOL(client);
     SHOW_BOOL(pull);
-    SHOW_STR(auth_user_pass_file);
+    SHOW_STR_INLINE(auth_user_pass_file);
 
     gc_free(&gc);
 }
@@ -4027,9 +4027,10 @@ options_postprocess_filechecks(struct options *options)
                               options->management_user_pass, R_OK,
                               "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
-    errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
-                              options->auth_user_pass_file, R_OK,
-                              "--auth-user-pass");
+    errs |= check_file_access_inline(options->auth_user_pass_file_inline,
+                                     CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
+                                     options->auth_user_pass_file, R_OK,
+                                     "--auth-user-pass");
     /* ** System related ** */
     errs |= check_file_access(CHKACC_FILE, options->chroot_dir,
                               R_OK|X_OK, "--chroot directory");
@@ -7705,10 +7706,11 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         if (p[1])
         {
             options->auth_user_pass_file = p[1];
+            options->auth_user_pass_file_inline = is_inline;
         }
         else
         {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5488db31..c9144154 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -523,6 +523,7 @@ struct options
     int push_continuation;
     unsigned int push_option_types_found;
     const char *auth_user_pass_file;
+    bool auth_user_pass_file_inline;
     struct options_pre_connect *pre_connect;
 
     int scheduled_exit_interval;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 15c8defc..b166da6d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -396,23 +396,32 @@ static char *auth_challenge; /* GLOBAL */
 #endif
 
 void
-auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sci)
+auth_user_pass_setup(const char *auth_file, bool is_inline,
+                     const struct static_challenge_info *sci)
 {
+    unsigned int flags = GET_USER_PASS_MANAGEMENT;
+
+    if (is_inline)
+    {
+        flags |= GET_USER_PASS_INLINE_CREDS;
+    }
+
     auth_user_pass_enabled = true;
     if (!auth_user_pass.defined && !auth_token.defined)
     {
 #ifdef ENABLE_MANAGEMENT
         if (auth_challenge) /* dynamic challenge/response */
         {
+            flags |= GET_USER_PASS_DYNAMIC_CHALLENGE;
             get_user_pass_cr(&auth_user_pass,
                              auth_file,
                              UP_TYPE_AUTH,
-                             GET_USER_PASS_MANAGEMENT|GET_USER_PASS_DYNAMIC_CHALLENGE,
+                             flags,
                              auth_challenge);
         }
         else if (sci) /* static challenge response */
         {
-            int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_STATIC_CHALLENGE;
+            flags |= GET_USER_PASS_STATIC_CHALLENGE;
             if (sci->flags & SC_ECHO)
             {
                 flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
@@ -425,7 +434,7 @@ auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *
         }
         else
 #endif /* ifdef ENABLE_MANAGEMENT */
-        get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT);
+        get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, flags);
     }
 }
 
@@ -2165,9 +2174,12 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
     if (auth_user_pass_enabled || (auth_token.token_defined && auth_token.defined))
     {
 #ifdef ENABLE_MANAGEMENT
-        auth_user_pass_setup(session->opt->auth_user_pass_file, session->opt->sci);
+        auth_user_pass_setup(session->opt->auth_user_pass_file,
+                             session->opt->auth_user_pass_file_inline,
+                             session->opt->sci);
 #else
-        auth_user_pass_setup(session->opt->auth_user_pass_file, NULL);
+        auth_user_pass_setup(session->opt->auth_user_pass_file,
+                             session->opt->auth_user_pass_file_inline, NULL);
 #endif
         struct user_pass *up = &auth_user_pass;
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ec0d2862..8a8a299f 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -367,9 +367,11 @@ void pem_password_setup(const char *auth_file);
 
 /*
  * Setup authentication username and password. If auth_file is given, use the
- * credentials stored in the file.
+ * credentials stored in the file, however, if is_inline is true then auth_file
+ * contains the username/password inline.
  */
-void auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sc_info);
+void auth_user_pass_setup(const char *auth_file, bool is_inline,
+                          const struct static_challenge_info *sc_info);
 
 /*
  * Ensure that no caching is performed on authentication information
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index bf3ac67a..eb91de15 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -366,6 +366,7 @@ struct tls_options
     bool auth_user_pass_verify_script_via_file;
     const char *tmp_dir;
     const char *auth_user_pass_file;
+    bool auth_user_pass_file_inline;
 
     bool auth_token_generate;   /**< Generate auth-tokens on successful
                                  * user/pass auth,seet via
-- 
2.35.1


