From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:22:17 +0200
Message-Id: <1330546942-18250-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
References: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [openvpn-gui 3/8] debug: fix debug under unicode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 main.c    |   26 ++++++++++++++------------
 openvpn.c |    2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/main.c b/main.c
index 22c8bef..95a9dfc 100644
--- a/main.c
+++ b/main.c
@@ -120,7 +120,7 @@ int WINAPI WinMain (HINSTANCE hThisInstance,
       ShowLocalizedMsg(IDS_ERR_OPEN_DEBUG_FILE, DEBUG_FILE);
       exit(1);
     }
-  PrintDebug("Starting OpenVPN GUI v%s", PACKAGE_VERSION);
+  PrintDebug(_T("Starting OpenVPN GUI v%S"), PACKAGE_VERSION);
 #endif
 
 
@@ -146,7 +146,7 @@ int WINAPI WinMain (HINSTANCE hThisInstance,
       exit(1);
     }
 #ifdef DEBUG
-  PrintDebug("Shell32.dll version: 0x%lx", shell32_version);
+  PrintDebug(_T("Shell32.dll version: 0x%lx"), shell32_version);
 #endif
 
 
@@ -500,15 +500,15 @@ void CloseApplication(HWND hwnd)
 }
 
 #ifdef DEBUG
-void PrintDebugMsg(char *msg)
+void PrintDebugMsg(TCHAR *msg)
 {
   time_t log_time;
   struct tm *time_struct;
-  char date[30];
+  TCHAR date[30];
 
   log_time = time(NULL);
   time_struct = localtime(&log_time);
-  snprintf(date, sizeof(date), "%d-%.2d-%.2d %.2d:%.2d:%.2d",
+  _sntprintf(date, sizeof(date)/sizeof(*date), _T("%d-%.2d-%.2d %.2d:%.2d:%.2d"),
                  time_struct->tm_year + 1900,
                  time_struct->tm_mon + 1,
                  time_struct->tm_mday,
@@ -516,14 +516,14 @@ void PrintDebugMsg(char *msg)
                  time_struct->tm_min,
                  time_struct->tm_sec);
 
-  fprintf(o.debug_fp, "%s %s\n", date, msg);
+  _ftprintf(o.debug_fp, _T("%s %s\n"), date, msg);
   fflush(o.debug_fp);
 }
 
-void PrintErrorDebug(char *msg)
+void PrintErrorDebug(TCHAR *msg)
 {
   LPVOID lpMsgBuf;
-  char *buf;
+  TCHAR *buf;
 
   /* Get last error message */
   if (!FormatMessage( 
@@ -538,15 +538,17 @@ void PrintErrorDebug(char *msg)
           NULL ))
     {
       /* FormatMessage failed! */
-      PrintDebug("FormatMessage() failed. %s ", msg);
+      PrintDebug(_T("FormatMessage() failed. %s "), msg);
       return;
     }
 
   /* Cut of CR/LFs */
-  buf = (char *)lpMsgBuf;
-  buf[strlen(buf) - 3] = '\0';
+  buf = (TCHAR *)lpMsgBuf;
+  buf[_tcslen(buf) - 3] = '\0';
 
-  PrintDebug("%s %s", msg, (LPCTSTR)lpMsgBuf);
+  PrintDebug(_T("%s %s"), msg, (LPCTSTR)lpMsgBuf);
+
+  LocalFree(lpMsgBuf);
 
 }
 #endif
diff --git a/openvpn.c b/openvpn.c
index 48a6ef6..5c3d98a 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -970,7 +970,7 @@ CheckVersion()
     else if (ReadLineFromStdOut(hStdOutRead, line, sizeof(line)))
     {
 #ifdef DEBUG
-        PrintDebug("VersionString: %s", line);
+        PrintDebug(_T("VersionString: %S"), line);
 #endif
         CloseHandle(pi.hThread);
         CloseHandle(pi.hProcess);
-- 
1.7.3.4


