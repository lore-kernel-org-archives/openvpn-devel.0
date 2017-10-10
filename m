From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:29 +0200
Message-Id: <20171010231130.6832-12-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 12/13] Memory size arithmetic reviewed
 according to 64-bit MSVC complaints
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

From: Simon Rozman <simon@...2293...>

---
 src/openvpnserv/automatic.c   | 14 ++++++++------
 src/openvpnserv/interactive.c | 12 ++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 6c39aaa..3e8f6ed 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -130,24 +130,26 @@ close_if_open(HANDLE h)
 static bool
 match(const WIN32_FIND_DATA *find, LPCTSTR ext)
 {
-    int i;
+    size_t i, len_filename, len_ext;
 
     if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
     {
         return false;
     }
 
-    if (!_tcslen(ext))
+    len_ext = _tcslen(ext);
+    if (!len_ext)
     {
         return true;
     }
 
-    i = _tcslen(find->cFileName) - _tcslen(ext) - 1;
-    if (i < 1)
+    len_filename = _tcslen(find->cFileName);
+    if (len_filename < len_ext + 2)
     {
         return false;
     }
 
+    i = len_filename - len_ext - 1;
     return find->cFileName[i] == '.' && !_tcsicmp(find->cFileName + i + 1, ext);
 }
 
@@ -157,14 +159,14 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
 static bool
 modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
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
index 96e0de0..9a4c01a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -280,7 +280,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
     _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
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
@@ -1163,7 +1163,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     const wchar_t *fmt = L"netsh interface %s %s dns \"%s\" %s";
 
     /* max cmdline length in wchars -- include room for worst case and some */
-    int ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
+    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
     wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1683,7 +1683,7 @@ RunOpenvpn(LPVOID p)
     {
         DWORD written;
         WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, input, input_size, NULL, NULL);
-        WriteFile(stdin_write, input, strlen(input), &written, NULL);
+        WriteFile(stdin_write, input, (DWORD)strlen(input), &written, NULL);
         free(input);
     }
 
-- 
2.9.0.windows.1


