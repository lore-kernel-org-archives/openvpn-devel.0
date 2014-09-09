From: David Sommerseth <openvpn.list@...1114...>
Date: Tue,  9 Sep 2014 19:26:13 +0200
Message-Id: <1410283573-17933-3-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
References: <1410283573-17933-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH v2 2/2] Clean up the pipe closing in
	openvpn_popen()
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

From: David Sommerseth <davids@...1347...>

Do the proper closing of the pipe ends which is not being used,
also in error situations.  Moved the closing of the parent side
before the waitpid(), to be consistent with the child side (as
early as possible).

Also improved the error messages with more details.

[v2 - Don't call close() if execve() fails]

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/misc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 19bbef7..61bc523 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -365,27 +365,29 @@ openvpn_popen (const struct argv *a,  const struct env_set *es)
 		      pid = fork ();
 		      if (pid == (pid_t)0) /* child side */
 			{
-			  close (pipe_stdout[0]);
+			  close (pipe_stdout[0]);  /* Close read end */
 			  dup2 (pipe_stdout[1],1);
 			  execve (cmd, argv, envp);
 			  exit (127);
 			}
-		      else if (pid < (pid_t)0) /* fork failed */
-			{
-			  msg (M_ERR, "openvpn_popen: unable to fork");
-			}
-		      else /* parent side */
+		      else if (pid > (pid_t)0) /* parent side */
 			{
                           int status = 0;
 
+                          close (pipe_stdout[1]); /* Close write end */
                           waitpid(pid, &status, 0);
                           ret = pipe_stdout[0];
+			}
+		      else /* fork failed */
+			{
+                          close (pipe_stdout[0]);
                           close (pipe_stdout[1]);
+			  msg (M_ERR, "openvpn_popen: unable to fork %s", cmd);
 			}
 	      }
 	      else {
-		      msg (M_WARN, "openvpn_popen: unable to create stdout pipe");
-		      ret = -1;
+                msg (M_WARN, "openvpn_popen: unable to create stdout pipe for %s", cmd);
+                ret = -1;
 	      }
 	}
       else if (!warn_shown && (script_security < SSEC_SCRIPTS))
-- 
1.8.3.1


