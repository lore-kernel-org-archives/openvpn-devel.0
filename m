From: Michal Ludvig <mludvig@...1388...>
Date: Tue, 16 Jul 2013 00:17:06 +1200
Message-Id: <1373890626-13943-1-git-send-email-mludvig@...1388...>
Subject: [Openvpn-devel] [PATCH] Support for username-only auth file.
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

Make OpenVPN read the username from the auth file
parameter of --auth-user-pass and prompt for a
password if it's not in the file.

Rationale: Prior to this change OpenVPN either
required both username and password present in the
auth file or prompted for both on the console.
Unlike passwords usernames usually don't change and
can therefore be "hardcoded" in the config.

Signed-off-by: Michal Ludvig <mludvig@...1388...>
---
 doc/openvpn.8         |   3 +-
 src/openvpn/misc.c    | 110 ++++++++++++++++++++++++++------------------------
 src/openvpn/options.c |   3 +-
 3 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f74fe81..7ea204d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3601,7 +3601,8 @@ over the client's routing table.
 .B \-\-auth-user-pass [up]
 Authenticate with server using username/password.
 .B up
-is a file containing username/password on 2 lines (Note: OpenVPN
+is a file containing username/password on 2 lines. If the
+password line is missing OpenVPN will prompt for one. (Note: OpenVPN
 will only read passwords from a file if it has been built
 with the \-\-enable-password-save configure option, or on Windows
 by defining ENABLE_PASSWORD_SAVE in win/settings.in).
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1120adc..0362d6c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1036,7 +1036,9 @@ get_user_pass_cr (struct user_pass *up,
 
   if (!up->defined)
     {
-      const bool from_stdin = (!auth_file || !strcmp (auth_file, "stdin"));
+      bool from_authfile = (auth_file && strcmp (auth_file, "stdin") != 0);
+      bool username_from_stdin = !from_authfile;
+      bool password_from_stdin = !from_authfile;
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -1046,7 +1048,7 @@ get_user_pass_cr (struct user_pass *up,
        * Get username/password from management interface?
        */
       if (management
-	  && ((auth_file && streq (auth_file, "management")) || (from_stdin && (flags & GET_USER_PASS_MANAGEMENT)))
+	  && ((auth_file && streq (auth_file, "management")) || (username_from_stdin && (flags & GET_USER_PASS_MANAGEMENT)))
 	  && management_query_user_pass_enabled (management))
 	{
 	  const char *sc = NULL;
@@ -1083,11 +1085,61 @@ get_user_pass_cr (struct user_pass *up,
 	  if (!strlen (up->password))
 	    strcpy (up->password, "ok");
 	}
-	  
+      else if (from_authfile)
+	{
+	  /*
+	   * Try to get username/password from a file.
+	   */
+	  FILE *fp;
+	  char password_buf[USER_PASS_LEN] = { '\0' };
+
+	  warn_if_group_others_accessible (auth_file);
+
+	  fp = platform_fopen (auth_file, "r");
+	  if (!fp)
+	    msg (M_ERR, "Error opening '%s' auth file: %s", prefix, auth_file);
+
+	  if ((flags & GET_USER_PASS_PASSWORD_ONLY) == 0)
+	    {
+	      /* Read username first */
+	      if (fgets (up->username, USER_PASS_LEN, fp) == NULL)
+		msg (M_FATAL, "Error reading username from %s authfile: %s",
+		     prefix,
+		     auth_file);
+	    }
+	  chomp (up->username);
+
+	  if (fgets (password_buf, USER_PASS_LEN, fp) != NULL)
+	    {
+#ifndef ENABLE_PASSWORD_SAVE
+	      /*
+	       * Unless ENABLE_PASSWORD_SAVE is defined, don't allow sensitive passwords
+	       * to be read from a file.
+	       */
+	      if (flags & GET_USER_PASS_SENSITIVE)
+	        msg (M_FATAL, "Sorry, '%s' password cannot be read from a file", prefix);
+#endif
+	      chomp (password_buf);
+	    }
+
+	  if (flags & GET_USER_PASS_PASSWORD_ONLY && !password_buf[0])
+		msg (M_FATAL, "Error reading password from %s authfile: %s", prefix, auth_file);
+
+	  if (password_buf[0])
+	    strncpy(up->password, password_buf, USER_PASS_LEN);
+	  else
+	    password_from_stdin = 1;
+
+	  fclose (fp);
+
+	  if (!(flags & GET_USER_PASS_PASSWORD_ONLY) && strlen (up->username) == 0)
+	    msg (M_FATAL, "ERROR: username from %s authfile '%s' is empty", prefix, auth_file);
+	}
+
       /*
        * Get username/password from standard input?
        */
-      else if (from_stdin)
+      if (username_from_stdin || password_from_stdin)
 	{
 #ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
@@ -1119,7 +1171,7 @@ get_user_pass_cr (struct user_pass *up,
 	      buf_printf (&user_prompt, "Enter %s Username:", prefix);
 	      buf_printf (&pass_prompt, "Enter %s Password:", prefix);
 
-	      if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
+	      if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
 		{
 		  if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
 		    msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
@@ -1127,7 +1179,7 @@ get_user_pass_cr (struct user_pass *up,
 		    msg (M_FATAL, "ERROR: %s username is empty", prefix);
 		}
 
-	      if (!get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
+	      if (password_from_stdin && !get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
 		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
 
 #ifdef ENABLE_CLIENT_CR
@@ -1153,52 +1205,6 @@ get_user_pass_cr (struct user_pass *up,
 #endif
 	    }
 	}
-      else
-	{
-	  /*
-	   * Get username/password from a file.
-	   */
-	  FILE *fp;
-      
-#ifndef ENABLE_PASSWORD_SAVE
-	  /*
-	   * Unless ENABLE_PASSWORD_SAVE is defined, don't allow sensitive passwords
-	   * to be read from a file.
-	   */
-	  if (flags & GET_USER_PASS_SENSITIVE)
-	    msg (M_FATAL, "Sorry, '%s' password cannot be read from a file", prefix);
-#endif
-
-	  warn_if_group_others_accessible (auth_file);
-
-	  fp = platform_fopen (auth_file, "r");
-	  if (!fp)
-	    msg (M_ERR, "Error opening '%s' auth file: %s", prefix, auth_file);
-
-	  if (flags & GET_USER_PASS_PASSWORD_ONLY)
-	    {
-	      if (fgets (up->password, USER_PASS_LEN, fp) == NULL)
-		msg (M_FATAL, "Error reading password from %s authfile: %s",
-		     prefix,
-		     auth_file);
-	    }
-	  else
-	    {
-	      if (fgets (up->username, USER_PASS_LEN, fp) == NULL
-		  || fgets (up->password, USER_PASS_LEN, fp) == NULL)
-		msg (M_FATAL, "Error reading username and password (must be on two consecutive lines) from %s authfile: %s",
-		     prefix,
-		     auth_file);
-	    }
-      
-	  fclose (fp);
-      
-	  chomp (up->username);
-	  chomp (up->password);
-      
-	  if (!(flags & GET_USER_PASS_PASSWORD_ONLY) && strlen (up->username) == 0)
-	    msg (M_FATAL, "ERROR: username from %s authfile '%s' is empty", prefix, auth_file);
-	}
 
       string_mod (up->username, CC_PRINT, CC_CRLF, 0);
       string_mod (up->password, CC_PRINT, CC_CRLF, 0);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2191916..dc445dd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -495,7 +495,8 @@ static const char usage_message[] =
   "--client         : Helper option to easily configure client mode.\n"
   "--auth-user-pass [up] : Authenticate with server using username/password.\n"
   "                  up is a file containing username/password on 2 lines,\n"
-  "                  or omit to prompt from console.\n"
+  "                  or provide only username on one line and be prompted\n"
+  "                  for password or omit to prompt for both from console.\n"
   "--pull           : Accept certain config file options from the peer as if they\n"
   "                  were part of the local config file.  Must be specified\n"
   "                  when connecting to a '--mode server' remote host.\n"
-- 
1.8.1.4


