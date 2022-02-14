From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 14 Feb 2022 14:24:09 +0200
Message-Id: <20220214122409.260-1-lstipakov@...277...>
In-Reply-To: <20220127090917.633-1-lstipakov@...277...>
References: <20220127090917.633-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v3] openvpnmsica: add ovpn-dco custom actions
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
Cc: Lev Stipakov <lev@...515...>, Simon Rozman <simon@...2293...>

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
Signed-off-by: Simon Rozman <simon@...2293...>
---

 v3:
  - Remove GetComponentNameById() and use hardcoded component name
    instead
  - Use WCHAR consistently
  - add msg() calls on failure paths
  - fix a few memory leaks
  - minor cleanups

 
 v2:
  - fix string conversion warning

 src/openvpnmsica/Makefile.am    |   2 +-
 src/openvpnmsica/openvpnmsica.c | 315 ++++++++++++++++++++++++++++++--
 src/openvpnmsica/openvpnmsica.h |  30 +++
 3 files changed, 334 insertions(+), 13 deletions(-)

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index a1a04afe..95482940 100644
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
index 6560751a..843b5762 100644
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
+#define CMP_OVPN_DCO_INF        L"CMP_ovpn_dco.inf"
+#define ACTION_ADD_DRIVER       L"AddDriver"
+#define ACTION_DELETE_DRIVER    L"DeleteDriver"
+#define ACTION_NOOP             L"Noop"
+#define FILE_OVPN_DCO_INF       L"ovpn-dco.inf"
+#define OVPN_DCO_HWID           L"ovpn-dco"
 
 /**
  * Joins an argument sequence and sets it to the MSI property.
@@ -424,6 +434,11 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
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
@@ -1042,15 +1057,15 @@ parse_guid(
 static void
 CreateRebootFile(_In_z_ LPCWSTR szTmpDir)
 {
-    TCHAR path[MAX_PATH];
+    WCHAR path[MAX_PATH];
     swprintf_s(path, _countof(path), L"%s%s", szTmpDir, FILE_NEED_REBOOT);
 
-    msg(M_WARN, "%s: Reboot required, create reboot indication file \"%" PRIsLPTSTR "\"", __FUNCTION__, path);
+    msg(M_WARN, "%s: Reboot required, create reboot indication file \"%ls\"", __FUNCTION__, path);
 
-    HANDLE file = CreateFile(path, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
+    HANDLE file = CreateFileW(path, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
     if (file == INVALID_HANDLE_VALUE)
     {
-        msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, path);
+        msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%ls\") failed", __FUNCTION__, path);
     }
     else
     {
@@ -1140,7 +1155,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
             if (dwResult == ERROR_SUCCESS)
             {
                 /* Set adapter name. May fail on some machines, but that is not critical - use silent
-                   flag to mute messagebox and print error only to log */
+                 * flag to mute messagebox and print error only to log */
                 tap_set_adapter_name(&guidAdapter, szName, TRUE);
             }
         }
@@ -1267,30 +1282,306 @@ CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 
     debug_popup(__FUNCTION__);
 
-    UINT ret = ERROR_SUCCESS;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     /* get user-specific temp path, to where we create reboot indication file */
-    TCHAR tempPath[MAX_PATH];
-    GetTempPath(MAX_PATH, tempPath);
+    WCHAR tempPath[MAX_PATH];
+    GetTempPathW(MAX_PATH, tempPath);
 
     /* check if reboot file exists */
-    TCHAR path[MAX_PATH];
-    _stprintf_s(path, _countof(path), L"%s%s", tempPath, FILE_NEED_REBOOT);
+    WCHAR path[MAX_PATH];
+    swprintf_s(path, _countof(path), L"%s%s", tempPath, FILE_NEED_REBOOT);
     WIN32_FIND_DATA data = { 0 };
-    HANDLE searchHandle = FindFirstFile(path, &data);
+    HANDLE searchHandle = FindFirstFileW(path, &data);
     if (searchHandle != INVALID_HANDLE_VALUE)
     {
         msg(M_WARN, "%s: Reboot file exists, schedule reboot", __FUNCTION__);
 
         FindClose(searchHandle);
-        DeleteFile(path);
+        DeleteFileW(path);
 
         MsiSetMode(hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
     }
 
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
+    return ERROR_SUCCESS;
+}
+
+static BOOL
+IsInstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
+{
+    return INSTALLSTATE_LOCAL == ActionState || INSTALLSTATE_SOURCE == ActionState
+           || (INSTALLSTATE_DEFAULT == ActionState
+               && (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState));
+}
+
+static BOOL
+IsReInstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
+{
+    return (INSTALLSTATE_LOCAL == ActionState || INSTALLSTATE_SOURCE == ActionState
+            || INSTALLSTATE_DEFAULT == ActionState)
+           && (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState);
+}
+
+static BOOL
+IsUninstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
+{
+    return (INSTALLSTATE_ABSENT == ActionState || INSTALLSTATE_REMOVED == ActionState)
+           && (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState);
+}
+
+UINT __stdcall
+EvaluateDriver(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    debug_popup(__FUNCTION__);
+
+    UINT ret;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
+
+    INSTALLSTATE InstallState, ActionState;
+    ret = MsiGetComponentStateW(hInstall, CMP_OVPN_DCO_INF, &InstallState, &ActionState);
+    if (ret != ERROR_SUCCESS)
+    {
+        SetLastError(ret);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%ls\") failed", __FUNCTION__, CMP_OVPN_DCO_INF);
+        goto cleanup;
+    }
+
+    /* get user-specific temp path, to where we create reboot indication file */
+    WCHAR tempPath[MAX_PATH];
+    GetTempPathW(MAX_PATH, tempPath);
+
+    WCHAR pathToInf[MAX_PATH];
+    DWORD pathLen = _countof(pathToInf);
+    ret = MsiGetPropertyW(hInstall, L"OVPNDCO", pathToInf, &pathLen);
+    if (ret != ERROR_SUCCESS)
+    {
+        SetLastError(ret);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiGetProperty failed", __FUNCTION__);
+        goto cleanup;
+    }
+
+    WCHAR action[0x400];
+    if ((IsReInstalling(InstallState, ActionState) || IsInstalling(InstallState, ActionState)))
+    {
+        swprintf_s(action, _countof(action), L"%s|%s%s|%s", ACTION_ADD_DRIVER, pathToInf, FILE_OVPN_DCO_INF, tempPath);
+    }
+    else if (IsUninstalling(InstallState, ActionState))
+    {
+        swprintf_s(action, _countof(action), L"%s|%s%s|%s", ACTION_DELETE_DRIVER, pathToInf, FILE_OVPN_DCO_INF, tempPath);
+    }
+    else
+    {
+        swprintf_s(action, _countof(action), L"%s||", ACTION_NOOP);
+    }
+
+    ret = MsiSetPropertyW(hInstall, L"OvpnDcoProcess", action);
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
+    HDEVINFO devInfoSet = SetupDiGetClassDevsW(&GUID_DEVCLASS_NET, NULL, NULL, 0);
+    if (!devInfoSet)
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetClassDevsW failed", __FUNCTION__);
+        return FALSE;
+    }
+    BOOL res = FALSE;
+    if (!SetupDiBuildDriverInfoList(devInfoSet, NULL, SPDIT_CLASSDRIVER))
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiBuildDriverInfoList failed", __FUNCTION__);
+        goto cleanupDeviceInfoSet;
+    }
+    for (DWORD idx = 0;; ++idx)
+    {
+        SP_DRVINFO_DATA_W drvInfo = { .cbSize = sizeof(drvInfo) };
+        if (!SetupDiEnumDriverInfoW(devInfoSet, NULL, SPDIT_CLASSDRIVER, idx, &drvInfo))
+        {
+            if (GetLastError() == ERROR_NO_MORE_ITEMS)
+            {
+                break;
+            }
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiEnumDriverInfoW failed", __FUNCTION__);
+            goto cleanupDriverInfoList;
+        }
+        DWORD size;
+        if (SetupDiGetDriverInfoDetailW(devInfoSet, NULL, &drvInfo, NULL, 0, &size) || GetLastError() != ERROR_INSUFFICIENT_BUFFER)
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDriverInfoDetailW failed", __FUNCTION__);
+            goto cleanupDriverInfoList;
+        }
+        PSP_DRVINFO_DETAIL_DATA_W drvDetails = calloc(1, size);
+        if (!drvDetails)
+        {
+            msg(M_NONFATAL, "%s: calloc(1, %u) failed", __FUNCTION__, size);
+            goto cleanupDriverInfoList;
+        }
+        drvDetails->cbSize = sizeof(*drvDetails);
+        if (!SetupDiGetDriverInfoDetailW(devInfoSet, NULL, &drvInfo, drvDetails, size, &size))
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDriverInfoDetailW failed", __FUNCTION__);
+            free(drvDetails);
+            goto cleanupDriverInfoList;
+        }
+        if (wcscmp(hwid, drvDetails->HardwareID) == 0)
+        {
+            PathStripPathW(drvDetails->InfFileName);
+            wcscpy_s(publishedName, len, drvDetails->InfFileName);
+            free(drvDetails);
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
+    struct tap_adapter_node *pAdapterList = NULL;
+    DWORD ret = tap_list_adapters(NULL, OVPN_DCO_HWID, &pAdapterList);
+    if (ret != ERROR_SUCCESS)
+    {
+        msg(M_NONFATAL, "%s", "Failed to get adapter list: %d", __FUNCTION__, ret);
+    }
+
+    /* delete all adapters */
+    BOOL rebootRequired = FALSE;
+    for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
+    {
+        tap_delete_adapter(NULL, &pAdapter->guid, &rebootRequired);
+    }
+
+    /* delete driver */
+    WCHAR publishedName[MAX_PATH] = { 0 };
+    if (GetPublishedDriverName(OVPN_DCO_HWID, publishedName, _countof(publishedName)))
+    {
+        if (!SetupUninstallOEMInfW(publishedName, 0, NULL))
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupUninstallOEMInfW(\"%ls\") failed", __FUNCTION__, publishedName);
+        }
+    }
+
+    if (rebootRequired)
+    {
+        CreateRebootFile(pathToTmp);
+    }
+}
+
+static void
+AddDriver(_In_z_ LPCWSTR pathToInf, _In_z_ LPCWSTR pathToTmp)
+{
+    /* copy driver to driver store */
+    if (!SetupCopyOEMInfW(pathToInf, NULL, SPOST_PATH, 0, NULL, 0, NULL, NULL))
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupCopyOEMInf(\"%ls\") failed", __FUNCTION__, pathToInf);
+        return;
+    }
+
+    /* update driver for existing devices (if any) */
+    BOOL rebootRequired = FALSE;
+    if (!UpdateDriverForPlugAndPlayDevicesW(NULL, OVPN_DCO_HWID, pathToInf, INSTALLFLAG_NONINTERACTIVE | INSTALLFLAG_FORCE, &rebootRequired))
+    {
+        /* ERROR_NO_SUCH_DEVINST means that no devices exist, which is normal case - device (adapter) is created at later stage */
+        if (GetLastError() != ERROR_NO_SUCH_DEVINST)
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: UpdateDriverForPlugAndPlayDevices(\"%ls\", \"%ls\") failed", __FUNCTION__, OVPN_DCO_HWID, pathToInf);
+            return;
+        }
+    }
+    if (rebootRequired)
+    {
+        CreateRebootFile(pathToTmp);
+    }
+}
+
+UINT __stdcall
+ProcessDriver(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    debug_popup(__FUNCTION__);
+
+    UINT ret = 0;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
+
+    LPWSTR customData = NULL;
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
+    WCHAR *pos = NULL;
+    WCHAR *token = wcstok_s(customData, L"|", &pos);
+    /* action|path_to_inf_file|path_to_tmp_dir */
+    while (token)
+    {
+        switch (i++)
+        {
+            case 0:
+                wcscpy_s(action, _countof(action), token);
+                break;
+
+            case 1:
+                wcscpy_s(pathToInf, _countof(pathToInf), token);
+                break;
+
+            case 2:
+                wcscpy_s(pathToTmp, _countof(pathToTmp), token);
+                break;
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
+    free(customData);
     if (bIsCoInitialized)
     {
         CoUninitialize();
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 8c53de45..a2d2d3f4 100644
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


