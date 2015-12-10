From: Wayne Davison <wayne@...2099...>
Date: Thu, 10 Dec 2015 17:10:11 +0000
Message-Id: <1449767411-3852-1-git-send-email-wayne@...2099...>
In-Reply-To: <1449766646-3519-1-git-send-email-wayne@...2099...>
References: <1449766646-3519-1-git-send-email-wayne@...2099...>
Subject: [Openvpn-devel] [PATCH] Allow challenge/response to be read from
	--auth-user-pass file.
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

Must be applied after the patch to fix CR prompting.

---
 doc/openvpn.8      |  8 +++++++-
 src/openvpn/misc.c | 19 +++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 1b9dcae..e806930 100644
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
+(and can also be combined with an empty password line to still
+be prompted for your password).
 
 If
 .B up
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 83e10f7..4de4a17 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1038,6 +1038,9 @@ get_user_pass_cr (struct user_pass *up,
       bool from_authfile = (auth_file && !streq (auth_file, "stdin"));
       bool username_from_stdin = false;
       bool password_from_stdin = false;
+#ifdef ENABLE_CLIENT_CR
+      char response_buf[USER_PASS_LEN] = { '\0' };
+#endif
 
       if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
 	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -1111,6 +1114,10 @@ get_user_pass_cr (struct user_pass *up,
           if (fgets (password_buf, USER_PASS_LEN, fp) != NULL)
             {
               chomp (password_buf);
+#ifdef ENABLE_CLIENT_CR
+              if (!(flags & GET_USER_PASS_PASSWORD_ONLY) && fgets (response_buf, USER_PASS_LEN, fp) != NULL)
+                chomp (response_buf);
+#endif
             }
 
           if (flags & GET_USER_PASS_PASSWORD_ONLY && !password_buf[0])
@@ -1138,15 +1145,14 @@ get_user_pass_cr (struct user_pass *up,
           struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
           if (ac)
             {
-              char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
               struct buffer packed_resp;
 
               buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
               msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-              if (!get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
+              if (!response_buf[0] && !get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response_buf, USER_PASS_LEN))
                 msg (M_FATAL, "ERROR: could not read challenge response from stdin");
               strncpynt (up->username, ac->user, USER_PASS_LEN);
-              buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
+              buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response_buf);
             }
           else
             {
@@ -1177,15 +1183,16 @@ get_user_pass_cr (struct user_pass *up,
 #ifdef ENABLE_CLIENT_CR
           if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
             {
-              char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
               struct buffer packed_resp;
               char *pw64=NULL, *resp64=NULL;
 
               msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
-              if (!get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response, USER_PASS_LEN))
+              if (!response_buf[0] && !get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response_buf, USER_PASS_LEN))
                 msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
+              else if (!response_buf[0] && (flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO))
+                msg (M_INFO|M_NOPREFIX, "Response: %s", response_buf);
               if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
-                  || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
+                  || openvpn_base64_encode(response_buf, strlen(response_buf), &resp64) == -1)
                 msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
               buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
               buf_printf (&packed_resp, "SCRV1:%s:%s", pw64, resp64);
-- 
1.9.1


