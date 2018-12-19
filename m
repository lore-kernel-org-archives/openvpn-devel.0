From: Simon Rozman <simon@...2293...>
Date: Wed, 19 Dec 2018 21:26:09 +0100
Message-Id: <20181219202611.2144-2-simon@...2293...>
In-Reply-To: <20181219202611.2144-1-simon@...2293...>
References: <20181219202611.2144-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] Extend FindSystemInfo custom action to
 detect OpenVPNService state
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

---
 src/openvpnmsica/openvpnmsica.c | 168 ++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 17 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 721bd4f8..810c2858 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -44,6 +44,7 @@
 #include <tchar.h>
 
 #ifdef _MSC_VER
+#pragma comment(lib, "advapi32.lib")
 #pragma comment(lib, "iphlpapi.lib")
 #pragma comment(lib, "shell32.lib")
 #pragma comment(lib, "shlwapi.lib")
@@ -193,29 +194,34 @@ _openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
 #endif
 
 
-UINT __stdcall
-FindSystemInfo(_In_ MSIHANDLE hInstall)
+/**
+ * Detects Windows version and sets DRIVERCERTIFICATION property to "", "whql", or "attsgn"
+ * accordingly.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+static UINT
+openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
-#pragma comment(linker, DLLEXP_EXPORT)
-#endif
-
-    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
-
     UINT uiResult;
-    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-
-    /* Set MSI session handle in TLS. */
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
-    s->hInstall = hInstall;
 
     /* Get Windows version. */
+#ifdef _MSC_VER
+#pragma warning(push)
+#pragma warning(disable: 4996) /* 'GetVersionExW': was declared deprecated. */
+#endif
     OSVERSIONINFOEX ver_info = { .dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX) };
     if (!GetVersionEx((LPOSVERSIONINFO)&ver_info)) {
         uiResult = GetLastError();
         msg(M_NONFATAL | M_ERRNO, "%s: GetVersionEx() failed", __FUNCTION__);
-        goto cleanup_CoInitialize;
+        return uiResult;
     }
+#ifdef _MSC_VER
+#pragma warning(pop)
+#endif
 
     /* The Windows version is usually spoofed, check using RtlGetVersion(). */
     TCHAR szDllPath[0x1000];
@@ -294,17 +300,145 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
         msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"DRIVERCERTIFICATION\") failed", __FUNCTION__);
-        goto cleanup_CoInitialize;
+        return uiResult;
+    }
+
+    return ERROR_SUCCESS;
+}
+
+
+/**
+ * Detects if the OpenVPNService service is in use (running or paused) and sets
+ * OPENVPNSERVICE to the service process PID, or its path if it is set to
+ * auto-start, but not running.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+static UINT
+openvpnmsica_set_openvpnserv_state(_In_ MSIHANDLE hInstall)
+{
+    UINT uiResult;
+
+    /* Get Service Control Manager handle. */
+    SC_HANDLE hSCManager = OpenSCManager(NULL, SERVICES_ACTIVE_DATABASE, SC_MANAGER_CONNECT);
+    if (hSCManager == NULL)
+    {
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: OpenSCManager() failed", __FUNCTION__);
+        return uiResult;
+    }
+
+    /* Get OpenVPNService service handle. */
+    SC_HANDLE hService = OpenService(hSCManager, TEXT("OpenVPNService"), SERVICE_QUERY_STATUS | SERVICE_QUERY_CONFIG);
+    if (hService == NULL)
+    {
+        uiResult = GetLastError();
+        if (uiResult == ERROR_SERVICE_DOES_NOT_EXIST) {
+            /* This is not actually an error. */
+            goto cleanup_OpenSCManager;
+        }
+        msg(M_NONFATAL | M_ERRNO, "%s: OpenService(\"OpenVPNService\") failed", __FUNCTION__);
+        goto cleanup_OpenSCManager;
+    }
+
+    /* Query service status. */
+    SERVICE_STATUS_PROCESS ssp;
+    DWORD dwBufSize;
+    if (!QueryServiceStatusEx(hService, SC_STATUS_PROCESS_INFO, (LPBYTE)&ssp, sizeof(ssp), &dwBufSize))
+    {
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: QueryServiceStatusEx(\"OpenVPNService\") failed", __FUNCTION__);
+        goto finish_QueryServiceStatusEx;
+    }
+
+    switch (ssp.dwCurrentState)
+    {
+    case SERVICE_START_PENDING:
+    case SERVICE_RUNNING:
+    case SERVICE_STOP_PENDING:
+    case SERVICE_PAUSE_PENDING:
+    case SERVICE_PAUSED:
+    case SERVICE_CONTINUE_PENDING:
+    {
+        /* Set OPENVPNSERVICE property to service PID. */
+        TCHAR szPID[10/*MAXDWORD in decimal*/ + 1/*terminator*/];
+        _stprintf_s(
+            szPID, _countof(szPID),
+            TEXT("%u"),
+            ssp.dwProcessId);
+
+        uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), szPID);
+        if (uiResult != ERROR_SUCCESS)
+        {
+            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
+        }
+        goto cleanup_OpenService;
+    }
+    break;
+    }
+finish_QueryServiceStatusEx:;
+
+    // Service is not started. Is it set to auto-start?
+    // MSDN describes the maximum buffer size for QueryServiceConfig() to be 8kB.
+    // This is small enough to fit on stack.
+    BYTE _buffer_8k[8192];
+    LPQUERY_SERVICE_CONFIG pQsc = (LPQUERY_SERVICE_CONFIG)_buffer_8k;
+    dwBufSize = sizeof(_buffer_8k);
+    if (!QueryServiceConfig(hService, pQsc, dwBufSize, &dwBufSize))
+    {
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: QueryServiceStatusEx(\"QueryServiceConfig\") failed", __FUNCTION__);
+        goto cleanup_OpenService;
+    }
+
+    if (pQsc->dwStartType <= SERVICE_AUTO_START)
+    {
+        uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), pQsc->lpBinaryPathName);
+        if (uiResult != ERROR_SUCCESS)
+        {
+            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
+            goto cleanup_OpenService;
+        }
     }
 
     uiResult = ERROR_SUCCESS;
 
-cleanup_CoInitialize:
-    if (bIsCoInitialized) CoUninitialize();
+cleanup_OpenService:
+    CloseServiceHandle(hService);
+cleanup_OpenSCManager:
+    CloseServiceHandle(hSCManager);
     return uiResult;
 }
 
 
+UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall = hInstall;
+
+    openvpnmsica_set_driver_certification(hInstall);
+    openvpnmsica_set_openvpnserv_state(hInstall);
+
+    if (bIsCoInitialized) CoUninitialize();
+    return ERROR_SUCCESS;
+}
+
+
 UINT __stdcall
 FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 {
-- 
2.19.0.windows.1


