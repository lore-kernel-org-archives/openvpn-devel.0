From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 24 Jun 2021 11:39:18 +0300
Message-Id: <20210624083918.106-1-lstipakov@...277...>
In-Reply-To: <20210618155241.400-1-lstipakov@...277...>
References: <20210618155241.400-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] Fix console prompts with redirected log
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

When openvpn nees to prompt user for a password
(for example, to set management interface password),
the prompt is written to standard error device.

When log is redirected to a file, that prompt is written
to that file and not to the "original" stderr. Moreover, on recent
Insider build (21390.2025) openvpn exits with fatal error

  get_console_input_win32(): unexpected error: No such device or address (errno=6)

while attempting to write that prompt.

When redirecting stdout/stderr, we use _dup2() to associate stderr
descriptor with a log file. This call closes file associated
with stderr descriptor, which might explain why it has stopped
working (original stderr is closed and WriteFile() fails) and on
current versions it appears to work "by accident" - not failing
but use redirected stderr instead of original one.

Fix by creating new file descriptor with _dup() for stderr
before redirect and use this descriptor for writing prompts.

While on it, make code a bit more C99-ish by moving variables
declaration from the beginning of the scope to the actual
initialisation.

Signed-off-by: Lev Stipakov <lev@...515...>
---

  v2: actually fix the prompt by displaying it in console
instead of writing to log

 src/openvpn/console_builtin.c | 16 +++++++---------
 src/openvpn/error.c           | 28 +++++++---------------------
 src/openvpn/error.h           |  4 ++--
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 3214cb5f..2340da6e 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -62,23 +62,19 @@
 static bool
 get_console_input_win32(const char *prompt, const bool echo, char *input, const int capacity)
 {
-    HANDLE in = INVALID_HANDLE_VALUE;
-    HANDLE err = INVALID_HANDLE_VALUE;
-    DWORD len = 0;
-
     ASSERT(prompt);
     ASSERT(input);
     ASSERT(capacity > 0);
 
     input[0] = '\0';
 
-    in = GetStdHandle(STD_INPUT_HANDLE);
-    err = get_orig_stderr();
+    HANDLE in = GetStdHandle(STD_INPUT_HANDLE);
+    int err = get_orig_stderr();
 
     if (in != INVALID_HANDLE_VALUE
-        && err != INVALID_HANDLE_VALUE
+        && err != -1
         && !win32_service_interrupt(&win32_signal)
-        && WriteFile(err, prompt, strlen(prompt), &len, NULL))
+        && (_write(err, prompt, strlen(prompt)) != -1))
     {
         bool is_console = (GetFileType(in) == FILE_TYPE_CHAR);
         DWORD flags_save = 0;
@@ -102,6 +98,8 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
             }
         }
 
+        DWORD len = 0;
+
         if (is_console)
         {
             winput = malloc(capacity * sizeof(WCHAR));
@@ -124,7 +122,7 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
 
         if (!echo)
         {
-            WriteFile(err, "\r\n", 2, &len, NULL);
+            _write(err, "\r\n", 2);
         }
         if (is_console)
         {
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b94d387c..eb82f9c7 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -491,22 +491,12 @@ close_syslog(void)
 }
 
 #ifdef _WIN32
+static int orig_stderr;
 
-static HANDLE orig_stderr;
-
-HANDLE
-get_orig_stderr(void)
+int get_orig_stderr()
 {
-    if (orig_stderr)
-    {
-        return orig_stderr;
-    }
-    else
-    {
-        return GetStdHandle(STD_ERROR_HANDLE);
-    }
+    return orig_stderr ? orig_stderr : _fileno(stderr);
 }
-
 #endif
 
 void
@@ -550,16 +540,12 @@ redirect_stdout_stderr(const char *file, bool append)
         }
 
         /* save original stderr for password prompts */
-        orig_stderr = GetStdHandle(STD_ERROR_HANDLE);
-
-#if 0 /* seems not be necessary with stdout/stderr redirection below*/
-        /* set up for redirection */
-        if (!SetStdHandle(STD_OUTPUT_HANDLE, log_handle)
-            || !SetStdHandle(STD_ERROR_HANDLE, log_handle))
+        orig_stderr = _dup(_fileno(stderr));
+        if (orig_stderr == -1)
         {
-            msg(M_ERR, "Error: cannot redirect stdout/stderr to --log file: %s", file);
+            msg(M_WARN | M_ERRNO, "Warning: cannot duplicate stderr, password prompts will appear in log file instead of console.");
+            orig_stderr = _fileno(stderr);
         }
-#endif
 
         /* direct stdout/stderr to point to log_handle */
         log_fd = _open_osfhandle((intptr_t)log_handle, _O_TEXT);
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index f4528ef2..533354b3 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -256,8 +256,8 @@ void close_syslog(void);
 void redirect_stdout_stderr(const char *file, bool append);
 
 #ifdef _WIN32
-/* get original stderr handle, even if redirected by --log/--log-append */
-HANDLE get_orig_stderr(void);
+/* get original stderr fd, even if redirected by --log/--log-append */
+int get_orig_stderr(void);
 
 #endif
 
-- 
2.23.0.windows.1


