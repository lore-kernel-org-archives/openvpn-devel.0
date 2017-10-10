From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:22 +0200
Message-Id: <20171010231130.6832-5-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 05/13] Function prototypes are declared as
 "typedef <return type> (<calling convention> *type_name)(<arguments>)" in
 MSVC.
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

From: Simon Rozman <simon@...2293...>

Note: NETIOAPI_API is defined as:
#define NETIOAPI_API NETIO_STATUS NETIOAPI_API_
#define NETIOAPI_API_ WINAPI

I am not sure whether interactive.c will compile using mingw with this patch. If not:
1. We can introduce some
   #ifdef _MSC_VER
   #else
   #endif
2. Since NTDDI_VERSION=NTDDI_VISTA, most of the dynamic API loading by GetProcAddress() could be simplified to statically linked API calls, avoiding function prototype declarations altogether. I suggest we do this anyway to clean-up the code in the future.
---
 src/openvpnserv/interactive.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 7ff45b1..8d94197 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -550,7 +550,7 @@ InterfaceLuid(const char *iface_name, PNET_LUID luid)
     LPWSTR wide_name;
     int n;
 
-    typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
+    typedef NETIO_STATUS (WINAPI *ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
     static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid = NULL;
     if (!ConvertInterfaceAliasToLuid)
     {
@@ -585,7 +585,7 @@ CmpAddress(LPVOID item, LPVOID address)
 static DWORD
 DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)
 {
-    typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
+    typedef NETIO_STATUS (NETIOAPI_API_ *DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
     static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry = NULL;
 
     if (!DeleteUnicastIpAddressEntry)
@@ -613,8 +613,8 @@ HandleAddressMessage(address_message_t *msg, undo_lists_t *lists)
     PMIB_UNICASTIPADDRESS_ROW addr_row;
     BOOL add = msg->header.type == msg_add_address;
 
-    typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
-    typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
+    typedef NETIO_STATUS (NETIOAPI_API_ *CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
+    typedef NETIO_STATUS (NETIOAPI_API_ *InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
     static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry = NULL;
     static InitializeUnicastIpAddressEntryFn InitializeUnicastIpAddressEntry = NULL;
 
@@ -707,7 +707,7 @@ CmpRoute(LPVOID item, LPVOID route)
 static DWORD
 DeleteRoute(PMIB_IPFORWARD_ROW2 fwd_row)
 {
-    typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
+    typedef NETIO_STATUS (NETIOAPI_API_ *DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
     static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
 
     if (!DeleteIpForwardEntry2)
@@ -735,7 +735,7 @@ HandleRouteMessage(route_message_t *msg, undo_lists_t *lists)
     PMIB_IPFORWARD_ROW2 fwd_row;
     BOOL add = msg->header.type == msg_add_route;
 
-    typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
+    typedef NETIO_STATUS (NETIOAPI_API_ *CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
     static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
 
     if (!CreateIpForwardEntry2)
@@ -821,7 +821,7 @@ out:
 static DWORD
 HandleFlushNeighborsMessage(flush_neighbors_message_t *msg)
 {
-    typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
+    typedef NETIO_STATUS (NETIOAPI_API_ *FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
     static FlushIpNetTable2Fn flush_fn = NULL;
 
     if (msg->family == AF_INET)
-- 
2.9.0.windows.1


