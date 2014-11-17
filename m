From: David Sommerseth <openvpn.list@...1114...>
Date: Mon, 17 Nov 2014 23:14:20 +0100
Message-Id: <1416262460-9158-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] down-root: Improve error messages
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

If down-root fails it will now use warn() to provide some more information
about what went wrong, by retrieving the error message via errno.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/plugins/down-root/down-root.c | 52 +++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 4d10f48..ed2636a 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -41,6 +41,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <syslog.h>
+#include <errno.h>
 
 #include <openvpn-plugin.h>
 
@@ -160,7 +161,7 @@ daemonize (const char *envp[])
 	fd = dup (2);
       if (daemon (0, 0) < 0)
 	{
-	  fprintf (stderr, "DOWN-ROOT: daemonization failed\n");
+	  warn ("DOWN-ROOT: daemonization failed");
 	}
       else if (fd >= 3)
 	{
@@ -214,7 +215,10 @@ free_context (struct down_root_context *context)
 {
   if (context)
     {
-      free (context->command);
+      if (context->command)
+	{
+	  free (context->command);
+	}
       free (context);
     }
 }
@@ -231,13 +235,14 @@ run_script(char * const *argv, char * const *envp) {
   pid = fork();
   if (pid == (pid_t)0) { /* child side */
     execve(argv[0], argv, envp);
-    fprintf(stderr, "DOWN-ROOT: Failed execute: %s\n", argv[0]);
-    exit(127);  /* If execve() fails to run, exit child with exit code 127 */
-  } else if (pid < (pid_t)0 ) {
-    fprintf(stderr, "DOWN-ROOT: Failed to fork child to run %s\n", argv[0]);
+    /* If execve() fails to run, exit child with exit code 127 */
+    err(127, "DOWN-ROOT: Failed execute: %s", argv[0]);
+  } else if (pid < (pid_t)0 ){
+    warn ("DOWN-ROOT: Failed to fork child to run %s", argv[0]);
     return -1;
   } else { /* parent side */
     if( waitpid (pid, &ret, 0) != pid ) {
+      /* waitpid does not return error information via errno */
       fprintf(stderr, "DOWN-ROOT: waitpid() failed, don't know exit code of child (%s)\n", argv[0]);
       return -1;
     }
@@ -256,7 +261,10 @@ openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char
    */
   context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
   if (!context)
-    goto error;
+    {
+      warn ("DOWN-ROOT: Could not allocate memory for plug-in context");
+      goto error;
+    }
   context->foreground_fd = -1;
 
   /*
@@ -278,6 +286,12 @@ openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char
    * Save the arguments in our context
    */
   context->command = calloc(string_array_len(argv), sizeof(char *));
+  if (!context->command)
+    {
+      warn ("DOWN-ROOT: Could not allocate memory for command array");
+      goto error;
+    }
+
   /* Ignore argv[0], as it contains just the plug-in file name */
   for (i = 1; i < string_array_len(argv); i++)
     {
@@ -316,7 +330,7 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const ch
        */
       if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
 	{
-	  fprintf (stderr, "DOWN-ROOT: socketpair call failed\n");
+	  warn ("DOWN-ROOT: socketpair call failed");
 	  return OPENVPN_PLUGIN_FUNC_ERROR;
 	}
 
@@ -341,7 +355,9 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const ch
 
 	  /* don't let future subprocesses inherit child socket */
 	  if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
-	    fprintf (stderr, "DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed\n");
+	    {
+	      warn ("DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed");
+	    }
 
 	  /* wait for background child process to initialize */
 	  status = recv_control (fd[0]);
@@ -378,7 +394,7 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const ch
     {
       if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
 	{
-	  fprintf (stderr, "DOWN-ROOT: Error sending script execution signal to background process\n");
+	  warn ("DOWN-ROOT: Error sending script execution signal to background process");
 	}
       else
 	{
@@ -386,7 +402,9 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const ch
 	  if (status == RESPONSE_SCRIPT_SUCCEEDED)
 	    return OPENVPN_PLUGIN_FUNC_SUCCESS;
 	  if (status == -1)
-	    fprintf (stderr, "DOWN-ROOT: Error receiving script execution confirmation from background process\n");
+	    {
+	      warn ("DOWN-ROOT: Error receiving script execution confirmation from background process");
+	    }
 	}
     }
   return OPENVPN_PLUGIN_FUNC_ERROR;
@@ -404,7 +422,9 @@ openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
     {
       /* tell background process to exit */
       if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
-	fprintf (stderr, "DOWN-ROOT: Error signalling background process to exit\n");
+	{
+	  warn ("DOWN-ROOT: Error signalling background process to exit");
+	}
 
       /* wait for background process to exit */
       if (context->background_pid > 0)
@@ -451,7 +471,7 @@ down_root_server (const int fd, char * const *argv, char * const *envp, const in
    */
   if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
     {
-      fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [1]\n");
+      warn ("DOWN-ROOT: BACKGROUND: write error on response socket [1]");
       goto done;
     }
 
@@ -476,7 +496,7 @@ down_root_server (const int fd, char * const *argv, char * const *envp, const in
 	    {
 	      if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
 		{
-		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [2]\n");
+		  warn ("DOWN-ROOT: BACKGROUND: write error on response socket [2]");
 		  goto done;
 		}
 	    }
@@ -485,7 +505,7 @@ down_root_server (const int fd, char * const *argv, char * const *envp, const in
 	      fprintf(stderr, "DOWN-ROOT: BACKGROUND: %s exited with exit code %i\n", argv[0], exit_code);
 	      if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
 		{
-		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [3]\n");
+		  warn ("DOWN-ROOT: BACKGROUND: write error on response socket [3]");
 		  goto done;
 		}
 	    }
@@ -495,7 +515,7 @@ down_root_server (const int fd, char * const *argv, char * const *envp, const in
 	  goto done;
 
 	case -1:
-	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: read error on command channel\n");
+	  warn ("DOWN-ROOT: BACKGROUND: read error on command channel");
 	  goto done;
 
 	default:
-- 
1.8.3.1


