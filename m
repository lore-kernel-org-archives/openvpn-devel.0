From: Wayne Davison <wayne@...2099...>
Date: Tue,  8 Dec 2015 18:28:48 +0000
Message-Id: <1449599329-12968-2-git-send-email-wayne@...2099...>
In-Reply-To: <1449599329-12968-1-git-send-email-wayne@...2099...>
References: <1449599329-12968-1-git-send-email-wayne@...2099...>
Subject: [Openvpn-devel] [PATCH 1/2] Fix CR prompt with --auth-user-pass &
	support reading response.
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

Fixes a bug where there is no prompt for a dynamic (or static) challenge
response when combining "--auth-retry interact" (or --static-challenge)
with --auth-user-pass and the password is read from the file. It also
extends the reading from the file to allow a response to be provided on
the line after the password (which is nice for "push", "phone", etc.).

NOTE: indentation left too deep on one big section so that changes are
clearly seen.
---
 doc/openvpn.8      |  8 +++++++-
 src/openvpn/misc.c | 31 ++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 1b9dcae..ffe81c5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3800,7 +3800,13 @@ over the client's routing table.
 Authenticate with server using username/password.
 .B up
 is a file containing username/password on 2 lines. If the
-password line is missing, OpenVPN will prompt for one.
+password line is missing or empty, OpenVPN will prompt for one.
+The third line of the file can be used to enter a response to
+a challenge, such as "push", "phone", etc., which can be used
+to eliminate an extra prompt for an unchanging text if your
+challenge/response setup uses push/callback two-factor auth
+(and can be combined with an empty password line to still be
+prompted for your password).
 
 If
 .B up
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 5713d2e..a6915ac 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1038,6 +1038,10 @@ get_user_pass_cr (struct user_pass *up,
       bool from_authfile = (auth_file && !streq (auth_file, "stdin"));
       bool username_from_stdin = false;
       bool password_from_stdin = false;
+      bool response_from_stdin = false;
+#ifdef ENABLE_CLIENT_CR
+      char response_buf[USER_PASS_LEN] = { '\0' };
+#endif
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -1111,6 +1115,10 @@ get_user_pass_cr (struct user_pass *up,
           if (fgets (password_buf, USER_PASS_LEN, fp) != NULL)
             {
               chomp (password_buf);
+#ifdef ENABLE_CLIENT_CR
+              if (!(flags & GET_USER_PASS_PASSWORD_ONLY) && fgets (response_buf, USER_PASS_LEN, fp) != NULL)
+                chomp (response_buf);
+#endif
             }
 
           if (flags & GET_USER_PASS_PASSWORD_ONLY && !password_buf[0])
@@ -1119,7 +1127,7 @@ get_user_pass_cr (struct user_pass *up,
           if (password_buf[0])
             strncpy(up->password, password_buf, USER_PASS_LEN);
           else
-            password_from_stdin = 1;
+            password_from_stdin = true;
 
           fclose (fp);
 
@@ -1132,16 +1140,22 @@ get_user_pass_cr (struct user_pass *up,
           password_from_stdin = true;
         }
 
+#ifdef ENABLE_CLIENT_CR
+      if (auth_challenge && (flags & (GET_USER_PASS_DYNAMIC_CHALLENGE|GET_USER_PASS_STATIC_CHALLENGE)) && !response_buf[0])
+	response_from_stdin = true;
+#endif
+
       /*
        * Get username/password from standard input?
        */
-      if (username_from_stdin || password_from_stdin)
+      if (username_from_stdin || password_from_stdin || response_from_stdin)
 	{
 #ifndef WIN32
 	  /* did we --daemon'ize before asking for passwords? */
 	  if ( !isatty(0) && !isatty(2) )
 	    { msg(M_FATAL, "neither stdin nor stderr are a tty device, can't ask for %s password.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prefix ); }
 #endif
+	}
 
 #ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
@@ -1149,15 +1163,14 @@ get_user_pass_cr (struct user_pass *up,
 	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
 	      if (ac)
 		{
-		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
 		  struct buffer packed_resp;
 
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
 		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-		  if (!get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
+		  if (response_from_stdin && !get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response_buf, USER_PASS_LEN))
 		    msg (M_FATAL, "ERROR: could not read challenge response from stdin");
 		  strncpynt (up->username, ac->user, USER_PASS_LEN);
-		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
+		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response_buf);
 		}
 	      else
 		{
@@ -1187,15 +1200,16 @@ get_user_pass_cr (struct user_pass *up,
 #ifdef ENABLE_CLIENT_CR
 	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
 		{
-		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
 		  struct buffer packed_resp;
 		  char *pw64=NULL, *resp64=NULL;
 
 		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
-		  if (!get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response, USER_PASS_LEN))
+		  if (response_from_stdin && !get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response_buf, USER_PASS_LEN))
 		    msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
+                  else if (!response_from_stdin && (flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO))
+                    msg (M_INFO|M_NOPREFIX, "Response: %s", response_buf);
 		  if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
-		      || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
+		      || openvpn_base64_encode(response_buf, strlen(response_buf), &resp64) == -1)
 		    msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
 		  buf_printf (&packed_resp, "SCRV1:%s:%s", pw64, resp64);
@@ -1206,7 +1220,6 @@ get_user_pass_cr (struct user_pass *up,
 		}
 #endif
 	    }
-	}
 
       string_mod (up->username, CC_PRINT, CC_CRLF, 0);
       string_mod (up->password, CC_PRINT, CC_CRLF, 0);
-- 
1.9.1


