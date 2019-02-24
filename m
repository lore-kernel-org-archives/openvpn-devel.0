From: Simon Rozman <simon@...2293...>
Date: Sun, 24 Feb 2019 19:16:21 +0100
Message-Id: <20190224181621.27020-1-simon@...2293...>
In-Reply-To: <20190120130813.GY962@...1296...>
References: <20190120130813.GY962@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Limit tapctl.exe and openvpnmsica.dll to
 TAP-Windows6 adapters only
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

Note: Hardware ID check is used selectively. When naming the adapter, we
still need to check all existing adapters to prevent duplicate names.
When listing or removing adapters by name, the operation is limited to
TUN-Windows6 adapters only.

This patch follows Gert's recommendations from [openvpn-devel].

Signed-off-by: Simon Rozman <simon@...2293...>
Message-ID: <20190120130813.GY962@...1296...>
---
 src/openvpnmsica/msica_op.c     | 16 ++++----
 src/openvpnmsica/openvpnmsica.c | 69 +++++--------------------------
 src/tapctl/main.c               | 20 ++++-----
 src/tapctl/tap.c                | 72 ++++++++++++++++++++++++---------
 src/tapctl/tap.h                |  8 +++-
 5 files changed, 89 insertions(+), 96 deletions(-)

diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
index fec1ef8a..8912e92a 100644
--- a/src/openvpnmsica/msica_op.c
+++ b/src/openvpnmsica/msica_op.c
@@ -443,9 +443,9 @@ msica_op_tap_interface_create_exec(
         }
     }
 
-    /* Get available network interfaces. */
+    /* Get all available network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
@@ -598,9 +598,9 @@ msica_op_tap_interface_delete_by_name_exec(
         }
     }
 
-    /* Get available network interfaces. */
+    /* Get available TUN/TAP interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
@@ -656,9 +656,9 @@ msica_op_tap_interface_delete_by_guid_exec(
         }
     }
 
-    /* Get available network interfaces. */
+    /* Get all available interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
@@ -715,9 +715,9 @@ msica_op_tap_interface_set_name_exec(
         }
     }
 
-    /* Get available network interfaces. */
+    /* Get all available network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 2477e81a..b134bc9b 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -475,9 +475,9 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    /* Get available network interfaces. */
+    /* Get all TUN/TAP network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    uiResult = tap_list_interfaces(NULL, &pInterfaceList);
+    uiResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
     if (uiResult != ERROR_SUCCESS)
     {
         goto cleanup_CoInitialize;
@@ -516,58 +516,15 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
         }
     }
 
-    /* Enumerate interfaces. */
-    struct interface_node
+    if (pInterfaceList != NULL)
     {
-        const struct tap_interface_node *iface;
-        struct interface_node *next;
-    } *interfaces_head = NULL, *interfaces_tail = NULL;
-    size_t interface_count = 0;
-    MSIHANDLE hRecord = MsiCreateRecord(1);
-    for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
-    {
-        for (LPCTSTR hwid = pInterface->szzHardwareIDs; hwid[0]; hwid += _tcslen(hwid) + 1)
+        /* Count interfaces. */
+        size_t interface_count = 0;
+        for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
         {
-            if (_tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
-                || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
-            {
-                /* TAP interface found. */
-
-                /* Report the GUID of the interface to installer. */
-                LPOLESTR szInterfaceId = NULL;
-                StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
-                MsiRecordSetString(hRecord, 1, szInterfaceId);
-                MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-                CoTaskMemFree(szInterfaceId);
-
-                /* Append interface to the list. */
-                struct interface_node *node = (struct interface_node *)malloc(sizeof(struct interface_node));
-                if (node == NULL)
-                {
-                    MsiCloseHandle(hRecord);
-                    msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct interface_node));
-                    uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
-                }
-
-                node->iface = pInterface;
-                node->next = NULL;
-                if (interfaces_head)
-                {
-                    interfaces_tail = interfaces_tail->next = node;
-                }
-                else
-                {
-                    interfaces_head = interfaces_tail = node;
-                }
-                interface_count++;
-                break;
-            }
+            interface_count++;
         }
-    }
-    MsiCloseHandle(hRecord);
 
-    if (interface_count)
-    {
         /* Prepare semicolon delimited list of TAP interface ID(s) and active TAP interface ID(s). */
         LPTSTR
             szTAPInterfaces     = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
@@ -587,11 +544,11 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
             uiResult = ERROR_OUTOFMEMORY; goto cleanup_szTAPInterfaces;
         }
 
-        while (interfaces_head)
+        for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
         {
             /* Convert interface GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
             LPOLESTR szInterfaceId = NULL;
-            StringFromIID((REFIID)&interfaces_head->iface->guid, &szInterfaceId);
+            StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
 
             /* Append to the list of TAP interface ID(s). */
             if (szTAPInterfaces < szTAPInterfacesTail)
@@ -604,11 +561,11 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
             /* If this interface is active (connected), add it to the list of active TAP interface ID(s). */
             for (PIP_ADAPTER_ADDRESSES p = pAdapterAdresses; p; p = p->Next)
             {
-                OLECHAR szId[38 + 1];
+                OLECHAR szId[38 /*GUID*/ + 1 /*terminator*/];
                 GUID guid;
                 if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0
                     && SUCCEEDED(IIDFromString(szId, &guid))
-                    && memcmp(&guid, &interfaces_head->iface->guid, sizeof(GUID)) == 0)
+                    && memcmp(&guid, &pInterface->guid, sizeof(GUID)) == 0)
                 {
                     if (p->OperStatus == IfOperStatusUp)
                     {
@@ -624,10 +581,6 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
                 }
             }
             CoTaskMemFree(szInterfaceId);
-
-            struct interface_node *p = interfaces_head;
-            interfaces_head = interfaces_head->next;
-            free(p);
         }
         szTAPInterfacesTail      [0] = 0;
         szTAPInterfacesActiveTail[0] = 0;
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 295366b4..04c03ddc 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -58,7 +58,7 @@ static const TCHAR usage_message[] =
     TEXT("Commands:\n")
     TEXT("\n")
     TEXT("create     Create a new TUN/TAP interface\n")
-    TEXT("list       List network interfaces\n")
+    TEXT("list       List TUN/TAP interfaces\n")
     TEXT("delete     Delete specified network interface\n")
     TEXT("help       Display this text\n")
     TEXT("\n")
@@ -90,7 +90,7 @@ static const TCHAR usage_message_create[] =
 static const TCHAR usage_message_list[] =
     TEXT("%s\n")
     TEXT("\n")
-    TEXT("Lists network interfaces\n")
+    TEXT("Lists TUN/TAP interfaces\n")
     TEXT("\n")
     TEXT("Usage:\n")
     TEXT("\n")
@@ -98,7 +98,7 @@ static const TCHAR usage_message_list[] =
     TEXT("\n")
     TEXT("Output:\n")
     TEXT("\n")
-    TEXT("This command prints all network interfaces to stdout.                          \n")
+    TEXT("This command prints all TUN/TAP interfaces to stdout.                          \n")
 ;
 
 static const TCHAR usage_message_delete[] =
@@ -200,9 +200,9 @@ _tmain(int argc, LPCTSTR argv[])
 
         if (szName)
         {
-            /* Get the list of available interfaces. */
+            /* Get the list of all available interfaces. */
             struct tap_interface_node *pInterfaceList = NULL;
-            dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+            dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
             if (dwResult != ERROR_SUCCESS)
             {
                 _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
@@ -257,12 +257,12 @@ create_delete_interface:
     }
     else if (_tcsicmp(argv[1], TEXT("list")) == 0)
     {
-        /* Output list of network interfaces. */
+        /* Output list of TUN/TAP interfaces. */
         struct tap_interface_node *pInterfaceList = NULL;
-        DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+        DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
         if (dwResult != ERROR_SUCCESS)
         {
-            _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
+            _ftprintf(stderr, TEXT("Enumerating TUN/TAP interfaces failed (error 0x%x).\n"), dwResult);
             iResult = 1; goto quit;
         }
 
@@ -290,10 +290,10 @@ create_delete_interface:
         {
             /* The argument failed to covert to GUID. Treat it as the interface name. */
             struct tap_interface_node *pInterfaceList = NULL;
-            DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+            DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
             if (dwResult != ERROR_SUCCESS)
             {
-                _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
+                _ftprintf(stderr, TEXT("Enumerating TUN/TAP interfaces failed (error 0x%x).\n"), dwResult);
                 iResult = 1; goto quit;
             }
 
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index b2cb2dca..c1f3f053 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -953,7 +953,8 @@ cleanup_szInterfaceId:
 DWORD
 tap_list_interfaces(
     _In_opt_ HWND hwndParent,
-    _Out_ struct tap_interface_node **ppInterface)
+    _Out_ struct tap_interface_node **ppInterface,
+    _In_ BOOL bAll)
 {
     DWORD dwResult;
 
@@ -1015,19 +1016,6 @@ tap_list_interfaces(
             }
         }
 
-        /* Get interface GUID. */
-        GUID guidInterface;
-        dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
-        if (dwResult != ERROR_SUCCESS)
-        {
-            /* Something is wrong with this device. Skip it. */
-            continue;
-        }
-
-        /* Get the interface GUID as string. */
-        LPOLESTR szInterfaceId = NULL;
-        StringFromIID((REFIID)&guidInterface, &szInterfaceId);
-
         /* Get device hardware ID(s). */
         DWORD dwDataType = REG_NONE;
         LPTSTR szzDeviceHardwareIDs = NULL;
@@ -1039,9 +1027,57 @@ tap_list_interfaces(
             (LPVOID)&szzDeviceHardwareIDs);
         if (dwResult != ERROR_SUCCESS)
         {
-            goto cleanup_szInterfaceId;
+            /* Something is wrong with this device. Skip it. */
+            continue;
         }
 
+        /* Check that hardware ID is REG_SZ/REG_MULTI_SZ, and optionally if it matches ours. */
+        if (dwDataType == REG_SZ)
+        {
+            if (!bAll && _tcsicmp(szzDeviceHardwareIDs, szzHardwareIDs) != 0)
+            {
+                /* This is not our device. Skip it. */
+                goto cleanup_szzDeviceHardwareIDs;
+            }
+        }
+        else if (dwDataType == REG_MULTI_SZ)
+        {
+            if (!bAll)
+            {
+                for (LPTSTR szHwdID = szzDeviceHardwareIDs;; szHwdID += _tcslen(szHwdID) + 1)
+                {
+                    if (szHwdID[0] == 0)
+                    {
+                        /* This is not our device. Skip it. */
+                        goto cleanup_szzDeviceHardwareIDs;
+                    }
+                    else if (_tcsicmp(szHwdID, szzHardwareIDs) == 0)
+                    {
+                        /* This is our device. */
+                        break;
+                    }
+                }
+            }
+        }
+        else
+        {
+            /* Unexpected hardware ID format. Skip device. */
+            goto cleanup_szzDeviceHardwareIDs;
+        }
+
+        /* Get interface GUID. */
+        GUID guidInterface;
+        dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            /* Something is wrong with this device. Skip it. */
+            goto cleanup_szzDeviceHardwareIDs;
+        }
+
+        /* Get the interface GUID as string. */
+        LPOLESTR szInterfaceId = NULL;
+        StringFromIID((REFIID)&guidInterface, &szInterfaceId);
+
         /* Render registry key path. */
         TCHAR szRegKey[INTERFACE_REGKEY_PATH_MAX];
         _stprintf_s(
@@ -1062,7 +1098,7 @@ tap_list_interfaces(
         {
             SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
-            goto cleanup_szzDeviceHardwareIDs;
+            goto cleanup_szInterfaceId;
         }
 
         /* Read interface name. */
@@ -1108,10 +1144,10 @@ cleanup_szName:
         free(szName);
 cleanup_hKey:
         RegCloseKey(hKey);
-cleanup_szzDeviceHardwareIDs:
-        free(szzDeviceHardwareIDs);
 cleanup_szInterfaceId:
         CoTaskMemFree(szInterfaceId);
+cleanup_szzDeviceHardwareIDs:
+        free(szzDeviceHardwareIDs);
     }
 
     dwResult = ERROR_SUCCESS;
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index c09c4766..2437d056 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -55,7 +55,7 @@ tap_create_interface(
 
 
 /**
- * Deletes a TUN/TAP interface.
+ * Deletes an interface.
  *
  * @param hwndParent    A handle to the top-level window to use for any user interface that is
  *                      related to non-device-specific actions (such as a select-device dialog
@@ -120,12 +120,16 @@ struct tap_interface_node
  *                      the list. After the list is no longer required, free it using
  *                      tap_free_interface_list().
  *
+ * @param bAll          When TRUE, all network interfaces found are added to the list. When
+ *                      FALSE, only TUN/TAP interfaces found are added.
+ *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
 DWORD
 tap_list_interfaces(
     _In_opt_ HWND hwndParent,
-    _Out_ struct tap_interface_node **ppInterfaceList);
+    _Out_ struct tap_interface_node **ppInterfaceList,
+    _In_ BOOL bAll);
 
 
 /**
-- 
2.19.0.windows.1


