From: Kevin Cernekee <cernekee@...277...>
Date: Sat, 12 Apr 2014 22:16:54 -0700
Message-Id: <1397366216-657-2-git-send-email-cernekee@...277...>
In-Reply-To: <1397366216-657-1-git-send-email-cernekee@...277...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
Subject: [Openvpn-devel] [PATCH 1/3] Add S_NOWAIT and S_SETPGRP flags to
	openvpn_execve
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

This is to let openvpn_execve be used to create a process that runs in
the background, and return its PID so that its process group can be nuked
on exit.

Signed-off-by: Kevin Cernekee <cernekee@...277...>
---
 src/openvpn/misc.c |    9 ++++++++-
 src/openvpn/misc.h |    6 ++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 7483184..a8018ff 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -308,6 +308,11 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
           pid = fork ();
           if (pid == (pid_t)0) /* child side */
             {
+              if (flags & S_SETPGRP)
+                {
+                  if (setpgid (0, getpid ()) == -1)
+                    msg (M_WARN | M_ERRNO, "openvpn_execve: setpgid failed");
+                }
               execve (cmd, argv, envp);
               exit (127);
             }
@@ -315,7 +320,9 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
             msg (M_ERR, "openvpn_execve: unable to fork");
           else /* parent side */
             {
-              if (waitpid (pid, &ret, 0) != pid)
+              if (flags & S_NOWAIT)
+                ret = (int)pid;
+              else if (waitpid (pid, &ret, 0) != pid)
                 ret = -1;
             }
         }
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 41748bd..5b7aeee 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -86,8 +86,10 @@ void write_pid (const struct pid_state *state);
 void warn_if_group_others_accessible(const char* filename);
 
 /* system flags */
-#define S_SCRIPT (1<<0)
-#define S_FATAL  (1<<1)
+#define S_SCRIPT    (1<<0)
+#define S_FATAL     (1<<1)
+#define S_NOWAIT    (1<<2)
+#define S_SETPGRP   (1<<3)
 
 const char *system_error_message (int, struct gc_arena *gc);
 
-- 
1.7.9.5


