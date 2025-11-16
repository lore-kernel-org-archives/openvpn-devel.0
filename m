From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 12:32:24 +0100
Message-ID: <20251116113230.31872-1-gert@...1296...>
In-Reply-To: <gerrit.1762950770000.Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796@...2715...>
References: <gerrit.1762950770000.Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tapctl: make output of 'list' and
 'create' commands more verbose
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

Print adapter GUID, name and hwid.

Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1372
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1372
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 4d25998..15c25ae 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -80,7 +80,8 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints newly created VPN network adapter's GUID to stdout.        \n"
+    L"This command prints newly created VPN network adapter's GUID, name and         \n"
+    L"hardware ID to stdout.                                                         \n"
 ;
 
 static const WCHAR usage_message_list[] =
@@ -99,7 +100,7 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints all VPN network adapters to stdout.                        \n"
+    L"This command prints VPN network adapter GUID, name and hardware ID to stdout.  \n"
 ;
 
 static const WCHAR usage_message_delete[] =
@@ -211,10 +212,12 @@
     LPCWSTR szName = NULL;
     LPCWSTR szHwId = L"root\\" _L(TAP_WIN_COMPONENT_ID);
     struct tap_adapter_node *adapter_list = NULL;
-    LPWSTR adapter_name = NULL;
+    LPWSTR rename_name = NULL;
+    LPWSTR final_name = NULL;
     LPOLESTR adapter_id = NULL;
     GUID guidAdapter;
     int result = 1;
+    BOOL delete_created_adapter = FALSE;
 
     for (int i = 2; i < argc; i++)
     {
@@ -247,45 +250,56 @@
     if (dwResult != ERROR_SUCCESS)
     {
         fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", dwResult);
-        tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
-        return result;
+        delete_created_adapter = TRUE;
+        goto cleanup;
     }
 
-    adapter_name = szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list);
-    if (adapter_name)
+    rename_name = szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list);
+    if (rename_name)
     {
-        if (szName && !is_adapter_name_available(adapter_name, adapter_list, TRUE))
+        if (szName && !is_adapter_name_available(rename_name, adapter_list, TRUE))
         {
-            tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+            delete_created_adapter = TRUE;
             goto cleanup;
         }
 
-        dwResult = tap_set_adapter_name(&guidAdapter, adapter_name, FALSE);
-        if (dwResult != ERROR_SUCCESS)
+        dwResult = tap_set_adapter_name(&guidAdapter, rename_name, FALSE);
+        if (dwResult == ERROR_SUCCESS)
+        {
+            final_name = rename_name;
+            rename_name = NULL;
+        }
+        else
         {
             StringFromIID((REFIID)&guidAdapter, &adapter_id);
             fwprintf(stderr,
                      L"Renaming TUN/TAP adapter %ls"
                      L" to \"%ls\" failed (error 0x%x).\n",
-                     adapter_id, adapter_name, dwResult);
+                     adapter_id, rename_name, dwResult);
             CoTaskMemFree(adapter_id);
-            goto cleanup;
         }
     }
 
     result = 0;
 
 cleanup:
-    free(adapter_name);
     tap_free_adapter_list(adapter_list);
+    free(rename_name);
 
-    if (result == 0)
+    if (result == 0 && final_name)
     {
         StringFromIID((REFIID)&guidAdapter, &adapter_id);
-        fwprintf(stdout, L"%ls\n", adapter_id);
+        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, final_name, szHwId ? szHwId : L"");
         CoTaskMemFree(adapter_id);
     }
 
+    free(final_name);
+
+    if (result != 0 && delete_created_adapter)
+    {
+        tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+    }
+
     return result;
 }
 
@@ -327,10 +341,11 @@
     {
         LPOLESTR adapter_id = NULL;
         StringFromIID((REFIID)&adapter->guid, &adapter_id);
-        fwprintf(stdout,
-                 L"%ls\t%"
-                 L"ls\n",
-                 adapter_id, adapter->szName);
+        const WCHAR *name = adapter->szName ? adapter->szName : L"";
+        const WCHAR *hwid = (adapter->szzHardwareIDs && adapter->szzHardwareIDs[0])
+                                ? adapter->szzHardwareIDs
+                                : L"";
+        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, name, hwid);
         CoTaskMemFree(adapter_id);
     }
 

