From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 23 Sep 2019 12:08:02 +0300
Message-Id: <1569229682-9731-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tapctl: add optional "hardware id" parameter
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

If parameter is not specified, default value "root\tap0901"
is used.

This enables tapctl to work with different tun drivers,
like "tapoas" (from OpenVPN Connect) or "wintun".

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/msica_op.c     | 10 +++++-----
 src/openvpnmsica/openvpnmsica.c |  2 +-
 src/tapctl/main.c               | 37 +++++++++++++++++++++++++++++++++----
 src/tapctl/tap.c                | 24 ++++++++++++++++++------
 src/tapctl/tap.h                | 10 ++++++++++
 5 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
index 3b9878d..63aa6c8 100644
--- a/src/openvpnmsica/msica_op.c
+++ b/src/openvpnmsica/msica_op.c
@@ -446,7 +446,7 @@ msica_op_tap_interface_create_exec(
 
     /* Get all available network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
+    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
@@ -457,7 +457,7 @@ msica_op_tap_interface_create_exec(
                 /* No interface with a same name found. Create one. */
                 BOOL bRebootRequired = FALSE;
                 GUID guidInterface;
-                dwResult = tap_create_interface(NULL, NULL, &bRebootRequired, &guidInterface);
+                dwResult = tap_create_interface(NULL, NULL, NULL, &bRebootRequired, &guidInterface);
                 if (dwResult == ERROR_SUCCESS)
                 {
                     /* Set interface name. */
@@ -601,7 +601,7 @@ msica_op_tap_interface_delete_by_name_exec(
 
     /* Get available TUN/TAP interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
+    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
@@ -659,7 +659,7 @@ msica_op_tap_interface_delete_by_guid_exec(
 
     /* Get all available interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
+    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
@@ -718,7 +718,7 @@ msica_op_tap_interface_set_name_exec(
 
     /* Get all available network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
+    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index f5ad229..16381ea 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -478,7 +478,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 
     /* Get all TUN/TAP network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
-    uiResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
+    uiResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
     if (uiResult != ERROR_SUCCESS)
     {
         goto cleanup_CoInitialize;
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 04c03dd..bf21586 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -81,7 +81,9 @@ static const TCHAR usage_message_create[] =
     TEXT("               specified, a default interface name is chosen by Windows.       \n")
     TEXT("               Note: This name can also be specified as OpenVPN's --dev-node   \n")
     TEXT("               option.                                                         \n")
-    TEXT("\n")
+    TEXT("--hwid <hwid>  Interface hardware id. Default value is root\\tap0901, which    \n")
+    TEXT("               describes tap-windows6 driver. To work with wintun driver,      \n")
+    TEXT("               specify 'wintun'.                                               \n")
     TEXT("Output:\n")
     TEXT("\n")
     TEXT("This command prints newly created TUN/TAP interface's GUID to stdout.          \n")
@@ -96,6 +98,11 @@ static const TCHAR usage_message_list[] =
     TEXT("\n")
     TEXT("tapctl list\n")
     TEXT("\n")
+    TEXT("Options:\n")
+    TEXT("\n")
+    TEXT("--hwid <hwid>  Interface hardware id. Default value is root\\tap0901, which    \n")
+    TEXT("               describes tap-windows6 driver. To work with wintun driver,      \n")
+    TEXT("               specify 'wintun'.                                               \n")
     TEXT("Output:\n")
     TEXT("\n")
     TEXT("This command prints all TUN/TAP interfaces to stdout.                          \n")
@@ -170,6 +177,7 @@ _tmain(int argc, LPCTSTR argv[])
     else if (_tcsicmp(argv[1], TEXT("create")) == 0)
     {
         LPCTSTR szName = NULL;
+        LPCTSTR szHwId = NULL;
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
@@ -179,6 +187,11 @@ _tmain(int argc, LPCTSTR argv[])
                 szName = argv[++i];
             }
             else
+            if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
+            {
+                szHwId = argv[++i];
+            }
+            else
             {
                 _ftprintf(stderr, TEXT("Unknown option \"%s\". Please, use \"tapctl help create\" to list supported options. Ignored.\n"), argv[i]);
             }
@@ -190,6 +203,7 @@ _tmain(int argc, LPCTSTR argv[])
         DWORD dwResult = tap_create_interface(
             NULL,
             TEXT("Virtual Ethernet"),
+            szHwId,
             &bRebootRequired,
             &guidInterface);
         if (dwResult != ERROR_SUCCESS)
@@ -202,7 +216,7 @@ _tmain(int argc, LPCTSTR argv[])
         {
             /* Get the list of all available interfaces. */
             struct tap_interface_node *pInterfaceList = NULL;
-            dwResult = tap_list_interfaces(NULL, &pInterfaceList, TRUE);
+            dwResult = tap_list_interfaces(NULL, szHwId, &pInterfaceList, TRUE);
             if (dwResult != ERROR_SUCCESS)
             {
                 _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
@@ -257,9 +271,24 @@ create_delete_interface:
     }
     else if (_tcsicmp(argv[1], TEXT("list")) == 0)
     {
+        LPCTSTR szHwId = NULL;
+
+        /* Parse options. */
+        for (int i = 2; i < argc; i++)
+        {
+            if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
+            {
+                szHwId = argv[++i];
+            }
+            else
+            {
+                _ftprintf(stderr, TEXT("Unknown option \"%s\". Please, use \"tapctl help list\" to list supported options. Ignored.\n"), argv[i]);
+            }
+        }
+
         /* Output list of TUN/TAP interfaces. */
         struct tap_interface_node *pInterfaceList = NULL;
-        DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
+        DWORD dwResult = tap_list_interfaces(NULL, szHwId, &pInterfaceList, FALSE);
         if (dwResult != ERROR_SUCCESS)
         {
             _ftprintf(stderr, TEXT("Enumerating TUN/TAP interfaces failed (error 0x%x).\n"), dwResult);
@@ -290,7 +319,7 @@ create_delete_interface:
         {
             /* The argument failed to covert to GUID. Treat it as the interface name. */
             struct tap_interface_node *pInterfaceList = NULL;
-            DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList, FALSE);
+            DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
             if (dwResult != ERROR_SUCCESS)
             {
                 _ftprintf(stderr, TEXT("Enumerating TUN/TAP interfaces failed (error 0x%x).\n"), dwResult);
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index e75db35..464ce72 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -41,7 +41,7 @@
 
 const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
 
-const static TCHAR szzHardwareIDs[] = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
+const static TCHAR szzDefaultHardwareIDs[] = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
 
 const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
 #define INTERFACE_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
@@ -448,6 +448,7 @@ DWORD
 tap_create_interface(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
+    _In_opt_ LPCTSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
     _Out_ LPGUID pguidInterface)
 {
@@ -459,6 +460,11 @@ tap_create_interface(
         return ERROR_BAD_ARGUMENTS;
     }
 
+    if (szHwId == NULL)
+    {
+        szHwId = szzDefaultHardwareIDs;
+    }
+
     /* Create an empty device info set for network adapter device class. */
     HDEVINFO hDevInfoList = SetupDiCreateDeviceInfoList(&GUID_DEVCLASS_NET, hwndParent);
     if (hDevInfoList == INVALID_HANDLE_VALUE)
@@ -512,7 +518,7 @@ tap_create_interface(
             hDevInfoList,
             &devinfo_data,
             SPDRP_HARDWAREID,
-            (const BYTE *)szzHardwareIDs, sizeof(szzHardwareIDs)))
+            (const BYTE *)szHwId, (DWORD)((_tcslen(szHwId) + 1) * sizeof(TCHAR))))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiSetDeviceRegistryProperty failed", __FUNCTION__);
@@ -616,7 +622,7 @@ tap_create_interface(
             /* Search the list of hardware IDs. */
             for (LPTSTR szHwdID = drvinfo_detail_data->HardwareID; szHwdID && szHwdID[0]; szHwdID += _tcslen(szHwdID) + 1)
             {
-                if (_tcsicmp(szHwdID, szzHardwareIDs) == 0)
+                if (_tcsicmp(szHwdID, szHwId) == 0)
                 {
                     /* Matching hardware ID found. Select the driver. */
                     if (!SetupDiSetSelectedDriver(
@@ -643,7 +649,7 @@ tap_create_interface(
     if (dwlDriverVersion == 0)
     {
         dwResult = ERROR_NOT_FOUND;
-        msg(M_NONFATAL, "%s: No driver for device \"%" PRIsLPTSTR "\" installed.", __FUNCTION__, szzHardwareIDs);
+        msg(M_NONFATAL, "%s: No driver for device \"%" PRIsLPTSTR "\" installed.", __FUNCTION__, szHwId);
         goto cleanup_DriverInfoList;
     }
 
@@ -953,6 +959,7 @@ cleanup_szInterfaceId:
 DWORD
 tap_list_interfaces(
     _In_opt_ HWND hwndParent,
+    _In_opt_ LPCTSTR szHwId,
     _Out_ struct tap_interface_node **ppInterface,
     _In_ BOOL bAll)
 {
@@ -963,6 +970,11 @@ tap_list_interfaces(
         return ERROR_BAD_ARGUMENTS;
     }
 
+    if (szHwId == NULL)
+    {
+        szHwId = szzDefaultHardwareIDs;
+    }
+
     /* Create a list of network devices. */
     HDEVINFO hDevInfoList = SetupDiGetClassDevsEx(
         &GUID_DEVCLASS_NET,
@@ -1034,7 +1046,7 @@ tap_list_interfaces(
         /* Check that hardware ID is REG_SZ/REG_MULTI_SZ, and optionally if it matches ours. */
         if (dwDataType == REG_SZ)
         {
-            if (!bAll && _tcsicmp(szzDeviceHardwareIDs, szzHardwareIDs) != 0)
+            if (!bAll && _tcsicmp(szzDeviceHardwareIDs, szHwId) != 0)
             {
                 /* This is not our device. Skip it. */
                 goto cleanup_szzDeviceHardwareIDs;
@@ -1051,7 +1063,7 @@ tap_list_interfaces(
                         /* This is not our device. Skip it. */
                         goto cleanup_szzDeviceHardwareIDs;
                     }
-                    else if (_tcsicmp(szHwdID, szzHardwareIDs) == 0)
+                    else if (_tcsicmp(szHwdID, szHwId) == 0)
                     {
                         /* This is our device. */
                         break;
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 2437d05..f74a39d 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -37,6 +37,10 @@
  * @param szDeviceDescription  A pointer to a NULL-terminated string that supplies the text
  *                      description of the device. This pointer is optional and can be NULL.
  *
+ * @param szHwId        A pointer to a NULL-terminated string that supplies the hardware id
+ *                      of the device. This pointer is optional and can be NULL. Default value
+ *                      is root\tap0901.
+ *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
  *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
  *                      left unmodified. This allows the flag to be globally initialized to
@@ -50,6 +54,7 @@ DWORD
 tap_create_interface(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
+    _In_opt_ LPCTSTR szHwId,
     _Inout_ LPBOOL pbRebootRequired,
     _Out_ LPGUID pguidInterface);
 
@@ -116,6 +121,10 @@ struct tap_interface_node
  *                      and can be NULL. If a specific top-level window is not required, set
  *                      hwndParent to NULL.
  *
+ * @param szHwId        A pointer to a NULL-terminated string that supplies the hardware id
+ *                      of the device. This pointer is optional and can be NULL. Default value
+ *                      is root\tap0901.
+ *
  * @param ppInterfaceList  A pointer to the list to receive pointer to the first interface in
  *                      the list. After the list is no longer required, free it using
  *                      tap_free_interface_list().
@@ -128,6 +137,7 @@ struct tap_interface_node
 DWORD
 tap_list_interfaces(
     _In_opt_ HWND hwndParent,
+    _In_opt_ LPCTSTR szHwId,
     _Out_ struct tap_interface_node **ppInterfaceList,
     _In_ BOOL bAll);
 
-- 
2.7.4


