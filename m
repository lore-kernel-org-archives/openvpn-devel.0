From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:25 +0100
Message-Id: <20200309131728.380-9-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 09/12] openvpnmsica: Extend to support
 arbitrary HWID network adapters
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
 src/openvpnmsica/openvpnmsica.c | 73 ++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 4223b680..cfbda8da 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -555,7 +555,9 @@ cleanup_CoInitialize:
  * @param seqRollback   The argument sequence to pass to InstallTUNTAPAdaptersRollback custom
  *                      action. NULL when rollback is disabled.
  *
- * @param szDisplayName  Adapter display name.
+ * @param szDisplayName  Adapter display name
+ *
+ * @param szHardwareId  Adapter hardware ID
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
  *                      indicator) the InstallTUNTAPAdapters will take. This function increments it
@@ -568,6 +570,7 @@ schedule_adapter_create(
     _Inout_ struct msica_arg_seq *seq,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
     _In_z_ LPCTSTR szDisplayName,
+    _In_z_ LPCTSTR szHardwareId,
     _Inout_ int *iTicks)
 {
     /* Get all available network adapters. */
@@ -584,13 +587,14 @@ schedule_adapter_create(
         if (pAdapterOther == NULL)
         {
             /* No adapter with a same name found. */
-            TCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*terminator*/];
+            TCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*|*/ + MAX_PATH /*szHardwareId*/ + 1 /*terminator*/];
 
             /* InstallTUNTAPAdapters will create the adapter. */
             _stprintf_s(
                 szArgument, _countof(szArgument),
-                TEXT("create=\"%.*s\""),
-                MAX_PATH, szDisplayName);
+                TEXT("create=\"%.*s|%.*s\""),
+                MAX_PATH, szDisplayName,
+                MAX_PATH, szHardwareId);
             msica_arg_seq_add_tail(seq, szArgument);
 
             if (seqRollback)
@@ -613,16 +617,14 @@ schedule_adapter_create(
             {
                 if (hwid[0] == 0)
                 {
-                    /* This is not a TAP adapter. */
+                    /* This adapter has a different hardware ID. */
                     msg(M_NONFATAL, "%s: Adapter with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pAdapterOther->szName);
                     dwResult = ERROR_ALREADY_EXISTS;
                     goto cleanup_pAdapterList;
                 }
-                else if (
-                    _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
-                    || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+                else if (_tcsicmp(hwid, szHardwareId) == 0)
                 {
-                    /* This is a TAP-Windows6 adapter. We already have what we want! */
+                    /* This is an adapter with the requested hardware ID. We already have what we want! */
                     break;
                 }
             }
@@ -653,7 +655,9 @@ cleanup_pAdapterList:
  * @param seqRollback   The argument sequence to pass to UninstallTUNTAPAdaptersRollback custom
  *                      action. NULL when rollback is disabled.
  *
- * @param szDisplayName  Adapter display name.
+ * @param szDisplayName  Adapter display name
+ *
+ * @param szHardwareId  Adapter hardware ID
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
  *                      indicator) the UninstallTUNTAPAdapters will take. This function increments
@@ -667,11 +671,12 @@ schedule_adapter_delete(
     _Inout_opt_ struct msica_arg_seq *seqCommit,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
     _In_z_ LPCTSTR szDisplayName,
+    _In_z_ LPCTSTR szHardwareId,
     _Inout_ int *iTicks)
 {
-    /* Get available TUN/TAP adapters. */
+    /* Get available adapters with given hardware ID. */
     struct tap_adapter_node *pAdapterList = NULL;
-    DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
+    DWORD dwResult = tap_list_adapters(NULL, szHardwareId, &pAdapterList, FALSE);
     if (dwResult != ERROR_SUCCESS)
     {
         return dwResult;
@@ -780,7 +785,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 
     /* Prepare a query to get a list/view of adapters. */
     MSIHANDLE hViewST = 0;
-    LPCTSTR szQuery = TEXT("SELECT `Adapter`,`DisplayName`,`Condition`,`Component_` FROM `TUNTAPAdapter`");
+    LPCTSTR szQuery = TEXT("SELECT `Adapter`,`DisplayName`,`Condition`,`Component_`,`HardwareId` FROM `TUNTAPAdapter`");
     uiResult = MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
     if (uiResult != ERROR_SUCCESS)
     {
@@ -857,6 +862,14 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
         LPTSTR szDisplayNameEx = _tcschr(szDisplayName, TEXT('|'));
         szDisplayNameEx = szDisplayNameEx != NULL ? szDisplayNameEx + 1 : szDisplayName;
 
+        /* Get adapter hardware ID (`HardwareId` is field #5). */
+        LPTSTR szHardwareId = NULL;
+        uiResult = msi_get_record_string(hRecord, 5, &szHardwareId);
+        if (uiResult != ERROR_SUCCESS)
+        {
+            goto cleanup_szDisplayName;
+        }
+
         if (iAction > INSTALLSTATE_BROKEN)
         {
             int iTicks = 0;
@@ -868,7 +881,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                 uiResult = msi_get_record_string(hRecord, 3, &szValue);
                 if (uiResult != ERROR_SUCCESS)
                 {
-                    goto cleanup_szDisplayName;
+                    goto cleanup_szHardwareId;
                 }
 #ifdef __GNUC__
 /*
@@ -882,13 +895,13 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                 {
                     case MSICONDITION_FALSE:
                         free(szValue);
-                        goto cleanup_szDisplayName;
+                        goto cleanup_szHardwareId;
 
                     case MSICONDITION_ERROR:
                         uiResult = ERROR_INVALID_FIELD;
                         msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szValue);
                         free(szValue);
-                        goto cleanup_szDisplayName;
+                        goto cleanup_szHardwareId;
                 }
 #ifdef __GNUC__
 #pragma GCC diagnostic pop
@@ -900,10 +913,11 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                         &seqInstall,
                         bRollbackEnabled ? &seqInstallRollback : NULL,
                         szDisplayNameEx,
+                        szHardwareId,
                         &iTicks) != ERROR_SUCCESS)
                 {
                     uiResult = ERROR_INSTALL_FAILED;
-                    goto cleanup_szDisplayName;
+                    goto cleanup_szHardwareId;
                 }
             }
             else
@@ -918,6 +932,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                     bRollbackEnabled ? &seqUninstallCommit : NULL,
                     bRollbackEnabled ? &seqUninstallRollback : NULL,
                     szDisplayNameEx,
+                    szHardwareId,
                     &iTicks);
             }
 
@@ -928,10 +943,12 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
             if (MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
             {
                 uiResult = ERROR_INSTALL_USEREXIT;
-                goto cleanup_szDisplayName;
+                goto cleanup_szHardwareId;
             }
         }
 
+cleanup_szHardwareId:
+        free(szHardwareId);
 cleanup_szDisplayName:
         free(szDisplayName);
 cleanup_hRecord:
@@ -1052,14 +1069,22 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 
         if (wcsncmp(szArg[i], L"create=", 7) == 0)
         {
-            /* Create an adapter with a given name. */
-            LPCWSTR szName = szArg[i] + 7;
+            /* Create an adapter with a given name and hardware ID. */
+            LPWSTR szName = szArg[i] + 7;
+            LPWSTR szHardwareId = wcschr(szName, L'|');
+            if (szHardwareId == NULL)
+            {
+                goto invalid_argument;
+            }
+            szHardwareId[0] = 0;
+            ++szHardwareId;
 
             {
                 /* Report the name of the adapter to installer. */
-                MSIHANDLE hRecord = MsiCreateRecord(3);
+                MSIHANDLE hRecord = MsiCreateRecord(4);
                 MsiRecordSetString(hRecord, 1, TEXT("Creating adapter"));
                 MsiRecordSetString(hRecord, 2, szName);
+                MsiRecordSetString(hRecord, 3, szHardwareId);
                 int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
                 MsiCloseHandle(hRecord);
                 if (iResult == IDCANCEL)
@@ -1070,7 +1095,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
             }
 
             GUID guidAdapter;
-            dwResult = tap_create_adapter(NULL, NULL, NULL, &bRebootRequired, &guidAdapter);
+            dwResult = tap_create_adapter(NULL, NULL, szHardwareId, &bRebootRequired, &guidAdapter);
             if (dwResult == ERROR_SUCCESS)
             {
                 /* Set adapter name. */
@@ -1100,9 +1125,9 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
                 }
             }
 
-            /* Get available TUN/TAP adapters. */
+            /* Get all available adapters. */
             struct tap_adapter_node *pAdapterList = NULL;
-            dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
+            dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, TRUE);
             if (dwResult == ERROR_SUCCESS)
             {
                 /* Does the adapter exist? */
-- 
2.24.1.windows.2


