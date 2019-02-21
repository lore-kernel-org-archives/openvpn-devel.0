From: selva.nair@...277...
Date: Wed, 20 Feb 2019 19:46:22 -0500
Message-Id: <1550709982-19319-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1550368541-10402-1-git-send-email-selva.nair@...277...>
References: <1550368541-10402-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Better error message when script fails
 due to script-security setting
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

v2 changes as suggested by <davds@...515...>

- define macros for return values of openvpn_execve()
- replace if/else by switch() in system_error_message()

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/run_command.c | 93 ++++++++++++++++++++++++++++-------------------
 src/openvpn/run_command.h |  4 ++
 src/openvpn/win32.c       | 12 ++++--
 3 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 2d75a3e..4c4adf9 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -54,44 +54,57 @@ script_security_set(int level)
 }
 
 /*
- * Print an error message based on the status code returned by system().
+ * Generate an error message based on the status code returned by openvpn_execve().
  */
 static const char *
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
 
@@ -114,12 +127,14 @@ openvpn_execve_allowed(const unsigned int flags)
  * Run execve() inside a fork().  Designed to replicate the semantics of system() but
  * in a safer way that doesn't require the invocation of a shell or the risks
  * associated with formatting and parsing a command line.
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
@@ -136,7 +151,7 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             if (pid == (pid_t)0) /* child side */
             {
                 execve(cmd, argv, envp);
-                exit(127);
+                exit(OPENVPN_EXECVE_FAILURE);
             }
             else if (pid < (pid_t)0) /* fork failed */
             {
@@ -146,14 +161,18 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             {
                 if (waitpid(pid, &ret, 0) != pid)
                 {
-                    ret = -1;
+                    ret = OPENVPN_EXECVE_ERROR;
                 }
             }
         }
-        else if (!warn_shown && (script_security() < SSEC_SCRIPTS))
+        else
         {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            warn_shown = true;
+            ret = OPENVPN_EXECVE_NOT_ALLOWED;
+            if (!warn_shown && (script_security() < SSEC_SCRIPTS))
+            {
+                msg(M_WARN, SCRIPT_SECURITY_WARNING);
+                warn_shown = true;
+            }
         }
 #else  /* if defined(ENABLE_FEATURE_EXECVE) */
         msg(M_WARN, "openvpn_execve: execve function not available");
@@ -227,7 +246,7 @@ openvpn_popen(const struct argv *a,  const struct env_set *es)
                     close(pipe_stdout[0]);         /* Close read end */
                     dup2(pipe_stdout[1],1);
                     execve(cmd, argv, envp);
-                    exit(127);
+                    exit(OPENVPN_EXECVE_FAILURE);
                 }
                 else if (pid > (pid_t)0)       /* parent side */
                 {
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 4501a5c..7ccb13c 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -33,6 +33,10 @@
 #define SSEC_SCRIPTS   2 /* allow calling of built-in programs and user-defined scripts */
 #define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-defined scripts that may receive a password as an environmental variable */
 
+#define OPENVPN_EXECVE_ERROR       -1 /* generic error while forking to run an external program */
+#define OPENVPN_EXECVE_NOT_ALLOWED -2 /* external program not run due to script security */
+#define OPENVPN_EXECVE_FAILURE    127 /* exit code passed back from child when execve fails */
+
 int script_security(void);
 
 void script_security_set(int level);
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 463ac07..55d9843 100644
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
-        else if (!exec_warn && (script_security() < SSEC_SCRIPTS))
+        else
         {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            exec_warn = true;
+            ret = OPENVPN_EXECVE_NOT_ALLOWED;
+            if (!exec_warn && (script_security() < SSEC_SCRIPTS))
+            {
+                msg(M_WARN, SCRIPT_SECURITY_WARNING);
+                exec_warn = true;
+            }
         }
     }
     else
-- 
2.1.4


