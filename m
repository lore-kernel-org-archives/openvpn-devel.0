From: Simon Rozman <simon@...2293...>
Date: Tue, 16 Oct 2018 12:26:24 +0200
Message-Id: <20181016102627.18676-2-simon@...2293...>
In-Reply-To: <20181016102627.18676-1-simon@...2293...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5] Prevent __stdcall name mangling of MSVC
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

Using `extern "C" __declspec(dllexport) __stdcall`, Win32 MSVC compiler
exports the functions are as `_name@...1630...`. Exporting functions using
`/EXPORT` linker flag allows us to specify exact function name.

Note: The 64-bit MSVC compiler does not exhibit `__stdcall` name-
mangling.
---
 src/openvpnmsica/openvpnmsica.c | 12 ++++++++++++
 src/openvpnmsica/openvpnmsica.h | 14 +++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
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
     MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
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
     MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
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
     MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
 #endif
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 3a64fbaa..bb8e28ec 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -55,6 +55,14 @@ extern DWORD openvpnmsica_tlsidx_session;
 extern "C" {
 #endif
 
+#ifdef __GNUC__
+#define DLLEXP_DECL __declspec(dllexport)
+#else
+#define DLLEXP_DECL
+#define DLLEXP_EXPORT "/EXPORT:"__FUNCTION__"="__FUNCDNAME__
+#endif
+
+
 /**
  * Find existing TAP interfaces and set TAPINTERFACES property with semicolon delimited list
  * of installed TAP interface GUIDs.
@@ -64,7 +72,7 @@ extern "C" {
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-__declspec(dllexport) UINT __stdcall
+DLLEXP_DECL UINT __stdcall
 FindTAPInterfaces(_In_ MSIHANDLE hInstall);
 
 
@@ -77,7 +85,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-__declspec(dllexport) UINT __stdcall
+DLLEXP_DECL UINT __stdcall
 EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall);
 
 
@@ -89,7 +97,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-__declspec(dllexport) UINT __stdcall
+DLLEXP_DECL UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall);
 
 #ifdef __cplusplus
-- 
2.19.0.windows.1


