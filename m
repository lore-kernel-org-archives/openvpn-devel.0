From: Gert Doering <gert@...1296...>
Date: Fri, 18 Jun 2021 20:12:46 +0200
Message-Id: <20210618181246.30769-1-gert@...1296...>
In-Reply-To: <20210618171933.28985-1-gert@...1296...>
References: <20210618171933.28985-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add error reporting to
 get_console_input_win32().
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

When the function setup fails due to invalid file handles, or because
WriteFile(err, ...) fails (due to file handle corruption elsewhere),
the function used to silently "return false"

Change this to print a M_WARN|M_ERRNO message.

Also, change the function style to early-return style (= large diff, but
most are indent changes only).

v2: fix spurious "}" that was left over from change to early-return.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/console_builtin.c | 95 ++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 3214cb5f..9bf36347 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -75,65 +75,68 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
     in = GetStdHandle(STD_INPUT_HANDLE);
     err = get_orig_stderr();
 
-    if (in != INVALID_HANDLE_VALUE
-        && err != INVALID_HANDLE_VALUE
-        && !win32_service_interrupt(&win32_signal)
-        && WriteFile(err, prompt, strlen(prompt), &len, NULL))
+    if (in == INVALID_HANDLE_VALUE
+        || err == INVALID_HANDLE_VALUE
+        || win32_service_interrupt(&win32_signal)
+        || !WriteFile(err, prompt, strlen(prompt), &len, NULL))
     {
-        bool is_console = (GetFileType(in) == FILE_TYPE_CHAR);
-        DWORD flags_save = 0;
-        int status = 0;
-        WCHAR *winput;
+        msg(M_WARN|M_ERRNO, "get_console_input_win32(): unexpected error");
+        return false;
+    }
 
-        if (is_console)
-        {
-            if (GetConsoleMode(in, &flags_save))
-            {
-                DWORD flags = ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
-                if (echo)
-                {
-                    flags |= ENABLE_ECHO_INPUT;
-                }
-                SetConsoleMode(in, flags);
-            }
-            else
-            {
-                is_console = 0;
-            }
-        }
+    bool is_console = (GetFileType(in) == FILE_TYPE_CHAR);
+    DWORD flags_save = 0;
+    int status = 0;
+    WCHAR *winput;
 
-        if (is_console)
+    if (is_console)
+    {
+        if (GetConsoleMode(in, &flags_save))
         {
-            winput = malloc(capacity * sizeof(WCHAR));
-            if (winput == NULL)
+            DWORD flags = ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
+            if (echo)
             {
-                return false;
+                flags |= ENABLE_ECHO_INPUT;
             }
-
-            status = ReadConsoleW(in, winput, capacity, &len, NULL);
-            WideCharToMultiByte(CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
-            free(winput);
+            SetConsoleMode(in, flags);
         }
         else
         {
-            status = ReadFile(in, input, capacity, &len, NULL);
+            is_console = 0;
         }
+    }
 
-        string_null_terminate(input, (int)len, capacity);
-        chomp(input);
-
-        if (!echo)
-        {
-            WriteFile(err, "\r\n", 2, &len, NULL);
-        }
-        if (is_console)
-        {
-            SetConsoleMode(in, flags_save);
-        }
-        if (status && !win32_service_interrupt(&win32_signal))
+    if (is_console)
+    {
+        winput = malloc(capacity * sizeof(WCHAR));
+        if (winput == NULL)
         {
-            return true;
+            return false;
         }
+
+        status = ReadConsoleW(in, winput, capacity, &len, NULL);
+        WideCharToMultiByte(CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
+        free(winput);
+    }
+    else
+    {
+        status = ReadFile(in, input, capacity, &len, NULL);
+    }
+
+    string_null_terminate(input, (int)len, capacity);
+    chomp(input);
+
+    if (!echo)
+    {
+        WriteFile(err, "\r\n", 2, &len, NULL);
+    }
+    if (is_console)
+    {
+        SetConsoleMode(in, flags_save);
+    }
+    if (status && !win32_service_interrupt(&win32_signal))
+    {
+        return true;
     }
 
     return false;
-- 
2.26.3


