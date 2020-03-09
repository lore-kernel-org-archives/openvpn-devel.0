From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:17 +0100
Message-Id: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 01/12] openvpnmsica: Remove required Windows
 driver certification detection
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

The MSI packages are switching to TAP-Windows6 and Wintun MSM modules to
install the TAP/TUN driver. The MSM modules have built-in Windows
version detection already.

This commit is now-dead-code clean up with uncrustification.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 129 +-------------------------------
 1 file changed, 3 insertions(+), 126 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 16381ea1..4236330a 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -203,128 +203,6 @@ _openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
 #endif /* ifdef _DEBUG */
 
 
-/**
- * Detects Windows version and sets DRIVERCERTIFICATION property to "", "whql", or "attsgn"
- * accordingly.
- *
- * @param hInstall      Handle to the installation provided to the DLL custom action
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
- */
-static UINT
-openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
-{
-    UINT uiResult;
-
-    /* Get Windows version. */
-#ifdef _MSC_VER
-#pragma warning(push)
-#pragma warning(disable: 4996) /* 'GetVersionExW': was declared deprecated. */
-#endif
-    OSVERSIONINFOEX ver_info = { .dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX) };
-    if (!GetVersionEx((LPOSVERSIONINFO)&ver_info))
-    {
-        uiResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: GetVersionEx() failed", __FUNCTION__);
-        return uiResult;
-    }
-#ifdef _MSC_VER
-#pragma warning(pop)
-#endif
-
-    /* The Windows version is usually spoofed, check using RtlGetVersion(). */
-    TCHAR szDllPath[0x1000];
-    ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\ntdll.dll"), szDllPath,
-#ifdef UNICODE
-                             _countof(szDllPath)
-#else
-                             _countof(szDllPath) - 1
-#endif
-                             );
-    HMODULE hNtDllModule = LoadLibrary(szDllPath);
-    if (hNtDllModule)
-    {
-        typedef NTSTATUS (WINAPI* fnRtlGetVersion)(PRTL_OSVERSIONINFOW);
-        fnRtlGetVersion RtlGetVersion = (fnRtlGetVersion)GetProcAddress(hNtDllModule, "RtlGetVersion");
-        if (RtlGetVersion)
-        {
-            RTL_OSVERSIONINFOW rtl_ver_info = { .dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOW) };
-            if (RtlGetVersion(&rtl_ver_info) == 0)
-            {
-                if (
-                    rtl_ver_info.dwMajorVersion >  ver_info.dwMajorVersion
-                    || rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion >  ver_info.dwMinorVersion
-                    || rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion == ver_info.dwMinorVersion && rtl_ver_info.dwBuildNumber > ver_info.dwBuildNumber)
-                {
-                    /* We got RtlGetVersion() and it reported newer version than GetVersionEx(). */
-                    ver_info.dwMajorVersion = rtl_ver_info.dwMajorVersion;
-                    ver_info.dwMinorVersion = rtl_ver_info.dwMinorVersion;
-                    ver_info.dwBuildNumber  = rtl_ver_info.dwBuildNumber;
-                    ver_info.dwPlatformId   = rtl_ver_info.dwPlatformId;
-                }
-            }
-        }
-
-        FreeLibrary(hNtDllModule);
-    }
-
-    /* We don't trust RtlGetVersion() either. Check the version resource of kernel32.dll. */
-    ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\kernel32.dll"), szDllPath,
-#ifdef UNICODE
-                             _countof(szDllPath)
-#else
-                             _countof(szDllPath) - 1
-#endif
-                             );
-
-    DWORD dwHandle;
-    DWORD dwVerInfoSize = GetFileVersionInfoSize(szDllPath, &dwHandle);
-    if (dwVerInfoSize)
-    {
-        LPVOID pVersionInfo = malloc(dwVerInfoSize);
-        if (pVersionInfo)
-        {
-            /* Read version info. */
-            if (GetFileVersionInfo(szDllPath, dwHandle, dwVerInfoSize, pVersionInfo))
-            {
-                /* Get the value for the root block. */
-                UINT uiSize = 0;
-                VS_FIXEDFILEINFO *pVSFixedFileInfo = NULL;
-                if (VerQueryValue(pVersionInfo, TEXT("\\"), &pVSFixedFileInfo, &uiSize) && uiSize && pVSFixedFileInfo)
-                {
-                    if (HIWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMajorVersion
-                        || HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMinorVersion
-                        || HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMinorVersion && HIWORD(pVSFixedFileInfo->dwProductVersionLS) > ver_info.dwBuildNumber)
-                    {
-                        /* We got kernel32.dll version and it is newer. */
-                        ver_info.dwMajorVersion = HIWORD(pVSFixedFileInfo->dwProductVersionMS);
-                        ver_info.dwMinorVersion = LOWORD(pVSFixedFileInfo->dwProductVersionMS);
-                        ver_info.dwBuildNumber  = HIWORD(pVSFixedFileInfo->dwProductVersionLS);
-                    }
-                }
-            }
-
-            free(pVersionInfo);
-        }
-        else
-        {
-            msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, dwVerInfoSize);
-        }
-    }
-
-    uiResult = MsiSetProperty(hInstall, TEXT("DRIVERCERTIFICATION"), ver_info.dwMajorVersion >= 10 ? ver_info.wProductType > VER_NT_WORKSTATION ? TEXT("whql") : TEXT("attsgn") : TEXT(""));
-    if (uiResult != ERROR_SUCCESS)
-    {
-        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"DRIVERCERTIFICATION\") failed", __FUNCTION__);
-        return uiResult;
-    }
-
-    return ERROR_SUCCESS;
-}
-
-
 /**
  * Detects if the OpenVPNService service is in use (running or paused) and sets
  * OPENVPNSERVICE to the service process PID, or its path if it is set to
@@ -451,7 +329,6 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    openvpnmsica_set_driver_certification(hInstall);
     openvpnmsica_set_openvpnserv_state(hInstall);
 
     if (bIsCoInitialized)
@@ -829,7 +706,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
         goto cleanup_hViewST_close;
     }
 
-    for (;;)
+    for (;; )
     {
         /* Fetch one record from the view. */
         MSIHANDLE hRecord = 0;
@@ -998,7 +875,7 @@ cleanup_szSeqFilename:
     if (uiResult != ERROR_SUCCESS)
     {
         /* Clean-up sequence files. */
-        for (size_t i = _countof(szActionNames); i--;)
+        for (size_t i = _countof(szActionNames); i--; )
         {
             if (szSeqFilename[i][0])
             {
@@ -1186,7 +1063,7 @@ cleanup_session:
         uiResult = ERROR_SUCCESS;
     }
 
-    for (size_t i = MSICA_CLEANUP_ACTION_COUNT; i--;)
+    for (size_t i = MSICA_CLEANUP_ACTION_COUNT; i--; )
     {
         msica_op_seq_free(&session.seq_cleanup[i]);
     }
-- 
2.24.1.windows.2


