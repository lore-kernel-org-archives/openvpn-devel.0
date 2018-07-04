From: Steffan Karger <steffan@...1856...>
Date: Wed,  4 Jul 2018 19:53:57 +0200
Message-Id: <20180704175404.22371-2-steffan@...1856...>
In-Reply-To: <20180704175404.22371-1-steffan@...1856...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2 2/9] Move execve/run_script helper
 functions to run_command.c
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

To avoid having to include misc.c - which is a dependency mess - in the
tls-crypt unit tests, move the command execution helper functions to a new
run_command.c module.

While at it, abstract away the script_security global variable.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/Makefile.am   |   1 +
 src/openvpn/env_set.c     |   6 +-
 src/openvpn/init.c        |   5 +-
 src/openvpn/lladdr.c      |   1 +
 src/openvpn/misc.c        | 218 -------------------------------
 src/openvpn/misc.h        |  32 -----
 src/openvpn/multi.c       |   2 +-
 src/openvpn/options.c     |   3 +-
 src/openvpn/route.c       |   2 +-
 src/openvpn/run_command.c | 267 ++++++++++++++++++++++++++++++++++++++
 src/openvpn/run_command.h |  63 +++++++++
 src/openvpn/socket.c      |   1 +
 src/openvpn/ssl_verify.c  |   4 +-
 src/openvpn/tun.c         |   2 +-
 src/openvpn/win32.c       |   4 +-
 15 files changed, 348 insertions(+), 263 deletions(-)
 create mode 100644 src/openvpn/run_command.c
 create mode 100644 src/openvpn/run_command.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index eda08351..66410611 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -102,6 +102,7 @@ openvpn_SOURCES = \
 	pushlist.h \
 	reliable.c reliable.h \
 	route.c route.h \
+	run_command.c run_command.h \
 	schedule.c schedule.h \
 	session_id.c session_id.h \
 	shaper.c shaper.h \
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 17675625..e7fb2d83 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -32,10 +32,10 @@
 
 #include "syshead.h"
 
-#include "misc.h"
-
 #include "env_set.h"
 
+#include "run_command.h"
+
 /*
  * Set environmental variable (int or string).
  *
@@ -414,7 +414,7 @@ setenv_str_i(struct env_set *es, const char *name, const char *value, const int
 bool
 env_allowed(const char *str)
 {
-    return (script_security >= SSEC_PW_ENV || !is_password_env_var(str));
+    return (script_security() >= SSEC_PW_ENV || !is_password_env_var(str));
 }
 
 /* Make arrays of strings */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f6c8f08e..d28d1fd2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -35,6 +35,7 @@
 
 #include "win32.h"
 #include "init.h"
+#include "run_command.h"
 #include "sig.h"
 #include "occ.h"
 #include "list.h"
@@ -3095,11 +3096,11 @@ do_option_warnings(struct context *c)
     /* If a script is used, print appropiate warnings */
     if (o->user_script_used)
     {
-        if (script_security >= SSEC_SCRIPTS)
+        if (script_security() >= SSEC_SCRIPTS)
         {
             msg(M_WARN, "NOTE: the current --script-security setting may allow this configuration to call user-defined scripts");
         }
-        else if (script_security >= SSEC_PW_ENV)
+        else if (script_security() >= SSEC_PW_ENV)
         {
             msg(M_WARN, "WARNING: the current --script-security setting may allow passwords to be passed to scripts via environmental variables");
         }
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index ff71e48c..f24596b5 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -11,6 +11,7 @@
 #include "syshead.h"
 #include "error.h"
 #include "misc.h"
+#include "run_command.h"
 
 int
 set_lladdr(const char *ifname, const char *lladdr,
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 85cdc95d..71fa2135 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -51,9 +51,6 @@
 const char *iproute_path = IPROUTE_PATH; /* GLOBAL */
 #endif
 
-/* contains an SSEC_x value defined in misc.h */
-int script_security = SSEC_BUILT_IN; /* GLOBAL */
-
 /*
  * Set standard file descriptors to /dev/null
  */
@@ -98,221 +95,6 @@ save_inetd_socket_descriptor(void)
 #endif
 }
 
-/*
- * Print an error message based on the status code returned by system().
- */
-const char *
-system_error_message(int stat, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(256, gc);
-#ifdef _WIN32
-    if (stat == -1)
-    {
-        buf_printf(&out, "external program did not execute -- ");
-    }
-    buf_printf(&out, "returned error code %d", stat);
-#else  /* ifdef _WIN32 */
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
-#endif /* ifdef _WIN32 */
-    return (const char *)out.data;
-}
-
-/*
- * Wrapper around openvpn_execve
- */
-bool
-openvpn_execve_check(const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message)
-{
-    struct gc_arena gc = gc_new();
-    const int stat = openvpn_execve(a, es, flags);
-    int ret = false;
-
-    if (platform_system_ok(stat))
-    {
-        ret = true;
-    }
-    else
-    {
-        if (error_message)
-        {
-            msg(((flags & S_FATAL) ? M_FATAL : M_WARN), "%s: %s",
-                error_message,
-                system_error_message(stat, &gc));
-        }
-    }
-    gc_free(&gc);
-    return ret;
-}
-
-bool
-openvpn_execve_allowed(const unsigned int flags)
-{
-    if (flags & S_SCRIPT)
-    {
-        return script_security >= SSEC_SCRIPTS;
-    }
-    else
-    {
-        return script_security >= SSEC_BUILT_IN;
-    }
-}
-
-
-#ifndef _WIN32
-/*
- * Run execve() inside a fork().  Designed to replicate the semantics of system() but
- * in a safer way that doesn't require the invocation of a shell or the risks
- * assocated with formatting and parsing a command line.
- */
-int
-openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
-{
-    struct gc_arena gc = gc_new();
-    int ret = -1;
-    static bool warn_shown = false;
-
-    if (a && a->argv[0])
-    {
-#if defined(ENABLE_FEATURE_EXECVE)
-        if (openvpn_execve_allowed(flags))
-        {
-            const char *cmd = a->argv[0];
-            char *const *argv = a->argv;
-            char *const *envp = (char *const *)make_env_array(es, true, &gc);
-            pid_t pid;
-
-            pid = fork();
-            if (pid == (pid_t)0) /* child side */
-            {
-                execve(cmd, argv, envp);
-                exit(127);
-            }
-            else if (pid < (pid_t)0) /* fork failed */
-            {
-                msg(M_ERR, "openvpn_execve: unable to fork");
-            }
-            else /* parent side */
-            {
-                if (waitpid(pid, &ret, 0) != pid)
-                {
-                    ret = -1;
-                }
-            }
-        }
-        else if (!warn_shown && (script_security < SSEC_SCRIPTS))
-        {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            warn_shown = true;
-        }
-#else  /* if defined(ENABLE_FEATURE_EXECVE) */
-        msg(M_WARN, "openvpn_execve: execve function not available");
-#endif /* if defined(ENABLE_FEATURE_EXECVE) */
-    }
-    else
-    {
-        msg(M_FATAL, "openvpn_execve: called with empty argv");
-    }
-
-    gc_free(&gc);
-    return ret;
-}
-#endif /* ifndef _WIN32 */
-
-/*
- * Run execve() inside a fork(), duping stdout.  Designed to replicate the semantics of popen() but
- * in a safer way that doesn't require the invocation of a shell or the risks
- * assocated with formatting and parsing a command line.
- */
-int
-openvpn_popen(const struct argv *a,  const struct env_set *es)
-{
-    struct gc_arena gc = gc_new();
-    int ret = -1;
-    static bool warn_shown = false;
-
-    if (a && a->argv[0])
-    {
-#if defined(ENABLE_FEATURE_EXECVE)
-        if (script_security >= SSEC_BUILT_IN)
-        {
-            const char *cmd = a->argv[0];
-            char *const *argv = a->argv;
-            char *const *envp = (char *const *)make_env_array(es, true, &gc);
-            pid_t pid;
-            int pipe_stdout[2];
-
-            if (pipe(pipe_stdout) == 0)
-            {
-                pid = fork();
-                if (pid == (pid_t)0)       /* child side */
-                {
-                    close(pipe_stdout[0]);         /* Close read end */
-                    dup2(pipe_stdout[1],1);
-                    execve(cmd, argv, envp);
-                    exit(127);
-                }
-                else if (pid > (pid_t)0)       /* parent side */
-                {
-                    int status = 0;
-
-                    close(pipe_stdout[1]);        /* Close write end */
-                    waitpid(pid, &status, 0);
-                    ret = pipe_stdout[0];
-                }
-                else       /* fork failed */
-                {
-                    close(pipe_stdout[0]);
-                    close(pipe_stdout[1]);
-                    msg(M_ERR, "openvpn_popen: unable to fork %s", cmd);
-                }
-            }
-            else
-            {
-                msg(M_WARN, "openvpn_popen: unable to create stdout pipe for %s", cmd);
-                ret = -1;
-            }
-        }
-        else if (!warn_shown && (script_security < SSEC_SCRIPTS))
-        {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            warn_shown = true;
-        }
-#else  /* if defined(ENABLE_FEATURE_EXECVE) */
-        msg(M_WARN, "openvpn_popen: execve function not available");
-#endif /* if defined(ENABLE_FEATURE_EXECVE) */
-    }
-    else
-    {
-        msg(M_FATAL, "openvpn_popen: called with empty argv");
-    }
-
-    gc_free(&gc);
-    return ret;
-}
-
 /*
  * Prepend a random string to hostname to prevent DNS caching.
  * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index c23d4cd1..14abb0f3 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -38,30 +38,6 @@
 /* forward declarations */
 struct plugin_list;
 
-/* system flags */
-#define S_SCRIPT (1<<0)
-#define S_FATAL  (1<<1)
-
-const char *system_error_message(int, struct gc_arena *gc);
-
-/* wrapper around the execve() call */
-int openvpn_popen(const struct argv *a,  const struct env_set *es);
-
-int openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
-
-bool openvpn_execve_check(const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message);
-
-bool openvpn_execve_allowed(const unsigned int flags);
-
-static inline bool
-openvpn_run_script(const struct argv *a, const struct env_set *es, const unsigned int flags, const char *hook)
-{
-    char msg[256];
-
-    openvpn_snprintf(msg, sizeof(msg), "WARNING: Failed running command (%s)", hook);
-    return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
-}
-
 
 /* Set standard file descriptors to /dev/null */
 void set_std_files_to_null(bool stdin_only);
@@ -198,14 +174,6 @@ void get_user_pass_auto_userid(struct user_pass *up, const char *tag);
 extern const char *iproute_path;
 #endif
 
-/* Script security */
-#define SSEC_NONE      0 /* strictly no calling of external programs */
-#define SSEC_BUILT_IN  1 /* only call built-in programs such as ifconfig, route, netsh, etc.*/
-#define SSEC_SCRIPTS   2 /* allow calling of built-in programs and user-defined scripts */
-#define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-defined scripts that may receive a password as an environmental variable */
-extern int script_security; /* GLOBAL */
-
-
 #define COMPAT_FLAG_QUERY         0       /** compat_flags operator: Query for a flag */
 #define COMPAT_FLAG_SET           (1<<0)  /** compat_flags operator: Set a compat flag */
 #define COMPAT_NAMES              (1<<1)  /** compat flag: --compat-names set */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2944eef2..db32500d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -38,7 +38,7 @@
 
 #include "multi.h"
 #include "push.h"
-#include "misc.h"
+#include "run_command.h"
 #include "otime.h"
 #include "gremlin.h"
 #include "mstats.h"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 426057ab..b89f4ba2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -41,6 +41,7 @@
 #include "buffer.h"
 #include "error.h"
 #include "common.h"
+#include "run_command.h"
 #include "shaper.h"
 #include "crypto.h"
 #include "ssl.h"
@@ -6379,7 +6380,7 @@ add_option(struct options *options,
     else if (streq(p[0], "script-security") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        script_security = atoi(p[1]);
+        script_security_set(atoi(p[1]));
     }
     else if (streq(p[0], "mssfix") && !p[2])
     {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f6962848..ff392308 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -36,7 +36,7 @@
 #include "common.h"
 #include "error.h"
 #include "route.h"
-#include "misc.h"
+#include "run_command.h"
 #include "socket.h"
 #include "manage.h"
 #include "win32.h"
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
new file mode 100644
index 00000000..4e198676
--- /dev/null
+++ b/src/openvpn/run_command.c
@@ -0,0 +1,267 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "buffer.h"
+#include "error.h"
+#include "platform.h"
+#include "win32.h"
+
+#include "memdbg.h"
+
+#include "run_command.h"
+
+/* contains an SSEC_x value defined in platform.h */
+static int script_security_level = SSEC_BUILT_IN; /* GLOBAL */
+
+int script_security(void)
+{
+    return script_security_level;
+}
+
+void script_security_set(int level)
+{
+    script_security_level = level;
+}
+
+/*
+ * Print an error message based on the status code returned by system().
+ */
+static const char *
+system_error_message(int stat, struct gc_arena *gc)
+{
+    struct buffer out = alloc_buf_gc(256, gc);
+#ifdef _WIN32
+    if (stat == -1)
+    {
+        buf_printf(&out, "external program did not execute -- ");
+    }
+    buf_printf(&out, "returned error code %d", stat);
+#else  /* ifdef _WIN32 */
+    if (stat == -1)
+    {
+        buf_printf(&out, "external program fork failed");
+    }
+    else if (!WIFEXITED(stat))
+    {
+        buf_printf(&out, "external program did not exit normally");
+    }
+    else
+    {
+        const int cmd_ret = WEXITSTATUS(stat);
+        if (!cmd_ret)
+        {
+            buf_printf(&out, "external program exited normally");
+        }
+        else if (cmd_ret == 127)
+        {
+            buf_printf(&out, "could not execute external program");
+        }
+        else
+        {
+            buf_printf(&out, "external program exited with error status: %d", cmd_ret);
+        }
+    }
+#endif /* ifdef _WIN32 */
+    return (const char *)out.data;
+}
+
+bool
+openvpn_execve_allowed(const unsigned int flags)
+{
+    if (flags & S_SCRIPT)
+    {
+        return script_security() >= SSEC_SCRIPTS;
+    }
+    else
+    {
+        return script_security() >= SSEC_BUILT_IN;
+    }
+}
+
+
+#ifndef _WIN32
+/*
+ * Run execve() inside a fork().  Designed to replicate the semantics of system() but
+ * in a safer way that doesn't require the invocation of a shell or the risks
+ * assocated with formatting and parsing a command line.
+ */
+int
+openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
+{
+    struct gc_arena gc = gc_new();
+    int ret = -1;
+    static bool warn_shown = false;
+
+    if (a && a->argv[0])
+    {
+#if defined(ENABLE_FEATURE_EXECVE)
+        if (openvpn_execve_allowed(flags))
+        {
+            const char *cmd = a->argv[0];
+            char *const *argv = a->argv;
+            char *const *envp = (char *const *)make_env_array(es, true, &gc);
+            pid_t pid;
+
+            pid = fork();
+            if (pid == (pid_t)0) /* child side */
+            {
+                execve(cmd, argv, envp);
+                exit(127);
+            }
+            else if (pid < (pid_t)0) /* fork failed */
+            {
+                msg(M_ERR, "openvpn_execve: unable to fork");
+            }
+            else /* parent side */
+            {
+                if (waitpid(pid, &ret, 0) != pid)
+                {
+                    ret = -1;
+                }
+            }
+        }
+        else if (!warn_shown && (script_security() < SSEC_SCRIPTS))
+        {
+            msg(M_WARN, SCRIPT_SECURITY_WARNING);
+            warn_shown = true;
+        }
+#else  /* if defined(ENABLE_FEATURE_EXECVE) */
+        msg(M_WARN, "openvpn_execve: execve function not available");
+#endif /* if defined(ENABLE_FEATURE_EXECVE) */
+    }
+    else
+    {
+        msg(M_FATAL, "openvpn_execve: called with empty argv");
+    }
+
+    gc_free(&gc);
+    return ret;
+}
+#endif /* ifndef _WIN32 */
+
+/*
+ * Wrapper around openvpn_execve
+ */
+bool
+openvpn_execve_check(const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message)
+{
+    struct gc_arena gc = gc_new();
+    const int stat = openvpn_execve(a, es, flags);
+    int ret = false;
+
+    if (platform_system_ok(stat))
+    {
+        ret = true;
+    }
+    else
+    {
+        if (error_message)
+        {
+            msg(((flags & S_FATAL) ? M_FATAL : M_WARN), "%s: %s",
+                error_message,
+                system_error_message(stat, &gc));
+        }
+    }
+    gc_free(&gc);
+    return ret;
+}
+
+/*
+ * Run execve() inside a fork(), duping stdout.  Designed to replicate the semantics of popen() but
+ * in a safer way that doesn't require the invocation of a shell or the risks
+ * assocated with formatting and parsing a command line.
+ */
+int
+openvpn_popen(const struct argv *a,  const struct env_set *es)
+{
+    struct gc_arena gc = gc_new();
+    int ret = -1;
+    static bool warn_shown = false;
+
+    if (a && a->argv[0])
+    {
+#if defined(ENABLE_FEATURE_EXECVE)
+        if (script_security() >= SSEC_BUILT_IN)
+        {
+            const char *cmd = a->argv[0];
+            char *const *argv = a->argv;
+            char *const *envp = (char *const *)make_env_array(es, true, &gc);
+            pid_t pid;
+            int pipe_stdout[2];
+
+            if (pipe(pipe_stdout) == 0)
+            {
+                pid = fork();
+                if (pid == (pid_t)0)       /* child side */
+                {
+                    close(pipe_stdout[0]);         /* Close read end */
+                    dup2(pipe_stdout[1],1);
+                    execve(cmd, argv, envp);
+                    exit(127);
+                }
+                else if (pid > (pid_t)0)       /* parent side */
+                {
+                    int status = 0;
+
+                    close(pipe_stdout[1]);        /* Close write end */
+                    waitpid(pid, &status, 0);
+                    ret = pipe_stdout[0];
+                }
+                else       /* fork failed */
+                {
+                    close(pipe_stdout[0]);
+                    close(pipe_stdout[1]);
+                    msg(M_ERR, "openvpn_popen: unable to fork %s", cmd);
+                }
+            }
+            else
+            {
+                msg(M_WARN, "openvpn_popen: unable to create stdout pipe for %s", cmd);
+                ret = -1;
+            }
+        }
+        else if (!warn_shown && (script_security() < SSEC_SCRIPTS))
+        {
+            msg(M_WARN, SCRIPT_SECURITY_WARNING);
+            warn_shown = true;
+        }
+#else  /* if defined(ENABLE_FEATURE_EXECVE) */
+        msg(M_WARN, "openvpn_popen: execve function not available");
+#endif /* if defined(ENABLE_FEATURE_EXECVE) */
+    }
+    else
+    {
+        msg(M_FATAL, "openvpn_popen: called with empty argv");
+    }
+
+    gc_free(&gc);
+    return ret;
+}
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
new file mode 100644
index 00000000..4501a5cc
--- /dev/null
+++ b/src/openvpn/run_command.h
@@ -0,0 +1,63 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef RUN_COMMAND_H
+#define RUN_COMMAND_H
+
+#include "basic.h"
+#include "env_set.h"
+
+/* Script security */
+#define SSEC_NONE      0 /* strictly no calling of external programs */
+#define SSEC_BUILT_IN  1 /* only call built-in programs such as ifconfig, route, netsh, etc.*/
+#define SSEC_SCRIPTS   2 /* allow calling of built-in programs and user-defined scripts */
+#define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-defined scripts that may receive a password as an environmental variable */
+
+int script_security(void);
+
+void script_security_set(int level);
+
+/* openvpn_execve flags */
+#define S_SCRIPT (1<<0)
+#define S_FATAL  (1<<1)
+
+/* wrapper around the execve() call */
+int openvpn_popen(const struct argv *a,  const struct env_set *es);
+
+bool openvpn_execve_allowed(const unsigned int flags);
+
+bool openvpn_execve_check(const struct argv *a, const struct env_set *es,
+                          const unsigned int flags, const char *error_message);
+
+static inline bool
+openvpn_run_script(const struct argv *a, const struct env_set *es,
+                   const unsigned int flags, const char *hook)
+{
+    char msg[256];
+
+    openvpn_snprintf(msg, sizeof(msg),
+                     "WARNING: Failed running command (%s)", hook);
+    return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
+}
+
+#endif /* ifndef RUN_COMMAND_H */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 211e7441..911b2335 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -35,6 +35,7 @@
 #include "gremlin.h"
 #include "plugin.h"
 #include "ps.h"
+#include "run_command.h"
 #include "manage.h"
 #include "misc.h"
 #include "manage.h"
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a3699252..61872251 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -34,10 +34,10 @@
 
 #include "syshead.h"
 
-#include "misc.h"
+#include "base64.h"
 #include "manage.h"
 #include "otime.h"
-#include "base64.h"
+#include "run_command.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 26baa206..1c7e51d9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -40,7 +40,7 @@
 #include "tun.h"
 #include "fdmisc.h"
 #include "common.h"
-#include "misc.h"
+#include "run_command.h"
 #include "socket.h"
 #include "manage.h"
 #include "route.h"
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 29bbb841..3905524a 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -39,9 +39,9 @@
 #include "buffer.h"
 #include "error.h"
 #include "mtu.h"
+#include "run_command.h"
 #include "sig.h"
 #include "win32.h"
-#include "misc.h"
 #include "openvpn-msg.h"
 
 #include "memdbg.h"
@@ -1137,7 +1137,7 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             free(env);
             gc_free(&gc);
         }
-        else if (!exec_warn && (script_security < SSEC_SCRIPTS))
+        else if (!exec_warn && (script_security() < SSEC_SCRIPTS))
         {
             msg(M_WARN, SCRIPT_SECURITY_WARNING);
             exec_warn = true;
-- 
2.17.1


