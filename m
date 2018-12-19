From: Simon Rozman <simon@...2293...>
Date: Wed, 19 Dec 2018 21:26:10 +0100
Message-Id: <20181219202611.2144-3-simon@...2293...>
In-Reply-To: <20181219202611.2144-1-simon@...2293...>
References: <20181219202611.2144-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Uncrustify tapctl and openvpnmsica
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

---
 src/openvpnmsica/dllmain.c      |  33 +--
 src/openvpnmsica/msica_op.c     | 362 +++++++++++++++++-------------
 src/openvpnmsica/msica_op.h     | 114 +++++-----
 src/openvpnmsica/msiex.c        |  51 +++--
 src/openvpnmsica/msiex.h        |  86 ++++----
 src/openvpnmsica/openvpnmsica.c | 292 ++++++++++++++++---------
 src/openvpnmsica/openvpnmsica.h |  10 +-
 src/tapctl/basic.h              |   2 +-
 src/tapctl/error.h              |   3 +-
 src/tapctl/main.c               |  60 +++--
 src/tapctl/tap.c                | 375 ++++++++++++++++++--------------
 src/tapctl/tap.h                |  22 +-
 12 files changed, 827 insertions(+), 583 deletions(-)

diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index e9fc66f6..50231e4c 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -42,10 +42,11 @@ DWORD openvpnmsica_tlsidx_session = TLS_OUT_OF_INDEXES;
 /**
  * DLL entry point
  */
-BOOL WINAPI DllMain(
+BOOL WINAPI
+DllMain(
     _In_ HINSTANCE hinstDLL,
-    _In_ DWORD     dwReason,
-    _In_ LPVOID    lpReserved)
+    _In_ DWORD dwReason,
+    _In_ LPVOID lpReserved)
 {
     UNREFERENCED_PARAMETER(hinstDLL);
     UNREFERENCED_PARAMETER(lpReserved);
@@ -56,13 +57,15 @@ BOOL WINAPI DllMain(
             /* Allocate TLS index. */
             openvpnmsica_tlsidx_session = TlsAlloc();
             if (openvpnmsica_tlsidx_session == TLS_OUT_OF_INDEXES)
+            {
                 return FALSE;
-            /* Fall through. */
+            }
+        /* Fall through. */
 
         case DLL_THREAD_ATTACH:
         {
             /* Create TLS data. */
-            struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data*)malloc(sizeof(struct openvpnmsica_tls_data));
+            struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)malloc(sizeof(struct openvpnmsica_tls_data));
             memset(s, 0, sizeof(struct openvpnmsica_tls_data));
             TlsSetValue(openvpnmsica_tlsidx_session, s);
             break;
@@ -124,7 +127,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
         else
         {
             /* Allocate on heap and retry. */
-            char *szMessage = (char*)malloc(++iResultLen * sizeof(char));
+            char *szMessage = (char *)malloc(++iResultLen * sizeof(char));
             vsnprintf(szMessage, iResultLen, format, arglist);
             MsiRecordSetStringA(hRecordProg, 2, szMessage);
             free(szMessage);
@@ -147,21 +150,23 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
         /* Field 4: The Windows error description. */
         LPTSTR szErrMessage = NULL;
         if (FormatMessage(
-            FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
-            0,
-            dwResult,
-            0,
-            (LPTSTR)&szErrMessage,
-            0,
-            NULL) && szErrMessage)
+                FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
+                0,
+                dwResult,
+                0,
+                (LPTSTR)&szErrMessage,
+                0,
+                NULL) && szErrMessage)
         {
             /* Trim trailing whitespace. Set terminator after the last non-whitespace character. This prevents excessive trailing line breaks. */
-            for (size_t i = 0, i_last = 0; ; i++)
+            for (size_t i = 0, i_last = 0;; i++)
             {
                 if (szErrMessage[i])
                 {
                     if (!_istspace(szErrMessage[i]))
+                    {
                         i_last = i + 1;
+                    }
                 }
                 else
                 {
diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
index 2ce69444..1ea93530 100644
--- a/src/openvpnmsica/msica_op.c
+++ b/src/openvpnmsica/msica_op.c
@@ -70,12 +70,12 @@ msica_op_seq_free(_Inout_ struct msica_op_seq *seq)
 }
 
 
-struct msica_op*
+struct msica_op *
 msica_op_create_bool(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     bool                value)
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ bool value)
 {
     if (MSICA_OP_TYPE_DATA(type) != 0x1)
     {
@@ -84,7 +84,7 @@ msica_op_create_bool(
     }
 
     /* Create and fill operation struct. */
-    struct msica_op_bool *op = (struct msica_op_bool*)malloc(sizeof(struct msica_op_bool));
+    struct msica_op_bool *op = (struct msica_op_bool *)malloc(sizeof(struct msica_op_bool));
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -94,12 +94,12 @@ msica_op_create_bool(
 }
 
 
-struct msica_op*
+struct msica_op *
 msica_op_create_string(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_z_   LPCTSTR             value)
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_z_ LPCTSTR value)
 {
     if (MSICA_OP_TYPE_DATA(type) != 0x2)
     {
@@ -109,7 +109,7 @@ msica_op_create_string(
 
     /* Create and fill operation struct. */
     size_t value_size = (_tcslen(value) + 1) * sizeof(TCHAR);
-    struct msica_op_string *op = (struct msica_op_string*)malloc(sizeof(struct msica_op_string) + value_size);
+    struct msica_op_string *op = (struct msica_op_string *)malloc(sizeof(struct msica_op_string) + value_size);
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -119,12 +119,12 @@ msica_op_create_string(
 }
 
 
-struct msica_op*
+struct msica_op *
 msica_op_create_multistring_va(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     va_list             arglist)
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ va_list arglist)
 {
     if (MSICA_OP_TYPE_DATA(type) != 0x3)
     {
@@ -135,11 +135,13 @@ msica_op_create_multistring_va(
     /* Calculate required space first. */
     LPCTSTR str;
     size_t value_size = 1;
-    for (va_list a = arglist; (str = va_arg(a, LPCTSTR)) != NULL; value_size += _tcslen(str) + 1);
+    for (va_list a = arglist; (str = va_arg(a, LPCTSTR)) != NULL; value_size += _tcslen(str) + 1)
+    {
+    }
     value_size *= sizeof(TCHAR);
 
     /* Create and fill operation struct. */
-    struct msica_op_multistring *op = (struct msica_op_multistring*)malloc(sizeof(struct msica_op_multistring) + value_size);
+    struct msica_op_multistring *op = (struct msica_op_multistring *)malloc(sizeof(struct msica_op_multistring) + value_size);
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -156,12 +158,12 @@ msica_op_create_multistring_va(
 }
 
 
-struct msica_op*
+struct msica_op *
 msica_op_create_guid(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     const GUID         *value)
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ const GUID *value)
 {
     if (MSICA_OP_TYPE_DATA(type) != 0x4)
     {
@@ -170,7 +172,7 @@ msica_op_create_guid(
     }
 
     /* Create and fill operation struct. */
-    struct msica_op_guid *op = (struct msica_op_guid*)malloc(sizeof(struct msica_op_guid));
+    struct msica_op_guid *op = (struct msica_op_guid *)malloc(sizeof(struct msica_op_guid));
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
@@ -180,13 +182,13 @@ msica_op_create_guid(
 }
 
 
-struct msica_op*
+struct msica_op *
 msica_op_create_guid_string(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     const GUID         *value_guid,
-    _In_z_   LPCTSTR             value_str)
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ const GUID *value_guid,
+    _In_z_ LPCTSTR value_str)
 {
     if (MSICA_OP_TYPE_DATA(type) != 0x5)
     {
@@ -196,12 +198,12 @@ msica_op_create_guid_string(
 
     /* Create and fill operation struct. */
     size_t value_str_size = (_tcslen(value_str) + 1) * sizeof(TCHAR);
-    struct msica_op_guid_string *op = (struct msica_op_guid_string*)malloc(sizeof(struct msica_op_guid_string) + value_str_size);
+    struct msica_op_guid_string *op = (struct msica_op_guid_string *)malloc(sizeof(struct msica_op_guid_string) + value_str_size);
     op->base.type  = type;
     op->base.ticks = ticks;
     op->base.next  = next;
-    memcpy(&op->value_guid, value_guid, sizeof(GUID)  );
-    memcpy( op->value_str , value_str , value_str_size);
+    memcpy(&op->value_guid, value_guid, sizeof(GUID));
+    memcpy(op->value_str, value_str, value_str_size);
 
     return &op->base;
 }
@@ -210,32 +212,42 @@ msica_op_create_guid_string(
 void
 msica_op_seq_add_head(
     _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op     *operation)
+    _Inout_ struct msica_op *operation)
 {
     /* Insert list in the head. */
     struct msica_op *op;
-    for (op = operation; op->next; op = op->next);
+    for (op = operation; op->next; op = op->next)
+    {
+    }
     op->next = seq->head;
 
     /* Update head (and tail). */
     seq->head = operation;
     if (seq->tail == NULL)
+    {
         seq->tail = op;
+    }
 }
 
 
 void
 msica_op_seq_add_tail(
     _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op     *operation)
+    _Inout_ struct msica_op *operation)
 {
     /* Append list to the tail. */
     struct msica_op *op;
-    for (op = operation; op->next; op = op->next);
+    for (op = operation; op->next; op = op->next)
+    {
+    }
     if (seq->tail)
+    {
         seq->tail->next = operation;
+    }
     else
+    {
         seq->head = operation;
+    }
     seq->tail = op;
 }
 
@@ -243,7 +255,7 @@ msica_op_seq_add_tail(
 DWORD
 msica_op_seq_save(
     _In_ const struct msica_op_seq *seq,
-    _In_ HANDLE                     hFile)
+    _In_ HANDLE hFile)
 {
     DWORD dwWritten;
     for (const struct msica_op *op = seq->head; op; op = op->next)
@@ -255,43 +267,45 @@ msica_op_seq_save(
         /* Calculate size of data. */
         switch (MSICA_OP_TYPE_DATA(op->type))
         {
-        case 0x1: /* msica_op_bool */
-            hdr.size_data = sizeof(struct msica_op_bool) - sizeof(struct msica_op);
-            break;
+            case 0x1: /* msica_op_bool */
+                hdr.size_data = sizeof(struct msica_op_bool) - sizeof(struct msica_op);
+                break;
 
-        case 0x2: /* msica_op_string */
-            hdr.size_data =
-                sizeof(struct msica_op_string) - sizeof(struct msica_op) +
-                (DWORD)(_tcslen(((struct msica_op_string*)op)->value) + 1) * sizeof(TCHAR);
-            break;
+            case 0x2: /* msica_op_string */
+                hdr.size_data =
+                    sizeof(struct msica_op_string) - sizeof(struct msica_op)
+                    +(DWORD)(_tcslen(((struct msica_op_string *)op)->value) + 1) * sizeof(TCHAR);
+                break;
 
-        case 0x3: /* msica_op_multistring */
-        {
-            LPCTSTR str;
-            for (str = ((struct msica_op_multistring*)op)->value; str[0]; str += _tcslen(str) + 1);
-            hdr.size_data =
-                sizeof(struct msica_op_multistring) - sizeof(struct msica_op) +
-                (DWORD)(str + 1 - ((struct msica_op_multistring*)op)->value) * sizeof(TCHAR);
-            break;
-        }
+            case 0x3: /* msica_op_multistring */
+            {
+                LPCTSTR str;
+                for (str = ((struct msica_op_multistring *)op)->value; str[0]; str += _tcslen(str) + 1)
+                {
+                }
+                hdr.size_data =
+                    sizeof(struct msica_op_multistring) - sizeof(struct msica_op)
+                    +(DWORD)(str + 1 - ((struct msica_op_multistring *)op)->value) * sizeof(TCHAR);
+                break;
+            }
 
-        case 0x4: /* msica_op_guid */
-            hdr.size_data = sizeof(struct msica_op_guid) - sizeof(struct msica_op);
-            break;
+            case 0x4: /* msica_op_guid */
+                hdr.size_data = sizeof(struct msica_op_guid) - sizeof(struct msica_op);
+                break;
 
-        case 0x5: /* msica_op_guid_string */
-            hdr.size_data =
-                sizeof(struct msica_op_guid_string) - sizeof(struct msica_op) +
-                (DWORD)(_tcslen(((struct msica_op_guid_string*)op)->value_str) + 1) * sizeof(TCHAR);
-            break;
+            case 0x5: /* msica_op_guid_string */
+                hdr.size_data =
+                    sizeof(struct msica_op_guid_string) - sizeof(struct msica_op)
+                    +(DWORD)(_tcslen(((struct msica_op_guid_string *)op)->value_str) + 1) * sizeof(TCHAR);
+                break;
 
-        default:
-            msg(M_NONFATAL, "%s: Unknown operation data type (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(op->type));
-            return ERROR_BAD_ARGUMENTS;
+            default:
+                msg(M_NONFATAL, "%s: Unknown operation data type (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(op->type));
+                return ERROR_BAD_ARGUMENTS;
         }
 
-        if (!WriteFile(hFile, &hdr, sizeof(struct msica_op_hdr), &dwWritten, NULL) ||
-            !WriteFile(hFile, op + 1, hdr.size_data, &dwWritten, NULL))
+        if (!WriteFile(hFile, &hdr, sizeof(struct msica_op_hdr), &dwWritten, NULL)
+            || !WriteFile(hFile, op + 1, hdr.size_data, &dwWritten, NULL))
         {
             DWORD dwResult = GetLastError();
             msg(M_NONFATAL | M_ERRNO, "%s: WriteFile failed", __FUNCTION__);
@@ -306,7 +320,7 @@ msica_op_seq_save(
 DWORD
 msica_op_seq_load(
     _Inout_ struct msica_op_seq *seq,
-    _In_    HANDLE               hFile)
+    _In_ HANDLE hFile)
 {
     DWORD dwRead;
 
@@ -331,7 +345,7 @@ msica_op_seq_load(
             msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
             return ERROR_INVALID_DATA;
         }
-        struct msica_op *op = (struct msica_op*)malloc(sizeof(struct msica_op) + hdr.size_data);
+        struct msica_op *op = (struct msica_op *)malloc(sizeof(struct msica_op) + hdr.size_data);
         op->type  = hdr.type;
         op->ticks = hdr.ticks;
         op->next  = NULL;
@@ -355,10 +369,12 @@ msica_op_seq_load(
 static DWORD
 msica_op_tap_interface_create_exec(
     _Inout_ const struct msica_op_string *op,
-    _Inout_ struct msica_session         *session)
+    _Inout_ struct msica_session *session)
 {
     if (op == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     {
         /* Report the name of the interface to installer. */
@@ -368,7 +384,9 @@ msica_op_tap_interface_create_exec(
         int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
         MsiCloseHandle(hRecord);
         if (iResult == IDCANCEL)
+        {
             return ERROR_INSTALL_USEREXIT;
+        }
     }
 
     /* Get available network interfaces. */
@@ -377,7 +395,7 @@ msica_op_tap_interface_create_exec(
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
-        for (struct tap_interface_node *pInterfaceOther = pInterfaceList; ; pInterfaceOther = pInterfaceOther->pNext)
+        for (struct tap_interface_node *pInterfaceOther = pInterfaceList;; pInterfaceOther = pInterfaceOther->pNext)
         {
             if (pInterfaceOther == NULL)
             {
@@ -404,28 +422,32 @@ msica_op_tap_interface_create_exec(
                         }
                     }
                     else
+                    {
                         tap_delete_interface(NULL, &guidInterface, &bRebootRequired);
+                    }
 
                     if (bRebootRequired)
+                    {
                         MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+                    }
                 }
                 break;
             }
             else if (_tcsicmp(op->value, pInterfaceOther->szName) == 0)
             {
                 /* Interface with a same name found. */
-                for (LPCTSTR hwid = pInterfaceOther->szzHardwareIDs; ; hwid += _tcslen(hwid) + 1)
+                for (LPCTSTR hwid = pInterfaceOther->szzHardwareIDs;; hwid += _tcslen(hwid) + 1)
                 {
                     if (hwid[0] == 0)
                     {
                         /* This is not a TAP interface. */
-                        msg(M_NONFATAL, "%s: Interface with name \"%"PRIsLPTSTR"\" already exists", __FUNCTION__, pInterfaceOther->szName);
+                        msg(M_NONFATAL, "%s: Interface with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pInterfaceOther->szName);
                         dwResult = ERROR_ALREADY_EXISTS;
                         break;
                     }
                     else if (
-                        _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0 ||
-                        _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+                        _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
+                        || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
                     {
                         /* This is a TAP interface. We already got what we wanted! */
                         dwResult = ERROR_SUCCESS;
@@ -445,12 +467,14 @@ msica_op_tap_interface_create_exec(
 
 static DWORD
 msica_op_tap_interface_delete(
-    _In_    struct tap_interface_node *pInterfaceList,
-    _In_    struct tap_interface_node *pInterface,
-    _Inout_ struct msica_session      *session)
+    _In_ struct tap_interface_node *pInterfaceList,
+    _In_ struct tap_interface_node *pInterface,
+    _Inout_ struct msica_session *session)
 {
     if (pInterfaceList == NULL || pInterface == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     DWORD dwResult;
 
@@ -458,30 +482,32 @@ msica_op_tap_interface_delete(
     BOOL bRebootRequired = FALSE;
     dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
     if (bRebootRequired)
+    {
         MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+    }
 
     if (session->rollback_enabled)
     {
         /*
-        Schedule rollback action to create the interface back. Though it won't be exactly the same interface again.
-
-        The previous version of this function did:
-        - Execution Pass:       rename the interface to some temporary name
-        - Commit/Rollback Pass: delete the interface / rename the interface back to original name
-
-        However, the WiX Toolset's Diffx extension to install and remove drivers removed the TAP driver between the
-        execution and commit passes. TAP driver removal makes all TAP interfaces unavailable and our CA couldn't find
-        the interface to delete any more.
-
-        While the system where OpenVPN was uninstalled didn't have any TAP interfaces any more as expected behaviour,
-        the problem appears after reinstalling the OpenVPN. Some residue TAP interface registry keys remain on the
-        system, causing the TAP interface to reappear as "Ethernet NN" interface next time the TAP driver is
-        installed. This causes TAP interfaces to accumulate over cyclic install-uninstall-install...
-
-        Therefore, it is better to remove the TAP interfaces before the TAP driver is removed, and reinstall the TAP
-        interface back should the rollback be required. I wonder if the WiX Diffx extension supports execute/commit/
-        rollback feature of MSI in the first place.
-        */
+         * Schedule rollback action to create the interface back. Though it won't be exactly the same interface again.
+         *
+         * The previous version of this function did:
+         * - Execution Pass:       rename the interface to some temporary name
+         * - Commit/Rollback Pass: delete the interface / rename the interface back to original name
+         *
+         * However, the WiX Toolset's Diffx extension to install and remove drivers removed the TAP driver between the
+         * execution and commit passes. TAP driver removal makes all TAP interfaces unavailable and our CA couldn't find
+         * the interface to delete any more.
+         *
+         * While the system where OpenVPN was uninstalled didn't have any TAP interfaces any more as expected behaviour,
+         * the problem appears after reinstalling the OpenVPN. Some residue TAP interface registry keys remain on the
+         * system, causing the TAP interface to reappear as "Ethernet NN" interface next time the TAP driver is
+         * installed. This causes TAP interfaces to accumulate over cyclic install-uninstall-install...
+         *
+         * Therefore, it is better to remove the TAP interfaces before the TAP driver is removed, and reinstall the TAP
+         * interface back should the rollback be required. I wonder if the WiX Diffx extension supports execute/commit/
+         * rollback feature of MSI in the first place.
+         */
         msica_op_seq_add_head(
             &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
             msica_op_create_string(
@@ -498,10 +524,12 @@ msica_op_tap_interface_delete(
 static DWORD
 msica_op_tap_interface_delete_by_name_exec(
     _Inout_ const struct msica_op_string *op,
-    _Inout_ struct msica_session         *session)
+    _Inout_ struct msica_session *session)
 {
     if (op == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     {
         /* Report the name of the interface to installer. */
@@ -511,7 +539,9 @@ msica_op_tap_interface_delete_by_name_exec(
         int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
         MsiCloseHandle(hRecord);
         if (iResult == IDCANCEL)
+        {
             return ERROR_INSTALL_USEREXIT;
+        }
     }
 
     /* Get available network interfaces. */
@@ -520,7 +550,7 @@ msica_op_tap_interface_delete_by_name_exec(
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
-        for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+        for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
         {
             if (pInterface == NULL)
             {
@@ -549,10 +579,12 @@ msica_op_tap_interface_delete_by_name_exec(
 static DWORD
 msica_op_tap_interface_delete_by_guid_exec(
     _Inout_ const struct msica_op_guid *op,
-    _Inout_ struct msica_session       *session)
+    _Inout_ struct msica_session *session)
 {
     if (op == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     {
         /* Report the GUID of the interface to installer. */
@@ -565,7 +597,9 @@ msica_op_tap_interface_delete_by_guid_exec(
         CoTaskMemFree(szInterfaceId);
         MsiCloseHandle(hRecord);
         if (iResult == IDCANCEL)
+        {
             return ERROR_INSTALL_USEREXIT;
+        }
     }
 
     /* Get available network interfaces. */
@@ -574,7 +608,7 @@ msica_op_tap_interface_delete_by_guid_exec(
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
-        for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+        for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
         {
             if (pInterface == NULL)
             {
@@ -603,10 +637,12 @@ msica_op_tap_interface_delete_by_guid_exec(
 static DWORD
 msica_op_tap_interface_set_name_exec(
     _Inout_ const struct msica_op_guid_string *op,
-    _Inout_ struct msica_session              *session)
+    _Inout_ struct msica_session *session)
 {
     if (op == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     {
         /* Report the GUID of the interface to installer. */
@@ -620,7 +656,9 @@ msica_op_tap_interface_set_name_exec(
         CoTaskMemFree(szInterfaceId);
         MsiCloseHandle(hRecord);
         if (iResult == IDCANCEL)
+        {
             return ERROR_INSTALL_USEREXIT;
+        }
     }
 
     /* Get available network interfaces. */
@@ -629,14 +667,14 @@ msica_op_tap_interface_set_name_exec(
     if (dwResult == ERROR_SUCCESS)
     {
         /* Does interface exist? */
-        for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+        for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
         {
             if (pInterface == NULL)
             {
                 /* Interface not found. */
                 LPOLESTR szInterfaceId = NULL;
                 StringFromIID((REFIID)&op->value_guid, &szInterfaceId);
-                msg(M_NONFATAL, "%s: %"PRIsLPOLESTR" interface not found", __FUNCTION__, szInterfaceId);
+                msg(M_NONFATAL, "%s: %" PRIsLPOLESTR " interface not found", __FUNCTION__, szInterfaceId);
                 CoTaskMemFree(szInterfaceId);
                 dwResult = ERROR_FILE_NOT_FOUND;
                 break;
@@ -644,7 +682,7 @@ msica_op_tap_interface_set_name_exec(
             else if (memcmp(&op->value_guid, &pInterface->guid, sizeof(GUID)) == 0)
             {
                 /* Interface found. */
-                for (struct tap_interface_node *pInterfaceOther = pInterfaceList; ; pInterfaceOther = pInterfaceOther->pNext)
+                for (struct tap_interface_node *pInterfaceOther = pInterfaceList;; pInterfaceOther = pInterfaceOther->pNext)
                 {
                     if (pInterfaceOther == NULL)
                     {
@@ -670,7 +708,7 @@ msica_op_tap_interface_set_name_exec(
                     else if (_tcsicmp(op->value_str, pInterfaceOther->szName) == 0)
                     {
                         /* Interface with a same name found. Duplicate interface names are not allowed. */
-                        msg(M_NONFATAL, "%s: Interface with name \"%"PRIsLPTSTR"\" already exists", __FUNCTION__, pInterfaceOther->szName);
+                        msg(M_NONFATAL, "%s: Interface with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pInterfaceOther->szName);
                         dwResult = ERROR_ALREADY_EXISTS;
                         break;
                     }
@@ -689,10 +727,12 @@ msica_op_tap_interface_set_name_exec(
 static DWORD
 msica_op_file_delete_exec(
     _Inout_ const struct msica_op_string *op,
-    _Inout_ struct msica_session         *session)
+    _Inout_ struct msica_session *session)
 {
     if (op == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     {
         /* Report the name of the file to installer. */
@@ -702,18 +742,21 @@ msica_op_file_delete_exec(
         int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
         MsiCloseHandle(hRecord);
         if (iResult == IDCANCEL)
+        {
             return ERROR_INSTALL_USEREXIT;
+        }
     }
 
     DWORD dwResult;
 
     if (session->rollback_enabled)
     {
-        size_t sizeNameBackupLenZ = _tcslen(op->value) + 7/*" (orig "*/ + 10/*maximum int*/ + 1/*")"*/ + 1/*terminator*/;
+        size_t sizeNameBackupLenZ = _tcslen(op->value) + 7 /*" (orig "*/ + 10 /*maximum int*/ + 1 /*")"*/ + 1 /*terminator*/;
         LPTSTR szNameBackup = (LPTSTR)malloc(sizeNameBackupLenZ * sizeof(TCHAR));
         int count = 0;
 
-        do {
+        do
+        {
             /* Rename the file to make a backup. */
             _stprintf_s(
                 szNameBackup, sizeNameBackupLenZ,
@@ -746,9 +789,13 @@ msica_op_file_delete_exec(
                     szNameBackup));
         }
         else if (dwResult == ERROR_FILE_NOT_FOUND) /* File does not exist: We already got what we wanted! */
+        {
             dwResult = ERROR_SUCCESS;
+        }
         else
-            msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%"PRIsLPTSTR"\", \"%"PRIsLPTSTR"\") failed", __FUNCTION__, op->value, szNameBackup);
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%" PRIsLPTSTR "\", \"%" PRIsLPTSTR "\") failed", __FUNCTION__, op->value, szNameBackup);
+        }
 
         free(szNameBackup);
     }
@@ -757,9 +804,13 @@ msica_op_file_delete_exec(
         /* Delete the file. */
         dwResult = DeleteFile(op->value) ? ERROR_SUCCESS : GetLastError();
         if (dwResult == ERROR_FILE_NOT_FOUND) /* File does not exist: We already got what we wanted! */
+        {
             dwResult = ERROR_SUCCESS;
+        }
         else if (dwResult != ERROR_SUCCESS)
-            msg(M_NONFATAL | M_ERRNO, "%s: DeleteFile(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, op->value);
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: DeleteFile(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, op->value);
+        }
     }
 
     return dwResult;
@@ -769,20 +820,26 @@ msica_op_file_delete_exec(
 static DWORD
 msica_op_file_move_exec(
     _Inout_ const struct msica_op_multistring *op,
-    _Inout_ struct msica_session              *session)
+    _Inout_ struct msica_session *session)
 {
     if (op == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Get source filename. */
     LPCTSTR szNameSrc = op->value;
     if (szNameSrc[0] == 0)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Get destination filename. */
     LPCTSTR szNameDst = szNameSrc + _tcslen(szNameSrc) + 1;
     if (szNameDst[0] == 0)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     {
         /* Report the name of the files to installer. */
@@ -793,12 +850,16 @@ msica_op_file_move_exec(
         int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
         MsiCloseHandle(hRecord);
         if (iResult == IDCANCEL)
+        {
             return ERROR_INSTALL_USEREXIT;
+        }
     }
 
     DWORD dwResult = MoveFile(szNameSrc, szNameDst) ? ERROR_SUCCESS : GetLastError();
-    if (dwResult == ERROR_SUCCESS) {
-        if (session->rollback_enabled) {
+    if (dwResult == ERROR_SUCCESS)
+    {
+        if (session->rollback_enabled)
+        {
             /* Order rollback action to move it back. */
             msica_op_seq_add_head(
                 &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
@@ -812,7 +873,9 @@ msica_op_file_move_exec(
         }
     }
     else
-        msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%"PRIsLPTSTR"\", \"%"PRIsLPTSTR"\") failed", __FUNCTION__, szNameSrc, szNameDst);
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%" PRIsLPTSTR "\", \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szNameSrc, szNameDst);
+    }
 
     return dwResult;
 }
@@ -821,27 +884,31 @@ msica_op_file_move_exec(
 void
 openvpnmsica_session_init(
     _Inout_ struct msica_session *session,
-    _In_    MSIHANDLE             hInstall,
-    _In_    bool                  continue_on_error,
-    _In_    bool                  rollback_enabled)
+    _In_ MSIHANDLE hInstall,
+    _In_ bool continue_on_error,
+    _In_ bool rollback_enabled)
 {
     session->hInstall          = hInstall;
     session->continue_on_error = continue_on_error;
     session->rollback_enabled  = rollback_enabled;
     for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+    {
         msica_op_seq_init(&session->seq_cleanup[i]);
+    }
 }
 
 
 DWORD
 msica_op_seq_process(
     _Inout_ const struct msica_op_seq *seq,
-    _Inout_ struct msica_session      *session)
+    _Inout_ struct msica_session *session)
 {
     DWORD dwResult;
 
     if (seq == NULL || session == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Tell the installer to use explicit progress messages. */
     MSIHANDLE hRecordProg = MsiCreateRecord(3);
@@ -858,41 +925,42 @@ msica_op_seq_process(
     {
         switch (op->type)
         {
-        case msica_op_rollback_enable:
-            session->rollback_enabled = ((const struct msica_op_bool*)op)->value;
-            dwResult = ERROR_SUCCESS;
-            break;
+            case msica_op_rollback_enable:
+                session->rollback_enabled = ((const struct msica_op_bool *)op)->value;
+                dwResult = ERROR_SUCCESS;
+                break;
 
-        case msica_op_tap_interface_create:
-            dwResult = msica_op_tap_interface_create_exec((const struct msica_op_string*)op, session);
-            break;
+            case msica_op_tap_interface_create:
+                dwResult = msica_op_tap_interface_create_exec((const struct msica_op_string *)op, session);
+                break;
 
-        case msica_op_tap_interface_delete_by_name:
-            dwResult = msica_op_tap_interface_delete_by_name_exec((const struct msica_op_string*)op, session);
-            break;
+            case msica_op_tap_interface_delete_by_name:
+                dwResult = msica_op_tap_interface_delete_by_name_exec((const struct msica_op_string *)op, session);
+                break;
 
-        case msica_op_tap_interface_delete_by_guid:
-            dwResult = msica_op_tap_interface_delete_by_guid_exec((const struct msica_op_guid*)op, session);
-            break;
+            case msica_op_tap_interface_delete_by_guid:
+                dwResult = msica_op_tap_interface_delete_by_guid_exec((const struct msica_op_guid *)op, session);
+                break;
 
-        case msica_op_tap_interface_set_name:
-            dwResult = msica_op_tap_interface_set_name_exec((const struct msica_op_guid_string*)op, session);
-            break;
+            case msica_op_tap_interface_set_name:
+                dwResult = msica_op_tap_interface_set_name_exec((const struct msica_op_guid_string *)op, session);
+                break;
 
-        case msica_op_file_delete:
-            dwResult = msica_op_file_delete_exec((const struct msica_op_string*)op, session);
-            break;
+            case msica_op_file_delete:
+                dwResult = msica_op_file_delete_exec((const struct msica_op_string *)op, session);
+                break;
 
-        case msica_op_file_move:
-            dwResult = msica_op_file_move_exec((const struct msica_op_multistring*)op, session);
-            break;
+            case msica_op_file_move:
+                dwResult = msica_op_file_move_exec((const struct msica_op_multistring *)op, session);
+                break;
 
-        default:
-            msg(M_NONFATAL, "%s: Unknown operation type (%x)", __FUNCTION__, op->type);
-            dwResult = ERROR_FILE_NOT_FOUND;
+            default:
+                msg(M_NONFATAL, "%s: Unknown operation type (%x)", __FUNCTION__, op->type);
+                dwResult = ERROR_FILE_NOT_FOUND;
         }
 
-        if (!session->continue_on_error && dwResult != ERROR_SUCCESS) {
+        if (!session->continue_on_error && dwResult != ERROR_SUCCESS)
+        {
             /* Operation failed. It should have sent error message to Installer. Therefore, just quit here. */
             goto cleanup_hRecordProg;
         }
diff --git a/src/openvpnmsica/msica_op.h b/src/openvpnmsica/msica_op.h
index e42a672e..910a6e51 100644
--- a/src/openvpnmsica/msica_op.h
+++ b/src/openvpnmsica/msica_op.h
@@ -120,12 +120,12 @@ struct msica_op_bool
  *                      released using free() after use. The function returns a pointer to
  *                      msica_op to reduce type-casting in code.
  */
-struct msica_op*
+struct msica_op *
 msica_op_create_bool(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     bool                value);
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ bool value);
 
 
 /**
@@ -153,12 +153,12 @@ struct msica_op_string
  *                      released using free() after use. The function returns a pointer to
  *                      msica_op to reduce type-casting in code.
  */
-struct msica_op*
+struct msica_op *
 msica_op_create_string(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_z_   LPCTSTR             value);
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_z_ LPCTSTR value);
 
 
 /**
@@ -172,26 +172,26 @@ struct msica_op_multistring
 
 
 /**
-* Allocates and fills a new msica_op_multistring operation
-*
-* @param type          Operation type
-*
-* @param ticks         Number of ticks on the progress indicator this operation represents
-*
-* @param next          Pointer to the next operation in the sequence
-*
-* @param arglist       List of non-empty strings. The last string must be NULL.
-*
-* @return              A new msica_op_string operation. Must be added to a sequence list or
-*                      released using free() after use. The function returns a pointer to
-*                      msica_op to reduce type-casting in code.
-*/
-struct msica_op*
+ * Allocates and fills a new msica_op_multistring operation
+ *
+ * @param type          Operation type
+ *
+ * @param ticks         Number of ticks on the progress indicator this operation represents
+ *
+ * @param next          Pointer to the next operation in the sequence
+ *
+ * @param arglist       List of non-empty strings. The last string must be NULL.
+ *
+ * @return              A new msica_op_string operation. Must be added to a sequence list or
+ *                      released using free() after use. The function returns a pointer to
+ *                      msica_op to reduce type-casting in code.
+ */
+struct msica_op *
 msica_op_create_multistring_va(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     va_list             arglist);
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ va_list arglist);
 
 
 /**
@@ -219,12 +219,12 @@ struct msica_op_guid
  *                      released using free() after use. The function returns a pointer to
  *                      msica_op to reduce type-casting in code.
  */
-struct msica_op*
+struct msica_op *
 msica_op_create_guid(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     const GUID         *value);
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ const GUID *value);
 
 
 /**
@@ -255,13 +255,13 @@ struct msica_op_guid_string
  *                      list or released using free() after use. The function returns a
  *                      pointer to msica_op to reduce type-casting in code.
  */
-struct msica_op*
+struct msica_op *
 msica_op_create_guid_string(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
-    _In_     const GUID         *value_guid,
-    _In_z_   LPCTSTR             value_str);
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
+    _In_ const GUID *value_guid,
+    _In_z_ LPCTSTR value_str);
 
 
 /**
@@ -278,11 +278,11 @@ msica_op_create_guid_string(
  *                      released using free() after use. The function returns a pointer to
  *                      msica_op to reduce type-casting in code.
  */
-static inline struct msica_op*
+static inline struct msica_op *
 msica_op_create_multistring(
-    _In_     enum msica_op_type  type,
-    _In_     int                 ticks,
-    _In_opt_ struct msica_op    *next,
+    _In_ enum msica_op_type type,
+    _In_ int ticks,
+    _In_opt_ struct msica_op *next,
     ...)
 {
     va_list arglist;
@@ -319,7 +319,7 @@ msica_op_seq_is_empty(_In_ const struct msica_op_seq *seq)
 void
 msica_op_seq_add_head(
     _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op     *operation);
+    _Inout_ struct msica_op *operation);
 
 
 /**
@@ -334,7 +334,7 @@ msica_op_seq_add_head(
 void
 msica_op_seq_add_tail(
     _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op     *operation);
+    _Inout_ struct msica_op *operation);
 
 
 /**
@@ -349,7 +349,7 @@ msica_op_seq_add_tail(
 DWORD
 msica_op_seq_save(
     _In_ const struct msica_op_seq *seq,
-    _In_ HANDLE                     hFile);
+    _In_ HANDLE hFile);
 
 
 /**
@@ -364,20 +364,20 @@ msica_op_seq_save(
 DWORD
 msica_op_seq_load(
     _Inout_ struct msica_op_seq *seq,
-    _In_    HANDLE               hFile);
+    _In_ HANDLE hFile);
 
 
 /**
-* Execution session constants
-*/
+ * Execution session constants
+ */
 #define MSICA_CLEANUP_ACTION_COMMIT   0
 #define MSICA_CLEANUP_ACTION_ROLLBACK 1
 #define MSICA_CLEANUP_ACTION_COUNT    2
 
 
 /**
-* Execution session
-*/
+ * Execution session
+ */
 struct msica_session
 {
     MSIHANDLE hInstall;           /** Installer handle */
@@ -401,9 +401,9 @@ struct msica_session
 void
 openvpnmsica_session_init(
     _Inout_ struct msica_session *session,
-    _In_    MSIHANDLE             hInstall,
-    _In_    bool                  continue_on_error,
-    _In_    bool                  rollback_enabled);
+    _In_ MSIHANDLE hInstall,
+    _In_ bool continue_on_error,
+    _In_ bool rollback_enabled);
 
 
 /**
@@ -420,10 +420,10 @@ openvpnmsica_session_init(
 DWORD
 msica_op_seq_process(
     _Inout_ const struct msica_op_seq *seq,
-    _Inout_ struct msica_session      *session);
+    _Inout_ struct msica_session *session);
 
 #ifdef _MSC_VER
 #pragma warning(pop)
 #endif
 
-#endif
+#endif /* ifndef MSICA_OP_H */
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 091f86fd..9b95f291 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -37,12 +37,14 @@
 
 UINT
 msi_get_string(
-    _In_   MSIHANDLE  hInstall,
-    _In_z_ LPCTSTR    szName,
-    _Out_  LPTSTR    *pszValue)
+    _In_ MSIHANDLE hInstall,
+    _In_z_ LPCTSTR szName,
+    _Out_ LPTSTR *pszValue)
 {
     if (pszValue == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Try with stack buffer first. */
     TCHAR szBufStack[128];
@@ -61,9 +63,13 @@ msi_get_string(
         LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
         uiResult = MsiGetProperty(hInstall, szName, szBufHeap, &dwLength);
         if (uiResult == ERROR_SUCCESS)
+        {
             *pszValue = szBufHeap;
+        }
         else
+        {
             free(szBufHeap);
+        }
         return uiResult;
     }
     else
@@ -77,12 +83,14 @@ msi_get_string(
 
 UINT
 msi_get_record_string(
-    _In_  MSIHANDLE     hRecord,
-    _In_  unsigned int  iField,
-    _Out_ LPTSTR       *pszValue)
+    _In_ MSIHANDLE hRecord,
+    _In_ unsigned int iField,
+    _Out_ LPTSTR *pszValue)
 {
     if (pszValue == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Try with stack buffer first. */
     TCHAR szBufStack[128];
@@ -101,9 +109,13 @@ msi_get_record_string(
         LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
         uiResult = MsiRecordGetString(hRecord, iField, szBufHeap, &dwLength);
         if (uiResult == ERROR_SUCCESS)
+        {
             *pszValue = szBufHeap;
+        }
         else
+        {
             free(szBufHeap);
+        }
         return uiResult;
     }
     else
@@ -117,12 +129,14 @@ msi_get_record_string(
 
 UINT
 msi_format_record(
-    _In_  MSIHANDLE  hInstall,
-    _In_  MSIHANDLE  hRecord,
-    _Out_ LPTSTR    *pszValue)
+    _In_ MSIHANDLE hInstall,
+    _In_ MSIHANDLE hRecord,
+    _Out_ LPTSTR *pszValue)
 {
     if (pszValue == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Try with stack buffer first. */
     TCHAR szBufStack[128];
@@ -141,9 +155,13 @@ msi_format_record(
         LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
         uiResult = MsiFormatRecord(hInstall, hRecord, szBufHeap, &dwLength);
         if (uiResult == ERROR_SUCCESS)
+        {
             *pszValue = szBufHeap;
+        }
         else
+        {
             free(szBufHeap);
+        }
         return uiResult;
     }
     else
@@ -157,18 +175,23 @@ msi_format_record(
 
 UINT
 msi_format_field(
-    _In_  MSIHANDLE     hInstall,
-    _In_  MSIHANDLE     hRecord,
-    _In_  unsigned int  iField,
-    _Out_ LPTSTR       *pszValue)
+    _In_ MSIHANDLE hInstall,
+    _In_ MSIHANDLE hRecord,
+    _In_ unsigned int iField,
+    _Out_ LPTSTR *pszValue)
 {
     if (pszValue == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Read string to format. */
     LPTSTR szValue = NULL;
     UINT uiResult = msi_get_record_string(hRecord, iField, &szValue);
-    if (uiResult != ERROR_SUCCESS) return uiResult;
+    if (uiResult != ERROR_SUCCESS)
+    {
+        return uiResult;
+    }
     if (szValue[0] == 0)
     {
         /* The string is empty. There's nothing left to do. */
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index fe25226c..e9f98377 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -39,9 +39,9 @@
  */
 UINT
 msi_get_string(
-    _In_   MSIHANDLE  hInstall,
-    _In_z_ LPCTSTR    szName,
-    _Out_  LPTSTR    *pszValue);
+    _In_ MSIHANDLE hInstall,
+    _In_z_ LPCTSTR szName,
+    _Out_ LPTSTR *pszValue);
 
 
 /**
@@ -58,54 +58,54 @@ msi_get_string(
  */
 UINT
 msi_get_record_string(
-    _In_  MSIHANDLE     hRecord,
-    _In_  unsigned int  iField,
-    _Out_ LPTSTR       *pszValue);
+    _In_ MSIHANDLE hRecord,
+    _In_ unsigned int iField,
+    _Out_ LPTSTR *pszValue);
 
 
 /**
-* Formats MSI record
-*
-* @param hInstall      Handle to the installation. This may be omitted, in which case only the
-*                      record field parameters are processed and properties are not available
-*                      for substitution.
-*
-* @param hRecord       Handle to the record to format. The template string must be stored in
-*                      record field 0 followed by referenced data parameters.
-*
-* @param pszValue      Pointer to string to retrieve formatted value. The string must be
-*                      released with free() after use.
-*
-* @return ERROR_SUCCESS on success; Win32 error code otherwise
-*/
+ * Formats MSI record
+ *
+ * @param hInstall      Handle to the installation. This may be omitted, in which case only the
+ *                      record field parameters are processed and properties are not available
+ *                      for substitution.
+ *
+ * @param hRecord       Handle to the record to format. The template string must be stored in
+ *                      record field 0 followed by referenced data parameters.
+ *
+ * @param pszValue      Pointer to string to retrieve formatted value. The string must be
+ *                      released with free() after use.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ */
 UINT
 msi_format_record(
-    _In_  MSIHANDLE  hInstall,
-    _In_  MSIHANDLE  hRecord,
-    _Out_ LPTSTR    *pszValue);
+    _In_ MSIHANDLE hInstall,
+    _In_ MSIHANDLE hRecord,
+    _Out_ LPTSTR *pszValue);
 
 
 /**
-* Formats MSI record field
-*
-* @param hInstall      Handle to the installation. This may be omitted, in which case only the
-*                      record field parameters are processed and properties are not available
-*                      for substitution.
-*
-* @param hRecord       Handle to the field record
-*
-* @param iField        Field index
-*
-* @param pszValue      Pointer to string to retrieve formatted value. The string must be
-*                      released with free() after use.
-*
-* @return ERROR_SUCCESS on success; Win32 error code otherwise
-*/
+ * Formats MSI record field
+ *
+ * @param hInstall      Handle to the installation. This may be omitted, in which case only the
+ *                      record field parameters are processed and properties are not available
+ *                      for substitution.
+ *
+ * @param hRecord       Handle to the field record
+ *
+ * @param iField        Field index
+ *
+ * @param pszValue      Pointer to string to retrieve formatted value. The string must be
+ *                      released with free() after use.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ */
 UINT
 msi_format_field(
-    _In_  MSIHANDLE     hInstall,
-    _In_  MSIHANDLE     hRecord,
-    _In_  unsigned int  iField,
-    _Out_ LPTSTR       *pszValue);
+    _In_ MSIHANDLE hInstall,
+    _In_ MSIHANDLE hRecord,
+    _In_ unsigned int iField,
+    _Out_ LPTSTR *pszValue);
 
-#endif
+#endif /* ifndef MSIHLP_H */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 810c2858..3232a47c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -87,14 +87,16 @@ static const struct {
  */
 static DWORD
 openvpnmsica_setup_sequence_filename(
-    _In_                     MSIHANDLE hInstall,
-    _In_z_                   LPCTSTR   szProperty,
-    _Out_z_cap_(MAXPATH + 1) LPTSTR    szFilename)
+    _In_ MSIHANDLE hInstall,
+    _In_z_ LPCTSTR szProperty,
+    _Out_z_cap_(MAXPATH + 1) LPTSTR szFilename)
 {
     DWORD dwResult;
 
     if (szFilename == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Generate a random filename in the temporary folder. */
     if (GetTempPath(MAX_PATH + 1, szFilename) == 0)
@@ -115,19 +117,19 @@ openvpnmsica_setup_sequence_filename(
     if (dwResult != ERROR_SUCCESS)
     {
         SetLastError(dwResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szProperty);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szProperty);
         return dwResult;
     }
 
     /* Generate and store cleanup operation sequence filenames to properties. */
     LPTSTR szExtension = PathFindExtension(szFilename);
-    TCHAR szFilenameEx[MAX_PATH + 1/*dash*/ + 2/*suffix*/ + 1/*terminator*/];
+    TCHAR szFilenameEx[MAX_PATH + 1 /*dash*/ + 2 /*suffix*/ + 1 /*terminator*/];
     size_t len_property_name = _tcslen(szProperty);
     for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
     {
         size_t len_action_name_z = _tcslen(openvpnmsica_cleanup_action_seqs[i].szName) + 1;
-        TCHAR *szPropertyEx = (TCHAR*)malloc((len_property_name + len_action_name_z) * sizeof(TCHAR));
-        memcpy(szPropertyEx                    , szProperty                                , len_property_name * sizeof(TCHAR));
+        TCHAR *szPropertyEx = (TCHAR *)malloc((len_property_name + len_action_name_z) * sizeof(TCHAR));
+        memcpy(szPropertyEx, szProperty, len_property_name * sizeof(TCHAR));
         memcpy(szPropertyEx + len_property_name, openvpnmsica_cleanup_action_seqs[i].szName, len_action_name_z * sizeof(TCHAR));
         _stprintf_s(
             szFilenameEx, _countof(szFilenameEx),
@@ -139,7 +141,7 @@ openvpnmsica_setup_sequence_filename(
         if (dwResult != ERROR_SUCCESS)
         {
             SetLastError(dwResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szPropertyEx);
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szPropertyEx);
             free(szPropertyEx);
             return dwResult;
         }
@@ -165,7 +167,7 @@ _openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
     TCHAR szTitle[0x100], szMessage[0x100+MAX_PATH], szProcessPath[MAX_PATH];
 
     /* Compose pop-up title. The dialog title will contain function name to ease the process
-       locating. Mind that Visual Studio displays window titles on the process list. */
+     * locating. Mind that Visual Studio displays window titles on the process list. */
     _stprintf_s(szTitle, _countof(szTitle), TEXT("%s v%s"), szFunctionName, TEXT(PACKAGE_VERSION));
 
     /* Get process name. */
@@ -189,9 +191,9 @@ _openvpnmsica_debug_popup(_In_z_ LPCTSTR szFunctionName)
 }
 
 #define openvpnmsica_debug_popup(f) _openvpnmsica_debug_popup(f)
-#else
+#else  /* ifdef _DEBUG */
 #define openvpnmsica_debug_popup(f)
-#endif
+#endif /* ifdef _DEBUG */
 
 
 /**
@@ -214,7 +216,8 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
 #pragma warning(disable: 4996) /* 'GetVersionExW': was declared deprecated. */
 #endif
     OSVERSIONINFOEX ver_info = { .dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX) };
-    if (!GetVersionEx((LPOSVERSIONINFO)&ver_info)) {
+    if (!GetVersionEx((LPOSVERSIONINFO)&ver_info))
+    {
         uiResult = GetLastError();
         msg(M_NONFATAL | M_ERRNO, "%s: GetVersionEx() failed", __FUNCTION__);
         return uiResult;
@@ -227,11 +230,11 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
     TCHAR szDllPath[0x1000];
     ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\ntdll.dll"), szDllPath,
 #ifdef UNICODE
-        _countof(szDllPath)
+                             _countof(szDllPath)
 #else
-        _countof(szDllPath) - 1
+                             _countof(szDllPath) - 1
 #endif
-    );
+                             );
     HMODULE hNtDllModule = LoadLibrary(szDllPath);
     if (hNtDllModule)
     {
@@ -241,10 +244,11 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
         {
             RTL_OSVERSIONINFOW rtl_ver_info = { .dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOW) };
             if (RtlGetVersion(&rtl_ver_info) == 0)
+            {
                 if (
-                    rtl_ver_info.dwMajorVersion >  ver_info.dwMajorVersion ||
-                    rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion >  ver_info.dwMinorVersion ||
-                    rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion == ver_info.dwMinorVersion && rtl_ver_info.dwBuildNumber > ver_info.dwBuildNumber)
+                    rtl_ver_info.dwMajorVersion >  ver_info.dwMajorVersion
+                    || rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion >  ver_info.dwMinorVersion
+                    || rtl_ver_info.dwMajorVersion == ver_info.dwMajorVersion && rtl_ver_info.dwMinorVersion == ver_info.dwMinorVersion && rtl_ver_info.dwBuildNumber > ver_info.dwBuildNumber)
                 {
                     /* We got RtlGetVersion() and it reported newer version than GetVersionEx(). */
                     ver_info.dwMajorVersion = rtl_ver_info.dwMajorVersion;
@@ -252,6 +256,7 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
                     ver_info.dwBuildNumber  = rtl_ver_info.dwBuildNumber;
                     ver_info.dwPlatformId   = rtl_ver_info.dwPlatformId;
                 }
+            }
         }
 
         FreeLibrary(hNtDllModule);
@@ -260,11 +265,11 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
     /* We don't trust RtlGetVersion() either. Check the version resource of kernel32.dll. */
     ExpandEnvironmentStrings(TEXT("%SystemRoot%\\System32\\kernel32.dll"), szDllPath,
 #ifdef UNICODE
-        _countof(szDllPath)
+                             _countof(szDllPath)
 #else
-        _countof(szDllPath)-1
+                             _countof(szDllPath) - 1
 #endif
-    );
+                             );
 
     DWORD dwHandle;
     DWORD dwVerInfoSize = GetFileVersionInfoSize(szDllPath, &dwHandle);
@@ -280,15 +285,17 @@ openvpnmsica_set_driver_certification(_In_ MSIHANDLE hInstall)
                 UINT uiSize = 0;
                 VS_FIXEDFILEINFO *pVSFixedFileInfo = NULL;
                 if (VerQueryValue(pVersionInfo, TEXT("\\"), &pVSFixedFileInfo, &uiSize) && uiSize && pVSFixedFileInfo)
-                    if (HIWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMajorVersion ||
-                        HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMinorVersion ||
-                        HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMinorVersion && HIWORD(pVSFixedFileInfo->dwProductVersionLS) > ver_info.dwBuildNumber)
+                {
+                    if (HIWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMajorVersion
+                        || HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) >  ver_info.dwMinorVersion
+                        || HIWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMajorVersion && LOWORD(pVSFixedFileInfo->dwProductVersionMS) == ver_info.dwMinorVersion && HIWORD(pVSFixedFileInfo->dwProductVersionLS) > ver_info.dwBuildNumber)
                     {
                         /* We got kernel32.dll version and it is newer. */
                         ver_info.dwMajorVersion = HIWORD(pVSFixedFileInfo->dwProductVersionMS);
                         ver_info.dwMinorVersion = LOWORD(pVSFixedFileInfo->dwProductVersionMS);
                         ver_info.dwBuildNumber  = HIWORD(pVSFixedFileInfo->dwProductVersionLS);
                     }
+                }
             }
 
             free(pVersionInfo);
@@ -336,7 +343,8 @@ openvpnmsica_set_openvpnserv_state(_In_ MSIHANDLE hInstall)
     if (hService == NULL)
     {
         uiResult = GetLastError();
-        if (uiResult == ERROR_SERVICE_DOES_NOT_EXIST) {
+        if (uiResult == ERROR_SERVICE_DOES_NOT_EXIST)
+        {
             /* This is not actually an error. */
             goto cleanup_OpenSCManager;
         }
@@ -356,35 +364,35 @@ openvpnmsica_set_openvpnserv_state(_In_ MSIHANDLE hInstall)
 
     switch (ssp.dwCurrentState)
     {
-    case SERVICE_START_PENDING:
-    case SERVICE_RUNNING:
-    case SERVICE_STOP_PENDING:
-    case SERVICE_PAUSE_PENDING:
-    case SERVICE_PAUSED:
-    case SERVICE_CONTINUE_PENDING:
-    {
-        /* Set OPENVPNSERVICE property to service PID. */
-        TCHAR szPID[10/*MAXDWORD in decimal*/ + 1/*terminator*/];
-        _stprintf_s(
-            szPID, _countof(szPID),
-            TEXT("%u"),
-            ssp.dwProcessId);
-
-        uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), szPID);
-        if (uiResult != ERROR_SUCCESS)
+        case SERVICE_START_PENDING:
+        case SERVICE_RUNNING:
+        case SERVICE_STOP_PENDING:
+        case SERVICE_PAUSE_PENDING:
+        case SERVICE_PAUSED:
+        case SERVICE_CONTINUE_PENDING:
         {
-            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
+            /* Set OPENVPNSERVICE property to service PID. */
+            TCHAR szPID[10 /*MAXDWORD in decimal*/ + 1 /*terminator*/];
+            _stprintf_s(
+                szPID, _countof(szPID),
+                TEXT("%u"),
+                ssp.dwProcessId);
+
+            uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), szPID);
+            if (uiResult != ERROR_SUCCESS)
+            {
+                SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+                msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
+            }
+            goto cleanup_OpenService;
         }
-        goto cleanup_OpenService;
-    }
-    break;
+        break;
     }
 finish_QueryServiceStatusEx:;
 
-    // Service is not started. Is it set to auto-start?
-    // MSDN describes the maximum buffer size for QueryServiceConfig() to be 8kB.
-    // This is small enough to fit on stack.
+    /* Service is not started. Is it set to auto-start? */
+    /* MSDN describes the maximum buffer size for QueryServiceConfig() to be 8kB. */
+    /* This is small enough to fit on stack. */
     BYTE _buffer_8k[8192];
     LPQUERY_SERVICE_CONFIG pQsc = (LPQUERY_SERVICE_CONFIG)_buffer_8k;
     dwBufSize = sizeof(_buffer_8k);
@@ -434,7 +442,10 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
     openvpnmsica_set_driver_certification(hInstall);
     openvpnmsica_set_openvpnserv_state(hInstall);
 
-    if (bIsCoInitialized) CoUninitialize();
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
     return ERROR_SUCCESS;
 }
 
@@ -459,14 +470,18 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
     struct tap_interface_node *pInterfaceList = NULL;
     uiResult = tap_list_interfaces(NULL, &pInterfaceList);
     if (uiResult != ERROR_SUCCESS)
+    {
         goto cleanup_CoInitialize;
+    }
 
     /* Get IPv4/v6 info for all network interfaces. Actually, we're interested in link status only: up/down? */
     PIP_ADAPTER_ADDRESSES pAdapterAdresses = NULL;
     ULONG ulAdapterAdressesSize = 16*1024;
-    for (size_t iteration = 0; iteration < 2; iteration++) {
+    for (size_t iteration = 0; iteration < 2; iteration++)
+    {
         pAdapterAdresses = (PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);
-        if (pAdapterAdresses == NULL) {
+        if (pAdapterAdresses == NULL)
+        {
             msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, ulAdapterAdressesSize);
             uiResult = ERROR_OUTOFMEMORY; goto cleanup_tap_list_interfaces;
         }
@@ -479,10 +494,13 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
             &ulAdapterAdressesSize);
 
         if (ulResult == ERROR_SUCCESS)
+        {
             break;
+        }
 
         free(pAdapterAdresses);
-        if (ulResult != ERROR_BUFFER_OVERFLOW) {
+        if (ulResult != ERROR_BUFFER_OVERFLOW)
+        {
             SetLastError(ulResult); /* MSDN does not mention GetAdaptersAddresses() to set GetLastError(). But we do have an error code. Set last error manually. */
             msg(M_NONFATAL | M_ERRNO, "%s: GetAdaptersAddresses() failed", __FUNCTION__);
             uiResult = ulResult; goto cleanup_tap_list_interfaces;
@@ -501,8 +519,8 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
     {
         for (LPCTSTR hwid = pInterface->szzHardwareIDs; hwid[0]; hwid += _tcslen(hwid) + 1)
         {
-            if (_tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0 ||
-                _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+            if (_tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
+                || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
             {
                 /* TAP interface found. */
 
@@ -514,13 +532,17 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
                 CoTaskMemFree(szInterfaceId);
 
                 /* Append interface to the list. */
-                struct interface_node *node = (struct interface_node*)malloc(sizeof(struct interface_node));
+                struct interface_node *node = (struct interface_node *)malloc(sizeof(struct interface_node));
                 node->iface = pInterface;
                 node->next = NULL;
                 if (interfaces_head)
+                {
                     interfaces_tail = interfaces_tail->next = node;
+                }
                 else
+                {
                     interfaces_head = interfaces_tail = node;
+                }
                 interface_count++;
                 break;
             }
@@ -532,9 +554,9 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
     {
         /* Prepare semicolon delimited list of TAP interface ID(s) and active TAP interface ID(s). */
         LPTSTR
-            szTAPInterfaces           = (LPTSTR)malloc(interface_count * (38/*GUID*/ + 1/*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPInterfaces           = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
             szTAPInterfacesTail       = szTAPInterfaces,
-            szTAPInterfacesActive     = (LPTSTR)malloc(interface_count * (38/*GUID*/ + 1/*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPInterfacesActive     = (LPTSTR)malloc(interface_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(TCHAR)),
             szTAPInterfacesActiveTail = szTAPInterfacesActive;
         while (interfaces_head)
         {
@@ -544,7 +566,9 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 
             /* Append to the list of TAP interface ID(s). */
             if (szTAPInterfaces < szTAPInterfacesTail)
+            {
                 *(szTAPInterfacesTail++) = TEXT(';');
+            }
             memcpy(szTAPInterfacesTail, szInterfaceId, 38 * sizeof(TCHAR));
             szTAPInterfacesTail += 38;
 
@@ -553,15 +577,17 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
             {
                 OLECHAR szId[38 + 1];
                 GUID guid;
-                if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0 &&
-                    SUCCEEDED(IIDFromString(szId, &guid)) &&
-                    memcmp(&guid, &interfaces_head->iface->guid, sizeof(GUID)) == 0)
+                if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0
+                    && SUCCEEDED(IIDFromString(szId, &guid))
+                    && memcmp(&guid, &interfaces_head->iface->guid, sizeof(GUID)) == 0)
                 {
                     if (p->OperStatus == IfOperStatusUp)
                     {
                         /* This TAP interface is active (connected). */
                         if (szTAPInterfacesActive < szTAPInterfacesActiveTail)
+                        {
                             *(szTAPInterfacesActiveTail++) = TEXT(';');
+                        }
                         memcpy(szTAPInterfacesActiveTail, szInterfaceId, 38 * sizeof(TCHAR));
                         szTAPInterfacesActiveTail += 38;
                     }
@@ -595,18 +621,23 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
             goto cleanup_szTAPInterfaces;
         }
 
-    cleanup_szTAPInterfaces:
+cleanup_szTAPInterfaces:
         free(szTAPInterfacesActive);
         free(szTAPInterfaces);
     }
     else
+    {
         uiResult = ERROR_SUCCESS;
+    }
 
     free(pAdapterAdresses);
 cleanup_tap_list_interfaces:
     tap_free_interface_list(pInterfaceList);
 cleanup_CoInitialize:
-    if (bIsCoInitialized) CoUninitialize();
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
     return uiResult;
 }
 
@@ -702,11 +733,16 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 
 cleanup_malloc_szPath:
     if (szPath != szStackBuf)
+    {
         free(szPath);
+    }
 cleanup_MsiCreateRecord:
     MsiCloseHandle(hRecord);
 cleanup_CoInitialize:
-    if (bIsCoInitialized) CoUninitialize();
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
     return uiResult;
 }
 
@@ -735,16 +771,19 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
     };
     struct msica_op_seq exec_seq[_countof(szActionNames)];
     for (size_t i = 0; i < _countof(szActionNames); i++)
+    {
         msica_op_seq_init(&exec_seq[i]);
+    }
 
     {
         /* Check and store the rollback enabled state. */
         TCHAR szValue[128];
         DWORD dwLength = _countof(szValue);
         bool enable_rollback = MsiGetProperty(hInstall, TEXT("RollbackDisabled"), szValue, &dwLength) == ERROR_SUCCESS ?
-            _ttoi(szValue) || _totlower(szValue[0]) == TEXT('y') ? false : true :
-            true;
+                               _ttoi(szValue) || _totlower(szValue[0]) == TEXT('y') ? false : true :
+                               true;
         for (size_t i = 0; i < _countof(szActionNames); i++)
+        {
             msica_op_seq_add_tail(
                 &exec_seq[i],
                 msica_op_create_bool(
@@ -752,6 +791,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
                     0,
                     NULL,
                     enable_rollback));
+        }
     }
 
     /* Open MSI database. */
@@ -765,11 +805,12 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
     /* Check if TAPInterface table exists. If it doesn't exist, there's nothing to do. */
     switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TAPInterface")))
     {
-    case MSICONDITION_FALSE:
-    case MSICONDITION_TRUE : break;
-    default:
-        uiResult = ERROR_SUCCESS;
-        goto cleanup_hDatabase;
+        case MSICONDITION_FALSE:
+        case MSICONDITION_TRUE: break;
+
+        default:
+            uiResult = ERROR_SUCCESS;
+            goto cleanup_hDatabase;
     }
 
     /* Prepare a query to get a list/view of interfaces. */
@@ -779,7 +820,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
     if (uiResult != ERROR_SUCCESS)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szQuery);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szQuery);
         goto cleanup_hDatabase;
     }
 
@@ -788,7 +829,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
     if (uiResult != ERROR_SUCCESS)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiViewExecute() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szQuery);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szQuery);
         goto cleanup_hViewST;
     }
 
@@ -806,7 +847,8 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
         /* Fetch one record from the view. */
         MSIHANDLE hRecord = 0;
         uiResult = MsiViewFetch(hViewST, &hRecord);
-        if (uiResult == ERROR_NO_MORE_ITEMS) {
+        if (uiResult == ERROR_NO_MORE_ITEMS)
+        {
             uiResult = ERROR_SUCCESS;
             break;
         }
@@ -822,14 +864,17 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
             /* Read interface component ID (`Component_` is field #4). */
             LPTSTR szValue = NULL;
             uiResult = msi_get_record_string(hRecord, 4, &szValue);
-            if (uiResult != ERROR_SUCCESS) goto cleanup_hRecord;
+            if (uiResult != ERROR_SUCCESS)
+            {
+                goto cleanup_hRecord;
+            }
 
             /* Get the component state. */
             uiResult = MsiGetComponentState(hInstall, szValue, &iInstalled, &iAction);
             if (uiResult != ERROR_SUCCESS)
             {
                 SetLastError(uiResult); /* MSDN does not mention MsiGetComponentState() to set GetLastError(). But we do have an error code. Set last error manually. */
-                msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szValue);
+                msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szValue);
                 free(szValue);
                 goto cleanup_hRecord;
             }
@@ -840,15 +885,21 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
         LPTSTR szDisplayName = NULL;
         uiResult = msi_format_field(hInstall, hRecord, 2, &szDisplayName);
         if (uiResult != ERROR_SUCCESS)
+        {
             goto cleanup_hRecord;
+        }
 
         if (iAction > INSTALLSTATE_BROKEN)
         {
-            if (iAction >= INSTALLSTATE_LOCAL) {
+            if (iAction >= INSTALLSTATE_LOCAL)
+            {
                 /* Read and evaluate interface condition (`Condition` is field #3). */
                 LPTSTR szValue = NULL;
                 uiResult = msi_get_record_string(hRecord, 3, &szValue);
-                if (uiResult != ERROR_SUCCESS) goto cleanup_szDisplayName;
+                if (uiResult != ERROR_SUCCESS)
+                {
+                    goto cleanup_szDisplayName;
+                }
 #ifdef __GNUC__
 /*
  * warning: enumeration value ‘MSICONDITION_TRUE’ not handled in switch
@@ -859,14 +910,15 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 #endif
                 switch (MsiEvaluateCondition(hInstall, szValue))
                 {
-                case MSICONDITION_FALSE:
-                    free(szValue);
-                    goto cleanup_szDisplayName;
-                case MSICONDITION_ERROR:
-                    uiResult = ERROR_INVALID_FIELD;
-                    msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szValue);
-                    free(szValue);
-                    goto cleanup_szDisplayName;
+                    case MSICONDITION_FALSE:
+                        free(szValue);
+                        goto cleanup_szDisplayName;
+
+                    case MSICONDITION_ERROR:
+                        uiResult = ERROR_INVALID_FIELD;
+                        msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szValue);
+                        free(szValue);
+                        goto cleanup_szDisplayName;
                 }
 #ifdef __GNUC__
 #pragma GCC diagnostic pop
@@ -904,27 +956,33 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
             }
         }
 
-    cleanup_szDisplayName:
+cleanup_szDisplayName:
         free(szDisplayName);
-    cleanup_hRecord:
+cleanup_hRecord:
         MsiCloseHandle(hRecord);
         if (uiResult != ERROR_SUCCESS)
+        {
             goto cleanup_hRecordProg;
+        }
     }
 
     /*
-    Write sequence files.
-    The InstallTAPInterfaces and UninstallTAPInterfaces are deferred custom actions, thus all this information
-    will be unavailable to them. Therefore save all required operations and their info to sequence files.
-    */
+     * Write sequence files.
+     * The InstallTAPInterfaces and UninstallTAPInterfaces are deferred custom actions, thus all this information
+     * will be unavailable to them. Therefore save all required operations and their info to sequence files.
+     */
     TCHAR szSeqFilename[_countof(szActionNames)][MAX_PATH + 1];
     for (size_t i = 0; i < _countof(szActionNames); i++)
+    {
         szSeqFilename[i][0] = 0;
+    }
     for (size_t i = 0; i < _countof(szActionNames); i++)
     {
         uiResult = openvpnmsica_setup_sequence_filename(hInstall, szActionNames[i], szSeqFilename[i]);
         if (uiResult != ERROR_SUCCESS)
+        {
             goto cleanup_szSeqFilename;
+        }
         HANDLE hSeqFile = CreateFile(
             szSeqFilename[i],
             GENERIC_WRITE,
@@ -936,13 +994,15 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
         if (hSeqFile == INVALID_HANDLE_VALUE)
         {
             uiResult = GetLastError();
-            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*"PRIsLPTSTR"\") failed", __FUNCTION__, _countof(szSeqFilename[i]), szSeqFilename[i]);
+            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*" PRIsLPTSTR "\") failed", __FUNCTION__, _countof(szSeqFilename[i]), szSeqFilename[i]);
             goto cleanup_szSeqFilename;
         }
         uiResult = msica_op_seq_save(&exec_seq[i], hSeqFile);
         CloseHandle(hSeqFile);
         if (uiResult != ERROR_SUCCESS)
+        {
             goto cleanup_szSeqFilename;
+        }
     }
 
     uiResult = ERROR_SUCCESS;
@@ -952,8 +1012,12 @@ cleanup_szSeqFilename:
     {
         /* Clean-up sequence files. */
         for (size_t i = _countof(szActionNames); i--;)
+        {
             if (szSeqFilename[i][0])
+            {
                 DeleteFile(szSeqFilename[i]);
+            }
+        }
     }
 cleanup_hRecordProg:
     MsiCloseHandle(hRecordProg);
@@ -965,8 +1029,13 @@ cleanup_hDatabase:
     MsiCloseHandle(hDatabase);
 cleanup_exec_seq:
     for (size_t i = 0; i < _countof(szActionNames); i++)
+    {
         msica_op_seq_free(&exec_seq[i]);
-    if (bIsCoInitialized) CoUninitialize();
+    }
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
     return uiResult;
 }
 
@@ -993,7 +1062,9 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
     LPTSTR szSeqFilename = NULL;
     uiResult = msi_get_string(hInstall, TEXT("CustomActionData"), &szSeqFilename);
     if (uiResult != ERROR_SUCCESS)
+    {
         goto cleanup_CoInitialize;
+    }
     struct msica_op_seq seq = { .head = NULL, .tail = NULL };
     {
         HANDLE hSeqFile = CreateFile(
@@ -1010,14 +1081,14 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
             if (uiResult == ERROR_FILE_NOT_FOUND && bIsCleanup)
             {
                 /*
-                Sequence file not found and this is rollback/commit action. Either of the following scenarios are possible:
-                - The delayed action failed to save the rollback/commit sequence to file. The delayed action performed cleanup itself. No further operation is required.
-                - Somebody removed the rollback/commit file between delayed action and rollback/commit action. No further operation is possible.
-                */
+                 * Sequence file not found and this is rollback/commit action. Either of the following scenarios are possible:
+                 * - The delayed action failed to save the rollback/commit sequence to file. The delayed action performed cleanup itself. No further operation is required.
+                 * - Somebody removed the rollback/commit file between delayed action and rollback/commit action. No further operation is possible.
+                 */
                 uiResult = ERROR_SUCCESS;
                 goto cleanup_szSeqFilename;
             }
-            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szSeqFilename);
+            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szSeqFilename);
             goto cleanup_szSeqFilename;
         }
 
@@ -1025,7 +1096,9 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
         uiResult = msica_op_seq_load(&seq, hSeqFile);
         CloseHandle(hSeqFile);
         if (uiResult != ERROR_SUCCESS)
+        {
             goto cleanup_seq;
+        }
     }
 
     /* Prepare session context. */
@@ -1041,12 +1114,12 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
     if (!bIsCleanup)
     {
         /*
-        Save cleanup scripts of delayed action regardless of action's execution status.
-        Rollback action MUST be scheduled in InstallExecuteSequence before this action! Otherwise cleanup won't be performed in case this action execution failed.
-        */
+         * Save cleanup scripts of delayed action regardless of action's execution status.
+         * Rollback action MUST be scheduled in InstallExecuteSequence before this action! Otherwise cleanup won't be performed in case this action execution failed.
+         */
         DWORD dwResultEx; /* Don't overwrite uiResult. */
         LPCTSTR szExtension = PathFindExtension(szSeqFilename);
-        TCHAR szFilenameEx[MAX_PATH + 1/*dash*/ + 2/*suffix*/ + 1/*terminator*/];
+        TCHAR szFilenameEx[MAX_PATH + 1 /*dash*/ + 2 /*suffix*/ + 1 /*terminator*/];
         for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
         {
             _stprintf_s(
@@ -1086,16 +1159,18 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
             if (hSeqFile == INVALID_HANDLE_VALUE)
             {
                 dwResultEx = GetLastError();
-                msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*"PRIsLPTSTR"\") failed", __FUNCTION__, _countof(szFilenameEx), szFilenameEx);
+                msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*" PRIsLPTSTR "\") failed", __FUNCTION__, _countof(szFilenameEx), szFilenameEx);
                 goto cleanup_session;
             }
             dwResultEx = msica_op_seq_save(&session.seq_cleanup[i], hSeqFile);
             CloseHandle(hSeqFile);
             if (dwResultEx != ERROR_SUCCESS)
+            {
                 goto cleanup_session;
+            }
         }
 
-    cleanup_session:
+cleanup_session:
         if (dwResultEx != ERROR_SUCCESS)
         {
             /* The commit and/or rollback scripts were not written to file successfully. Perform the cleanup immediately. */
@@ -1127,13 +1202,18 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
     }
 
     for (size_t i = MSICA_CLEANUP_ACTION_COUNT; i--;)
+    {
         msica_op_seq_free(&session.seq_cleanup[i]);
+    }
     DeleteFile(szSeqFilename);
 cleanup_seq:
     msica_op_seq_free(&seq);
 cleanup_szSeqFilename:
     free(szSeqFilename);
 cleanup_CoInitialize:
-    if (bIsCoInitialized) CoUninitialize();
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
     return uiResult;
 }
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 4ee5c05f..382064b6 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -25,9 +25,9 @@
 #include "../tapctl/basic.h"
 
 
- /*
-  * Error codes (next unused 2552L)
-  */
+/*
+ * Error codes (next unused 2552L)
+ */
 #define ERROR_MSICA       2550L
 #define ERROR_MSICA_ERRNO 2551L
 
@@ -59,7 +59,7 @@ extern "C" {
 #define DLLEXP_DECL __declspec(dllexport)
 #else
 #define DLLEXP_DECL
-#define DLLEXP_EXPORT "/EXPORT:"__FUNCTION__"="__FUNCDNAME__
+#define DLLEXP_EXPORT "/EXPORT:" __FUNCTION__ "=" __FUNCDNAME__
 #endif
 
 
@@ -144,4 +144,4 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall);
 }
 #endif
 
-#endif
+#endif /* ifndef MSICA_H */
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 442f3c32..3469cb1c 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -51,4 +51,4 @@
 #define _Out_z_cap_(n)
 #endif
 
-#endif
+#endif /* ifndef BASIC_H */
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index a62dd4da..1ac9b835 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -75,6 +75,7 @@ bool dont_mute(unsigned int flags);
 #endif
 
 void x_msg(const unsigned int flags, const char *format, ...);     /* should be called via msg above */
+
 void x_msg_va(const unsigned int flags, const char *format, va_list arglist);
 
 /* Inline functions */
@@ -92,4 +93,4 @@ msg_test(unsigned int flags)
     return check_debug_level(flags) && dont_mute(flags);
 }
 
-#endif
+#endif /* ifndef ERROR_H */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 13b14f70..5e6e1752 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -62,7 +62,7 @@ static const TCHAR usage_message[] =
     TEXT("help       Display this text\n")
     TEXT("\n")
     TEXT("Hint: Use \"tapctl help <command>\" to display help for particular command.\n")
-    ;
+;
 
 static const TCHAR usage_message_create[] =
     TEXT("%s\n")
@@ -84,7 +84,7 @@ static const TCHAR usage_message_create[] =
     TEXT("Output:\n")
     TEXT("\n")
     TEXT("This command prints newly created TUN/TAP interface's GUID to stdout.          \n")
-    ;
+;
 
 static const TCHAR usage_message_list[] =
     TEXT("%s\n")
@@ -98,7 +98,7 @@ static const TCHAR usage_message_list[] =
     TEXT("Output:\n")
     TEXT("\n")
     TEXT("This command prints all network interfaces to stdout.                          \n")
-    ;
+;
 
 static const TCHAR usage_message_delete[] =
     TEXT("%s\n")
@@ -108,7 +108,7 @@ static const TCHAR usage_message_delete[] =
     TEXT("Usage:\n")
     TEXT("\n")
     TEXT("tapctl delete <interface GUID | interface name>\n")
-    ;
+;
 
 
 /**
@@ -118,8 +118,8 @@ static void
 usage(void)
 {
     _ftprintf(stderr,
-        usage_message,
-        title_string);
+              usage_message,
+              title_string);
 }
 
 
@@ -144,15 +144,25 @@ _tmain(int argc, LPCTSTR argv[])
     {
         /* Output help. */
         if (argc < 3)
+        {
             usage();
+        }
         else if (_tcsicmp(argv[2], TEXT("create")) == 0)
+        {
             _ftprintf(stderr, usage_message_create, title_string);
+        }
         else if (_tcsicmp(argv[2], TEXT("list")) == 0)
+        {
             _ftprintf(stderr, usage_message_list, title_string);
+        }
         else if (_tcsicmp(argv[2], TEXT("delete")) == 0)
+        {
             _ftprintf(stderr, usage_message_delete, title_string);
+        }
         else
+        {
             _ftprintf(stderr, TEXT("Unknown command \"%s\". Please, use \"tapctl help\" to list supported commands.\n"), argv[2]);
+        }
 
         return 1;
     }
@@ -164,9 +174,13 @@ _tmain(int argc, LPCTSTR argv[])
         for (int i = 2; i < argc; i++)
         {
             if (_tcsicmp(argv[i], TEXT("--name")) == 0)
+            {
                 szName = argv[++i];
+            }
             else
+            {
                 _ftprintf(stderr, TEXT("Unknown option \"%s\". Please, use \"tapctl help create\" to list supported options. Ignored.\n"), argv[i]);
+            }
         }
 
         /* Create TUN/TAP interface. */
@@ -218,10 +232,12 @@ _tmain(int argc, LPCTSTR argv[])
 
             iResult = 0;
 
-        create_cleanup_pInterfaceList:
+create_cleanup_pInterfaceList:
             tap_free_interface_list(pInterfaceList);
             if (iResult)
+            {
                 goto create_delete_interface;
+            }
         }
 
         /* Output interface GUID. */
@@ -231,7 +247,7 @@ _tmain(int argc, LPCTSTR argv[])
 
         iResult = 0; goto quit;
 
-    create_delete_interface:
+create_delete_interface:
         tap_delete_interface(
             NULL,
             &guidInterface,
@@ -280,7 +296,7 @@ _tmain(int argc, LPCTSTR argv[])
                 iResult = 1; goto quit;
             }
 
-            for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+            for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
             {
                 if (pInterface == NULL)
                 {
@@ -296,10 +312,12 @@ _tmain(int argc, LPCTSTR argv[])
 
             iResult = 0;
 
-        delete_cleanup_pInterfaceList:
+delete_cleanup_pInterfaceList:
             tap_free_interface_list(pInterfaceList);
             if (iResult)
+            {
                 goto quit;
+            }
         }
 
         /* Delete the network interface. */
@@ -323,7 +341,9 @@ _tmain(int argc, LPCTSTR argv[])
 
 quit:
     if (bRebootRequired)
+    {
         _ftprintf(stderr, TEXT("A system reboot is required.\n"));
+    }
 
     return iResult;
 }
@@ -351,21 +371,23 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
         DWORD dwResult = GetLastError();
         LPTSTR szErrMessage = NULL;
         if (FormatMessage(
-            FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
-            0,
-            dwResult,
-            0,
-            (LPTSTR)&szErrMessage,
-            0,
-            NULL) && szErrMessage)
+                FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
+                0,
+                dwResult,
+                0,
+                (LPTSTR)&szErrMessage,
+                0,
+                NULL) && szErrMessage)
         {
             /* Trim trailing whitespace. Set terminator after the last non-whitespace character. This prevents excessive trailing line breaks. */
-            for (size_t i = 0, i_last = 0; ; i++)
+            for (size_t i = 0, i_last = 0;; i++)
             {
                 if (szErrMessage[i])
                 {
                     if (!_istspace(szErrMessage[i]))
+                    {
                         i_last = i + 1;
+                    }
                 }
                 else
                 {
@@ -380,6 +402,8 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
             LocalFree(szErrMessage);
         }
         else
+        {
             _ftprintf(stderr, TEXT("Error 0x%x\n"), dwResult);
+        }
     }
 }
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index bc6582f5..790a4956 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -64,18 +64,20 @@ const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentContro
  **/
 static DWORD
 check_reboot(
-    _In_    HDEVINFO         hDeviceInfoSet,
-    _In_    PSP_DEVINFO_DATA pDeviceInfoData,
-    _Inout_ LPBOOL           pbRebootRequired)
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _Inout_ LPBOOL pbRebootRequired)
 {
     if (pbRebootRequired == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     SP_DEVINSTALL_PARAMS devinstall_params = { .cbSize = sizeof(SP_DEVINSTALL_PARAMS) };
     if (!SetupDiGetDeviceInstallParams(
-        hDeviceInfoSet,
-        pDeviceInfoData,
-        &devinstall_params))
+            hDeviceInfoSet,
+            pDeviceInfoData,
+            &devinstall_params))
     {
         DWORD dwResult = GetLastError();
         msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDeviceInstallParams failed", __FUNCTION__);
@@ -83,7 +85,9 @@ check_reboot(
     }
 
     if ((devinstall_params.Flags & (DI_NEEDREBOOT | DI_NEEDRESTART)) != 0)
+    {
         *pbRebootRequired = TRUE;
+    }
 
     return ERROR_SUCCESS;
 }
@@ -105,12 +109,14 @@ check_reboot(
  */
 static DWORD
 get_reg_string(
-    _In_  HKEY     hKey,
-    _In_  LPCTSTR  szName,
-    _Out_ LPTSTR  *pszValue)
+    _In_ HKEY hKey,
+    _In_ LPCTSTR szName,
+    _Out_ LPTSTR *pszValue)
 {
     if (pszValue == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     DWORD dwValueType = REG_NONE, dwSize = 0;
     DWORD dwResult = RegQueryValueEx(
@@ -123,14 +129,14 @@ get_reg_string(
     if (dwResult != ERROR_SUCCESS)
     {
         SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: enumerating \"%"PRIsLPTSTR"\" registry value failed", __FUNCTION__, szName);
+        msg(M_NONFATAL | M_ERRNO, "%s: enumerating \"%" PRIsLPTSTR "\" registry value failed", __FUNCTION__, szName);
         return dwResult;
     }
 
     switch (dwValueType)
     {
-    case REG_SZ:
-    case REG_EXPAND_SZ:
+        case REG_SZ:
+        case REG_EXPAND_SZ:
         {
             /* Read value. */
             LPTSTR szValue = (LPTSTR)malloc(dwSize);
@@ -144,7 +150,7 @@ get_reg_string(
             if (dwResult != ERROR_SUCCESS)
             {
                 SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-                msg(M_NONFATAL | M_ERRNO, "%s: reading \"%"PRIsLPTSTR"\" registry value failed", __FUNCTION__, szName);
+                msg(M_NONFATAL | M_ERRNO, "%s: reading \"%" PRIsLPTSTR "\" registry value failed", __FUNCTION__, szName);
                 free(szValue);
                 return dwResult;
             }
@@ -156,18 +162,18 @@ get_reg_string(
                     dwSizeExp = dwSize * 2,
                     dwCountExp =
 #ifdef UNICODE
-                        dwSizeExp / sizeof(TCHAR);
+                    dwSizeExp / sizeof(TCHAR);
 #else
-                        dwSizeExp / sizeof(TCHAR) - 1; /* Note: ANSI version requires one extra char. */
+                    dwSizeExp / sizeof(TCHAR) - 1;     /* Note: ANSI version requires one extra char. */
 #endif
                 LPTSTR szValueExp = (LPTSTR)malloc(dwSizeExp);
                 DWORD dwCountExpResult = ExpandEnvironmentStrings(
                     szValue,
                     szValueExp, dwCountExp
-                );
+                    );
                 if (dwCountExpResult == 0)
                 {
-                    msg(M_NONFATAL | M_ERRNO, "%s: expanding \"%"PRIsLPTSTR"\" registry value failed", __FUNCTION__, szName);
+                    msg(M_NONFATAL | M_ERRNO, "%s: expanding \"%" PRIsLPTSTR "\" registry value failed", __FUNCTION__, szName);
                     free(szValueExp);
                     free(szValue);
                     return dwResult;
@@ -206,9 +212,9 @@ get_reg_string(
             }
         }
 
-    default:
-        msg(M_NONFATAL, "%s: \"%"PRIsLPTSTR"\" registry value is not string (type %u)", __FUNCTION__, dwValueType);
-        return ERROR_UNSUPPORTED_TYPE;
+        default:
+            msg(M_NONFATAL, "%s: \"%" PRIsLPTSTR "\" registry value is not string (type %u)", __FUNCTION__, dwValueType);
+            return ERROR_UNSUPPORTED_TYPE;
     }
 }
 
@@ -233,15 +239,17 @@ get_reg_string(
  **/
 static DWORD
 get_net_interface_guid(
-    _In_  HDEVINFO         hDeviceInfoSet,
-    _In_  PSP_DEVINFO_DATA pDeviceInfoData,
-    _In_  int              iNumAttempts,
-    _Out_ LPGUID           pguidInterface)
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _In_ int iNumAttempts,
+    _Out_ LPGUID pguidInterface)
 {
     DWORD dwResult = ERROR_BAD_ARGUMENTS;
 
     if (pguidInterface == NULL || iNumAttempts < 1)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Open HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\<class>\<id> registry key. */
     HKEY hKey = SetupDiOpenDevRegKey(
@@ -283,7 +291,9 @@ get_net_interface_guid(
             TEXT("NetCfgInstanceId"),
             &szCfgGuidString);
         if (dwResult != ERROR_SUCCESS)
+        {
             break;
+        }
 
         dwResult = SUCCEEDED(CLSIDFromString(szCfgGuidString, (LPCLSID)pguidInterface)) ? ERROR_SUCCESS : ERROR_INVALID_DATA;
         free(szCfgGuidString);
@@ -296,51 +306,53 @@ get_net_interface_guid(
 
 
 /**
-* Returns a specified Plug and Play device property.
-*
-* @param hDeviceInfoSet  A handle to a device information set that contains a device
-*                      information element that represents the device for which to
-*                      retrieve a Plug and Play property.
-*
-* @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the 
-*                      device information element in hDeviceInfoSet.
-*
-* @param dwProperty     Specifies the property to be retrieved. See
-*                       https://msdn.microsoft.com/en-us/library/windows/hardware/ff551967.aspx
-*
-* @pdwPropertyRegDataType  A pointer to a variable that receives the data type of the
-*                       property that is being retrieved. This is one of the standard
-*                       registry data types. This parameter is optional and can be NULL.
-*
-* @param ppData         A pointer to pointer to data that receives the device propery. The
-*                       data must be released with free() after use.
-*
-* @return ERROR_SUCCESS on success; Win32 error code otherwise
-**/
+ * Returns a specified Plug and Play device property.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device for which to
+ *                      retrieve a Plug and Play property.
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param dwProperty     Specifies the property to be retrieved. See
+ *                       https://msdn.microsoft.com/en-us/library/windows/hardware/ff551967.aspx
+ *
+ * @pdwPropertyRegDataType  A pointer to a variable that receives the data type of the
+ *                       property that is being retrieved. This is one of the standard
+ *                       registry data types. This parameter is optional and can be NULL.
+ *
+ * @param ppData         A pointer to pointer to data that receives the device propery. The
+ *                       data must be released with free() after use.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
 static DWORD
 get_device_reg_property(
-    _In_      HDEVINFO          hDeviceInfoSet,
-    _In_      PSP_DEVINFO_DATA  pDeviceInfoData,
-    _In_      DWORD             dwProperty,
-    _Out_opt_ LPDWORD           pdwPropertyRegDataType,
-    _Out_     LPVOID            *ppData)
+    _In_ HDEVINFO hDeviceInfoSet,
+    _In_ PSP_DEVINFO_DATA pDeviceInfoData,
+    _In_ DWORD dwProperty,
+    _Out_opt_ LPDWORD pdwPropertyRegDataType,
+    _Out_ LPVOID *ppData)
 {
     DWORD dwResult = ERROR_BAD_ARGUMENTS;
 
     if (ppData == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Try with stack buffer first. */
     BYTE bBufStack[128];
     DWORD dwRequiredSize = 0;
     if (SetupDiGetDeviceRegistryProperty(
-        hDeviceInfoSet,
-        pDeviceInfoData,
-        dwProperty,
-        pdwPropertyRegDataType,
-        bBufStack,
-        sizeof(bBufStack),
-        &dwRequiredSize))
+            hDeviceInfoSet,
+            pDeviceInfoData,
+            dwProperty,
+            pdwPropertyRegDataType,
+            bBufStack,
+            sizeof(bBufStack),
+            &dwRequiredSize))
     {
         /* Copy from stack. */
         *ppData = malloc(dwRequiredSize);
@@ -355,14 +367,16 @@ get_device_reg_property(
             /* Allocate on heap and retry. */
             *ppData = malloc(dwRequiredSize);
             if (SetupDiGetDeviceRegistryProperty(
-                hDeviceInfoSet,
-                pDeviceInfoData,
-                dwProperty,
-                pdwPropertyRegDataType,
-                *ppData,
-                dwRequiredSize,
-                &dwRequiredSize))
+                    hDeviceInfoSet,
+                    pDeviceInfoData,
+                    dwProperty,
+                    pdwPropertyRegDataType,
+                    *ppData,
+                    dwRequiredSize,
+                    &dwRequiredSize))
+            {
                 return ERROR_SUCCESS;
+            }
             else
             {
                 dwResult = GetLastError();
@@ -380,33 +394,37 @@ get_device_reg_property(
 
 
 /**
-* Returns length of list of strings
-*
-* @param str              Pointer to a list of strings terminated by an empty string.
-*
-* @return Number of characters not counting the final zero terminator
-**/
+ * Returns length of list of strings
+ *
+ * @param str              Pointer to a list of strings terminated by an empty string.
+ *
+ * @return Number of characters not counting the final zero terminator
+ **/
 static inline size_t
 _tcszlen(_In_ LPCTSTR str)
 {
     LPCTSTR s;
-    for (s = str; s[0]; s += _tcslen(s) + 1);
+    for (s = str; s[0]; s += _tcslen(s) + 1)
+    {
+    }
     return s - str;
 }
 
 
 DWORD
 tap_create_interface(
-    _In_opt_ HWND    hwndParent,
+    _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
-    _Inout_  LPBOOL  pbRebootRequired,
-    _Out_    LPGUID  pguidInterface)
+    _Inout_ LPBOOL pbRebootRequired,
+    _Out_ LPGUID pguidInterface)
 {
     DWORD dwResult;
 
-    if (pbRebootRequired == NULL ||
-        pguidInterface == NULL)
+    if (pbRebootRequired == NULL
+        || pguidInterface == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Create an empty device info set for network adapter device class. */
     HDEVINFO hDevInfoList = SetupDiCreateDeviceInfoList(&GUID_DEVCLASS_NET, hwndParent);
@@ -420,10 +438,10 @@ tap_create_interface(
     /* Get the device class name from GUID. */
     TCHAR szClassName[MAX_CLASS_NAME_LEN];
     if (!SetupDiClassNameFromGuid(
-        &GUID_DEVCLASS_NET,
-        szClassName,
-        _countof(szClassName),
-        NULL))
+            &GUID_DEVCLASS_NET,
+            szClassName,
+            _countof(szClassName),
+            NULL))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiClassNameFromGuid failed", __FUNCTION__);
@@ -433,13 +451,13 @@ tap_create_interface(
     /* Create a new device info element and add it to the device info set. */
     SP_DEVINFO_DATA devinfo_data = { .cbSize = sizeof(SP_DEVINFO_DATA) };
     if (!SetupDiCreateDeviceInfo(
-        hDevInfoList,
-        szClassName,
-        &GUID_DEVCLASS_NET,
-        szDeviceDescription,
-        hwndParent,
-        DICD_GENERATE_ID,
-        &devinfo_data))
+            hDevInfoList,
+            szClassName,
+            &GUID_DEVCLASS_NET,
+            szDeviceDescription,
+            hwndParent,
+            DICD_GENERATE_ID,
+            &devinfo_data))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiClassNameFromGuid failed", __FUNCTION__);
@@ -448,8 +466,8 @@ tap_create_interface(
 
     /* Set a device information element as the selected member of a device information set. */
     if (!SetupDiSetSelectedDevice(
-        hDevInfoList,
-        &devinfo_data))
+            hDevInfoList,
+            &devinfo_data))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiSetSelectedDevice failed", __FUNCTION__);
@@ -458,10 +476,10 @@ tap_create_interface(
 
     /* Set Plug&Play device hardware ID property. */
     if (!SetupDiSetDeviceRegistryProperty(
-        hDevInfoList,
-        &devinfo_data,
-        SPDRP_HARDWAREID,
-        (const BYTE *)szzHardwareIDs, sizeof(szzHardwareIDs)))
+            hDevInfoList,
+            &devinfo_data,
+            SPDRP_HARDWAREID,
+            (const BYTE *)szzHardwareIDs, sizeof(szzHardwareIDs)))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiSetDeviceRegistryProperty failed", __FUNCTION__);
@@ -470,9 +488,9 @@ tap_create_interface(
 
     /* Search for the driver. */
     if (!SetupDiBuildDriverInfoList(
-        hDevInfoList,
-        &devinfo_data,
-        SPDIT_CLASSDRIVER))
+            hDevInfoList,
+            &devinfo_data,
+            SPDIT_CLASSDRIVER))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiBuildDriverInfoList failed", __FUNCTION__);
@@ -480,20 +498,22 @@ tap_create_interface(
     }
     DWORDLONG dwlDriverVersion = 0;
     DWORD drvinfo_detail_data_size = sizeof(SP_DRVINFO_DETAIL_DATA) + 0x100;
-    SP_DRVINFO_DETAIL_DATA *drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA*)malloc(drvinfo_detail_data_size);
-    for (DWORD dwIndex = 0; ; dwIndex++)
+    SP_DRVINFO_DETAIL_DATA *drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA *)malloc(drvinfo_detail_data_size);
+    for (DWORD dwIndex = 0;; dwIndex++)
     {
         /* Get a driver from the list. */
         SP_DRVINFO_DATA drvinfo_data = { .cbSize = sizeof(SP_DRVINFO_DATA) };
         if (!SetupDiEnumDriverInfo(
-            hDevInfoList,
-            &devinfo_data,
-            SPDIT_CLASSDRIVER,
-            dwIndex,
-            &drvinfo_data))
+                hDevInfoList,
+                &devinfo_data,
+                SPDIT_CLASSDRIVER,
+                dwIndex,
+                &drvinfo_data))
         {
             if (GetLastError() == ERROR_NO_MORE_ITEMS)
+            {
                 break;
+            }
             else
             {
                 /* Something is wrong with this driver. Skip it. */
@@ -506,31 +526,33 @@ tap_create_interface(
         DWORD dwSize;
         drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
         if (!SetupDiGetDriverInfoDetail(
-            hDevInfoList,
-            &devinfo_data,
-            &drvinfo_data,
-            drvinfo_detail_data,
-            drvinfo_detail_data_size,
-            &dwSize))
+                hDevInfoList,
+                &devinfo_data,
+                &drvinfo_data,
+                drvinfo_detail_data,
+                drvinfo_detail_data_size,
+                &dwSize))
         {
             if (GetLastError() == ERROR_INSUFFICIENT_BUFFER)
             {
                 /* (Re)allocate buffer. */
                 if (drvinfo_detail_data)
+                {
                     free(drvinfo_detail_data);
+                }
 
                 drvinfo_detail_data_size = dwSize;
-                drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA*)malloc(drvinfo_detail_data_size);
+                drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA *)malloc(drvinfo_detail_data_size);
 
                 /* Re-get driver info details. */
                 drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
                 if (!SetupDiGetDriverInfoDetail(
-                    hDevInfoList,
-                    &devinfo_data,
-                    &drvinfo_data,
-                    drvinfo_detail_data,
-                    drvinfo_detail_data_size,
-                    &dwSize))
+                        hDevInfoList,
+                        &devinfo_data,
+                        &drvinfo_data,
+                        drvinfo_detail_data,
+                        drvinfo_detail_data_size,
+                        &dwSize))
                 {
                     /* Something is wrong with this driver. Skip it. */
                     continue;
@@ -554,9 +576,9 @@ tap_create_interface(
                 {
                     /* Matching hardware ID found. Select the driver. */
                     if (!SetupDiSetSelectedDriver(
-                        hDevInfoList,
-                        &devinfo_data,
-                        &drvinfo_data))
+                            hDevInfoList,
+                            &devinfo_data,
+                            &drvinfo_data))
                     {
                         /* Something is wrong with this driver. Skip it. */
                         msg(M_WARN | M_ERRNO, "%s: SetupDiSetSelectedDriver(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
@@ -570,13 +592,15 @@ tap_create_interface(
         }
     }
     if (drvinfo_detail_data)
+    {
         free(drvinfo_detail_data);
+    }
 
     /* Call appropriate class installer. */
     if (!SetupDiCallClassInstaller(
-        DIF_REGISTERDEVICE,
-        hDevInfoList,
-        &devinfo_data))
+            DIF_REGISTERDEVICE,
+            hDevInfoList,
+            &devinfo_data))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiCallClassInstaller(DIF_REGISTERDEVICE) failed", __FUNCTION__);
@@ -585,9 +609,9 @@ tap_create_interface(
 
     /* Register device co-installers if any. */
     if (!SetupDiCallClassInstaller(
-        DIF_REGISTER_COINSTALLERS,
-        hDevInfoList,
-        &devinfo_data))
+            DIF_REGISTER_COINSTALLERS,
+            hDevInfoList,
+            &devinfo_data))
     {
         dwResult = GetLastError();
         msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REGISTER_COINSTALLERS) failed", __FUNCTION__);
@@ -595,9 +619,9 @@ tap_create_interface(
 
     /* Install interfaces if any. */
     if (!SetupDiCallClassInstaller(
-        DIF_INSTALLINTERFACES,
-        hDevInfoList,
-        &devinfo_data))
+            DIF_INSTALLINTERFACES,
+            hDevInfoList,
+            &devinfo_data))
     {
         dwResult = GetLastError();
         msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_INSTALLINTERFACES) failed", __FUNCTION__);
@@ -605,9 +629,9 @@ tap_create_interface(
 
     /* Install the device. */
     if (!SetupDiCallClassInstaller(
-        DIF_INSTALLDEVICE,
-        hDevInfoList,
-        &devinfo_data))
+            DIF_INSTALLDEVICE,
+            hDevInfoList,
+            &devinfo_data))
     {
         dwResult = GetLastError();
         msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
@@ -637,10 +661,10 @@ cleanup_remove_device:
 
         /* Set class installer parameters for DIF_REMOVE. */
         if (SetupDiSetClassInstallParams(
-            hDevInfoList,
-            &devinfo_data,
-            &removedevice_params.ClassInstallHeader,
-            sizeof(SP_REMOVEDEVICE_PARAMS)))
+                hDevInfoList,
+                &devinfo_data,
+                &removedevice_params.ClassInstallHeader,
+                sizeof(SP_REMOVEDEVICE_PARAMS)))
         {
             /* Call appropriate class installer. */
             if (SetupDiCallClassInstaller(
@@ -652,10 +676,14 @@ cleanup_remove_device:
                 check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
             }
             else
+            {
                 msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REMOVE) failed", __FUNCTION__);
+            }
         }
         else
+        {
             msg(M_NONFATAL | M_ERRNO, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
+        }
     }
 
 cleanup_DriverInfoList:
@@ -670,15 +698,18 @@ cleanup_hDevInfoList:
 }
 
 
-DWORD tap_delete_interface(
-    _In_opt_ HWND    hwndParent,
-    _In_     LPCGUID pguidInterface,
-    _Inout_  LPBOOL  pbRebootRequired)
+DWORD
+tap_delete_interface(
+    _In_opt_ HWND hwndParent,
+    _In_ LPCGUID pguidInterface,
+    _Inout_ LPBOOL pbRebootRequired)
 {
     DWORD dwResult;
 
     if (pguidInterface == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Create a list of network devices. */
     HDEVINFO hDevInfoList = SetupDiGetClassDevsEx(
@@ -706,20 +737,20 @@ DWORD tap_delete_interface(
     }
 
     /* Iterate. */
-    for (DWORD dwIndex = 0; ; dwIndex++)
+    for (DWORD dwIndex = 0;; dwIndex++)
     {
         /* Get the device from the list. */
         SP_DEVINFO_DATA devinfo_data = { .cbSize = sizeof(SP_DEVINFO_DATA) };
         if (!SetupDiEnumDeviceInfo(
-            hDevInfoList,
-            dwIndex,
-            &devinfo_data))
+                hDevInfoList,
+                dwIndex,
+                &devinfo_data))
         {
             if (GetLastError() == ERROR_NO_MORE_ITEMS)
             {
                 LPOLESTR szInterfaceId = NULL;
                 StringFromIID((REFIID)pguidInterface, &szInterfaceId);
-                msg(M_NONFATAL, "%s: Interface %"PRIsLPOLESTR" not found", __FUNCTION__, szInterfaceId);
+                msg(M_NONFATAL, "%s: Interface %" PRIsLPOLESTR " not found", __FUNCTION__, szInterfaceId);
                 CoTaskMemFree(szInterfaceId);
                 dwResult = ERROR_FILE_NOT_FOUND;
                 goto cleanup_hDevInfoList;
@@ -735,7 +766,8 @@ DWORD tap_delete_interface(
         /* Get interface GUID. */
         GUID guidInterface;
         dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
-        if (dwResult != ERROR_SUCCESS) {
+        if (dwResult != ERROR_SUCCESS)
+        {
             /* Something is wrong with this device. Skip it. */
             continue;
         }
@@ -757,10 +789,10 @@ DWORD tap_delete_interface(
 
             /* Set class installer parameters for DIF_REMOVE. */
             if (!SetupDiSetClassInstallParams(
-                hDevInfoList,
-                &devinfo_data,
-                &removedevice_params.ClassInstallHeader,
-                sizeof(SP_REMOVEDEVICE_PARAMS)))
+                    hDevInfoList,
+                    &devinfo_data,
+                    &removedevice_params.ClassInstallHeader,
+                    sizeof(SP_REMOVEDEVICE_PARAMS)))
             {
                 dwResult = GetLastError();
                 msg(M_NONFATAL, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
@@ -769,9 +801,9 @@ DWORD tap_delete_interface(
 
             /* Call appropriate class installer. */
             if (!SetupDiCallClassInstaller(
-                DIF_REMOVE,
-                hDevInfoList,
-                &devinfo_data))
+                    DIF_REMOVE,
+                    hDevInfoList,
+                    &devinfo_data))
             {
                 dwResult = GetLastError();
                 msg(M_NONFATAL, "%s: SetupDiCallClassInstaller(DIF_REMOVE) failed", __FUNCTION__);
@@ -799,7 +831,9 @@ tap_set_interface_name(
     DWORD dwResult;
 
     if (pguidInterface == NULL || szName == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Get the device class GUID as string. */
     LPOLESTR szDevClassNetId = NULL;
@@ -828,7 +862,7 @@ tap_set_interface_name(
     if (dwResult != ERROR_SUCCESS)
     {
         SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%"PRIsLPTSTR"\") failed", __FUNCTION__, szRegKey);
+        msg(M_NONFATAL | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
         goto cleanup_szInterfaceId;
     }
 
@@ -867,13 +901,15 @@ cleanup_szInterfaceId:
 
 DWORD
 tap_list_interfaces(
-    _In_opt_ HWND                        hwndParent,
-    _Out_    struct tap_interface_node **ppInterface)
+    _In_opt_ HWND hwndParent,
+    _Out_ struct tap_interface_node **ppInterface)
 {
     DWORD dwResult;
 
     if (ppInterface == NULL)
+    {
         return ERROR_BAD_ARGUMENTS;
+    }
 
     /* Create a list of network devices. */
     HDEVINFO hDevInfoList = SetupDiGetClassDevsEx(
@@ -907,17 +943,19 @@ tap_list_interfaces(
     /* Iterate. */
     *ppInterface = NULL;
     struct tap_interface_node *pInterfaceTail = NULL;
-    for (DWORD dwIndex = 0; ; dwIndex++)
+    for (DWORD dwIndex = 0;; dwIndex++)
     {
         /* Get the device from the list. */
         SP_DEVINFO_DATA devinfo_data = { .cbSize = sizeof(SP_DEVINFO_DATA) };
         if (!SetupDiEnumDeviceInfo(
-            hDevInfoList,
-            dwIndex,
-            &devinfo_data))
+                hDevInfoList,
+                dwIndex,
+                &devinfo_data))
         {
             if (GetLastError() == ERROR_NO_MORE_ITEMS)
+            {
                 break;
+            }
             else
             {
                 /* Something is wrong with this device. Skip it. */
@@ -929,7 +967,8 @@ tap_list_interfaces(
         /* Get interface GUID. */
         GUID guidInterface;
         dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
-        if (dwResult != ERROR_SUCCESS) {
+        if (dwResult != ERROR_SUCCESS)
+        {
             /* Something is wrong with this device. Skip it. */
             continue;
         }
@@ -948,7 +987,9 @@ tap_list_interfaces(
             &dwDataType,
             (LPVOID)&szzDeviceHardwareIDs);
         if (dwResult != ERROR_SUCCESS)
+        {
             goto cleanup_szInterfaceId;
+        }
 
         /* Render registry key path. */
         TCHAR szRegKey[INTERFACE_REGKEY_PATH_MAX];
@@ -969,7 +1010,7 @@ tap_list_interfaces(
         if (dwResult != ERROR_SUCCESS)
         {
             SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%"PRIsLPTSTR"\") failed", __FUNCTION__, szRegKey);
+            msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szRegKey);
             goto cleanup_szzDeviceHardwareIDs;
         }
 
@@ -982,14 +1023,14 @@ tap_list_interfaces(
         if (dwResult != ERROR_SUCCESS)
         {
             SetLastError(dwResult);
-            msg(M_WARN | M_ERRNO, "%s: Cannot determine %"PRIsLPOLESTR" interface name", __FUNCTION__, szInterfaceId);
+            msg(M_WARN | M_ERRNO, "%s: Cannot determine %" PRIsLPOLESTR " interface name", __FUNCTION__, szInterfaceId);
             goto cleanup_hKey;
         }
 
         /* Append to the list. */
         size_t hwid_size = (_tcszlen(szzDeviceHardwareIDs) + 1) * sizeof(TCHAR);
         size_t name_size = (_tcslen(szName) + 1) * sizeof(TCHAR);
-        struct tap_interface_node *node = (struct tap_interface_node*)malloc(sizeof(struct tap_interface_node) + hwid_size + name_size);
+        struct tap_interface_node *node = (struct tap_interface_node *)malloc(sizeof(struct tap_interface_node) + hwid_size + name_size);
         memcpy(&node->guid, &guidInterface, sizeof(GUID));
         node->szzHardwareIDs = (LPTSTR)(node + 1);
         memcpy(node->szzHardwareIDs, szzDeviceHardwareIDs, hwid_size);
@@ -1002,14 +1043,16 @@ tap_list_interfaces(
             pInterfaceTail = node;
         }
         else
+        {
             *ppInterface = pInterfaceTail = node;
+        }
 
         free(szName);
-    cleanup_hKey:
+cleanup_hKey:
         RegCloseKey(hKey);
-    cleanup_szzDeviceHardwareIDs:
+cleanup_szzDeviceHardwareIDs:
         free(szzDeviceHardwareIDs);
-    cleanup_szInterfaceId:
+cleanup_szInterfaceId:
         CoTaskMemFree(szInterfaceId);
     }
 
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 0c42c44f..39dc28b0 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -47,10 +47,10 @@
  **/
 DWORD
 tap_create_interface(
-    _In_opt_ HWND    hwndParent,
+    _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
-    _Inout_  LPBOOL  pbRebootRequired,
-    _Out_    LPGUID  pguidInterface);
+    _Inout_ LPBOOL pbRebootRequired,
+    _Out_ LPGUID pguidInterface);
 
 
 /**
@@ -73,9 +73,9 @@ tap_create_interface(
  **/
 DWORD
 tap_delete_interface(
-    _In_opt_ HWND    hwndParent,
-    _In_     LPCGUID pguidInterface,
-    _Inout_  LPBOOL  pbRebootRequired);
+    _In_opt_ HWND hwndParent,
+    _In_ LPCGUID pguidInterface,
+    _Inout_ LPBOOL pbRebootRequired);
 
 
 /**
@@ -98,7 +98,7 @@ tap_set_interface_name(
  */
 struct tap_interface_node
 {
-    GUID   guid;           /** Interface GUID */
+    GUID guid;             /** Interface GUID */
     LPTSTR szzHardwareIDs; /** Device hardware ID(s) */
     LPTSTR szName;         /** Interface name */
 
@@ -116,15 +116,15 @@ struct tap_interface_node
  *                      hwndParent to NULL.
  *
  * @param ppInterfaceList  A pointer to the list to receive pointer to the first interface in
- *                      the list. After the list is no longer required, free it using 
+ *                      the list. After the list is no longer required, free it using
  *                      tap_free_interface_list().
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
 DWORD
 tap_list_interfaces(
-    _In_opt_ HWND                        hwndParent,
-    _Out_    struct tap_interface_node **ppInterfaceList);
+    _In_opt_ HWND hwndParent,
+    _Out_ struct tap_interface_node **ppInterfaceList);
 
 
 /**
@@ -136,4 +136,4 @@ void
 tap_free_interface_list(
     _In_ struct tap_interface_node *pInterfaceList);
 
-#endif
+#endif /* ifndef TAP_H */
-- 
2.19.0.windows.1


