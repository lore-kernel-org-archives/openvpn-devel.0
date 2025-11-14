From: Gert Doering <gert@...1296...>
Date: Fri, 14 Nov 2025 22:21:07 +0100
Message-ID: <20251114212112.6370-1-gert@...1296...>
In-Reply-To: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
References: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tapctl: factor out command handlers
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

Change-Id: I432e07216f9adb8f767af172fa37b626b350f994
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1370
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1370
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 031e262..3caffd8 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -201,6 +201,198 @@
     return NULL;
 }
 
+static int command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
+static int command_list(int argc, LPCWSTR argv[]);
+static int command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
+
+static int
+command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)
+{
+    LPCWSTR szName = NULL;
+    LPCWSTR szHwId = L"root\\" _L(TAP_WIN_COMPONENT_ID);
+    struct tap_adapter_node *adapter_list = NULL;
+    LPWSTR adapter_name = NULL;
+    LPOLESTR adapter_id = NULL;
+    GUID guidAdapter;
+    int result = 1;
+
+    for (int i = 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--name") == 0)
+        {
+            szName = argv[++i];
+        }
+        else if (wcsicmp(argv[i], L"--hwid") == 0)
+        {
+            szHwId = argv[++i];
+        }
+        else
+        {
+            fwprintf(stderr,
+                     L"Unknown option \"%ls"
+                     L"\". Please, use \"tapctl help create\" to list supported options. Ignored.\n",
+                     argv[i]);
+        }
+    }
+
+    DWORD dwResult =
+        tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, bRebootRequired, &guidAdapter);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x).\n", dwResult);
+        return result;
+    }
+
+    dwResult = tap_list_adapters(NULL, NULL, &adapter_list);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", dwResult);
+        tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+        return result;
+    }
+
+    adapter_name = szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list);
+    if (adapter_name)
+    {
+        if (szName && !is_adapter_name_available(adapter_name, adapter_list, TRUE))
+        {
+            tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+            goto cleanup;
+        }
+
+        dwResult = tap_set_adapter_name(&guidAdapter, adapter_name, FALSE);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            StringFromIID((REFIID)&guidAdapter, &adapter_id);
+            fwprintf(stderr,
+                     L"Renaming TUN/TAP adapter %ls"
+                     L" to \"%ls\" failed (error 0x%x).\n",
+                     adapter_id, adapter_name, dwResult);
+            CoTaskMemFree(adapter_id);
+            goto cleanup;
+        }
+    }
+
+    result = 0;
+
+cleanup:
+    free(adapter_name);
+    tap_free_adapter_list(adapter_list);
+
+    if (result == 0)
+    {
+        StringFromIID((REFIID)&guidAdapter, &adapter_id);
+        fwprintf(stdout, L"%ls\n", adapter_id);
+        CoTaskMemFree(adapter_id);
+    }
+
+    return result;
+}
+
+static int
+command_list(int argc, LPCWSTR argv[])
+{
+    WCHAR szzHwId[0x100] =
+        L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0" _L(TAP_WIN_COMPONENT_ID) L"\0"
+                                                                          L"ovpn-dco\0";
+
+    for (int i = 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--hwid") == 0)
+        {
+            memset(szzHwId, 0, sizeof(szzHwId));
+            ++i;
+            memcpy_s(szzHwId,
+                     sizeof(szzHwId) - 2 * sizeof(WCHAR),
+                     argv[i], wcslen(argv[i]) * sizeof(WCHAR));
+        }
+        else
+        {
+            fwprintf(stderr,
+                     L"Unknown option \"%ls"
+                     L"\". Please, use \"tapctl help list\" to list supported options. Ignored.\n",
+                     argv[i]);
+        }
+    }
+
+    struct tap_adapter_node *adapter_list = NULL;
+    DWORD dwResult = tap_list_adapters(NULL, szzHwId, &adapter_list);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x).\n", dwResult);
+        return 1;
+    }
+
+    for (struct tap_adapter_node *adapter = adapter_list; adapter; adapter = adapter->pNext)
+    {
+        LPOLESTR adapter_id = NULL;
+        StringFromIID((REFIID)&adapter->guid, &adapter_id);
+        fwprintf(stdout,
+                 L"%ls\t%"
+                 L"ls\n",
+                 adapter_id, adapter->szName);
+        CoTaskMemFree(adapter_id);
+    }
+
+    tap_free_adapter_list(adapter_list);
+
+    return 0;
+}
+
+static int
+command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired)
+{
+    if (argc < 3)
+    {
+        fwprintf(stderr,
+                 L"Missing adapter GUID or name. Please, use \"tapctl help delete\" for usage info.\n");
+        return 1;
+    }
+
+    GUID guidAdapter;
+    if (FAILED(IIDFromString(argv[2], (LPIID)&guidAdapter)))
+    {
+        struct tap_adapter_node *adapter_list = NULL;
+        DWORD dwResult = tap_list_adapters(NULL, NULL, &adapter_list);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x).\n", dwResult);
+            return 1;
+        }
+
+        BOOL found = FALSE;
+        for (struct tap_adapter_node *adapter = adapter_list; adapter; adapter = adapter->pNext)
+        {
+            if (wcsicmp(argv[2], adapter->szName) == 0)
+            {
+                memcpy(&guidAdapter, &adapter->guid, sizeof(GUID));
+                found = TRUE;
+                break;
+            }
+        }
+
+        tap_free_adapter_list(adapter_list);
+
+        if (!found)
+        {
+            fwprintf(stderr, L"\"%ls\" adapter not found.\n", argv[2]);
+            return 1;
+        }
+    }
+
+    DWORD dwResult = tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        fwprintf(stderr,
+                 L"Deleting adapter \"%ls"
+                 L"\" failed (error 0x%x).\n",
+                 argv[2], dwResult);
+        return 1;
+    }
+
+    return 0;
+}
+
 /**
  * Program entry point
  */
@@ -248,215 +440,17 @@
     }
     else if (wcsicmp(argv[1], L"create") == 0)
     {
-        LPCWSTR szName = NULL;
-        LPCWSTR szHwId = L"root\\" _L(TAP_WIN_COMPONENT_ID);
-
-        /* Parse options. */
-        for (int i = 2; i < argc; i++)
-        {
-            if (wcsicmp(argv[i], L"--name") == 0)
-            {
-                szName = argv[++i];
-            }
-            else if (wcsicmp(argv[i], L"--hwid") == 0)
-            {
-                szHwId = argv[++i];
-            }
-            else
-            {
-                fwprintf(
-                    stderr,
-                    L"Unknown option \"%ls"
-                    L"\". Please, use \"tapctl help create\" to list supported options. Ignored.\n",
-                    argv[i]);
-            }
-        }
-
-        /* Create TUN/TAP adapter. */
-        GUID guidAdapter;
-        LPOLESTR szAdapterId = NULL;
-        DWORD dwResult =
-            tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, &bRebootRequired, &guidAdapter);
-        if (dwResult != ERROR_SUCCESS)
-        {
-            fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x).\n", dwResult);
-            iResult = 1;
-            goto quit;
-        }
-
-        /* Get existing network adapters. */
-        struct tap_adapter_node *pAdapterList = NULL;
-        dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
-        if (dwResult != ERROR_SUCCESS)
-        {
-            fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", dwResult);
-            iResult = 1;
-            goto create_delete_adapter;
-        }
-
-        LPWSTR adapter_name =
-            szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, pAdapterList);
-        if (adapter_name)
-        {
-            /* Check for duplicates when name was specified,
-             * otherwise get_adapter_default_name() takes care of it */
-            if (szName && !is_adapter_name_available(adapter_name, pAdapterList, TRUE))
-            {
-                iResult = 1;
-                goto create_cleanup_pAdapterList;
-            }
-
-            /* Rename the adapter. */
-            dwResult = tap_set_adapter_name(&guidAdapter, adapter_name, FALSE);
-            if (dwResult != ERROR_SUCCESS)
-            {
-                StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-                fwprintf(stderr,
-                         L"Renaming TUN/TAP adapter %ls"
-                         L" to \"%ls\" failed (error 0x%x).\n",
-                         szAdapterId, adapter_name, dwResult);
-                CoTaskMemFree(szAdapterId);
-                iResult = 1;
-                goto quit;
-            }
-        }
-
-        iResult = 0;
-
-create_cleanup_pAdapterList:
-        free(adapter_name);
-
-        tap_free_adapter_list(pAdapterList);
-        if (iResult)
-        {
-            goto create_delete_adapter;
-        }
-
-        /* Output adapter GUID. */
-        StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-        fwprintf(stdout, L"%ls\n", szAdapterId);
-        CoTaskMemFree(szAdapterId);
-
-        iResult = 0;
-        goto quit;
-
-create_delete_adapter:
-        tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
-        iResult = 1;
+        iResult = command_create(argc, argv, &bRebootRequired);
         goto quit;
     }
     else if (wcsicmp(argv[1], L"list") == 0)
     {
-        WCHAR szzHwId[0x100] =
-            L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0" _L(TAP_WIN_COMPONENT_ID) L"\0"
-                                                                              L"ovpn-dco\0";
-
-        /* Parse options. */
-        for (int i = 2; i < argc; i++)
-        {
-            if (wcsicmp(argv[i], L"--hwid") == 0)
-            {
-                memset(szzHwId, 0, sizeof(szzHwId));
-                ++i;
-                memcpy_s(szzHwId,
-                         sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requires double zero termination*/,
-                         argv[i], wcslen(argv[i]) * sizeof(WCHAR));
-            }
-            else
-            {
-                fwprintf(
-                    stderr,
-                    L"Unknown option \"%ls"
-                    L"\". Please, use \"tapctl help list\" to list supported options. Ignored.\n",
-                    argv[i]);
-            }
-        }
-
-        /* Output list of adapters with given hardware ID. */
-        struct tap_adapter_node *pAdapterList = NULL;
-        DWORD dwResult = tap_list_adapters(NULL, szzHwId, &pAdapterList);
-        if (dwResult != ERROR_SUCCESS)
-        {
-            fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x).\n", dwResult);
-            iResult = 1;
-            goto quit;
-        }
-
-        for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
-        {
-            LPOLESTR szAdapterId = NULL;
-            StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
-            fwprintf(stdout,
-                     L"%ls\t%"
-                     L"ls\n",
-                     szAdapterId, pAdapter->szName);
-            CoTaskMemFree(szAdapterId);
-        }
-
-        iResult = 0;
-        tap_free_adapter_list(pAdapterList);
+        iResult = command_list(argc, argv);
+        goto quit;
     }
     else if (wcsicmp(argv[1], L"delete") == 0)
     {
-        if (argc < 3)
-        {
-            fwprintf(
-                stderr,
-                L"Missing adapter GUID or name. Please, use \"tapctl help delete\" for usage info.\n");
-            return 1;
-        }
-
-        GUID guidAdapter;
-        if (FAILED(IIDFromString(argv[2], (LPIID)&guidAdapter)))
-        {
-            /* The argument failed to covert to GUID. Treat it as the adapter name. */
-            struct tap_adapter_node *pAdapterList = NULL;
-            DWORD dwResult = tap_list_adapters(NULL, NULL, &pAdapterList);
-            if (dwResult != ERROR_SUCCESS)
-            {
-                fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x).\n", dwResult);
-                iResult = 1;
-                goto quit;
-            }
-
-            for (struct tap_adapter_node *pAdapter = pAdapterList;; pAdapter = pAdapter->pNext)
-            {
-                if (pAdapter == NULL)
-                {
-                    fwprintf(stderr, L"\"%ls\" adapter not found.\n", argv[2]);
-                    iResult = 1;
-                    goto delete_cleanup_pAdapterList;
-                }
-                else if (wcsicmp(argv[2], pAdapter->szName) == 0)
-                {
-                    memcpy(&guidAdapter, &pAdapter->guid, sizeof(GUID));
-                    break;
-                }
-            }
-
-            iResult = 0;
-
-delete_cleanup_pAdapterList:
-            tap_free_adapter_list(pAdapterList);
-            if (iResult)
-            {
-                goto quit;
-            }
-        }
-
-        /* Delete the network adapter. */
-        DWORD dwResult = tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
-        if (dwResult != ERROR_SUCCESS)
-        {
-            fwprintf(stderr,
-                     L"Deleting adapter \"%ls"
-                     L"\" failed (error 0x%x).\n",
-                     argv[2], dwResult);
-            iResult = 1;
-            goto quit;
-        }
-
-        iResult = 0;
+        iResult = command_delete(argc, argv, &bRebootRequired);
         goto quit;
     }
     else

