From: selva.nair@...277...
Date: Wed, 26 May 2021 18:49:19 -0400
Message-Id: <20210526224919.511-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Replace TEXT(__FUNCTION__) by __FUNCTION__
 in openvpnmscia.c
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

TEXT(__FUNCTION__) does not work in mingw as __FUNCTION__
is not a macro. Instead, use __FUNCTION__ as a narrow
string in both UNICODE and ANSI builds.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnmsica/openvpnmsica.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 5eb2f3c8..977f6813 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -102,13 +102,13 @@ setup_sequence(
  *                        title.
  */
 static void
-_debug_popup(_In_z_ LPCTSTR szFunctionName)
+_debug_popup(_In_z_ LPCSTR szFunctionName)
 {
     TCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
 
     /* Compose pop-up title. The dialog title will contain function name to ease the process
      * locating. Mind that Visual Studio displays window titles on the process list. */
-    _stprintf_s(szTitle, _countof(szTitle), TEXT("%") TEXT(PRIsLPTSTR) TEXT("v%") TEXT(PRIsLPTSTR),
+    _stprintf_s(szTitle, _countof(szTitle), TEXT("%hs v%") TEXT(PRIsLPTSTR),
                 szFunctionName, TEXT(PACKAGE_VERSION));
 
     /* Get process name. */
@@ -119,8 +119,8 @@ _debug_popup(_In_z_ LPCTSTR szFunctionName)
     /* Compose the pop-up message. */
     _stprintf_s(
         szMessage, _countof(szMessage),
-        TEXT("The %") TEXT(PRIsLPTSTR) TEXT(" process (PID: %u) has started to execute the %")
-        TEXT(PRIsLPTSTR) TEXT(" custom action.\r\n")
+        TEXT("The %") TEXT(PRIsLPTSTR) TEXT(" process (PID: %u) has started to execute the %hs")
+        TEXT(" custom action.\r\n")
         TEXT("\r\n")
         TEXT("If you would like to debug the custom action, attach a debugger to this process and set breakpoints before dismissing this dialog.\r\n")
         TEXT("\r\n")
@@ -407,7 +407,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    debug_popup(TEXT(__FUNCTION__));
+    debug_popup(__FUNCTION__);
 
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
@@ -441,7 +441,7 @@ CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 #endif
     UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with MSI session (report errors, access properties, tables, etc.). */
 
-    debug_popup(TEXT(__FUNCTION__));
+    debug_popup(__FUNCTION__);
 
     /* Find OpenVPN GUI window. */
     HWND hWnd = FindWindow(TEXT("OpenVPN-GUI"), NULL);
@@ -463,7 +463,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    debug_popup(TEXT(__FUNCTION__));
+    debug_popup(__FUNCTION__);
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -736,7 +736,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    debug_popup(TEXT(__FUNCTION__));
+    debug_popup(__FUNCTION__);
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -1065,7 +1065,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    debug_popup(TEXT(__FUNCTION__));
+    debug_popup(__FUNCTION__);
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -1265,7 +1265,7 @@ CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    debug_popup(TEXT(__FUNCTION__));
+    debug_popup(__FUNCTION__);
 
     UINT ret = ERROR_SUCCESS;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-- 
2.20.1


