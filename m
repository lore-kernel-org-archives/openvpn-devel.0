Message-ID: <5252FB07.3070309@...1832...>
Date: Mon, 07 Oct 2013 20:18:47 +0200
From: Max Muster <Max.Muster@...1832...>
MIME-Version: 1.0
References: <go9r6cg1wcfh4lpwb9664gdd.1381086064578@...1753...>
In-Reply-To: <go9r6cg1wcfh4lpwb9664gdd.1381086064578@...1753...>
Content-Type: multipart/mixed; boundary="------------010107050804060203020906"
Subject: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010107050804060203020906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Davide,

I had some time today, so I did some changes ("improvements", I hope
;-)) to your code:

First thing you do in add_option() if inline is used: auth_pass_file is
set (to "stdin").
So there is no need to check for both (options->auth_user_pass_file ||
options->auth_user_pass_file_inline), the "existing" check only for
"options->auth_user_pass_file" will suffice. That simplifies the patch.

Fixed terminating the copy of the strings.

Simplify tests in options_postprocess_verify_ce():
Fist check if options->auth_user_pass_file is set (as above, it is
"allways" set in any auth_user_path case), then it is always safe to do
"streq" on options->auth_user_pass_file, too. 

Use existing file_check for inline files "CHKACC_INLINE" in
options_postprocess_filechecks()

In auth_user_pass_setup() don't change indents, only add "extra_flags"


Kind regards

Joerg


-------- Original-Nachricht --------
Betreff: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
Von: Davide Brini <dave_br@...1278...>
An: Max.Muster@...1832...
Kopie (CC): openvpn-devel@lists.sourceforge.net
Datum: So 06 Okt 2013 21:01:04 CEST
> Thanks for reporting! I have poor connectivity and little time this week, but I will look at it when I have a chance.
>
> Sent from mobile
>
> Max.Muster@...1832... wrote:
[... snip ...]


--------------010107050804060203020906
Content-Type: text/x-patch;
 name="010-inlined_auth_user_pass.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="010-inlined_auth_user_pass.patch"

--- src/openvpn/init.c
+++ src/openvpn/init.c
@@ -401,9 +401,9 @@
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
--- src/openvpn/misc.c
+++ src/openvpn/misc.c
@@ -1044,7 +1044,7 @@
 
   if (!up->defined)
     {
-      const bool from_stdin = (!auth_file || !strcmp (auth_file, "stdin"));
+      const bool from_stdin = (!auth_file || streq (auth_file, "stdin"));
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
--- src/openvpn/options.c
+++ src/openvpn/options.c
@@ -1221,6 +1221,7 @@
   SHOW_BOOL (client);
   SHOW_BOOL (pull);
   SHOW_STR (auth_user_pass_file);
+  SHOW_STR (auth_user_pass_file_inline);
 
   gc_free (&gc);
 }
@@ -2339,6 +2340,42 @@
 #if P2MP
   if (options->auth_user_pass_file && !options->pull)
     msg (M_USAGE, "--auth-user-pass requires --pull");
+  if (options->auth_user_pass_file)  /* no check needed if no auth_pass_file set. It is even set in case of inline (to "stdin") */
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
+
+    }
 #endif
 
   uninit_options (&defaults);
@@ -2706,7 +2743,7 @@
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_INLINE,
                              options->auth_user_pass_file, R_OK,
                              "--auth-user-pass");
 #endif /* P2MP */
@@ -5835,7 +5872,12 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[1])
 	{
-	  options->auth_user_pass_file = p[1];
+          options->auth_user_pass_file = p[1];
+          if (streq (p[1], INLINE_FILE_TAG) && p[2])
+            { msg (M_WARN, "options.c \n  !!!SETTING !!! \n_ +5930,12 @@ add_optio"); 
+              options->auth_user_pass_file = "stdin";
+              options->auth_user_pass_file_inline = p[2];
+            }
 	}
       else
 	options->auth_user_pass_file = "stdin";
@@ -6462,6 +6504,7 @@
   else if (streq (p[0], "auth-nocache"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->auth_nocache = true;
       ssl_set_auth_nocache ();
     }
   else if (streq (p[0], "auth-token") && p[1])
--- src/openvpn/options.h
+++ src/openvpn/options.h
@@ -290,6 +290,7 @@
   bool up_delay;
   bool up_restart;
   bool daemon;
+  bool auth_nocache;
 
   int remap_sigusr1;
 
@@ -459,6 +460,7 @@
   bool pull; /* client pull of config options from server */
   int push_continuation;
   const char *auth_user_pass_file;
+  const char *auth_user_pass_file_inline;
   struct options_pre_pull *pre_pull;
 
   int server_poll_timeout;
--- src/openvpn/ssl.c
+++ src/openvpn/ssl.c
@@ -357,11 +357,57 @@
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
 #if AUTO_USERID
       get_user_pass_auto_userid (&auth_user_pass, auth_file);
 #else
@@ -370,11 +416,11 @@
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
@@ -385,8 +431,11 @@
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
 
@@ -1872,9 +1921,9 @@
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
--- src/openvpn/ssl.h
+++ src/openvpn/ssl.h
@@ -388,7 +388,7 @@
  * Setup authentication username and password. If auth_file is given, use the
  * credentials stored in the file.
  */
-void auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sc_info);
+void auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sc_info);
 
 /*
  * Ensure that no caching is performed on authentication information

--------------010107050804060203020906--

