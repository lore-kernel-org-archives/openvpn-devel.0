From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 18 Jun 2021 18:52:41 +0300
Message-Id: <20210618155241.400-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix management password prompt with
 redirected log
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

When management interface is password protected, openvpn
writes "Enter Management Password" to stderr. As it turns out,
when log is redirected to a file, that prompt is also written to that
file and not to the "original" stderr. Moreover, on recent Insider build
(21390.2025) openvpn exits with fatal error

  get_console_input_win32(): unexpected error: No such device or address (errno=6)

while attempting to write that prompt.

When redirecting stdout/stderr, we use _dup2() to associate stderr
descriptor with the log file. This call closes file associated
with stderr descriptor, which might explain why it has stopped
working (original stderr is closed and WriteFile() fails) and on
current versions it appears to work "by accident" - not failing
but use redirected stderr instead of original one.

I played a bit with DuplicateHandle() for STD_ERROR_HANDLE
but got the same behavior.

Fix fatal error on Insider build by always writing prompt
to the new stderr and removing concept of "orig_stderr".
For current Windows releases behavior doesn't change.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/console_builtin.c |  2 +-
 src/openvpn/error.c           | 31 -------------------------------
 src/openvpn/error.h           |  6 ------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 9bf36347..31214536 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -73,7 +73,7 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
     input[0] = '\0';
 
     in = GetStdHandle(STD_INPUT_HANDLE);
-    err = get_orig_stderr();
+    err = GetStdHandle(STD_ERROR_HANDLE);
 
     if (in == INVALID_HANDLE_VALUE
         || err == INVALID_HANDLE_VALUE
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b94d387c..e807435c 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -490,25 +490,6 @@ close_syslog(void)
 #endif
 }
 
-#ifdef _WIN32
-
-static HANDLE orig_stderr;
-
-HANDLE
-get_orig_stderr(void)
-{
-    if (orig_stderr)
-    {
-        return orig_stderr;
-    }
-    else
-    {
-        return GetStdHandle(STD_ERROR_HANDLE);
-    }
-}
-
-#endif
-
 void
 redirect_stdout_stderr(const char *file, bool append)
 {
@@ -549,18 +530,6 @@ redirect_stdout_stderr(const char *file, bool append)
             }
         }
 
-        /* save original stderr for password prompts */
-        orig_stderr = GetStdHandle(STD_ERROR_HANDLE);
-
-#if 0 /* seems not be necessary with stdout/stderr redirection below*/
-        /* set up for redirection */
-        if (!SetStdHandle(STD_OUTPUT_HANDLE, log_handle)
-            || !SetStdHandle(STD_ERROR_HANDLE, log_handle))
-        {
-            msg(M_ERR, "Error: cannot redirect stdout/stderr to --log file: %s", file);
-        }
-#endif
-
         /* direct stdout/stderr to point to log_handle */
         log_fd = _open_osfhandle((intptr_t)log_handle, _O_TEXT);
         if (log_fd == -1)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index f4528ef2..b91e54fb 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -255,12 +255,6 @@ void close_syslog(void);
 /* log file output */
 void redirect_stdout_stderr(const char *file, bool append);
 
-#ifdef _WIN32
-/* get original stderr handle, even if redirected by --log/--log-append */
-HANDLE get_orig_stderr(void);
-
-#endif
-
 /* exit program */
 void openvpn_exit(const int status);
 
-- 
2.23.0.windows.1


