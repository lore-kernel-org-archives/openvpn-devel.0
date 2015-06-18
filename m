From: Steffan Karger <steffan@...1856...>
Date: Fri, 19 Jun 2015 00:08:45 +0200
Message-Id: <1434665325-3225-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] write pid file immediately after daemonizing
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

Since we split daemonizing from changing directory in commit da9b292
(f025de005d719201a69ad0313d545a1ddd244752 in release/2.3), we can now
simply write the pid file immediately after daemonizing.  This not only
hould fix the bug reported in trac #563, but also furhter simplifies the
code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c    |  6 ------
 src/openvpn/misc.c    | 27 +++++++++------------------
 src/openvpn/misc.h    |  9 +--------
 src/openvpn/openvpn.c |  5 ++++-
 src/openvpn/openvpn.h |  3 ---
 5 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c99e775..7a2c69b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2775,16 +2775,10 @@ do_init_first_time (struct context *c)
 	platform_group_get (c->options.groupname, &c0->platform_state_group) |
 	platform_user_get (c->options.username, &c0->platform_state_user);
 
-      /* get --writepid file descriptor */
-      get_pid_file (c->options.writepid, &c0->pid_state);
-
       /* perform postponed chdir if --daemon */
       if (c->did_we_daemonize && c->options.cd_dir == NULL)
 	platform_chdir("/");
 
-      /* save process ID in a file */
-      write_pid (&c0->pid_state);
-
       /* should we change scheduling priority? */
       platform_nice (c->options.nice);
     }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 8408438..8e78117 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -127,30 +127,21 @@ run_up_down (const char *command,
   gc_free (&gc);
 }
 
-/* Get the file we will later write our process ID to */
+/* Write our PID to a file */
 void
-get_pid_file (const char* filename, struct pid_state *state)
+write_pid (const char *filename)
 {
-  CLEAR (*state);
   if (filename)
     {
-      state->fp = platform_fopen (filename, "w");
-      if (!state->fp)
+      unsigned int pid = 0;
+      FILE *fp = platform_fopen (filename, "w");
+      if (!fp)
 	msg (M_ERR, "Open error on pid file %s", filename);
-      state->filename = filename;
-    }
-}
 
-/* Write our PID to a file */
-void
-write_pid (const struct pid_state *state)
-{
-  if (state->filename && state->fp)
-    {
-      unsigned int pid = platform_getpid (); 
-      fprintf(state->fp, "%u\n", pid);
-      if (fclose (state->fp))
-	msg (M_ERR, "Close error on pid file %s", state->filename);
+      pid = platform_getpid ();
+      fprintf(fp, "%u\n", pid);
+      if (fclose (fp))
+	msg (M_ERR, "Close error on pid file %s", filename);
     }
 }
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 183898e..e67b5e4 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -73,14 +73,7 @@ void run_up_down (const char *command,
 		  const char *script_type,
 		  struct env_set *es);
 
-/* workspace for get_pid_file/write_pid */
-struct pid_state {
-  FILE *fp;
-  const char *filename;
-};
-
-void get_pid_file (const char* filename, struct pid_state *state);
-void write_pid (const struct pid_state *state);
+void write_pid (const char *filename);
 
 /* check file protections */
 void warn_if_group_others_accessible(const char* filename);
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 2f327f3..00bd570 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -231,7 +231,10 @@ openvpn_main (int argc, char *argv[])
 	  
 	  /* become a daemon if --daemon */
 	  if (c.first_time)
-	    c.did_we_daemonize = possibly_become_daemon (&c.options);
+	    {
+	      c.did_we_daemonize = possibly_become_daemon (&c.options);
+	      write_pid (c.options.writepid);
+	    }
 
 #ifdef ENABLE_MANAGEMENT
 	  /* open management subsystem */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index bdfa685..10ec859 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -137,9 +137,6 @@ struct context_persist
  */
 struct context_0
 {
-  /* workspace for get_pid_file/write_pid */
-  struct pid_state pid_state;
-
   /* workspace for --user/--group */
   bool uid_gid_specified;
   bool uid_gid_set;
-- 
2.1.4


