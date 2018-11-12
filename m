From: Simon Rozman <simon@...2293...>
Date: Mon, 12 Nov 2018 13:22:46 +0100
Message-Id: <20181112122246.13556-3-simon@...2293...>
In-Reply-To: <20181112122246.13556-1-simon@...2293...>
References: <20181112122246.13556-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Make MSI custom action debug pop-up
 more informative
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

Each MSI custom action pops-up a message box in the _DEBUG version
before commencing execution. This opens a time window for developer to
attach debugger to the msiexec.exe process, set the breakpoints before
custom action proceeds with execution.

While those pop-up dialogs are targeted to a limited audience, they were
very sparse. With this patch, they become more informative and they also
provide PID of the msiexec.exe process to attach debugger to.
---
 src/openvpnmsica/openvpnmsica.c | 60 ++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 99b47bf0..a2819e62 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -144,6 +144,50 @@ openvpnmsica_setup_sequence_filename(
 }
 
 
+#ifdef _DEBUG
+
+/**
+ * Pops up a message box creating a time window to attach a debugger to the installer process in
+ * order to debug custom actions.
+ *
+ * @param szFunctionName  Function name that triggered the pop-up. Displayed in message box's
+ *                        title.
+ */
+static void
+_openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
+{
+    TCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
+
+    /* Compose pop-up title. The dialog title will contain function name to ease the process
+       locating. Mind that Visual Studio displays window titles on the process list. */
+    _stprintf_s(szTitle, _countof(szTitle), TEXT("%s v%s"), szFunctionName, TEXT(PACKAGE_VERSION));
+
+    /* Get process name. */
+    GetModuleFileName(NULL, szProcessPath, _countof(szProcessPath));
+    LPCTSTR szProcessName = _tcsrchr(szProcessPath, TEXT('\\'));
+    szProcessName = szProcessName ? szProcessName + 1 : szProcessPath;
+
+    /* Compose the pop-up message. */
+    _stprintf_s(
+        szMessage, _countof(szMessage),
+        TEXT("The %s process (PID: %u) has started to execute the %s custom action.\r\n")
+        TEXT("\r\n")
+        TEXT("If you would like to debug the custom action, attach a debugger to this process and set breakpoints before dismissing this dialog.\r\n")
+        TEXT("\r\n")
+        TEXT("If you are not debugging this custom action, you can safely ignore this message."),
+        szProcessName,
+        GetCurrentProcessId(),
+        szFunctionName);
+
+    MessageBox(NULL, szMessage, szTitle, MB_OK);
+}
+
+#define openvpnmsica_debug_popup(f) _openvpnmsica_debug_popup(f)
+#else
+#define openvpnmsica_debug_popup(f)
+#endif
+
+
 UINT __stdcall
 FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
@@ -151,9 +195,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-#ifdef _DEBUG
-    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
-#endif
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -265,9 +307,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-#ifdef _DEBUG
-    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
-#endif
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -371,9 +411,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-#ifdef _DEBUG
-    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
-#endif
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -633,9 +671,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-#ifdef _DEBUG
-    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
-#endif
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-- 
2.19.1.windows.1


