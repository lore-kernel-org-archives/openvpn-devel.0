From: Jon Kunkee <jkunkee@...2393...>
Date: Thu, 8 Nov 2018 22:50:08 +0000
Message-ID: <DM5PR2101MB1112DB68D163884AD7ACDA80B0C50@...2412...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-4-simon@...2293...>
In-Reply-To: <20181016102627.18676-4-simon@...2293...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add MSI custom action for reliable
 Windows 10 detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Simon,

This is painful to read, and I bet it was even more painful to write. I am=
=20
sorry it came to this, though it does look like it should(TM) work.

From what I gather, the OS version should be checked in the=20
CustomAction's MSI execution conditions instead of in the CustomAction=20
itself. The appropriate information can then be passed in based on that:

https://blogs.msdn.microsoft.com/cjacks/2009/05/06/why-custom-actions-get-a=
-windows-vista-version-lie-on-windows-7/

It might be somewhat more convenient to add the PID to the debug=20
MessageBox call, but it is probably MUCH more convenient to use the=20
CustomAction debugging facility built into the MSI service itself:

https://docs.microsoft.com/en-us/windows/desktop/Msi/debugging-custom-actio=
ns

Thanks,
Jon

-----Original Message-----
From: Simon Rozman <simon@...2293...>=20
Sent: Tuesday, October 16, 2018 3:26 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH 4/5] Add MSI custom action for reliable Win=
dows 10 detection

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
@@ -41,7 +41,7 @@ libopenvpnmsica_la_CFLAGS =3D \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
-libopenvpnmsica_la_LDFLAGS =3D -ladvapi32 -lole32 -lmsi -lsetupapi -lshlwa=
pi -no-undefined -avoid-version
+libopenvpnmsica_la_LDFLAGS =3D -ladvapi32 -lole32 -lmsi -lsetupapi -lshlwa=
pi -lversion -no-undefined -avoid-version
 endif
=20
 libopenvpnmsica_la_SOURCES =3D \
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
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
=20
+#ifdef _MSC_VER
+#pragma comment(lib, "shlwapi.lib")
+#pragma comment(lib, "version.lib")
+#endif
+
=20
 /**
  * Local constants
@@ -119,7 +121,7 @@ openvpnmsica_setup_sequence_filename(
     {
         size_t len_action_name_z =3D _tcslen(openvpnmsica_cleanup_action_s=
eqs[i].szName) + 1;
         TCHAR *szPropertyEx =3D (TCHAR*)malloc((len_property_name + len_ac=
tion_name_z) * sizeof(TCHAR));
-        memcpy(szPropertyEx                    , szProperty               =
          , len_property_name * sizeof(TCHAR));
+        memcpy(szPropertyEx                    , szProperty               =
                 , len_property_name * sizeof(TCHAR));
         memcpy(szPropertyEx + len_property_name, openvpnmsica_cleanup_acti=
on_seqs[i].szName, len_action_name_z * sizeof(TCHAR));
         _stprintf_s(
             szFilenameEx, _countof(szFilenameEx),
@@ -142,6 +144,120 @@ openvpnmsica_setup_sequence_filename(
 }
=20
=20
+UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+#ifdef _DEBUG
+    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v=
")  TEXT(PACKAGE_VERSION), MB_OK);
+#endif
+
+    UINT uiResult;
+    BOOL bIsCoInitialized =3D SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s =3D (struct openvpnmsica_tls_data *)Tl=
sGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall =3D hInstall;
+
+    // Get Windows version.
+    OSVERSIONINFOEX ver_info =3D { .dwOSVersionInfoSize =3D sizeof(OSVERSI=
ONINFOEX) };
+    if (!GetVersionEx((LPOSVERSIONINFO)&ver_info)) {
+        uiResult =3D GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: GetVersionEx() failed", __FUNCTION_=
_);
+        goto cleanup_CoInitialize;
+    }
+
+    // The Windows version is usually spoofed, check using RtlGetVersion().
+    TCHAR szDllPath[0x1000];
+    ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\ntdll.dll"), sz=
DllPath,
+#ifdef UNICODE
+        _countof(szDllPath)
+#else
+        _countof(szDllPath) - 1
+#endif
+    );
+    HMODULE hNtDllModule =3D LoadLibrary(szDllPath);
+    if (hNtDllModule)
+    {
+        typedef NTSTATUS (WINAPI* fnRtlGetVersion)(PRTL_OSVERSIONINFOW);
+        fnRtlGetVersion RtlGetVersion =3D (fnRtlGetVersion)GetProcAddress(=
hNtDllModule, "RtlGetVersion");
+        if (RtlGetVersion)
+        {
+            RTL_OSVERSIONINFOW rtl_ver_info =3D { .dwOSVersionInfoSize =3D=
 sizeof(RTL_OSVERSIONINFOW) };
+            if (RtlGetVersion(&rtl_ver_info) =3D=3D 0)
+                if (
+                    rtl_ver_info.dwMajorVersion >  ver_info.dwMajorVersion=
 ||
+                    rtl_ver_info.dwMajorVersion =3D=3D ver_info.dwMajorVer=
sion && rtl_ver_info.dwMinorVersion >  ver_info.dwMinorVersion ||
+                    rtl_ver_info.dwMajorVersion =3D=3D ver_info.dwMajorVer=
sion && rtl_ver_info.dwMinorVersion =3D=3D ver_info.dwMinorVersion && rtl_v=
er_info.dwBuildNumber > ver_info.dwBuildNumber)
+                {
+                    // We got RtlGetVersion() and it reported newer versio=
n than GetVersionEx().
+                    ver_info.dwMajorVersion =3D rtl_ver_info.dwMajorVersio=
n;
+                    ver_info.dwMinorVersion =3D rtl_ver_info.dwMinorVersio=
n;
+                    ver_info.dwBuildNumber  =3D rtl_ver_info.dwBuildNumber;
+                    ver_info.dwPlatformId   =3D rtl_ver_info.dwPlatformId;
+                }
+        }
+
+        FreeLibrary(hNtDllModule);
+    }
+
+    // We don't trust RtlGetVersion() either. Check the version resource o=
f kernel32.dll.
+    ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\kernel32.dll"),=
 szDllPath,
+#ifdef UNICODE
+        _countof(szDllPath)
+#else
+        _countof(szDllPath)-1
+#endif
+    );
+
+    DWORD dwHandle;
+    DWORD dwVerInfoSize =3D GetFileVersionInfoSize(szDllPath, &dwHandle);
+    if (dwVerInfoSize)
+    {
+        LPVOID pVersionInfo =3D malloc(dwVerInfoSize);
+        if (pVersionInfo)
+        {
+            // Read version info.
+            if (GetFileVersionInfo(szDllPath, dwHandle, dwVerInfoSize, pVe=
rsionInfo))
+            {
+                // Get the value for the root block.
+                UINT uiSize =3D 0;
+                VS_FIXEDFILEINFO *pVSFixedFileInfo =3D NULL;
+                if (VerQueryValue(pVersionInfo, TEXT("\\"), &pVSFixedFileI=
nfo, &uiSize) && uiSize && pVSFixedFileInfo)
+                    if (HIWORD(pVSFixedFileInfo->dwProductVersionMS) >  ve=
r_info.dwMajorVersion ||
+                        HIWORD(pVSFixedFileInfo->dwProductVersionMS) =3D=
=3D ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS)=
 >  ver_info.dwMinorVersion ||
+                        HIWORD(pVSFixedFileInfo->dwProductVersionMS) =3D=
=3D ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS)=
 =3D=3D ver_info.dwMinorVersion && HIWORD(pVSFixedFileInfo->dwProductVersio=
nLS) > ver_info.dwBuildNumber)
+                    {
+                        // We got kernel32.dll version and it is newer.
+                        ver_info.dwMajorVersion =3D HIWORD(pVSFixedFileInf=
o->dwProductVersionMS);
+                        ver_info.dwMinorVersion =3D LOWORD(pVSFixedFileInf=
o->dwProductVersionMS);
+                        ver_info.dwBuildNumber  =3D HIWORD(pVSFixedFileInf=
o->dwProductVersionLS);
+                    }
+            }
+
+            free(pVersionInfo);
+        }
+    }
+
+    uiResult =3D MsiSetProperty(hInstall, TEXT("DriverCertification"), ver=
_info.dwMajorVersion >=3D 10 ? ver_info.wProductType > VER_NT_WORKSTATION ?=
 TEXT("whql") : TEXT("attsgn") : TEXT(""));
+    if (uiResult !=3D ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() =
to set GetLastError(). But we do have an error code. Set last error manuall=
y. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPINTERFACES\") f=
ailed", __FUNCTION__);
+        goto cleanup_CoInitialize;
+    }
+
+    uiResult =3D ERROR_SUCCESS;
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
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index bb8e28ec..da145062 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -63,6 +63,21 @@ extern "C" {
 #endif
=20
=20
+/**
+ * Determines Windows information:
+ * - Sets `DriverCertification` MSI property to "", "attsgn" or "whql"
+ *   according to the driver certification required by the running version=
 of
+ *   Windows.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL cus=
tom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://na01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Faa36807=
2.aspx&amp;data=3D02%7C01%7Cjkunkee%40microsoft.com%7Cd520a31814634dced1dc0=
8d63351eb58%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636752824275192379=
&amp;sdata=3D2DLeMsL5JHIFmh07Fh6zqZTGt117xy%2Bu2TY3acNpaH8%3D&amp;reserved=
=3D0
+ */
+DLLEXP_DECL UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall);
+
+
 /**
  * Find existing TAP interfaces and set TAPINTERFACES property with semico=
lon delimited list
  * of installed TAP interface GUIDs.
--=20
2.19.0.windows.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.so=
urceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;data=3D02%7C01%7Cjkunk=
ee%40microsoft.com%7Cd520a31814634dced1dc08d63351eb58%7C72f988bf86f141af91a=
b2d7cd011db47%7C1%7C0%7C636752824275192379&amp;sdata=3DUpy1p7tESRCzuEPIBUpk=
xr3YnZpFFrr8zpQybDyaY1Q%3D&amp;reserved=3D0

