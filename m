From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:28 +0100
Message-Id: <20200309131728.380-12-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 12/12] tapctl: Support multiple hardware IDs
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

TAP-Windows6 adapters created with tapinstall/devcon.exe have hardware
ID "tap0901", where TAP-Windows6 adapters created with tapctl.exe have
hardware ID "root\\tap0901".

The enumeration of the network adapters have been extended to detect
adapters using a list of acceptable hardware IDs.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 43 ++++++++++++++++++---------------
 src/tapctl/main.c               |  8 +++---
 src/tapctl/tap.c                | 21 ++++++++++++----
 src/tapctl/tap.h                |  8 +++---
 4 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 28cf16b5..31e90bd2 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -251,7 +251,7 @@ cleanup_OpenSCManager:
 static UINT
 find_adapters(
     _In_ MSIHANDLE hInstall,
-    _In_z_ LPCTSTR szHardwareId,
+    _In_z_ LPCTSTR szzHardwareIDs,
     _In_z_ LPCTSTR szAdaptersPropertyName,
     _In_z_ LPCTSTR szActiveAdaptersPropertyName)
 {
@@ -259,7 +259,7 @@ find_adapters(
 
     /* Get network adapters with given hardware ID. */
     struct tap_adapter_node *pAdapterList = NULL;
-    uiResult = tap_list_adapters(NULL, szHardwareId, &pAdapterList);
+    uiResult = tap_list_adapters(NULL, szzHardwareIDs, &pAdapterList);
     if (uiResult != ERROR_SUCCESS)
     {
         return uiResult;
@@ -414,12 +414,12 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
     set_openvpnserv_state(hInstall);
     find_adapters(
         hInstall,
-        TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID),
+        TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0"),
         TEXT("TAPWINDOWS6ADAPTERS"),
         TEXT("ACTIVETAPWINDOWS6ADAPTERS"));
     find_adapters(
         hInstall,
-        TEXT("Wintun"),
+        TEXT("Wintun") TEXT("\0"),
         TEXT("WINTUNADAPTERS"),
         TEXT("ACTIVEWINTUNADAPTERS"));
 
@@ -652,7 +652,7 @@ cleanup_pAdapterList:
  *
  * @param szDisplayName  Adapter display name
  *
- * @param szHardwareId  Adapter hardware ID
+ * @param szzHardwareIDs  String of strings with acceptable adapter hardware IDs
  *
  * @param iTicks        Pointer to an integer that represents amount of work (on progress
  *                      indicator) the UninstallTUNTAPAdapters will take. This function increments
@@ -666,12 +666,12 @@ schedule_adapter_delete(
     _Inout_opt_ struct msica_arg_seq *seqCommit,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
     _In_z_ LPCTSTR szDisplayName,
-    _In_z_ LPCTSTR szHardwareId,
+    _In_z_ LPCTSTR szzHardwareIDs,
     _Inout_ int *iTicks)
 {
     /* Get adapters with given hardware ID. */
     struct tap_adapter_node *pAdapterList = NULL;
-    DWORD dwResult = tap_list_adapters(NULL, szHardwareId, &pAdapterList);
+    DWORD dwResult = tap_list_adapters(NULL, szzHardwareIDs, &pAdapterList);
     if (dwResult != ERROR_SUCCESS)
     {
         return dwResult;
@@ -858,11 +858,16 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
         szDisplayNameEx = szDisplayNameEx != NULL ? szDisplayNameEx + 1 : szDisplayName;
 
         /* Get adapter hardware ID (`HardwareId` is field #5). */
-        LPTSTR szHardwareId = NULL;
-        uiResult = msi_get_record_string(hRecord, 5, &szHardwareId);
-        if (uiResult != ERROR_SUCCESS)
+        TCHAR szzHardwareIDs[0x100] = { 0 };
         {
-            goto cleanup_szDisplayName;
+            LPTSTR szHwId = NULL;
+            uiResult = msi_get_record_string(hRecord, 5, &szHwId);
+            if (uiResult != ERROR_SUCCESS)
+            {
+                goto cleanup_szDisplayName;
+            }
+            memcpy_s(szzHardwareIDs, sizeof(szzHardwareIDs) - 2*sizeof(TCHAR) /*requires double zero termination*/, szHwId, _tcslen(szHwId)*sizeof(TCHAR));
+            free(szHwId);
         }
 
         if (iAction > INSTALLSTATE_BROKEN)
@@ -876,7 +881,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                 uiResult = msi_get_record_string(hRecord, 3, &szValue);
                 if (uiResult != ERROR_SUCCESS)
                 {
-                    goto cleanup_szHardwareId;
+                    goto cleanup_szDisplayName;
                 }
 #ifdef __GNUC__
 /*
@@ -890,13 +895,13 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                 {
                     case MSICONDITION_FALSE:
                         free(szValue);
-                        goto cleanup_szHardwareId;
+                        goto cleanup_szDisplayName;
 
                     case MSICONDITION_ERROR:
                         uiResult = ERROR_INVALID_FIELD;
                         msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szValue);
                         free(szValue);
-                        goto cleanup_szHardwareId;
+                        goto cleanup_szDisplayName;
                 }
 #ifdef __GNUC__
 #pragma GCC diagnostic pop
@@ -908,11 +913,11 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                         &seqInstall,
                         bRollbackEnabled ? &seqInstallRollback : NULL,
                         szDisplayNameEx,
-                        szHardwareId,
+                        szzHardwareIDs,
                         &iTicks) != ERROR_SUCCESS)
                 {
                     uiResult = ERROR_INSTALL_FAILED;
-                    goto cleanup_szHardwareId;
+                    goto cleanup_szDisplayName;
                 }
             }
             else
@@ -927,7 +932,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
                     bRollbackEnabled ? &seqUninstallCommit : NULL,
                     bRollbackEnabled ? &seqUninstallRollback : NULL,
                     szDisplayNameEx,
-                    szHardwareId,
+                    szzHardwareIDs,
                     &iTicks);
             }
 
@@ -938,12 +943,10 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
             if (MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
             {
                 uiResult = ERROR_INSTALL_USEREXIT;
-                goto cleanup_szHardwareId;
+                goto cleanup_szDisplayName;
             }
         }
 
-cleanup_szHardwareId:
-        free(szHardwareId);
 cleanup_szDisplayName:
         free(szDisplayName);
 cleanup_hRecord:
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index fdeda7bf..40164879 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -271,14 +271,16 @@ create_delete_adapter:
     }
     else if (_tcsicmp(argv[1], TEXT("list")) == 0)
     {
-        LPCTSTR szHwId = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID);
+        TCHAR szzHwId[0x100] = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
         {
             if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
             {
-                szHwId = argv[++i];
+                memset(szzHwId, 0, sizeof(szzHwId));
+                memcpy_s(szzHwId, sizeof(szzHwId) - 2*sizeof(TCHAR) /*requires double zero termination*/, argv[i], _tcslen(argv[i])*sizeof(TCHAR));
+                ++i;
             }
             else
             {
@@ -288,7 +290,7 @@ create_delete_adapter:
 
         /* Output list of adapters with given hardware ID. */
         struct tap_adapter_node *pAdapterList = NULL;
-        DWORD dwResult = tap_list_adapters(NULL, szHwId, &pAdapterList);
+        DWORD dwResult = tap_list_adapters(NULL, szzHwId, &pAdapterList);
         if (dwResult != ERROR_SUCCESS)
         {
             _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index bdef3fc1..8ece3fb9 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -1179,7 +1179,7 @@ cleanup_szAdapterId:
 DWORD
 tap_list_adapters(
     _In_opt_ HWND hwndParent,
-    _In_opt_ LPCTSTR szHwId,
+    _In_opt_ LPCTSTR szzHwIDs,
     _Out_ struct tap_adapter_node **ppAdapter)
 {
     DWORD dwResult;
@@ -1260,7 +1260,7 @@ tap_list_adapters(
         /* Check that hardware ID is REG_SZ/REG_MULTI_SZ, and optionally if it matches ours. */
         if (dwDataType == REG_SZ)
         {
-            if (szHwId && _tcsicmp(szzDeviceHardwareIDs, szHwId) != 0)
+            if (szzHwIDs && !_tcszistr(szzHwIDs, szzDeviceHardwareIDs))
             {
                 /* This is not our device. Skip it. */
                 goto cleanup_szzDeviceHardwareIDs;
@@ -1268,10 +1268,21 @@ tap_list_adapters(
         }
         else if (dwDataType == REG_MULTI_SZ)
         {
-            if (szHwId && _tcszistr(szzDeviceHardwareIDs, szHwId) == NULL)
+            if (szzHwIDs)
             {
-                /* This is not our device. Skip it. */
-                goto cleanup_szzDeviceHardwareIDs;
+                for (LPTSTR s = szzDeviceHardwareIDs;; s += _tcslen(s) + 1)
+                {
+                    if (s[0] == 0)
+                    {
+                        /* This is not our device. Skip it. */
+                        goto cleanup_szzDeviceHardwareIDs;
+                    }
+                    else if (_tcszistr(szzHwIDs, s))
+                    {
+                        /* This is our device. */
+                        break;
+                    }
+                }
             }
         }
         else
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 68662c82..102de32d 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -148,9 +148,9 @@ struct tap_adapter_node
  *                      and can be NULL. If a specific top-level window is not required, set
  *                      hwndParent to NULL.
  *
- * @param szHwId        A pointer to a NULL-terminated string that supplies the hardware id
- *                      of the device. This pointer is optional and can be NULL. When NULL,
- *                      all network adapters found are added to the list.
+ * @param szzHwIDs      A string of strings that supplies the list of hardware IDs of the device.
+ *                      This pointer is optional and can be NULL. When NULL, all network adapters
+ *                      found are added to the list.
  *
  * @param ppAdapterList  A pointer to the list to receive pointer to the first adapter in
  *                      the list. After the list is no longer required, free it using
@@ -161,7 +161,7 @@ struct tap_adapter_node
 DWORD
 tap_list_adapters(
     _In_opt_ HWND hwndParent,
-    _In_opt_ LPCTSTR szHwId,
+    _In_opt_ LPCTSTR szzHwIDs,
     _Out_ struct tap_adapter_node **ppAdapterList);
 
 
-- 
2.24.1.windows.2


