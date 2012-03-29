From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu, 29 Mar 2012 11:16:42 +0200
Message-Id: <1333012602-5419-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
Subject: [Openvpn-devel] [PATCH 4/4] cleanup: avoid using ~0 - windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Use the following constants:
- METRIC_NOT_USED
- TUN_ADAPTER_INDEX_INVALID

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/route.c |   30 +++++++++++++++++-------------
 src/openvpn/tun.c   |   46 +++++++++++++++++++++++-----------------------
 src/openvpn/tun.h   |    2 ++
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f681a58..e97cbed 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -45,6 +45,10 @@
 
 #include "memdbg.h"
 
+#ifdef WIN32
+#define METRIC_NOT_USED ((DWORD)-1)
+#endif
+
 static void delete_route (struct route *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es);
 
 static void get_bypass_addresses (struct route_bypass *rb, const unsigned int flags);
@@ -1342,7 +1346,7 @@ add_route (struct route *r,
 
 #elif defined (WIN32)
   {
-    DWORD ai = ~0;
+    DWORD ai = TUN_ADAPTER_INDEX_INVALID;
     argv_printf (&argv, "%s%sc ADD %s MASK %s %s",
 		 get_win_sys_path(),
 		 WIN_ROUTE_PATH_SUFFIX,
@@ -2098,7 +2102,7 @@ static const MIB_IPFORWARDROW *
 get_default_gateway_row (const MIB_IPFORWARDTABLE *routes)
 {
   struct gc_arena gc = gc_new ();
-  DWORD lowest_metric = ~0;
+  DWORD lowest_metric = METRIC_NOT_USED;
   const MIB_IPFORWARDROW *ret = NULL;
   int i;
   int best = -1;
@@ -2155,7 +2159,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 	{
 	  rgi->flags |= RGI_ADDR_DEFINED;
 	  a_index = adapter_index_of_ip (adapters, rgi->gateway.addr, NULL, &rgi->gateway.netmask);
-	  if (a_index != ~0)
+	  if (a_index != TUN_ADAPTER_INDEX_INVALID)
 	    {
 	      rgi->adapter_index = a_index;
 	      rgi->flags |= (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);
@@ -2176,7 +2180,7 @@ static DWORD
 windows_route_find_if_index (const struct route *r, const struct tuntap *tt)
 {
   struct gc_arena gc = gc_new ();
-  DWORD ret = ~0;
+  DWORD ret = TUN_ADAPTER_INDEX_INVALID;
   int count = 0;
   const IP_ADAPTER_INFO *adapters = get_adapter_info_list (&gc);
   const IP_ADAPTER_INFO *tun_adapter = get_tun_adapter (tt, adapters);
@@ -2198,14 +2202,14 @@ windows_route_find_if_index (const struct route *r, const struct tuntap *tt)
     {
       msg (M_WARN, "Warning: route gateway is not reachable on any active network adapters: %s",
 	   print_in_addr_t (r->gateway, 0, &gc));
-      ret = ~0;
+      ret = TUN_ADAPTER_INDEX_INVALID;
     }
   else if (count > 1)
     {
       msg (M_WARN, "Warning: route gateway is ambiguous: %s (%d matches)",
 	   print_in_addr_t (r->gateway, 0, &gc),
 	   count);
-      ret = ~0;
+      ret = TUN_ADAPTER_INDEX_INVALID;
     }
 
   dmsg (D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d",
@@ -2223,9 +2227,9 @@ add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_i
   struct gc_arena gc = gc_new ();
   bool ret = false;
   DWORD status;
-  const DWORD if_index = (adapter_index == ~0) ? windows_route_find_if_index (r, tt) : adapter_index;
+  const DWORD if_index = (adapter_index == TUN_ADAPTER_INDEX_INVALID) ? windows_route_find_if_index (r, tt) : adapter_index;
 
-  if (if_index != ~0)
+  if (if_index != TUN_ADAPTER_INDEX_INVALID)
     {
       MIB_IPFORWARDROW fr;
       CLEAR (fr);
@@ -2239,10 +2243,10 @@ add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_i
       fr.dwForwardAge = 0;
       fr.dwForwardNextHopAS = 0;
       fr.dwForwardMetric1 = (r->flags & RT_METRIC_DEFINED) ? r->metric : 1;
-      fr.dwForwardMetric2 = ~0;
-      fr.dwForwardMetric3 = ~0;
-      fr.dwForwardMetric4 = ~0;
-      fr.dwForwardMetric5 = ~0;
+      fr.dwForwardMetric2 = METRIC_NOT_USED;
+      fr.dwForwardMetric3 = METRIC_NOT_USED;
+      fr.dwForwardMetric4 = METRIC_NOT_USED;
+      fr.dwForwardMetric5 = METRIC_NOT_USED;
 
       if ((r->network & r->netmask) != r->network)
 	msg (M_WARN, "Warning: address %s is not a network address in relation to netmask %s",
@@ -2299,7 +2303,7 @@ del_route_ipapi (const struct route *r, const struct tuntap *tt)
   DWORD status;
   const DWORD if_index = windows_route_find_if_index (r, tt);
 
-  if (if_index != ~0)
+  if (if_index != TUN_ADAPTER_INDEX_INVALID)
     {
       MIB_IPFORWARDROW fr;
       CLEAR (fr);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 21778a2..b99071c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -579,7 +579,7 @@ init_tun_post (struct tuntap *tt,
   overlapped_io_init (&tt->writes, frame, TRUE, true);
   tt->rw_handle.read = tt->reads.overlapped.hEvent;
   tt->rw_handle.write = tt->writes.overlapped.hEvent;
-  tt->adapter_index = ~0;
+  tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
 #endif
 }
 
@@ -3250,7 +3250,7 @@ get_per_adapter_info (const DWORD index, struct gc_arena *gc)
   IP_PER_ADAPTER_INFO *pi = NULL;
   DWORD status;
 
-  if (index != ~0)
+  if (index != TUN_ADAPTER_INDEX_INVALID)
     {
       if ((status = GetPerAdapterInfo (index, NULL, &size)) != ERROR_BUFFER_OVERFLOW)
 	{
@@ -3327,7 +3327,7 @@ get_interface_info (DWORD index, struct gc_arena *gc)
 const IP_ADAPTER_INFO *
 get_adapter (const IP_ADAPTER_INFO *ai, DWORD index)
 {
-  if (ai && index != (DWORD)~0)
+  if (ai && index != TUN_ADAPTER_INDEX_INVALID)
     {
       const IP_ADAPTER_INFO *a;
 
@@ -3504,7 +3504,7 @@ adapter_index_of_ip (const IP_ADAPTER_INFO *list,
 		     in_addr_t *netmask)
 {
   struct gc_arena gc = gc_new ();
-  DWORD ret = ~0;
+  DWORD ret = TUN_ADAPTER_INDEX_INVALID;
   in_addr_t highest_netmask = 0;
   bool first = true;
 
@@ -3540,7 +3540,7 @@ adapter_index_of_ip (const IP_ADAPTER_INFO *list,
        (int)ret,
        count ? *count : -1);
 
-  if (ret == ~0 && count)
+  if (ret == TUN_ADAPTER_INDEX_INVALID && count)
     *count = 0;
 
   if (netmask)
@@ -3564,7 +3564,7 @@ dhcp_status (DWORD index)
 {
   struct gc_arena gc = gc_new ();
   int ret = DHCP_STATUS_UNDEF;
-  if (index != ~0)
+  if (index != TUN_ADAPTER_INDEX_INVALID)
     {
       const IP_ADAPTER_INFO *ai = get_adapter_info (index, &gc);
 
@@ -3626,15 +3626,15 @@ delete_temp_addresses (DWORD index)
 static DWORD
 get_adapter_index_method_1 (const char *guid)
 {
-  struct gc_arena gc = gc_new ();
-  ULONG index = ~0;
-  DWORD status;
+  DWORD index;
+  ULONG aindex;
   wchar_t wbuf[256];
   _snwprintf (wbuf, SIZE (wbuf), L"\\DEVICE\\TCPIP_%S", guid);
   wbuf [SIZE(wbuf) - 1] = 0;
-  if ((status = GetAdapterIndex (wbuf, &index)) != NO_ERROR)
-    index = ~0;
-  gc_free (&gc);
+  if (GetAdapterIndex (wbuf, &aindex) != NO_ERROR)
+    index = TUN_ADAPTER_INDEX_INVALID;
+  else
+    index = (DWORD)aindex;
   return index;
 }
 
@@ -3642,7 +3642,7 @@ static DWORD
 get_adapter_index_method_2 (const char *guid)
 {
   struct gc_arena gc = gc_new ();
-  DWORD index = ~0;
+  DWORD index = TUN_ADAPTER_INDEX_INVALID;
 
   const IP_ADAPTER_INFO *list = get_adapter_info_list (&gc);
 
@@ -3665,9 +3665,9 @@ get_adapter_index (const char *guid)
 {
   DWORD index;
   index = get_adapter_index_method_1 (guid);
-  if (index == ~0)
+  if (index == TUN_ADAPTER_INDEX_INVALID)
     index = get_adapter_index_method_2 (guid);
-  if (index == ~0)
+  if (index == TUN_ADAPTER_INDEX_INVALID)
     msg (M_INFO, "NOTE: could not get adapter index for %s", guid);
   return index;
 }
@@ -3678,18 +3678,18 @@ get_adapter_index_flexible (const char *name) /* actual name or GUID */
   struct gc_arena gc = gc_new ();
   DWORD index;
   index = get_adapter_index_method_1 (name);
-  if (index == ~0)
+  if (index == TUN_ADAPTER_INDEX_INVALID)
     index = get_adapter_index_method_2 (name);
-  if (index == ~0)
+  if (index == TUN_ADAPTER_INDEX_INVALID)
     {
       const struct tap_reg *tap_reg = get_tap_reg (&gc);
       const struct panel_reg *panel_reg = get_panel_reg (&gc);
       const char *guid = name_to_guid (name, tap_reg, panel_reg);
       index = get_adapter_index_method_1 (guid);
-      if (index == ~0)
+      if (index == TUN_ADAPTER_INDEX_INVALID)
 	index = get_adapter_index_method_2 (guid);
     }
-  if (index == ~0)
+  if (index == TUN_ADAPTER_INDEX_INVALID)
     msg (M_INFO, "NOTE: could not get adapter index for name/GUID '%s'", name);
   gc_free (&gc);
   return index;
@@ -3920,7 +3920,7 @@ dhcp_release_by_adapter_index(const DWORD adapter_index)
 static bool
 dhcp_release (const struct tuntap *tt)
 {
-  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != ~0)
+  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != TUN_ADAPTER_INDEX_INVALID)
     return dhcp_release_by_adapter_index (tt->adapter_index);
   else
     return false;
@@ -3953,7 +3953,7 @@ dhcp_renew_by_adapter_index (const DWORD adapter_index)
 static bool
 dhcp_renew (const struct tuntap *tt)
 {
-  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != ~0)
+  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != TUN_ADAPTER_INDEX_INVALID)
     return dhcp_renew_by_adapter_index (tt->adapter_index);
   else
     return false;
@@ -4838,7 +4838,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     const DWORD index = tt->adapter_index;
     
     /* flush arp cache */
-    if (index != (DWORD)~0)
+    if (index != TUN_ADAPTER_INDEX_INVALID)
       {
 	DWORD status;
 
@@ -4880,7 +4880,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 	const char *error_suffix = "I am having trouble using the Windows 'IP helper API' to automatically set the IP address -- consider using other --ip-win32 methods (not 'ipapi')";
 
 	/* couldn't get adapter index */
-	if (index == (DWORD)~0)
+	if (index == TUN_ADAPTER_INDEX_INVALID)
 	  {
 	    msg (M_FATAL, "ERROR: unable to get adapter index for interface %s -- %s",
 		 device_guid,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 749bee5..9bd990f 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -40,6 +40,8 @@
 
 #ifdef WIN32
 
+#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
+
 /* time constants for --ip-win32 adaptive */
 #define IPW32_SET_ADAPTIVE_DELAY_WINDOW 300
 #define IPW32_SET_ADAPTIVE_TRY_NETSH    20
-- 
1.7.3.4


