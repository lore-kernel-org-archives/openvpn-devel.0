From: selva.nair@...277...
Date: Fri, 21 May 2021 23:32:32 -0400
Message-Id: <20210522033232.20548-3-selva.nair@...277...>
In-Reply-To: <20210522033232.20548-1-selva.nair@...277...>
References: <20210522033232.20548-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Print format spec changes for tapctl
 and openvpnmscia
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

The tapctl and openvpnmscia codebase is written with an intent of
supporting both unicode and ansi builds.  This patch does not attempt
to change that although non-unicode support looks untested
and buggy.

The main change is to replace %s by PRIsLPTSR that is defined
as %ls or %s depending on _UNICODE is defined ot not.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnmsica/openvpnmsica.c |  6 +++--
 src/tapctl/main.c               | 39 +++++++++++++++++++++------------
 src/tapctl/tap.c                |  3 ++-
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 96652117..1a6f7e86 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -108,7 +108,8 @@ _debug_popup(_In_z_ LPCTSTR szFunctionName)
 
     /* Compose pop-up title. The dialog title will contain function name to ease the process
      * locating. Mind that Visual Studio displays window titles on the process list. */
-    _stprintf_s(szTitle, _countof(szTitle), TEXT("%s v%s"), szFunctionName, TEXT(PACKAGE_VERSION));
+    _stprintf_s(szTitle, _countof(szTitle), TEXT("%") TEXT(PRIsLPTSTR) TEXT("v%") TEXT(PRIsLPTSTR),
+		szFunctionName, TEXT(PACKAGE_VERSION));
 
     /* Get process name. */
     GetModuleFileName(NULL, szProcessPath, _countof(szProcessPath));
@@ -118,7 +119,8 @@ _debug_popup(_In_z_ LPCTSTR szFunctionName)
     /* Compose the pop-up message. */
     _stprintf_s(
         szMessage, _countof(szMessage),
-        TEXT("The %s process (PID: %u) has started to execute the %s custom action.\r\n")
+        TEXT("The %") TEXT(PRIsLPTSTR) TEXT(" process (PID: %u) has started to execute the %"
+        TEXT(PRIsLPTSTR) TEXT(" custom action.\r\n")
         TEXT("\r\n")
         TEXT("If you would like to debug the custom action, attach a debugger to this process and set breakpoints before dismissing this dialog.\r\n")
         TEXT("\r\n")
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 3350bf1f..81addaef 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -49,7 +49,7 @@ const TCHAR title_string[] =
 ;
 
 static const TCHAR usage_message[] =
-    TEXT("%s\n")
+    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
     TEXT("\n")
     TEXT("Usage:\n")
     TEXT("\n")
@@ -66,7 +66,7 @@ static const TCHAR usage_message[] =
 ;
 
 static const TCHAR usage_message_create[] =
-    TEXT("%s\n")
+    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
     TEXT("\n")
     TEXT("Creates a new TUN/TAP adapter\n")
     TEXT("\n")
@@ -91,7 +91,7 @@ static const TCHAR usage_message_create[] =
 ;
 
 static const TCHAR usage_message_list[] =
-    TEXT("%s\n")
+    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
     TEXT("\n")
     TEXT("Lists TUN/TAP adapters\n")
     TEXT("\n")
@@ -110,7 +110,7 @@ static const TCHAR usage_message_list[] =
 ;
 
 static const TCHAR usage_message_delete[] =
-    TEXT("%s\n")
+    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
     TEXT("\n")
     TEXT("Deletes the specified network adapter\n")
     TEXT("\n")
@@ -170,7 +170,8 @@ _tmain(int argc, LPCTSTR argv[])
         }
         else
         {
-            _ftprintf(stderr, TEXT("Unknown command \"%s\". Please, use \"tapctl help\" to list supported commands.\n"), argv[2]);
+            _ftprintf(stderr, TEXT("Unknown command \"%") TEXT(PRIsLPTSTR)
+                      TEXT("\". Please, use \"tapctl help\" to list supported commands.\n"), argv[2]);
         }
 
         return 1;
@@ -194,7 +195,9 @@ _tmain(int argc, LPCTSTR argv[])
             }
             else
             {
-                _ftprintf(stderr, TEXT("Unknown option \"%s\". Please, use \"tapctl help create\" to list supported options. Ignored.\n"), argv[i]);
+                _ftprintf(stderr, TEXT("Unknown option \"%") TEXT(PRIsLPTSTR)
+                          TEXT("\". Please, use \"tapctl help create\" to list supported options. Ignored.\n"),
+                          argv[i]);
             }
         }
 
@@ -230,7 +233,8 @@ _tmain(int argc, LPCTSTR argv[])
                 if (_tcsicmp(szName, pAdapter->szName) == 0)
                 {
                     StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
-                    _ftprintf(stderr, TEXT("Adapter \"%s\" already exists (GUID %") TEXT(PRIsLPOLESTR) TEXT(").\n"), pAdapter->szName, szAdapterId);
+                    _ftprintf(stderr, TEXT("Adapter \"%") TEXT(PRIsLPTSTR) TEXT("\" already exists (GUID %")
+                              TEXT(PRIsLPOLESTR) TEXT(").\n"), pAdapter->szName, szAdapterId);
                     CoTaskMemFree(szAdapterId);
                     iResult = 1; goto create_cleanup_pAdapterList;
                 }
@@ -241,7 +245,9 @@ _tmain(int argc, LPCTSTR argv[])
             if (dwResult != ERROR_SUCCESS)
             {
                 StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-                _ftprintf(stderr, TEXT("Renaming TUN/TAP adapter %") TEXT(PRIsLPOLESTR) TEXT(" to \"%s\" failed (error 0x%x).\n"), szAdapterId, szName, dwResult);
+                _ftprintf(stderr, TEXT("Renaming TUN/TAP adapter %") TEXT(PRIsLPOLESTR)
+                          TEXT(" to \"%") TEXT(PRIsLPTSTR) TEXT("\" failed (error 0x%x).\n"),
+                          szAdapterId, szName, dwResult);
                 CoTaskMemFree(szAdapterId);
                 iResult = 1; goto quit;
             }
@@ -289,7 +295,9 @@ create_delete_adapter:
             }
             else
             {
-                _ftprintf(stderr, TEXT("Unknown option \"%s\". Please, use \"tapctl help list\" to list supported options. Ignored.\n"), argv[i]);
+                _ftprintf(stderr, TEXT("Unknown option \"%") TEXT(PRIsLPTSTR)
+                          TEXT("\". Please, use \"tapctl help list\" to list supported options. Ignored.\n"),
+                          argv[i]);
             }
         }
 
@@ -306,7 +314,8 @@ create_delete_adapter:
         {
             LPOLESTR szAdapterId = NULL;
             StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
-            _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\t%") TEXT(PRIsLPTSTR) TEXT("\n"), szAdapterId, pAdapter->szName);
+            _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\t%")
+                      TEXT(PRIsLPTSTR) TEXT("\n"), szAdapterId, pAdapter->szName);
             CoTaskMemFree(szAdapterId);
         }
 
@@ -337,7 +346,7 @@ create_delete_adapter:
             {
                 if (pAdapter == NULL)
                 {
-                    _ftprintf(stderr, TEXT("\"%s\" adapter not found.\n"), argv[2]);
+                    _ftprintf(stderr, TEXT("\"%") TEXT(PRIsLPTSTR) TEXT("\" adapter not found.\n"), argv[2]);
                     iResult = 1; goto delete_cleanup_pAdapterList;
                 }
                 else if (_tcsicmp(argv[2], pAdapter->szName) == 0)
@@ -364,7 +373,8 @@ delete_cleanup_pAdapterList:
             &bRebootRequired);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Deleting adapter \"%s\" failed (error 0x%x).\n"), argv[2], dwResult);
+            _ftprintf(stderr, TEXT("Deleting adapter \"%") TEXT(PRIsLPTSTR)
+                      TEXT("\" failed (error 0x%x).\n"), argv[2], dwResult);
             iResult = 1; goto quit;
         }
 
@@ -372,7 +382,8 @@ delete_cleanup_pAdapterList:
     }
     else
     {
-        _ftprintf(stderr, TEXT("Unknown command \"%s\". Please, use \"tapctl help\" to list supported commands.\n"), argv[1]);
+        _ftprintf(stderr, TEXT("Unknown command \"%") TEXT(PRIsLPTSTR)
+                  TEXT("\". Please, use \"tapctl help\" to list supported commands.\n"), argv[1]);
         return 1;
     }
 
@@ -434,7 +445,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
             }
 
             /* Output error message. */
-            _ftprintf(stderr, TEXT("Error 0x%x: %s\n"), dwResult, szErrMessage);
+            _ftprintf(stderr, TEXT("Error 0x%x: %") TEXT(PRIsLPTSTR) TEXT("\n"), dwResult, szErrMessage);
 
             LocalFree(szErrMessage);
         }
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 563c07f6..b8d63b0f 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -1117,7 +1117,8 @@ tap_set_adapter_name(
     }
 
     /* rename adapter via netsh call */
-    const TCHAR* szFmt = _T("netsh interface set interface name=\"%s\" newname=\"%s\"");
+    const TCHAR* szFmt = TEXT("netsh interface set interface name=\"%")
+                         TEXT(PRIsLPTSTR) TEXT("\" newname=\"%") TEXT(PRIsLPTSTR) TEXT("\"");
     size_t ncmdline = _tcslen(szFmt) + _tcslen(szOldName) + _tcslen(szName) + 1;
     WCHAR* szCmdLine = malloc(ncmdline * sizeof(TCHAR));
     _stprintf_s(szCmdLine, ncmdline, szFmt, szOldName, szName);
-- 
2.20.1


