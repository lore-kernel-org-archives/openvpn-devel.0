From: Simon Rozman <simon@...2293...>
Date: Sun,  3 Dec 2017 21:20:51 +0100
Message-Id: <20171203202051.7848-1-simon@...2293...>
In-Reply-To: <CAKuzo_jFkLexh20dyeX-kSqCLyhGWmVKsC+DBwF+3sAi2optyA@...278...>
References: <CAKuzo_jFkLexh20dyeX-kSqCLyhGWmVKsC+DBwF+3sAi2optyA@...278...>
Subject: [Openvpn-devel] [PATCH] openvpnserv: Review MSVC down-casting
 warnings
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

Data size arithmetic was reviewed according to 64-bit MSVC complaints.

The warnings were addressed by migrating to size_t, rewriting the code,
or silencing the warnings by an explicit cast where appropriate.
---
 src/openvpnserv/automatic.c   | 19 +++++++------------
 src/openvpnserv/interactive.c | 12 ++++++------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 75c3be2..28f21cc 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -115,25 +115,20 @@ close_if_open(HANDLE h)
 static bool
 match(const WIN32_FIND_DATA *find, LPCTSTR ext)
 {
-    int i;
-
     if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
     {
         return false;
     }
 
-    if (!_tcslen(ext))
-    {
-        return true;
-    }
-
-    i = _tcslen(find->cFileName) - _tcslen(ext) - 1;
-    if (i < 1)
+    if (*ext == TEXT('\0'))
     {
         return false;
     }
 
-    return find->cFileName[i] == '.' && !_tcsicmp(find->cFileName + i + 1, ext);
+    /* find the pointer to that last '.' in filename and match ext against the rest */
+
+    const TCHAR *p = _tcsrchr(find->cFileName, TEXT('.'));
+    return p && p != find->cFileName && _tcsicmp(p + 1, ext) == 0;
 }
 
 /*
@@ -142,14 +137,14 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
 static bool
 modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
 {
-    int i;
+    size_t i;
 
     if (size > 0 && (_tcslen(src) + 1) <= size)
     {
         _tcscpy(dest, src);
         dest [size - 1] = TEXT('\0');
         i = _tcslen(dest);
-        while (--i >= 0)
+        while (i-- > 0)
         {
             if (dest[i] == TEXT('\\'))
             {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ed4603e..5d58ceb 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -280,7 +280,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
     swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
     buf[_countof(buf) - 1] = '\0';
 
-    WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
+    WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
 }
 
 static VOID
@@ -308,7 +308,7 @@ ReturnError(HANDLE pipe, DWORD error, LPCWSTR func, DWORD count, LPHANDLE events
                                 L"0x%1!08x!\n%2!s!\n%3!s!", 0, 0,
                                 (LPWSTR) &result, 0, (va_list *) args);
 
-    WritePipeAsync(pipe, result, wcslen(result) * 2, count, events);
+    WritePipeAsync(pipe, result, (DWORD)(wcslen(result) * 2), count, events);
 #ifdef UNICODE
     MsgToEventLog(MSG_FLAGS_ERROR, result);
 #else
@@ -452,10 +452,10 @@ out:
 static BOOL
 GetStartupData(HANDLE pipe, STARTUP_DATA *sud)
 {
-    size_t len;
+    size_t size, len;
     BOOL ret = FALSE;
     WCHAR *data = NULL;
-    DWORD size, bytes, read;
+    DWORD bytes, read;
 
     bytes = PeekNamedPipeAsync(pipe, 1, &exit_event);
     if (bytes == 0)
@@ -1051,7 +1051,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     const wchar_t *fmt = L"netsh interface %s %s dns \"%s\" %s";
 
     /* max cmdline length in wchars -- include room for worst case and some */
-    int ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
+    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
     wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1571,7 +1571,7 @@ RunOpenvpn(LPVOID p)
     {
         DWORD written;
         WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, input, input_size, NULL, NULL);
-        WriteFile(stdin_write, input, strlen(input), &written, NULL);
+        WriteFile(stdin_write, input, (DWORD)strlen(input), &written, NULL);
         free(input);
     }
 
-- 
2.9.0.windows.1

Hi,

My mistake. Here's the v4 of the patch.

Regards,
Simon

