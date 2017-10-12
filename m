From: Simon Rozman <simon@...2293...>
Date: Thu, 12 Oct 2017 10:07:20 +0200
Message-Id: <20171012080720.7764-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Simplify iphlpapi.dll API calls
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

Dynamically locating API function addresses at run-time using
GetProcAddress() was a leftover from the early days of the interactive
service development. It was required before `NTDDI_VERSION` was raised
from Windows XP to Windows Vista.

After NTDDI_VERSION API level was raised to NTDDI_VISTA, the direct
calling of Vista introduced API functions is possible and much
simpler.

This patch simplifies the code while in the same time it removes
controversial function type definitions that caused interactive service not to compile on MSVC.
---
 src/openvpnserv/interactive.c | 123 +-----------------------------------------
 1 file changed, 1 insertion(+), 122 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a060a06..bb8c5f6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -549,23 +549,6 @@ InterfaceLuid(const char *iface_name, PNET_LUID luid)
     LPWSTR wide_name;
     int n;
 
-    typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
-    static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid = NULL;
-    if (!ConvertInterfaceAliasToLuid)
-    {
-        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
-        if (iphlpapi == NULL)
-        {
-            return GetLastError();
-        }
-
-        ConvertInterfaceAliasToLuid = (ConvertInterfaceAliasToLuidFn) GetProcAddress(iphlpapi, "ConvertInterfaceAliasToLuid");
-        if (!ConvertInterfaceAliasToLuid)
-        {
-            return GetLastError();
-        }
-    }
-
     n = MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, NULL, 0);
     wide_name = malloc(n * sizeof(WCHAR));
     MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, wide_name, n);
@@ -584,24 +567,6 @@ CmpAddress(LPVOID item, LPVOID address)
 static DWORD
 DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)
 {
-    typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
-    static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry = NULL;
-
-    if (!DeleteUnicastIpAddressEntry)
-    {
-        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
-        if (iphlpapi == NULL)
-        {
-            return GetLastError();
-        }
-
-        DeleteUnicastIpAddressEntry = (DeleteUnicastIpAddressEntryFn) GetProcAddress(iphlpapi, "DeleteUnicastIpAddressEntry");
-        if (!DeleteUnicastIpAddressEntry)
-        {
-            return GetLastError();
-        }
-    }
-
     return DeleteUnicastIpAddressEntry(addr_row);
 }
 
@@ -612,32 +577,6 @@ HandleAddressMessage(address_message_t *msg, undo_lists_t *lists)
     PMIB_UNICASTIPADDRESS_ROW addr_row;
     BOOL add = msg->header.type == msg_add_address;
 
-    typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
-    typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
-    static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry = NULL;
-    static InitializeUnicastIpAddressEntryFn InitializeUnicastIpAddressEntry = NULL;
-
-    if (!CreateUnicastIpAddressEntry || !InitializeUnicastIpAddressEntry)
-    {
-        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
-        if (iphlpapi == NULL)
-        {
-            return GetLastError();
-        }
-
-        CreateUnicastIpAddressEntry = (CreateUnicastIpAddressEntryFn) GetProcAddress(iphlpapi, "CreateUnicastIpAddressEntry");
-        if (!CreateUnicastIpAddressEntry)
-        {
-            return GetLastError();
-        }
-
-        InitializeUnicastIpAddressEntry = (InitializeUnicastIpAddressEntryFn) GetProcAddress(iphlpapi, "InitializeUnicastIpAddressEntry");
-        if (!InitializeUnicastIpAddressEntry)
-        {
-            return GetLastError();
-        }
-    }
-
     addr_row = malloc(sizeof(*addr_row));
     if (addr_row == NULL)
     {
@@ -706,24 +645,6 @@ CmpRoute(LPVOID item, LPVOID route)
 static DWORD
 DeleteRoute(PMIB_IPFORWARD_ROW2 fwd_row)
 {
-    typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
-    static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
-
-    if (!DeleteIpForwardEntry2)
-    {
-        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
-        if (iphlpapi == NULL)
-        {
-            return GetLastError();
-        }
-
-        DeleteIpForwardEntry2 = (DeleteIpForwardEntry2Fn) GetProcAddress(iphlpapi, "DeleteIpForwardEntry2");
-        if (!DeleteIpForwardEntry2)
-        {
-            return GetLastError();
-        }
-    }
-
     return DeleteIpForwardEntry2(fwd_row);
 }
 
@@ -734,24 +655,6 @@ HandleRouteMessage(route_message_t *msg, undo_lists_t *lists)
     PMIB_IPFORWARD_ROW2 fwd_row;
     BOOL add = msg->header.type == msg_add_route;
 
-    typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
-    static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
-
-    if (!CreateIpForwardEntry2)
-    {
-        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
-        if (iphlpapi == NULL)
-        {
-            return GetLastError();
-        }
-
-        CreateIpForwardEntry2 = (CreateIpForwardEntry2Fn) GetProcAddress(iphlpapi, "CreateIpForwardEntry2");
-        if (!CreateIpForwardEntry2)
-        {
-            return GetLastError();
-        }
-    }
-
     fwd_row = malloc(sizeof(*fwd_row));
     if (fwd_row == NULL)
     {
@@ -820,36 +723,12 @@ out:
 static DWORD
 HandleFlushNeighborsMessage(flush_neighbors_message_t *msg)
 {
-    typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
-    static FlushIpNetTable2Fn flush_fn = NULL;
-
     if (msg->family == AF_INET)
     {
         return FlushIpNetTable(msg->iface.index);
     }
 
-    if (!flush_fn)
-    {
-        HMODULE iphlpapi = GetModuleHandle(TEXT("iphlpapi.dll"));
-        if (iphlpapi == NULL)
-        {
-            return GetLastError();
-        }
-
-        flush_fn = (FlushIpNetTable2Fn) GetProcAddress(iphlpapi, "FlushIpNetTable2");
-        if (!flush_fn)
-        {
-            if (GetLastError() == ERROR_PROC_NOT_FOUND)
-            {
-                return WSAEPFNOSUPPORT;
-            }
-            else
-            {
-                return GetLastError();
-            }
-        }
-    }
-    return flush_fn(msg->family, msg->iface.index);
+    return FlushIpNetTable2(msg->family, msg->iface.index);
 }
 
 static void
-- 
2.9.0.windows.1


