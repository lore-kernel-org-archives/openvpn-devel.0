From: Fabian Knittel <fabian.knittel@...1338...>
Date: Tue,  4 May 2010 16:21:47 +0200
Message-Id: <1272982907-30917-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH] ssl.c: fix use of openvpn_run_script()'s
	return value
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

This patch fixes two bugs introduced in

    commit 339f2a4d4b487afa53fa99d72c35b16f31e417d3
    Author: David Sommerseth <dazo@...384...>
    Date:   Thu Apr 29 23:35:45 2010 +0200

David's patch replaced openvpn_execve() with openvpn_run_script() in two places,
but didn't adjust the return value handling.  openvpn_run_script() returns true
or false, while openvpn_execve() returns the program's exit code.

Without the fix, the --tls-verify script and the --auth-user-pass-verify
script fail to run.  (I noticed the latter, but haven't actually tested the
former.)

The return value handling is fine for the other places where
openvpn_run_script() is used, because those places previously used
openvpn_execve_check() (notice the "_check" suffix).

Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 ssl.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/ssl.c b/ssl.c
index a4af6a5..276322f 100644
--- a/ssl.c
+++ b/ssl.c
@@ -957,21 +957,19 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
            gc_free(&gc);
         }
 
-      if (system_ok (ret))
+      if (ret)
 	{
 	  msg (D_HANDSHAKE, "VERIFY SCRIPT OK: depth=%d, %s",
 	       ctx->error_depth, subject);
 	}
       else
 	{
-	  if (!system_executed (ret))
-	    argv_msg_prefix (M_ERR, &argv, "Verify command failed to execute");
 	  msg (D_HANDSHAKE, "VERIFY SCRIPT ERROR: depth=%d, %s",
 	       ctx->error_depth, subject);
 	  goto err;		/* Reject connection */
 	}
     }
-  
+
   /* check peer cert against CRL */
   if (opt->crl_file)
     {
@@ -3192,7 +3190,6 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
   struct gc_arena gc = gc_new ();
   struct argv argv = argv_new ();
   const char *tmp_file = "";
-  int retval;
   bool ret = false;
 
   /* Is username defined? */
@@ -3230,16 +3227,11 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
 
       /* format command line */
       argv_printf (&argv, "%sc %s", session->opt->auth_user_pass_verify_script, tmp_file);
-      
+
       /* call command */
-      retval = openvpn_run_script (&argv, session->opt->es, 0, "--auth-user-pass-verify");
+      ret = openvpn_run_script (&argv, session->opt->es, 0,
+				"--auth-user-pass-verify");
 
-      /* test return status of command */
-      if (system_ok (retval))
-	ret = true;
-      else if (!system_executed (retval))
-	argv_msg_prefix (D_TLS_ERRORS, &argv, "TLS Auth Error: user-pass-verify script failed to execute");
-	  
       if (!session->opt->auth_user_pass_verify_script_via_file)
 	setenv_del (session->opt->es, "password");
     }
-- 
1.7.0


