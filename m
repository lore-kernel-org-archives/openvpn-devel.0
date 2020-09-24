From: Simon Rozman <simon@...2293...>
Date: Thu, 24 Sep 2020 08:59:15 +0200
Message-Id: <20200924065915.164-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openvpnmsica: Skip legacy TAP-Windows6
 adapters from evaluation
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

Legacy TAP-Windows6 adapters (marked as IF_TYPE_ETHERNET_CSMACD 0x6)
fail to upgrade to the new driver on Windows 7: Device cannot start
(Code 10).

Ignoring those adapters on Windows 7 triggers creation of a new TAP
adapter on setup eliminating the need for user intervention.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 13 ++++++++++++
 src/tapctl/tap.c                | 37 +++++++++++++++++++++++++++++----
 src/tapctl/tap.h                |  3 +++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index f203f736..dd6ecd74 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -303,10 +303,18 @@ find_adapters(
         }
     }
 
+    OSVERSIONINFOEX osvi = { sizeof(OSVERSIONINFOEX), HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8) };
+    DWORDLONG const dwlConditionMask = VerSetConditionMask(VerSetConditionMask(0, VER_MAJORVERSION, VER_GREATER_EQUAL), VER_MINORVERSION, VER_GREATER_EQUAL);
+    BOOL bSkipLegacyAdapters = !VerifyVersionInfo(&osvi, VER_MAJORVERSION | VER_MINORVERSION, dwlConditionMask);
+
     /* Count adapters. */
     size_t adapter_count = 0;
     for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
     {
+        if (bSkipLegacyAdapters && pAdapter->dwIfType != IF_TYPE_PROP_VIRTUAL)
+        {
+            continue;
+        }
         adapter_count++;
     }
 
@@ -331,6 +339,11 @@ find_adapters(
 
     for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
     {
+        if (bSkipLegacyAdapters && pAdapter->dwIfType != IF_TYPE_PROP_VIRTUAL)
+        {
+            continue;
+        }
+
         /* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
         LPOLESTR szAdapterId = NULL;
         StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index dd4a10a3..0dfc7555 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -29,6 +29,7 @@
 
 #include <windows.h>
 #include <cfgmgr32.h>
+#include <ipifcons.h>
 #include <objbase.h>
 #include <setupapi.h>
 #include <stdio.h>
@@ -551,6 +552,8 @@ get_reg_string(
  *
  * @param pguidAdapter  A pointer to GUID that receives network adapter ID.
  *
+ * @param pdwIfType     A pointer to DWORD that receives interface type.
+ *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
 static DWORD
@@ -558,7 +561,8 @@ get_net_adapter_guid(
     _In_ HDEVINFO hDeviceInfoSet,
     _In_ PSP_DEVINFO_DATA pDeviceInfoData,
     _In_ int iNumAttempts,
-    _Out_ LPGUID pguidAdapter)
+    _Out_ LPGUID pguidAdapter,
+    _Out_opt_ LPDWORD pdwIfType)
 {
     DWORD dwResult = ERROR_BAD_ARGUMENTS;
 
@@ -613,6 +617,23 @@ get_net_adapter_guid(
 
         dwResult = SUCCEEDED(CLSIDFromString(szCfgGuidString, (LPCLSID)pguidAdapter)) ? ERROR_SUCCESS : ERROR_INVALID_DATA;
         free(szCfgGuidString);
+
+        if (pdwIfType)
+        {
+            DWORD dwValueType = REG_NONE, dwSize = sizeof(*pdwIfType);
+            dwResult = RegQueryValueEx(
+                hKey,
+                TEXT("*IfType"),
+                NULL,
+                &dwValueType,
+                (BYTE *)pdwIfType,
+                &dwSize);
+            if (dwResult != ERROR_SUCCESS || dwValueType != REG_DWORD || dwSize != sizeof(*pdwIfType))
+            {
+                *pdwIfType = IF_TYPE_OTHER;
+            }
+        }
+
         break;
     }
 
@@ -839,7 +860,7 @@ tap_create_adapter(
     }
 
     /* Get network adapter ID from registry. Retry for max 30sec. */
-    dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 30, pguidAdapter);
+    dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 30, pguidAdapter, NULL);
 
 cleanup_remove_device:
     if (dwResult != ERROR_SUCCESS)
@@ -981,7 +1002,7 @@ execute_on_first_adapter(
 
         /* Get adapter GUID. */
         GUID guidAdapter;
-        dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 1, &guidAdapter);
+        dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 1, &guidAdapter, NULL);
         if (dwResult != ERROR_SUCCESS)
         {
             /* Something is wrong with this device. Skip it. */
@@ -1259,7 +1280,8 @@ tap_list_adapters(
 
         /* Get adapter GUID. */
         GUID guidAdapter;
-        dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 1, &guidAdapter);
+        DWORD dwIfType;
+        dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 1, &guidAdapter, &dwIfType);
         if (dwResult != ERROR_SUCCESS)
         {
             /* Something is wrong with this device. Skip it. */
@@ -1321,6 +1343,7 @@ tap_list_adapters(
         memcpy(node->szzHardwareIDs, szzDeviceHardwareIDs, hwid_size);
         node->szName = (LPTSTR)((LPBYTE)node->szzHardwareIDs + hwid_size);
         memcpy(node->szName, szName, name_size);
+        node->dwIfType = dwIfType;
         node->pNext = NULL;
         if (pAdapterTail)
         {
@@ -1332,6 +1355,12 @@ tap_list_adapters(
             *ppAdapter = pAdapterTail = node;
         }
 
+        if (CM_Get_DevNode_Status(&node->ulStatus, &node->ulProblemNumber, devinfo_data.DevInst, 0) != CR_SUCCESS)
+        {
+            node->ulStatus = 0;
+            node->ulProblemNumber = 0;
+        }
+
 cleanup_szName:
         free(szName);
 cleanup_hKey:
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 63d791c9..5d356cb6 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -138,6 +138,9 @@ struct tap_adapter_node
     GUID guid;             /** Adapter GUID */
     LPTSTR szzHardwareIDs; /** Device hardware ID(s) */
     LPTSTR szName;         /** Adapter name */
+    DWORD dwIfType;        /** Interface type. One of IF_TYPE_* constants. */
+    ULONG ulStatus;        /** Device status. A bitwise combination of the DN_* constants. */
+    ULONG ulProblemNumber; /** When ulStatus has DN_HAS_PROBLEM set, this member is one of the CM_PROB_* constants. */
 
     struct tap_adapter_node *pNext; /** Pointer to next adapter */
 };
-- 
2.28.0.windows.1


