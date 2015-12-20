From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Dec 2015 14:12:53 -0500
Message-Id: <1450638773-11376-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Support reading the challenge-response from
	console
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

Trying to keep the footrpint small, this patch adds to the
convoluted code-flow in get_user_pass_cr(). Cleanup left for later.
-----8<-----

Currently prompting for a response to static-challenge
gets skipped when the username and passowrd are read
from a file. Further, dynamic challenge gets wrongly handled
as if its a username/password request.

The Fix:
- Add yet another flag in get_user_pass_cr() to
  set when prompting of response from console is needed.
- In receive_auth_failed(), the challenge text received
  from server _always_ copied to  the auth_challenge
  buffer: this is needed to trigger prompting from console
  when required.
- Also show the challenge text instead of an opaque
  "Response:" at the prompt.

While at it, also remove the special treatment of authfile ==
"management" in get_user_pass_cr(). The feature implied by that
test does not exist.

Tested:
  - username and optionally password from file, rest from console
  - the above with a static challenge
  - the above with a dynamic challenge
  - all of the above with systemd in place of console
  - all from management with and without static/dynamic
    challenge.

Thanks to Wayne Davison <wayne@...2099...> for pointing out the
issue with challenge-response, and an initial patch.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/misc.c |   22 +++++++++++++++-------
 src/openvpn/push.c |    5 ++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 05ed073..363b8f7 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1044,6 +1044,7 @@ get_user_pass_cr (struct user_pass *up,
       bool from_authfile = (auth_file && !streq (auth_file, "stdin"));
       bool username_from_stdin = false;
       bool password_from_stdin = false;
+      bool response_from_stdin = true;
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -1053,10 +1054,11 @@ get_user_pass_cr (struct user_pass *up,
        * Get username/password from management interface?
        */
       if (management
-	  && ((auth_file && streq (auth_file, "management")) || (!from_authfile && (flags & GET_USER_PASS_MANAGEMENT)))
+          && (!from_authfile && (flags & GET_USER_PASS_MANAGEMENT))
 	  && management_query_user_pass_enabled (management))
 	{
 	  const char *sc = NULL;
+          response_from_stdin = false;
 
 	  if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	    management_auth_failure (management, prefix, "previous auth credentials failed");
@@ -1090,7 +1092,10 @@ get_user_pass_cr (struct user_pass *up,
 	  if (!strlen (up->password))
 	    strcpy (up->password, "ok");
 	}
-      else if (from_authfile)
+      /*
+       * Read from auth file unless this is a dynamic challenge request.
+       */
+      else if (from_authfile && !(flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
         {
           /*
            * Try to get username/password from a file.
@@ -1141,10 +1146,10 @@ get_user_pass_cr (struct user_pass *up,
       /*
        * Get username/password from standard input?
        */
-      if (username_from_stdin || password_from_stdin)
+      if (username_from_stdin || password_from_stdin || response_from_stdin)
 	{
 #ifdef ENABLE_CLIENT_CR
-	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
+          if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE) && response_from_stdin)
 	    {
 	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
 	      if (ac)
@@ -1154,7 +1159,8 @@ get_user_pass_cr (struct user_pass *up,
 
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
 		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-		  if (!get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
+                  if (!get_console_input (ac->challenge_text, BOOL_CAST(ac->flags&CR_ECHO),
+                                          response, USER_PASS_LEN))
 		    msg (M_FATAL, "ERROR: could not read challenge response from stdin");
 		  strncpynt (up->username, ac->user, USER_PASS_LEN);
 		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
@@ -1185,14 +1191,16 @@ get_user_pass_cr (struct user_pass *up,
 		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
 
 #ifdef ENABLE_CLIENT_CR
-	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
+              if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE) && response_from_stdin)
 		{
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
 		  struct buffer packed_resp;
 		  char *pw64=NULL, *resp64=NULL;
 
 		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
-		  if (!get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response, USER_PASS_LEN))
+
+                  if (!get_console_input (auth_challenge, BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO),
+                                          response, USER_PASS_LEN))
 		    msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
 		  if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
 		      || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d4f3cb6..ba13881 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -76,8 +76,11 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	  if (buf_string_compare_advance (&buf, "AUTH_FAILED,") && BLEN (&buf))
 	    reason = BSTR (&buf);
 	  management_auth_failure (management, UP_TYPE_AUTH, reason);
-	} else
+	}
 #endif
+      /*
+       * Save the dynamic-challenge text even when management is defined
+       */
 	{
 #ifdef ENABLE_CLIENT_CR
 	  struct buffer buf = *buffer;
-- 
1.7.10.4


