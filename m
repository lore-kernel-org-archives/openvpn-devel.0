From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:23 +0100
Message-Id: <20200309131728.380-7-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 07/12] openvpnmsica,
 tapctl: "interface" => "adapter"
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

Interface is not equal to adapter. A quote from Microsoft documentation:

> There is a one-to-one correspondence between the interfaces and
> adapters on a given computer. An interface is an IP-level abstraction,
> whereas an adapter is a datalink-level abstraction.

As tapctl and openvpnmsica are all about managing network adapters on
Windows computers, the terminology has been updated.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 366 ++++++++++++++++----------------
 src/openvpnmsica/openvpnmsica.h |  13 +-
 src/tapctl/main.c               | 150 ++++++-------
 src/tapctl/tap.c                | 182 ++++++++--------
 src/tapctl/tap.h                |  82 +++----
 src/tapctl/tapctl_resources.rc  |   4 +-
 6 files changed, 399 insertions(+), 398 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 749dce56..1438d3f7 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -57,7 +57,7 @@
  * Local constants
  */
 
-#define MSICA_INTERFACE_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN interface creation/deletition. */
+#define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
 
 
 /**
@@ -272,7 +272,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 
 
 UINT __stdcall
-FindTAPInterfaces(_In_ MSIHANDLE hInstall)
+FindTAPAdapters(_In_ MSIHANDLE hInstall)
 {
 #ifdef _MSC_VER
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -285,15 +285,15 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    /* Get all TUN/TAP network interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    uiResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
+    /* Get all TUN/TAP network adapters. */
+    struct tap_adapter_node *pAdapterList = NULL;
+    uiResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
     if (uiResult != ERROR_SUCCESS)
     {
         goto cleanup_CoInitialize;
     }
 
-    /* Get IPv4/v6 info for all network interfaces. Actually, we're interested in link status only: up/down? */
+    /* Get IPv4/v6 info for all network adapters. Actually, we're interested in link status only: up/down? */
     PIP_ADAPTER_ADDRESSES pAdapterAdresses = NULL;
     ULONG ulAdapterAdressesSize = 16*1024;
     for (size_t iteration = 0; iteration < 2; iteration++)
@@ -302,7 +302,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
         if (pAdapterAdresses == NULL)
         {
             msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, ulAdapterAdressesSize);
-            uiResult = ERROR_OUTOFMEMORY; goto cleanup_tap_list_interfaces;
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_tap_list_adapters;
         }
 
         ULONG ulResult = GetAdaptersAddresses(
@@ -322,101 +322,101 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
         {
             SetLastError(ulResult); /* MSDN does not mention GetAdaptersAddresses() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_NONFATAL | M_ERRNO, "%s: GetAdaptersAddresses() failed", __FUNCTION__);
-            uiResult = ulResult; goto cleanup_tap_list_interfaces;
+            uiResult = ulResult; goto cleanup_tap_list_adapters;
         }
     }
 
-    if (pInterfaceList != NULL)
+    if (pAdapterList != NULL)
     {
-        /* Count interfaces. */
-        size_t interface_count = 0;
-        for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+        /* Count adapters. */
+        size_t adapter_count = 0;
+        for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
         {
-            interface_count++;
+            adapter_count++;
         }
 
-        /* Prepare semicolon delimited list of TAP interface ID(s) and active TAP interface ID(s). */
+        /* Prepare semicolon delimited list of TAP adapter ID(s) and active TAP adapter ID(s). */
         LPTSTR
-            szTAPInterfaces     = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szTAPInterfacesTail = szTAPInterfaces;
-        if (szTAPInterfaces == NULL)
+            szTAPAdapters     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPAdaptersTail = szTAPAdapters;
+        if (szTAPAdapters == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
             uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
         }
 
         LPTSTR
-            szTAPInterfacesActive     = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szTAPInterfacesActiveTail = szTAPInterfacesActive;
-        if (szTAPInterfacesActive == NULL)
+            szTAPAdaptersActive     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPAdaptersActiveTail = szTAPAdaptersActive;
+        if (szTAPAdaptersActive == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
-            uiResult = ERROR_OUTOFMEMORY; goto cleanup_szTAPInterfaces;
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_szTAPAdapters;
         }
 
-        for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+        for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
         {
-            /* Convert interface GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
-            LPOLESTR szInterfaceId = NULL;
-            StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
+            /* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
+            LPOLESTR szAdapterId = NULL;
+            StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
 
-            /* Append to the list of TAP interface ID(s). */
-            if (szTAPInterfaces < szTAPInterfacesTail)
+            /* Append to the list of TAP adapter ID(s). */
+            if (szTAPAdapters < szTAPAdaptersTail)
             {
-                *(szTAPInterfacesTail++) = TEXT(';');
+                *(szTAPAdaptersTail++) = TEXT(';');
             }
-            memcpy(szTAPInterfacesTail, szInterfaceId, 38 * sizeof(TCHAR));
-            szTAPInterfacesTail += 38;
+            memcpy(szTAPAdaptersTail, szAdapterId, 38 * sizeof(TCHAR));
+            szTAPAdaptersTail += 38;
 
-            /* If this interface is active (connected), add it to the list of active TAP interface ID(s). */
+            /* If this adapter is active (connected), add it to the list of active TAP adapter ID(s). */
             for (PIP_ADAPTER_ADDRESSES p = pAdapterAdresses; p; p = p->Next)
             {
                 OLECHAR szId[38 /*GUID*/ + 1 /*terminator*/];
                 GUID guid;
                 if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0
                     && SUCCEEDED(IIDFromString(szId, &guid))
-                    && memcmp(&guid, &pInterface->guid, sizeof(GUID)) == 0)
+                    && memcmp(&guid, &pAdapter->guid, sizeof(GUID)) == 0)
                 {
                     if (p->OperStatus == IfOperStatusUp)
                     {
-                        /* This TAP interface is active (connected). */
-                        if (szTAPInterfacesActive < szTAPInterfacesActiveTail)
+                        /* This TAP adapter is active (connected). */
+                        if (szTAPAdaptersActive < szTAPAdaptersActiveTail)
                         {
-                            *(szTAPInterfacesActiveTail++) = TEXT(';');
+                            *(szTAPAdaptersActiveTail++) = TEXT(';');
                         }
-                        memcpy(szTAPInterfacesActiveTail, szInterfaceId, 38 * sizeof(TCHAR));
-                        szTAPInterfacesActiveTail += 38;
+                        memcpy(szTAPAdaptersActiveTail, szAdapterId, 38 * sizeof(TCHAR));
+                        szTAPAdaptersActiveTail += 38;
                     }
                     break;
                 }
             }
-            CoTaskMemFree(szInterfaceId);
+            CoTaskMemFree(szAdapterId);
         }
-        szTAPInterfacesTail      [0] = 0;
-        szTAPInterfacesActiveTail[0] = 0;
+        szTAPAdaptersTail      [0] = 0;
+        szTAPAdaptersActiveTail[0] = 0;
 
-        /* Set Installer TAPINTERFACES property. */
-        uiResult = MsiSetProperty(hInstall, TEXT("TAPINTERFACES"), szTAPInterfaces);
+        /* Set Installer TAPADAPTERS property. */
+        uiResult = MsiSetProperty(hInstall, TEXT("TAPADAPTERS"), szTAPAdapters);
         if (uiResult != ERROR_SUCCESS)
         {
             SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPINTERFACES\") failed", __FUNCTION__);
-            goto cleanup_szTAPInterfacesActive;
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPADAPTERS\") failed", __FUNCTION__);
+            goto cleanup_szTAPAdaptersActive;
         }
 
-        /* Set Installer ACTIVETAPINTERFACES property. */
-        uiResult = MsiSetProperty(hInstall, TEXT("ACTIVETAPINTERFACES"), szTAPInterfacesActive);
+        /* Set Installer ACTIVETAPADAPTERS property. */
+        uiResult = MsiSetProperty(hInstall, TEXT("ACTIVETAPADAPTERS"), szTAPAdaptersActive);
         if (uiResult != ERROR_SUCCESS)
         {
             SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETAPINTERFACES\") failed", __FUNCTION__);
-            goto cleanup_szTAPInterfacesActive;
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETAPADAPTERS\") failed", __FUNCTION__);
+            goto cleanup_szTAPAdaptersActive;
         }
 
-cleanup_szTAPInterfacesActive:
-        free(szTAPInterfacesActive);
-cleanup_szTAPInterfaces:
-        free(szTAPInterfaces);
+cleanup_szTAPAdaptersActive:
+        free(szTAPAdaptersActive);
+cleanup_szTAPAdapters:
+        free(szTAPAdapters);
     }
     else
     {
@@ -425,8 +425,8 @@ cleanup_szTAPInterfaces:
 
 cleanup_pAdapterAdresses:
     free(pAdapterAdresses);
-cleanup_tap_list_interfaces:
-    tap_free_interface_list(pInterfaceList);
+cleanup_tap_list_adapters:
+    tap_free_adapter_list(pAdapterList);
 cleanup_CoInitialize:
     if (bIsCoInitialized)
     {
@@ -546,47 +546,47 @@ cleanup_CoInitialize:
 
 
 /**
- * Schedules interface creation.
+ * Schedules adapter creation.
  *
- * When the rollback is enabled, the interface deletition is scheduled on rollback.
+ * When the rollback is enabled, the adapter deletition is scheduled on rollback.
  *
- * @param seq           The argument sequence to pass to InstallTAPInterfaces custom action
+ * @param seq           The argument sequence to pass to InstallTAPAdapters custom action
  *
- * @param seqRollback   The argument sequence to pass to InstallTAPInterfacesRollback custom
+ * @param seqRollback   The argument sequence to pass to InstallTAPAdaptersRollback custom
  *                      action. NULL when rollback is disabled.
  *
- * @param szDisplayName  Interface display name.
+ * @param szDisplayName  Adapter display name.
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
- *                      indicator) the InstallTAPInterfaces will take. This function increments it
- *                      by MSICA_INTERFACE_TICK_SIZE for each interface to create.
+ *                      indicator) the InstallTAPAdapters will take. This function increments it
+ *                      by MSICA_ADAPTER_TICK_SIZE for each adapter to create.
  *
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static DWORD
-schedule_interface_create(
+schedule_adapter_create(
     _Inout_ struct msica_arg_seq *seq,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
     _In_z_ LPCTSTR szDisplayName,
     _Inout_ int *iTicks)
 {
-    /* Get all available network interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
+    /* Get all available network adapters. */
+    struct tap_adapter_node *pAdapterList = NULL;
+    DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, TRUE);
     if (dwResult != ERROR_SUCCESS)
     {
         return dwResult;
     }
 
-    /* Does interface exist? */
-    for (struct tap_interface_node *pInterfaceOther = pInterfaceList;; pInterfaceOther = pInterfaceOther->pNext)
+    /* Does adapter exist? */
+    for (struct tap_adapter_node *pAdapterOther = pAdapterList;; pAdapterOther = pAdapterOther->pNext)
     {
-        if (pInterfaceOther == NULL)
+        if (pAdapterOther == NULL)
         {
-            /* No interface with a same name found. */
+            /* No adapter with a same name found. */
             TCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*terminator*/];
 
-            /* InstallTAPInterfaces will create the interface. */
+            /* InstallTAPAdapters will create the adapter. */
             _stprintf_s(
                 szArgument, _countof(szArgument),
                 TEXT("create=\"%.*s\""),
@@ -595,7 +595,7 @@ schedule_interface_create(
 
             if (seqRollback)
             {
-                /* InstallTAPInterfacesRollback will delete the interface. */
+                /* InstallTAPAdaptersRollback will delete the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("deleteN=\"%.*s\""),
@@ -603,132 +603,132 @@ schedule_interface_create(
                 msica_arg_seq_add_head(seqRollback, szArgument);
             }
 
-            *iTicks += MSICA_INTERFACE_TICK_SIZE;
+            *iTicks += MSICA_ADAPTER_TICK_SIZE;
             break;
         }
-        else if (_tcsicmp(szDisplayName, pInterfaceOther->szName) == 0)
+        else if (_tcsicmp(szDisplayName, pAdapterOther->szName) == 0)
         {
-            /* Interface with a same name found. */
-            for (LPCTSTR hwid = pInterfaceOther->szzHardwareIDs;; hwid += _tcslen(hwid) + 1)
+            /* Adapter with a same name found. */
+            for (LPCTSTR hwid = pAdapterOther->szzHardwareIDs;; hwid += _tcslen(hwid) + 1)
             {
                 if (hwid[0] == 0)
                 {
-                    /* This is not a TAP interface. */
-                    msg(M_NONFATAL, "%s: Interface with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pInterfaceOther->szName);
+                    /* This is not a TAP adapter. */
+                    msg(M_NONFATAL, "%s: Adapter with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pAdapterOther->szName);
                     dwResult = ERROR_ALREADY_EXISTS;
-                    goto cleanup_pInterfaceList;
+                    goto cleanup_pAdapterList;
                 }
                 else if (
                     _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
                     || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
                 {
-                    /* This is a TAP-Windows6 interface. We already have what we want! */
+                    /* This is a TAP-Windows6 adapter. We already have what we want! */
                     break;
                 }
             }
-            break; /* Interface names are unique. There should be no other interface with this name. */
+            break; /* Adapter names are unique. There should be no other adapter with this name. */
         }
     }
 
-cleanup_pInterfaceList:
-    tap_free_interface_list(pInterfaceList);
+cleanup_pAdapterList:
+    tap_free_adapter_list(pAdapterList);
     return dwResult;
 }
 
 
 /**
- * Schedules interface deletion.
+ * Schedules adapter deletion.
  *
- * When the rollback is enabled, the interface deletition is scheduled as: disable in
- * UninstallTAPInterfaces, enable on rollback, delete on commit.
+ * When the rollback is enabled, the adapter deletition is scheduled as: disable in
+ * UninstallTAPAdapters, enable on rollback, delete on commit.
  *
- * When rollback is disabled, the interface deletition is scheduled as delete in
- * UninstallTAPInterfaces.
+ * When rollback is disabled, the adapter deletition is scheduled as delete in
+ * UninstallTAPAdapters.
  *
- * @param seq           The argument sequence to pass to UninstallTAPInterfaces custom action
+ * @param seq           The argument sequence to pass to UninstallTAPAdapters custom action
  *
- * @param seqCommit     The argument sequence to pass to UninstallTAPInterfacesCommit custom
+ * @param seqCommit     The argument sequence to pass to UninstallTAPAdaptersCommit custom
  *                      action. NULL when rollback is disabled.
  *
- * @param seqRollback   The argument sequence to pass to UninstallTAPInterfacesRollback custom
+ * @param seqRollback   The argument sequence to pass to UninstallTAPAdaptersRollback custom
  *                      action. NULL when rollback is disabled.
  *
- * @param szDisplayName  Interface display name.
+ * @param szDisplayName  Adapter display name.
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
- *                      indicator) the UninstallTAPInterfaces will take. This function increments
- *                      it by MSICA_INTERFACE_TICK_SIZE for each interface to delete.
+ *                      indicator) the UninstallTAPAdapters will take. This function increments
+ *                      it by MSICA_ADAPTER_TICK_SIZE for each adapter to delete.
  *
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static DWORD
-schedule_interface_delete(
+schedule_adapter_delete(
     _Inout_ struct msica_arg_seq *seq,
     _Inout_opt_ struct msica_arg_seq *seqCommit,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
     _In_z_ LPCTSTR szDisplayName,
     _Inout_ int *iTicks)
 {
-    /* Get available TUN/TAP interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
+    /* Get available TUN/TAP adapters. */
+    struct tap_adapter_node *pAdapterList = NULL;
+    DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
     if (dwResult != ERROR_SUCCESS)
     {
         return dwResult;
     }
 
-    /* Does interface exist? */
-    for (struct tap_interface_node *pInterface = pInterfaceList; pInterface != NULL; pInterface = pInterface->pNext)
+    /* Does adapter exist? */
+    for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
     {
-        if (_tcsicmp(szDisplayName, pInterface->szName) == 0)
+        if (_tcsicmp(szDisplayName, pAdapter->szName) == 0)
         {
-            /* Interface found. */
+            /* Adapter found. */
             TCHAR szArgument[8 /*disable=|enable=|delete=*/ + 38 /*{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}*/ + 1 /*terminator*/];
             if (seqCommit && seqRollback)
             {
-                /* UninstallTAPInterfaces will disable the interface. */
+                /* UninstallTAPAdapters will disable the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("disable=") TEXT(PRIXGUID),
-                    PRIGUID_PARAM(pInterface->guid));
+                    PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seq, szArgument);
 
-                /* UninstallTAPInterfacesRollback will re-enable the interface. */
+                /* UninstallTAPAdaptersRollback will re-enable the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("enable=") TEXT(PRIXGUID),
-                    PRIGUID_PARAM(pInterface->guid));
+                    PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_head(seqRollback, szArgument);
 
-                /* UninstallTAPInterfacesCommit will delete the interface. */
+                /* UninstallTAPAdaptersCommit will delete the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("delete=") TEXT(PRIXGUID),
-                    PRIGUID_PARAM(pInterface->guid));
+                    PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seqCommit, szArgument);
             }
             else
             {
-                /* UninstallTAPInterfaces will delete the interface. */
+                /* UninstallTAPAdapters will delete the adapter. */
                 _stprintf_s(
                     szArgument, _countof(szArgument),
                     TEXT("delete=") TEXT(PRIXGUID),
-                    PRIGUID_PARAM(pInterface->guid));
+                    PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seq, szArgument);
             }
 
-            iTicks += MSICA_INTERFACE_TICK_SIZE;
-            break; /* Interface names are unique. There should be no other interface with this name. */
+            iTicks += MSICA_ADAPTER_TICK_SIZE;
+            break; /* Adapter names are unique. There should be no other adapter with this name. */
         }
     }
 
-    tap_free_interface_list(pInterfaceList);
+    tap_free_adapter_list(pAdapterList);
     return dwResult;
 }
 
 
 UINT __stdcall
-EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
+EvaluateTAPAdapters(_In_ MSIHANDLE hInstall)
 {
 #ifdef _MSC_VER
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -742,18 +742,18 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     struct msica_arg_seq
-        seqInstallTAPInterfaces,
-        seqInstallTAPInterfacesCommit,
-        seqInstallTAPInterfacesRollback,
-        seqUninstallTAPInterfaces,
-        seqUninstallTAPInterfacesCommit,
-        seqUninstallTAPInterfacesRollback;
-    msica_arg_seq_init(&seqInstallTAPInterfaces);
-    msica_arg_seq_init(&seqInstallTAPInterfacesCommit);
-    msica_arg_seq_init(&seqInstallTAPInterfacesRollback);
-    msica_arg_seq_init(&seqUninstallTAPInterfaces);
-    msica_arg_seq_init(&seqUninstallTAPInterfacesCommit);
-    msica_arg_seq_init(&seqUninstallTAPInterfacesRollback);
+        seqInstallTAPAdapters,
+        seqInstallTAPAdaptersCommit,
+        seqInstallTAPAdaptersRollback,
+        seqUninstallTAPAdapters,
+        seqUninstallTAPAdaptersCommit,
+        seqUninstallTAPAdaptersRollback;
+    msica_arg_seq_init(&seqInstallTAPAdapters);
+    msica_arg_seq_init(&seqInstallTAPAdaptersCommit);
+    msica_arg_seq_init(&seqInstallTAPAdaptersRollback);
+    msica_arg_seq_init(&seqUninstallTAPAdapters);
+    msica_arg_seq_init(&seqUninstallTAPAdaptersCommit);
+    msica_arg_seq_init(&seqUninstallTAPAdaptersRollback);
 
     /* Check rollback state. */
     bool bRollbackEnabled = MsiEvaluateCondition(hInstall, TEXT("RollbackDisabled")) != MSICONDITION_TRUE;
@@ -767,8 +767,8 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
         goto cleanup_exec_seq;
     }
 
-    /* Check if TAPInterface table exists. If it doesn't exist, there's nothing to do. */
-    switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TAPInterface")))
+    /* Check if TAPAdapter table exists. If it doesn't exist, there's nothing to do. */
+    switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TAPAdapter")))
     {
         case MSICONDITION_FALSE:
         case MSICONDITION_TRUE: break;
@@ -778,9 +778,9 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
             goto cleanup_hDatabase;
     }
 
-    /* Prepare a query to get a list/view of interfaces. */
+    /* Prepare a query to get a list/view of adapters. */
     MSIHANDLE hViewST = 0;
-    LPCTSTR szQuery = TEXT("SELECT `Interface`,`DisplayName`,`Condition`,`Component_` FROM `TAPInterface`");
+    LPCTSTR szQuery = TEXT("SELECT `Adapter`,`DisplayName`,`Condition`,`Component_` FROM `TAPAdapter`");
     uiResult = MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
     if (uiResult != ERROR_SUCCESS)
     {
@@ -826,7 +826,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 
         INSTALLSTATE iInstalled, iAction;
         {
-            /* Read interface component ID (`Component_` is field #4). */
+            /* Read adapter component ID (`Component_` is field #4). */
             LPTSTR szValue = NULL;
             uiResult = msi_get_record_string(hRecord, 4, &szValue);
             if (uiResult != ERROR_SUCCESS)
@@ -846,7 +846,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
             free(szValue);
         }
 
-        /* Get interface display name (`DisplayName` is field #2). */
+        /* Get adapter display name (`DisplayName` is field #2). */
         LPTSTR szDisplayName = NULL;
         uiResult = msi_format_field(hInstall, hRecord, 2, &szDisplayName);
         if (uiResult != ERROR_SUCCESS)
@@ -863,7 +863,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 
             if (iAction >= INSTALLSTATE_LOCAL)
             {
-                /* Read and evaluate interface condition (`Condition` is field #3). */
+                /* Read and evaluate adapter condition (`Condition` is field #3). */
                 LPTSTR szValue = NULL;
                 uiResult = msi_get_record_string(hRecord, 3, &szValue);
                 if (uiResult != ERROR_SUCCESS)
@@ -895,10 +895,10 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 #endif
                 free(szValue);
 
-                /* Component is or should be installed. Schedule interface creation. */
-                if (schedule_interface_create(
-                        &seqInstallTAPInterfaces,
-                        bRollbackEnabled ? &seqInstallTAPInterfacesRollback : NULL,
+                /* Component is or should be installed. Schedule adapter creation. */
+                if (schedule_adapter_create(
+                        &seqInstallTAPAdapters,
+                        bRollbackEnabled ? &seqInstallTAPAdaptersRollback : NULL,
                         szDisplayNameEx,
                         &iTicks) != ERROR_SUCCESS)
                 {
@@ -908,15 +908,15 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
             }
             else
             {
-                /* Component is installed, but should be degraded to advertised/removed. Schedule interface deletition.
+                /* Component is installed, but should be degraded to advertised/removed. Schedule adapter deletition.
                  *
-                 * Note: On interface removal (product is being uninstalled), we tolerate dwResult error.
+                 * Note: On adapter removal (product is being uninstalled), we tolerate dwResult error.
                  * Better a partial uninstallation than no uninstallation at all.
                  */
-                schedule_interface_delete(
-                    &seqUninstallTAPInterfaces,
-                    bRollbackEnabled ? &seqUninstallTAPInterfacesCommit : NULL,
-                    bRollbackEnabled ? &seqUninstallTAPInterfacesRollback : NULL,
+                schedule_adapter_delete(
+                    &seqUninstallTAPAdapters,
+                    bRollbackEnabled ? &seqUninstallTAPAdaptersCommit : NULL,
+                    bRollbackEnabled ? &seqUninstallTAPAdaptersRollback : NULL,
                     szDisplayNameEx,
                     &iTicks);
             }
@@ -943,12 +943,12 @@ cleanup_hRecord:
     }
 
     /* Store deferred custom action parameters. */
-    if ((uiResult = setup_sequence(hInstall, TEXT("InstallTAPInterfaces"          ), &seqInstallTAPInterfaces          )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPInterfacesCommit"    ), &seqInstallTAPInterfacesCommit    )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPInterfacesRollback"  ), &seqInstallTAPInterfacesRollback  )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPInterfaces"        ), &seqUninstallTAPInterfaces        )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPInterfacesCommit"  ), &seqUninstallTAPInterfacesCommit  )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPInterfacesRollback"), &seqUninstallTAPInterfacesRollback)) != ERROR_SUCCESS)
+    if ((uiResult = setup_sequence(hInstall, TEXT("InstallTAPAdapters"          ), &seqInstallTAPAdapters          )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPAdaptersCommit"    ), &seqInstallTAPAdaptersCommit    )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("InstallTAPAdaptersRollback"  ), &seqInstallTAPAdaptersRollback  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPAdapters"        ), &seqUninstallTAPAdapters        )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPAdaptersCommit"  ), &seqUninstallTAPAdaptersCommit  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTAPAdaptersRollback"), &seqUninstallTAPAdaptersRollback)) != ERROR_SUCCESS)
     {
         goto cleanup_hRecordProg;
     }
@@ -964,12 +964,12 @@ cleanup_hViewST:
 cleanup_hDatabase:
     MsiCloseHandle(hDatabase);
 cleanup_exec_seq:
-    msica_arg_seq_free(&seqInstallTAPInterfaces);
-    msica_arg_seq_free(&seqInstallTAPInterfacesCommit);
-    msica_arg_seq_free(&seqInstallTAPInterfacesRollback);
-    msica_arg_seq_free(&seqUninstallTAPInterfaces);
-    msica_arg_seq_free(&seqUninstallTAPInterfacesCommit);
-    msica_arg_seq_free(&seqUninstallTAPInterfacesRollback);
+    msica_arg_seq_free(&seqInstallTAPAdapters);
+    msica_arg_seq_free(&seqInstallTAPAdaptersCommit);
+    msica_arg_seq_free(&seqInstallTAPAdaptersRollback);
+    msica_arg_seq_free(&seqUninstallTAPAdapters);
+    msica_arg_seq_free(&seqUninstallTAPAdaptersCommit);
+    msica_arg_seq_free(&seqUninstallTAPAdaptersRollback);
     if (bIsCoInitialized)
     {
         CoUninitialize();
@@ -1052,13 +1052,13 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 
         if (wcsncmp(szArg[i], L"create=", 7) == 0)
         {
-            /* Create an interface with a given name. */
+            /* Create an adapter with a given name. */
             LPCWSTR szName = szArg[i] + 7;
 
             {
-                /* Report the name of the interface to installer. */
+                /* Report the name of the adapter to installer. */
                 MSIHANDLE hRecord = MsiCreateRecord(3);
-                MsiRecordSetString(hRecord, 1, TEXT("Creating interface"));
+                MsiRecordSetString(hRecord, 1, TEXT("Creating adapter"));
                 MsiRecordSetString(hRecord, 2, szName);
                 int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
                 MsiCloseHandle(hRecord);
@@ -1069,27 +1069,27 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
                 }
             }
 
-            GUID guidInterface;
-            dwResult = tap_create_interface(NULL, NULL, NULL, &bRebootRequired, &guidInterface);
+            GUID guidAdapter;
+            dwResult = tap_create_adapter(NULL, NULL, NULL, &bRebootRequired, &guidAdapter);
             if (dwResult == ERROR_SUCCESS)
             {
-                /* Set interface name. */
-                dwResult = tap_set_interface_name(&guidInterface, szName);
+                /* Set adapter name. */
+                dwResult = tap_set_adapter_name(&guidAdapter, szName);
                 if (dwResult != ERROR_SUCCESS)
                 {
-                    tap_delete_interface(NULL, &guidInterface, &bRebootRequired);
+                    tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
                 }
             }
         }
         else if (wcsncmp(szArg[i], L"deleteN=", 8) == 0)
         {
-            /* Delete the interface by name. */
+            /* Delete the adapter by name. */
             LPCWSTR szName = szArg[i] + 8;
 
             {
-                /* Report the name of the interface to installer. */
+                /* Report the name of the adapter to installer. */
                 MSIHANDLE hRecord = MsiCreateRecord(3);
-                MsiRecordSetString(hRecord, 1, TEXT("Deleting interface"));
+                MsiRecordSetString(hRecord, 1, TEXT("Deleting adapter"));
                 MsiRecordSetString(hRecord, 2, szName);
                 int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
                 MsiCloseHandle(hRecord);
@@ -1100,54 +1100,54 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
                 }
             }
 
-            /* Get available TUN/TAP interfaces. */
-            struct tap_interface_node *pInterfaceList = NULL;
-            dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
+            /* Get available TUN/TAP adapters. */
+            struct tap_adapter_node *pAdapterList = NULL;
+            dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
             if (dwResult == ERROR_SUCCESS)
             {
-                /* Does the interface exist? */
-                for (struct tap_interface_node *pInterface = pInterfaceList; pInterface != NULL; pInterface = pInterface->pNext)
+                /* Does the adapter exist? */
+                for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
                 {
-                    if (_tcsicmp(szName, pInterface->szName) == 0)
+                    if (_tcsicmp(szName, pAdapter->szName) == 0)
                     {
-                        /* Interface found. */
-                        dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
+                        /* Adapter found. */
+                        dwResult = tap_delete_adapter(NULL, &pAdapter->guid, &bRebootRequired);
                         break;
                     }
                 }
 
-                tap_free_interface_list(pInterfaceList);
+                tap_free_adapter_list(pAdapterList);
             }
         }
         else if (wcsncmp(szArg[i], L"delete=", 7) == 0)
         {
-            /* Delete the interface by GUID. */
+            /* Delete the adapter by GUID. */
             GUID guid;
             if (!parse_guid(szArg[i] + 7, &guid))
             {
                 goto invalid_argument;
             }
-            dwResult = tap_delete_interface(NULL, &guid, &bRebootRequired);
+            dwResult = tap_delete_adapter(NULL, &guid, &bRebootRequired);
         }
         else if (wcsncmp(szArg[i], L"enable=", 7) == 0)
         {
-            /* Enable the interface. */
+            /* Enable the adapter. */
             GUID guid;
             if (!parse_guid(szArg[i] + 7, &guid))
             {
                 goto invalid_argument;
             }
-            dwResult = tap_enable_interface(NULL, &guid, TRUE, &bRebootRequired);
+            dwResult = tap_enable_adapter(NULL, &guid, TRUE, &bRebootRequired);
         }
         else if (wcsncmp(szArg[i], L"disable=", 8) == 0)
         {
-            /* Disable the interface. */
+            /* Disable the adapter. */
             GUID guid;
             if (!parse_guid(szArg[i] + 8, &guid))
             {
                 goto invalid_argument;
             }
-            dwResult = tap_enable_interface(NULL, &guid, FALSE, &bRebootRequired);
+            dwResult = tap_enable_adapter(NULL, &guid, FALSE, &bRebootRequired);
         }
         else
         {
@@ -1161,7 +1161,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
         }
 
         /* Report progress and check for user cancellation. */
-        MsiRecordSetInteger(hRecordProg, 2, MSICA_INTERFACE_TICK_SIZE);
+        MsiRecordSetInteger(hRecordProg, 2, MSICA_ADAPTER_TICK_SIZE);
         if (MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
         {
             dwResult = ERROR_INSTALL_USEREXIT;
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 1486c043..14fb78a2 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -90,8 +90,9 @@ FindSystemInfo(_In_ MSIHANDLE hInstall);
 
 
 /**
- * Find existing TAP interfaces and set TAPINTERFACES property with semicolon delimited list
- * of installed TAP interface GUIDs.
+ * Find existing TAP adapters and set TAPADAPTERS and ACTIVETAPADAPTERS properties with
+ * semicolon delimited list of all installed TAP adapter GUIDs and active adapter GUIDs
+ * respectively.
  *
  * @param hInstall      Handle to the installation provided to the DLL custom action
  *
@@ -99,7 +100,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall);
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
 DLLEXP_DECL UINT __stdcall
-FindTAPInterfaces(_In_ MSIHANDLE hInstall);
+FindTAPAdapters(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -128,8 +129,8 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
 
 
 /**
- * Evaluate the TAPInterface table of the MSI package database and prepare a list of TAP
- * interfaces to install/remove.
+ * Evaluate the TAPAdapter table of the MSI package database and prepare a list of TAP
+ * adapters to install/remove.
  *
  * @param hInstall      Handle to the installation provided to the DLL custom action
  *
@@ -137,7 +138,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
 DLLEXP_DECL UINT __stdcall
-EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall);
+EvaluateTAPAdapters(_In_ MSIHANDLE hInstall);
 
 
 /**
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index bf215862..1cc86424 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -1,5 +1,5 @@
 /*
- *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
@@ -57,9 +57,9 @@ static const TCHAR usage_message[] =
     TEXT("\n")
     TEXT("Commands:\n")
     TEXT("\n")
-    TEXT("create     Create a new TUN/TAP interface\n")
-    TEXT("list       List TUN/TAP interfaces\n")
-    TEXT("delete     Delete specified network interface\n")
+    TEXT("create     Create a new TUN/TAP adapter\n")
+    TEXT("list       List TUN/TAP adapters\n")
+    TEXT("delete     Delete specified network adapter\n")
     TEXT("help       Display this text\n")
     TEXT("\n")
     TEXT("Hint: Use \"tapctl help <command>\" to display help for particular command.\n")
@@ -68,7 +68,7 @@ static const TCHAR usage_message[] =
 static const TCHAR usage_message_create[] =
     TEXT("%s\n")
     TEXT("\n")
-    TEXT("Creates a new TUN/TAP interface\n")
+    TEXT("Creates a new TUN/TAP adapter\n")
     TEXT("\n")
     TEXT("Usage:\n")
     TEXT("\n")
@@ -76,23 +76,23 @@ static const TCHAR usage_message_create[] =
     TEXT("\n")
     TEXT("Options:\n")
     TEXT("\n")
-    TEXT("--name <name>  Set TUN/TAP interface name. Should the interface with given name\n")
+    TEXT("--name <name>  Set TUN/TAP adapter name. Should the adapter with given name    \n")
     TEXT("               already exist, an error is returned. If this option is not      \n")
-    TEXT("               specified, a default interface name is chosen by Windows.       \n")
+    TEXT("               specified, a default adapter name is chosen by Windows.         \n")
     TEXT("               Note: This name can also be specified as OpenVPN's --dev-node   \n")
     TEXT("               option.                                                         \n")
-    TEXT("--hwid <hwid>  Interface hardware id. Default value is root\\tap0901, which    \n")
+    TEXT("--hwid <hwid>  Adapter hardware id. Default value is root\\tap0901, which      \n")
     TEXT("               describes tap-windows6 driver. To work with wintun driver,      \n")
     TEXT("               specify 'wintun'.                                               \n")
     TEXT("Output:\n")
     TEXT("\n")
-    TEXT("This command prints newly created TUN/TAP interface's GUID to stdout.          \n")
+    TEXT("This command prints newly created TUN/TAP adapter's GUID to stdout.          \n")
 ;
 
 static const TCHAR usage_message_list[] =
     TEXT("%s\n")
     TEXT("\n")
-    TEXT("Lists TUN/TAP interfaces\n")
+    TEXT("Lists TUN/TAP adapters\n")
     TEXT("\n")
     TEXT("Usage:\n")
     TEXT("\n")
@@ -100,22 +100,22 @@ static const TCHAR usage_message_list[] =
     TEXT("\n")
     TEXT("Options:\n")
     TEXT("\n")
-    TEXT("--hwid <hwid>  Interface hardware id. Default value is root\\tap0901, which    \n")
+    TEXT("--hwid <hwid>  Adapter hardware id. Default value is root\\tap0901, which      \n")
     TEXT("               describes tap-windows6 driver. To work with wintun driver,      \n")
     TEXT("               specify 'wintun'.                                               \n")
     TEXT("Output:\n")
     TEXT("\n")
-    TEXT("This command prints all TUN/TAP interfaces to stdout.                          \n")
+    TEXT("This command prints all TUN/TAP adapters to stdout.                          \n")
 ;
 
 static const TCHAR usage_message_delete[] =
     TEXT("%s\n")
     TEXT("\n")
-    TEXT("Deletes the specified network interface\n")
+    TEXT("Deletes the specified network adapter\n")
     TEXT("\n")
     TEXT("Usage:\n")
     TEXT("\n")
-    TEXT("tapctl delete <interface GUID | interface name>\n")
+    TEXT("tapctl delete <adapter GUID | adapter name>\n")
 ;
 
 
@@ -197,75 +197,75 @@ _tmain(int argc, LPCTSTR argv[])
             }
         }
 
-        /* Create TUN/TAP interface. */
-        GUID guidInterface;
-        LPOLESTR szInterfaceId = NULL;
-        DWORD dwResult = tap_create_interface(
+        /* Create TUN/TAP adapter. */
+        GUID guidAdapter;
+        LPOLESTR szAdapterId = NULL;
+        DWORD dwResult = tap_create_adapter(
             NULL,
             TEXT("Virtual Ethernet"),
             szHwId,
             &bRebootRequired,
-            &guidInterface);
+            &guidAdapter);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Creating TUN/TAP interface failed (error 0x%x).\n"), dwResult);
+            _ftprintf(stderr, TEXT("Creating TUN/TAP adapter failed (error 0x%x).\n"), dwResult);
             iResult = 1; goto quit;
         }
 
         if (szName)
         {
-            /* Get the list of all available interfaces. */
-            struct tap_interface_node *pInterfaceList = NULL;
-            dwResult = tap_list_interfaces(NULL, szHwId, &pInterfaceList, TRUE);
+            /* Get the list of all available adapters. */
+            struct tap_adapter_node *pAdapterList = NULL;
+            dwResult = tap_list_adapters(NULL, szHwId, &pAdapterList, TRUE);
             if (dwResult != ERROR_SUCCESS)
             {
-                _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
-                iResult = 1; goto create_delete_interface;
+                _ftprintf(stderr, TEXT("Enumerating adapters failed (error 0x%x).\n"), dwResult);
+                iResult = 1; goto create_delete_adapter;
             }
 
             /* Check for duplicates. */
-            for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+            for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
             {
-                if (_tcsicmp(szName, pInterface->szName) == 0)
+                if (_tcsicmp(szName, pAdapter->szName) == 0)
                 {
-                    StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
-                    _ftprintf(stderr, TEXT("Interface \"%s\" already exists (GUID %") TEXT(PRIsLPOLESTR) TEXT(").\n"), pInterface->szName, szInterfaceId);
-                    CoTaskMemFree(szInterfaceId);
-                    iResult = 1; goto create_cleanup_pInterfaceList;
+                    StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
+                    _ftprintf(stderr, TEXT("Adapter \"%s\" already exists (GUID %") TEXT(PRIsLPOLESTR) TEXT(").\n"), pAdapter->szName, szAdapterId);
+                    CoTaskMemFree(szAdapterId);
+                    iResult = 1; goto create_cleanup_pAdapterList;
                 }
             }
 
-            /* Rename the interface. */
-            dwResult = tap_set_interface_name(&guidInterface, szName);
+            /* Rename the adapter. */
+            dwResult = tap_set_adapter_name(&guidAdapter, szName);
             if (dwResult != ERROR_SUCCESS)
             {
-                StringFromIID((REFIID)&guidInterface, &szInterfaceId);
-                _ftprintf(stderr, TEXT("Renaming TUN/TAP interface %") TEXT(PRIsLPOLESTR) TEXT(" to \"%s\" failed (error 0x%x).\n"), szInterfaceId, szName, dwResult);
-                CoTaskMemFree(szInterfaceId);
+                StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+                _ftprintf(stderr, TEXT("Renaming TUN/TAP adapter %") TEXT(PRIsLPOLESTR) TEXT(" to \"%s\" failed (error 0x%x).\n"), szAdapterId, szName, dwResult);
+                CoTaskMemFree(szAdapterId);
                 iResult = 1; goto quit;
             }
 
             iResult = 0;
 
-create_cleanup_pInterfaceList:
-            tap_free_interface_list(pInterfaceList);
+create_cleanup_pAdapterList:
+            tap_free_adapter_list(pAdapterList);
             if (iResult)
             {
-                goto create_delete_interface;
+                goto create_delete_adapter;
             }
         }
 
-        /* Output interface GUID. */
-        StringFromIID((REFIID)&guidInterface, &szInterfaceId);
-        _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\n"), szInterfaceId);
-        CoTaskMemFree(szInterfaceId);
+        /* Output adapter GUID. */
+        StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+        _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\n"), szAdapterId);
+        CoTaskMemFree(szAdapterId);
 
         iResult = 0; goto quit;
 
-create_delete_interface:
-        tap_delete_interface(
+create_delete_adapter:
+        tap_delete_adapter(
             NULL,
-            &guidInterface,
+            &guidAdapter,
             &bRebootRequired);
         iResult = 1; goto quit;
     }
@@ -286,78 +286,78 @@ create_delete_interface:
             }
         }
 
-        /* Output list of TUN/TAP interfaces. */
-        struct tap_interface_node *pInterfaceList = NULL;
-        DWORD dwResult = tap_list_interfaces(NULL, szHwId, &pInterfaceList, FALSE);
+        /* Output list of TUN/TAP adapters. */
+        struct tap_adapter_node *pAdapterList = NULL;
+        DWORD dwResult = tap_list_adapters(NULL, szHwId, &pAdapterList, FALSE);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Enumerating TUN/TAP interfaces failed (error 0x%x).\n"), dwResult);
+            _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
             iResult = 1; goto quit;
         }
 
-        for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+        for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
         {
-            LPOLESTR szInterfaceId = NULL;
-            StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
-            _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\t%") TEXT(PRIsLPTSTR) TEXT("\n"), szInterfaceId, pInterface->szName);
-            CoTaskMemFree(szInterfaceId);
+            LPOLESTR szAdapterId = NULL;
+            StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
+            _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\t%") TEXT(PRIsLPTSTR) TEXT("\n"), szAdapterId, pAdapter->szName);
+            CoTaskMemFree(szAdapterId);
         }
 
         iResult = 0;
-        tap_free_interface_list(pInterfaceList);
+        tap_free_adapter_list(pAdapterList);
     }
     else if (_tcsicmp(argv[1], TEXT("delete")) == 0)
     {
         if (argc < 3)
         {
-            _ftprintf(stderr, TEXT("Missing interface GUID or name. Please, use \"tapctl help delete\" for usage info.\n"));
+            _ftprintf(stderr, TEXT("Missing adapter GUID or name. Please, use \"tapctl help delete\" for usage info.\n"));
             return 1;
         }
 
-        GUID guidInterface;
-        if (FAILED(IIDFromString(argv[2], (LPIID)&guidInterface)))
+        GUID guidAdapter;
+        if (FAILED(IIDFromString(argv[2], (LPIID)&guidAdapter)))
         {
-            /* The argument failed to covert to GUID. Treat it as the interface name. */
-            struct tap_interface_node *pInterfaceList = NULL;
-            DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
+            /* The argument failed to covert to GUID. Treat it as the adapter name. */
+            struct tap_adapter_node *pAdapterList = NULL;
+            DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
             if (dwResult != ERROR_SUCCESS)
             {
-                _ftprintf(stderr, TEXT("Enumerating TUN/TAP interfaces failed (error 0x%x).\n"), dwResult);
+                _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
                 iResult = 1; goto quit;
             }
 
-            for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
+            for (struct tap_adapter_node *pAdapter = pAdapterList;; pAdapter = pAdapter->pNext)
             {
-                if (pInterface == NULL)
+                if (pAdapter == NULL)
                 {
-                    _ftprintf(stderr, TEXT("\"%s\" interface not found.\n"), argv[2]);
-                    iResult = 1; goto delete_cleanup_pInterfaceList;
+                    _ftprintf(stderr, TEXT("\"%s\" adapter not found.\n"), argv[2]);
+                    iResult = 1; goto delete_cleanup_pAdapterList;
                 }
-                else if (_tcsicmp(argv[2], pInterface->szName) == 0)
+                else if (_tcsicmp(argv[2], pAdapter->szName) == 0)
                 {
-                    memcpy(&guidInterface, &pInterface->guid, sizeof(GUID));
+                    memcpy(&guidAdapter, &pAdapter->guid, sizeof(GUID));
                     break;
                 }
             }
 
             iResult = 0;
 
-delete_cleanup_pInterfaceList:
-            tap_free_interface_list(pInterfaceList);
+delete_cleanup_pAdapterList:
+            tap_free_adapter_list(pAdapterList);
             if (iResult)
             {
                 goto quit;
             }
         }
 
-        /* Delete the network interface. */
-        DWORD dwResult = tap_delete_interface(
+        /* Delete the network adapter. */
+        DWORD dwResult = tap_delete_adapter(
             NULL,
-            &guidInterface,
+            &guidAdapter,
             &bRebootRequired);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Deleting interface \"%s\" failed (error 0x%x).\n"), argv[2], dwResult);
+            _ftprintf(stderr, TEXT("Deleting adapter \"%s\" failed (error 0x%x).\n"), argv[2], dwResult);
             iResult = 1; goto quit;
         }
 
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index d4631679..d718d43e 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -1,5 +1,5 @@
 /*
- *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
@@ -44,8 +44,8 @@ const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc
 
 const static TCHAR szzDefaultHardwareIDs[] = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
 
-const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
-#define INTERFACE_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
+const static TCHAR szAdapterRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
+#define ADAPTER_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
 
 
 /**
@@ -60,7 +60,7 @@ const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentContro
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -82,7 +82,7 @@ typedef DWORD (*devop_func_t)(
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -129,7 +129,7 @@ check_reboot(
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -193,7 +193,7 @@ delete_device(
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -257,7 +257,7 @@ change_device_state(
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -283,7 +283,7 @@ enable_device(
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -444,7 +444,7 @@ get_reg_string(
 
 
 /**
- * Returns network interface ID.
+ * Returns network adapter ID.
  *
  * @param hDeviceInfoSet  A handle to a device information set that contains a device
  *                      information element that represents the device.
@@ -457,20 +457,20 @@ get_reg_string(
  *                      attempts to read NetCfgInstanceId value from registry. A 1sec sleep
  *                      is inserted between retry attempts.
  *
- * @param pguidInterface  A pointer to GUID that receives network interface ID.
+ * @param pguidAdapter  A pointer to GUID that receives network adapter ID.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 static DWORD
-get_net_interface_guid(
+get_net_adapter_guid(
     _In_ HDEVINFO hDeviceInfoSet,
     _In_ PSP_DEVINFO_DATA pDeviceInfoData,
     _In_ int iNumAttempts,
-    _Out_ LPGUID pguidInterface)
+    _Out_ LPGUID pguidAdapter)
 {
     DWORD dwResult = ERROR_BAD_ARGUMENTS;
 
-    if (pguidInterface == NULL || iNumAttempts < 1)
+    if (pguidAdapter == NULL || iNumAttempts < 1)
     {
         return ERROR_BAD_ARGUMENTS;
     }
@@ -519,7 +519,7 @@ get_net_interface_guid(
             break;
         }
 
-        dwResult = SUCCEEDED(CLSIDFromString(szCfgGuidString, (LPCLSID)pguidInterface)) ? ERROR_SUCCESS : ERROR_INVALID_DATA;
+        dwResult = SUCCEEDED(CLSIDFromString(szCfgGuidString, (LPCLSID)pguidAdapter)) ? ERROR_SUCCESS : ERROR_INVALID_DATA;
         free(szCfgGuidString);
         break;
     }
@@ -647,17 +647,17 @@ _tcszlen(_In_ LPCTSTR str)
 
 
 DWORD
-tap_create_interface(
+tap_create_adapter(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
     _In_opt_ LPCTSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
-    _Out_ LPGUID pguidInterface)
+    _Out_ LPGUID pguidAdapter)
 {
     DWORD dwResult;
 
     if (pbRebootRequired == NULL
-        || pguidInterface == NULL)
+        || pguidAdapter == NULL)
     {
         return ERROR_BAD_ARGUMENTS;
     }
@@ -876,7 +876,7 @@ tap_create_interface(
         msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REGISTER_COINSTALLERS) failed", __FUNCTION__);
     }
 
-    /* Install interfaces if any. */
+    /* Install adapters if any. */
     if (!SetupDiCallClassInstaller(
             DIF_INSTALLINTERFACES,
             hDevInfoList,
@@ -900,13 +900,13 @@ tap_create_interface(
     /* Check if a system reboot is required. (Ignore errors) */
     check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
 
-    /* Get network interface ID from registry. Retry for max 30sec. */
-    dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 30, pguidInterface);
+    /* Get network adapter ID from registry. Retry for max 30sec. */
+    dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 30, pguidAdapter);
 
 cleanup_remove_device:
     if (dwResult != ERROR_SUCCESS)
     {
-        /* The interface was installed. But, the interface ID was unobtainable. Clean-up. */
+        /* The adapter was installed. But, the adapter ID was unobtainable. Clean-up. */
         SP_REMOVEDEVICE_PARAMS removedevice_params =
         {
             .ClassInstallHeader =
@@ -958,35 +958,35 @@ cleanup_hDevInfoList:
 
 
 /**
- * Performs a given task on an interface.
+ * Performs a given task on an adapter.
  *
- * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ * @param hwndParent    A handle to the top-level window to use for any user adapter that is
  *                      related to non-device-specific actions (such as a select-device dialog
  *                      box that uses the global class driver list). This handle is optional
  *                      and can be NULL. If a specific top-level window is not required, set
  *                      hwndParent to NULL.
  *
- * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ * @param pguidAdapter  A pointer to GUID that contains network adapter ID.
  *
- * @param funcOperation  A pointer for the function to perform specific task on the interface.
+ * @param funcOperation  A pointer for the function to perform specific task on the adapter.
  *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 static DWORD
-execute_on_first_interface(
+execute_on_first_adapter(
     _In_opt_ HWND hwndParent,
-    _In_ LPCGUID pguidInterface,
+    _In_ LPCGUID pguidAdapter,
     _In_ devop_func_t funcOperation,
     _Inout_ LPBOOL pbRebootRequired)
 {
     DWORD dwResult;
 
-    if (pguidInterface == NULL)
+    if (pguidAdapter == NULL)
     {
         return ERROR_BAD_ARGUMENTS;
     }
@@ -1028,10 +1028,10 @@ execute_on_first_interface(
         {
             if (GetLastError() == ERROR_NO_MORE_ITEMS)
             {
-                LPOLESTR szInterfaceId = NULL;
-                StringFromIID((REFIID)pguidInterface, &szInterfaceId);
-                msg(M_NONFATAL, "%s: Interface %" PRIsLPOLESTR " not found", __FUNCTION__, szInterfaceId);
-                CoTaskMemFree(szInterfaceId);
+                LPOLESTR szAdapterId = NULL;
+                StringFromIID((REFIID)pguidAdapter, &szAdapterId);
+                msg(M_NONFATAL, "%s: Adapter %" PRIsLPOLESTR " not found", __FUNCTION__, szAdapterId);
+                CoTaskMemFree(szAdapterId);
                 dwResult = ERROR_FILE_NOT_FOUND;
                 goto cleanup_hDevInfoList;
             }
@@ -1043,9 +1043,9 @@ execute_on_first_interface(
             }
         }
 
-        /* Get interface GUID. */
-        GUID guidInterface;
-        dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
+        /* Get adapter GUID. */
+        GUID guidAdapter;
+        dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 1, &guidAdapter);
         if (dwResult != ERROR_SUCCESS)
         {
             /* Something is wrong with this device. Skip it. */
@@ -1053,7 +1053,7 @@ execute_on_first_interface(
         }
 
         /* Compare GUIDs. */
-        if (memcmp(pguidInterface, &guidInterface, sizeof(GUID)) == 0)
+        if (memcmp(pguidAdapter, &guidAdapter, sizeof(GUID)) == 0)
         {
             dwResult = funcOperation(hDevInfoList, &devinfo_data, pbRebootRequired);
             break;
@@ -1067,34 +1067,34 @@ cleanup_hDevInfoList:
 
 
 DWORD
-tap_delete_interface(
+tap_delete_adapter(
     _In_opt_ HWND hwndParent,
-    _In_ LPCGUID pguidInterface,
+    _In_ LPCGUID pguidAdapter,
     _Inout_ LPBOOL pbRebootRequired)
 {
-    return execute_on_first_interface(hwndParent, pguidInterface, delete_device, pbRebootRequired);
+    return execute_on_first_adapter(hwndParent, pguidAdapter, delete_device, pbRebootRequired);
 }
 
 
 DWORD
-tap_enable_interface(
+tap_enable_adapter(
     _In_opt_ HWND hwndParent,
-    _In_ LPCGUID pguidInterface,
+    _In_ LPCGUID pguidAdapter,
     _In_ BOOL bEnable,
     _Inout_ LPBOOL pbRebootRequired)
 {
-    return execute_on_first_interface(hwndParent, pguidInterface, bEnable ? enable_device : disable_device, pbRebootRequired);
+    return execute_on_first_adapter(hwndParent, pguidAdapter, bEnable ? enable_device : disable_device, pbRebootRequired);
 }
 
 
 DWORD
-tap_set_interface_name(
-    _In_ LPCGUID pguidInterface,
+tap_set_adapter_name(
+    _In_ LPCGUID pguidAdapter,
     _In_ LPCTSTR szName)
 {
     DWORD dwResult;
 
-    if (pguidInterface == NULL || szName == NULL)
+    if (pguidAdapter == NULL || szName == NULL)
     {
         return ERROR_BAD_ARGUMENTS;
     }
@@ -1103,19 +1103,19 @@ tap_set_interface_name(
     LPOLESTR szDevClassNetId = NULL;
     StringFromIID((REFIID)&GUID_DEVCLASS_NET, &szDevClassNetId);
 
-    /* Get the interface GUID as string. */
-    LPOLESTR szInterfaceId = NULL;
-    StringFromIID((REFIID)pguidInterface, &szInterfaceId);
+    /* Get the adapter GUID as string. */
+    LPOLESTR szAdapterId = NULL;
+    StringFromIID((REFIID)pguidAdapter, &szAdapterId);
 
     /* Render registry key path. */
-    TCHAR szRegKey[INTERFACE_REGKEY_PATH_MAX];
+    TCHAR szRegKey[ADAPTER_REGKEY_PATH_MAX];
     _stprintf_s(
         szRegKey, _countof(szRegKey),
-        szInterfaceRegKeyPathTemplate,
+        szAdapterRegKeyPathTemplate,
         szDevClassNetId,
-        szInterfaceId);
+        szAdapterId);
 
-    /* Open network interface registry key. */
+    /* Open network adapter registry key. */
     HKEY hKey = NULL;
     dwResult = RegOpenKeyEx(
         HKEY_LOCAL_MACHINE,
@@ -1127,10 +1127,10 @@ tap_set_interface_name(
     {
         SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
         msg(M_NONFATAL | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
-        goto cleanup_szInterfaceId;
+        goto cleanup_szAdapterId;
     }
 
-    /* Set the interface name. */
+    /* Set the adapter name. */
     size_t sizeName = ((_tcslen(szName) + 1) * sizeof(TCHAR));
 #ifdef _WIN64
     if (sizeName > DWORD_MAX)
@@ -1156,23 +1156,23 @@ tap_set_interface_name(
 
 cleanup_hKey:
     RegCloseKey(hKey);
-cleanup_szInterfaceId:
-    CoTaskMemFree(szInterfaceId);
+cleanup_szAdapterId:
+    CoTaskMemFree(szAdapterId);
     CoTaskMemFree(szDevClassNetId);
     return dwResult;
 }
 
 
 DWORD
-tap_list_interfaces(
+tap_list_adapters(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szHwId,
-    _Out_ struct tap_interface_node **ppInterface,
+    _Out_ struct tap_adapter_node **ppAdapter,
     _In_ BOOL bAll)
 {
     DWORD dwResult;
 
-    if (ppInterface == NULL)
+    if (ppAdapter == NULL)
     {
         return ERROR_BAD_ARGUMENTS;
     }
@@ -1212,8 +1212,8 @@ tap_list_interfaces(
     StringFromIID((REFIID)&GUID_DEVCLASS_NET, &szDevClassNetId);
 
     /* Iterate. */
-    *ppInterface = NULL;
-    struct tap_interface_node *pInterfaceTail = NULL;
+    *ppAdapter = NULL;
+    struct tap_adapter_node *pAdapterTail = NULL;
     for (DWORD dwIndex = 0;; dwIndex++)
     {
         /* Get the device from the list. */
@@ -1284,28 +1284,28 @@ tap_list_interfaces(
             goto cleanup_szzDeviceHardwareIDs;
         }
 
-        /* Get interface GUID. */
-        GUID guidInterface;
-        dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
+        /* Get adapter GUID. */
+        GUID guidAdapter;
+        dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 1, &guidAdapter);
         if (dwResult != ERROR_SUCCESS)
         {
             /* Something is wrong with this device. Skip it. */
             goto cleanup_szzDeviceHardwareIDs;
         }
 
-        /* Get the interface GUID as string. */
-        LPOLESTR szInterfaceId = NULL;
-        StringFromIID((REFIID)&guidInterface, &szInterfaceId);
+        /* Get the adapter GUID as string. */
+        LPOLESTR szAdapterId = NULL;
+        StringFromIID((REFIID)&guidAdapter, &szAdapterId);
 
         /* Render registry key path. */
-        TCHAR szRegKey[INTERFACE_REGKEY_PATH_MAX];
+        TCHAR szRegKey[ADAPTER_REGKEY_PATH_MAX];
         _stprintf_s(
             szRegKey, _countof(szRegKey),
-            szInterfaceRegKeyPathTemplate,
+            szAdapterRegKeyPathTemplate,
             szDevClassNetId,
-            szInterfaceId);
+            szAdapterId);
 
-        /* Open network interface registry key. */
+        /* Open network adapter registry key. */
         HKEY hKey = NULL;
         dwResult = RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -1317,10 +1317,10 @@ tap_list_interfaces(
         {
             SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
-            goto cleanup_szInterfaceId;
+            goto cleanup_szAdapterId;
         }
 
-        /* Read interface name. */
+        /* Read adapter name. */
         LPTSTR szName = NULL;
         dwResult = get_reg_string(
             hKey,
@@ -1329,42 +1329,42 @@ tap_list_interfaces(
         if (dwResult != ERROR_SUCCESS)
         {
             SetLastError(dwResult);
-            msg(M_WARN | M_ERRNO, "%s: Cannot determine %" PRIsLPOLESTR " interface name", __FUNCTION__, szInterfaceId);
+            msg(M_WARN | M_ERRNO, "%s: Cannot determine %" PRIsLPOLESTR " adapter name", __FUNCTION__, szAdapterId);
             goto cleanup_hKey;
         }
 
         /* Append to the list. */
         size_t hwid_size = (_tcszlen(szzDeviceHardwareIDs) + 1) * sizeof(TCHAR);
         size_t name_size = (_tcslen(szName) + 1) * sizeof(TCHAR);
-        struct tap_interface_node *node = (struct tap_interface_node *)malloc(sizeof(struct tap_interface_node) + hwid_size + name_size);
+        struct tap_adapter_node *node = (struct tap_adapter_node *)malloc(sizeof(struct tap_adapter_node) + hwid_size + name_size);
         if (node == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct tap_interface_node) + hwid_size + name_size);
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct tap_adapter_node) + hwid_size + name_size);
             dwResult = ERROR_OUTOFMEMORY; goto cleanup_szName;
         }
 
-        memcpy(&node->guid, &guidInterface, sizeof(GUID));
+        memcpy(&node->guid, &guidAdapter, sizeof(GUID));
         node->szzHardwareIDs = (LPTSTR)(node + 1);
         memcpy(node->szzHardwareIDs, szzDeviceHardwareIDs, hwid_size);
         node->szName = (LPTSTR)((LPBYTE)node->szzHardwareIDs + hwid_size);
         memcpy(node->szName, szName, name_size);
         node->pNext = NULL;
-        if (pInterfaceTail)
+        if (pAdapterTail)
         {
-            pInterfaceTail->pNext = node;
-            pInterfaceTail = node;
+            pAdapterTail->pNext = node;
+            pAdapterTail = node;
         }
         else
         {
-            *ppInterface = pInterfaceTail = node;
+            *ppAdapter = pAdapterTail = node;
         }
 
 cleanup_szName:
         free(szName);
 cleanup_hKey:
         RegCloseKey(hKey);
-cleanup_szInterfaceId:
-        CoTaskMemFree(szInterfaceId);
+cleanup_szAdapterId:
+        CoTaskMemFree(szAdapterId);
 cleanup_szzDeviceHardwareIDs:
         free(szzDeviceHardwareIDs);
     }
@@ -1379,16 +1379,16 @@ cleanup_hDevInfoList:
 
 
 void
-tap_free_interface_list(
-    _In_ struct tap_interface_node *pInterfaceList)
+tap_free_adapter_list(
+    _In_ struct tap_adapter_node *pAdapterList)
 {
     /* Iterate over all nodes of the list. */
-    while (pInterfaceList)
+    while (pAdapterList)
     {
-        struct tap_interface_node *node = pInterfaceList;
-        pInterfaceList = pInterfaceList->pNext;
+        struct tap_adapter_node *node = pAdapterList;
+        pAdapterList = pAdapterList->pNext;
 
-        /* Free the interface node. */
+        /* Free the adapter node. */
         free(node);
     }
 }
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 4c2d73ba..aec44ec8 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -1,5 +1,5 @@
 /*
- *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
@@ -26,9 +26,9 @@
 
 
 /**
- * Creates a TUN/TAP interface.
+ * Creates a TUN/TAP adapter.
  *
- * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ * @param hwndParent    A handle to the top-level window to use for any user adapter that is
  *                      related to non-device-specific actions (such as a select-device dialog
  *                      box that uses the global class driver list). This handle is optional
  *                      and can be NULL. If a specific top-level window is not required, set
@@ -44,106 +44,106 @@
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
- * @param pguidInterface  A pointer to GUID that receives network interface ID.
+ * @param pguidAdapter  A pointer to GUID that receives network adapter ID.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 DWORD
-tap_create_interface(
+tap_create_adapter(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
     _In_opt_ LPCTSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
-    _Out_ LPGUID pguidInterface);
+    _Out_ LPGUID pguidAdapter);
 
 
 /**
- * Deletes an interface.
+ * Deletes an adapter.
  *
- * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ * @param hwndParent    A handle to the top-level window to use for any user adapter that is
  *                      related to non-device-specific actions (such as a select-device dialog
  *                      box that uses the global class driver list). This handle is optional
  *                      and can be NULL. If a specific top-level window is not required, set
  *                      hwndParent to NULL.
  *
- * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ * @param pguidAdapter  A pointer to GUID that contains network adapter ID.
  *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 DWORD
-tap_delete_interface(
+tap_delete_adapter(
     _In_opt_ HWND hwndParent,
-    _In_ LPCGUID pguidInterface,
+    _In_ LPCGUID pguidAdapter,
     _Inout_ LPBOOL pbRebootRequired);
 
 
 /**
- * Enables or disables an interface.
+ * Enables or disables an adapter.
  *
- * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ * @param hwndParent    A handle to the top-level window to use for any user adapter that is
  *                      related to non-device-specific actions (such as a select-device dialog
  *                      box that uses the global class driver list). This handle is optional
  *                      and can be NULL. If a specific top-level window is not required, set
  *                      hwndParent to NULL.
  *
- * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ * @param pguidAdapter  A pointer to GUID that contains network adapter ID.
  *
  * @param bEnable       TRUE to enable; FALSE to disable
  *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
  *                      allows the flag to be globally initialized to FALSE and reused for multiple
- *                      interface manipulations.
+ *                      adapter manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 DWORD
-tap_enable_interface(
+tap_enable_adapter(
     _In_opt_ HWND hwndParent,
-    _In_ LPCGUID pguidInterface,
+    _In_ LPCGUID pguidAdapter,
     _In_ BOOL bEnable,
     _Inout_ LPBOOL pbRebootRequired);
 
 
 /**
- * Sets interface name.
+ * Sets adapter name.
  *
- * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ * @param pguidAdapter  A pointer to GUID that contains network adapter ID.
  *
- * @param szName        New interface name - must be unique
+ * @param szName        New adapter name - must be unique
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 DWORD
-tap_set_interface_name(
-    _In_ LPCGUID pguidInterface,
+tap_set_adapter_name(
+    _In_ LPCGUID pguidAdapter,
     _In_ LPCTSTR szName);
 
 
 /**
- * Network interface list node
+ * Network adapter list node
  */
-struct tap_interface_node
+struct tap_adapter_node
 {
-    GUID guid;             /** Interface GUID */
+    GUID guid;             /** Adapter GUID */
     LPTSTR szzHardwareIDs; /** Device hardware ID(s) */
-    LPTSTR szName;         /** Interface name */
+    LPTSTR szName;         /** Adapter name */
 
-    struct tap_interface_node *pNext; /** Pointer to next interface */
+    struct tap_adapter_node *pNext; /** Pointer to next adapter */
 };
 
 
 /**
- * Creates a list of available network interfaces.
+ * Creates a list of available network adapters.
  *
- * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ * @param hwndParent    A handle to the top-level window to use for any user adapter that is
  *                      related to non-device-specific actions (such as a select-device dialog
  *                      box that uses the global class driver list). This handle is optional
  *                      and can be NULL. If a specific top-level window is not required, set
@@ -153,30 +153,30 @@ struct tap_interface_node
  *                      of the device. This pointer is optional and can be NULL. Default value
  *                      is root\tap0901.
  *
- * @param ppInterfaceList  A pointer to the list to receive pointer to the first interface in
+ * @param ppAdapterList  A pointer to the list to receive pointer to the first adapter in
  *                      the list. After the list is no longer required, free it using
- *                      tap_free_interface_list().
+ *                      tap_free_adapter_list().
  *
- * @param bAll          When TRUE, all network interfaces found are added to the list. When
- *                      FALSE, only TUN/TAP interfaces found are added.
+ * @param bAll          When TRUE, all network adapters found are added to the list. When
+ *                      FALSE, only TUN/TAP adapters found are added.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
 DWORD
-tap_list_interfaces(
+tap_list_adapters(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szHwId,
-    _Out_ struct tap_interface_node **ppInterfaceList,
+    _Out_ struct tap_adapter_node **ppAdapterList,
     _In_ BOOL bAll);
 
 
 /**
- * Frees a list of network interfaces.
+ * Frees a list of network adapters.
  *
- * @param pInterfaceList  A pointer to the first interface in the list to free.
+ * @param pAdapterList  A pointer to the first adapter in the list to free.
  */
 void
-tap_free_interface_list(
-    _In_ struct tap_interface_node *pInterfaceList);
+tap_free_adapter_list(
+    _In_ struct tap_adapter_node *pAdapterList);
 
 #endif /* ifndef TAP_H */
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index f6f3cb75..2b3ff238 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -1,5 +1,5 @@
 /*
- *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *
  *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
  *
@@ -46,7 +46,7 @@ BEGIN
         BLOCK "040904b0"
         BEGIN
             VALUE "CompanyName", "The OpenVPN Project"
-            VALUE "FileDescription", "Utility to manipulate TUN/TAP interfaces on Windows"
+            VALUE "FileDescription", "Utility to manipulate TUN/TAP adapters on Windows"
             VALUE "FileVersion", PACKAGE_VERSION ".0"
             VALUE "InternalName", "OpenVPN"
             VALUE "LegalCopyright", "Copyright © The OpenVPN Project"
-- 
2.24.1.windows.2


