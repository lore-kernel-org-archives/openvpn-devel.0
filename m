From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 28 Jul 2022 14:17:12 +0300
Message-Id: <20220728111712.94-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] openvpnmsica: remove OpenVPNService state
 check code
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

This code reads the state of OpenVPNService,
such as startup mode and running, and sets MSI
property value. If that property is set, installer
selects OpenVPNService as a feature to be installed.

This has been superseded by change in installer:

  https://github.com/OpenVPN/openvpn-build/pull/261

which, in addition to checking the state of OpenVPNService,
applies that state to the newly installed service.

  - by default, OpenVPNService feature is now checked
and service is installed

  - in clean installation, service startup mode is set to "manual"
and service is not started

  - in upgrade, installer preserves the service state, such
as startup mode and started/stopped

With all those changes to installer, we don't need this code
in openvpnmsica.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.c | 115 --------------------------------
 1 file changed, 115 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 843b5762..538cdbaa 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -147,120 +147,6 @@ _debug_popup(_In_z_ LPCSTR szFunctionName)
 #define debug_popup(f)
 #endif /* ifdef _DEBUG */
 
-
-/**
- * Detects if the OpenVPNService service is in use (running or paused) and sets
- * OPENVPNSERVICE to the service process PID, or its path if it is set to
- * auto-start, but not running.
- *
- * @param hInstall      Handle to the installation provided to the DLL custom action
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
- */
-static UINT
-set_openvpnserv_state(_In_ MSIHANDLE hInstall)
-{
-    UINT uiResult;
-
-    /* Get Service Control Manager handle. */
-    SC_HANDLE hSCManager = OpenSCManager(NULL, SERVICES_ACTIVE_DATABASE, SC_MANAGER_CONNECT);
-    if (hSCManager == NULL)
-    {
-        uiResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: OpenSCManager() failed", __FUNCTION__);
-        return uiResult;
-    }
-
-    /* Get OpenVPNService service handle. */
-    SC_HANDLE hService = OpenService(hSCManager, TEXT("OpenVPNService"), SERVICE_QUERY_STATUS | SERVICE_QUERY_CONFIG);
-    if (hService == NULL)
-    {
-        uiResult = GetLastError();
-        if (uiResult == ERROR_SERVICE_DOES_NOT_EXIST)
-        {
-            /* This is not actually an error. */
-            goto cleanup_OpenSCManager;
-        }
-        msg(M_NONFATAL | M_ERRNO, "%s: OpenService(\"OpenVPNService\") failed", __FUNCTION__);
-        goto cleanup_OpenSCManager;
-    }
-
-    /* Query service status. */
-    SERVICE_STATUS_PROCESS ssp;
-    DWORD dwBufSize;
-    if (QueryServiceStatusEx(hService, SC_STATUS_PROCESS_INFO, (LPBYTE)&ssp, sizeof(ssp), &dwBufSize))
-    {
-        switch (ssp.dwCurrentState)
-        {
-            case SERVICE_START_PENDING:
-            case SERVICE_RUNNING:
-            case SERVICE_STOP_PENDING:
-            case SERVICE_PAUSE_PENDING:
-            case SERVICE_PAUSED:
-            case SERVICE_CONTINUE_PENDING:
-            {
-                /* Service is started (kind of). Set OPENVPNSERVICE property to service PID. */
-                TCHAR szPID[10 /*MAXDWORD in decimal*/ + 1 /*terminator*/];
-                _stprintf_s(
-                    szPID, _countof(szPID),
-                    TEXT("%u"),
-                    ssp.dwProcessId);
-
-                uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), szPID);
-                if (uiResult != ERROR_SUCCESS)
-                {
-                    SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-                    msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
-                }
-
-                /* We know user is using the service. Skip auto-start setting check. */
-                goto cleanup_OpenService;
-            }
-            break;
-        }
-    }
-    else
-    {
-        uiResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: QueryServiceStatusEx(\"OpenVPNService\") failed", __FUNCTION__);
-    }
-
-    /* Service is not started. Is it set to auto-start? */
-    /* MSDN describes the maximum buffer size for QueryServiceConfig() to be 8kB. */
-    /* This is small enough to fit on stack. */
-    BYTE _buffer_8k[8192];
-    LPQUERY_SERVICE_CONFIG pQsc = (LPQUERY_SERVICE_CONFIG)_buffer_8k;
-    dwBufSize = sizeof(_buffer_8k);
-    if (!QueryServiceConfig(hService, pQsc, dwBufSize, &dwBufSize))
-    {
-        uiResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: QueryServiceStatusEx(\"QueryServiceConfig\") failed", __FUNCTION__);
-        goto cleanup_OpenService;
-    }
-
-    if (pQsc->dwStartType <= SERVICE_AUTO_START)
-    {
-        /* Service is set to auto-start. Set OPENVPNSERVICE property to its path. */
-        uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), pQsc->lpBinaryPathName);
-        if (uiResult != ERROR_SUCCESS)
-        {
-            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
-            goto cleanup_OpenService;
-        }
-    }
-
-    uiResult = ERROR_SUCCESS;
-
-cleanup_OpenService:
-    CloseServiceHandle(hService);
-cleanup_OpenSCManager:
-    CloseServiceHandle(hSCManager);
-    return uiResult;
-}
-
-
 static void
 find_adapters(
     _In_ MSIHANDLE hInstall,
@@ -423,7 +309,6 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    set_openvpnserv_state(hInstall);
     find_adapters(
         hInstall,
         TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0"),
-- 
2.23.0.windows.1


