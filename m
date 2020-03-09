From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:27 +0100
Message-Id: <20200309131728.380-11-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 11/12] openvpnmsica: Merge
 FindTUNTAPAdapters into FindSystemInfo
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

1. We don't need two custom actions to evaluate the system state, do we?

2. FindTUNTAPAdapters was actually broken. It enumerated all existing
   network adapters, rather than just the ones we are interested in:
   TAP-Windows6 and Wintun.

3. TUNTAPADAPTER and ACTIVETUNTAPADAPTERS were split into
   TAPWINDOWS6ADAPTERS, ACTIVETAPWINDOWS6ADAPTERS, WINTUNADAPTERS and
   ACTIVEWINTUNADAPTERS to allow finer control.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 235 ++++++++++++++++----------------
 src/openvpnmsica/openvpnmsica.h |  26 ++--
 2 files changed, 125 insertions(+), 136 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index ae9b007f..28cf16b5 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -248,49 +248,26 @@ cleanup_OpenSCManager:
 }
 
 
-UINT __stdcall
-FindSystemInfo(_In_ MSIHANDLE hInstall)
-{
-#ifdef _MSC_VER
-#pragma comment(linker, DLLEXP_EXPORT)
-#endif
-
-    debug_popup(TEXT(__FUNCTION__));
-
-    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-
-    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
-
-    set_openvpnserv_state(hInstall);
-
-    if (bIsCoInitialized)
-    {
-        CoUninitialize();
-    }
-    return ERROR_SUCCESS;
-}
-
-
-UINT __stdcall
-FindTUNTAPAdapters(_In_ MSIHANDLE hInstall)
+static UINT
+find_adapters(
+    _In_ MSIHANDLE hInstall,
+    _In_z_ LPCTSTR szHardwareId,
+    _In_z_ LPCTSTR szAdaptersPropertyName,
+    _In_z_ LPCTSTR szActiveAdaptersPropertyName)
 {
-#ifdef _MSC_VER
-#pragma comment(linker, DLLEXP_EXPORT)
-#endif
-
-    debug_popup(TEXT(__FUNCTION__));
-
     UINT uiResult;
-    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
-
-    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    /* Get existing network adapters. */
+    /* Get network adapters with given hardware ID. */
     struct tap_adapter_node *pAdapterList = NULL;
-    uiResult = tap_list_adapters(NULL, NULL, &pAdapterList);
+    uiResult = tap_list_adapters(NULL, szHardwareId, &pAdapterList);
     if (uiResult != ERROR_SUCCESS)
     {
-        goto cleanup_CoInitialize;
+        return uiResult;
+    }
+    else if (pAdapterList == NULL)
+    {
+        /* No adapters - no fun. */
+        return ERROR_SUCCESS;
     }
 
     /* Get IPv4/v6 info for all network adapters. Actually, we're interested in link status only: up/down? */
@@ -302,7 +279,7 @@ FindTUNTAPAdapters(_In_ MSIHANDLE hInstall)
         if (pAdapterAdresses == NULL)
         {
             msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, ulAdapterAdressesSize);
-            uiResult = ERROR_OUTOFMEMORY; goto cleanup_tap_list_adapters;
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterList;
         }
 
         ULONG ulResult = GetAdaptersAddresses(
@@ -322,117 +299,135 @@ FindTUNTAPAdapters(_In_ MSIHANDLE hInstall)
         {
             SetLastError(ulResult); /* MSDN does not mention GetAdaptersAddresses() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_NONFATAL | M_ERRNO, "%s: GetAdaptersAddresses() failed", __FUNCTION__);
-            uiResult = ulResult; goto cleanup_tap_list_adapters;
+            uiResult = ulResult; goto cleanup_pAdapterList;
         }
     }
 
-    if (pAdapterList != NULL)
+    /* Count adapters. */
+    size_t adapter_count = 0;
+    for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
     {
-        /* Count adapters. */
-        size_t adapter_count = 0;
-        for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
-        {
-            adapter_count++;
-        }
+        adapter_count++;
+    }
 
-        /* Prepare semicolon delimited list of TAP adapter ID(s) and active TAP adapter ID(s). */
-        LPTSTR
-            szAdapters     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szAdaptersTail = szAdapters;
-        if (szAdapters == NULL)
-        {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
-            uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
-        }
+    /* Prepare semicolon delimited list of TAP adapter ID(s) and active TAP adapter ID(s). */
+    LPTSTR
+        szAdapters     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+        szAdaptersTail = szAdapters;
+    if (szAdapters == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+        uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
+    }
+
+    LPTSTR
+        szAdaptersActive     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+        szAdaptersActiveTail = szAdaptersActive;
+    if (szAdaptersActive == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+        uiResult = ERROR_OUTOFMEMORY; goto cleanup_szAdapters;
+    }
 
-        LPTSTR
-            szAdaptersActive     = (LPTSTR)malloc(adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szAdaptersActiveTail = szAdaptersActive;
-        if (szAdaptersActive == NULL)
+    for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
+    {
+        /* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
+        LPOLESTR szAdapterId = NULL;
+        StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
+
+        /* Append to the list of TAP adapter ID(s). */
+        if (szAdapters < szAdaptersTail)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
-            uiResult = ERROR_OUTOFMEMORY; goto cleanup_szAdapters;
+            *(szAdaptersTail++) = TEXT(';');
         }
+        memcpy(szAdaptersTail, szAdapterId, 38 * sizeof(TCHAR));
+        szAdaptersTail += 38;
 
-        for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
+        /* If this adapter is active (connected), add it to the list of active TAP adapter ID(s). */
+        for (PIP_ADAPTER_ADDRESSES p = pAdapterAdresses; p; p = p->Next)
         {
-            /* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
-            LPOLESTR szAdapterId = NULL;
-            StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
-
-            /* Append to the list of TAP adapter ID(s). */
-            if (szAdapters < szAdaptersTail)
-            {
-                *(szAdaptersTail++) = TEXT(';');
-            }
-            memcpy(szAdaptersTail, szAdapterId, 38 * sizeof(TCHAR));
-            szAdaptersTail += 38;
-
-            /* If this adapter is active (connected), add it to the list of active TAP adapter ID(s). */
-            for (PIP_ADAPTER_ADDRESSES p = pAdapterAdresses; p; p = p->Next)
+            OLECHAR szId[38 /*GUID*/ + 1 /*terminator*/];
+            GUID guid;
+            if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0
+                && SUCCEEDED(IIDFromString(szId, &guid))
+                && memcmp(&guid, &pAdapter->guid, sizeof(GUID)) == 0)
             {
-                OLECHAR szId[38 /*GUID*/ + 1 /*terminator*/];
-                GUID guid;
-                if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0
-                    && SUCCEEDED(IIDFromString(szId, &guid))
-                    && memcmp(&guid, &pAdapter->guid, sizeof(GUID)) == 0)
+                if (p->OperStatus == IfOperStatusUp)
                 {
-                    if (p->OperStatus == IfOperStatusUp)
+                    /* This TAP adapter is active (connected). */
+                    if (szAdaptersActive < szAdaptersActiveTail)
                     {
-                        /* This TAP adapter is active (connected). */
-                        if (szAdaptersActive < szAdaptersActiveTail)
-                        {
-                            *(szAdaptersActiveTail++) = TEXT(';');
-                        }
-                        memcpy(szAdaptersActiveTail, szAdapterId, 38 * sizeof(TCHAR));
-                        szAdaptersActiveTail += 38;
+                        *(szAdaptersActiveTail++) = TEXT(';');
                     }
-                    break;
+                    memcpy(szAdaptersActiveTail, szAdapterId, 38 * sizeof(TCHAR));
+                    szAdaptersActiveTail += 38;
                 }
+                break;
             }
-            CoTaskMemFree(szAdapterId);
-        }
-        szAdaptersTail      [0] = 0;
-        szAdaptersActiveTail[0] = 0;
-
-        /* Set Installer TUNTAPADAPTERS property. */
-        uiResult = MsiSetProperty(hInstall, TEXT("TUNTAPADAPTERS"), szAdapters);
-        if (uiResult != ERROR_SUCCESS)
-        {
-            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TUNTAPADAPTERS\") failed", __FUNCTION__);
-            goto cleanup_szAdaptersActive;
-        }
-
-        /* Set Installer ACTIVETUNTAPADAPTERS property. */
-        uiResult = MsiSetProperty(hInstall, TEXT("ACTIVETUNTAPADAPTERS"), szAdaptersActive);
-        if (uiResult != ERROR_SUCCESS)
-        {
-            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETUNTAPADAPTERS\") failed", __FUNCTION__);
-            goto cleanup_szAdaptersActive;
         }
+        CoTaskMemFree(szAdapterId);
+    }
+    szAdaptersTail      [0] = 0;
+    szAdaptersActiveTail[0] = 0;
 
-cleanup_szAdaptersActive:
-        free(szAdaptersActive);
-cleanup_szAdapters:
-        free(szAdapters);
+    /* Set Installer properties. */
+    uiResult = MsiSetProperty(hInstall, szAdaptersPropertyName, szAdapters);
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%s\") failed", __FUNCTION__, szAdaptersPropertyName);
+        goto cleanup_szAdaptersActive;
     }
-    else
+    uiResult = MsiSetProperty(hInstall, szActiveAdaptersPropertyName, szAdaptersActive);
+    if (uiResult != ERROR_SUCCESS)
     {
-        uiResult = ERROR_SUCCESS;
+        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%s\") failed", __FUNCTION__, szActiveAdaptersPropertyName);
+        goto cleanup_szAdaptersActive;
     }
 
+cleanup_szAdaptersActive:
+    free(szAdaptersActive);
+cleanup_szAdapters:
+    free(szAdapters);
 cleanup_pAdapterAdresses:
     free(pAdapterAdresses);
-cleanup_tap_list_adapters:
+cleanup_pAdapterList:
     tap_free_adapter_list(pAdapterList);
-cleanup_CoInitialize:
+    return uiResult;
+}
+
+
+UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    debug_popup(TEXT(__FUNCTION__));
+
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
+
+    set_openvpnserv_state(hInstall);
+    find_adapters(
+        hInstall,
+        TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID),
+        TEXT("TAPWINDOWS6ADAPTERS"),
+        TEXT("ACTIVETAPWINDOWS6ADAPTERS"));
+    find_adapters(
+        hInstall,
+        TEXT("Wintun"),
+        TEXT("WINTUNADAPTERS"),
+        TEXT("ACTIVEWINTUNADAPTERS"));
+
     if (bIsCoInitialized)
     {
         CoUninitialize();
     }
-    return uiResult;
+    return ERROR_SUCCESS;
 }
 
 
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 5d140930..221d03ca 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -76,23 +76,17 @@ extern "C" {
 
 /**
  * Determines Windows information:
- * - Sets `DriverCertification` MSI property to "", "attsgn" or "whql"
- *   according to the driver certification required by the running version of
- *   Windows.
  *
- * @param hInstall      Handle to the installation provided to the DLL custom action
+ * - Sets `OPENVPNSERVICE` MSI property to PID of OpenVPN Service if running, or its EXE path if
+ *   configured for auto-start.
  *
- * @return ERROR_SUCCESS on success; An error code otherwise
- *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
- */
-DLLEXP_DECL UINT __stdcall
-FindSystemInfo(_In_ MSIHANDLE hInstall);
-
-
-/**
- * Find existing TAP adapters and set TUNTAPADAPTERS and ACTIVETUNTAPADAPTERS properties with
- * semicolon delimited list of all installed TAP adapter GUIDs and active adapter GUIDs
- * respectively.
+ * - Finds existing TAP-Windows6 adapters and set TAPWINDOWS6ADAPTERS and
+ *   ACTIVETAPWINDOWS6ADAPTERS properties with semicolon delimited list of all installed adapter
+ *   GUIDs and active adapter GUIDs respectively.
+ *
+ * - Finds existing Wintun adapters and set WINTUNADAPTERS and ACTIVEWINTUNADAPTERS properties
+ *   with semicolon delimited list of all installed adapter GUIDs and active adapter GUIDs
+ *   respectively.
  *
  * @param hInstall      Handle to the installation provided to the DLL custom action
  *
@@ -100,7 +94,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall);
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
 DLLEXP_DECL UINT __stdcall
-FindTUNTAPAdapters(_In_ MSIHANDLE hInstall);
+FindSystemInfo(_In_ MSIHANDLE hInstall);
 
 
 /**
-- 
2.24.1.windows.2


