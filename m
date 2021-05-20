From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 20 May 2021 12:37:00 +0300
Message-Id: <20210520093700.133-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] openvpnmsica: add ovpn-dco custom actions
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Add two custom actions to service ovpn-dco driver installation.

 - EvaluateDriver

Runs under user privileges. Determines what action (install/uninstall)
should be performed on ovpn-dco component.

 - ProcessDriver

Runs under SYSTEM privileges. Performs driver (un)installation.
During uninstall, all existing adapters with given hwid (ovpn-dco)
are removed.

The logic is inspired by custom actions from tap-windows6 installer
(https://github.com/OpenVPN/tap-windows6/tree/master/msm).

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/Makefile.am    |   2 +-
 src/openvpnmsica/openvpnmsica.c | 348 ++++++++++++++++++++++++++++++++
 src/openvpnmsica/openvpnmsica.h |  30 +++
 3 files changed, 379 insertions(+), 1 deletion(-)

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 9d18854a..a5d9c170 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -42,7 +42,7 @@ libopenvpnmsica_la_CFLAGS = \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA \
 	-Wl,--kill-at
-libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -no-undefined -avoid-version
+libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -lnewdev -no-undefined -avoid-version
 endif
 
 libopenvpnmsica_la_SOURCES = \
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 96652117..5e58b08e 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -43,6 +43,10 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <tchar.h>
+#include <setupapi.h>
+#include <newdev.h>
+#include <initguid.h>
+#include <devguid.h>
 
 #ifdef _MSC_VER
 #pragma comment(lib, "advapi32.lib")
@@ -60,6 +64,12 @@
 #define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
 
 #define FILE_NEED_REBOOT        L".ovpn_need_reboot"
+#define CMP_OVPN_DCO_INF_GUID   L"{4BE20469-2292-4AE2-B953-49AA0DA4165E}"
+#define ACTION_ADD_DRIVER       L"AddDriver"
+#define ACTION_DELETE_DRIVER    L"DeleteDriver"
+#define ACTION_NOOP             L"Noop"
+#define FILE_OVPN_DCO_INF       L"ovpn-dco.inf"
+#define OVPN_DCO_HWID           L"ovpn-dco"
 
 /**
  * Joins an argument sequence and sets it to the MSI property.
@@ -422,6 +432,11 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
         TEXT("Wintun") TEXT("\0"),
         TEXT("WINTUNADAPTERS"),
         TEXT("ACTIVEWINTUNADAPTERS"));
+    find_adapters(
+        hInstall,
+        TEXT("ovpn-dco") TEXT("\0"),
+        TEXT("OVPNDCOAPTERS"),
+        TEXT("ACTIVEOVPNDCOADAPTERS"));
 
     if (bIsCoInitialized)
     {
@@ -1295,3 +1310,336 @@ CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
     }
     return ret;
 }
+
+static BOOL
+IsInstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
+{
+    return INSTALLSTATE_LOCAL == ActionState || INSTALLSTATE_SOURCE == ActionState ||
+        (INSTALLSTATE_DEFAULT == ActionState &&
+            (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState));
+}
+
+static BOOL
+IsReInstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
+{
+    return (INSTALLSTATE_LOCAL == ActionState || INSTALLSTATE_SOURCE == ActionState ||
+        INSTALLSTATE_DEFAULT == ActionState) &&
+        (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState);
+}
+
+static BOOL
+IsUninstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
+{
+    return (INSTALLSTATE_ABSENT == ActionState || INSTALLSTATE_REMOVED == ActionState) &&
+        (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState);
+}
+
+static UINT
+GetComponentNameById(_In_ MSIHANDLE hInstall, _In_ LPCTSTR componentId, _Out_ LPTSTR name, DWORD len)
+{
+    UINT ret = 0;
+    MSIHANDLE record = 0;
+    MSIHANDLE view = 0;
+
+    name[len - 1] = '\0';
+
+    /* Open MSI database. */
+    MSIHANDLE db = MsiGetActiveDatabase(hInstall);
+    if (db == 0)
+    {
+        msg(M_NONFATAL, "%s: MsiGetActiveDatabase failed", __FUNCTION__);
+        ret = ERROR_INVALID_HANDLE;
+        goto cleanup;
+    }
+
+    TCHAR cmd[0x400];
+    _stprintf_s(cmd, _countof(cmd), L"SELECT `Component` FROM `Component` WHERE `ComponentId` = '%s'", componentId);
+
+    ret = MsiDatabaseOpenView(db, cmd, &view);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    ret = MsiViewExecute(view, 0);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    ret = MsiViewFetch(view, &record);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    ret = MsiRecordGetString(record, 1, name, &len);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+cleanup:
+    MsiCloseHandle(view);
+    MsiCloseHandle(record);
+    MsiCloseHandle(db);
+
+    return ret;
+}
+
+UINT __stdcall
+EvaluateDriver(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    debug_popup(TEXT(__FUNCTION__));
+
+    UINT ret;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
+
+    WCHAR componentName[0x400];
+    ret = GetComponentNameById(hInstall, CMP_OVPN_DCO_INF_GUID, componentName, _countof(componentName));
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    INSTALLSTATE InstallState, ActionState;
+    ret = MsiGetComponentState(hInstall, componentName, &InstallState, &ActionState);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    /* get user-specific temp path, to where we create reboot indication file */
+    WCHAR tempPath[MAX_PATH];
+    GetTempPath(MAX_PATH, tempPath);
+
+    WCHAR pathToInf[MAX_PATH];
+    DWORD pathLen = _countof(pathToInf);
+    ret = MsiGetProperty(hInstall, L"OVPNDCO", pathToInf, &pathLen);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    TCHAR action[0x400];
+    if ((IsReInstalling(InstallState, ActionState) || IsInstalling(InstallState, ActionState)))
+    {
+        _stprintf_s(action, _countof(action), L"%s|%s%s|%s", ACTION_ADD_DRIVER, pathToInf, FILE_OVPN_DCO_INF, tempPath);
+    }
+    else if (IsUninstalling(InstallState, ActionState))
+    {
+        _stprintf_s(action, _countof(action), L"%s|%s%s|%s", ACTION_DELETE_DRIVER, pathToInf, FILE_OVPN_DCO_INF, tempPath);
+    }
+    else
+    {
+        _stprintf_s(action, _countof(action), L"%s||", ACTION_NOOP);
+    }
+
+    ret = MsiSetProperty(hInstall, L"OvpnDcoProcess", action);
+
+cleanup:
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
+    return ret;
+}
+
+static BOOL
+GetPublishedDriverName(_In_z_ LPCWSTR hwid, _Out_writes_z_(len) LPWSTR publishedName, _In_ DWORD len)
+{
+    wcscpy_s(publishedName, len, L"");
+
+    HDEVINFO devInfoSet = SetupDiGetClassDevs(&GUID_DEVCLASS_NET, NULL, NULL, 0);
+    if (!devInfoSet)
+    {
+        return FALSE;
+    }
+    BOOL res = FALSE;
+    if (!SetupDiBuildDriverInfoList(devInfoSet, NULL, SPDIT_CLASSDRIVER))
+    {
+        goto cleanupDeviceInfoSet;
+    }
+    for (DWORD idx = 0;; ++idx)
+    {
+        SP_DRVINFO_DATA drvInfo = { .cbSize = sizeof(drvInfo) };
+        if (!SetupDiEnumDriverInfo(devInfoSet, NULL, SPDIT_CLASSDRIVER, idx, &drvInfo))
+        {
+            if (GetLastError() == ERROR_NO_MORE_ITEMS)
+            {
+                break;
+            }
+            goto cleanupDriverInfoList;
+        }
+        DWORD size;
+        if (SetupDiGetDriverInfoDetail(devInfoSet, NULL, &drvInfo, NULL, 0, &size) || GetLastError() != ERROR_INSUFFICIENT_BUFFER)
+        {
+            goto cleanupDriverInfoList;
+        }
+        PSP_DRVINFO_DETAIL_DATA drvDetails = calloc(1, size);
+        if (!drvDetails)
+        {
+            goto cleanupDriverInfoList;
+        }
+        drvDetails->cbSize = sizeof(*drvDetails);
+        if (!SetupDiGetDriverInfoDetail(devInfoSet, NULL, &drvInfo, drvDetails, size, &size))
+        {
+            free(drvDetails);
+            goto cleanupDriverInfoList;
+        }
+        if (_tcscmp(hwid, drvDetails->HardwareID) == 0)
+        {
+            PathStripPath(drvDetails->InfFileName);
+            _tcscpy_s(publishedName, len, drvDetails->InfFileName);
+            res = TRUE;
+            break;
+        }
+        free(drvDetails);
+    }
+
+cleanupDriverInfoList:
+    SetupDiDestroyDriverInfoList(devInfoSet, NULL, SPDIT_CLASSDRIVER);
+cleanupDeviceInfoSet:
+    SetupDiDestroyDeviceInfoList(devInfoSet);
+    return res;
+}
+
+static void
+DeleteDriver(_In_z_ LPCWSTR pathToTmp)
+{
+    /* get list of adapters for hwid */
+    struct tap_adapter_node* pAdapterList = NULL;
+    DWORD ret = tap_list_adapters(NULL, OVPN_DCO_HWID, &pAdapterList);
+    if (ret != ERROR_SUCCESS)
+    {
+        msg(M_NONFATAL, "%s", "Failed to get adapter list: %d", __FUNCTION__, ret);
+    }
+
+    /* delete all adapters */
+    BOOL rebootRequired = FALSE;
+    for (struct tap_adapter_node* pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
+    {
+        BOOL rebootForOneAdapter = FALSE;
+        tap_delete_adapter(NULL, &pAdapter->guid, &rebootForOneAdapter);
+        rebootRequired |= rebootForOneAdapter;
+    }
+
+    /* delete driver */
+    WCHAR publishedName[MAX_PATH] = { 0 };
+    if (GetPublishedDriverName(OVPN_DCO_HWID, publishedName, _countof(publishedName)))
+    {
+        if (!SetupUninstallOEMInf(publishedName, 0, NULL))
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupUninstallOEMInf(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, publishedName);
+        }
+    }
+    else
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: GetPublishedDriverName(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, OVPN_DCO_HWID);
+    }
+
+    if (rebootRequired)
+    {
+        CreateRebootFile(pathToTmp);
+    }
+
+    ret = ERROR_SUCCESS;
+}
+
+static UINT
+AddDriver(_In_z_ LPCWSTR pathToInf, _In_z_ LPCWSTR pathToTmp)
+{
+    /* copy driver to driver store */
+    if (!SetupCopyOEMInf(pathToInf, NULL, SPOST_PATH, 0, NULL, 0, NULL, NULL))
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupCopyOEMInf(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, pathToInf);
+        return GetLastError();
+    }
+
+    /* update driver for existing devices (if any) */
+    BOOL rebootRequired = FALSE;
+    if (!UpdateDriverForPlugAndPlayDevices(NULL, OVPN_DCO_HWID, pathToInf, INSTALLFLAG_NONINTERACTIVE | INSTALLFLAG_FORCE, &rebootRequired))
+    {
+        /* ERROR_NO_SUCH_DEVINST means that no devices exist, which is normal case - device (adapter) is created at later stage */
+        if (GetLastError() != ERROR_NO_SUCH_DEVINST)
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: UpdateDriverForPlugAndPlayDevices(\"%" PRIsLPTSTR "\", \"%" PRIsLPTSTR "\") failed", __FUNCTION__, OVPN_DCO_HWID, pathToInf);
+            return GetLastError();
+        }
+    }
+    if (rebootRequired)
+    {
+        CreateRebootFile(pathToTmp);
+    }
+
+    return ERROR_SUCCESS;
+}
+
+UINT __stdcall
+ProcessDriver(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    debug_popup(TEXT(__FUNCTION__));
+
+    UINT ret = 0;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
+
+    LPTSTR customData = NULL;
+    ret = msi_get_string(hInstall, L"CustomActionData", &customData);
+    if (ret != ERROR_SUCCESS)
+    {
+        goto cleanup;
+    }
+
+    int i = 0;
+    WCHAR action[0x400] = { 0 };
+    WCHAR pathToInf[MAX_PATH] = { 0 };
+    WCHAR pathToTmp[MAX_PATH] = { 0 };
+
+    WCHAR* pos = NULL;
+    WCHAR* token = wcstok_s(customData, L"|", &pos);
+    /* action|path_to_inf_file|path_to_tmp_dir */
+    while (token)
+    {
+        switch (i++)
+        {
+        case 0:
+            wcscpy_s(action, _countof(action), token);
+            break;
+        case 1:
+            wcscpy_s(pathToInf, _countof(pathToInf), token);
+            break;
+        case 2:
+            wcscpy_s(pathToTmp, _countof(pathToTmp), token);
+            break;
+        }
+        token = wcstok_s(NULL, L"|", &pos);
+    }
+
+    if (wcscmp(action, ACTION_ADD_DRIVER) == 0)
+    {
+        AddDriver(pathToInf, pathToTmp);
+    }
+    else if (wcscmp(action, ACTION_DELETE_DRIVER) == 0)
+    {
+        DeleteDriver(pathToTmp);
+    }
+
+cleanup:
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
+    return ret;
+}
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 5af68470..f82af4a4 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -88,6 +88,10 @@ extern "C" {
  *   with semicolon delimited list of all installed adapter GUIDs and active adapter GUIDs
  *   respectively.
  *
+ * - Finds existing ovpn-dco adapters and set OVPNDCOADAPTERS and ACTIVEOVPNDCOADAPTERS properties
+ *   with semicolon delimited list of all installed adapter GUIDs and active adapter GUIDs
+ *   respectively.
+ *
  * @param hInstall      Handle to the installation provided to the DLL custom action
  *
  * @return ERROR_SUCCESS on success; An error code otherwise
@@ -147,6 +151,32 @@ DLLEXP_DECL UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall);
 
 
+/**
+ * Check what operation shall be performed on ovpn-dco driver
+ * and set data value (path to inf and user temp dir) for ProcessDriver action.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+DLLEXP_DECL UINT __stdcall
+EvaluateDriver(_In_ MSIHANDLE hInstall);
+
+
+/**
+ * Install or uninstall ovpn-dco driver, removing all adapters using that driver.
+ * If reboot is required, creates reboot indication file in user's temp directory
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+DLLEXP_DECL UINT __stdcall
+ProcessDriver(_In_ MSIHANDLE hInstall);
+
+
 /**
  * Schedule reboot after installation if reboot
  * indication file is found in user's temp directory
-- 
2.23.0.windows.1


