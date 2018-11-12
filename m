From: Simon Rozman <simon@...2293...>
Date: Mon, 12 Nov 2018 13:22:45 +0100
Message-Id: <20181112122246.13556-2-simon@...2293...>
In-Reply-To: <20181112122246.13556-1-simon@...2293...>
References: <20181112122246.13556-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Change C++ to C comments
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
 src/openvpnmsica/openvpnmsica.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index d1642d6a..99b47bf0 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -162,7 +162,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
     struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
     s->hInstall = hInstall;
 
-    // Get Windows version.
+    /* Get Windows version. */
     OSVERSIONINFOEX ver_info = { .dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX) };
     if (!GetVersionEx((LPOSVERSIONINFO)&ver_info)) {
         uiResult = GetLastError();
@@ -170,7 +170,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
         goto cleanup_CoInitialize;
     }
 
-    // The Windows version is usually spoofed, check using RtlGetVersion().
+    /* The Windows version is usually spoofed, check using RtlGetVersion(). */
     TCHAR szDllPath[0x1000];
     ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\ntdll.dll"), szDllPath,
 #ifdef UNICODE
@@ -193,7 +193,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
                     rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion >  ver_info.dwMinorVersion ||
                     rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion == ver_info.dwMinorVersion && rtl_ver_info.dwBuildNumber > ver_info.dwBuildNumber)
                 {
-                    // We got RtlGetVersion() and it reported newer version than GetVersionEx().
+                    /* We got RtlGetVersion() and it reported newer version than GetVersionEx(). */
                     ver_info.dwMajorVersion = rtl_ver_info.dwMajorVersion;
                     ver_info.dwMinorVersion = rtl_ver_info.dwMinorVersion;
                     ver_info.dwBuildNumber  = rtl_ver_info.dwBuildNumber;
@@ -204,7 +204,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
         FreeLibrary(hNtDllModule);
     }
 
-    // We don't trust RtlGetVersion() either. Check the version resource of kernel32.dll.
+    /* We don't trust RtlGetVersion() either. Check the version resource of kernel32.dll. */
     ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\kernel32.dll"), szDllPath,
 #ifdef UNICODE
         _countof(szDllPath)
@@ -220,10 +220,10 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
         LPVOID pVersionInfo = malloc(dwVerInfoSize);
         if (pVersionInfo)
         {
-            // Read version info.
+            /* Read version info. */
             if (GetFileVersionInfo(szDllPath, dwHandle, dwVerInfoSize, pVersionInfo))
             {
-                // Get the value for the root block.
+                /* Get the value for the root block. */
                 UINT uiSize = 0;
                 VS_FIXEDFILEINFO *pVSFixedFileInfo = NULL;
                 if (VerQueryValue(pVersionInfo, TEXT("\\"), &pVSFixedFileInfo, &uiSize) && uiSize && pVSFixedFileInfo)
@@ -231,7 +231,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
                         HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMinorVersion ||
                         HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMinorVersion && HIWORD(pVSFixedFileInfo->dwProductVersionLS) > ver_info.dwBuildNumber)
                     {
-                        // We got kernel32.dll version and it is newer.
+                        /* We got kernel32.dll version and it is newer. */
                         ver_info.dwMajorVersion = HIWORD(pVSFixedFileInfo->dwProductVersionMS);
                         ver_info.dwMinorVersion = LOWORD(pVSFixedFileInfo->dwProductVersionMS);
                         ver_info.dwBuildNumber  = HIWORD(pVSFixedFileInfo->dwProductVersionLS);
-- 
2.19.1.windows.1


