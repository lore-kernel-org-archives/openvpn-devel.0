Date: Wed, 2 Oct 2013 22:49:46 +0200
From: Davide Brini <dave_br@...1278...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/zFKiEXIsLVrR9YT9Zf/dbJJ"
Message-ID: <0MAQ0o-1VYfA02dyM-00BYQL@...1825...>
Subject: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--MP_/zFKiEXIsLVrR9YT9Zf/dbJJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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
---
 src/openvpn/init.c    |    9 +++--
 src/openvpn/misc.c    |    2 +-
 src/openvpn/options.c |   56 ++++++++++++++++++++++++----
 src/openvpn/options.h |    2 +
 src/openvpn/ssl.c     |   98 +++++++++++++++++++++++++++++++++++++------------
 src/openvpn/ssl.h     |    2 +-
 6 files changed, 134 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 031fb20..1ec2d6e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -400,12 +400,15 @@ init_query_passwords (struct context *c)
   
 #if P2MP
   /* Auth user/pass input */
-  if (c->options.auth_user_pass_file)
+  if (c->options.auth_user_pass_file || c->options.auth_user_pass_file_inline)
     {
+
+     printf("---------- init_query_passwords\n");
+
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (c->options.auth_user_pass_file, &c->options.sc_info);
+      auth_user_pass_setup (c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline, &c->options.sc_info);
 #else
-      auth_user_pass_setup (c->options.auth_user_pass_file, NULL);
+      auth_user_pass_setup (c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline, NULL);
 #endif
     }
 #endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4688444..05bc2f0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1036,7 +1036,7 @@ get_user_pass_cr (struct user_pass *up,
 
   if (!up->defined)
     {
-      const bool from_stdin = (!auth_file || !strcmp (auth_file, "stdin"));
+      const bool from_stdin = (!auth_file || streq (auth_file, "stdin"));
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d0271f..6f2ea66 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1233,6 +1233,7 @@ show_p2mp_parms (const struct options *o)
   SHOW_BOOL (client);
   SHOW_BOOL (pull);
   SHOW_STR (auth_user_pass_file);
+  SHOW_STR (auth_user_pass_file_inline);
 
   gc_free (&gc);
 }
@@ -2080,7 +2081,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->ifconfig_ipv6_local && !options->tun_ipv6 )
 	msg (M_INFO, "Warning: --ifconfig-ipv6 without --tun-ipv6 will not do IPv6");
 
-      if (options->auth_user_pass_file)
+      if ( options->auth_user_pass_file || options->auth_user_pass_file_inline )
 	msg (M_USAGE, "--auth-user-pass cannot be used with --mode server (it should be used on the client side only)");
       if (options->ccd_exclusive && !options->client_config_dir)
 	msg (M_USAGE, "--ccd-exclusive must be used with --client-config-dir");
@@ -2274,7 +2275,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	      if (sum == 0)
 		{
 #if P2MP
-		  if (!options->auth_user_pass_file)
+		  if (!options->auth_user_pass_file && !options->auth_user_pass_file_inline)
 #endif
 		    msg (M_USAGE, "No client-side authentication method is specified.  You must use either --cert/--key, --pkcs12, or --auth-user-pass");
 		}
@@ -2350,8 +2351,42 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #endif /* ENABLE_SSL */
 
 #if P2MP
-  if (options->auth_user_pass_file && !options->pull)
+  if ( ( options->auth_user_pass_file || options->auth_user_pass_file_inline) && !options->pull)
     msg (M_USAGE, "--auth-user-pass requires --pull");
+
+  if ( ( !streq(options->auth_user_pass_file, "stdin") || options->auth_user_pass_file_inline) && options->auth_nocache)
+    msg (M_USAGE, "Cannot use --auth-nocache with credentials from file");
+
+  if ( ( !streq(options->auth_user_pass_file, "stdin") || options->auth_user_pass_file_inline) && options->sc_info.challenge_text)
+    msg (M_USAGE, "Credentials cannot be in a file if using --static-challenge");
+
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
+
+    }
 #endif
 
   uninit_options (&defaults);
@@ -2719,9 +2754,10 @@ options_postprocess_filechecks (struct options *options)
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
-                             options->auth_user_pass_file, R_OK,
-                             "--auth-user-pass");
+  if (!streq(options->auth_user_pass_file, INLINE_FILE_TAG))
+    errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+                               options->auth_user_pass_file, R_OK,
+                               "--auth-user-pass");
 #endif /* P2MP */
 
   /* ** System related ** */
@@ -5894,7 +5930,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[1])
 	{
-	  options->auth_user_pass_file = p[1];
+          options->auth_user_pass_file = p[1];
+          if (streq (p[1], INLINE_FILE_TAG) && p[2])
+            {
+              options->auth_user_pass_file = "stdin";
+              options->auth_user_pass_file_inline = p[2];
+            }
 	}
       else
 	options->auth_user_pass_file = "stdin";
@@ -6591,6 +6632,7 @@ add_option (struct options *options,
   else if (streq (p[0], "auth-nocache"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->auth_nocache = true;
       ssl_set_auth_nocache ();
     }
   else if (streq (p[0], "auth-token") && p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 8e0e367..5ae733a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -292,6 +292,7 @@ struct options
   bool up_delay;
   bool up_restart;
   bool daemon;
+  bool auth_nocache;
 
   int remap_sigusr1;
 
@@ -460,6 +461,7 @@ struct options
   bool pull; /* client pull of config options from server */
   int push_continuation;
   const char *auth_user_pass_file;
+  const char *auth_user_pass_file_inline;
   struct options_pre_pull *pre_pull;
 
   int server_poll_timeout;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69f77f3..aa249f1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -354,36 +354,88 @@ static char *auth_challenge; /* GLOBAL */
 #endif
 
 void
-auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sci)
+auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sci)
 {
+
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
+                  inlined_username[pos - prev + 1] = '\0';
+                  msg (M_INFO, "Using inlined username: %s", inlined_username);
+                }
+              else
+                {
+                  strncpy(inlined_password, prev, pos - prev);
+                  inlined_password[pos - prev + 1] = '\0';
+                  msg (M_INFO, "Using inlined password: ...");
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
 #if AUTO_USERID
-      get_user_pass_auto_userid (&auth_user_pass, auth_file);
+          get_user_pass_auto_userid (&auth_user_pass, auth_file);
 #else
 # ifdef ENABLE_CLIENT_CR
-      if (auth_challenge) /* dynamic challenge/response */
-       get_user_pass_cr (&auth_user_pass,
-                         auth_file,
-                         UP_TYPE_AUTH,
-                         GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE,
-                         auth_challenge);
-      else if (sci) /* static challenge response */
-       {
-         int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE;
-         if (sci->flags & SC_ECHO)
-           flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
-         get_user_pass_cr (&auth_user_pass,
-                           auth_file,
-                           UP_TYPE_AUTH,
-                           flags,
-                           sci->challenge_text);
-       }
-      else
+          if (auth_challenge) /* dynamic challenge/response */
+            get_user_pass_cr (&auth_user_pass,
+                              auth_file,
+                              UP_TYPE_AUTH,
+                              GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE|extra_flags,
+                              auth_challenge);
+          else if (sci) /* static challenge response */
+            {
+              int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE|extra_flags;
+              if (sci->flags & SC_ECHO)
+                flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
+
+              get_user_pass_cr (&auth_user_pass,
+                                auth_file,
+                                UP_TYPE_AUTH,
+                                flags,
+                                sci->challenge_text);
+            }
+          else
 # endif
-       get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE);
+            get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|extra_flags);
 #endif
+        }
+
+        if (n_inlined == 1)
+          strcpy(auth_user_pass.username, inlined_username);
+ 
     }
 }
 
@@ -1892,9 +1944,9 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   if (auth_user_pass_enabled)
     {
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (NULL, session->opt->sci);
+      auth_user_pass_setup (NULL, NULL, session->opt->sci);
 #else
-      auth_user_pass_setup (NULL, NULL);
+      auth_user_pass_setup (NULL, NULL, NULL);
 #endif
       if (!write_string (buf, auth_user_pass.username, -1))
 	goto error;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cd7cae2..c7554aa 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -388,7 +388,7 @@ void pem_password_setup (const char *auth_file);
  * Setup authentication username and password. If auth_file is given, use the
  * credentials stored in the file.
  */
-void auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sc_info);
+void auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sc_info);
 
 /*
  * Ensure that no caching is performed on authentication information
--
1.7.10.4
--MP_/zFKiEXIsLVrR9YT9Zf/dbJJ
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=inlined_auth_user_pass.patch

 src/openvpn/init.c    |    9 +++--
 src/openvpn/misc.c    |    2 +-
 src/openvpn/options.c |   56 ++++++++++++++++++++++++----
 src/openvpn/options.h |    2 +
 src/openvpn/ssl.c     |   98 +++++++++++++++++++++++++++++++++++++------------
 src/openvpn/ssl.h     |    2 +-
 6 files changed, 134 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 031fb20..1ec2d6e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -400,12 +400,15 @@ init_query_passwords (struct context *c)
   
 #if P2MP
   /* Auth user/pass input */
-  if (c->options.auth_user_pass_file)
+  if (c->options.auth_user_pass_file || c->options.auth_user_pass_file_inline)
     {
+
+     printf("---------- init_query_passwords\n");
+
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (c->options.auth_user_pass_file, &c->options.sc_info);
+      auth_user_pass_setup (c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline, &c->options.sc_info);
 #else
-      auth_user_pass_setup (c->options.auth_user_pass_file, NULL);
+      auth_user_pass_setup (c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline, NULL);
 #endif
     }
 #endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4688444..05bc2f0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1036,7 +1036,7 @@ get_user_pass_cr (struct user_pass *up,
 
   if (!up->defined)
     {
-      const bool from_stdin = (!auth_file || !strcmp (auth_file, "stdin"));
+      const bool from_stdin = (!auth_file || streq (auth_file, "stdin"));
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d0271f..6f2ea66 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1233,6 +1233,7 @@ show_p2mp_parms (const struct options *o)
   SHOW_BOOL (client);
   SHOW_BOOL (pull);
   SHOW_STR (auth_user_pass_file);
+  SHOW_STR (auth_user_pass_file_inline);
 
   gc_free (&gc);
 }
@@ -2080,7 +2081,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->ifconfig_ipv6_local && !options->tun_ipv6 )
 	msg (M_INFO, "Warning: --ifconfig-ipv6 without --tun-ipv6 will not do IPv6");
 
-      if (options->auth_user_pass_file)
+      if ( options->auth_user_pass_file || options->auth_user_pass_file_inline )
 	msg (M_USAGE, "--auth-user-pass cannot be used with --mode server (it should be used on the client side only)");
       if (options->ccd_exclusive && !options->client_config_dir)
 	msg (M_USAGE, "--ccd-exclusive must be used with --client-config-dir");
@@ -2274,7 +2275,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	      if (sum == 0)
 		{
 #if P2MP
-		  if (!options->auth_user_pass_file)
+		  if (!options->auth_user_pass_file && !options->auth_user_pass_file_inline)
 #endif
 		    msg (M_USAGE, "No client-side authentication method is specified.  You must use either --cert/--key, --pkcs12, or --auth-user-pass");
 		}
@@ -2350,8 +2351,42 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #endif /* ENABLE_SSL */
 
 #if P2MP
-  if (options->auth_user_pass_file && !options->pull)
+  if ( ( options->auth_user_pass_file || options->auth_user_pass_file_inline) && !options->pull)
     msg (M_USAGE, "--auth-user-pass requires --pull");
+
+  if ( ( !streq(options->auth_user_pass_file, "stdin") || options->auth_user_pass_file_inline) && options->auth_nocache)
+    msg (M_USAGE, "Cannot use --auth-nocache with credentials from file");
+
+  if ( ( !streq(options->auth_user_pass_file, "stdin") || options->auth_user_pass_file_inline) && options->sc_info.challenge_text)
+    msg (M_USAGE, "Credentials cannot be in a file if using --static-challenge");
+
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
+
+    }
 #endif
 
   uninit_options (&defaults);
@@ -2719,9 +2754,10 @@ options_postprocess_filechecks (struct options *options)
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
-                             options->auth_user_pass_file, R_OK,
-                             "--auth-user-pass");
+  if (!streq(options->auth_user_pass_file, INLINE_FILE_TAG))
+    errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+                               options->auth_user_pass_file, R_OK,
+                               "--auth-user-pass");
 #endif /* P2MP */
 
   /* ** System related ** */
@@ -5894,7 +5930,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[1])
 	{
-	  options->auth_user_pass_file = p[1];
+          options->auth_user_pass_file = p[1];
+          if (streq (p[1], INLINE_FILE_TAG) && p[2])
+            {
+              options->auth_user_pass_file = "stdin";
+              options->auth_user_pass_file_inline = p[2];
+            }
 	}
       else
 	options->auth_user_pass_file = "stdin";
@@ -6591,6 +6632,7 @@ add_option (struct options *options,
   else if (streq (p[0], "auth-nocache"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->auth_nocache = true;
       ssl_set_auth_nocache ();
     }
   else if (streq (p[0], "auth-token") && p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 8e0e367..5ae733a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -292,6 +292,7 @@ struct options
   bool up_delay;
   bool up_restart;
   bool daemon;
+  bool auth_nocache;
 
   int remap_sigusr1;
 
@@ -460,6 +461,7 @@ struct options
   bool pull; /* client pull of config options from server */
   int push_continuation;
   const char *auth_user_pass_file;
+  const char *auth_user_pass_file_inline;
   struct options_pre_pull *pre_pull;
 
   int server_poll_timeout;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69f77f3..aa249f1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -354,36 +354,88 @@ static char *auth_challenge; /* GLOBAL */
 #endif
 
 void
-auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sci)
+auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sci)
 {
+
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
+                  inlined_username[pos - prev + 1] = '\0';
+                  msg (M_INFO, "Using inlined username: %s", inlined_username);
+                }
+              else
+                {
+                  strncpy(inlined_password, prev, pos - prev);
+                  inlined_password[pos - prev + 1] = '\0';
+                  msg (M_INFO, "Using inlined password: ...");
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
 #if AUTO_USERID
-      get_user_pass_auto_userid (&auth_user_pass, auth_file);
+          get_user_pass_auto_userid (&auth_user_pass, auth_file);
 #else
 # ifdef ENABLE_CLIENT_CR
-      if (auth_challenge) /* dynamic challenge/response */
-       get_user_pass_cr (&auth_user_pass,
-                         auth_file,
-                         UP_TYPE_AUTH,
-                         GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE,
-                         auth_challenge);
-      else if (sci) /* static challenge response */
-       {
-         int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE;
-         if (sci->flags & SC_ECHO)
-           flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
-         get_user_pass_cr (&auth_user_pass,
-                           auth_file,
-                           UP_TYPE_AUTH,
-                           flags,
-                           sci->challenge_text);
-       }
-      else
+          if (auth_challenge) /* dynamic challenge/response */
+            get_user_pass_cr (&auth_user_pass,
+                              auth_file,
+                              UP_TYPE_AUTH,
+                              GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_DYNAMIC_CHALLENGE|extra_flags,
+                              auth_challenge);
+          else if (sci) /* static challenge response */
+            {
+              int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|GET_USER_PASS_STATIC_CHALLENGE|extra_flags;
+              if (sci->flags & SC_ECHO)
+                flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
+
+              get_user_pass_cr (&auth_user_pass,
+                                auth_file,
+                                UP_TYPE_AUTH,
+                                flags,
+                                sci->challenge_text);
+            }
+          else
 # endif
-       get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE);
+            get_user_pass (&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_SENSITIVE|extra_flags);
 #endif
+        }
+
+        if (n_inlined == 1)
+          strcpy(auth_user_pass.username, inlined_username);
+ 
     }
 }
 
@@ -1892,9 +1944,9 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   if (auth_user_pass_enabled)
     {
 #ifdef ENABLE_CLIENT_CR
-      auth_user_pass_setup (NULL, session->opt->sci);
+      auth_user_pass_setup (NULL, NULL, session->opt->sci);
 #else
-      auth_user_pass_setup (NULL, NULL);
+      auth_user_pass_setup (NULL, NULL, NULL);
 #endif
       if (!write_string (buf, auth_user_pass.username, -1))
 	goto error;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cd7cae2..c7554aa 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -388,7 +388,7 @@ void pem_password_setup (const char *auth_file);
  * Setup authentication username and password. If auth_file is given, use the
  * credentials stored in the file.
  */
-void auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sc_info);
+void auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sc_info);
 
 /*
  * Ensure that no caching is performed on authentication information

--MP_/zFKiEXIsLVrR9YT9Zf/dbJJ--

