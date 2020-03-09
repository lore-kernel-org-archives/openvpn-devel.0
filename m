From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:22 +0100
Message-Id: <20200309131728.380-6-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 06/12] openvpnmsica: Simplify static
 function names
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 63 +++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 4c186b13..749dce56 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -72,7 +72,7 @@
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static UINT
-openvpnmsica_setup_sequence(
+setup_sequence(
     _In_ MSIHANDLE hInstall,
     _In_z_ LPCTSTR szProperty,
     _In_ struct msica_arg_seq *seq)
@@ -101,7 +101,7 @@ openvpnmsica_setup_sequence(
  *                        title.
  */
 static void
-_openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
+_debug_popup(_In_z_ LPCTSTR szFunctionName)
 {
     TCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
 
@@ -129,9 +129,9 @@ _openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
     MessageBox(NULL, szMessage, szTitle, MB_OK);
 }
 
-#define openvpnmsica_debug_popup(f) _openvpnmsica_debug_popup(f)
+#define debug_popup(f) _debug_popup(f)
 #else  /* ifdef _DEBUG */
-#define openvpnmsica_debug_popup(f)
+#define debug_popup(f)
 #endif /* ifdef _DEBUG */
 
 
@@ -146,7 +146,7 @@ _openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
 static UINT
-openvpnmsica_set_openvpnserv_state(_In_ MSIHANDLE hInstall)
+set_openvpnserv_state(_In_ MSIHANDLE hInstall)
 {
     UINT uiResult;
 
@@ -255,13 +255,13 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+    debug_popup(TEXT(__FUNCTION__));
 
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    openvpnmsica_set_openvpnserv_state(hInstall);
+    set_openvpnserv_state(hInstall);
 
     if (bIsCoInitialized)
     {
@@ -278,7 +278,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+    debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -444,7 +444,7 @@ CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 #endif
     UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with MSI session (report errors, access properties, tables, etc.). */
 
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+    debug_popup(TEXT(__FUNCTION__));
 
     /* Find OpenVPN GUI window. */
     HWND hWnd = FindWindow(TEXT("OpenVPN-GUI"), NULL);
@@ -466,7 +466,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+    debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -564,7 +564,11 @@ cleanup_CoInitialize:
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static DWORD
-openvpnmsica_schedule_interface_create(_Inout_ struct msica_arg_seq *seq, _Inout_opt_ struct msica_arg_seq *seqRollback, _In_z_ LPCTSTR szDisplayName, _Inout_ int *iTicks)
+schedule_interface_create(
+    _Inout_ struct msica_arg_seq *seq,
+    _Inout_opt_ struct msica_arg_seq *seqRollback,
+    _In_z_ LPCTSTR szDisplayName,
+    _Inout_ int *iTicks)
 {
     /* Get all available network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
@@ -658,7 +662,12 @@ cleanup_pInterfaceList:
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static DWORD
-openvpnmsica_schedule_interface_delete(_Inout_ struct msica_arg_seq *seq, _Inout_opt_ struct msica_arg_seq *seqCommit, _Inout_opt_ struct msica_arg_seq *seqRollback, _In_z_ LPCTSTR szDisplayName, _Inout_ int *iTicks)
+schedule_interface_delete(
+    _Inout_ struct msica_arg_seq *seq,
+    _Inout_opt_ struct msica_arg_seq *seqCommit,
+    _Inout_opt_ struct msica_arg_seq *seqRollback,
+    _In_z_ LPCTSTR szDisplayName,
+    _Inout_ int *iTicks)
 {
     /* Get available TUN/TAP interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
@@ -725,7 +734,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+    debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -887,7 +896,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
                 free(szValue);
 
                 /* Component is or should be installed. Schedule interface creation. */
-                if (openvpnmsica_schedule_interface_create(
+                if (schedule_interface_create(
                         &seqInstallTAPInterfaces,
                         bRollbackEnabled ? &seqInstallTAPInterfacesRollback : NULL,
                         szDisplayNameEx,
@@ -904,7 +913,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
                  * Note: On interface removal (product is being uninstalled), we tolerate dwResult error.
                  * Better a partial uninstallation than no uninstallation at all.
                  */
-                openvpnmsica_schedule_interface_delete(
+                schedule_interface_delete(
                     &seqUninstallTAPInterfaces,
                     bRollbackEnabled ? &seqUninstallTAPInterfacesCommit : NULL,
                     bRollbackEnabled ? &seqUninstallTAPInterfacesRollback : NULL,
@@ -934,12 +943,12 @@ cleanup_hRecord:
     }
 
     /* Store deferred custom action parameters. */
-    if ((uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("InstallTAPInterfaces"          ), &seqInstallTAPInterfaces          )) != ERROR_SUCCESS
-        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("InstallTAPInterfacesCommit"    ), &seqInstallTAPInterfacesCommit    )) != ERROR_SUCCESS
-        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("InstallTAPInterfacesRollback"  ), &seqInstallTAPInterfacesRollback  )) != ERROR_SUCCESS
-        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("UninstallTAPInterfaces"        ), &seqUninstallTAPInterfaces        )) != ERROR_SUCCESS
-        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("UninstallTAPInterfacesCommit"  ), &seqUninstallTAPInterfacesCommit  )) != ERROR_SUCCESS
-        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("UninstallTAPInterfacesRollback"), &seqUninstallTAPInterfacesRollback)) != ERROR_SUCCESS)
+    if ((uiResult = setup_sequence(hInstall, TEXT("InstallTAPInterfaces"          ), &seqInstallTAPInterfaces          )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPInterfacesCommit"    ), &seqInstallTAPInterfacesCommit    )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPInterfacesRollback"  ), &seqInstallTAPInterfacesRollback  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPInterfaces"        ), &seqUninstallTAPInterfaces        )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPInterfacesCommit"  ), &seqUninstallTAPInterfacesCommit  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPInterfacesRollback"), &seqUninstallTAPInterfacesRollback)) != ERROR_SUCCESS)
     {
         goto cleanup_hRecordProg;
     }
@@ -979,7 +988,9 @@ cleanup_exec_seq:
  * @return TRUE on success; FALSE otherwise
  */
 static BOOL
-openvpnmsica_parse_guid(_In_z_ LPCWSTR szArg, _Out_ GUID *guid)
+parse_guid(
+    _In_z_ LPCWSTR szArg,
+    _Out_ GUID *guid)
 {
     if (swscanf_s(szArg, _L(PRIXGUID), PRIGUID_PARAM_REF(*guid)) != 11)
     {
@@ -997,7 +1008,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+    debug_popup(TEXT(__FUNCTION__));
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
@@ -1112,7 +1123,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
         {
             /* Delete the interface by GUID. */
             GUID guid;
-            if (!openvpnmsica_parse_guid(szArg[i] + 7, &guid))
+            if (!parse_guid(szArg[i] + 7, &guid))
             {
                 goto invalid_argument;
             }
@@ -1122,7 +1133,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
         {
             /* Enable the interface. */
             GUID guid;
-            if (!openvpnmsica_parse_guid(szArg[i] + 7, &guid))
+            if (!parse_guid(szArg[i] + 7, &guid))
             {
                 goto invalid_argument;
             }
@@ -1132,7 +1143,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
         {
             /* Disable the interface. */
             GUID guid;
-            if (!openvpnmsica_parse_guid(szArg[i] + 8, &guid))
+            if (!parse_guid(szArg[i] + 8, &guid))
             {
                 goto invalid_argument;
             }
-- 
2.24.1.windows.2


