From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:20 +0100
Message-Id: <20200309131728.380-4-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 04/12] tapctl: Add functions for
 enabling/disabling adapters
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
 src/tapctl/tap.c | 287 ++++++++++++++++++++++++++++++++++++++++-------
 src/tapctl/tap.h |  28 +++++
 2 files changed, 275 insertions(+), 40 deletions(-)

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index b8249919..576f6740 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -47,6 +47,28 @@ const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentContro
 #define INTERFACE_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
 
 
+/**
+ * Function that performs a specific task on a device
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device.
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+typedef DWORD (*devop_func_t)(
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _Inout_ LPBOOL pbRebootRequired);
+
+
 /**
  * Checks device install parameters if a system reboot is required.
  *
@@ -94,6 +116,186 @@ check_reboot(
 }
 
 
+/**
+ * Deletes the device.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device.
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+delete_device(
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _Inout_ LPBOOL pbRebootRequired)
+{
+    SP_REMOVEDEVICE_PARAMS params =
+    {
+        .ClassInstallHeader =
+        {
+            .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
+            .InstallFunction = DIF_REMOVE,
+        },
+        .Scope = DI_REMOVEDEVICE_GLOBAL,
+        .HwProfile = 0,
+    };
+
+    /* Set class installer parameters for DIF_REMOVE. */
+    if (!SetupDiSetClassInstallParams(
+            hDeviceInfoSet,
+            pDeviceInfoData,
+            &params.ClassInstallHeader,
+            sizeof(SP_REMOVEDEVICE_PARAMS)))
+    {
+        DWORD dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Call appropriate class installer. */
+    if (!SetupDiCallClassInstaller(
+            DIF_REMOVE,
+            hDeviceInfoSet,
+            pDeviceInfoData))
+    {
+        DWORD dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REMOVE) failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Check if a system reboot is required. */
+    check_reboot(hDeviceInfoSet, pDeviceInfoData, pbRebootRequired);
+    return ERROR_SUCCESS;
+}
+
+
+/**
+ * Changes the device state.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device.
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param bEnable       TRUE to enable the device; FALSE to disable.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+change_device_state(
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _In_ BOOL bEnable,
+    _Inout_ LPBOOL pbRebootRequired)
+{
+    SP_PROPCHANGE_PARAMS params =
+    {
+        .ClassInstallHeader =
+        {
+            .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
+            .InstallFunction = DIF_PROPERTYCHANGE,
+        },
+        .StateChange = bEnable ? DICS_ENABLE : DICS_DISABLE,
+        .Scope = DICS_FLAG_GLOBAL,
+        .HwProfile = 0,
+    };
+
+    /* Set class installer parameters for DIF_PROPERTYCHANGE. */
+    if (!SetupDiSetClassInstallParams(
+            hDeviceInfoSet,
+            pDeviceInfoData,
+            &params.ClassInstallHeader,
+            sizeof(SP_PROPCHANGE_PARAMS)))
+    {
+        DWORD dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Call appropriate class installer. */
+    if (!SetupDiCallClassInstaller(
+            DIF_PROPERTYCHANGE,
+            hDeviceInfoSet,
+            pDeviceInfoData))
+    {
+        DWORD dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_PROPERTYCHANGE) failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Check if a system reboot is required. */
+    check_reboot(hDeviceInfoSet, pDeviceInfoData, pbRebootRequired);
+    return ERROR_SUCCESS;
+}
+
+
+/**
+ * Enables the device.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device.
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+enable_device(
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _Inout_ LPBOOL pbRebootRequired)
+{
+    return change_device_state(hDeviceInfoSet, pDeviceInfoData, TRUE, pbRebootRequired);
+}
+
+
+/**
+ * Disables the device.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device.
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+disable_device(
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _Inout_ LPBOOL pbRebootRequired)
+{
+    return change_device_state(hDeviceInfoSet, pDeviceInfoData, FALSE, pbRebootRequired);
+}
+
+
 /**
  * Reads string value from registry key.
  *
@@ -754,10 +956,31 @@ cleanup_hDevInfoList:
 }
 
 
-DWORD
-tap_delete_interface(
+/**
+ * Performs a given task on an interface.
+ *
+ * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ *                      related to non-device-specific actions (such as a select-device dialog
+ *                      box that uses the global class driver list). This handle is optional
+ *                      and can be NULL. If a specific top-level window is not required, set
+ *                      hwndParent to NULL.
+ *
+ * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ *
+ * @param funcOperation  A pointer for the function to perform specific task on the interface.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+execute_on_first_interface(
     _In_opt_ HWND hwndParent,
     _In_ LPCGUID pguidInterface,
+    _In_ devop_func_t funcOperation,
     _Inout_ LPBOOL pbRebootRequired)
 {
     DWORD dwResult;
@@ -831,44 +1054,7 @@ tap_delete_interface(
         /* Compare GUIDs. */
         if (memcmp(pguidInterface, &guidInterface, sizeof(GUID)) == 0)
         {
-            /* Remove the device. */
-            SP_REMOVEDEVICE_PARAMS removedevice_params =
-            {
-                .ClassInstallHeader =
-                {
-                    .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
-                    .InstallFunction = DIF_REMOVE,
-                },
-                .Scope = DI_REMOVEDEVICE_GLOBAL,
-                .HwProfile = 0,
-            };
-
-            /* Set class installer parameters for DIF_REMOVE. */
-            if (!SetupDiSetClassInstallParams(
-                    hDevInfoList,
-                    &devinfo_data,
-                    &removedevice_params.ClassInstallHeader,
-                    sizeof(SP_REMOVEDEVICE_PARAMS)))
-            {
-                dwResult = GetLastError();
-                msg(M_NONFATAL, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
-                goto cleanup_hDevInfoList;
-            }
-
-            /* Call appropriate class installer. */
-            if (!SetupDiCallClassInstaller(
-                    DIF_REMOVE,
-                    hDevInfoList,
-                    &devinfo_data))
-            {
-                dwResult = GetLastError();
-                msg(M_NONFATAL, "%s: SetupDiCallClassInstaller(DIF_REMOVE) failed", __FUNCTION__);
-                goto cleanup_hDevInfoList;
-            }
-
-            /* Check if a system reboot is required. */
-            check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
-            dwResult = ERROR_SUCCESS;
+            dwResult = funcOperation(hDevInfoList, &devinfo_data, pbRebootRequired);
             break;
         }
     }
@@ -879,6 +1065,27 @@ cleanup_hDevInfoList:
 }
 
 
+DWORD
+tap_delete_interface(
+    _In_opt_ HWND hwndParent,
+    _In_ LPCGUID pguidInterface,
+    _Inout_ LPBOOL pbRebootRequired)
+{
+    return execute_on_first_interface(hwndParent, pguidInterface, delete_device, pbRebootRequired);
+}
+
+
+DWORD
+tap_enable_interface(
+    _In_opt_ HWND hwndParent,
+    _In_ LPCGUID pguidInterface,
+    _In_ BOOL bEnable,
+    _Inout_ LPBOOL pbRebootRequired)
+{
+    return execute_on_first_interface(hwndParent, pguidInterface, bEnable ? enable_device : disable_device, pbRebootRequired);
+}
+
+
 DWORD
 tap_set_interface_name(
     _In_ LPCGUID pguidInterface,
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index ca66e5da..4c2d73ba 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -84,6 +84,34 @@ tap_delete_interface(
     _Inout_ LPBOOL pbRebootRequired);
 
 
+/**
+ * Enables or disables an interface.
+ *
+ * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ *                      related to non-device-specific actions (such as a select-device dialog
+ *                      box that uses the global class driver list). This handle is optional
+ *                      and can be NULL. If a specific top-level window is not required, set
+ *                      hwndParent to NULL.
+ *
+ * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ *
+ * @param bEnable       TRUE to enable; FALSE to disable
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+DWORD
+tap_enable_interface(
+    _In_opt_ HWND hwndParent,
+    _In_ LPCGUID pguidInterface,
+    _In_ BOOL bEnable,
+    _Inout_ LPBOOL pbRebootRequired);
+
+
 /**
  * Sets interface name.
  *
-- 
2.24.1.windows.2


