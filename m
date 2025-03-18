From: Gert Doering <gert@...1296...>
Date: Tue, 18 Mar 2025 18:23:42 +0100
Message-ID: <20250318172350.20996-1-gert@...1296...>
In-Reply-To: <gerrit.1736341120000.I8f53c49b885c7c9e36a78ca434ec021e6dc347e0@...2715...>
References: <gerrit.1736341120000.I8f53c49b885c7c9e36a78ca434ec021e6dc347e0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Apply text-removal.sh script to Windows
 codebase
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

From: Frank Lichtenheld <frank@...2641...>

Change-Id: I8f53c49b885c7c9e36a78ca434ec021e6dc347e0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/853
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index e737956..daade91 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -32,7 +32,7 @@
 #pragma comment(lib, "msi.lib")
 #endif
 #include <stdio.h>
-#include <tchar.h>
+#include <wchar.h>
 
 
 DWORD openvpnmsica_thread_data_idx = TLS_OUT_OF_INDEXES;
@@ -160,13 +160,13 @@
         MsiRecordSetInteger(hRecordProg, 3, dwResult);
 
         /* Field 4: The Windows error description. */
-        LPTSTR szErrMessage = NULL;
+        LPWSTR szErrMessage = NULL;
         if (FormatMessage(
                 FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
                 0,
                 dwResult,
                 0,
-                (LPTSTR)&szErrMessage,
+                (LPWSTR)&szErrMessage,
                 0,
                 NULL) && szErrMessage)
         {
@@ -175,7 +175,7 @@
             {
                 if (szErrMessage[i])
                 {
-                    if (!_istspace(szErrMessage[i]))
+                    if (!iswspace(szErrMessage[i]))
                     {
                         i_last = i + 1;
                     }
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index 7c60983..ce1c69a 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -54,9 +54,9 @@
 void
 msica_arg_seq_add_head(
     _Inout_ struct msica_arg_seq *seq,
-    _In_z_ LPCTSTR argument)
+    _In_z_ LPCWSTR argument)
 {
-    size_t argument_size = (_tcslen(argument) + 1) * sizeof(TCHAR);
+    size_t argument_size = (wcslen(argument) + 1) * sizeof(WCHAR);
     struct msica_arg *p = malloc(sizeof(struct msica_arg) + argument_size);
     if (p == NULL)
     {
@@ -75,9 +75,9 @@
 void
 msica_arg_seq_add_tail(
     _Inout_ struct msica_arg_seq *seq,
-    _Inout_ LPCTSTR argument)
+    _Inout_ LPCWSTR argument)
 {
-    size_t argument_size = (_tcslen(argument) + 1) * sizeof(TCHAR);
+    size_t argument_size = (wcslen(argument) + 1) * sizeof(WCHAR);
     struct msica_arg *p = malloc(sizeof(struct msica_arg) + argument_size);
     if (p == NULL)
     {
@@ -90,19 +90,19 @@
 }
 
 
-LPTSTR
+LPWSTR
 msica_arg_seq_join(_In_ const struct msica_arg_seq *seq)
 {
     /* Count required space. */
     size_t size = 2 /*x + zero-terminator*/;
     for (struct msica_arg *p = seq->head; p != NULL; p = p->next)
     {
-        size += _tcslen(p->val) + 1 /*space delimiter|zero-terminator*/;
+        size += wcslen(p->val) + 1 /*space delimiter|zero-terminator*/;
     }
-    size *= sizeof(TCHAR);
+    size *= sizeof(WCHAR);
 
     /* Allocate. */
-    LPTSTR str = malloc(size);
+    LPWSTR str = malloc(size);
     if (str == NULL)
     {
         msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, size);
@@ -115,18 +115,18 @@
 #endif
 
     /* Dummy argv[0] (i.e. executable name), for CommandLineToArgvW to work correctly when parsing this string. */
-    _tcscpy(str, TEXT("x"));
+    wcscpy(str, L"x");
 
     /* Join. */
-    LPTSTR s = str + 1 /*x*/;
+    LPWSTR s = str + 1 /*x*/;
     for (struct msica_arg *p = seq->head; p != NULL; p = p->next)
     {
         /* Convert zero-terminator into space delimiter. */
-        s[0] = TEXT(' ');
+        s[0] = L' ';
         s++;
         /* Append argument. */
-        _tcscpy(s, p->val);
-        s += _tcslen(p->val);
+        wcscpy(s, p->val);
+        s += wcslen(p->val);
     }
 
 #ifdef _MSC_VER
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index cec046f..43f2b5b 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -22,7 +22,7 @@
 #define MSICA_ARG_H
 
 #include <windows.h>
-#include <tchar.h>
+#include <wchar.h>
 #include "../tapctl/basic.h"
 
 
@@ -38,7 +38,7 @@
 struct msica_arg
 {
     struct msica_arg *next; /**< Pointer to the next argument in the sequence */
-    TCHAR val[];            /**< Zero terminated argument string */
+    WCHAR val[];            /**< Zero terminated argument string */
 };
 
 
@@ -80,7 +80,7 @@
 void
 msica_arg_seq_add_head(
     _Inout_ struct msica_arg_seq *seq,
-    _In_z_ LPCTSTR argument);
+    _In_z_ LPCWSTR argument);
 
 
 /**
@@ -93,7 +93,7 @@
 void
 msica_arg_seq_add_tail(
     _Inout_ struct msica_arg_seq *seq,
-    _Inout_ LPCTSTR argument);
+    _Inout_ LPCWSTR argument);
 
 /**
  * Join arguments of the argument sequence into a space delimited string
@@ -102,7 +102,7 @@
  *
  * @return Joined argument string. Must be released with free() after use.
  */
-LPTSTR
+LPWSTR
 msica_arg_seq_join(_In_ const struct msica_arg_seq *seq);
 
 #ifdef _MSC_VER
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index e29a60d..685fc60 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -37,8 +37,8 @@
 UINT
 msi_get_string(
     _In_ MSIHANDLE hInstall,
-    _In_z_ LPCTSTR szName,
-    _Out_ LPTSTR *pszValue)
+    _In_z_ LPCWSTR szName,
+    _Out_ LPWSTR *pszValue)
 {
     if (pszValue == NULL)
     {
@@ -46,29 +46,29 @@
     }
 
     /* Try with stack buffer first. */
-    TCHAR szBufStack[128];
+    WCHAR szBufStack[128];
     DWORD dwLength = _countof(szBufStack);
     UINT uiResult = MsiGetProperty(hInstall, szName, szBufStack, &dwLength);
     if (uiResult == ERROR_SUCCESS)
     {
         /* Copy from stack. */
-        *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", dwLength * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
-        memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
+        memcpy(*pszValue, szBufStack, dwLength * sizeof(WCHAR));
         return ERROR_SUCCESS;
     }
     else if (uiResult == ERROR_MORE_DATA)
     {
         /* Allocate on heap and retry. */
-        LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        LPWSTR szBufHeap = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -96,7 +96,7 @@
 msi_get_record_string(
     _In_ MSIHANDLE hRecord,
     _In_ unsigned int iField,
-    _Out_ LPTSTR *pszValue)
+    _Out_ LPWSTR *pszValue)
 {
     if (pszValue == NULL)
     {
@@ -104,29 +104,29 @@
     }
 
     /* Try with stack buffer first. */
-    TCHAR szBufStack[128];
+    WCHAR szBufStack[128];
     DWORD dwLength = _countof(szBufStack);
     UINT uiResult = MsiRecordGetString(hRecord, iField, szBufStack, &dwLength);
     if (uiResult == ERROR_SUCCESS)
     {
         /* Copy from stack. */
-        *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
-        memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
+        memcpy(*pszValue, szBufStack, dwLength * sizeof(WCHAR));
         return ERROR_SUCCESS;
     }
     else if (uiResult == ERROR_MORE_DATA)
     {
         /* Allocate on heap and retry. */
-        LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        LPWSTR szBufHeap = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -154,7 +154,7 @@
 msi_format_record(
     _In_ MSIHANDLE hInstall,
     _In_ MSIHANDLE hRecord,
-    _Out_ LPTSTR *pszValue)
+    _Out_ LPWSTR *pszValue)
 {
     if (pszValue == NULL)
     {
@@ -162,29 +162,29 @@
     }
 
     /* Try with stack buffer first. */
-    TCHAR szBufStack[128];
+    WCHAR szBufStack[128];
     DWORD dwLength = _countof(szBufStack);
     UINT uiResult = MsiFormatRecord(hInstall, hRecord, szBufStack, &dwLength);
     if (uiResult == ERROR_SUCCESS)
     {
         /* Copy from stack. */
-        *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
-        memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
+        memcpy(*pszValue, szBufStack, dwLength * sizeof(WCHAR));
         return ERROR_SUCCESS;
     }
     else if (uiResult == ERROR_MORE_DATA)
     {
         /* Allocate on heap and retry. */
-        LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        LPWSTR szBufHeap = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -213,7 +213,7 @@
     _In_ MSIHANDLE hInstall,
     _In_ MSIHANDLE hRecord,
     _In_ unsigned int iField,
-    _Out_ LPTSTR *pszValue)
+    _Out_ LPWSTR *pszValue)
 {
     if (pszValue == NULL)
     {
@@ -221,7 +221,7 @@
     }
 
     /* Read string to format. */
-    LPTSTR szValue = NULL;
+    LPWSTR szValue = NULL;
     UINT uiResult = msi_get_record_string(hRecord, iField, &szValue);
     if (uiResult != ERROR_SUCCESS)
     {
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index 6d84de5..557ac98 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -41,8 +41,8 @@
 UINT
 msi_get_string(
     _In_ MSIHANDLE hInstall,
-    _In_z_ LPCTSTR szName,
-    _Out_ LPTSTR *pszValue);
+    _In_z_ LPCWSTR szName,
+    _Out_ LPWSTR *pszValue);
 
 
 /**
@@ -61,7 +61,7 @@
 msi_get_record_string(
     _In_ MSIHANDLE hRecord,
     _In_ unsigned int iField,
-    _Out_ LPTSTR *pszValue);
+    _Out_ LPWSTR *pszValue);
 
 
 /**
@@ -83,7 +83,7 @@
 msi_format_record(
     _In_ MSIHANDLE hInstall,
     _In_ MSIHANDLE hRecord,
-    _Out_ LPTSTR *pszValue);
+    _Out_ LPWSTR *pszValue);
 
 
 /**
@@ -107,6 +107,6 @@
     _In_ MSIHANDLE hInstall,
     _In_ MSIHANDLE hRecord,
     _In_ unsigned int iField,
-    _Out_ LPTSTR *pszValue);
+    _Out_ LPWSTR *pszValue);
 
 #endif /* ifndef MSIHLP_H */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 17152e0..30db644 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -40,7 +40,7 @@
 #include <shlwapi.h>
 #include <stdbool.h>
 #include <stdlib.h>
-#include <tchar.h>
+#include <wchar.h>
 #include <setupapi.h>
 #include <newdev.h>
 #include <initguid.h>
@@ -80,11 +80,11 @@
 static UINT
 setup_sequence(
     _In_ MSIHANDLE hInstall,
-    _In_z_ LPCTSTR szProperty,
+    _In_z_ LPCWSTR szProperty,
     _In_ struct msica_arg_seq *seq)
 {
     UINT uiResult;
-    LPTSTR szSequence = msica_arg_seq_join(seq);
+    LPWSTR szSequence = msica_arg_seq_join(seq);
     uiResult = MsiSetProperty(hInstall, szProperty, szSequence);
     free(szSequence);
     if (uiResult != ERROR_SUCCESS)
@@ -92,7 +92,7 @@
         /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error
          * code. Set last error manually. */
         SetLastError(uiResult);
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szProperty);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%ls\") failed", __FUNCTION__, szProperty);
         return uiResult;
     }
     return ERROR_SUCCESS;
@@ -111,27 +111,27 @@
 static void
 _debug_popup(_In_z_ LPCSTR szFunctionName)
 {
-    TCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
+    WCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
 
     /* Compose pop-up title. The dialog title will contain function name to ease the process
      * locating. Mind that Visual Studio displays window titles on the process list. */
-    _stprintf_s(szTitle, _countof(szTitle), TEXT("%hs v%") TEXT(PRIsLPTSTR),
-                szFunctionName, TEXT(PACKAGE_VERSION));
+    swprintf_s(szTitle, _countof(szTitle), L"%hs v%ls",
+               szFunctionName, _L(PACKAGE_VERSION));
 
     /* Get process name. */
     GetModuleFileName(NULL, szProcessPath, _countof(szProcessPath));
-    LPCTSTR szProcessName = _tcsrchr(szProcessPath, TEXT('\\'));
+    LPCWSTR szProcessName = wcsrchr(szProcessPath, L'\\');
     szProcessName = szProcessName ? szProcessName + 1 : szProcessPath;
 
     /* Compose the pop-up message. */
-    _stprintf_s(
+    swprintf_s(
         szMessage, _countof(szMessage),
-        TEXT("The %") TEXT(PRIsLPTSTR) TEXT(" process (PID: %u) has started to execute the %hs")
-        TEXT(" custom action.\r\n")
-        TEXT("\r\n")
-        TEXT("If you would like to debug the custom action, attach a debugger to this process and set breakpoints before dismissing this dialog.\r\n")
-        TEXT("\r\n")
-        TEXT("If you are not debugging this custom action, you can safely ignore this message."),
+        L"The %ls process (PID: %u) has started to execute the %hs"
+        L" custom action.\r\n"
+        L"\r\n"
+        L"If you would like to debug the custom action, attach a debugger to this process and set breakpoints before dismissing this dialog.\r\n"
+        L"\r\n"
+        L"If you are not debugging this custom action, you can safely ignore this message.",
         szProcessName,
         GetCurrentProcessId(),
         szFunctionName);
@@ -147,9 +147,9 @@
 static void
 find_adapters(
     _In_ MSIHANDLE hInstall,
-    _In_z_ LPCTSTR szzHardwareIDs,
-    _In_z_ LPCTSTR szAdaptersPropertyName,
-    _In_z_ LPCTSTR szActiveAdaptersPropertyName)
+    _In_z_ LPCWSTR szzHardwareIDs,
+    _In_z_ LPCWSTR szAdaptersPropertyName,
+    _In_z_ LPCWSTR szActiveAdaptersPropertyName)
 {
     UINT uiResult;
 
@@ -207,28 +207,28 @@
     }
 
     /* Prepare semicolon delimited list of TAP adapter ID(s) and active TAP adapter ID(s). */
-    LPTSTR
-        szAdapters     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+    LPWSTR
+        szAdapters     = (LPWSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR)),
         szAdaptersTail = szAdapters;
     if (szAdapters == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));
         uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
     }
 
-    LPTSTR
-        szAdaptersActive     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+    LPWSTR
+        szAdaptersActive     = (LPWSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR)),
         szAdaptersActiveTail = szAdaptersActive;
     if (szAdaptersActive == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));
         uiResult = ERROR_OUTOFMEMORY; goto cleanup_szAdapters;
     }
 
     for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
     {
         /* exclude adapters created by OpenVPN Connect, since they're removed on Connect uninstallation */
-        if (_tcsstr(pAdapter->szName, OPENVPN_CONNECT_ADAPTER_SUBSTR))
+        if (wcsstr(pAdapter->szName, OPENVPN_CONNECT_ADAPTER_SUBSTR))
         {
             msg(M_WARN, "%s: skip OpenVPN Connect adapter '%ls'", __FUNCTION__, pAdapter->szName);
             continue;
@@ -241,9 +241,9 @@
         /* Append to the list of TAP adapter ID(s). */
         if (szAdapters < szAdaptersTail)
         {
-            *(szAdaptersTail++) = TEXT(';');
+            *(szAdaptersTail++) = L';';
         }
-        memcpy(szAdaptersTail, szAdapterId, 38 * sizeof(TCHAR));
+        memcpy(szAdaptersTail, szAdapterId, 38 * sizeof(WCHAR));
         szAdaptersTail += 38;
 
         /* If this adapter is active (connected), add it to the list of active TAP adapter ID(s). */
@@ -260,9 +260,9 @@
                     /* This TAP adapter is active (connected). */
                     if (szAdaptersActive < szAdaptersActiveTail)
                     {
-                        *(szAdaptersActiveTail++) = TEXT(';');
+                        *(szAdaptersActiveTail++) = L';';
                     }
-                    memcpy(szAdaptersActiveTail, szAdapterId, 38 * sizeof(TCHAR));
+                    memcpy(szAdaptersActiveTail, szAdapterId, 38 * sizeof(WCHAR));
                     szAdaptersActiveTail += 38;
                 }
                 break;
@@ -315,19 +315,19 @@
 
     find_adapters(
         hInstall,
-        TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0"),
-        TEXT("TAPWINDOWS6ADAPTERS"),
-        TEXT("ACTIVETAPWINDOWS6ADAPTERS"));
+        L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0" _L(TAP_WIN_COMPONENT_ID) L"\0",
+        L"TAPWINDOWS6ADAPTERS",
+        L"ACTIVETAPWINDOWS6ADAPTERS");
     find_adapters(
         hInstall,
-        TEXT("Wintun") TEXT("\0"),
-        TEXT("WINTUNADAPTERS"),
-        TEXT("ACTIVEWINTUNADAPTERS"));
+        L"Wintun" L"\0",
+        L"WINTUNADAPTERS",
+        L"ACTIVEWINTUNADAPTERS");
     find_adapters(
         hInstall,
-        TEXT("ovpn-dco") TEXT("\0"),
-        TEXT("OVPNDCOADAPTERS"),
-        TEXT("ACTIVEOVPNDCOADAPTERS"));
+        L"ovpn-dco" L"\0",
+        L"OVPNDCOADAPTERS",
+        L"ACTIVEOVPNDCOADAPTERS");
 
     if (bIsCoInitialized)
     {
@@ -348,7 +348,7 @@
     debug_popup(__FUNCTION__);
 
     /* Find OpenVPN GUI window. */
-    HWND hWnd = FindWindow(TEXT("OpenVPN-GUI"), NULL);
+    HWND hWnd = FindWindow(L"OpenVPN-GUI", NULL);
     if (hWnd)
     {
         /* Ask it to close and wait for 100ms. Unfortunately, this will succeed only for recent OpenVPN GUI that do not run elevated. */
@@ -382,7 +382,7 @@
         msg(M_NONFATAL, "%s: MsiCreateRecord failed", __FUNCTION__);
         goto cleanup_CoInitialize;
     }
-    uiResult = MsiRecordSetString(hRecord, 0, TEXT("\"[#bin.openvpn_gui.exe]\""));
+    uiResult = MsiRecordSetString(hRecord, 0, L"\"[#bin.openvpn_gui.exe]\"");
     if (uiResult != ERROR_SUCCESS)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiRecordSetString() to set GetLastError(). But we do have an error code. Set last error manually. */
@@ -391,17 +391,17 @@
     }
 
     /* Format string. */
-    TCHAR szStackBuf[MAX_PATH];
+    WCHAR szStackBuf[MAX_PATH];
     DWORD dwPathSize = _countof(szStackBuf);
-    LPTSTR szPath = szStackBuf;
+    LPWSTR szPath = szStackBuf;
     uiResult = MsiFormatRecord(hInstall, hRecord, szPath, &dwPathSize);
     if (uiResult == ERROR_MORE_DATA)
     {
         /* Allocate buffer on heap (+1 for terminator), and retry. */
-        szPath = (LPTSTR)malloc((++dwPathSize) * sizeof(TCHAR));
+        szPath = (LPWSTR)malloc((++dwPathSize) * sizeof(WCHAR));
         if (szPath == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwPathSize * sizeof(TCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwPathSize * sizeof(WCHAR));
             uiResult = ERROR_OUTOFMEMORY; goto cleanup_MsiCreateRecord;
         }
 
@@ -470,8 +470,8 @@
 schedule_adapter_create(
     _Inout_ struct msica_arg_seq *seq,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
-    _In_z_ LPCTSTR szDisplayName,
-    _In_z_ LPCTSTR szHardwareId,
+    _In_z_ LPCWSTR szDisplayName,
+    _In_z_ LPCWSTR szHardwareId,
     _Inout_ int *iTicks)
 {
     /* Get existing network adapters. */
@@ -488,12 +488,12 @@
         if (pAdapterOther == NULL)
         {
             /* No adapter with a same name found. */
-            TCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*|*/ + MAX_PATH /*szHardwareId*/ + 1 /*terminator*/];
+            WCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*|*/ + MAX_PATH /*szHardwareId*/ + 1 /*terminator*/];
 
             /* InstallTUNTAPAdapters will create the adapter. */
-            _stprintf_s(
+            swprintf_s(
                 szArgument, _countof(szArgument),
-                TEXT("create=\"%.*s|%.*s\""),
+                L"create=\"%.*s|%.*s\"",
                 MAX_PATH, szDisplayName,
                 MAX_PATH, szHardwareId);
             msica_arg_seq_add_tail(seq, szArgument);
@@ -501,9 +501,9 @@
             if (seqRollback)
             {
                 /* InstallTUNTAPAdaptersRollback will delete the adapter. */
-                _stprintf_s(
+                swprintf_s(
                     szArgument, _countof(szArgument),
-                    TEXT("deleteN=\"%.*s\""),
+                    L"deleteN=\"%.*s\"",
                     MAX_PATH, szDisplayName);
                 msica_arg_seq_add_head(seqRollback, szArgument);
             }
@@ -511,19 +511,19 @@
             *iTicks += MSICA_ADAPTER_TICK_SIZE;
             break;
         }
-        else if (_tcsicmp(szDisplayName, pAdapterOther->szName) == 0)
+        else if (wcsicmp(szDisplayName, pAdapterOther->szName) == 0)
         {
             /* Adapter with a same name found. */
-            for (LPCTSTR hwid = pAdapterOther->szzHardwareIDs;; hwid += _tcslen(hwid) + 1)
+            for (LPCWSTR hwid = pAdapterOther->szzHardwareIDs;; hwid += wcslen(hwid) + 1)
             {
                 if (hwid[0] == 0)
                 {
                     /* This adapter has a different hardware ID. */
-                    msg(M_NONFATAL, "%s: Adapter with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pAdapterOther->szName);
+                    msg(M_NONFATAL, "%s: Adapter with name \"%ls\" already exists", __FUNCTION__, pAdapterOther->szName);
                     dwResult = ERROR_ALREADY_EXISTS;
                     goto cleanup_pAdapterList;
                 }
-                else if (_tcsicmp(hwid, szHardwareId) == 0)
+                else if (wcsicmp(hwid, szHardwareId) == 0)
                 {
                     /* This is an adapter with the requested hardware ID. We already have what we want! */
                     break;
@@ -571,8 +571,8 @@
     _Inout_ struct msica_arg_seq *seq,
     _Inout_opt_ struct msica_arg_seq *seqCommit,
     _Inout_opt_ struct msica_arg_seq *seqRollback,
-    _In_z_ LPCTSTR szDisplayName,
-    _In_z_ LPCTSTR szzHardwareIDs,
+    _In_z_ LPCWSTR szDisplayName,
+    _In_z_ LPCWSTR szzHardwareIDs,
     _Inout_ int *iTicks)
 {
     /* Get adapters with given hardware ID. */
@@ -586,39 +586,39 @@
     /* Does adapter exist? */
     for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
     {
-        if (_tcsicmp(szDisplayName, pAdapter->szName) == 0)
+        if (wcsicmp(szDisplayName, pAdapter->szName) == 0)
         {
             /* Adapter found. */
-            TCHAR szArgument[8 /*disable=|enable=|delete=*/ + 38 /*{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}*/ + 1 /*terminator*/];
+            WCHAR szArgument[8 /*disable=|enable=|delete=*/ + 38 /*{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}*/ + 1 /*terminator*/];
             if (seqCommit && seqRollback)
             {
                 /* UninstallTUNTAPAdapters will disable the adapter. */
-                _stprintf_s(
+                swprintf_s(
                     szArgument, _countof(szArgument),
-                    TEXT("disable=") TEXT(PRIXGUID),
+                    L"disable=" _L(PRIXGUID),
                     PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seq, szArgument);
 
                 /* UninstallTUNTAPAdaptersRollback will re-enable the adapter. */
-                _stprintf_s(
+                swprintf_s(
                     szArgument, _countof(szArgument),
-                    TEXT("enable=") TEXT(PRIXGUID),
+                    L"enable=" _L(PRIXGUID),
                     PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_head(seqRollback, szArgument);
 
                 /* UninstallTUNTAPAdaptersCommit will delete the adapter. */
-                _stprintf_s(
+                swprintf_s(
                     szArgument, _countof(szArgument),
-                    TEXT("delete=") TEXT(PRIXGUID),
+                    L"delete=" _L(PRIXGUID),
                     PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seqCommit, szArgument);
             }
             else
             {
                 /* UninstallTUNTAPAdapters will delete the adapter. */
-                _stprintf_s(
+                swprintf_s(
                     szArgument, _countof(szArgument),
-                    TEXT("delete=") TEXT(PRIXGUID),
+                    L"delete=" _L(PRIXGUID),
                     PRIGUID_PARAM(pAdapter->guid));
                 msica_arg_seq_add_tail(seq, szArgument);
             }
@@ -662,7 +662,7 @@
     msica_arg_seq_init(&seqUninstallRollback);
 
     /* Check rollback state. */
-    bool bRollbackEnabled = MsiEvaluateCondition(hInstall, TEXT("RollbackDisabled")) != MSICONDITION_TRUE;
+    bool bRollbackEnabled = MsiEvaluateCondition(hInstall, L"RollbackDisabled") != MSICONDITION_TRUE;
 
     /* Open MSI database. */
     MSIHANDLE hDatabase = MsiGetActiveDatabase(hInstall);
@@ -674,7 +674,7 @@
     }
 
     /* Check if TUNTAPAdapter table exists. If it doesn't exist, there's nothing to do. */
-    switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TUNTAPAdapter")))
+    switch (MsiDatabaseIsTablePersistent(hDatabase, L"TUNTAPAdapter"))
     {
         case MSICONDITION_FALSE:
         case MSICONDITION_TRUE: break;
@@ -686,12 +686,12 @@
 
     /* Prepare a query to get a list/view of adapters. */
     MSIHANDLE hViewST = 0;
-    LPCTSTR szQuery = TEXT("SELECT `Adapter`,`DisplayName`,`Condition`,`Component_`,`HardwareId` FROM `TUNTAPAdapter`");
+    LPCWSTR szQuery = L"SELECT `Adapter`,`DisplayName`,`Condition`,`Component_`,`HardwareId` FROM `TUNTAPAdapter`";
     uiResult = MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
     if (uiResult != ERROR_SUCCESS)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szQuery);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup_hDatabase;
     }
 
@@ -700,7 +700,7 @@
     if (uiResult != ERROR_SUCCESS)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiViewExecute() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szQuery);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup_hViewST;
     }
 
@@ -733,7 +733,7 @@
         INSTALLSTATE iInstalled, iAction;
         {
             /* Read adapter component ID (`Component_` is field #4). */
-            LPTSTR szValue = NULL;
+            LPWSTR szValue = NULL;
             uiResult = msi_get_record_string(hRecord, 4, &szValue);
             if (uiResult != ERROR_SUCCESS)
             {
@@ -745,7 +745,7 @@
             if (uiResult != ERROR_SUCCESS)
             {
                 SetLastError(uiResult); /* MSDN does not mention MsiGetComponentState() to set GetLastError(). But we do have an error code. Set last error manually. */
-                msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szValue);
+                msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%ls\") failed", __FUNCTION__, szValue);
                 free(szValue);
                 goto cleanup_hRecord;
             }
@@ -753,26 +753,26 @@
         }
 
         /* Get adapter display name (`DisplayName` is field #2). */
-        LPTSTR szDisplayName = NULL;
+        LPWSTR szDisplayName = NULL;
         uiResult = msi_format_field(hInstall, hRecord, 2, &szDisplayName);
         if (uiResult != ERROR_SUCCESS)
         {
             goto cleanup_hRecord;
         }
         /* `DisplayName` field type is [Filename](https://docs.microsoft.com/en-us/windows/win32/msi/filename), which is either "8.3|long name" or "8.3". */
-        LPTSTR szDisplayNameEx = _tcschr(szDisplayName, TEXT('|'));
+        LPWSTR szDisplayNameEx = wcschr(szDisplayName, L'|');
         szDisplayNameEx = szDisplayNameEx != NULL ? szDisplayNameEx + 1 : szDisplayName;
 
         /* Get adapter hardware ID (`HardwareId` is field #5). */
-        TCHAR szzHardwareIDs[0x100] = { 0 };
+        WCHAR szzHardwareIDs[0x100] = { 0 };
         {
-            LPTSTR szHwId = NULL;
+            LPWSTR szHwId = NULL;
             uiResult = msi_get_record_string(hRecord, 5, &szHwId);
             if (uiResult != ERROR_SUCCESS)
             {
                 goto cleanup_szDisplayName;
             }
-            memcpy_s(szzHardwareIDs, sizeof(szzHardwareIDs) - 2*sizeof(TCHAR) /*requires double zero termination*/, szHwId, _tcslen(szHwId)*sizeof(TCHAR));
+            memcpy_s(szzHardwareIDs, sizeof(szzHardwareIDs) - 2*sizeof(WCHAR) /*requires double zero termination*/, szHwId, wcslen(szHwId)*sizeof(WCHAR));
             free(szHwId);
         }
 
@@ -783,7 +783,7 @@
             if (iAction >= INSTALLSTATE_LOCAL)
             {
                 /* Read and evaluate adapter condition (`Condition` is field #3). */
-                LPTSTR szValue = NULL;
+                LPWSTR szValue = NULL;
                 uiResult = msi_get_record_string(hRecord, 3, &szValue);
                 if (uiResult != ERROR_SUCCESS)
                 {
@@ -805,7 +805,7 @@
 
                     case MSICONDITION_ERROR:
                         uiResult = ERROR_INVALID_FIELD;
-                        msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szValue);
+                        msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%ls\") failed", __FUNCTION__, szValue);
                         free(szValue);
                         goto cleanup_szDisplayName;
                 }
@@ -864,11 +864,11 @@
     }
 
     /* save path to user's temp dir to be used later by deferred actions */
-    TCHAR tmpDir[MAX_PATH];
+    WCHAR tmpDir[MAX_PATH];
     GetTempPath(MAX_PATH, tmpDir);
 
-    TCHAR str[MAX_PATH + 7];
-    _stprintf_s(str, _countof(str), TEXT("tmpdir=%") TEXT(PRIsLPTSTR), tmpDir);
+    WCHAR str[MAX_PATH + 7];
+    swprintf_s(str, _countof(str), L"tmpdir=%ls", tmpDir);
     msica_arg_seq_add_tail(&seqInstall, str);
     msica_arg_seq_add_tail(&seqInstallCommit, str);
     msica_arg_seq_add_tail(&seqInstallRollback, str);
@@ -877,12 +877,12 @@
     msica_arg_seq_add_tail(&seqUninstallRollback, str);
 
     /* Store deferred custom action parameters. */
-    if ((uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdapters"          ), &seqInstall          )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdaptersCommit"    ), &seqInstallCommit    )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdaptersRollback"  ), &seqInstallRollback  )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTUNTAPAdapters"        ), &seqUninstall        )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTUNTAPAdaptersCommit"  ), &seqUninstallCommit  )) != ERROR_SUCCESS
-        || (uiResult = setup_sequence(hInstall, TEXT("UninstallTUNTAPAdaptersRollback"), &seqUninstallRollback)) != ERROR_SUCCESS)
+    if ((uiResult = setup_sequence(hInstall, L"InstallTUNTAPAdapters", &seqInstall          )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, L"InstallTUNTAPAdaptersCommit", &seqInstallCommit    )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, L"InstallTUNTAPAdaptersRollback", &seqInstallRollback  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, L"UninstallTUNTAPAdapters", &seqUninstall        )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, L"UninstallTUNTAPAdaptersCommit", &seqUninstallCommit  )) != ERROR_SUCCESS
+        || (uiResult = setup_sequence(hInstall, L"UninstallTUNTAPAdaptersRollback", &seqUninstallRollback)) != ERROR_SUCCESS)
     {
         goto cleanup_hRecordProg;
     }
@@ -1027,7 +1027,7 @@
             {
                 /* Report the name of the adapter to installer. */
                 MSIHANDLE hRecord = MsiCreateRecord(4);
-                MsiRecordSetString(hRecord, 1, TEXT("Creating adapter"));
+                MsiRecordSetString(hRecord, 1, L"Creating adapter");
                 MsiRecordSetString(hRecord, 2, szName);
                 MsiRecordSetString(hRecord, 3, szHardwareId);
                 int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
@@ -1056,7 +1056,7 @@
             {
                 /* Report the name of the adapter to installer. */
                 MSIHANDLE hRecord = MsiCreateRecord(3);
-                MsiRecordSetString(hRecord, 1, TEXT("Deleting adapter"));
+                MsiRecordSetString(hRecord, 1, L"Deleting adapter");
                 MsiRecordSetString(hRecord, 2, szName);
                 int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
                 MsiCloseHandle(hRecord);
@@ -1075,7 +1075,7 @@
                 /* Does the adapter exist? */
                 for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL; pAdapter = pAdapter->pNext)
                 {
-                    if (_tcsicmp(szName, pAdapter->szName) == 0)
+                    if (wcsicmp(szName, pAdapter->szName) == 0)
                     {
                         /* Adapter found. */
                         dwResult = tap_delete_adapter(NULL, &pAdapter->guid, &bRebootRequired);
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 74bec6e..39b39aa 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -24,11 +24,11 @@
 #include "service.h"
 #include "validate.h"
 
-LPCTSTR service_instance = TEXT("");
+LPCWSTR service_instance = L"";
 static wchar_t win_sys_path[MAX_PATH];
 
 static DWORD
-GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
+GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)
 {
     LONG status = RegGetValue(key, NULL, value, RRF_RT_REG_SZ,
                               NULL, (LPBYTE) data, &size);
@@ -45,7 +45,7 @@
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Error querying registry value: HKLM\\SOFTWARE\\") TEXT(PACKAGE_NAME) TEXT("%ls\\%ls"), service_instance, value);
+        return MsgToEventLog(M_SYSERR, L"Error querying registry value: HKLM\\SOFTWARE\\" _L(PACKAGE_NAME) L"%ls\\%ls", service_instance, value);
     }
 
     return ERROR_SUCCESS;
@@ -55,21 +55,21 @@
 DWORD
 GetOpenvpnSettings(settings_t *s)
 {
-    TCHAR reg_path[256];
-    TCHAR priority[64];
-    TCHAR append[2];
+    WCHAR reg_path[256];
+    WCHAR priority[64];
+    WCHAR append[2];
     DWORD error;
     HKEY key;
-    TCHAR install_path[MAX_PATH];
-    TCHAR default_value[MAX_PATH];
+    WCHAR install_path[MAX_PATH];
+    WCHAR default_value[MAX_PATH];
 
-    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\") TEXT(PACKAGE_NAME) TEXT("%ls"), service_instance);
+    swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" _L(PACKAGE_NAME) L"%ls", service_instance);
 
     LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%ls not found"), reg_path);
+        return MsgToEventLog(M_SYSERR, L"Could not open Registry key HKLM\\%ls not found", reg_path);
     }
 
     /* The default value of REG_KEY is the install path */
@@ -80,97 +80,97 @@
         goto out;
     }
 
-    swprintf(default_value, _countof(default_value), TEXT("%ls\\bin\\openvpn.exe"),
+    swprintf(default_value, _countof(default_value), L"%ls\\bin\\openvpn.exe",
              install_path);
-    error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), default_value);
+    error = GetRegString(key, L"exe_path", s->exe_path, sizeof(s->exe_path), default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    swprintf(default_value, _countof(default_value), TEXT("%ls\\config"), install_path);
-    error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir),
+    swprintf(default_value, _countof(default_value), L"%ls\\config", install_path);
+    error = GetRegString(key, L"config_dir", s->config_dir, sizeof(s->config_dir),
                          default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("config_ext"), s->ext_string, sizeof(s->ext_string),
-                         TEXT(".ovpn"));
+    error = GetRegString(key, L"config_ext", s->ext_string, sizeof(s->ext_string),
+                         L".ovpn");
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    swprintf(default_value, _countof(default_value), TEXT("%ls\\log"), install_path);
-    error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), default_value);
+    swprintf(default_value, _countof(default_value), L"%ls\\log", install_path);
+    error = GetRegString(key, L"log_dir", s->log_dir, sizeof(s->log_dir), default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("priority"), priority, sizeof(priority),
-                         TEXT("NORMAL_PRIORITY_CLASS"));
+    error = GetRegString(key, L"priority", priority, sizeof(priority),
+                         L"NORMAL_PRIORITY_CLASS");
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("log_append"), append, sizeof(append), TEXT("0"));
+    error = GetRegString(key, L"log_append", append, sizeof(append), L"0");
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
     /* read if present, else use default */
-    error = GetRegString(key, TEXT("ovpn_admin_group"), s->ovpn_admin_group,
+    error = GetRegString(key, L"ovpn_admin_group", s->ovpn_admin_group,
                          sizeof(s->ovpn_admin_group), OVPN_ADMIN_GROUP);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
     /* set process priority */
-    if (!_wcsicmp(priority, TEXT("IDLE_PRIORITY_CLASS")))
+    if (!_wcsicmp(priority, L"IDLE_PRIORITY_CLASS"))
     {
         s->priority = IDLE_PRIORITY_CLASS;
     }
-    else if (!_wcsicmp(priority, TEXT("BELOW_NORMAL_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, L"BELOW_NORMAL_PRIORITY_CLASS"))
     {
         s->priority = BELOW_NORMAL_PRIORITY_CLASS;
     }
-    else if (!_wcsicmp(priority, TEXT("NORMAL_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, L"NORMAL_PRIORITY_CLASS"))
     {
         s->priority = NORMAL_PRIORITY_CLASS;
     }
-    else if (!_wcsicmp(priority, TEXT("ABOVE_NORMAL_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, L"ABOVE_NORMAL_PRIORITY_CLASS"))
     {
         s->priority = ABOVE_NORMAL_PRIORITY_CLASS;
     }
-    else if (!_wcsicmp(priority, TEXT("HIGH_PRIORITY_CLASS")))
+    else if (!_wcsicmp(priority, L"HIGH_PRIORITY_CLASS"))
     {
         s->priority = HIGH_PRIORITY_CLASS;
     }
     else
     {
         SetLastError(ERROR_INVALID_DATA);
-        error = MsgToEventLog(M_SYSERR, TEXT("Unknown priority name: %ls"), priority);
+        error = MsgToEventLog(M_SYSERR, L"Unknown priority name: %ls", priority);
         goto out;
     }
 
     /* set log file append/truncate flag */
-    if (append[0] == TEXT('0'))
+    if (append[0] == L'0')
     {
         s->append = FALSE;
     }
-    else if (append[0] == TEXT('1'))
+    else if (append[0] == L'1')
     {
         s->append = TRUE;
     }
     else
     {
         SetLastError(ERROR_INVALID_DATA);
-        error = MsgToEventLog(M_ERR, TEXT("Log file append flag (given as '%ls') must be '0' or '1'"), append);
+        error = MsgToEventLog(M_ERR, L"Log file append flag (given as '%ls') must be '0' or '1'", append);
         goto out;
     }
 
@@ -180,13 +180,13 @@
 }
 
 
-LPCTSTR
+LPCWSTR
 GetLastErrorText(void)
 {
     DWORD error;
-    static TCHAR buf[256];
+    static WCHAR buf[256];
     DWORD len;
-    LPTSTR tmp = NULL;
+    LPWSTR tmp = NULL;
 
     error = GetLastError();
     len = FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
@@ -194,12 +194,12 @@
 
     if (len == 0 || (long) _countof(buf) < (long) len + 14)
     {
-        buf[0] = TEXT('\0');
+        buf[0] = L'\0';
     }
     else
     {
-        tmp[wcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
-        swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, error);
+        tmp[wcslen(tmp) - 2] = L'\0'; /* remove CR/LF characters */
+        swprintf(buf, _countof(buf), L"%ls (0x%x)", tmp, error);
     }
 
     if (tmp)
@@ -212,12 +212,12 @@
 
 
 DWORD
-MsgToEventLog(DWORD flags, LPCTSTR format, ...)
+MsgToEventLog(DWORD flags, LPCWSTR format, ...)
 {
     HANDLE hEventSource;
-    TCHAR msg[2][256];
+    WCHAR msg[2][256];
     DWORD error = 0;
-    LPCTSTR err_msg = TEXT("");
+    LPCWSTR err_msg = L"";
     va_list arglist;
 
     if (flags & MSG_FLAGS_SYS_CODE)
@@ -230,14 +230,14 @@
     if (hEventSource != NULL)
     {
         swprintf(msg[0], _countof(msg[0]),
-                 TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
-                 (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
+                 L"%ls%ls%ls: %ls", APPNAME, service_instance,
+                 (flags & MSG_FLAGS_ERROR) ? L" error" : L"", err_msg);
 
         va_start(arglist, format);
         vswprintf(msg[1], _countof(msg[1]), format, arglist);
         va_end(arglist);
 
-        const TCHAR *mesg[] = { msg[0], msg[1] };
+        const WCHAR *mesg[] = { msg[0], msg[1] };
         ReportEvent(hEventSource, flags & MSG_FLAGS_ERROR ?
                     EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
                     0, 0, NULL, 2, 0, mesg, NULL);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d5a749a..bc53f04 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -60,8 +60,8 @@
 
 openvpn_service_t interactive_service = {
     interactive,
-    TEXT(PACKAGE_NAME) TEXT("ServiceInteractive"),
-    TEXT(PACKAGE_NAME) TEXT(" Interactive Service"),
+    _L(PACKAGE_NAME) L"ServiceInteractive",
+    _L(PACKAGE_NAME) L" Interactive Service",
     SERVICE_DEPENDENCIES,
     SERVICE_AUTO_START
 };
@@ -462,7 +462,7 @@
     bytes = PeekNamedPipeAsync(pipe, 1, &exit_event);
     if (bytes == 0)
     {
-        MsgToEventLog(M_SYSERR, TEXT("PeekNamedPipeAsync failed"));
+        MsgToEventLog(M_SYSERR, L"PeekNamedPipeAsync failed");
         ReturnLastError(pipe, L"PeekNamedPipeAsync");
         goto err;
     }
@@ -470,7 +470,7 @@
     size = bytes / sizeof(*data);
     if (size == 0)
     {
-        MsgToEventLog(M_SYSERR, TEXT("malformed startup data: 1 byte received"));
+        MsgToEventLog(M_SYSERR, L"malformed startup data: 1 byte received");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         goto err;
     }
@@ -478,7 +478,7 @@
     data = malloc(bytes);
     if (data == NULL)
     {
-        MsgToEventLog(M_SYSERR, TEXT("malloc failed"));
+        MsgToEventLog(M_SYSERR, L"malloc failed");
         ReturnLastError(pipe, L"malloc");
         goto err;
     }
@@ -486,14 +486,14 @@
     read = ReadPipeAsync(pipe, data, bytes, 1, &exit_event);
     if (bytes != read)
     {
-        MsgToEventLog(M_SYSERR, TEXT("ReadPipeAsync failed"));
+        MsgToEventLog(M_SYSERR, L"ReadPipeAsync failed");
         ReturnLastError(pipe, L"ReadPipeAsync");
         goto err;
     }
 
     if (data[size - 1] != 0)
     {
-        MsgToEventLog(M_ERR, TEXT("Startup data is not NULL terminated"));
+        MsgToEventLog(M_ERR, L"Startup data is not NULL terminated");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         goto err;
     }
@@ -503,7 +503,7 @@
     size -= len;
     if (size <= 0)
     {
-        MsgToEventLog(M_ERR, TEXT("Startup data ends at working directory"));
+        MsgToEventLog(M_ERR, L"Startup data ends at working directory");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         goto err;
     }
@@ -513,7 +513,7 @@
     size -= len;
     if (size <= 0)
     {
-        MsgToEventLog(M_ERR, TEXT("Startup data ends at command line options"));
+        MsgToEventLog(M_ERR, L"Startup data ends at command line options");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         goto err;
     }
@@ -746,15 +746,15 @@
 static void
 BlockDNSErrHandler(DWORD err, const char *msg)
 {
-    TCHAR buf[256];
-    LPCTSTR err_str;
+    WCHAR buf[256];
+    LPCWSTR err_str;
 
     if (!err)
     {
         return;
     }
 
-    err_str = TEXT("Unknown Win32 Error");
+    err_str = L"Unknown Win32 Error";
 
     if (FormatMessage(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM
                       | FORMAT_MESSAGE_ARGUMENT_ARRAY,
@@ -796,7 +796,7 @@
     }
     else
     {
-        MsgToEventLog(M_ERR, TEXT("No previous block filters to delete"));
+        MsgToEventLog(M_ERR, L"No previous block filters to delete");
     }
 
     return err;
@@ -913,7 +913,7 @@
         WaitForSingleObject(pi.hProcess, timeout ? timeout : INFINITE);
         if (!GetExitCodeProcess(pi.hProcess, &exit_code))
         {
-            MsgToEventLog(M_SYSERR, TEXT("ExecCommand: Error getting exit_code:"));
+            MsgToEventLog(M_SYSERR, L"ExecCommand: Error getting exit_code:");
             exit_code = GetLastError();
         }
         else if (exit_code == STILL_ACTIVE)
@@ -922,17 +922,17 @@
 
             /* kill without impunity */
             TerminateProcess(pi.hProcess, exit_code);
-            MsgToEventLog(M_ERR, TEXT("ExecCommand: \"%ls %ls\" killed after timeout"),
+            MsgToEventLog(M_ERR, L"ExecCommand: \"%ls %ls\" killed after timeout",
                           argv0, cmdline);
         }
         else if (exit_code)
         {
-            MsgToEventLog(M_ERR, TEXT("ExecCommand: \"%ls %ls\" exited with status = %lu"),
+            MsgToEventLog(M_ERR, L"ExecCommand: \"%ls %ls\" exited with status = %lu",
                           argv0, cmdline, exit_code);
         }
         else
         {
-            MsgToEventLog(M_INFO, TEXT("ExecCommand: \"%ls %ls\" completed"), argv0, cmdline);
+            MsgToEventLog(M_INFO, L"ExecCommand: \"%ls %ls\" completed", argv0, cmdline);
         }
 
         CloseHandle(pi.hProcess);
@@ -941,7 +941,7 @@
     else
     {
         exit_code = GetLastError();
-        MsgToEventLog(M_SYSERR, TEXT("ExecCommand: could not run \"%ls %ls\" :"),
+        MsgToEventLog(M_SYSERR, L"ExecCommand: could not run \"%ls %ls\" :",
                       argv0, cmdline);
     }
 
@@ -986,12 +986,12 @@
         err = 0;
         if (!ReleaseSemaphore(rdns_semaphore, 1, NULL) )
         {
-            err = MsgToEventLog(M_SYSERR, TEXT("RegisterDNS: Failed to release regsiter-dns semaphore:"));
+            err = MsgToEventLog(M_SYSERR, L"RegisterDNS: Failed to release regsiter-dns semaphore:");
         }
     }
     else
     {
-        MsgToEventLog(M_ERR, TEXT("RegisterDNS: Failed to lock register-dns semaphore"));
+        MsgToEventLog(M_ERR, L"RegisterDNS: Failed to lock register-dns semaphore");
         err = ERROR_SEM_TIMEOUT; /* Windows error code 0x79 */
     }
     return err;
@@ -1194,7 +1194,7 @@
 
     if (apply_gpol && ApplyGpolSettings() == FALSE)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: sending GPOL notification failed"));
+        MsgToEventLog(M_ERR, L"ApplyDnsSettings: sending GPOL notification failed");
     }
 
     scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
@@ -1442,7 +1442,7 @@
 {
     if (!list || wcslen(list) == 0)
     {
-        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: empty search list"));
+        MsgToEventLog(M_ERR, L"StoreInitialDnsSearchList: empty search list");
         return FALSE;
     }
 
@@ -2079,7 +2079,7 @@
     if (!DuplicateHandle(ovpn_proc, orig_handle, GetCurrentProcess(), new_handle, 0, FALSE, DUPLICATE_SAME_ACCESS))
     {
         err = GetLastError();
-        MsgToEventLog(M_SYSERR, TEXT("Could not duplicate handle"));
+        MsgToEventLog(M_SYSERR, L"Could not duplicate handle");
         return err;
     }
 
@@ -2103,7 +2103,7 @@
     if (*ring == NULL)
     {
         err = GetLastError();
-        MsgToEventLog(M_SYSERR, TEXT("Could not map shared memory"));
+        MsgToEventLog(M_SYSERR, L"Could not map shared memory");
         return err;
     }
 
@@ -2166,7 +2166,7 @@
                                send_tail_moved, receive_tail_moved))
     {
         err = GetLastError();
-        MsgToEventLog(M_SYSERR, TEXT("Could not register ring buffers"));
+        MsgToEventLog(M_SYSERR, L"Could not register ring buffers");
         goto out;
     }
 
@@ -2299,7 +2299,7 @@
 
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
-            MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
+            MsgToEventLog(MSG_FLAGS_ERROR, L"Unknown message type %d", msg.header.type);
             break;
     }
 
@@ -2391,7 +2391,7 @@
     STARTUPINFOW startup_info;
     PROCESS_INFORMATION proc_info;
     LPVOID user_env = NULL;
-    TCHAR ovpn_pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
+    WCHAR ovpn_pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
     LPCWSTR exe_path;
     WCHAR *cmdline = NULL;
     size_t cmdline_size;
@@ -2509,14 +2509,14 @@
     ea[0].grfInheritance = NO_INHERITANCE;
     ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
     ea[0].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
-    ea[0].Trustee.ptstrName = (LPTSTR) svc_user->User.Sid;
+    ea[0].Trustee.ptstrName = (LPWSTR) svc_user->User.Sid;
     ea[1].grfAccessPermissions = READ_CONTROL | SYNCHRONIZE | PROCESS_VM_READ
                                  |SYNCHRONIZE | PROCESS_TERMINATE | PROCESS_QUERY_INFORMATION;
     ea[1].grfAccessMode = SET_ACCESS;
     ea[1].grfInheritance = NO_INHERITANCE;
     ea[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
     ea[1].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
-    ea[1].Trustee.ptstrName = (LPTSTR) ovpn_user->User.Sid;
+    ea[1].Trustee.ptstrName = (LPWSTR) ovpn_user->User.Sid;
 
     /* Set owner and DACL of OpenVPN security descriptor */
     if (!SetSecurityDescriptorOwner(&ovpn_sd, svc_user->User.Sid, FALSE))
@@ -2543,7 +2543,7 @@
     }
 
     /* use /dev/null for stdout of openvpn (client should use --log for output) */
-    stdout_write = CreateFile(_T("NUL"), GENERIC_WRITE, FILE_SHARE_WRITE,
+    stdout_write = CreateFile(_L("NUL"), GENERIC_WRITE, FILE_SHARE_WRITE,
                               &inheritable, OPEN_EXISTING, 0, NULL);
     if (stdout_write == INVALID_HANDLE_VALUE)
     {
@@ -2559,7 +2559,7 @@
     }
 
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-             TEXT("\\\\.\\pipe\\") TEXT(PACKAGE) TEXT("%ls\\service_%lu"), service_instance, GetCurrentThreadId());
+             L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu", service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -2654,7 +2654,7 @@
         if (bytes > sizeof(pipe_message_t))
         {
             /* process at the other side of the pipe is misbehaving, shut it down */
-            MsgToEventLog(MSG_FLAGS_ERROR, TEXT("OpenVPN process sent too large payload length to the pipe (%lu bytes), it will be terminated"), bytes);
+            MsgToEventLog(MSG_FLAGS_ERROR, L"OpenVPN process sent too large payload length to the pipe (%lu bytes), it will be terminated", bytes);
             break;
         }
 
@@ -2734,12 +2734,12 @@
      * allow read/write for authenticated users
      * deny all access to anonymous
      */
-    const TCHAR *sddlString = TEXT("D:(A;OICI;GA;;;S-1-5-18)(D;OICI;0x4;;;S-1-1-0)(A;OICI;GRGW;;;S-1-5-11)(D;;GA;;;S-1-5-7)");
+    const WCHAR *sddlString = L"D:(A;OICI;GA;;;S-1-5-18)(D;OICI;0x4;;;S-1-1-0)(A;OICI;GRGW;;;S-1-5-11)(D;;GA;;;S-1-5-7)";
 
     PSECURITY_DESCRIPTOR sd = NULL;
     if (!ConvertStringSecurityDescriptorToSecurityDescriptor(sddlString, SDDL_REVISION_1, &sd, NULL))
     {
-        MsgToEventLog(M_SYSERR, TEXT("ConvertStringSecurityDescriptorToSecurityDescriptor failed."));
+        MsgToEventLog(M_SYSERR, L"ConvertStringSecurityDescriptorToSecurityDescriptor failed.");
         return INVALID_HANDLE_VALUE;
     }
 
@@ -2758,8 +2758,8 @@
         first = FALSE;
     }
 
-    TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
-    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\") TEXT(PACKAGE) TEXT("%ls\\service"), service_instance);
+    WCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
+    swprintf(pipe_name, _countof(pipe_name), L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service", service_instance);
     HANDLE pipe = CreateNamedPipe(pipe_name, flags,
                                   PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
                                   PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
@@ -2768,7 +2768,7 @@
 
     if (pipe == INVALID_HANDLE_VALUE)
     {
-        MsgToEventLog(M_SYSERR, TEXT("Could not create named pipe"));
+        MsgToEventLog(M_SYSERR, L"Could not create named pipe");
         return INVALID_HANDLE_VALUE;
     }
 
@@ -2840,7 +2840,7 @@
 
 
 VOID WINAPI
-ServiceStartInteractiveOwn(DWORD dwArgc, LPTSTR *lpszArgv)
+ServiceStartInteractiveOwn(DWORD dwArgc, LPWSTR *lpszArgv)
 {
     status.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
     ServiceStartInteractive(dwArgc, lpszArgv);
@@ -2876,7 +2876,7 @@
 }
 
 VOID WINAPI
-ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
+ServiceStartInteractive(DWORD dwArgc, LPWSTR *lpszArgv)
 {
     HANDLE pipe, io_event = NULL;
     OVERLAPPED overlapped;
@@ -2911,14 +2911,14 @@
     exit_event = CreateEvent(NULL, TRUE, FALSE, NULL);
     if (!exit_event || !io_event)
     {
-        error = MsgToEventLog(M_SYSERR, TEXT("Could not create event"));
+        error = MsgToEventLog(M_SYSERR, L"Could not create event");
         goto out;
     }
 
     rdns_semaphore = CreateSemaphoreW(NULL, 1, 1, NULL);
     if (!rdns_semaphore)
     {
-        error = MsgToEventLog(M_SYSERR, TEXT("Could not create semaphore for register-dns"));
+        error = MsgToEventLog(M_SYSERR, L"Could not create semaphore for register-dns");
         goto out;
     }
 
@@ -2944,7 +2944,7 @@
             && GetLastError() != ERROR_PIPE_CONNECTED
             && GetLastError() != ERROR_IO_PENDING)
         {
-            MsgToEventLog(M_SYSERR, TEXT("Could not connect pipe"));
+            MsgToEventLog(M_SYSERR, L"Could not connect pipe");
             break;
         }
 
@@ -2989,7 +2989,7 @@
             CancelIo(pipe);
             if (error == WAIT_FAILED)
             {
-                MsgToEventLog(M_SYSERR, TEXT("WaitForMultipleObjects failed"));
+                MsgToEventLog(M_SYSERR, L"WaitForMultipleObjects failed");
                 SetEvent(exit_event);
                 /* Give some time for worker threads to exit and then terminate */
                 Sleep(1000);
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 84fd11a..a76dce7 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -47,7 +47,7 @@
     res = SetServiceStatus(service, status);
     if (!res)
     {
-        MsgToEventLog(MSG_FLAGS_ERROR, TEXT("SetServiceStatus"));
+        MsgToEventLog(MSG_FLAGS_ERROR, L"SetServiceStatus");
     }
 
     return res;
@@ -58,22 +58,22 @@
 {
     SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
-    TCHAR path[512];
+    WCHAR path[512];
     int i, ret = _service_max;
 
     if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) == 0)
     {
-        wprintf(TEXT("Unable to install service - %ls\n"), GetLastErrorText());
+        wprintf(L"Unable to install service - %ls\n", GetLastErrorText());
         return 1;
     }
 
-    path[0] = TEXT('\"');
-    wcscat_s(path, _countof(path), TEXT("\""));
+    path[0] = L'\"';
+    wcscat_s(path, _countof(path), L"\"");
 
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr == NULL)
     {
-        wprintf(TEXT("OpenSCManager failed - %ls\n"), GetLastErrorText());
+        wprintf(L"OpenSCManager failed - %ls\n", GetLastErrorText());
         return 1;
     }
 
@@ -91,13 +91,13 @@
                                 NULL, NULL);
         if (service)
         {
-            wprintf(TEXT("%ls installed.\n"), openvpn_service[i].display_name);
+            wprintf(L"%ls installed.\n", openvpn_service[i].display_name);
             CloseServiceHandle(service);
             --ret;
         }
         else
         {
-            wprintf(TEXT("CreateService failed - %ls\n"), GetLastErrorText());
+            wprintf(L"CreateService failed - %ls\n", GetLastErrorText());
         }
     }
 
@@ -116,7 +116,7 @@
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     if (svc_ctl_mgr == NULL)
     {
-        wprintf(TEXT("OpenSCManager failed - %ls\n"), GetLastErrorText());
+        wprintf(L"OpenSCManager failed - %ls\n", GetLastErrorText());
         return 1;
     }
 
@@ -125,19 +125,19 @@
     {
         if (StartService(service, 0, NULL))
         {
-            wprintf(TEXT("Service Started\n"));
+            wprintf(L"Service Started\n");
             ret = 0;
         }
         else
         {
-            wprintf(TEXT("StartService failed - %ls\n"), GetLastErrorText());
+            wprintf(L"StartService failed - %ls\n", GetLastErrorText());
         }
 
         CloseServiceHandle(service);
     }
     else
     {
-        wprintf(TEXT("OpenService failed - %ls\n"), GetLastErrorText());
+        wprintf(L"OpenService failed - %ls\n", GetLastErrorText());
     }
 
     CloseServiceHandle(svc_ctl_mgr);
@@ -156,7 +156,7 @@
     svc_ctl_mgr = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
     if (svc_ctl_mgr == NULL)
     {
-        wprintf(TEXT("OpenSCManager failed - %ls\n"), GetLastErrorText());
+        wprintf(L"OpenSCManager failed - %ls\n", GetLastErrorText());
         return 1;
     }
 
@@ -167,21 +167,21 @@
                               DELETE | SERVICE_STOP | SERVICE_QUERY_STATUS);
         if (service == NULL)
         {
-            wprintf(TEXT("OpenService failed - %ls\n"), GetLastErrorText());
+            wprintf(L"OpenService failed - %ls\n", GetLastErrorText());
             goto out;
         }
 
         /* try to stop the service */
         if (ControlService(service, SERVICE_CONTROL_STOP, &status))
         {
-            wprintf(TEXT("Stopping %ls."), ovpn_svc->display_name);
+            wprintf(L"Stopping %ls.", ovpn_svc->display_name);
             Sleep(1000);
 
             while (QueryServiceStatus(service, &status))
             {
                 if (status.dwCurrentState == SERVICE_STOP_PENDING)
                 {
-                    wprintf(TEXT("."));
+                    wprintf(L".");
                     Sleep(1000);
                 }
                 else
@@ -192,23 +192,23 @@
 
             if (status.dwCurrentState == SERVICE_STOPPED)
             {
-                wprintf(TEXT("\n%ls stopped.\n"), ovpn_svc->display_name);
+                wprintf(L"\n%ls stopped.\n", ovpn_svc->display_name);
             }
             else
             {
-                wprintf(TEXT("\n%ls failed to stop.\n"), ovpn_svc->display_name);
+                wprintf(L"\n%ls failed to stop.\n", ovpn_svc->display_name);
             }
         }
 
         /* now remove the service */
         if (DeleteService(service))
         {
-            wprintf(TEXT("%ls removed.\n"), ovpn_svc->display_name);
+            wprintf(L"%ls removed.\n", ovpn_svc->display_name);
             --ret;
         }
         else
         {
-            wprintf(TEXT("DeleteService failed - %ls\n"), GetLastErrorText());
+            wprintf(L"DeleteService failed - %ls\n", GetLastErrorText());
         }
 
         CloseServiceHandle(service);
@@ -221,7 +221,7 @@
 
 
 int
-_tmain(int argc, TCHAR *argv[])
+wmain(int argc, WCHAR *argv[])
 {
     /*
      * Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
@@ -234,7 +234,7 @@
 
     /* Interactive service only (as a SERVICE_WIN32_OWN_PROCESS) */
     const SERVICE_TABLE_ENTRY dispatchTable_interactive[] = {
-        { TEXT(""), ServiceStartInteractiveOwn },
+        { L"", ServiceStartInteractiveOwn },
         { NULL, NULL }
     };
 
@@ -244,23 +244,23 @@
 
     for (int i = 1; i < argc; i++)
     {
-        if (*argv[i] == TEXT('-') || *argv[i] == TEXT('/'))
+        if (*argv[i] == L'-' || *argv[i] == L'/')
         {
-            if (_wcsicmp(TEXT("install"), argv[i] + 1) == 0)
+            if (_wcsicmp(L"install", argv[i] + 1) == 0)
             {
                 return CmdInstallServices();
             }
-            else if (_wcsicmp(TEXT("remove"), argv[i] + 1) == 0)
+            else if (_wcsicmp(L"remove", argv[i] + 1) == 0)
             {
                 return CmdRemoveServices();
             }
-            else if (_wcsicmp(TEXT("start"), argv[i] + 1) == 0)
+            else if (_wcsicmp(L"start", argv[i] + 1) == 0)
             {
                 return CmdStartService(interactive);
             }
-            else if (argc > i + 2 && _wcsicmp(TEXT("instance"), argv[i] + 1) == 0)
+            else if (argc > i + 2 && _wcsicmp(L"instance", argv[i] + 1) == 0)
             {
-                if (_wcsicmp(TEXT("interactive"), argv[i+1]) == 0)
+                if (_wcsicmp(L"interactive", argv[i+1]) == 0)
                 {
                     dispatchTable = dispatchTable_interactive;
                     service_instance = argv[i + 2];
@@ -274,16 +274,16 @@
             }
             else
             {
-                wprintf(TEXT("%ls -install        to install the interactive service\n"), APPNAME);
-                wprintf(TEXT("%ls -start [name]   to start the service (name = \"interactive\" is optional)\n"), APPNAME);
-                wprintf(TEXT("%ls -remove         to remove the service\n"), APPNAME);
+                wprintf(L"%ls -install        to install the interactive service\n", APPNAME);
+                wprintf(L"%ls -start [name]   to start the service (name = \"interactive\") is optional\n", APPNAME);
+                wprintf(L"%ls -remove         to remove the service\n", APPNAME);
 
-                wprintf(TEXT("\nService run-time parameters:\n"));
-                wprintf(TEXT("-instance interactive <id>\n")
-                        TEXT("   Runs the service as an alternate instance.\n")
-                        TEXT("   The service settings will be loaded from\n")
-                        TEXT("   HKLM\\Software\\") TEXT(PACKAGE_NAME) TEXT("<id> registry key, and the service will accept\n")
-                        TEXT("   requests on \\\\.\\pipe\\") TEXT(PACKAGE) TEXT("<id>\\service named pipe.\n"));
+                wprintf(L"\nService run-time parameters:\n");
+                wprintf(L"-instance interactive <id>\n"
+                        L"   Runs the service as an alternate instance.\n"
+                        L"   The service settings will be loaded from\n"
+                        L"   HKLM\\Software\\" _L(PACKAGE_NAME) L"<id> registry key, and the service will accept\n"
+                        L"   requests on \\\\.\\pipe\\" _L(PACKAGE) L"<id>\\service named pipe.\n");
 
                 return 0;
             }
@@ -294,12 +294,12 @@
      * the service control manager may be starting the service
      * so we must call StartServiceCtrlDispatcher
      */
-    wprintf(TEXT("\nStartServiceCtrlDispatcher being called.\n"));
-    wprintf(TEXT("This may take several seconds. Please wait.\n"));
+    wprintf(L"\nStartServiceCtrlDispatcher being called.\n");
+    wprintf(L"This may take several seconds. Please wait.\n");
 
     if (!StartServiceCtrlDispatcher(dispatchTable))
     {
-        MsgToEventLog(MSG_FLAGS_ERROR, TEXT("StartServiceCtrlDispatcher failed."));
+        MsgToEventLog(MSG_FLAGS_ERROR, L"StartServiceCtrlDispatcher failed.");
     }
 
     return 0;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index c5f587b..b2b706b 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -36,11 +36,11 @@
 #include <winsock2.h>
 #include <windows.h>
 #include <stdlib.h>
-#include <tchar.h>
+#include <wchar.h>
 #include "../tapctl/basic.h"
 
-#define APPNAME  TEXT(PACKAGE) TEXT("serv")
-#define SERVICE_DEPENDENCIES  TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0Dhcp\0\0")
+#define APPNAME  _L(PACKAGE) L"serv"
+#define SERVICE_DEPENDENCIES  _L(TAP_WIN_COMPONENT_ID) L"\0Dhcp\0\0"
 
 /*
  * Message handling
@@ -58,37 +58,37 @@
 
 typedef struct {
     openvpn_service_type type;
-    TCHAR *name;
-    TCHAR *display_name;
-    TCHAR *dependencies;
+    WCHAR *name;
+    WCHAR *display_name;
+    WCHAR *dependencies;
     DWORD start_type;
 } openvpn_service_t;
 
 #define MAX_NAME 256
 typedef struct {
-    TCHAR exe_path[MAX_PATH];
-    TCHAR config_dir[MAX_PATH];
-    TCHAR ext_string[16];
-    TCHAR log_dir[MAX_PATH];
-    TCHAR ovpn_admin_group[MAX_NAME];
+    WCHAR exe_path[MAX_PATH];
+    WCHAR config_dir[MAX_PATH];
+    WCHAR ext_string[16];
+    WCHAR log_dir[MAX_PATH];
+    WCHAR ovpn_admin_group[MAX_NAME];
     DWORD priority;
     BOOL append;
 } settings_t;
 
 extern openvpn_service_t interactive_service;
-extern LPCTSTR service_instance;
+extern LPCWSTR service_instance;
 
-VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPTSTR *argv);
+VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPWSTR *argv);
 
-VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
+VOID WINAPI ServiceStartInteractive(DWORD argc, LPWSTR *argv);
 
 DWORD GetOpenvpnSettings(settings_t *s);
 
 BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status);
 
-LPCTSTR GetLastErrorText(void);
+LPCWSTR GetLastErrorText(void);
 
-DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);
+DWORD MsgToEventLog(DWORD flags, LPCWSTR lpszMsg, ...);
 
 /**
  * Convert a UTF-8 string to UTF-16
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 9563fa5..23d78af 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -158,7 +158,7 @@
     /* Get username */
     if (!LookupAccountSidW(NULL, sid, username, &len, domain, &len, &sid_type))
     {
-        MsgToEventLog(M_SYSERR, TEXT("LookupAccountSid"));
+        MsgToEventLog(M_SYSERR, L"LookupAccountSid");
         /* not fatal as this is now used only for logging */
         username[0] = '\0';
         domain[0] = '\0';
@@ -170,7 +170,7 @@
     }
     else
     {
-        MsgToEventLog(M_SYSERR, TEXT("Failed to get the name of Administrators group. Using the default."));
+        MsgToEventLog(M_SYSERR, L"Failed to get the name of Administrators group. Using the default.");
         /* use the default value */
         admin_group[0] = SYSTEM_ADMIN_GROUP;
     }
@@ -182,7 +182,7 @@
         ret = IsUserInGroup(sid, token_groups, admin_group[i]);
         if (ret)
         {
-            MsgToEventLog(M_INFO, TEXT("Authorizing user '%ls@%ls' by virtue of membership in group '%ls'"),
+            MsgToEventLog(M_INFO, L"Authorizing user '%ls@%ls' by virtue of membership in group '%ls'",
                           username, domain, admin_group[i]);
             goto out;
         }
@@ -302,7 +302,7 @@
     if (err != NERR_Success && err != NERR_GroupNotFound)
     {
         SetLastError(err);
-        MsgToEventLog(M_SYSERR, TEXT("In NetLocalGroupGetMembers for group '%ls'"), group_name);
+        MsgToEventLog(M_SYSERR, L"In NetLocalGroupGetMembers for group '%ls'", group_name);
     }
 
     return ret;
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index a9f1b9d..61a0ad6 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -28,8 +28,8 @@
 #include "service.h"
 
 /* Authorized groups who can use any options and config locations */
-#define SYSTEM_ADMIN_GROUP TEXT("Administrators")
-#define OVPN_ADMIN_GROUP TEXT("OpenVPN Administrators")
+#define SYSTEM_ADMIN_GROUP L"Administrators"
+#define OVPN_ADMIN_GROUP L"OpenVPN Administrators"
 /* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin_group */
 
 BOOL
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index ca69aab..ca5c6d4 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -23,10 +23,10 @@
 #define BASIC_H
 
 #ifdef _UNICODE
-#define PRIsLPTSTR      "ls"
+#define PRIsLPWSTR      "ls"
 #define PRIsLPOLESTR    "ls"
 #else
-#define PRIsLPTSTR      "s"
+#define PRIsLPWSTR      "s"
 #define PRIsLPOLESTR    "ls"
 #endif
 #define PRIXGUID        "{%08lX-%04hX-%04hX-%02hhX%02hhX-%02hhX%02hhX%02hhX%02hhX%02hhX%02hhX}"
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 9bfc870..551a8e6 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -29,7 +29,7 @@
 #include <objbase.h>
 #include <setupapi.h>
 #include <stdio.h>
-#include <tchar.h>
+#include <wchar.h>
 
 #ifdef _MSC_VER
 #pragma comment(lib, "ole32.lib")
@@ -37,79 +37,79 @@
 #endif
 
 
-const TCHAR title_string[] =
-    TEXT(PACKAGE_NAME) TEXT(" ") TEXT(PACKAGE_VERSION)
+const WCHAR title_string[] =
+    _L(PACKAGE_NAME) L" " _L(PACKAGE_VERSION)
 ;
 
-static const TCHAR usage_message[] =
-    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
-    TEXT("\n")
-    TEXT("Usage:\n")
-    TEXT("\n")
-    TEXT("tapctl <command> [<command specific options>]\n")
-    TEXT("\n")
-    TEXT("Commands:\n")
-    TEXT("\n")
-    TEXT("create     Create a new TUN/TAP adapter\n")
-    TEXT("list       List TUN/TAP adapters\n")
-    TEXT("delete     Delete specified network adapter\n")
-    TEXT("help       Display this text\n")
-    TEXT("\n")
-    TEXT("Hint: Use \"tapctl help <command>\" to display help for particular command.\n")
+static const WCHAR usage_message[] =
+    L"%ls\n"
+    L"\n"
+    L"Usage:\n"
+    L"\n"
+    L"tapctl <command> [<command specific options>]\n"
+    L"\n"
+    L"Commands:\n"
+    L"\n"
+    L"create     Create a new TUN/TAP adapter\n"
+    L"list       List TUN/TAP adapters\n"
+    L"delete     Delete specified network adapter\n"
+    L"help       Display this text\n"
+    L"\n"
+    L"Hint: Use \"tapctl help <command>\" to display help for particular command.\n"
 ;
 
-static const TCHAR usage_message_create[] =
-    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
-    TEXT("\n")
-    TEXT("Creates a new TUN/TAP adapter\n")
-    TEXT("\n")
-    TEXT("Usage:\n")
-    TEXT("\n")
-    TEXT("tapctl create [<options>]\n")
-    TEXT("\n")
-    TEXT("Options:\n")
-    TEXT("\n")
-    TEXT("--name <name>  Set TUN/TAP adapter name. Should the adapter with given name    \n")
-    TEXT("               already exist, an error is returned. If this option is not      \n")
-    TEXT("               specified, a default adapter name is chosen by Windows.         \n")
-    TEXT("               Note: This name can also be specified as OpenVPN's --dev-node   \n")
-    TEXT("               option.                                                         \n")
-    TEXT("--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, which      \n")
-    TEXT("               describes tap-windows6 driver. To work with wintun or ovpn-dco  \n")
-    TEXT("               driver, specify 'wintun' or 'ovpn-dco'.                         \n")
-    TEXT("\n")
-    TEXT("Output:\n")
-    TEXT("\n")
-    TEXT("This command prints newly created TUN/TAP adapter's GUID to stdout.            \n")
+static const WCHAR usage_message_create[] =
+    L"%ls\n"
+    L"\n"
+    L"Creates a new TUN/TAP adapter\n"
+    L"\n"
+    L"Usage:\n"
+    L"\n"
+    L"tapctl create [<options>]\n"
+    L"\n"
+    L"Options:\n"
+    L"\n"
+    L"--name <name>  Set TUN/TAP adapter name. Should the adapter with given name    \n"
+    L"               already exist, an error is returned. If this option is not      \n"
+    L"               specified, a default adapter name is chosen by Windows.         \n"
+    L"               Note: This name can also be specified as OpenVPN's --dev-node   \n"
+    L"               option.                                                         \n"
+    L"--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, which      \n"
+    L"               describes tap-windows6 driver. To work with wintun or ovpn-dco  \n"
+    L"               driver, specify 'wintun' or 'ovpn-dco'.                         \n"
+    L"\n"
+    L"Output:\n"
+    L"\n"
+    L"This command prints newly created TUN/TAP adapter's GUID to stdout.            \n"
 ;
 
-static const TCHAR usage_message_list[] =
-    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
-    TEXT("\n")
-    TEXT("Lists TUN/TAP adapters\n")
-    TEXT("\n")
-    TEXT("Usage:\n")
-    TEXT("\n")
-    TEXT("tapctl list\n")
-    TEXT("\n")
-    TEXT("Options:\n")
-    TEXT("\n")
-    TEXT("--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap0901, wintun and \n")
-    TEXT("               ovpn-dco adapters are listed. Use this switch to limit the list.\n")
-    TEXT("\n")
-    TEXT("Output:\n")
-    TEXT("\n")
-    TEXT("This command prints all TUN/TAP adapters to stdout.                            \n")
+static const WCHAR usage_message_list[] =
+    L"%ls\n"
+    L"\n"
+    L"Lists TUN/TAP adapters\n"
+    L"\n"
+    L"Usage:\n"
+    L"\n"
+    L"tapctl list\n"
+    L"\n"
+    L"Options:\n"
+    L"\n"
+    L"--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap0901, wintun and \n"
+    L"               ovpn-dco adapters are listed. Use this switch to limit the list.\n"
+    L"\n"
+    L"Output:\n"
+    L"\n"
+    L"This command prints all TUN/TAP adapters to stdout.                            \n"
 ;
 
-static const TCHAR usage_message_delete[] =
-    TEXT("%") TEXT(PRIsLPTSTR) TEXT("\n")
-    TEXT("\n")
-    TEXT("Deletes the specified network adapter\n")
-    TEXT("\n")
-    TEXT("Usage:\n")
-    TEXT("\n")
-    TEXT("tapctl delete <adapter GUID | adapter name>\n")
+static const WCHAR usage_message_delete[] =
+    L"%ls\n"
+    L"\n"
+    L"Deletes the specified network adapter\n"
+    L"\n"
+    L"Usage:\n"
+    L"\n"
+    L"tapctl delete <adapter GUID | adapter name>\n"
 ;
 
 
@@ -119,27 +119,27 @@
 static void
 usage(void)
 {
-    _ftprintf(stderr,
-              usage_message,
-              title_string);
+    fwprintf(stderr,
+             usage_message,
+             title_string);
 }
 
 /**
  * Checks if adapter with given name doesn't already exist
  */
 static BOOL
-is_adapter_name_available(LPCTSTR name, struct tap_adapter_node *adapter_list, BOOL log)
+is_adapter_name_available(LPCWSTR name, struct tap_adapter_node *adapter_list, BOOL log)
 {
     for (struct tap_adapter_node *a = adapter_list; a; a = a->pNext)
     {
-        if (_tcsicmp(name, a->szName) == 0)
+        if (wcsicmp(name, a->szName) == 0)
         {
             if (log)
             {
                 LPOLESTR adapter_id = NULL;
                 StringFromIID((REFIID)&a->guid, &adapter_id);
-                _ftprintf(stderr, TEXT("Adapter \"%") TEXT(PRIsLPTSTR) TEXT("\" already exists (GUID %")
-                          TEXT(PRIsLPOLESTR) TEXT(").\n"), a->szName, adapter_id);
+                fwprintf(stderr, L"Adapter \"%ls\" already exists (GUID %"
+                         L"ls).\n", a->szName, adapter_id);
                 CoTaskMemFree(adapter_id);
             }
 
@@ -154,26 +154,26 @@
  * Returns unique adapter name based on hwid or NULL if name cannot be generated.
  * Caller is responsible for freeing it.
  */
-static LPTSTR
-get_unique_adapter_name(LPCTSTR hwid, struct tap_adapter_node *adapter_list)
+static LPWSTR
+get_unique_adapter_name(LPCWSTR hwid, struct tap_adapter_node *adapter_list)
 {
     if (hwid == NULL)
     {
         return NULL;
     }
 
-    LPCTSTR base_name;
-    if (_tcsicmp(hwid, TEXT("ovpn-dco")) == 0)
+    LPCWSTR base_name;
+    if (wcsicmp(hwid, L"ovpn-dco") == 0)
     {
-        base_name = TEXT("OpenVPN Data Channel Offload");
+        base_name = L"OpenVPN Data Channel Offload";
     }
-    else if (_tcsicmp(hwid, TEXT("wintun")) == 0)
+    else if (wcsicmp(hwid, L"wintun") == 0)
     {
-        base_name = TEXT("OpenVPN Wintun");
+        base_name = L"OpenVPN Wintun";
     }
-    else if (_tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+    else if (wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) == 0)
     {
-        base_name = TEXT("OpenVPN TAP-Windows6");
+        base_name = L"OpenVPN TAP-Windows6";
     }
     else
     {
@@ -182,18 +182,18 @@
 
     if (is_adapter_name_available(base_name, adapter_list, FALSE))
     {
-        return _tcsdup(base_name);
+        return wcsdup(base_name);
     }
 
-    size_t name_len = _tcslen(base_name) + 10;
-    LPTSTR name = malloc(name_len * sizeof(TCHAR));
+    size_t name_len = wcslen(base_name) + 10;
+    LPWSTR name = malloc(name_len * sizeof(WCHAR));
     if (name == NULL)
     {
         return NULL;
     }
     for (int i = 1; i < 100; ++i)
     {
-        _stprintf_s(name, name_len, TEXT("%ls #%d"), base_name, i);
+        swprintf_s(name, name_len, L"%ls #%d", base_name, i);
 
         if (is_adapter_name_available(name, adapter_list, FALSE))
         {
@@ -208,7 +208,7 @@
  * Program entry point
  */
 int __cdecl
-_tmain(int argc, LPCTSTR argv[])
+wmain(int argc, LPCWSTR argv[])
 {
     int iResult;
     BOOL bRebootRequired = FALSE;
@@ -221,54 +221,54 @@
         usage();
         return 1;
     }
-    else if (_tcsicmp(argv[1], TEXT("help")) == 0)
+    else if (wcsicmp(argv[1], L"help") == 0)
     {
         /* Output help. */
         if (argc < 3)
         {
             usage();
         }
-        else if (_tcsicmp(argv[2], TEXT("create")) == 0)
+        else if (wcsicmp(argv[2], L"create") == 0)
         {
-            _ftprintf(stderr, usage_message_create, title_string);
+            fwprintf(stderr, usage_message_create, title_string);
         }
-        else if (_tcsicmp(argv[2], TEXT("list")) == 0)
+        else if (wcsicmp(argv[2], L"list") == 0)
         {
-            _ftprintf(stderr, usage_message_list, title_string);
+            fwprintf(stderr, usage_message_list, title_string);
         }
-        else if (_tcsicmp(argv[2], TEXT("delete")) == 0)
+        else if (wcsicmp(argv[2], L"delete") == 0)
         {
-            _ftprintf(stderr, usage_message_delete, title_string);
+            fwprintf(stderr, usage_message_delete, title_string);
         }
         else
         {
-            _ftprintf(stderr, TEXT("Unknown command \"%") TEXT(PRIsLPTSTR)
-                      TEXT("\". Please, use \"tapctl help\" to list supported commands.\n"), argv[2]);
+            fwprintf(stderr, L"Unknown command \"%ls"
+                     L"\". Please, use \"tapctl help\" to list supported commands.\n", argv[2]);
         }
 
         return 1;
     }
-    else if (_tcsicmp(argv[1], TEXT("create")) == 0)
+    else if (wcsicmp(argv[1], L"create") == 0)
     {
-        LPCTSTR szName = NULL;
-        LPCTSTR szHwId = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID);
+        LPCWSTR szName = NULL;
+        LPCWSTR szHwId = L"root\\" _L(TAP_WIN_COMPONENT_ID);
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
         {
-            if (_tcsicmp(argv[i], TEXT("--name")) == 0)
+            if (wcsicmp(argv[i], L"--name") == 0)
             {
                 szName = argv[++i];
             }
-            else if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
+            else if (wcsicmp(argv[i], L"--hwid") == 0)
             {
                 szHwId = argv[++i];
             }
             else
             {
-                _ftprintf(stderr, TEXT("Unknown option \"%") TEXT(PRIsLPTSTR)
-                          TEXT("\". Please, use \"tapctl help create\" to list supported options. Ignored.\n"),
-                          argv[i]);
+                fwprintf(stderr, L"Unknown option \"%ls"
+                         L"\". Please, use \"tapctl help create\" to list supported options. Ignored.\n",
+                         argv[i]);
             }
         }
 
@@ -277,13 +277,13 @@
         LPOLESTR szAdapterId = NULL;
         DWORD dwResult = tap_create_adapter(
             NULL,
-            TEXT("Virtual Ethernet"),
+            L"Virtual Ethernet",
             szHwId,
             &bRebootRequired,
             &guidAdapter);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Creating TUN/TAP adapter failed (error 0x%x).\n"), dwResult);
+            fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x).\n", dwResult);
             iResult = 1; goto quit;
         }
 
@@ -292,12 +292,12 @@
         dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Enumerating adapters failed (error 0x%x).\n"), dwResult);
+            fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", dwResult);
             iResult = 1;
             goto create_delete_adapter;
         }
 
-        LPTSTR adapter_name = szName ? _tcsdup(szName) : get_unique_adapter_name(szHwId, pAdapterList);
+        LPWSTR adapter_name = szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, pAdapterList);
         if (adapter_name)
         {
             /* Check for duplicates when name was specified,
@@ -313,9 +313,9 @@
             if (dwResult != ERROR_SUCCESS)
             {
                 StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-                _ftprintf(stderr, TEXT("Renaming TUN/TAP adapter %") TEXT(PRIsLPOLESTR)
-                          TEXT(" to \"%") TEXT(PRIsLPTSTR) TEXT("\" failed (error 0x%x).\n"),
-                          szAdapterId, adapter_name, dwResult);
+                fwprintf(stderr, L"Renaming TUN/TAP adapter %ls"
+                         L" to \"%ls\" failed (error 0x%x).\n",
+                         szAdapterId, adapter_name, dwResult);
                 CoTaskMemFree(szAdapterId);
                 iResult = 1; goto quit;
             }
@@ -334,7 +334,7 @@
 
         /* Output adapter GUID. */
         StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-        _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\n"), szAdapterId);
+        fwprintf(stdout, L"%ls\n", szAdapterId);
         CoTaskMemFree(szAdapterId);
 
         iResult = 0; goto quit;
@@ -346,28 +346,28 @@
             &bRebootRequired);
         iResult = 1; goto quit;
     }
-    else if (_tcsicmp(argv[1], TEXT("list")) == 0)
+    else if (wcsicmp(argv[1], L"list") == 0)
     {
-        TCHAR szzHwId[0x100] =
-            TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0")
-            TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0")
-            TEXT("Wintun\0")
-            TEXT("ovpn-dco\0");
+        WCHAR szzHwId[0x100] =
+            L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0"
+            _L(TAP_WIN_COMPONENT_ID) L"\0"
+            L"Wintun\0"
+            L"ovpn-dco\0";
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
         {
-            if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
+            if (wcsicmp(argv[i], L"--hwid") == 0)
             {
                 memset(szzHwId, 0, sizeof(szzHwId));
                 ++i;
-                memcpy_s(szzHwId, sizeof(szzHwId) - 2*sizeof(TCHAR) /*requires double zero termination*/, argv[i], _tcslen(argv[i])*sizeof(TCHAR));
+                memcpy_s(szzHwId, sizeof(szzHwId) - 2*sizeof(WCHAR) /*requires double zero termination*/, argv[i], wcslen(argv[i])*sizeof(WCHAR));
             }
             else
             {
-                _ftprintf(stderr, TEXT("Unknown option \"%") TEXT(PRIsLPTSTR)
-                          TEXT("\". Please, use \"tapctl help list\" to list supported options. Ignored.\n"),
-                          argv[i]);
+                fwprintf(stderr, L"Unknown option \"%ls"
+                         L"\". Please, use \"tapctl help list\" to list supported options. Ignored.\n",
+                         argv[i]);
             }
         }
 
@@ -376,7 +376,7 @@
         DWORD dwResult = tap_list_adapters(NULL, szzHwId, &pAdapterList);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
+            fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x).\n", dwResult);
             iResult = 1; goto quit;
         }
 
@@ -384,19 +384,19 @@
         {
             LPOLESTR szAdapterId = NULL;
             StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
-            _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\t%")
-                      TEXT(PRIsLPTSTR) TEXT("\n"), szAdapterId, pAdapter->szName);
+            fwprintf(stdout, L"%ls\t%"
+                     L"ls\n", szAdapterId, pAdapter->szName);
             CoTaskMemFree(szAdapterId);
         }
 
         iResult = 0;
         tap_free_adapter_list(pAdapterList);
     }
-    else if (_tcsicmp(argv[1], TEXT("delete")) == 0)
+    else if (wcsicmp(argv[1], L"delete") == 0)
     {
         if (argc < 3)
         {
-            _ftprintf(stderr, TEXT("Missing adapter GUID or name. Please, use \"tapctl help delete\" for usage info.\n"));
+            fwprintf(stderr, L"Missing adapter GUID or name. Please, use \"tapctl help delete\" for usage info.\n");
             return 1;
         }
 
@@ -408,7 +408,7 @@
             DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
             if (dwResult != ERROR_SUCCESS)
             {
-                _ftprintf(stderr, TEXT("Enumerating TUN/TAP adapters failed (error 0x%x).\n"), dwResult);
+                fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x).\n", dwResult);
                 iResult = 1; goto quit;
             }
 
@@ -416,10 +416,10 @@
             {
                 if (pAdapter == NULL)
                 {
-                    _ftprintf(stderr, TEXT("\"%") TEXT(PRIsLPTSTR) TEXT("\" adapter not found.\n"), argv[2]);
+                    fwprintf(stderr, L"\"%ls\" adapter not found.\n", argv[2]);
                     iResult = 1; goto delete_cleanup_pAdapterList;
                 }
-                else if (_tcsicmp(argv[2], pAdapter->szName) == 0)
+                else if (wcsicmp(argv[2], pAdapter->szName) == 0)
                 {
                     memcpy(&guidAdapter, &pAdapter->guid, sizeof(GUID));
                     break;
@@ -443,8 +443,8 @@
             &bRebootRequired);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Deleting adapter \"%") TEXT(PRIsLPTSTR)
-                      TEXT("\" failed (error 0x%x).\n"), argv[2], dwResult);
+            fwprintf(stderr, L"Deleting adapter \"%ls"
+                     L"\" failed (error 0x%x).\n", argv[2], dwResult);
             iResult = 1; goto quit;
         }
 
@@ -452,15 +452,15 @@
     }
     else
     {
-        _ftprintf(stderr, TEXT("Unknown command \"%") TEXT(PRIsLPTSTR)
-                  TEXT("\". Please, use \"tapctl help\" to list supported commands.\n"), argv[1]);
+        fwprintf(stderr, L"Unknown command \"%ls"
+                 L"\". Please, use \"tapctl help\" to list supported commands.\n", argv[1]);
         return 1;
     }
 
 quit:
     if (bRebootRequired)
     {
-        _ftprintf(stderr, TEXT("A system reboot is required.\n"));
+        fwprintf(stderr, L"A system reboot is required.\n");
     }
 
     return iResult;
@@ -481,19 +481,19 @@
 {
     /* Output message string. Note: Message strings don't contain line terminators. */
     vfprintf(stderr, format, arglist);
-    _ftprintf(stderr, TEXT("\n"));
+    fwprintf(stderr, L"\n");
 
     if ((flags & M_ERRNO) != 0)
     {
         /* Output system error message (if possible). */
         DWORD dwResult = GetLastError();
-        LPTSTR szErrMessage = NULL;
+        LPWSTR szErrMessage = NULL;
         if (FormatMessage(
                 FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
                 0,
                 dwResult,
                 0,
-                (LPTSTR)&szErrMessage,
+                (LPWSTR)&szErrMessage,
                 0,
                 NULL) && szErrMessage)
         {
@@ -502,7 +502,7 @@
             {
                 if (szErrMessage[i])
                 {
-                    if (!_istspace(szErrMessage[i]))
+                    if (!iswspace(szErrMessage[i]))
                     {
                         i_last = i + 1;
                     }
@@ -515,13 +515,13 @@
             }
 
             /* Output error message. */
-            _ftprintf(stderr, TEXT("Error 0x%x: %") TEXT(PRIsLPTSTR) TEXT("\n"), dwResult, szErrMessage);
+            fwprintf(stderr, L"Error 0x%x: %ls\n", dwResult, szErrMessage);
 
             LocalFree(szErrMessage);
         }
         else
         {
-            _ftprintf(stderr, TEXT("Error 0x%x\n"), dwResult);
+            fwprintf(stderr, L"Error 0x%x\n", dwResult);
         }
     }
 }
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 4dde2e6..0fdd750 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -30,7 +30,7 @@
 #include <objbase.h>
 #include <setupapi.h>
 #include <stdio.h>
-#include <tchar.h>
+#include <wchar.h>
 #include <newdev.h>
 
 #ifdef _MSC_VER
@@ -43,8 +43,8 @@
 
 const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
 
-const static TCHAR szAdapterRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
-#define ADAPTER_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
+const static WCHAR szAdapterRegKeyPathTemplate[] = L"SYSTEM\\CurrentControlSet\\Control\\Network\\%ls\\%ls\\Connection";
+#define ADAPTER_REGKEY_PATH_MAX (_countof(L"SYSTEM\\CurrentControlSet\\Control\\Network\\") - 1 + 38 + _countof(L"\\") - 1 + 38 + _countof(L"\\Connection"))
 
 /**
  * Dynamically load a library and find a function in it
@@ -104,10 +104,10 @@
  * @return Number of characters not counting the final zero terminator
  **/
 static inline size_t
-_tcszlen(_In_z_ LPCTSTR szz)
+wcszlen(_In_z_ LPCWSTR szz)
 {
-    LPCTSTR s;
-    for (s = szz; s[0]; s += _tcslen(s) + 1)
+    LPCWSTR s;
+    for (s = szz; s[0]; s += wcslen(s) + 1)
     {
     }
     return s - szz;
@@ -124,12 +124,12 @@
  *
  * @return Pointer to the string in szzHay that matches szNeedle is found; NULL otherwise
  */
-static LPCTSTR
-_tcszistr(_In_z_ LPCTSTR szzHay, _In_z_ LPCTSTR szNeedle)
+static LPCWSTR
+wcszistr(_In_z_ LPCWSTR szzHay, _In_z_ LPCWSTR szNeedle)
 {
-    for (LPCTSTR s = szzHay; s[0]; s += _tcslen(s) + 1)
+    for (LPCWSTR s = szzHay; s[0]; s += wcslen(s) + 1)
     {
-        if (_tcsicmp(s, szNeedle) == 0)
+        if (wcsicmp(s, szNeedle) == 0)
         {
             return s;
         }
@@ -405,8 +405,8 @@
 static DWORD
 get_reg_string(
     _In_ HKEY hKey,
-    _In_ LPCTSTR szName,
-    _Out_ LPTSTR *pszValue)
+    _In_ LPCWSTR szName,
+    _Out_ LPWSTR *pszValue)
 {
     if (pszValue == NULL)
     {
@@ -424,7 +424,7 @@
     if (dwResult != ERROR_SUCCESS)
     {
         SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: enumerating \"%" PRIsLPTSTR "\" registry value failed", __FUNCTION__, szName);
+        msg(M_NONFATAL | M_ERRNO, "%s: enumerating \"%ls\" registry value failed", __FUNCTION__, szName);
         return dwResult;
     }
 
@@ -434,7 +434,7 @@
         case REG_EXPAND_SZ:
         {
             /* Read value. */
-            LPTSTR szValue = (LPTSTR)malloc(dwSize);
+            LPWSTR szValue = (LPWSTR)malloc(dwSize);
             if (szValue == NULL)
             {
                 msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwSize);
@@ -451,7 +451,7 @@
             if (dwResult != ERROR_SUCCESS)
             {
                 SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-                msg(M_NONFATAL | M_ERRNO, "%s: reading \"%" PRIsLPTSTR "\" registry value failed", __FUNCTION__, szName);
+                msg(M_NONFATAL | M_ERRNO, "%s: reading \"%ls\" registry value failed", __FUNCTION__, szName);
                 free(szValue);
                 return dwResult;
             }
@@ -463,11 +463,11 @@
                     dwSizeExp = dwSize * 2,
                     dwCountExp =
 #ifdef UNICODE
-                    dwSizeExp / sizeof(TCHAR);
+                    dwSizeExp / sizeof(WCHAR);
 #else
-                    dwSizeExp / sizeof(TCHAR) - 1;     /* Note: ANSI version requires one extra char. */
+                    dwSizeExp / sizeof(WCHAR) - 1;     /* Note: ANSI version requires one extra char. */
 #endif
-                LPTSTR szValueExp = (LPTSTR)malloc(dwSizeExp);
+                LPWSTR szValueExp = (LPWSTR)malloc(dwSizeExp);
                 if (szValueExp == NULL)
                 {
                     free(szValue);
@@ -481,7 +481,7 @@
                     );
                 if (dwCountExpResult == 0)
                 {
-                    msg(M_NONFATAL | M_ERRNO, "%s: expanding \"%" PRIsLPTSTR "\" registry value failed", __FUNCTION__, szName);
+                    msg(M_NONFATAL | M_ERRNO, "%s: expanding \"%ls\" registry value failed", __FUNCTION__, szName);
                     free(szValueExp);
                     free(szValue);
                     return dwResult;
@@ -498,13 +498,13 @@
                     /* Retry with a bigger buffer. */
                     free(szValueExp);
 #ifdef UNICODE
-                    dwSizeExp = dwCountExpResult * sizeof(TCHAR);
+                    dwSizeExp = dwCountExpResult * sizeof(WCHAR);
 #else
                     /* Note: ANSI version requires one extra char. */
-                    dwSizeExp = (dwCountExpResult + 1) * sizeof(TCHAR);
+                    dwSizeExp = (dwCountExpResult + 1) * sizeof(WCHAR);
 #endif
                     dwCountExp = dwCountExpResult;
-                    szValueExp = (LPTSTR)malloc(dwSizeExp);
+                    szValueExp = (LPWSTR)malloc(dwSizeExp);
                     if (szValueExp == NULL)
                     {
                         free(szValue);
@@ -528,7 +528,7 @@
         }
 
         default:
-            msg(M_NONFATAL, "%s: \"%" PRIsLPTSTR "\" registry value is not string (type %u)", __FUNCTION__, dwValueType);
+            msg(M_NONFATAL, "%s: \"%ls\" registry value is not string (type %u)", __FUNCTION__, dwValueType);
             return ERROR_UNSUPPORTED_TYPE;
     }
 }
@@ -584,8 +584,8 @@
     while (iNumAttempts > 0)
     {
         /* Query the NetCfgInstanceId value. Using get_reg_string() right on might clutter the output with error messages while the registry is still being populated. */
-        LPTSTR szCfgGuidString = NULL;
-        dwResult = RegQueryValueEx(hKey, TEXT("NetCfgInstanceId"), NULL, NULL, NULL, NULL);
+        LPWSTR szCfgGuidString = NULL;
+        dwResult = RegQueryValueEx(hKey, L"NetCfgInstanceId", NULL, NULL, NULL, NULL);
         if (dwResult != ERROR_SUCCESS)
         {
             if (dwResult == ERROR_FILE_NOT_FOUND && --iNumAttempts > 0)
@@ -603,7 +603,7 @@
         /* Read the NetCfgInstanceId value now. */
         dwResult = get_reg_string(
             hKey,
-            TEXT("NetCfgInstanceId"),
+            L"NetCfgInstanceId",
             &szCfgGuidString);
         if (dwResult != ERROR_SUCCESS)
         {
@@ -722,8 +722,8 @@
 DWORD
 tap_create_adapter(
     _In_opt_ HWND hwndParent,
-    _In_opt_ LPCTSTR szDeviceDescription,
-    _In_ LPCTSTR szHwId,
+    _In_opt_ LPCWSTR szDeviceDescription,
+    _In_ LPCWSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
     _Out_ LPGUID pguidAdapter)
 {
@@ -747,7 +747,7 @@
     }
 
     /* Get the device class name from GUID. */
-    TCHAR szClassName[MAX_CLASS_NAME_LEN];
+    WCHAR szClassName[MAX_CLASS_NAME_LEN];
     if (!SetupDiClassNameFromGuid(
             &GUID_DEVCLASS_NET,
             szClassName,
@@ -790,7 +790,7 @@
             hDevInfoList,
             &devinfo_data,
             SPDRP_HARDWAREID,
-            (const BYTE *)szHwId, (DWORD)((_tcslen(szHwId) + 1) * sizeof(TCHAR))))
+            (const BYTE *)szHwId, (DWORD)((wcslen(szHwId) + 1) * sizeof(WCHAR))))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiSetDeviceRegistryProperty failed", __FUNCTION__);
@@ -965,7 +965,7 @@
             {
                 LPOLESTR szAdapterId = NULL;
                 StringFromIID((REFIID)pguidAdapter, &szAdapterId);
-                msg(M_NONFATAL, "%s: Adapter %" PRIsLPOLESTR " not found", __FUNCTION__, szAdapterId);
+                msg(M_NONFATAL, "%s: Adapter %ls not found", __FUNCTION__, szAdapterId);
                 CoTaskMemFree(szAdapterId);
                 dwResult = ERROR_FILE_NOT_FOUND;
                 goto cleanup_hDevInfoList;
@@ -1062,7 +1062,7 @@
 DWORD
 tap_set_adapter_name(
     _In_ LPCGUID pguidAdapter,
-    _In_ LPCTSTR szName,
+    _In_ LPCWSTR szName,
     _In_ BOOL bSilent)
 {
     DWORD dwResult;
@@ -1083,8 +1083,8 @@
     StringFromIID((REFIID)pguidAdapter, &szAdapterId);
 
     /* Render registry key path. */
-    TCHAR szRegKey[ADAPTER_REGKEY_PATH_MAX];
-    _stprintf_s(
+    WCHAR szRegKey[ADAPTER_REGKEY_PATH_MAX];
+    swprintf_s(
         szRegKey, _countof(szRegKey),
         szAdapterRegKeyPathTemplate,
         szDevClassNetId,
@@ -1101,12 +1101,12 @@
     if (dwResult != ERROR_SUCCESS)
     {
         SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(msg_flag, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
+        msg(msg_flag, "%s: RegOpenKeyEx(HKLM, \"%ls\") failed", __FUNCTION__, szRegKey);
         goto cleanup_szAdapterId;
     }
 
-    LPTSTR szOldName = NULL;
-    dwResult = get_reg_string(hKey, TEXT("Name"), &szOldName);
+    LPWSTR szOldName = NULL;
+    dwResult = get_reg_string(hKey, L"Name", &szOldName);
     if (dwResult != ERROR_SUCCESS)
     {
         SetLastError(dwResult);
@@ -1115,11 +1115,11 @@
     }
 
     /* rename adapter via netsh call */
-    const TCHAR *szFmt = TEXT("netsh interface set interface name=\"%")
-                         TEXT(PRIsLPTSTR) TEXT("\" newname=\"%") TEXT(PRIsLPTSTR) TEXT("\"");
-    size_t ncmdline = _tcslen(szFmt) + _tcslen(szOldName) + _tcslen(szName) + 1;
-    WCHAR *szCmdLine = malloc(ncmdline * sizeof(TCHAR));
-    _stprintf_s(szCmdLine, ncmdline, szFmt, szOldName, szName);
+    const WCHAR *szFmt = L"netsh interface set interface name=\"%"
+                         L"ls\" newname=\"%ls\"";
+    size_t ncmdline = wcslen(szFmt) + wcslen(szOldName) + wcslen(szName) + 1;
+    WCHAR *szCmdLine = malloc(ncmdline * sizeof(WCHAR));
+    swprintf_s(szCmdLine, ncmdline, szFmt, szOldName, szName);
 
     free(szOldName);
 
@@ -1145,7 +1145,7 @@
 DWORD
 tap_list_adapters(
     _In_opt_ HWND hwndParent,
-    _In_opt_ LPCTSTR szzHwIDs,
+    _In_opt_ LPCWSTR szzHwIDs,
     _Out_ struct tap_adapter_node **ppAdapter)
 {
     DWORD dwResult;
@@ -1210,7 +1210,7 @@
 
         /* Get device hardware ID(s). */
         DWORD dwDataType = REG_NONE;
-        LPTSTR szzDeviceHardwareIDs = NULL;
+        LPWSTR szzDeviceHardwareIDs = NULL;
         dwResult = get_device_reg_property(
             hDevInfoList,
             &devinfo_data,
@@ -1226,7 +1226,7 @@
         /* Check that hardware ID is REG_SZ/REG_MULTI_SZ, and optionally if it matches ours. */
         if (dwDataType == REG_SZ)
         {
-            if (szzHwIDs && !_tcszistr(szzHwIDs, szzDeviceHardwareIDs))
+            if (szzHwIDs && !wcszistr(szzHwIDs, szzDeviceHardwareIDs))
             {
                 /* This is not our device. Skip it. */
                 goto cleanup_szzDeviceHardwareIDs;
@@ -1236,14 +1236,14 @@
         {
             if (szzHwIDs)
             {
-                for (LPTSTR s = szzDeviceHardwareIDs;; s += _tcslen(s) + 1)
+                for (LPWSTR s = szzDeviceHardwareIDs;; s += wcslen(s) + 1)
                 {
                     if (s[0] == 0)
                     {
                         /* This is not our device. Skip it. */
                         goto cleanup_szzDeviceHardwareIDs;
                     }
-                    else if (_tcszistr(szzHwIDs, s))
+                    else if (wcszistr(szzHwIDs, s))
                     {
                         /* This is our device. */
                         break;
@@ -1271,8 +1271,8 @@
         StringFromIID((REFIID)&guidAdapter, &szAdapterId);
 
         /* Render registry key path. */
-        TCHAR szRegKey[ADAPTER_REGKEY_PATH_MAX];
-        _stprintf_s(
+        WCHAR szRegKey[ADAPTER_REGKEY_PATH_MAX];
+        swprintf_s(
             szRegKey, _countof(szRegKey),
             szAdapterRegKeyPathTemplate,
             szDevClassNetId,
@@ -1289,26 +1289,26 @@
         if (dwResult != ERROR_SUCCESS)
         {
             SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
+            msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%ls\") failed", __FUNCTION__, szRegKey);
             goto cleanup_szAdapterId;
         }
 
         /* Read adapter name. */
-        LPTSTR szName = NULL;
+        LPWSTR szName = NULL;
         dwResult = get_reg_string(
             hKey,
-            TEXT("Name"),
+            L"Name",
             &szName);
         if (dwResult != ERROR_SUCCESS)
         {
             SetLastError(dwResult);
-            msg(M_WARN | M_ERRNO, "%s: Cannot determine %" PRIsLPOLESTR " adapter name", __FUNCTION__, szAdapterId);
+            msg(M_WARN | M_ERRNO, "%s: Cannot determine %ls adapter name", __FUNCTION__, szAdapterId);
             goto cleanup_hKey;
         }
 
         /* Append to the list. */
-        size_t hwid_size = (_tcszlen(szzDeviceHardwareIDs) + 1) * sizeof(TCHAR);
-        size_t name_size = (_tcslen(szName) + 1) * sizeof(TCHAR);
+        size_t hwid_size = (wcszlen(szzDeviceHardwareIDs) + 1) * sizeof(WCHAR);
+        size_t name_size = (wcslen(szName) + 1) * sizeof(WCHAR);
         struct tap_adapter_node *node = (struct tap_adapter_node *)malloc(sizeof(struct tap_adapter_node) + hwid_size + name_size);
         if (node == NULL)
         {
@@ -1317,9 +1317,9 @@
         }
 
         memcpy(&node->guid, &guidAdapter, sizeof(GUID));
-        node->szzHardwareIDs = (LPTSTR)(node + 1);
+        node->szzHardwareIDs = (LPWSTR)(node + 1);
         memcpy(node->szzHardwareIDs, szzDeviceHardwareIDs, hwid_size);
-        node->szName = (LPTSTR)((LPBYTE)node->szzHardwareIDs + hwid_size);
+        node->szName = (LPWSTR)((LPBYTE)node->szzHardwareIDs + hwid_size);
         memcpy(node->szName, szName, name_size);
         node->pNext = NULL;
         if (pAdapterTail)
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 680c13a..38ea824 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -52,8 +52,8 @@
 DWORD
 tap_create_adapter(
     _In_opt_ HWND hwndParent,
-    _In_opt_ LPCTSTR szDeviceDescription,
-    _In_ LPCTSTR szHwId,
+    _In_opt_ LPCWSTR szDeviceDescription,
+    _In_ LPCWSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
     _Out_ LPGUID pguidAdapter);
 
@@ -126,7 +126,7 @@
 DWORD
 tap_set_adapter_name(
     _In_ LPCGUID pguidAdapter,
-    _In_ LPCTSTR szName,
+    _In_ LPCWSTR szName,
     _In_ BOOL bSilent);
 
 
@@ -136,8 +136,8 @@
 struct tap_adapter_node
 {
     GUID guid;             /**< Adapter GUID */
-    LPTSTR szzHardwareIDs; /**< Device hardware ID(s) */
-    LPTSTR szName;         /**< Adapter name */
+    LPWSTR szzHardwareIDs; /**< Device hardware ID(s) */
+    LPWSTR szName;         /**< Adapter name */
 
     struct tap_adapter_node *pNext; /**< Pointer to next adapter */
 };
@@ -165,7 +165,7 @@
 DWORD
 tap_list_adapters(
     _In_opt_ HWND hwndParent,
-    _In_opt_ LPCTSTR szzHwIDs,
+    _In_opt_ LPCWSTR szzHwIDs,
     _Out_ struct tap_adapter_node **ppAdapterList);
 
 

