From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Dec 2015 13:36:58 +0100
Message-Id: <1449751018-10634-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Replace ENABLE_CLIENT_CR with
	ENABLE_MANAGMENT with unconditionally enables it
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
To: openvpn-devel@lists.sourceforge.net

---
 src/openvpn/init.c       | 4 ++--
 src/openvpn/manage.c     | 5 +----
 src/openvpn/misc.c       | 9 ++++-----
 src/openvpn/misc.h       | 2 +-
 src/openvpn/options.c    | 2 --
 src/openvpn/options.h    | 2 +-
 src/openvpn/push.c       | 5 ++---
 src/openvpn/ssl.c        | 8 ++++----
 src/openvpn/ssl.h        | 2 +-
 src/openvpn/ssl_common.h | 2 +-
 src/openvpn/syshead.h    | 7 -------
 11 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7dfc4aa..b9a9075 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -421,7 +421,7 @@ init_query_passwords (const struct context *c)
   /* Auth user/pass input */
   if (c->options.auth_user_pass_file)
     {
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
       auth_user_pass_setup (c->options.auth_user_pass_file, &c->options.sc_info);
 #else
       auth_user_pass_setup (c->options.auth_user_pass_file, NULL);
@@ -2305,7 +2305,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 #endif
 
 #if P2MP
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
   to.sci = &options->sc_info;
 #endif
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index dcb1bc1..891a498 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3056,9 +3056,8 @@ management_query_user_pass (struct management *man,
       const char *alert_type = NULL;
       const char *prefix = NULL;
       unsigned int up_query_mode = 0;
-#ifdef ENABLE_CLIENT_CR
       const char *sc = NULL;
-#endif
+
       ret = true;
       man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
       man->persist.special_state_msg = NULL;
@@ -3088,10 +3087,8 @@ management_query_user_pass (struct management *man,
 	  up_query_mode = UP_QUERY_USER_PASS;
 	  prefix = "PASSWORD";
 	  alert_type = "username/password";
-#ifdef ENABLE_CLIENT_CR
 	  if (static_challenge)
 	    sc = static_challenge;
-#endif
 	}
       buf_printf (&alert_msg, ">%s:Need '%s' %s",
 		  prefix,
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 5713d2e..52ef81a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1055,10 +1055,9 @@ get_user_pass_cr (struct user_pass *up,
 	  if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	    management_auth_failure (management, prefix, "previous auth credentials failed");
 
-#ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
 	    sc = auth_challenge;
-#endif
+
 	  if (!management_query_user_pass (management, up, prefix, flags, sc))
 	    {
 	      if ((flags & GET_USER_PASS_NOFATAL) != 0)
@@ -1143,7 +1142,7 @@ get_user_pass_cr (struct user_pass *up,
 	    { msg(M_FATAL, "neither stdin nor stderr are a tty device, can't ask for %s password.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prefix ); }
 #endif
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
 	    {
 	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
@@ -1184,7 +1183,7 @@ get_user_pass_cr (struct user_pass *up,
 	      if (password_from_stdin && !get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
 		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
 		{
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
@@ -1223,7 +1222,7 @@ get_user_pass_cr (struct user_pass *up,
   return true;
 }
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 
 /*
  * See management/management-notes.txt for more info on the
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index dbe899e..5b853fa 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -207,7 +207,7 @@ struct user_pass
   char password[USER_PASS_LEN];
 };
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 /*
  * Challenge response info on client as pushed by server.
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9481610..4347525 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5960,7 +5960,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       auth_retry_set (msglevel, p[1]);
     }
-#ifdef ENABLE_CLIENT_CR
   else if (streq (p[0], "static-challenge") && p[1] && p[2] && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -5969,7 +5968,6 @@ add_option (struct options *options,
 	options->sc_info.flags |= SC_ECHO;
     }
 #endif
-#endif
 #ifdef WIN32
   else if (streq (p[0], "win-sys") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 30b995d..7e2d9f3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -458,7 +458,7 @@ struct options
 
   int scheduled_exit_interval;
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
   struct static_challenge_info sc_info;
 #endif
 #endif
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d4f3cb6..a691984 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -76,10 +76,9 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	  if (buf_string_compare_advance (&buf, "AUTH_FAILED,") && BLEN (&buf))
 	    reason = BSTR (&buf);
 	  management_auth_failure (management, UP_TYPE_AUTH, reason);
-	} else
-#endif
+	}
+      else
 	{
-#ifdef ENABLE_CLIENT_CR
 	  struct buffer buf = *buffer;
 	  if (buf_string_match_head_str (&buf, "AUTH_FAILED,CRV1:") && BLEN (&buf))
 	    {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 887bd75..b6ca098 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -357,7 +357,7 @@ pem_password_callback (char *buf, int size, int rwflag, void *u)
 static bool auth_user_pass_enabled;     /* GLOBAL */
 static struct user_pass auth_user_pass; /* GLOBAL */
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 static char *auth_challenge; /* GLOBAL */
 #endif
 
@@ -370,7 +370,7 @@ auth_user_pass_setup (const char *auth_file, const struct static_challenge_info
 #if AUTO_USERID
       get_user_pass_auto_userid (&auth_user_pass, auth_file);
 #else
-# ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
       if (auth_challenge) /* dynamic challenge/response */
        get_user_pass_cr (&auth_user_pass,
                          auth_file,
@@ -428,12 +428,12 @@ ssl_purge_auth (const bool auth_user_pass_only)
       purge_user_pass (&passbuf, true);
     }
   purge_user_pass (&auth_user_pass, true);
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
   ssl_purge_auth_challenge();
 #endif
 }
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 
 void
 ssl_purge_auth_challenge (void)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 797c3e5..1bea04c 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -404,7 +404,7 @@ void ssl_purge_auth (const bool auth_user_pass_only);
 
 void ssl_set_auth_token (const char *token);
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
 /*
  * ssl_get_auth_challenge will parse the server-pushed auth-failed
  * reason string and return a dynamically allocated
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e2b0ebf..b74f32a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -312,7 +312,7 @@ struct tls_options
   const struct x509_track *x509_track;
 #endif
 
-#ifdef ENABLE_CLIENT_CR
+#ifdef ENABLE_MANAGEMENT
   const struct static_challenge_info *sci;
 #endif
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 7e77b6c..9e1bd05 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -694,13 +694,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Do we support challenge/response authentication as client?
- */
-#if defined(ENABLE_MANAGEMENT)
-#define ENABLE_CLIENT_CR
-#endif
-
-/*
  * Do we support pushing peer info?
  */
 #if defined(ENABLE_CRYPTO)
-- 
2.5.4 (Apple Git-61)


