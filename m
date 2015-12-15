From: Wayne Davison <wayne@...2099...>
Date: Tue, 15 Dec 2015 22:16:33 +0000
Message-Id: <1450217793-17974-3-git-send-email-wayne@...2099...>
In-Reply-To: <1450217793-17974-1-git-send-email-wayne@...2099...>
References: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
	<1450217793-17974-1-git-send-email-wayne@...2099...>
Subject: [Openvpn-devel] [PATCH 3/3] Fix too-deep indentation.
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

Fix the indentation on the code block that got moved out of an unneeded
"if".
---
 src/openvpn/misc.c | 116 ++++++++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index e0aa5f9..517a2eb 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1142,69 +1142,69 @@ get_user_pass_cr (struct user_pass *up,
        * Get username/password from standard input?
        */
 #ifdef ENABLE_CLIENT_CR
-	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
-	    {
-	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
-	      if (ac)
-		{
-		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
-
-		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-		  if (!get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read challenge response from stdin");
-		  strncpynt (up->username, ac->user, USER_PASS_LEN);
-		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
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
+              char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
+              struct buffer packed_resp;
+
+              buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
+              msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
+              if (!get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not read challenge response from stdin");
+              strncpynt (up->username, ac->user, USER_PASS_LEN);
+              buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
+            }
+          else
+            {
+              msg (M_FATAL, "ERROR: received malformed challenge request from server");
+            }
+        }
+      else
 #endif
-	    {
-	      if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
-		{
-		  struct buffer user_prompt = alloc_buf_gc (128, &gc);
-		  buf_printf (&user_prompt, "Enter %s Username:", prefix);
-		  if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
-		  if (strlen (up->username) == 0)
-		    msg (M_FATAL, "ERROR: %s username is empty", prefix);
-		}
+        {
+          if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
+            {
+              struct buffer user_prompt = alloc_buf_gc (128, &gc);
+              buf_printf (&user_prompt, "Enter %s Username:", prefix);
+              if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
+              if (strlen (up->username) == 0)
+                msg (M_FATAL, "ERROR: %s username is empty", prefix);
+            }
 
-              if (password_from_stdin)
-                {
-		  struct buffer pass_prompt = alloc_buf_gc (128, &gc);
-		  buf_printf (&pass_prompt, "Enter %s Password:", prefix);
-		  if (!get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
-                    msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
-                }
+          if (password_from_stdin)
+            {
+              struct buffer pass_prompt = alloc_buf_gc (128, &gc);
+              buf_printf (&pass_prompt, "Enter %s Password:", prefix);
+              if (!get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
+            }
 
 #ifdef ENABLE_CLIENT_CR
-	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
-		{
-		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
-		  char *pw64=NULL, *resp64=NULL;
-
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
-		  if (!get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
-		  if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
-		      || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
-		    msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
-		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
-		  buf_printf (&packed_resp, "SCRV1:%s:%s", pw64, resp64);
-		  string_clear(pw64);
-		  free(pw64);
-		  string_clear(resp64);
-		  free(resp64);
-		}
-#endif
+          if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
+            {
+              char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
+              struct buffer packed_resp;
+              char *pw64=NULL, *resp64=NULL;
+
+              msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
+              if (!get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response, USER_PASS_LEN))
+                msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
+              if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
+                  || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
+                msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
+              buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
+              buf_printf (&packed_resp, "SCRV1:%s:%s", pw64, resp64);
+              string_clear(pw64);
+              free(pw64);
+              string_clear(resp64);
+              free(resp64);
 	    }
+#endif
+        }
 
       string_mod (up->username, CC_PRINT, CC_CRLF, 0);
       string_mod (up->password, CC_PRINT, CC_CRLF, 0);
-- 
1.9.1


