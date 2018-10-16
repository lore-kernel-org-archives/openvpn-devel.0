From: Simon Rozman <simon@...2293...>
Date: Tue, 16 Oct 2018 12:26:26 +0200
Message-Id: <20181016102627.18676-4-simon@...2293...>
In-Reply-To: <20181016102627.18676-1-simon@...2293...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] Add MSI custom action for reliable
 Windows 10 detection
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

This patch introduces a `FindSystemInfo()` MSI custom action to reliably
detect Windows 10. The MSI built-in properties for Windows version
detection depend on bootstrapper's manifest. We could provide our own
Windows 10 compatible EXE bootstrapper, but that would cover the
Windows 10 detection in the `InstallUISequence` only. The
`InstallExecuteSequence` is launched by msiexec.exe which we cannot
tamper with would still report `VersionNT` as Windows 8 (603).
---
 src/openvpnmsica/Makefile.am    |   2 +-
 src/openvpnmsica/openvpnmsica.c | 124 ++++++++++++++++++++++++++++++--
 src/openvpnmsica/openvpnmsica.h |  15 ++++
 3 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index d46170b4..ecca74bc 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -41,7 +41,7 @@ libopenvpnmsica_la_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -lshlwapi -no-undefined -avoid-version
+libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -lshlwapi -lversion -no-undefined -avoid-version
 endif
 
 libopenvpnmsica_la_SOURCES = \
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 3b90ce05..d1642d6a 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -36,13 +36,15 @@
 #include <memory.h>
 #include <msiquery.h>
 #include <shlwapi.h>
-#ifdef _MSC_VER
-#pragma comment(lib, "shlwapi.lib")
-#endif
 #include <stdbool.h>
 #include <stdlib.h>
 #include <tchar.h>
 
+#ifdef _MSC_VER
+#pragma comment(lib, "shlwapi.lib")
+#pragma comment(lib, "version.lib")
+#endif
+
 
 /**
  * Local constants
@@ -119,7 +121,7 @@ openvpnmsica_setup_sequence_filename(
     {
         size_t len_action_name_z = _tcslen(openvpnmsica_cleanup_action_seqs[i].szName) + 1;
         TCHAR *szPropertyEx = (TCHAR*)malloc((len_property_name + len_action_name_z) * sizeof(TCHAR));
-        memcpy(szPropertyEx                    , szProperty                         , len_property_name * sizeof(TCHAR));
+        memcpy(szPropertyEx                    , szProperty                                , len_property_name * sizeof(TCHAR));
         memcpy(szPropertyEx + len_property_name, openvpnmsica_cleanup_action_seqs[i].szName, len_action_name_z * sizeof(TCHAR));
         _stprintf_s(
             szFilenameEx, _countof(szFilenameEx),
@@ -142,6 +144,120 @@ openvpnmsica_setup_sequence_filename(
 }
 
 
+UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+#ifdef _DEBUG
+    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
+#endif
+
+    UINT uiResult;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall = hInstall;
+
+    // Get Windows version.
+    OSVERSIONINFOEX ver_info = { .dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX) };
+    if (!GetVersionEx((LPOSVERSIONINFO)&ver_info)) {
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: GetVersionEx() failed", __FUNCTION__);
+        goto cleanup_CoInitialize;
+    }
+
+    // The Windows version is usually spoofed, check using RtlGetVersion().
+    TCHAR szDllPath[0x1000];
+    ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\ntdll.dll"), szDllPath,
+#ifdef UNICODE
+        _countof(szDllPath)
+#else
+        _countof(szDllPath) - 1
+#endif
+    );
+    HMODULE hNtDllModule = LoadLibrary(szDllPath);
+    if (hNtDllModule)
+    {
+        typedef NTSTATUS (WINAPI* fnRtlGetVersion)(PRTL_OSVERSIONINFOW);
+        fnRtlGetVersion RtlGetVersion = (fnRtlGetVersion)GetProcAddress(hNtDllModule, "RtlGetVersion");
+        if (RtlGetVersion)
+        {
+            RTL_OSVERSIONINFOW rtl_ver_info = { .dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOW) };
+            if (RtlGetVersion(&rtl_ver_info) == 0)
+                if (
+                    rtl_ver_info.dwMajorVersion >  ver_info.dwMajorVersion ||
+                    rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion >  ver_info.dwMinorVersion ||
+                    rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion == ver_info.dwMinorVersion && rtl_ver_info.dwBuildNumber > ver_info.dwBuildNumber)
+                {
+                    // We got RtlGetVersion() and it reported newer version than GetVersionEx().
+                    ver_info.dwMajorVersion = rtl_ver_info.dwMajorVersion;
+                    ver_info.dwMinorVersion = rtl_ver_info.dwMinorVersion;
+                    ver_info.dwBuildNumber  = rtl_ver_info.dwBuildNumber;
+                    ver_info.dwPlatformId   = rtl_ver_info.dwPlatformId;
+                }
+        }
+
+        FreeLibrary(hNtDllModule);
+    }
+
+    // We don't trust RtlGetVersion() either. Check the version resource of kernel32.dll.
+    ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\kernel32.dll"), szDllPath,
+#ifdef UNICODE
+        _countof(szDllPath)
+#else
+        _countof(szDllPath)-1
+#endif
+    );
+
+    DWORD dwHandle;
+    DWORD dwVerInfoSize = GetFileVersionInfoSize(szDllPath, &dwHandle);
+    if (dwVerInfoSize)
+    {
+        LPVOID pVersionInfo = malloc(dwVerInfoSize);
+        if (pVersionInfo)
+        {
+            // Read version info.
+            if (GetFileVersionInfo(szDllPath, dwHandle, dwVerInfoSize, pVersionInfo))
+            {
+                // Get the value for the root block.
+                UINT uiSize = 0;
+                VS_FIXEDFILEINFO *pVSFixedFileInfo = NULL;
+                if (VerQueryValue(pVersionInfo, TEXT("\\"), &pVSFixedFileInfo, &uiSize) && uiSize && pVSFixedFileInfo)
+                    if (HIWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMajorVersion ||
+                        HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMinorVersion ||
+                        HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMinorVersion && HIWORD(pVSFixedFileInfo->dwProductVersionLS) > ver_info.dwBuildNumber)
+                    {
+                        // We got kernel32.dll version and it is newer.
+                        ver_info.dwMajorVersion = HIWORD(pVSFixedFileInfo->dwProductVersionMS);
+                        ver_info.dwMinorVersion = LOWORD(pVSFixedFileInfo->dwProductVersionMS);
+                        ver_info.dwBuildNumber  = HIWORD(pVSFixedFileInfo->dwProductVersionLS);
+                    }
+            }
+
+            free(pVersionInfo);
+        }
+    }
+
+    uiResult = MsiSetProperty(hInstall, TEXT("DriverCertification"), ver_info.dwMajorVersion >= 10 ? ver_info.wProductType > VER_NT_WORKSTATION ? TEXT("whql") : TEXT("attsgn") : TEXT(""));
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPINTERFACES\") failed", __FUNCTION__);
+        goto cleanup_CoInitialize;
+    }
+
+    uiResult = ERROR_SUCCESS;
+
+cleanup_CoInitialize:
+    if (bIsCoInitialized) CoUninitialize();
+    return uiResult;
+}
+
+
 UINT __stdcall
 FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 {
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index bb8e28ec..da145062 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -63,6 +63,21 @@ extern "C" {
 #endif
 
 
+/**
+ * Determines Windows information:
+ * - Sets `DriverCertification` MSI property to "", "attsgn" or "whql"
+ *   according to the driver certification required by the running version of
+ *   Windows.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+DLLEXP_DECL UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall);
+
+
 /**
  * Find existing TAP interfaces and set TAPINTERFACES property with semicolon delimited list
  * of installed TAP interface GUIDs.
-- 
2.19.0.windows.1


