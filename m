From: Simon Rozman <simon@...2293...>
Date: Tue, 27 Nov 2018 01:28:08 +0100
Message-Id: <20181127002808.19200-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add a MSI custom actions to close and
 relaunch OpenVPN GUI
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

This custom actions are used by MSI setup to close OpenVPN GUI before
performing an upgrade and relaunch it afterwards.
---
 src/openvpnmsica/Makefile.am    |   2 +-
 src/openvpnmsica/openvpnmsica.c | 102 ++++++++++++++++++++++++++++++++
 src/openvpnmsica/openvpnmsica.h |  25 ++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index f4725a53..f00a01d8 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -41,7 +41,7 @@ libopenvpnmsica_la_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshlwapi -lversion -no-undefined -avoid-version
+libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -no-undefined -avoid-version
 endif
 
 libopenvpnmsica_la_SOURCES = \
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index e8988ac8..86434801 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -37,6 +37,7 @@
 #include <malloc.h>
 #include <memory.h>
 #include <msiquery.h>
+#include <shellapi.h>
 #include <shlwapi.h>
 #include <stdbool.h>
 #include <stdlib.h>
@@ -44,6 +45,7 @@
 
 #ifdef _MSC_VER
 #pragma comment(lib, "iphlpapi.lib")
+#pragma comment(lib, "shell32.lib")
 #pragma comment(lib, "shlwapi.lib")
 #pragma comment(lib, "version.lib")
 #endif
@@ -475,6 +477,106 @@ cleanup_CoInitialize:
 }
 
 
+UINT __stdcall
+CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+    UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with MSI session (report errors, access properties, tables, etc.). */
+
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+
+    /* Find OpenVPN GUI window. */
+    HWND hWnd = FindWindow(TEXT("OpenVPN-GUI"), NULL);
+    if (hWnd)
+    {
+        /* Ask it to close and wait for 100ms. Unfortunately, this will succeed only for recent OpenVPN GUI that do not run elevated. */
+        SendMessage(hWnd, WM_CLOSE, 0, 0);
+        Sleep(100);
+    }
+
+    return ERROR_SUCCESS;
+}
+
+
+UINT __stdcall
+StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    openvpnmsica_debug_popup(TEXT(__FUNCTION__));
+
+    UINT uiResult;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall = hInstall;
+
+    /* Create and populate a MSI record. */
+    MSIHANDLE hRecord = MsiCreateRecord(1);
+    if (!hRecord)
+    {
+        uiResult = ERROR_INVALID_HANDLE;
+        msg(M_NONFATAL, "%s: MsiCreateRecord failed", __FUNCTION__);
+        goto cleanup_CoInitialize;
+    }
+    uiResult = MsiRecordSetString(hRecord, 0, TEXT("\"[#bin.openvpn_gui.exe]\""));
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiRecordSetString() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiRecordSetString failed", __FUNCTION__);
+        goto cleanup_MsiCreateRecord;
+    }
+
+    /* Format string. */
+    TCHAR szStackBuf[MAX_PATH];
+    DWORD dwPathSize = _countof(szStackBuf);
+    LPTSTR szPath = szStackBuf;
+    uiResult = MsiFormatRecord(hInstall, hRecord, szPath, &dwPathSize);
+    if (uiResult == ERROR_MORE_DATA)
+    {
+        /* Allocate buffer on heap (+1 for terminator), and retry. */
+        szPath = (LPTSTR)malloc((++dwPathSize) * sizeof(TCHAR));
+        uiResult = MsiFormatRecord(hInstall, hRecord, szPath, &dwPathSize);
+    }
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiFormatRecord() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiFormatRecord failed", __FUNCTION__);
+        goto cleanup_malloc_szPath;
+    }
+
+    /* Launch the OpenVPN GUI. */
+    SHELLEXECUTEINFO sei = {
+        .cbSize = sizeof(SHELLEXECUTEINFO),
+        .fMask  = SEE_MASK_FLAG_NO_UI, /* Don't show error UI, we'll display it. */
+        .lpFile = szPath,
+        .nShow  = SW_SHOWNORMAL
+    };
+    if (!ShellExecuteEx(&sei))
+    {
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: ShellExecuteEx(%s) failed", __FUNCTION__, szPath);
+        goto cleanup_malloc_szPath;
+    }
+
+    uiResult = ERROR_SUCCESS;
+
+cleanup_malloc_szPath:
+    if (szPath != szStackBuf)
+        free(szPath);
+cleanup_MsiCreateRecord:
+    MsiCloseHandle(hRecord);
+cleanup_CoInitialize:
+    if (bIsCoInitialized) CoUninitialize();
+    return uiResult;
+}
+
+
 UINT __stdcall
 EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 {
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index da145062..4ee5c05f 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -91,6 +91,31 @@ DLLEXP_DECL UINT __stdcall
 FindTAPInterfaces(_In_ MSIHANDLE hInstall);
 
 
+/**
+ * Find OpenVPN GUI window and send it a WM_CLOSE message.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+DLLEXP_DECL UINT __stdcall
+CloseOpenVPNGUI(_In_ MSIHANDLE hInstall);
+
+
+/**
+ * Launches OpenVPN GUI. It's path is obtained by expanding the `[#bin.openvpn_gui.exe]`
+ * therefore, its Id field in File table must be "bin.openvpn_gui.exe".
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+DLLEXP_DECL UINT __stdcall
+StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
+
+
 /**
  * Evaluate the TAPInterface table of the MSI package database and prepare a list of TAP
  * interfaces to install/remove.
-- 
2.19.0.windows.1


