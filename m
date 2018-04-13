From: Simon Rozman <simon@...2293...>
Date: Fri, 13 Apr 2018 14:47:56 +0200
Message-Id: <20180413124756.5756-1-simon@...2293...>
In-Reply-To: <20180125160037.GT69387@...1296...>
References: <20180125160037.GT69387@...1296...>
Subject: [Openvpn-devel] [PATCH v2 09/13] Signed/unsigned warnings of MSVC
 resolved
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

This patch fixes the signed/unsigned comparison warnings discovered when
compiling openvpnserv using MSVC.

Wherever possible, it changes iterator and/or size variables to a more
appropriate type, or uses type-casting when it is safe to do so.
---
 src/openvpnserv/automatic.c   | 2 +-
 src/openvpnserv/common.c      | 2 +-
 src/openvpnserv/interactive.c | 7 +++----
 src/openvpnserv/validate.c    | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 1f98283..89367fc 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -135,7 +135,7 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
  * Modify the extension on a filename.
  */
 static bool
-modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
+modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
 {
     size_t i;
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index dc47666..59f73bd 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -40,7 +40,7 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
         len = _vsntprintf(str, size, format, arglist);
         str[size - 1] = 0;
     }
-    return (len >= 0 && len < size);
+    return (len >= 0 && (size_t)len < size);
 }
 int
 openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index fbc32f9..66ffeec 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -188,7 +188,7 @@ typedef enum {
 static DWORD
 AsyncPipeOp(async_op_t op, HANDLE pipe, LPVOID buffer, DWORD size, DWORD count, LPHANDLE events)
 {
-    int i;
+    DWORD i;
     BOOL success;
     HANDLE io_event;
     DWORD res, bytes = 0;
@@ -934,7 +934,7 @@ static DWORD WINAPI
 RegisterDNS(LPVOID unused)
 {
     DWORD err;
-    DWORD i;
+    size_t i;
     WCHAR sys_path[MAX_PATH];
     DWORD timeout = RDNS_TIMEOUT * 1000; /* in milliseconds */
 
@@ -950,7 +950,6 @@ RegisterDNS(LPVOID unused)
         { ipcfg, L"ipconfig /flushdns",    timeout },
         { ipcfg, L"ipconfig /registerdns", timeout },
     };
-    int ncmds = sizeof(cmds) / sizeof(cmds[0]);
 
     HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
 
@@ -963,7 +962,7 @@ RegisterDNS(LPVOID unused)
     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
     {
         /* Semaphore locked */
-        for (i = 0; i < ncmds; ++i)
+        for (i = 0; i < _countof(cmds); ++i)
         {
             ExecCommand(cmds[i].argv0, cmds[i].cmdline, cmds[i].timeout);
         }
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 653bd12..26ffa8f 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -298,7 +298,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_groups, const WCHAR *group_nam
             break;
         }
         /* If a match is already found, ret == TRUE and the loop is skipped */
-        for (int i = 0; i < nread && !ret; ++i)
+        for (DWORD i = 0; i < nread && !ret; ++i)
         {
             ret = EqualSid(members[i].lgrmi0_sid, sid);
         }
-- 
2.9.0.windows.1

