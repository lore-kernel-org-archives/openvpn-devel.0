From: Gert Doering <gert@...1296...>
Date: Tue, 13 Oct 2020 22:47:58 +0200
Message-Id: <20201013204758.2472-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Avoid passing NULL to argv_printf_cat() in
 temp_file error case.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

To pass username + password to verify_user_pass_script(), OpenVPN
can either put both into environment, or create a temp file, and
pass that file name to the "user-pass-verify" script.  The file
name is initialized as "", so if no file is desired, it's well
defined - but if the file can not be created, the pointer is NULL
afterwards.

Change the sequence of events, setting up the argv before the
"if (file)" conditional, and add the file name only inside that
clause, if creating the temp file succeeded.

commit a4eeef17b2 did not create the problem, but modified the
code enough so that the static analyzer in gcc 9.2.0 *now* noticed
and issued a warning.

 ssl_verify.c:1132:5: warning: '%s' directive argument is null
              1132 |     argv_printf_cat(&argv, "%s", tmp_file);

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl_verify.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e19644c8..5c0aa6da 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1098,6 +1098,9 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
     /* Set environmental variables prior to calling script */
     setenv_str(session->opt->es, "script_type", "user-pass-verify");
 
+    /* format command line */
+    argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
+
     if (session->opt->auth_user_pass_verify_script_via_file)
     {
         struct status_output *so;
@@ -1115,6 +1118,8 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
                     tmp_file);
                 goto done;
             }
+            /* pass temp file name to script */
+            argv_printf_cat(&argv, "%s", tmp_file);
         }
         else
         {
@@ -1127,10 +1132,6 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
         setenv_str(session->opt->es, "password", up->password);
     }
 
-    /* format command line */
-    argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
-    argv_printf_cat(&argv, "%s", tmp_file);
-
     /* call command */
     ret = openvpn_run_script(&argv, session->opt->es, 0,
                              "--auth-user-pass-verify");
-- 
2.26.2


