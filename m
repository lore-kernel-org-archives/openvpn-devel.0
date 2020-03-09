From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:26 +0100
Message-Id: <20200309131728.380-10-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 10/12] openvpnmsica,
 tapctl: Revise default hardware ID management
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

tap_create_adapter() and tap_list_adapter() no longer default to
"root\tap0901". Defining a default hardware ID value is at the
responsibility of upper layers that process user desires.

Since the tap_list_adapter() no longer defaults the hardware ID to
anything, its behavior was simplified to return all existing
adapters when a NULL hardware ID is specified.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c |  16 ++--
 src/tapctl/main.c               |  14 ++--
 src/tapctl/tap.c                | 134 ++++++++++++++++----------------
 src/tapctl/tap.h                |  17 ++--
 4 files changed, 86 insertions(+), 95 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index cfbda8da..ae9b007f 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -285,9 +285,9 @@ FindTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    /* Get all TUN/TAP network adapters. */
+    /* Get existing network adapters. */
     struct tap_adapter_node *pAdapterList = NULL;
-    uiResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
+    uiResult = tap_list_adapters(NULL, NULL, &pAdapterList);
     if (uiResult != ERROR_SUCCESS)
     {
         goto cleanup_CoInitialize;
@@ -573,9 +573,9 @@ schedule_adapter_create(
     _In_z_ LPCTSTR szHardwareId,
     _Inout_ int *iTicks)
 {
-    /* Get all available network adapters. */
+    /* Get existing network adapters. */
     struct tap_adapter_node *pAdapterList = NULL;
-    DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, TRUE);
+    DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
     if (dwResult != ERROR_SUCCESS)
     {
         return dwResult;
@@ -674,9 +674,9 @@ schedule_adapter_delete(
     _In_z_ LPCTSTR szHardwareId,
     _Inout_ int *iTicks)
 {
-    /* Get available adapters with given hardware ID. */
+    /* Get adapters with given hardware ID. */
     struct tap_adapter_node *pAdapterList = NULL;
-    DWORD dwResult = tap_list_adapters(NULL, szHardwareId, &pAdapterList, FALSE);
+    DWORD dwResult = tap_list_adapters(NULL, szHardwareId, &pAdapterList);
     if (dwResult != ERROR_SUCCESS)
     {
         return dwResult;
@@ -1125,9 +1125,9 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
                 }
             }
 
-            /* Get all available adapters. */
+            /* Get existing adapters. */
             struct tap_adapter_node *pAdapterList = NULL;
-            dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, TRUE);
+            dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
             if (dwResult == ERROR_SUCCESS)
             {
                 /* Does the adapter exist? */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 1cc86424..fdeda7bf 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -177,7 +177,7 @@ _tmain(int argc, LPCTSTR argv[])
     else if (_tcsicmp(argv[1], TEXT("create")) == 0)
     {
         LPCTSTR szName = NULL;
-        LPCTSTR szHwId = NULL;
+        LPCTSTR szHwId = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID);
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
@@ -214,9 +214,9 @@ _tmain(int argc, LPCTSTR argv[])
 
         if (szName)
         {
-            /* Get the list of all available adapters. */
+            /* Get existing network adapters. */
             struct tap_adapter_node *pAdapterList = NULL;
-            dwResult = tap_list_adapters(NULL, szHwId, &pAdapterList, TRUE);
+            dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
             if (dwResult != ERROR_SUCCESS)
             {
                 _ftprintf(stderr, TEXT("Enumerating adapters failed (error 0x%x).\n"), dwResult);
@@ -271,7 +271,7 @@ create_delete_adapter:
     }
     else if (_tcsicmp(argv[1], TEXT("list")) == 0)
     {
-        LPCTSTR szHwId = NULL;
+        LPCTSTR szHwId = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID);
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
@@ -286,9 +286,9 @@ create_delete_adapter:
             }
         }
 
-        /* Output list of TUN/TAP adapters. */
+        /* Output list of adapters with given hardware ID. */
         struct tap_adapter_node *pAdapterList = NULL;
-        DWORD dwResult = tap_list_adapters(NULL, szHwId, &pAdapterList, FALSE);
+        DWORD dwResult = tap_list_adapters(NULL, szHwId, &pAdapterList);
         if (dwResult != ERROR_SUCCESS)
         {
             _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
@@ -319,7 +319,7 @@ create_delete_adapter:
         {
             /* The argument failed to covert to GUID. Treat it as the adapter name. */
             struct tap_adapter_node *pAdapterList = NULL;
-            DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList, FALSE);
+            DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
             if (dwResult != ERROR_SUCCESS)
             {
                 _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index d718d43e..bdef3fc1 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -42,12 +42,53 @@
 
 const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
 
-const static TCHAR szzDefaultHardwareIDs[] = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
-
 const static TCHAR szAdapterRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
 #define ADAPTER_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
 
 
+/**
+ * Returns length of string of strings
+ *
+ * @param szz           Pointer to a string of strings (terminated by an empty string)
+ *
+ * @return Number of characters not counting the final zero terminator
+ **/
+static inline size_t
+_tcszlen(_In_z_ LPCTSTR szz)
+{
+    LPCTSTR s;
+    for (s = szz; s[0]; s += _tcslen(s) + 1)
+    {
+    }
+    return s - szz;
+}
+
+
+/**
+ * Checks if string is contained in the string of strings. Comparison is made case-insensitive.
+ *
+ * @param szzHay        Pointer to a string of strings (terminated by an empty string) we are
+ *                      looking in
+ *
+ * @param szNeedle      The string we are searching for
+ *
+ * @return Pointer to the string in szzHay that matches szNeedle is found; NULL otherwise
+ */
+static LPCTSTR
+_tcszistr(_In_z_ LPCTSTR szzHay, _In_z_ LPCTSTR szNeedle)
+{
+    for (LPCTSTR s = szzHay; s[0]; s += _tcslen(s) + 1)
+    {
+        if (_tcsicmp(s, szNeedle) == 0)
+        {
+            return s;
+        }
+    }
+
+    return NULL;
+}
+
+
 /**
  * Function that performs a specific task on a device
  *
@@ -628,45 +669,23 @@ get_device_reg_property(
 }
 
 
-/**
- * Returns length of list of strings
- *
- * @param str              Pointer to a list of strings terminated by an empty string.
- *
- * @return Number of characters not counting the final zero terminator
- **/
-static inline size_t
-_tcszlen(_In_ LPCTSTR str)
-{
-    LPCTSTR s;
-    for (s = str; s[0]; s += _tcslen(s) + 1)
-    {
-    }
-    return s - str;
-}
-
-
 DWORD
 tap_create_adapter(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
-    _In_opt_ LPCTSTR szHwId,
+    _In_ LPCTSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
     _Out_ LPGUID pguidAdapter)
 {
     DWORD dwResult;
 
-    if (pbRebootRequired == NULL
+    if (szHwId == NULL
+        || pbRebootRequired == NULL
         || pguidAdapter == NULL)
     {
         return ERROR_BAD_ARGUMENTS;
     }
 
-    if (szHwId == NULL)
-    {
-        szHwId = szzDefaultHardwareIDs;
-    }
-
     /* Create an empty device info set for network adapter device class. */
     HDEVINFO hDevInfoList = SetupDiCreateDeviceInfoList(&GUID_DEVCLASS_NET, hwndParent);
     if (hDevInfoList == INVALID_HANDLE_VALUE)
@@ -818,29 +837,23 @@ tap_create_adapter(
             }
         }
 
-        /* Check the driver version first, since the check is trivial and will save us iterating over hardware IDs for any driver versioned prior our best match. */
-        if (dwlDriverVersion < drvinfo_data.DriverVersion)
+        /* Check the driver version and hardware ID. */
+        if (dwlDriverVersion < drvinfo_data.DriverVersion
+            && drvinfo_detail_data->HardwareID
+            && _tcszistr(drvinfo_detail_data->HardwareID, szHwId))
         {
-            /* Search the list of hardware IDs. */
-            for (LPTSTR szHwdID = drvinfo_detail_data->HardwareID; szHwdID && szHwdID[0]; szHwdID += _tcslen(szHwdID) + 1)
+            /* Newer version and matching hardware ID found. Select the driver. */
+            if (!SetupDiSetSelectedDriver(
+                    hDevInfoList,
+                    &devinfo_data,
+                    &drvinfo_data))
             {
-                if (_tcsicmp(szHwdID, szHwId) == 0)
-                {
-                    /* Matching hardware ID found. Select the driver. */
-                    if (!SetupDiSetSelectedDriver(
-                            hDevInfoList,
-                            &devinfo_data,
-                            &drvinfo_data))
-                    {
-                        /* Something is wrong with this driver. Skip it. */
-                        msg(M_WARN | M_ERRNO, "%s: SetupDiSetSelectedDriver(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
-                        break;
-                    }
-
-                    dwlDriverVersion = drvinfo_data.DriverVersion;
-                    break;
-                }
+                /* Something is wrong with this driver. Skip it. */
+                msg(M_WARN | M_ERRNO, "%s: SetupDiSetSelectedDriver(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
+                continue;
             }
+
+            dwlDriverVersion = drvinfo_data.DriverVersion;
         }
     }
     if (drvinfo_detail_data)
@@ -1167,8 +1180,7 @@ DWORD
 tap_list_adapters(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szHwId,
-    _Out_ struct tap_adapter_node **ppAdapter,
-    _In_ BOOL bAll)
+    _Out_ struct tap_adapter_node **ppAdapter)
 {
     DWORD dwResult;
 
@@ -1177,11 +1189,6 @@ tap_list_adapters(
         return ERROR_BAD_ARGUMENTS;
     }
 
-    if (szHwId == NULL)
-    {
-        szHwId = szzDefaultHardwareIDs;
-    }
-
     /* Create a list of network devices. */
     HDEVINFO hDevInfoList = SetupDiGetClassDevsEx(
         &GUID_DEVCLASS_NET,
@@ -1253,7 +1260,7 @@ tap_list_adapters(
         /* Check that hardware ID is REG_SZ/REG_MULTI_SZ, and optionally if it matches ours. */
         if (dwDataType == REG_SZ)
         {
-            if (!bAll && _tcsicmp(szzDeviceHardwareIDs, szHwId) != 0)
+            if (szHwId && _tcsicmp(szzDeviceHardwareIDs, szHwId) != 0)
             {
                 /* This is not our device. Skip it. */
                 goto cleanup_szzDeviceHardwareIDs;
@@ -1261,21 +1268,10 @@ tap_list_adapters(
         }
         else if (dwDataType == REG_MULTI_SZ)
         {
-            if (!bAll)
+            if (szHwId && _tcszistr(szzDeviceHardwareIDs, szHwId) == NULL)
             {
-                for (LPTSTR szHwdID = szzDeviceHardwareIDs;; szHwdID += _tcslen(szHwdID) + 1)
-                {
-                    if (szHwdID[0] == 0)
-                    {
-                        /* This is not our device. Skip it. */
-                        goto cleanup_szzDeviceHardwareIDs;
-                    }
-                    else if (_tcsicmp(szHwdID, szHwId) == 0)
-                    {
-                        /* This is our device. */
-                        break;
-                    }
-                }
+                /* This is not our device. Skip it. */
+                goto cleanup_szzDeviceHardwareIDs;
             }
         }
         else
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index aec44ec8..68662c82 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -38,8 +38,7 @@
  *                      description of the device. This pointer is optional and can be NULL.
  *
  * @param szHwId        A pointer to a NULL-terminated string that supplies the hardware id
- *                      of the device. This pointer is optional and can be NULL. Default value
- *                      is root\tap0901.
+ *                      of the device (e.g. "root\\tap0901", "Wintun").
  *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
@@ -54,7 +53,7 @@ DWORD
 tap_create_adapter(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
-    _In_opt_ LPCTSTR szHwId,
+    _In_ LPCTSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
     _Out_ LPGUID pguidAdapter);
 
@@ -141,7 +140,7 @@ struct tap_adapter_node
 
 
 /**
- * Creates a list of available network adapters.
+ * Creates a list of existing network adapters.
  *
  * @param hwndParent    A handle to the top-level window to use for any user adapter that is
  *                      related to non-device-specific actions (such as a select-device dialog
@@ -150,24 +149,20 @@ struct tap_adapter_node
  *                      hwndParent to NULL.
  *
  * @param szHwId        A pointer to a NULL-terminated string that supplies the hardware id
- *                      of the device. This pointer is optional and can be NULL. Default value
- *                      is root\tap0901.
+ *                      of the device. This pointer is optional and can be NULL. When NULL,
+ *                      all network adapters found are added to the list.
  *
  * @param ppAdapterList  A pointer to the list to receive pointer to the first adapter in
  *                      the list. After the list is no longer required, free it using
  *                      tap_free_adapter_list().
  *
- * @param bAll          When TRUE, all network adapters found are added to the list. When
- *                      FALSE, only TUN/TAP adapters found are added.
- *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
 DWORD
 tap_list_adapters(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szHwId,
-    _Out_ struct tap_adapter_node **ppAdapterList,
-    _In_ BOOL bAll);
+    _Out_ struct tap_adapter_node **ppAdapterList);
 
 
 /**
-- 
2.24.1.windows.2


