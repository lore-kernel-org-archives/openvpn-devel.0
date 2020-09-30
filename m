From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:12 +0200
Message-Id: <20200930131317.1299-8-arne@...1227...>
In-Reply-To: <20200930131317.1299-1-arne@...1227...>
References: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 06/11] Add S_EXITCODE flag for
 openvpn_run_script to report exit code
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

This allows to use script that have more than just fail/sucess but
also deferred as status

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/platform.c    | 35 +++++++++++++++++++++++++++++++++++
 src/openvpn/platform.h    |  5 ++++-
 src/openvpn/run_command.c | 25 ++++++++++++++++---------
 src/openvpn/run_command.h | 14 ++++++++++----
 4 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 53d07f9c..5545a133 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -240,6 +240,41 @@ platform_system_ok(int stat)
 #endif
 }
 
+#ifdef _WIN32
+int
+platform_ret_code(int stat)
+{
+
+    if (stat >= 0 && stat < 255)
+    {
+        return stat;
+    }
+    else
+    {
+        return -1;
+    }
+}
+#else
+int
+platform_ret_code(int stat)
+{
+    if (!WIFEXITED(stat) || stat == -1)
+    {
+        return -1;
+    }
+
+    int status = WEXITSTATUS(stat);
+    if (status >= 0 && status < 255)
+    {
+        return status;
+    }
+    else
+    {
+        return -1;
+    }
+}
+#endif
+
 int
 platform_access(const char *path, int mode)
 {
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 091fc9c4..c7f6aae1 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -119,9 +119,12 @@ void platform_mlockall(bool print_msg);  /* Disable paging */
 
 int platform_chdir(const char *dir);
 
-/* interpret the status code returned by execve() */
+/** interpret the status code returned by execve() */
 bool platform_system_ok(int stat);
 
+/** Return a return code if valid and between 0 and 255, -1 otherwise */
+int platform_ret_code(int stat);
+
 int platform_access(const char *path, int mode);
 
 void platform_sleep_milliseconds(unsigned int n);
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 4c4adf97..c1dd102c 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -191,27 +191,34 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
 /*
  * Wrapper around openvpn_execve
  */
-bool
+int
 openvpn_execve_check(const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message)
 {
     struct gc_arena gc = gc_new();
     const int stat = openvpn_execve(a, es, flags);
     int ret = false;
 
-    if (platform_system_ok(stat))
+    if(flags & S_EXITCODE)
+    {
+        ret = platform_ret_code(stat);
+        if (ret != -1) {
+            goto done;
+        }
+    }
+    else if (platform_system_ok(stat))
     {
         ret = true;
+        goto done;
     }
-    else
+    if (error_message)
     {
-        if (error_message)
-        {
-            msg(((flags & S_FATAL) ? M_FATAL : M_WARN), "%s: %s",
-                error_message,
-                system_error_message(stat, &gc));
-        }
+        msg(((flags & S_FATAL) ? M_FATAL : M_WARN), "%s: %s",
+            error_message,
+            system_error_message(stat, &gc));
     }
+done:
     gc_free(&gc);
+
     return ret;
 }
 
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 7ccb13c6..e322ebd1 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -42,18 +42,24 @@ int script_security(void);
 void script_security_set(int level);
 
 /* openvpn_execve flags */
-#define S_SCRIPT (1<<0)
-#define S_FATAL  (1<<1)
+#define S_SCRIPT    (1<<0)
+#define S_FATAL     (1<<1)
+/** Instead of returning 1/0 for success/fail,
+ * return exit code when between 0 and 255 and -1 otherwise */
+#define S_EXITCODE  (1<<2)
 
 /* wrapper around the execve() call */
 int openvpn_popen(const struct argv *a,  const struct env_set *es);
 
 bool openvpn_execve_allowed(const unsigned int flags);
 
-bool openvpn_execve_check(const struct argv *a, const struct env_set *es,
+int openvpn_execve_check(const struct argv *a, const struct env_set *es,
                           const unsigned int flags, const char *error_message);
 
-static inline bool
+/**
+ * Will run a script and return the exit code if it
+ */
+static inline int
 openvpn_run_script(const struct argv *a, const struct env_set *es,
                    const unsigned int flags, const char *hook)
 {
-- 
2.26.2


