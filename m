From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 19 Jan 2023 10:59:59 +0200
Message-Id: <20230119085959.157-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openvpnmsica: remove dco installer custom
 actions
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

Those have been moved into MSM to be reused by openvpn-gui and Connect.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.c | 283 --------------------------------
 1 file changed, 283 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 229eff00..af12b2c4 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -64,12 +64,6 @@
 #define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
 
 #define FILE_NEED_REBOOT        L".ovpn_need_reboot"
-#define CMP_OVPN_DCO_INF        L"CMP_ovpn_dco.inf"
-#define ACTION_ADD_DRIVER       L"AddDriver"
-#define ACTION_DELETE_DRIVER    L"DeleteDriver"
-#define ACTION_NOOP             L"Noop"
-#define FILE_OVPN_DCO_INF       L"ovpn-dco.inf"
-#define OVPN_DCO_HWID           L"ovpn-dco"
 
 /**
  * Joins an argument sequence and sets it to the MSI property.
@@ -1196,280 +1190,3 @@ CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
     }
     return ERROR_SUCCESS;
 }
-
-static BOOL
-IsInstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
-{
-    return INSTALLSTATE_LOCAL == ActionState || INSTALLSTATE_SOURCE == ActionState
-           || (INSTALLSTATE_DEFAULT == ActionState
-               && (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState));
-}
-
-static BOOL
-IsReInstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
-{
-    return (INSTALLSTATE_LOCAL == ActionState || INSTALLSTATE_SOURCE == ActionState
-            || INSTALLSTATE_DEFAULT == ActionState)
-           && (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState);
-}
-
-static BOOL
-IsUninstalling(_In_ INSTALLSTATE InstallState, _In_ INSTALLSTATE ActionState)
-{
-    return (INSTALLSTATE_ABSENT == ActionState || INSTALLSTATE_REMOVED == ActionState)
-           && (INSTALLSTATE_LOCAL == InstallState || INSTALLSTATE_SOURCE == InstallState);
-}
-
-UINT __stdcall
-EvaluateDriver(_In_ MSIHANDLE hInstall)
-{
-#ifdef _MSC_VER
-#pragma comment(linker, DLLEXP_EXPORT)
-#endif
-
-    debug_popup(__FUNCTION__);
-
-    UINT ret;
-    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-
-    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
-
-    INSTALLSTATE InstallState, ActionState;
-    ret = MsiGetComponentStateW(hInstall, CMP_OVPN_DCO_INF, &InstallState, &ActionState);
-    if (ret != ERROR_SUCCESS)
-    {
-        SetLastError(ret);
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%ls\") failed", __FUNCTION__, CMP_OVPN_DCO_INF);
-        goto cleanup;
-    }
-
-    /* get user-specific temp path, to where we create reboot indication file */
-    WCHAR tempPath[MAX_PATH];
-    GetTempPathW(MAX_PATH, tempPath);
-
-    WCHAR pathToInf[MAX_PATH];
-    DWORD pathLen = _countof(pathToInf);
-    ret = MsiGetPropertyW(hInstall, L"OVPNDCO", pathToInf, &pathLen);
-    if (ret != ERROR_SUCCESS)
-    {
-        SetLastError(ret);
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiGetProperty failed", __FUNCTION__);
-        goto cleanup;
-    }
-
-    WCHAR action[0x400];
-    if ((IsReInstalling(InstallState, ActionState) || IsInstalling(InstallState, ActionState)))
-    {
-        swprintf_s(action, _countof(action), L"%s|%s%s|%s", ACTION_ADD_DRIVER, pathToInf, FILE_OVPN_DCO_INF, tempPath);
-    }
-    else if (IsUninstalling(InstallState, ActionState))
-    {
-        swprintf_s(action, _countof(action), L"%s|%s%s|%s", ACTION_DELETE_DRIVER, pathToInf, FILE_OVPN_DCO_INF, tempPath);
-    }
-    else
-    {
-        swprintf_s(action, _countof(action), L"%s||", ACTION_NOOP);
-    }
-
-    ret = MsiSetPropertyW(hInstall, L"OvpnDcoProcess", action);
-
-cleanup:
-    if (bIsCoInitialized)
-    {
-        CoUninitialize();
-    }
-    return ret;
-}
-
-static BOOL
-GetPublishedDriverName(_In_z_ LPCWSTR hwid, _Out_writes_z_(len) LPWSTR publishedName, _In_ DWORD len)
-{
-    wcscpy_s(publishedName, len, L"");
-
-    HDEVINFO devInfoSet = SetupDiGetClassDevsW(&GUID_DEVCLASS_NET, NULL, NULL, 0);
-    if (!devInfoSet)
-    {
-        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetClassDevsW failed", __FUNCTION__);
-        return FALSE;
-    }
-    BOOL res = FALSE;
-    if (!SetupDiBuildDriverInfoList(devInfoSet, NULL, SPDIT_CLASSDRIVER))
-    {
-        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiBuildDriverInfoList failed", __FUNCTION__);
-        goto cleanupDeviceInfoSet;
-    }
-    for (DWORD idx = 0;; ++idx)
-    {
-        SP_DRVINFO_DATA_W drvInfo = { .cbSize = sizeof(drvInfo) };
-        if (!SetupDiEnumDriverInfoW(devInfoSet, NULL, SPDIT_CLASSDRIVER, idx, &drvInfo))
-        {
-            if (GetLastError() == ERROR_NO_MORE_ITEMS)
-            {
-                break;
-            }
-            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiEnumDriverInfoW failed", __FUNCTION__);
-            goto cleanupDriverInfoList;
-        }
-        DWORD size;
-        if (SetupDiGetDriverInfoDetailW(devInfoSet, NULL, &drvInfo, NULL, 0, &size) || GetLastError() != ERROR_INSUFFICIENT_BUFFER)
-        {
-            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDriverInfoDetailW failed", __FUNCTION__);
-            goto cleanupDriverInfoList;
-        }
-        PSP_DRVINFO_DETAIL_DATA_W drvDetails = calloc(1, size);
-        if (!drvDetails)
-        {
-            msg(M_NONFATAL, "%s: calloc(1, %u) failed", __FUNCTION__, size);
-            goto cleanupDriverInfoList;
-        }
-        drvDetails->cbSize = sizeof(*drvDetails);
-        if (!SetupDiGetDriverInfoDetailW(devInfoSet, NULL, &drvInfo, drvDetails, size, &size))
-        {
-            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDriverInfoDetailW failed", __FUNCTION__);
-            free(drvDetails);
-            goto cleanupDriverInfoList;
-        }
-        if (wcscmp(hwid, drvDetails->HardwareID) == 0)
-        {
-            PathStripPathW(drvDetails->InfFileName);
-            wcscpy_s(publishedName, len, drvDetails->InfFileName);
-            free(drvDetails);
-            res = TRUE;
-            break;
-        }
-        free(drvDetails);
-    }
-
-cleanupDriverInfoList:
-    SetupDiDestroyDriverInfoList(devInfoSet, NULL, SPDIT_CLASSDRIVER);
-cleanupDeviceInfoSet:
-    SetupDiDestroyDeviceInfoList(devInfoSet);
-    return res;
-}
-
-static void
-DeleteDriver(_In_z_ LPCWSTR pathToTmp)
-{
-    /* get list of adapters for hwid */
-    struct tap_adapter_node *pAdapterList = NULL;
-    DWORD ret = tap_list_adapters(NULL, OVPN_DCO_HWID, &pAdapterList);
-    if (ret != ERROR_SUCCESS)
-    {
-        msg(M_NONFATAL, "%s", "Failed to get adapter list: %d", __FUNCTION__, ret);
-    }
-
-    /* delete all adapters */
-    BOOL rebootRequired = FALSE;
-    for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
-    {
-        tap_delete_adapter(NULL, &pAdapter->guid, &rebootRequired);
-    }
-
-    /* delete driver */
-    WCHAR publishedName[MAX_PATH] = { 0 };
-    if (GetPublishedDriverName(OVPN_DCO_HWID, publishedName, _countof(publishedName)))
-    {
-        if (!SetupUninstallOEMInfW(publishedName, 0, NULL))
-        {
-            msg(M_NONFATAL | M_ERRNO, "%s: SetupUninstallOEMInfW(\"%ls\") failed", __FUNCTION__, publishedName);
-        }
-    }
-
-    if (rebootRequired)
-    {
-        CreateRebootFile(pathToTmp);
-    }
-}
-
-static void
-AddDriver(_In_z_ LPCWSTR pathToInf, _In_z_ LPCWSTR pathToTmp)
-{
-    /* copy driver to driver store */
-    if (!SetupCopyOEMInfW(pathToInf, NULL, SPOST_PATH, 0, NULL, 0, NULL, NULL))
-    {
-        msg(M_NONFATAL | M_ERRNO, "%s: SetupCopyOEMInf(\"%ls\") failed", __FUNCTION__, pathToInf);
-        return;
-    }
-
-    /* update driver for existing devices (if any) */
-    BOOL rebootRequired = FALSE;
-    if (!UpdateDriverForPlugAndPlayDevicesW(NULL, OVPN_DCO_HWID, pathToInf, INSTALLFLAG_NONINTERACTIVE | INSTALLFLAG_FORCE, &rebootRequired))
-    {
-        /* ERROR_NO_SUCH_DEVINST means that no devices exist, which is normal case - device (adapter) is created at later stage */
-        if (GetLastError() != ERROR_NO_SUCH_DEVINST)
-        {
-            msg(M_NONFATAL | M_ERRNO, "%s: UpdateDriverForPlugAndPlayDevices(\"%ls\", \"%ls\") failed", __FUNCTION__, OVPN_DCO_HWID, pathToInf);
-            return;
-        }
-    }
-    if (rebootRequired)
-    {
-        CreateRebootFile(pathToTmp);
-    }
-}
-
-UINT __stdcall
-ProcessDriver(_In_ MSIHANDLE hInstall)
-{
-#ifdef _MSC_VER
-#pragma comment(linker, DLLEXP_EXPORT)
-#endif
-
-    debug_popup(__FUNCTION__);
-
-    UINT ret = 0;
-    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-
-    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
-
-    LPWSTR customData = NULL;
-    ret = msi_get_string(hInstall, L"CustomActionData", &customData);
-    if (ret != ERROR_SUCCESS)
-    {
-        goto cleanup;
-    }
-
-    int i = 0;
-    WCHAR action[0x400] = { 0 };
-    WCHAR pathToInf[MAX_PATH] = { 0 };
-    WCHAR pathToTmp[MAX_PATH] = { 0 };
-
-    WCHAR *pos = NULL;
-    WCHAR *token = wcstok_s(customData, L"|", &pos);
-    /* action|path_to_inf_file|path_to_tmp_dir */
-    while (token)
-    {
-        switch (i++)
-        {
-            case 0:
-                wcscpy_s(action, _countof(action), token);
-                break;
-
-            case 1:
-                wcscpy_s(pathToInf, _countof(pathToInf), token);
-                break;
-
-            case 2:
-                wcscpy_s(pathToTmp, _countof(pathToTmp), token);
-                break;
-        }
-        token = wcstok_s(NULL, L"|", &pos);
-    }
-
-    if (wcscmp(action, ACTION_ADD_DRIVER) == 0)
-    {
-        AddDriver(pathToInf, pathToTmp);
-    }
-    else if (wcscmp(action, ACTION_DELETE_DRIVER) == 0)
-    {
-        DeleteDriver(pathToTmp);
-    }
-
-cleanup:
-    free(customData);
-    if (bIsCoInitialized)
-    {
-        CoUninitialize();
-    }
-    return ret;
-}
-- 
2.38.1.windows.1


