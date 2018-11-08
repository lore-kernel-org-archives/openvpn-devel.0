From: Jon Kunkee <jkunkee@...2393...>
Date: Thu, 8 Nov 2018 22:46:00 +0000
Message-ID: <DM5PR2101MB111211D7100DDFB6CF7741C2B0C50@...2412...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-2-simon@...2293...>
In-Reply-To: <20181016102627.18676-2-simon@...2293...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/5] Prevent __stdcall name mangling of
 MSVC
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

This approach keeps 'goes in DLL' next to the function itself, which I like=
. If=20
you're interested, another possible approach here is to use .DEF files with=
=20
MSVC, which can also do symbol aliasing:
https://docs.microsoft.com/en-us/cpp/build/exporting-from-a-dll-using-def-f=
iles

I would expect mingw to support .DEF files as well, but I don't know.

Only x86 Win32 functions are actually __stdcall; x64, ARM32, and ARM64=20
all ignore the token because the architectural calling convention makes it
meaningless:
https://msdn.microsoft.com/en-us/library/zxk0tw93.aspx

This is why the names don't get mangled. Of course, it's then inconsistent.

Export name consistency is needed so CustomActions can reference the=20
export symbol name, right?

Jon

-----Original Message-----
From: Simon Rozman <simon@...2293...>=20
Sent: Tuesday, October 16, 2018 3:26 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH 2/5] Prevent __stdcall name mangling of MSVC

Using `extern "C" __declspec(dllexport) __stdcall`, Win32 MSVC compiler
exports the functions are as `_name@...1630...`. Exporting functions using
`/EXPORT` linker flag allows us to specify exact function name.

Note: The 64-bit MSVC compiler does not exhibit `__stdcall` name-
mangling.
---
 src/openvpnmsica/openvpnmsica.c | 12 ++++++++++++
 src/openvpnmsica/openvpnmsica.h | 14 +++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 82333991..3b90ce05 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -145,6 +145,10 @@ openvpnmsica_setup_sequence_filename(
 UINT __stdcall
 FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 {
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
 #ifdef _DEBUG
     MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v=
")  TEXT(PACKAGE_VERSION), MB_OK);
 #endif
@@ -247,6 +251,10 @@ cleanup_CoInitialize:
 UINT __stdcall
 EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 {
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
 #ifdef _DEBUG
     MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v=
")  TEXT(PACKAGE_VERSION), MB_OK);
 #endif
@@ -505,6 +513,10 @@ cleanup_exec_seq:
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
 #ifdef _DEBUG
     MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v=
")  TEXT(PACKAGE_VERSION), MB_OK);
 #endif
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index 3a64fbaa..bb8e28ec 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -55,6 +55,14 @@ extern DWORD openvpnmsica_tlsidx_session;
 extern "C" {
 #endif
=20
+#ifdef __GNUC__
+#define DLLEXP_DECL __declspec(dllexport)
+#else
+#define DLLEXP_DECL
+#define DLLEXP_EXPORT "/EXPORT:"__FUNCTION__"=3D"__FUNCDNAME__
+#endif
+
+
 /**
  * Find existing TAP interfaces and set TAPINTERFACES property with semico=
lon delimited list
  * of installed TAP interface GUIDs.
@@ -64,7 +72,7 @@ extern "C" {
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://na01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Faa36807=
2.aspx&amp;data=3D02%7C01%7Cjkunkee%40microsoft.com%7C726e9ae5072942c989bf0=
8d63351ec71%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636752824301952450=
&amp;sdata=3DBXt41C1200ZAAQBQBS7vOiAZ3MzuQGCVHaUuFhYwMCk%3D&amp;reserved=3D0
  */
-__declspec(dllexport) UINT __stdcall
+DLLEXP_DECL UINT __stdcall
 FindTAPInterfaces(_In_ MSIHANDLE hInstall);
=20
=20
@@ -77,7 +85,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://na01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Faa36807=
2.aspx&amp;data=3D02%7C01%7Cjkunkee%40microsoft.com%7C726e9ae5072942c989bf0=
8d63351ec71%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636752824301962454=
&amp;sdata=3DvMBtU2AQPrfZ9xnbN4nYZfcAb2wNlIxLPqqYLwDtvUc%3D&amp;reserved=3D0
  */
-__declspec(dllexport) UINT __stdcall
+DLLEXP_DECL UINT __stdcall
 EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall);
=20
=20
@@ -89,7 +97,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://na01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Faa36807=
2.aspx&amp;data=3D02%7C01%7Cjkunkee%40microsoft.com%7C726e9ae5072942c989bf0=
8d63351ec71%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636752824301962454=
&amp;sdata=3DvMBtU2AQPrfZ9xnbN4nYZfcAb2wNlIxLPqqYLwDtvUc%3D&amp;reserved=3D0
  */
-__declspec(dllexport) UINT __stdcall
+DLLEXP_DECL UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall);
=20
 #ifdef __cplusplus
--=20
2.19.0.windows.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.so=
urceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;data=3D02%7C01%7Cjkunk=
ee%40microsoft.com%7C726e9ae5072942c989bf08d63351ec71%7C72f988bf86f141af91a=
b2d7cd011db47%7C1%7C0%7C636752824301962454&amp;sdata=3DmUAulpo9rK%2BlLjtrCm=
PGlSXWplIoifrSQcC7wCokw7E%3D&amp;reserved=3D0

