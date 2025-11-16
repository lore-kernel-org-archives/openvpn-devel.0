From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 13:11:40 +0100
Message-ID: <20251116121146.4067-1-gert@...1296...>
In-Reply-To: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
References: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tapctl: refactor 'create' command
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

From: Lev Stipakov <lev@...515...>

Make default adapter name selection logic more robust -
sometimes renaming fails because the deleted adapter name
might present in the registry even though adapter is not shown
anymore in enumeration.

Ensure that adapter name doesn't contain disallowed symbols.

Use --hwid ovpn-dco by default and update documentation.

Change-Id: I270f679505c90ef78a5afbad1e05219f166be089
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1374
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1374
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 15c25ae..c92c122 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -71,12 +71,12 @@
     L"\n"
     L"--name <name>  Set VPN network adapter name. Should the adapter with given     \n"
     L"               name already exist, an error is returned. If this option is not \n"
-    L"               specified, a default adapter name is chosen by Windows.         \n"
+    L"               specified, an OpenVPN-specific default name is chosen.          \n"
     L"               Note: This name can also be specified as OpenVPN's --dev-node   \n"
     L"               option.                                                         \n"
-    L"--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, which      \n"
-    L"               describes tap-windows6 driver. To work with ovpn-dco driver,    \n"
-    L"               driver, specify 'ovpn-dco'.                                     \n"
+    L"--hwid <hwid>  Adapter hardware ID. Default value is ovpn-dco, which uses      \n"
+    L"               the OpenVPN Data Channel Offload driver. To work with          \n"
+    L"               tap-windows6 driver, specify root\\tap0901 or tap0901.         \n"
     L"\n"
     L"Output:\n"
     L"\n"
@@ -125,26 +125,163 @@
 }
 
 /**
- * Checks if adapter with given name doesn't already exist
+ * Locate an adapter node by its friendly name within the enumerated list.
+ *
+ * @param name          Friendly name to search for. Comparison is case-insensitive.
+ * @param adapter_list  Head of the adapter list returned by tap_list_adapters().
+ *
+ * @return Pointer to the matching node, or NULL when not found.
  */
-static BOOL
-is_adapter_name_available(LPCWSTR name, struct tap_adapter_node *adapter_list, BOOL log)
+static struct tap_adapter_node *
+find_adapter_by_name(LPCWSTR name, struct tap_adapter_node *adapter_list)
 {
     for (struct tap_adapter_node *a = adapter_list; a; a = a->pNext)
     {
-        if (wcsicmp(name, a->szName) == 0)
+        if (_wcsicmp(name, a->szName) == 0)
         {
-            if (log)
-            {
-                LPOLESTR adapter_id = NULL;
-                StringFromIID((REFIID)&a->guid, &adapter_id);
-                fwprintf(stderr,
-                         L"Adapter \"%ls\" already exists (GUID %"
-                         L"ls).\n",
-                         a->szName, adapter_id);
-                CoTaskMemFree(adapter_id);
-            }
+            return a;
+        }
+    }
 
+    return NULL;
+}
+
+/**
+ * Check whether the registry still reserves a given network-connection name.
+ *
+ * Windows keeps friendly names under
+ * \\HKLM\\SYSTEM\\CurrentControlSet\\Control\\Network\\{NETCLASS}\\{GUID}\\Connection\\Name,
+ * even after an adapter is removed. netsh refuses to rename to any reserved name.
+ *
+ * @param name  Friendly name to test.
+ *
+ * @return TRUE if the name exists in the registry, FALSE otherwise.
+ */
+static BOOL
+registry_name_exists(LPCWSTR name)
+{
+    static const WCHAR class_key[] =
+        L"SYSTEM\\CurrentControlSet\\Control\\Network\\{4d36e972-e325-11ce-bfc1-08002be10318}";
+
+    HKEY hClassKey = NULL;
+    if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, class_key, 0, KEY_READ, &hClassKey) != ERROR_SUCCESS)
+    {
+        return FALSE;
+    }
+
+    BOOL found = FALSE;
+
+    for (DWORD index = 0;; ++index)
+    {
+        WCHAR adapter_id[64];
+        DWORD adapter_id_len = _countof(adapter_id);
+        LONG result = RegEnumKeyEx(hClassKey, index, adapter_id, &adapter_id_len, NULL, NULL, NULL,
+                                   NULL);
+        if (result == ERROR_NO_MORE_ITEMS)
+        {
+            break;
+        }
+        else if (result != ERROR_SUCCESS)
+        {
+            continue;
+        }
+
+        WCHAR connection_key[512];
+        swprintf_s(connection_key, _countof(connection_key), L"%ls\\%ls\\Connection", class_key,
+                   adapter_id);
+
+        DWORD value_size = 0;
+        LONG query = RegGetValueW(HKEY_LOCAL_MACHINE, connection_key, L"Name",
+                                  RRF_RT_REG_SZ | RRF_NOEXPAND, NULL, NULL, &value_size);
+        if (query != ERROR_SUCCESS || value_size < sizeof(WCHAR))
+        {
+            continue;
+        }
+
+        LPWSTR value = (LPWSTR)malloc(value_size);
+        if (!value)
+        {
+            continue;
+        }
+
+        query = RegGetValueW(HKEY_LOCAL_MACHINE, connection_key, L"Name",
+                             RRF_RT_REG_SZ | RRF_NOEXPAND, NULL, value, &value_size);
+        if (query == ERROR_SUCCESS && _wcsicmp(name, value) == 0)
+        {
+            found = TRUE;
+            free(value);
+            break;
+        }
+
+        free(value);
+
+        if (found)
+        {
+            break;
+        }
+    }
+
+    RegCloseKey(hClassKey);
+    return found;
+}
+
+/**
+ * Determine whether a friendly name is currently in use by an adapter or reserved
+ * in the registry.
+ *
+ * @param name          Friendly name to test.
+ * @param adapter_list  Head of the adapter list returned by tap_list_adapters().
+ *
+ * @return TRUE when the name is taken/reserved, FALSE when available.
+ */
+static BOOL
+tap_name_in_use(LPCWSTR name, struct tap_adapter_node *adapter_list)
+{
+    if (name == NULL)
+    {
+        return FALSE;
+    }
+
+    if (find_adapter_by_name(name, adapter_list))
+    {
+        return TRUE;
+    }
+
+    return registry_name_exists(name);
+}
+
+/**
+ * Check whether a proposed adapter name satisfies Windows connection-name rules.
+ *
+ * Tabs, control characters (except space), and the following characters are disallowed:
+ * \ / : * ? " < > |
+ * Names must also be non-empty and no longer than 255 characters.
+ */
+BOOL
+tap_is_valid_adapter_name(LPCWSTR name)
+{
+    if (name == NULL)
+    {
+        return FALSE;
+    }
+
+    size_t length = wcslen(name);
+    if (length == 0 || length > 255)
+    {
+        return FALSE;
+    }
+
+    static const WCHAR invalid_chars[] = L"\\/:*?\"<>|";
+
+    for (const WCHAR *p = name; *p; ++p)
+    {
+        WCHAR ch = *p;
+        if (ch < L' ')
+        {
+            return FALSE;
+        }
+        if (wcschr(invalid_chars, ch))
+        {
             return FALSE;
         }
     }
@@ -153,81 +290,152 @@
 }
 
 /**
- * Returns unique adapter name based on hwid or NULL if name cannot be generated.
- * Caller is responsible for freeing it.
+ * Resolve the adapter name we should apply:
+ *   - For user-specified names, ensure they are unique both in the adapter list and
+ *     in the registry. On conflict, an explanatory message is printed and NULL is returned.
+ *   - For automatic naming, derive the base string from HWID and append the first available
+ *     suffix recognised by Windows.
+ *
+ * @param requested_name  Name provided via CLI or configuration (may be NULL/empty).
+ * @param hwid            Hardware identifier of the adapter being created.
+ * @param adapter_list    Existing adapters enumerated via tap_list_adapters().
+ *
+ * @return Newly allocated wide string containing the final name, or NULL on failure.
  */
 static LPWSTR
-get_unique_adapter_name(LPCWSTR hwid, struct tap_adapter_node *adapter_list)
+tap_resolve_adapter_name(LPCWSTR requested_name, LPCWSTR hwid,
+                         struct tap_adapter_node *adapter_list)
 {
+    if (requested_name && requested_name[0])
+    {
+        if (!tap_is_valid_adapter_name(requested_name))
+        {
+            fwprintf(stderr,
+                     L"Adapter name \"%ls\" contains invalid characters. Avoid tabs or the "
+                     L"characters \\ / : * ? \" < > | and keep the length within 255 characters.\n",
+                     requested_name);
+            return NULL;
+        }
+
+        struct tap_adapter_node *conflict = find_adapter_by_name(requested_name, adapter_list);
+        if (conflict)
+        {
+            LPOLESTR adapter_id = NULL;
+            StringFromIID((REFIID)&conflict->guid, &adapter_id);
+            fwprintf(stderr,
+                     L"Adapter \"%ls\" already exists (GUID %"
+                     L"ls).\n",
+                     conflict->szName, adapter_id);
+            CoTaskMemFree(adapter_id);
+            return NULL;
+        }
+
+        if (registry_name_exists(requested_name))
+        {
+            fwprintf(stderr, L"Adapter name \"%ls\" is already in use.\n", requested_name);
+            return NULL;
+        }
+
+        return wcsdup(requested_name);
+    }
+
     if (hwid == NULL)
     {
         return NULL;
     }
 
-    LPCWSTR base_name;
-    if (wcsicmp(hwid, L"ovpn-dco") == 0)
+    LPCWSTR base_name = NULL;
+    if (_wcsicmp(hwid, L"ovpn-dco") == 0)
     {
         base_name = L"OpenVPN Data Channel Offload";
     }
-    else if (wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) == 0)
+    else if (_wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) == 0
+             || _wcsicmp(hwid, _L(TAP_WIN_COMPONENT_ID)) == 0)
     {
         base_name = L"OpenVPN TAP-Windows6";
     }
     else
     {
+        fwprintf(stderr,
+                 L"Cannot auto-generate adapter name for hardware ID \"%ls\".\n", hwid);
         return NULL;
     }
 
-    if (is_adapter_name_available(base_name, adapter_list, FALSE))
+    if (!tap_name_in_use(base_name, adapter_list))
     {
         return wcsdup(base_name);
     }
 
     size_t name_len = wcslen(base_name) + 10;
-    LPWSTR name = malloc(name_len * sizeof(WCHAR));
+    LPWSTR name = (LPWSTR)malloc(name_len * sizeof(WCHAR));
     if (name == NULL)
     {
         return NULL;
     }
-    for (int i = 1; i < 100; ++i)
+
+    /* Windows never assigns the "#1" suffix, so skip it to avoid netsh failures. */
+    for (int i = 2; i < 100; ++i)
     {
         swprintf_s(name, name_len, L"%ls #%d", base_name, i);
 
-        if (is_adapter_name_available(name, adapter_list, FALSE))
+        if (!tap_name_in_use(name, adapter_list))
         {
             return name;
         }
     }
 
+    free(name);
+    fwprintf(stderr, L"Unable to find available adapter name based on \"%ls\".\n", base_name);
     return NULL;
 }
 
-static int command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
-static int command_list(int argc, LPCWSTR argv[]);
-static int command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
-
 static int
 command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)
 {
     LPCWSTR szName = NULL;
-    LPCWSTR szHwId = L"root\\" _L(TAP_WIN_COMPONENT_ID);
-    struct tap_adapter_node *adapter_list = NULL;
-    LPWSTR rename_name = NULL;
-    LPWSTR final_name = NULL;
-    LPOLESTR adapter_id = NULL;
+    LPCWSTR defaultHwId = L"ovpn-dco";
+    LPCWSTR szHwId = defaultHwId;
+    LPWSTR adapter_name = NULL;
+    struct tap_adapter_node *pAdapterList = NULL;
     GUID guidAdapter;
-    int result = 1;
-    BOOL delete_created_adapter = FALSE;
+    LPOLESTR szAdapterId = NULL;
+    DWORD dwResult;
+    int iResult = 1;
+    BOOL adapter_created = FALSE;
 
     for (int i = 2; i < argc; i++)
     {
         if (wcsicmp(argv[i], L"--name") == 0)
         {
-            szName = argv[++i];
+            if (++i >= argc)
+            {
+                fwprintf(stderr, L"--name option requires a value. Ignored.\n");
+                break;
+            }
+            szName = argv[i];
+            if (szName[0] == L'\0')
+            {
+                fwprintf(stderr, L"--name option cannot be empty. Ignored.\n");
+                szName = NULL;
+            }
         }
         else if (wcsicmp(argv[i], L"--hwid") == 0)
         {
-            szHwId = argv[++i];
+            if (++i >= argc)
+            {
+                fwprintf(stderr,
+                         L"--hwid option requires a value. Using default \"%ls\".\n",
+                         defaultHwId);
+                break;
+            }
+            szHwId = argv[i];
+            if (szHwId[0] == L'\0')
+            {
+                fwprintf(stderr,
+                         L"--hwid option cannot be empty. Using default \"%ls\".\n",
+                         defaultHwId);
+                szHwId = defaultHwId;
+            }
         }
         else
         {
@@ -238,69 +446,59 @@
         }
     }
 
-    DWORD dwResult =
-        tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, bRebootRequired, &guidAdapter);
+    dwResult = tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, bRebootRequired,
+                                  &guidAdapter);
     if (dwResult != ERROR_SUCCESS)
     {
-        fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x).\n", dwResult);
-        return result;
+        fwprintf(stderr, L"Creating network adapter failed (error 0x%x).\n", dwResult);
+        goto cleanup;
     }
+    adapter_created = TRUE;
 
-    dwResult = tap_list_adapters(NULL, NULL, &adapter_list);
+    dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
     if (dwResult != ERROR_SUCCESS)
     {
         fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", dwResult);
-        delete_created_adapter = TRUE;
         goto cleanup;
     }
 
-    rename_name = szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list);
-    if (rename_name)
+    adapter_name = tap_resolve_adapter_name(szName, szHwId, pAdapterList);
+    if (adapter_name == NULL)
     {
-        if (szName && !is_adapter_name_available(rename_name, adapter_list, TRUE))
-        {
-            delete_created_adapter = TRUE;
-            goto cleanup;
-        }
-
-        dwResult = tap_set_adapter_name(&guidAdapter, rename_name, FALSE);
-        if (dwResult == ERROR_SUCCESS)
-        {
-            final_name = rename_name;
-            rename_name = NULL;
-        }
-        else
-        {
-            StringFromIID((REFIID)&guidAdapter, &adapter_id);
-            fwprintf(stderr,
-                     L"Renaming TUN/TAP adapter %ls"
-                     L" to \"%ls\" failed (error 0x%x).\n",
-                     adapter_id, rename_name, dwResult);
-            CoTaskMemFree(adapter_id);
-        }
+        goto cleanup;
     }
 
-    result = 0;
+    dwResult = tap_set_adapter_name(&guidAdapter, adapter_name, FALSE);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+        fwprintf(stderr,
+                 L"Renaming network adapter %ls to \"%ls\" failed (error 0x%x).\n", szAdapterId,
+                 adapter_name, dwResult);
+        CoTaskMemFree(szAdapterId);
+        goto cleanup;
+    }
+
+    iResult = 0;
+    StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+    const WCHAR *name_to_print = (adapter_name && adapter_name[0]) ? adapter_name : L"(unnamed)";
+    const WCHAR *hwid_to_print = (szHwId && szHwId[0]) ? szHwId : L"(unknown hwid)";
+    fwprintf(stdout, L"%ls\t%ls\t%ls\n", szAdapterId, name_to_print, hwid_to_print);
+    CoTaskMemFree(szAdapterId);
 
 cleanup:
-    tap_free_adapter_list(adapter_list);
-    free(rename_name);
-
-    if (result == 0 && final_name)
+    if (pAdapterList)
     {
-        StringFromIID((REFIID)&guidAdapter, &adapter_id);
-        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, final_name, szHwId ? szHwId : L"");
-        CoTaskMemFree(adapter_id);
+        tap_free_adapter_list(pAdapterList);
     }
+    free(adapter_name);
 
-    free(final_name);
-
-    if (result != 0 && delete_created_adapter)
+    if (adapter_created && iResult != 0)
     {
         tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
     }
 
-    return result;
+    return iResult;
 }
 
 static int

