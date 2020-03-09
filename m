From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:24 +0100
Message-Id: <20200309131728.380-8-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 08/12] openvpnmsica: "TAP" => "TUN/TAP"
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

The function and property names that are common to TAP and TUN from
TAP-Windows6 and TUN from Wintun were renamed not to make the now
mainstream TUN sad.

I would have go with just the "adapter". But, wouldn't that cause
confusion when user sees "Deleting adapters" when uninstalling the
OpenVPN?

Internal variable names were simplified thou to omit the TUN/TAP
referencing.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 156 ++++++++++++++++----------------
 src/openvpnmsica/openvpnmsica.h |   8 +-
 2 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 1438d3f7..4223b680 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -272,7 +272,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 
 
 UINT __stdcall
-FindTAPAdapters(_In_ MSIHANDLE hInstall)
+FindTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
 #ifdef _MSC_VER
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -337,21 +337,21 @@ FindTAPAdapters(_In_ MSIHANDLE hInstall)
 
         /* Prepare semicolon delimited list of TAP adapter ID(s) and active TAP adapter ID(s). */
         LPTSTR
-            szTAPAdapters     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szTAPAdaptersTail = szTAPAdapters;
-        if (szTAPAdapters == NULL)
+            szAdapters     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+            szAdaptersTail = szAdapters;
+        if (szAdapters == NULL)
         {
             msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
             uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
         }
 
         LPTSTR
-            szTAPAdaptersActive     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szTAPAdaptersActiveTail = szTAPAdaptersActive;
-        if (szTAPAdaptersActive == NULL)
+            szAdaptersActive     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+            szAdaptersActiveTail = szAdaptersActive;
+        if (szAdaptersActive == NULL)
         {
             msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
-            uiResult = ERROR_OUTOFMEMORY; goto cleanup_szTAPAdapters;
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_szAdapters;
         }
 
         for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
@@ -361,12 +361,12 @@ FindTAPAdapters(_In_ MSIHANDLE hInstall)
             StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
 
             /* Append to the list of TAP adapter ID(s). */
-            if (szTAPAdapters < szTAPAdaptersTail)
+            if (szAdapters < szAdaptersTail)
             {
-                *(szTAPAdaptersTail++) = TEXT(';');
+                *(szAdaptersTail++) = TEXT(';');
             }
-            memcpy(szTAPAdaptersTail, szAdapterId, 38 * sizeof(TCHAR));
-            szTAPAdaptersTail += 38;
+            memcpy(szAdaptersTail, szAdapterId, 38 * sizeof(TCHAR));
+            szAdaptersTail += 38;
 
             /* If this adapter is active (connected), add it to the list of active TAP adapter ID(s). */
             for (PIP_ADAPTER_ADDRESSES p = pAdapterAdresses; p; p = p->Next)
@@ -380,43 +380,43 @@ FindTAPAdapters(_In_ MSIHANDLE hInstall)
                     if (p->OperStatus == IfOperStatusUp)
                     {
                         /* This TAP adapter is active (connected). */
-                        if (szTAPAdaptersActive < szTAPAdaptersActiveTail)
+                        if (szAdaptersActive < szAdaptersActiveTail)
                         {
-                            *(szTAPAdaptersActiveTail++) = TEXT(';');
+                            *(szAdaptersActiveTail++) = TEXT(';');
                         }
-                        memcpy(szTAPAdaptersActiveTail, szAdapterId, 38 * sizeof(TCHAR));
-                        szTAPAdaptersActiveTail += 38;
+                        memcpy(szAdaptersActiveTail, szAdapterId, 38 * sizeof(TCHAR));
+                        szAdaptersActiveTail += 38;
                     }
                     break;
                 }
             }
             CoTaskMemFree(szAdapterId);
         }
-        szTAPAdaptersTail      [0] = 0;
-        szTAPAdaptersActiveTail[0] = 0;
+        szAdaptersTail      [0] = 0;
+        szAdaptersActiveTail[0] = 0;
 
-        /* Set Installer TAPADAPTERS property. */
-        uiResult = MsiSetProperty(hInstall, TEXT("TAPADAPTERS"), szTAPAdapters);
+        /* Set Installer TUNTAPADAPTERS property. */
+        uiResult = MsiSetProperty(hInstall, TEXT("TUNTAPADAPTERS"), szAdapters);
         if (uiResult != ERROR_SUCCESS)
         {
             SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPADAPTERS\") failed", __FUNCTION__);
-            goto cleanup_szTAPAdaptersActive;
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TUNTAPADAPTERS\") failed", __FUNCTION__);
+            goto cleanup_szAdaptersActive;
         }
 
-        /* Set Installer ACTIVETAPADAPTERS property. */
-        uiResult = MsiSetProperty(hInstall, TEXT("ACTIVETAPADAPTERS"), szTAPAdaptersActive);
+        /* Set Installer ACTIVETUNTAPADAPTERS property. */
+        uiResult = MsiSetProperty(hInstall, TEXT("ACTIVETUNTAPADAPTERS"), szAdaptersActive);
         if (uiResult != ERROR_SUCCESS)
         {
             SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETAPADAPTERS\") failed", __FUNCTION__);
-            goto cleanup_szTAPAdaptersActive;
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETUNTAPADAPTERS\") failed", __FUNCTION__);
+            goto cleanup_szAdaptersActive;
         }
 
-cleanup_szTAPAdaptersActive:
-        free(szTAPAdaptersActive);
-cleanup_szTAPAdapters:
-        free(szTAPAdapters);
+cleanup_szAdaptersActive:
+        free(szAdaptersActive);
+cleanup_szAdapters:
+        free(szAdapters);
     }
     else
     {
@@ -550,15 +550,15 @@ cleanup_CoInitialize:
  *
  * When the rollback is enabled, the adapter deletition is scheduled on rollback.
  *
- * @param seq           The argument sequence to pass to InstallTAPAdapters custom action
+ * @param seq           The argument sequence to pass to InstallTUNTAPAdapters custom action
  *
- * @param seqRollback   The argument sequence to pass to InstallTAPAdaptersRollback custom
+ * @param seqRollback   The argument sequence to pass to InstallTUNTAPAdaptersRollback custom
  *                      action. NULL when rollback is disabled.
  *
  * @param szDisplayName  Adapter display name.
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
- *                      indicator) the InstallTAPAdapters will take. This function increments it
+ *                      indicator) the InstallTUNTAPAdapters will take. This function increments it
  *                      by MSICA_ADAPTER_TICK_SIZE for each adapter to create.
  *
  * @return ERROR_SUCCESS on success; An error code otherwise
@@ -586,7 +586,7 @@ schedule_adapter_create(
             /* No adapter with a same name found. */
             TCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*terminator*/];
 
-            /* InstallTAPAdapters will create the adapter. */
+            /* InstallTUNTAPAdapters will create the adapter. */
             _stprintf_s(
                 szArgument, _countof(szArgument),
                 TEXT("create=\"%.*s\""),
@@ -595,7 +595,7 @@ schedule_adapter_create(
 
             if (seqRollback)
             {
-                /* InstallTAPAdaptersRollback will delete the adapter. */
+                /* InstallTUNTAPAdaptersRollback will delete the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("deleteN=\"%.*s\""),
@@ -640,23 +640,23 @@ cleanup_pAdapterList:
  * Schedules adapter deletion.
  *
  * When the rollback is enabled, the adapter deletition is scheduled as: disable in
- * UninstallTAPAdapters, enable on rollback, delete on commit.
+ * UninstallTUNTAPAdapters, enable on rollback, delete on commit.
  *
  * When rollback is disabled, the adapter deletition is scheduled as delete in
- * UninstallTAPAdapters.
+ * UninstallTUNTAPAdapters.
  *
- * @param seq           The argument sequence to pass to UninstallTAPAdapters custom action
+ * @param seq           The argument sequence to pass to UninstallTUNTAPAdapters custom action
  *
- * @param seqCommit     The argument sequence to pass to UninstallTAPAdaptersCommit custom
+ * @param seqCommit     The argument sequence to pass to UninstallTUNTAPAdaptersCommit custom
  *                      action. NULL when rollback is disabled.
  *
- * @param seqRollback   The argument sequence to pass to UninstallTAPAdaptersRollback custom
+ * @param seqRollback   The argument sequence to pass to UninstallTUNTAPAdaptersRollback custom
  *                      action. NULL when rollback is disabled.
  *
  * @param szDisplayName  Adapter display name.
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
- *                      indicator) the UninstallTAPAdapters will take. This function increments
+ *                      indicator) the UninstallTUNTAPAdapters will take. This function increments
  *                      it by MSICA_ADAPTER_TICK_SIZE for each adapter to delete.
  *
  * @return ERROR_SUCCESS on success; An error code otherwise
@@ -686,21 +686,21 @@ schedule_adapter_delete(
             TCHAR szArgument[8 /*disable=|enable=|delete=*/ + 38 /*{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}*/ + 1 /*terminator*/];
             if (seqCommit && seqRollback)
             {
-                /* UninstallTAPAdapters will disable the adapter. */
+                /* UninstallTUNTAPAdapters will disable the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("disable=") TEXT(PRIXGUID),
                     PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seq, szArgument);
 
-                /* UninstallTAPAdaptersRollback will re-enable the adapter. */
+                /* UninstallTUNTAPAdaptersRollback will re-enable the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("enable=") TEXT(PRIXGUID),
                     PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_head(seqRollback, szArgument);
 
-                /* UninstallTAPAdaptersCommit will delete the adapter. */
+                /* UninstallTUNTAPAdaptersCommit will delete the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("delete=") TEXT(PRIXGUID),
@@ -709,7 +709,7 @@ schedule_adapter_delete(
             }
             else
             {
-                /* UninstallTAPAdapters will delete the adapter. */
+                /* UninstallTUNTAPAdapters will delete the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("delete=") TEXT(PRIXGUID),
@@ -728,7 +728,7 @@ schedule_adapter_delete(
 
 
 UINT __stdcall
-EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
+EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
 #ifdef _MSC_VER
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -742,18 +742,18 @@ EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     struct msica_arg_seq
-        seqInstallTAPAdapters,
-        seqInstallTAPAdaptersCommit,
-        seqInstallTAPAdaptersRollback,
-        seqUninstallTAPAdapters,
-        seqUninstallTAPAdaptersCommit,
-        seqUninstallTAPAdaptersRollback;
-    msica_arg_seq_init(&seqInstallTAPAdapters);
-    msica_arg_seq_init(&seqInstallTAPAdaptersCommit);
-    msica_arg_seq_init(&seqInstallTAPAdaptersRollback);
-    msica_arg_seq_init(&seqUninstallTAPAdapters);
-    msica_arg_seq_init(&seqUninstallTAPAdaptersCommit);
-    msica_arg_seq_init(&seqUninstallTAPAdaptersRollback);
+        seqInstall,
+        seqInstallCommit,
+        seqInstallRollback,
+        seqUninstall,
+        seqUninstallCommit,
+        seqUninstallRollback;
+    msica_arg_seq_init(&seqInstall);
+    msica_arg_seq_init(&seqInstallCommit);
+    msica_arg_seq_init(&seqInstallRollback);
+    msica_arg_seq_init(&seqUninstall);
+    msica_arg_seq_init(&seqUninstallCommit);
+    msica_arg_seq_init(&seqUninstallRollback);
 
     /* Check rollback state. */
     bool bRollbackEnabled = MsiEvaluateCondition(hInstall, TEXT("RollbackDisabled")) != MSICONDITION_TRUE;
@@ -767,8 +767,8 @@ EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
         goto cleanup_exec_seq;
     }
 
-    /* Check if TAPAdapter table exists. If it doesn't exist, there's nothing to do. */
-    switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TAPAdapter")))
+    /* Check if TUNTAPAdapter table exists. If it doesn't exist, there's nothing to do. */
+    switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TUNTAPAdapter")))
     {
         case MSICONDITION_FALSE:
         case MSICONDITION_TRUE: break;
@@ -780,7 +780,7 @@ EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
 
     /* Prepare a query to get a list/view of adapters. */
     MSIHANDLE hViewST = 0;
-    LPCTSTR szQuery = TEXT("SELECT `Adapter`,`DisplayName`,`Condition`,`Component_` FROM `TAPAdapter`");
+    LPCTSTR szQuery = TEXT("SELECT `Adapter`,`DisplayName`,`Condition`,`Component_` FROM `TUNTAPAdapter`");
     uiResult = MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
     if (uiResult != ERROR_SUCCESS)
     {
@@ -897,8 +897,8 @@ EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
 
                 /* Component is or should be installed. Schedule adapter creation. */
                 if (schedule_adapter_create(
-                        &seqInstallTAPAdapters,
-                        bRollbackEnabled ? &seqInstallTAPAdaptersRollback : NULL,
+                        &seqInstall,
+                        bRollbackEnabled ? &seqInstallRollback : NULL,
                         szDisplayNameEx,
                         &iTicks) != ERROR_SUCCESS)
                 {
@@ -914,9 +914,9 @@ EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
                  * Better a partial uninstallation than no uninstallation at all.
                  */
                 schedule_adapter_delete(
-                    &seqUninstallTAPAdapters,
-                    bRollbackEnabled ? &seqUninstallTAPAdaptersCommit : NULL,
-                    bRollbackEnabled ? &seqUninstallTAPAdaptersRollback : NULL,
+                    &seqUninstall,
+                    bRollbackEnabled ? &seqUninstallCommit : NULL,
+                    bRollbackEnabled ? &seqUninstallRollback : NULL,
                     szDisplayNameEx,
                     &iTicks);
             }
@@ -943,12 +943,12 @@ cleanup_hRecord:
     }
 
     /* Store deferred custom action parameters. */
-    if ((uiResult = setup_sequence(hInstall, TEXT("InstallTAPAdapters"          ), &seqInstallTAPAdapters          )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPAdaptersCommit"    ), &seqInstallTAPAdaptersCommit    )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPAdaptersRollback"  ), &seqInstallTAPAdaptersRollback  )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPAdapters"        ), &seqUninstallTAPAdapters        )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPAdaptersCommit"  ), &seqUninstallTAPAdaptersCommit  )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPAdaptersRollback"), &seqUninstallTAPAdaptersRollback)) != ERROR_SUCCESS)
+    if ((uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdapters"          ), &seqInstall          )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdaptersCommit"    ), &seqInstallCommit    )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdaptersRollback"  ), &seqInstallRollback  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTUNTAPAdapters"        ), &seqUninstall        )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTUNTAPAdaptersCommit"  ), &seqUninstallCommit  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTUNTAPAdaptersRollback"), &seqUninstallRollback)) != ERROR_SUCCESS)
     {
         goto cleanup_hRecordProg;
     }
@@ -964,12 +964,12 @@ cleanup_hViewST:
 cleanup_hDatabase:
     MsiCloseHandle(hDatabase);
 cleanup_exec_seq:
-    msica_arg_seq_free(&seqInstallTAPAdapters);
-    msica_arg_seq_free(&seqInstallTAPAdaptersCommit);
-    msica_arg_seq_free(&seqInstallTAPAdaptersRollback);
-    msica_arg_seq_free(&seqUninstallTAPAdapters);
-    msica_arg_seq_free(&seqUninstallTAPAdaptersCommit);
-    msica_arg_seq_free(&seqUninstallTAPAdaptersRollback);
+    msica_arg_seq_free(&seqInstall);
+    msica_arg_seq_free(&seqInstallCommit);
+    msica_arg_seq_free(&seqInstallRollback);
+    msica_arg_seq_free(&seqUninstall);
+    msica_arg_seq_free(&seqUninstallCommit);
+    msica_arg_seq_free(&seqUninstallRollback);
     if (bIsCoInitialized)
     {
         CoUninitialize();
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 14fb78a2..5d140930 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -90,7 +90,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall);
 
 
 /**
- * Find existing TAP adapters and set TAPADAPTERS and ACTIVETAPADAPTERS properties with
+ * Find existing TAP adapters and set TUNTAPADAPTERS and ACTIVETUNTAPADAPTERS properties with
  * semicolon delimited list of all installed TAP adapter GUIDs and active adapter GUIDs
  * respectively.
  *
@@ -100,7 +100,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall);
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
 DLLEXP_DECL UINT __stdcall
-FindTAPAdapters(_In_ MSIHANDLE hInstall);
+FindTUNTAPAdapters(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -129,7 +129,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
 
 
 /**
- * Evaluate the TAPAdapter table of the MSI package database and prepare a list of TAP
+ * Evaluate the TUNTAPAdapter table of the MSI package database and prepare a list of TAP
  * adapters to install/remove.
  *
  * @param hInstall      Handle to the installation provided to the DLL custom action
@@ -138,7 +138,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
 DLLEXP_DECL UINT __stdcall
-EvaluateTAPAdapters(_In_ MSIHANDLE hInstall);
+EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall);
 
 
 /**
-- 
2.24.1.windows.2


