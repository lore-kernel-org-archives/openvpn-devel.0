From: davids@...1347...
Date: Fri,  5 Sep 2014 17:25:31 +0200
Message-Id: <1409930731-15263-5-git-send-email-davids@...1347...>
In-Reply-To: <1409930731-15263-1-git-send-email-davids@...1347...>
References: <1409930731-15263-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH 4/4] White-space clean-up of openvpn_popen()
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
Cc: fcrozat@...1519...

From: David Sommerseth <davids@...1347...>

The whole coding style was a mishmash of tab/spaces and different
alignments.

Reformatted to 2 space indents (no tabs).

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/misc.c | 81 +++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index daf4900..d7cbb8c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -354,48 +354,49 @@ openvpn_popen (const struct argv *a,  const struct env_set *es)
     {
 #if defined(ENABLE_FEATURE_EXECVE)
       if (script_security >= SSEC_BUILT_IN)
-	{
-	      const char *cmd = a->argv[0];
-	      char *const *argv = a->argv;
-	      char *const *envp = (char *const *)make_env_array (es, true, &gc);
-	      pid_t pid;
-	      int pipe_stdout[2];
-
-              if (pipe (pipe_stdout) == 0) {
-		      pid = fork ();
-		      if (pid == (pid_t)0) /* child side */
-			{
-			  close (pipe_stdout[0]);  /* Close read end */
-			  dup2 (pipe_stdout[1],1);
-			  execve (cmd, argv, envp);
-			  close (pipe_stdout[1]);
-			  exit (127);
-			}
-		      else if (pid > (pid_t)0) /* parent side */
-			{
-                          int status = 0;
-
-                          close (pipe_stdout[1]); /* Close write end */
-                          waitpid(pid, &status, 0);
-                          ret = pipe_stdout[0];
-			}
-		      else /* fork failed */
-			{
-                          close (pipe_stdout[0]);
-                          close (pipe_stdout[1]);
-			  msg (M_ERR, "openvpn_popen: unable to fork %s", cmd);
-			}
-	      }
-	      else {
-                msg (M_WARN, "openvpn_popen: unable to create stdout pipe for %s", cmd);
-                ret = -1;
-	      }
-	}
+        {
+          const char *cmd = a->argv[0];
+          char *const *argv = a->argv;
+          char *const *envp = (char *const *)make_env_array (es, true, &gc);
+          pid_t pid;
+          int pipe_stdout[2];
+
+          if (pipe (pipe_stdout) == 0) {
+            pid = fork ();
+            if (pid == (pid_t)0) /* child side */
+              {
+                close (pipe_stdout[0]);  /* Close read end */
+                dup2 (pipe_stdout[1],1);
+                execve (cmd, argv, envp);
+                close (pipe_stdout[1]);
+                exit (127);
+              }
+            else if (pid > (pid_t)0) /* parent side */
+              {
+                int status = 0;
+
+                close (pipe_stdout[1]); /* Close write end */
+                waitpid(pid, &status, 0);
+                ret = pipe_stdout[0];
+              }
+            else /* fork failed */
+              {
+                close (pipe_stdout[0]);
+                close (pipe_stdout[1]);
+                msg (M_ERR, "openvpn_popen: unable to fork %s", cmd);
+              }
+          }
+          else
+            {
+              msg (M_WARN, "openvpn_popen: unable to create stdout pipe for %s", cmd);
+              ret = -1;
+            }
+        }
       else if (!warn_shown && (script_security < SSEC_SCRIPTS))
-	{
-	  msg (M_WARN, SCRIPT_SECURITY_WARNING);
+        {
+          msg (M_WARN, SCRIPT_SECURITY_WARNING);
           warn_shown = true;
-	}
+        }
 #else
       msg (M_WARN, "openvpn_popen: execve function not available");
 #endif
-- 
1.8.3.1


