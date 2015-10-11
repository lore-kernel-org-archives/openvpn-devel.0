From: Adriaan de Jong <dejong@...1435...>
Date: Sun, 11 Oct 2015 11:52:17 +0200
Message-ID: <1444557137-19267-1-git-send-email-dejong@...1435...>
In-Reply-To: <1444553332-16205-1-git-send-email-dejong@...1435...>
References: <1444553332-16205-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@...350...

This patch allows inlining of the --auth-user-pass directive, so it is now
possible to do

<auth-user-pass>
myusername
mypassword
</auth-user-pass>

or supply just the username, eg

<auth-user-pass>
myusername
</auth-user-pass>

(in this case the user is prompted for the password only).
The most changed files are options.c (sanity check of inlined credentials)
and ssl.c (actual parsing of the inlined credentials).

Udates to the documentation will be provided in a separate patch if and when
the present patch is accepted.

As discussed on IRC, for the time being the non-inlined syntax

auth-user-pass [up]

is still supported and [up] is expected to contain username and password
on two lines.

Signed-off-by: Davide Brini <dave_br@...1278...>

Updated patch to current master, removed printing of the username/password.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 doc/openvpn.8            |  3 +--
 src/openvpn/init.c       |  5 ++--
 src/openvpn/misc.c       |  2 +-
 src/openvpn/options.c    | 45 +++++++++++++++++++++++++++++++++--
 src/openvpn/options.h    |  2 ++
 src/openvpn/ssl.c        | 61 +++++++++++++++++++++++++++++++++++++++++++-----
 src/openvpn/ssl.h        |  2 +-
 src/openvpn/ssl_common.h |  1 +
 8 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 829b09c..422b426 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6399,8 +6399,7 @@ X509_1_C=KG
 .SH INLINE FILE SUPPORT
 OpenVPN allows including files in the main configuration for the
 .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret
-and
-.B \-\-tls\-auth
+.B \-\-tls\-auth and \-\-auth-user-pass
 options.
 
 Each inline file started by the line
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c32a809..ade8cae 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -421,9 +421,9 @@ init_query_passwords (const struct context *c)
   if (c->options.auth_user_pass_file)
     {
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (c->options.auth_user_pass_file, &c->options.sc_info);
+      auth_user_pass_setup (c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline, &c->options.sc_info);
 #else
-      auth_user_pass_setup (c->options.auth_user_pass_file, NULL);
+      auth_user_pass_setup (c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline, NULL);
 #endif
     }
 #endif
@@ -2263,6 +2263,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   if (options->ccd_exclusive)
     to.client_config_dir_exclusive = options->client_config_dir;
   to.auth_user_pass_file = options->auth_user_pass_file;
+  to.auth_user_pass_file_inline = options->auth_user_pass_file_inline;
 #endif
 
 #ifdef ENABLE_X509_TRACK
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fd1930a..5158f66 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1003,7 +1003,7 @@ get_user_pass_cr (struct user_pass *up,
 
   if (!up->defined)
     {
-      const bool from_stdin = (!auth_file || !strcmp (auth_file, "stdin"));
+      const bool from_stdin = (!auth_file || streq (auth_file, "stdin"));
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7906f46..619a269 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2320,6 +2320,41 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #if P2MP
   if (options->auth_user_pass_file && !options->pull)
     msg (M_USAGE, "--auth-user-pass requires --pull");
+  if (options->auth_user_pass_file)
+    {
+      if ( (!streq(options->auth_user_pass_file, "stdin") || options->auth_user_pass_file_inline) && options->auth_nocache)
+        msg (M_USAGE, "Cannot use --auth-nocache with credentials from file");
+#ifdef ENABLE_CLIENT_CR
+      if ( (!streq(options->auth_user_pass_file, "stdin") || options->auth_user_pass_file_inline) && options->sc_info.challenge_text)
+        msg (M_USAGE, "Credentials cannot be in a file if using --static-challenge");
+#endif
+    }
+  if (options->auth_user_pass_file_inline)
+    {
+      int n_inlined = 0;
+      const char *pos = options->auth_user_pass_file_inline;
+      const char *prev = pos;
+
+      if ( strlen(pos) == 0 )
+        msg (M_USAGE, "Invalid format for inlined --auth-user-pass");
+
+      while( (pos = strchr(pos, '\n')) != NULL )
+        {
+          n_inlined++;
+
+          if (n_inlined > 2)
+            msg (M_USAGE, "Too many lines in inlined --auth-user-pass");
+
+          if ( pos - prev > USER_PASS_LEN - 1 )
+            msg (M_USAGE, "Line too long in inlined --auth-user-pass");
+
+          pos++;
+          prev = pos;
+        }
+
+      if ( (n_inlined == 0) || (*prev != '\0') )
+        msg (M_USAGE, "Invalid format for inlined --auth-user-pass");
+    }
 #endif
 
   uninit_options (&defaults);
@@ -2744,7 +2779,7 @@ options_postprocess_filechecks (struct options *options)
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_INLINE,
                              options->auth_user_pass_file, R_OK,
                              "--auth-user-pass");
 #endif /* P2MP */
@@ -5932,12 +5967,17 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->server_poll_timeout = positive_atoi(p[1]);
     }
-  else if (streq (p[0], "auth-user-pass") && !p[2])
+  else if (streq (p[0], "auth-user-pass") && p[1] && ((streq (p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[1])
 	{
 	  options->auth_user_pass_file = p[1];
+          if (streq (p[1], INLINE_FILE_TAG) && p[2])
+            {
+              options->auth_user_pass_file = "stdin";
+              options->auth_user_pass_file_inline = p[2];
+            }
 	}
       else
 	options->auth_user_pass_file = "stdin";
@@ -6665,6 +6705,7 @@ add_option (struct options *options,
   else if (streq (p[0], "auth-nocache") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->auth_nocache = true;
       ssl_set_auth_nocache ();
     }
   else if (streq (p[0], "auth-token") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c642aa0..903c663 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -292,6 +292,7 @@ struct options
   bool up_delay;
   bool up_restart;
   bool daemon;
+  bool auth_nocache;
 
   int remap_sigusr1;
 
@@ -457,6 +458,7 @@ struct options
   int push_continuation;
   unsigned int push_option_types_found;
   const char *auth_user_pass_file;
+  const char *auth_user_pass_file_inline;
   struct options_pre_pull *pre_pull;
 
   int server_poll_timeout;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 86eda77..7debaf8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -362,11 +362,57 @@ static char *auth_challenge; /* GLOBAL */
 #endif
 
 void
-auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sci)
+auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sci)
 {
+  int extra_flags = 0;
+  int n_inlined = 0;
+  char inlined_username[USER_PASS_LEN];
+  char inlined_password[USER_PASS_LEN];
+
   auth_user_pass_enabled = true;
+
   if (!auth_user_pass.defined)
     {
+      if (auth_file && streq (auth_file, "stdin") && auth_file_inline)
+        {
+          /* check how much is inlined. */
+          const char *pos = auth_file_inline;
+          const char *prev = pos;
+
+          while( (pos = strchr(pos, '\n')) != NULL)
+            {
+              n_inlined++;
+
+              if (n_inlined == 1)
+                {
+                  strncpy(inlined_username, prev, pos - prev);
+                  inlined_username[pos - prev] = '\0';
+                  msg (M_INFO, "Using inlined username: %s", inlined_username);
+                }
+              else
+                {
+                  strncpy(inlined_password, prev, pos - prev);
+                  inlined_password[pos - prev] = '\0';
+                  msg (M_INFO, "Using inlined password: ... ");
+                }
+
+              pos++;
+              prev = pos;
+            }
+
+          if (n_inlined == 1)
+            extra_flags = GET_USER_PASS_PASSWORD_ONLY;
+        }
+
+      if (n_inlined == 2)
+        {
+          strcpy(auth_user_pass.username, inlined_username);
+          strcpy(auth_user_pass.password, inlined_password);
+          auth_user_pass.defined = true;
+        }
+      else
+        {
+
 #if AUTO_USERID
       get_user_pass_auto_userid (&auth_user_pass, auth_file);
 #else
@@ -375,11 +421,11 @@ auth_user_pass_setup (const char *auth_file, const struct static_challenge_info
        get_user_pass_cr (&auth_user_pass,
                          auth_file,
                          UP_TYPE_AUTH,
-                         GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE,
+                         GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE|extra_flags,
                          auth_challenge);
       else if (sci) /* static challenge response */
        {
-         int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE;
+         int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE|extra_flags;
          if (sci->flags & SC_ECHO)
            flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
          get_user_pass_cr (&auth_user_pass,
@@ -390,8 +436,11 @@ auth_user_pass_setup (const char *auth_file, const struct static_challenge_info
        }
       else
 # endif
-       get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE);
+       get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|extra_flags);
 #endif
+        }
+        if (n_inlined == 1)
+          strcpy(auth_user_pass.username, inlined_username);
     }
 }
 
@@ -1925,9 +1974,9 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   if (auth_user_pass_enabled)
     {
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (session->opt->auth_user_pass_file, session->opt->sci);
+      auth_user_pass_setup (session->opt->auth_user_pass_file, session->opt->auth_user_pass_file_inline, session->opt->sci);
 #else
-      auth_user_pass_setup (session->opt->auth_user_pass_file, NULL);
+      auth_user_pass_setup (session->opt->auth_user_pass_file, session->opt->auth_user_pass_file_inline, NULL);
 #endif
       if (!write_string (buf, auth_user_pass.username, -1))
 	goto error;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 797c3e5..9473c35 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -389,7 +389,7 @@ void pem_password_setup (const char *auth_file);
  * Setup authentication username and password. If auth_file is given, use the
  * credentials stored in the file.
  */
-void auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sc_info);
+void auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sc_info);
 
 /*
  * Ensure that no caching is performed on authentication information
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 86e4ac8..01f7a30 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -278,6 +278,7 @@ struct tls_options
   bool auth_user_pass_verify_script_via_file;
   const char *tmp_dir;
   const char *auth_user_pass_file;
+  const char *auth_user_pass_file_inline;
 
   /* use the client-config-dir as a positive authenticator */
   const char *client_config_dir_exclusive;
-- 
2.1.4


