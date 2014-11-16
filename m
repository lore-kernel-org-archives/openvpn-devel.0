From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 16 Nov 2014 15:31:02 +0100
Message-Id: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] down-root plugin: Replaced system() calls
	with execve()
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

The system() call is prone to shell expansions and provides far more
environments variables to the executable run than what is usually
preferred.  By moving over to exevce() shell expansions are far more
difficult to achieve and only the OpenVPN provided environment
variables are available.

This is a response to the patch submitted to openvpn-devel ML:
http://article.gmane.org/gmane.network.openvpn.devel/7919

 v2 - Pulling it up again, fixing a few whitespace and spelling issues

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/plugins/down-root/down-root.c | 140 +++++++++++++-------------------------
 1 file changed, 48 insertions(+), 92 deletions(-)

diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index d51d0e5..4d10f48 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2013 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -46,8 +47,8 @@
 #define DEBUG(verb) ((verb) >= 7)
 
 /* Command codes for foreground -> background communication */
-#define COMMAND_RUN_SCRIPT 0
-#define COMMAND_EXIT       1
+#define COMMAND_RUN_SCRIPT 1
+#define COMMAND_EXIT       2
 
 /* Response codes for background -> foreground communication */
 #define RESPONSE_INIT_SUCCEEDED   10
@@ -56,7 +57,7 @@
 #define RESPONSE_SCRIPT_FAILED    13
 
 /* Background process function */
-static void down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb);
+static void down_root_server (const int fd, char * const * argv, char * const *envp, const int verb);
 
 /*
  * Plugin state, used by foreground
@@ -73,7 +74,7 @@ struct down_root_context
   int verb;
 
   /* down command */
-  char *command;
+  char **command;
 };
 
 /*
@@ -207,72 +208,48 @@ set_signals (void)
   signal (SIGPIPE, SIG_IGN);
 }
 
-/*
- * convert system() return into a success/failure value
- */
-int
-system_ok (int stat)
-{
-#ifdef WIN32
-  return stat == 0;
-#else
-  return stat != -1 && WIFEXITED (stat) && WEXITSTATUS (stat) == 0;
-#endif
-}
-
-static char *
-build_command_line (const char *argv[])
-{
-  int size = 0;
-  int n = 0;
-  int i;
-  char *string;
-
-  /* precompute size */
-  if (argv)
-    {
-      for (i = 0; argv[i]; ++i)
-	{
-	  size += (strlen (argv[i]) + 1); /* string length plus trailing space */
-	  ++n;
-	}
-    }
-  ++size;                                 /* for null terminator */
-
-  /* allocate memory */
-  string = (char *) malloc (size);
-  if (!string)
-    {
-      fprintf (stderr, "DOWN-ROOT: out of memory\n");
-      exit (1);
-    }
-  string[0] = '\0';
-
-  /* build string */
-  for (i = 0; i < n; ++i)
-    {
-      strcat (string, argv[i]);
-      if (i + 1 < n)
-	strcat (string, " ");
-    }
-  return string;
-}
 
 static void
 free_context (struct down_root_context *context)
 {
   if (context)
     {
-      if (context->command)
-	free (context->command);
+      free (context->command);
       free (context);
     }
 }
 
+/* Run the script using execve().  As execve() replaces the
+ * current process with the new one, do a fork first before
+ * calling execve()
+ */
+static int
+run_script(char * const *argv, char * const *envp) {
+  pid_t pid;
+  int ret = 0;
+
+  pid = fork();
+  if (pid == (pid_t)0) { /* child side */
+    execve(argv[0], argv, envp);
+    fprintf(stderr, "DOWN-ROOT: Failed execute: %s\n", argv[0]);
+    exit(127);  /* If execve() fails to run, exit child with exit code 127 */
+  } else if (pid < (pid_t)0 ) {
+    fprintf(stderr, "DOWN-ROOT: Failed to fork child to run %s\n", argv[0]);
+    return -1;
+  } else { /* parent side */
+    if( waitpid (pid, &ret, 0) != pid ) {
+      fprintf(stderr, "DOWN-ROOT: waitpid() failed, don't know exit code of child (%s)\n", argv[0]);
+      return -1;
+    }
+  }
+  return ret;
+}
+
 OPENVPN_EXPORT openvpn_plugin_handle_t
 openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
 {
   struct down_root_context *context;
+  int i = 0;
 
   /*
    * Allocate our context
@@ -298,9 +275,14 @@ openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char
     }
 
   /*
-   * Save our argument in context
+   * Save the arguments in our context
    */
-  context->command = build_command_line (&argv[1]);
+  context->command = calloc(string_array_len(argv), sizeof(char *));
+  /* Ignore argv[0], as it contains just the plug-in file name */
+  for (i = 1; i < string_array_len(argv); i++)
+    {
+      context->command[i-1] = (char *) argv[i];
+    }
 
   /*
    * Get verbosity level from environment
@@ -385,7 +367,7 @@ openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const ch
 	  daemonize (envp);
 
 	  /* execute the event loop */
-	  down_root_server (fd[1], context->command, argv, envp, context->verb);
+	  down_root_server (fd[1], context->command, (char * const *) envp, context->verb);
 
 	  close (fd[1]);
 	  exit (0);
@@ -422,7 +404,7 @@ openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
     {
       /* tell background process to exit */
       if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
-	fprintf (stderr, "DOWN-ROOT: Error signaling background process to exit\n");
+	fprintf (stderr, "DOWN-ROOT: Error signalling background process to exit\n");
 
       /* wait for background process to exit */
       if (context->background_pid > 0)
@@ -453,18 +435,16 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
  * Background process -- runs with privilege.
  */
 static void
-down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb)
+down_root_server (const int fd, char * const *argv, char * const *envp, const int verb)
 {
   const char *p[3];
-  char *command_line = NULL;
-  char *argv_cat = NULL;
   int i;
 
   /*
    * Do initialization
    */
   if (DEBUG (verb))
-    fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", command);
+    fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", argv[0]);
 
   /*
    * Tell foreground that we initialized successfully
@@ -476,32 +456,12 @@ down_root_server (const int fd, char *command, const char *argv[], const char *e
     }
 
   /*
-   * Build command line
-   */
-  if (string_array_len (argv) >= 2)
-    argv_cat = build_command_line (&argv[1]);
-  else
-    argv_cat = build_command_line (NULL);
-  p[0] = command;
-  p[1] = argv_cat;
-  p[2] = NULL;
-  command_line = build_command_line (p);
-
-  /*
-   * Save envp in environment
-   */
-  for (i = 0; envp[i]; ++i)
-    {
-      putenv ((char *)envp[i]);
-    }
-
-  /*
    * Event loop
    */
   while (1)
     {
       int command_code;
-      int status;
+      int exit_code = -1;
 
       /* get a command from foreground process */
       command_code = recv_control (fd);
@@ -512,8 +472,7 @@ down_root_server (const int fd, char *command, const char *argv[], const char *e
       switch (command_code)
 	{
 	case COMMAND_RUN_SCRIPT:
-	  status = system (command_line);
-	  if (system_ok (status)) /* Succeeded */
+	  if ( (exit_code = run_script(argv, envp)) == 0 ) /* Succeeded */
 	    {
 	      if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
 		{
@@ -523,6 +482,7 @@ down_root_server (const int fd, char *command, const char *argv[], const char *e
 	    }
 	  else /* Failed */
 	    {
+	      fprintf(stderr, "DOWN-ROOT: BACKGROUND: %s exited with exit code %i\n", argv[0], exit_code);
 	      if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
 		{
 		  fprintf (stderr, "DOWN-ROOT: BACKGROUND: write error on response socket [3]\n");
@@ -546,10 +506,6 @@ down_root_server (const int fd, char *command, const char *argv[], const char *e
     }
 
  done:
-  if (argv_cat)
-    free (argv_cat);
-  if (command_line)
-    free (command_line);
   if (DEBUG (verb))
     fprintf (stderr, "DOWN-ROOT: BACKGROUND: EXIT\n");
 
-- 
1.8.3.1


