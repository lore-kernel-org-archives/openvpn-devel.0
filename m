From: Wayne Davison <wayne@...2099...>
Date: Tue,  8 Dec 2015 18:28:49 +0000
Message-Id: <1449599329-12968-3-git-send-email-wayne@...2099...>
In-Reply-To: <1449599329-12968-1-git-send-email-wayne@...2099...>
References: <1449599329-12968-1-git-send-email-wayne@...2099...>
Subject: [Openvpn-devel] [PATCH 2/2] Fix indentation of just-tweaked section
	plus an off-by-one section.
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
 src/openvpn/misc.c | 120 ++++++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a6915ac..af64cb0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1105,11 +1105,11 @@ get_user_pass_cr (struct user_pass *up,
           if ((flags & GET_USER_PASS_PASSWORD_ONLY) == 0)
             {
               /* Read username first */
-               if (fgets (up->username, USER_PASS_LEN, fp) == NULL)
-                 msg (M_FATAL, "Error reading username from %s authfile: %s",
-                      prefix,
-                      auth_file);
-             }
+              if (fgets (up->username, USER_PASS_LEN, fp) == NULL)
+                msg (M_FATAL, "Error reading username from %s authfile: %s",
+                     prefix,
+                     auth_file);
+            }
           chomp (up->username);
 
           if (fgets (password_buf, USER_PASS_LEN, fp) != NULL)
@@ -1158,68 +1158,68 @@ get_user_pass_cr (struct user_pass *up,
 	}
 
 #ifdef ENABLE_CLIENT_CR
-	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
-	    {
-	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
-	      if (ac)
-		{
-		  struct buffer packed_resp;
-
-		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-		  if (response_from_stdin && !get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response_buf, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read challenge response from stdin");
-		  strncpynt (up->username, ac->user, USER_PASS_LEN);
-		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response_buf);
-		}
-	      else
-		{
-		  msg (M_FATAL, "ERROR: received malformed challenge request from server");
-		}
-	    }
-	  else
+      if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
+        {
+          struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
+          if (ac)
+            {
+              struct buffer packed_resp;
+
+              buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
+              msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
+              if (response_from_stdin && !get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response_buf, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not read challenge response from stdin");
+              strncpynt (up->username, ac->user, USER_PASS_LEN);
+              buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response_buf);
+            }
+          else
+            {
+              msg (M_FATAL, "ERROR: received malformed challenge request from server");
+            }
+        }
+      else
 #endif
-	    {
-	      struct buffer user_prompt = alloc_buf_gc (128, &gc);
-	      struct buffer pass_prompt = alloc_buf_gc (128, &gc);
+        {
+          struct buffer user_prompt = alloc_buf_gc (128, &gc);
+          struct buffer pass_prompt = alloc_buf_gc (128, &gc);
 
-	      buf_printf (&user_prompt, "Enter %s Username:", prefix);
-	      buf_printf (&pass_prompt, "Enter %s Password:", prefix);
+          buf_printf (&user_prompt, "Enter %s Username:", prefix);
+          buf_printf (&pass_prompt, "Enter %s Password:", prefix);
 
-	      if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
-		{
-		  if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
-		  if (strlen (up->username) == 0)
-		    msg (M_FATAL, "ERROR: %s username is empty", prefix);
-		}
+          if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
+            {
+              if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
+              if (strlen (up->username) == 0)
+                msg (M_FATAL, "ERROR: %s username is empty", prefix);
+            }
 
-	      if (password_from_stdin && !get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
-		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
+          if (password_from_stdin && !get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
+            msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
 
 #ifdef ENABLE_CLIENT_CR
-	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
-		{
-		  struct buffer packed_resp;
-		  char *pw64=NULL, *resp64=NULL;
-
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
-		  if (response_from_stdin && !get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response_buf, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
-                  else if (!response_from_stdin && (flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO))
-                    msg (M_INFO|M_NOPREFIX, "Response: %s", response_buf);
-		  if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
-		      || openvpn_base64_encode(response_buf, strlen(response_buf), &resp64) == -1)
-		    msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
-		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
-		  buf_printf (&packed_resp, "SCRV1:%s:%s", pw64, resp64);
-		  string_clear(pw64);
-		  free(pw64);
-		  string_clear(resp64);
-		  free(resp64);
-		}
+          if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
+            {
+              struct buffer packed_resp;
+              char *pw64=NULL, *resp64=NULL;
+
+              msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
+              if (response_from_stdin && !get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response_buf, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
+              else if (!response_from_stdin && (flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO))
+                msg (M_INFO|M_NOPREFIX, "Response: %s", response_buf);
+              if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
+                  || openvpn_base64_encode(response_buf, strlen(response_buf), &resp64) == -1)
+                msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
+              buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
+              buf_printf (&packed_resp, "SCRV1:%s:%s", pw64, resp64);
+              string_clear(pw64);
+              free(pw64);
+              string_clear(resp64);
+              free(resp64);
+            }
 #endif
-	    }
+        }
 
       string_mod (up->username, CC_PRINT, CC_CRLF, 0);
       string_mod (up->password, CC_PRINT, CC_CRLF, 0);
-- 
1.9.1


