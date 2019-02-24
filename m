From: Simon Rozman <simon@...2293...>
Date: Sun, 24 Feb 2019 19:14:00 +0100
Message-Id: <20190224181400.42524-1-simon@...2293...>
In-Reply-To: <20190117155829.GA92142@...1296...>
References: <20190117155829.GA92142@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add NULL checks
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

Extra NULL checks were added after malloc() calls to display out-of-
memory error and try to exit gracefully.

Function msica_op_create_*() now return NULL in out-of-memory condition
too. Since their output is directly used in msica_op_seq_add_head() and
msica_op_seq_add_tail() functions, later were extended to check for NULL
pointer arguments.

This patch follows Gert's recommendations from [openvpn-devel].

Signed-off-by: Simon Rozman <simon@...2293...>
Message-ID: <20190117155829.GA92142@...1296...>
---
 src/openvpnmsica/dllmain.c      | 23 ++++++++++---
 src/openvpnmsica/msica_op.c     | 60 +++++++++++++++++++++++++++++++++
 src/openvpnmsica/msiex.c        | 36 ++++++++++++++++++++
 src/openvpnmsica/openvpnmsica.c | 48 +++++++++++++++++++++++---
 src/tapctl/tap.c                | 50 +++++++++++++++++++++++++++
 5 files changed, 207 insertions(+), 10 deletions(-)

diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 5f5092a0..5e29f44c 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -65,8 +65,12 @@ DllMain(
         case DLL_THREAD_ATTACH:
         {
             /* Create thread local storage data. */
-            struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)malloc(sizeof(struct openvpnmsica_thread_data));
-            memset(s, 0, sizeof(struct openvpnmsica_thread_data));
+            struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)calloc(1, sizeof(struct openvpnmsica_thread_data));
+            if (s == NULL)
+            {
+                return FALSE;
+            }
+
             TlsSetValue(openvpnmsica_thread_data_idx, s);
             break;
         }
@@ -128,9 +132,18 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
         {
             /* Allocate on heap and retry. */
             char *szMessage = (char *)malloc(++iResultLen * sizeof(char));
-            vsnprintf(szMessage, iResultLen, format, arglist);
-            MsiRecordSetStringA(hRecordProg, 2, szMessage);
-            free(szMessage);
+            if (szMessage != NULL)
+            {
+                vsnprintf(szMessage, iResultLen, format, arglist);
+                MsiRecordSetStringA(hRecordProg, 2, szMessage);
+                free(szMessage);
+            }
+            else
+            {
+                /* Use stack variant anyway, but make sure it's zero-terminated. */
+                szBufStack[_countof(szBufStack) - 1] = 0;
+                MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+            }
         }
     }
 
diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
index 1ea93530..fec1ef8a 100644
--- a/src/openvpnmsica/msica_op.c
+++ b/src/openvpnmsica/msica_op.c
@@ -85,6 +85,12 @@ msica_op_create_bool(
 
     /* Create and fill operation struct. */
     struct msica_op_bool *op = (struct msica_op_bool *)malloc(sizeof(struct msica_op_bool));
+    if (op == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_bool));
+        return NULL;
+    }
+
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -110,6 +116,12 @@ msica_op_create_string(
     /* Create and fill operation struct. */
     size_t value_size = (_tcslen(value) + 1) * sizeof(TCHAR);
     struct msica_op_string *op = (struct msica_op_string *)malloc(sizeof(struct msica_op_string) + value_size);
+    if (op == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_string) + value_size);
+        return NULL;
+    }
+
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -142,6 +154,12 @@ msica_op_create_multistring_va(
 
     /* Create and fill operation struct. */
     struct msica_op_multistring *op = (struct msica_op_multistring *)malloc(sizeof(struct msica_op_multistring) + value_size);
+    if (op == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_multistring) + value_size);
+        return NULL;
+    }
+
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -173,6 +191,12 @@ msica_op_create_guid(
 
     /* Create and fill operation struct. */
     struct msica_op_guid *op = (struct msica_op_guid *)malloc(sizeof(struct msica_op_guid));
+    if (op == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_guid));
+        return NULL;
+    }
+
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -199,6 +223,12 @@ msica_op_create_guid_string(
     /* Create and fill operation struct. */
     size_t value_str_size = (_tcslen(value_str) + 1) * sizeof(TCHAR);
     struct msica_op_guid_string *op = (struct msica_op_guid_string *)malloc(sizeof(struct msica_op_guid_string) + value_str_size);
+    if (op == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_guid_string) + value_str_size);
+        return NULL;
+    }
+
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -214,6 +244,11 @@ msica_op_seq_add_head(
     _Inout_ struct msica_op_seq *seq,
     _Inout_ struct msica_op *operation)
 {
+    if (seq == NULL || operation == NULL)
+    {
+        return;
+    }
+
     /* Insert list in the head. */
     struct msica_op *op;
     for (op = operation; op->next; op = op->next)
@@ -235,6 +270,11 @@ msica_op_seq_add_tail(
     _Inout_ struct msica_op_seq *seq,
     _Inout_ struct msica_op *operation)
 {
+    if (seq == NULL || operation == NULL)
+    {
+        return;
+    }
+
     /* Append list to the tail. */
     struct msica_op *op;
     for (op = operation; op->next; op = op->next)
@@ -324,6 +364,11 @@ msica_op_seq_load(
 {
     DWORD dwRead;
 
+    if (seq == NULL)
+    {
+        return ERROR_BAD_ARGUMENTS;
+    }
+
     seq->head = seq->tail = NULL;
 
     for (;;)
@@ -345,10 +390,18 @@ msica_op_seq_load(
             msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
             return ERROR_INVALID_DATA;
         }
+
         struct msica_op *op = (struct msica_op *)malloc(sizeof(struct msica_op) + hdr.size_data);
+        if (op == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op) + hdr.size_data);
+            return ERROR_OUTOFMEMORY;
+        }
+
         op->type  = hdr.type;
         op->ticks = hdr.ticks;
         op->next  = NULL;
+
         if (!ReadFile(hFile, op + 1, hdr.size_data, &dwRead, NULL))
         {
             DWORD dwResult = GetLastError();
@@ -361,6 +414,7 @@ msica_op_seq_load(
             msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
             return ERROR_INVALID_DATA;
         }
+
         msica_op_seq_add_tail(seq, op);
     }
 }
@@ -753,6 +807,12 @@ msica_op_file_delete_exec(
     {
         size_t sizeNameBackupLenZ = _tcslen(op->value) + 7 /*" (orig "*/ + 10 /*maximum int*/ + 1 /*")"*/ + 1 /*terminator*/;
         LPTSTR szNameBackup = (LPTSTR)malloc(sizeNameBackupLenZ * sizeof(TCHAR));
+        if (szNameBackup == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeNameBackupLenZ * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         int count = 0;
 
         do
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 9b95f291..7e2bed3e 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -54,6 +54,12 @@ msi_get_string(
     {
         /* Copy from stack. */
         *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        if (*pszValue == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", dwLength * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
         return ERROR_SUCCESS;
     }
@@ -61,6 +67,12 @@ msi_get_string(
     {
         /* Allocate on heap and retry. */
         LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        if (szBufHeap == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         uiResult = MsiGetProperty(hInstall, szName, szBufHeap, &dwLength);
         if (uiResult == ERROR_SUCCESS)
         {
@@ -100,6 +112,12 @@ msi_get_record_string(
     {
         /* Copy from stack. */
         *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        if (*pszValue == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
         return ERROR_SUCCESS;
     }
@@ -107,6 +125,12 @@ msi_get_record_string(
     {
         /* Allocate on heap and retry. */
         LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        if (szBufHeap == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         uiResult = MsiRecordGetString(hRecord, iField, szBufHeap, &dwLength);
         if (uiResult == ERROR_SUCCESS)
         {
@@ -146,6 +170,12 @@ msi_format_record(
     {
         /* Copy from stack. */
         *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        if (*pszValue == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
         return ERROR_SUCCESS;
     }
@@ -153,6 +183,12 @@ msi_format_record(
     {
         /* Allocate on heap and retry. */
         LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        if (szBufHeap == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         uiResult = MsiFormatRecord(hInstall, hRecord, szBufHeap, &dwLength);
         if (uiResult == ERROR_SUCCESS)
         {
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index b8108b99..00ed2765 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -129,6 +129,12 @@ openvpnmsica_setup_sequence_filename(
     {
         size_t len_action_name_z = _tcslen(openvpnmsica_cleanup_action_seqs[i].szName) + 1;
         TCHAR *szPropertyEx = (TCHAR *)malloc((len_property_name + len_action_name_z) * sizeof(TCHAR));
+        if (szPropertyEx == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, (len_property_name + len_action_name_z) * sizeof(TCHAR));
+            return ERROR_OUTOFMEMORY;
+        }
+
         memcpy(szPropertyEx, szProperty, len_property_name * sizeof(TCHAR));
         memcpy(szPropertyEx + len_property_name, openvpnmsica_cleanup_action_seqs[i].szName, len_action_name_z * sizeof(TCHAR));
         _stprintf_s(
@@ -300,6 +306,10 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
 
             free(pVersionInfo);
         }
+        else
+        {
+            msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, dwVerInfoSize);
+        }
     }
 
     uiResult = MsiSetProperty(hInstall, TEXT("DRIVERCERTIFICATION"), ver_info.dwMajorVersion >= 10 ? ver_info.wProductType > VER_NT_WORKSTATION ? TEXT("whql") : TEXT("attsgn") : TEXT(""));
@@ -529,6 +539,13 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 
                 /* Append interface to the list. */
                 struct interface_node *node = (struct interface_node *)malloc(sizeof(struct interface_node));
+                if (node == NULL)
+                {
+                    MsiCloseHandle(hRecord);
+                    msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct interface_node));
+                    uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
+                }
+
                 node->iface = pInterface;
                 node->next = NULL;
                 if (interfaces_head)
@@ -550,10 +567,23 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
     {
         /* Prepare semicolon delimited list of TAP interface ID(s) and active TAP interface ID(s). */
         LPTSTR
-            szTAPInterfaces           = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
-            szTAPInterfacesTail       = szTAPInterfaces,
+            szTAPInterfaces     = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPInterfacesTail = szTAPInterfaces;
+        if (szTAPInterfaces == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_pAdapterAdresses;
+        }
+
+        LPTSTR
             szTAPInterfacesActive     = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
             szTAPInterfacesActiveTail = szTAPInterfacesActive;
+        if (szTAPInterfacesActive == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR));
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_szTAPInterfaces;
+        }
+
         while (interfaces_head)
         {
             /* Convert interface GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
@@ -605,7 +635,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
         {
             SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPINTERFACES\") failed", __FUNCTION__);
-            goto cleanup_szTAPInterfaces;
+            goto cleanup_szTAPInterfacesActive;
         }
 
         /* Set Installer ACTIVETAPINTERFACES property. */
@@ -614,11 +644,12 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
         {
             SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETAPINTERFACES\") failed", __FUNCTION__);
-            goto cleanup_szTAPInterfaces;
+            goto cleanup_szTAPInterfacesActive;
         }
 
-cleanup_szTAPInterfaces:
+cleanup_szTAPInterfacesActive:
         free(szTAPInterfacesActive);
+cleanup_szTAPInterfaces:
         free(szTAPInterfaces);
     }
     else
@@ -626,6 +657,7 @@ cleanup_szTAPInterfaces:
         uiResult = ERROR_SUCCESS;
     }
 
+cleanup_pAdapterAdresses:
     free(pAdapterAdresses);
 cleanup_tap_list_interfaces:
     tap_free_interface_list(pInterfaceList);
@@ -700,6 +732,12 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
     {
         /* Allocate buffer on heap (+1 for terminator), and retry. */
         szPath = (LPTSTR)malloc((++dwPathSize) * sizeof(TCHAR));
+        if (szPath == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwPathSize * sizeof(TCHAR));
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_MsiCreateRecord;
+        }
+
         uiResult = MsiFormatRecord(hInstall, hRecord, szPath, &dwPathSize);
     }
     if (uiResult != ERROR_SUCCESS)
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index ed3c6e0b..ba80237f 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -140,6 +140,12 @@ get_reg_string(
         {
             /* Read value. */
             LPTSTR szValue = (LPTSTR)malloc(dwSize);
+            if (szValue == NULL)
+            {
+                msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwSize);
+                return ERROR_OUTOFMEMORY;
+            }
+
             dwResult = RegQueryValueEx(
                 hKey,
                 szName,
@@ -167,6 +173,13 @@ get_reg_string(
                     dwSizeExp / sizeof(TCHAR) - 1;     /* Note: ANSI version requires one extra char. */
 #endif
                 LPTSTR szValueExp = (LPTSTR)malloc(dwSizeExp);
+                if (szValueExp == NULL)
+                {
+                    free(szValue);
+                    msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwSizeExp);
+                    return ERROR_OUTOFMEMORY;
+                }
+
                 DWORD dwCountExpResult = ExpandEnvironmentStrings(
                     szValue,
                     szValueExp, dwCountExp
@@ -197,6 +210,13 @@ get_reg_string(
 #endif
                     dwCountExp = dwCountExpResult;
                     szValueExp = (LPTSTR)malloc(dwSizeExp);
+                    if (szValueExp == NULL)
+                    {
+                        free(szValue);
+                        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwSizeExp);
+                        return ERROR_OUTOFMEMORY;
+                    }
+
                     dwCountExpResult = ExpandEnvironmentStrings(
                         szValue,
                         szValueExp, dwCountExp);
@@ -356,6 +376,12 @@ get_device_reg_property(
     {
         /* Copy from stack. */
         *ppData = malloc(dwRequiredSize);
+        if (*ppData == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwRequiredSize);
+            return ERROR_OUTOFMEMORY;
+        }
+
         memcpy(*ppData, bBufStack, dwRequiredSize);
         return ERROR_SUCCESS;
     }
@@ -366,6 +392,12 @@ get_device_reg_property(
         {
             /* Allocate on heap and retry. */
             *ppData = malloc(dwRequiredSize);
+            if (*ppData == NULL)
+            {
+                msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwRequiredSize);
+                return ERROR_OUTOFMEMORY;
+            }
+
             if (SetupDiGetDeviceRegistryProperty(
                     hDeviceInfoSet,
                     pDeviceInfoData,
@@ -499,6 +531,12 @@ tap_create_interface(
     DWORDLONG dwlDriverVersion = 0;
     DWORD drvinfo_detail_data_size = sizeof(SP_DRVINFO_DETAIL_DATA) + 0x100;
     SP_DRVINFO_DETAIL_DATA *drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA *)malloc(drvinfo_detail_data_size);
+    if (drvinfo_detail_data == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, drvinfo_detail_data_size);
+        dwResult = ERROR_OUTOFMEMORY; goto cleanup_DriverInfoList;
+    }
+
     for (DWORD dwIndex = 0;; dwIndex++)
     {
         /* Get a driver from the list. */
@@ -543,6 +581,11 @@ tap_create_interface(
 
                 drvinfo_detail_data_size = dwSize;
                 drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA *)malloc(drvinfo_detail_data_size);
+                if (drvinfo_detail_data == NULL)
+                {
+                    msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, drvinfo_detail_data_size);
+                    dwResult = ERROR_OUTOFMEMORY; goto cleanup_DriverInfoList;
+                }
 
                 /* Re-get driver info details. */
                 drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
@@ -1038,6 +1081,12 @@ tap_list_interfaces(
         size_t hwid_size = (_tcszlen(szzDeviceHardwareIDs) + 1) * sizeof(TCHAR);
         size_t name_size = (_tcslen(szName) + 1) * sizeof(TCHAR);
         struct tap_interface_node *node = (struct tap_interface_node *)malloc(sizeof(struct tap_interface_node) + hwid_size + name_size);
+        if (node == NULL)
+        {
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct tap_interface_node) + hwid_size + name_size);
+            dwResult = ERROR_OUTOFMEMORY; goto cleanup_szName;
+        }
+
         memcpy(&node->guid, &guidInterface, sizeof(GUID));
         node->szzHardwareIDs = (LPTSTR)(node + 1);
         memcpy(node->szzHardwareIDs, szzDeviceHardwareIDs, hwid_size);
@@ -1054,6 +1103,7 @@ tap_list_interfaces(
             *ppInterface = pInterfaceTail = node;
         }
 
+cleanup_szName:
         free(szName);
 cleanup_hKey:
         RegCloseKey(hKey);
-- 
2.19.0.windows.1


