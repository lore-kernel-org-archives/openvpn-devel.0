From: selva.nair@...277...
Date: Fri,  1 Mar 2019 00:32:24 -0500
Message-Id: <1551418344-16317-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH for-2.4] Better error message when script
 fails due to script-security setting
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

From: Selva Nair <selva.nair@...277...>

- Add a new return value (-2) for openvpn_execve() when external
  program execution is not allowed due to a low script-security
  setting.

- Add a corresponding error message

Errors and warnings in such cases will now display as
"WARNING: failed running command (<cmd>) :" followed by

"disallowed by script-security setting" on all platforms

instead of the current

"external program did not execute -- returned error code -1"
on Windows and
"external program fork failed" on other platforms.

The error is FATAL for some scripts and that behaviour is unchanged.

This helps the Windows GUI to detect when a connection failure
results from a safer script-security setting enforced by the GUI,
and show a relevant message.

Note: Same as commit 01a3c876d4911 in master except for
script_security() --> script_security and context change:
run_command.[ch] --> misc.[ch]

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/misc.c  | 93 ++++++++++++++++++++++++++++++++---------------------
 src/openvpn/misc.h  |  5 +++
 src/openvpn/win32.c | 12 ++++---
 3 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 581a890..f44c65f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -99,44 +99,57 @@ save_inetd_socket_descriptor(void)
 }
 
 /*
- * Print an error message based on the status code returned by system().
+ * Generate an error message based on the status code returned by openvpn_execve().
  */
 const char *
 system_error_message(int stat, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
-#ifdef _WIN32
-    if (stat == -1)
+
+    switch (stat)
     {
-        buf_printf(&out, "external program did not execute -- ");
-    }
-    buf_printf(&out, "returned error code %d", stat);
+        case OPENVPN_EXECVE_NOT_ALLOWED:
+            buf_printf(&out, "disallowed by script-security setting");
+            break;
+
+#ifdef _WIN32
+        case OPENVPN_EXECVE_ERROR:
+            buf_printf(&out, "external program did not execute -- ");
+        /* fall through */
+
+        default:
+            buf_printf(&out, "returned error code %d", stat);
+            break;
 #else  /* ifdef _WIN32 */
-    if (stat == -1)
-    {
-        buf_printf(&out, "external program fork failed");
-    }
-    else if (!WIFEXITED(stat))
-    {
-        buf_printf(&out, "external program did not exit normally");
-    }
-    else
-    {
-        const int cmd_ret = WEXITSTATUS(stat);
-        if (!cmd_ret)
-        {
-            buf_printf(&out, "external program exited normally");
-        }
-        else if (cmd_ret == 127)
-        {
-            buf_printf(&out, "could not execute external program");
-        }
-        else
-        {
-            buf_printf(&out, "external program exited with error status: %d", cmd_ret);
-        }
-    }
+
+        case OPENVPN_EXECVE_ERROR:
+            buf_printf(&out, "external program fork failed");
+            break;
+
+        default:
+            if (!WIFEXITED(stat))
+            {
+                buf_printf(&out, "external program did not exit normally");
+            }
+            else
+            {
+                const int cmd_ret = WEXITSTATUS(stat);
+                if (!cmd_ret)
+                {
+                    buf_printf(&out, "external program exited normally");
+                }
+                else if (cmd_ret == OPENVPN_EXECVE_FAILURE)
+                {
+                    buf_printf(&out, "could not execute external program");
+                }
+                else
+                {
+                    buf_printf(&out, "external program exited with error status: %d", cmd_ret);
+                }
+            }
+            break;
 #endif /* ifdef _WIN32 */
+    }
     return (const char *)out.data;
 }
 
@@ -186,12 +199,14 @@ openvpn_execve_allowed(const unsigned int flags)
  * Run execve() inside a fork().  Designed to replicate the semantics of system() but
  * in a safer way that doesn't require the invocation of a shell or the risks
  * assocated with formatting and parsing a command line.
+ * Returns the exit status of child, OPENVPN_EXECVE_NOT_ALLOWED if openvpn_execve_allowed()
+ * returns false, or OPENVPN_EXECVE_ERROR on other errors.
  */
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
 {
     struct gc_arena gc = gc_new();
-    int ret = -1;
+    int ret = OPENVPN_EXECVE_ERROR;
     static bool warn_shown = false;
 
     if (a && a->argv[0])
@@ -208,7 +223,7 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             if (pid == (pid_t)0) /* child side */
             {
                 execve(cmd, argv, envp);
-                exit(127);
+                exit(OPENVPN_EXECVE_FAILURE);
             }
             else if (pid < (pid_t)0) /* fork failed */
             {
@@ -218,14 +233,18 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             {
                 if (waitpid(pid, &ret, 0) != pid)
                 {
-                    ret = -1;
+                    ret = OPENVPN_EXECVE_ERROR;
                 }
             }
         }
-        else if (!warn_shown && (script_security < SSEC_SCRIPTS))
+        else
         {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            warn_shown = true;
+            ret = OPENVPN_EXECVE_NOT_ALLOWED;
+            if (!warn_shown && (script_security < SSEC_SCRIPTS))
+            {
+                msg(M_WARN, SCRIPT_SECURITY_WARNING);
+                warn_shown = true;
+            }
         }
 #else  /* if defined(ENABLE_FEATURE_EXECVE) */
         msg(M_WARN, "openvpn_execve: execve function not available");
@@ -272,7 +291,7 @@ openvpn_popen(const struct argv *a,  const struct env_set *es)
                     close(pipe_stdout[0]);         /* Close read end */
                     dup2(pipe_stdout[1],1);
                     execve(cmd, argv, envp);
-                    exit(127);
+                    exit(OPENVPN_EXECVE_FAILURE);
                 }
                 else if (pid > (pid_t)0)       /* parent side */
                 {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index a64ddcc..8a34f43 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -57,6 +57,11 @@ struct env_set {
 
 const char *system_error_message(int, struct gc_arena *gc);
 
+/* openvpn_execve return codes */
+#define OPENVPN_EXECVE_ERROR       -1 /* generic error while forking to run an external program */
+#define OPENVPN_EXECVE_NOT_ALLOWED -2 /* external program not run due to script security */
+#define OPENVPN_EXECVE_FAILURE    127 /* exit code passed back from child when execve fails */
+
 /* wrapper around the execve() call */
 int openvpn_popen(const struct argv *a,  const struct env_set *es);
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 29bbb84..c3e38cc 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1088,7 +1088,7 @@ wide_cmd_line(const struct argv *a, struct gc_arena *gc)
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
 {
-    int ret = -1;
+    int ret = OPENVPN_EXECVE_ERROR;
     static bool exec_warn = false;
 
     if (a && a->argv[0])
@@ -1137,10 +1137,14 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             free(env);
             gc_free(&gc);
         }
-        else if (!exec_warn && (script_security < SSEC_SCRIPTS))
+        else
         {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            exec_warn = true;
+            ret = OPENVPN_EXECVE_NOT_ALLOWED;
+            if (!exec_warn && (script_security < SSEC_SCRIPTS))
+            {
+                msg(M_WARN, SCRIPT_SECURITY_WARNING);
+                exec_warn = true;
+            }
         }
     }
     else
-- 
2.1.4


