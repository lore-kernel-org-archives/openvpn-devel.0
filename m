From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 28 Mar 2012 20:44:18 +0200
Message-Id: <1332960258-25371-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <20120328171611.GH1359@...1296...>
References: <20120328171611.GH1359@...1296...>
Subject: [Openvpn-devel] [PATCH] Avoid using ~0
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

To avoid casting use two constants:
1. IPV4_NETMASK_HOST
2. dwMINUS_ONE

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/basic.h  |    6 ++++++
 src/openvpn/mroute.c |    2 +-
 src/openvpn/pf.c     |    2 +-
 src/openvpn/route.c  |   44 ++++++++++++++++++++++----------------------
 src/openvpn/route.h  |    2 +-
 src/openvpn/tun.c    |   42 +++++++++++++++++++++---------------------
 6 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 88539e2..561c513 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -46,4 +46,10 @@
 /* clear an object */
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
 
+#define IPV4_NETMASK_HOST 0xffffffffU
+
+#ifdef WIN32
+#define dwMINUS_ONE ((DWORD)-1)
+#endif
+
 #endif
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 5b53571..aecb702 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -342,7 +342,7 @@ mroute_addr_mask_host_bits (struct mroute_addr *ma)
 	  if ( bits_to_clear >= 8 )
 	    { ma->addr[byte--] = 0; bits_to_clear -= 8; }
 	  else
-	    { ma->addr[byte--] &= (~0 << bits_to_clear); bits_to_clear = 0; }
+	    { ma->addr[byte--] &= (IPV4_NETMASK_HOST << bits_to_clear); bits_to_clear = 0; }
         }
       ASSERT( bits_to_clear == 0 );
     }
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 7ed1e70..3c46801 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -125,7 +125,7 @@ add_subnet (const char *line, const char *prefix, const int line_num, struct pf_
     {
       /* match special "unknown" tag for addresses unrecognized by mroute */
       network.s_addr = htonl(0);
-      netmask = ~0;
+      netmask = IPV4_NETMASK_HOST;
     }
 
   {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bf7af63..05ea57f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -268,7 +268,7 @@ init_route (struct route *r,
 	    const struct route_option *ro,
 	    const struct route_list *rl)
 {
-  const in_addr_t default_netmask = ~0;
+  const in_addr_t default_netmask = IPV4_NETMASK_HOST;
   bool status;
 
   CLEAR (*r);
@@ -797,7 +797,7 @@ add_bypass_routes (struct route_bypass *rb,
     {
       if (rb->bypass[i])
 	add_route3 (rb->bypass[i],
-		    ~0,
+		    IPV4_NETMASK_HOST,
 		    gateway,
 		    tt,
 		    flags | ROUTE_REF_GW,
@@ -819,7 +819,7 @@ del_bypass_routes (struct route_bypass *rb,
     {
       if (rb->bypass[i])
 	del_route3 (rb->bypass[i],
-		    ~0,
+		    IPV4_NETMASK_HOST,
 		    gateway,
 		    tt,
 		    flags | ROUTE_REF_GW,
@@ -870,7 +870,7 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 	       * adding this special /32 route */
 	      if (rl->spec.remote_host != IPV4_INVALID_ADDR) {
 		add_route3 (rl->spec.remote_host,
-			    ~0,
+			    IPV4_NETMASK_HOST,
 			    rl->rgi.gateway.addr,
 			    tt,
 			    flags | ROUTE_REF_GW,
@@ -944,7 +944,7 @@ undo_redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *
       if (rl->iflags & RL_DID_LOCAL)
 	{
 	  del_route3 (rl->spec.remote_host,
-		      ~0,
+		      IPV4_NETMASK_HOST,
 		      rl->rgi.gateway.addr,
 		      tt,
 		      flags | ROUTE_REF_GW,
@@ -1342,7 +1342,7 @@ add_route (struct route *r,
 
 #elif defined (WIN32)
   {
-    DWORD ai = ~0;
+    DWORD ai = dwMINUS_ONE;
     argv_printf (&argv, "%s%sc ADD %s MASK %s %s",
 		 get_win_sys_path(),
 		 WIN_ROUTE_PATH_SUFFIX,
@@ -1367,7 +1367,7 @@ add_route (struct route *r,
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
       {
 	netcmd_semaphore_lock ();
-	status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add command failed");
+	status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add command f(DWORD)ailed");
 	netcmd_semaphore_release ();
       }
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
@@ -1530,7 +1530,7 @@ print_in6_addr_netbits_only( struct in6_addr network_copy, int netbits,
       if ( bits_to_clear >= 8 )
 	{ network_copy.s6_addr[byte--] = 0; bits_to_clear -= 8; }
       else
-	{ network_copy.s6_addr[byte--] &= (~0 << bits_to_clear); bits_to_clear = 0; }
+	{ network_copy.s6_addr[byte--] &= (IPV4_NETMASK_HOST << bits_to_clear); bits_to_clear = 0; }
     }
 
   return print_in6_addr( network_copy, 0, gc);
@@ -2098,7 +2098,7 @@ static const MIB_IPFORWARDROW *
 get_default_gateway_row (const MIB_IPFORWARDTABLE *routes)
 {
   struct gc_arena gc = gc_new ();
-  DWORD lowest_metric = ~0;
+  DWORD lowest_metric = dwMINUS_ONE;
   const MIB_IPFORWARDROW *ret = NULL;
   int i;
   int best = -1;
@@ -2155,7 +2155,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 	{
 	  rgi->flags |= RGI_ADDR_DEFINED;
 	  a_index = adapter_index_of_ip (adapters, rgi->gateway.addr, NULL, &rgi->gateway.netmask);
-	  if (a_index != ~0)
+	  if (a_index != dwMINUS_ONE)
 	    {
 	      rgi->adapter_index = a_index;
 	      rgi->flags |= (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);
@@ -2176,7 +2176,7 @@ static DWORD
 windows_route_find_if_index (const struct route *r, const struct tuntap *tt)
 {
   struct gc_arena gc = gc_new ();
-  DWORD ret = ~0;
+  DWORD ret = dwMINUS_ONE;
   int count = 0;
   const IP_ADAPTER_INFO *adapters = get_adapter_info_list (&gc);
   const IP_ADAPTER_INFO *tun_adapter = get_tun_adapter (tt, adapters);
@@ -2198,14 +2198,14 @@ windows_route_find_if_index (const struct route *r, const struct tuntap *tt)
     {
       msg (M_WARN, "Warning: route gateway is not reachable on any active network adapters: %s",
 	   print_in_addr_t (r->gateway, 0, &gc));
-      ret = ~0;
+      ret = dwMINUS_ONE;
     }
   else if (count > 1)
     {
       msg (M_WARN, "Warning: route gateway is ambiguous: %s (%d matches)",
 	   print_in_addr_t (r->gateway, 0, &gc),
 	   count);
-      ret = ~0;
+      ret = dwMINUS_ONE;
     }
 
   dmsg (D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d",
@@ -2223,9 +2223,9 @@ add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_i
   struct gc_arena gc = gc_new ();
   bool ret = false;
   DWORD status;
-  const DWORD if_index = (adapter_index == ~0) ? windows_route_find_if_index (r, tt) : adapter_index;
+  const DWORD if_index = (adapter_index == dwMINUS_ONE) ? windows_route_find_if_index (r, tt) : adapter_index;
 
-  if (if_index != ~0)
+  if (if_index != dwMINUS_ONE)
     {
       MIB_IPFORWARDROW fr;
       CLEAR (fr);
@@ -2239,10 +2239,10 @@ add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_i
       fr.dwForwardAge = 0;
       fr.dwForwardNextHopAS = 0;
       fr.dwForwardMetric1 = (r->flags & RT_METRIC_DEFINED) ? r->metric : 1;
-      fr.dwForwardMetric2 = ~0;
-      fr.dwForwardMetric3 = ~0;
-      fr.dwForwardMetric4 = ~0;
-      fr.dwForwardMetric5 = ~0;
+      fr.dwForwardMetric2 = dwMINUS_ONE;
+      fr.dwForwardMetric3 = dwMINUS_ONE;
+      fr.dwForwardMetric4 = dwMINUS_ONE;
+      fr.dwForwardMetric5 = dwMINUS_ONE;
 
       if ((r->network & r->netmask) != r->network)
 	msg (M_WARN, "Warning: address %s is not a network address in relation to netmask %s",
@@ -2299,7 +2299,7 @@ del_route_ipapi (const struct route *r, const struct tuntap *tt)
   DWORD status;
   const DWORD if_index = windows_route_find_if_index (r, tt);
 
-  if (if_index != ~0)
+  if (if_index != dwMINUS_ONE)
     {
       MIB_IPFORWARDROW fr;
       CLEAR (fr);
@@ -2386,7 +2386,7 @@ get_default_gateway (struct route_gateway_info *rgi)
       {
 	char line[256];
 	int count = 0;
-	unsigned int lowest_metric = ~0;
+	unsigned int lowest_metric = (unsigned int)-1;
 	in_addr_t best_gw = 0;
 	bool found = false;
 	while (fgets (line, sizeof (line), fp) != NULL)
@@ -3125,7 +3125,7 @@ netmask_to_netbits (const in_addr_t network, const in_addr_t netmask, int *netbi
 static void
 add_host_route_if_nonlocal (struct route_bypass *rb, const in_addr_t addr)
 {
-  if (test_local_addr(addr, NULL) == TLA_NONLOCAL && addr != 0 && addr != ~0)
+  if (test_local_addr(addr, NULL) == TLA_NONLOCAL && addr != 0 && addr != IPV4_NETMASK_HOST)
     add_bypass_address (rb, addr);
 }
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 25ecaee..c0f5f57 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -317,7 +317,7 @@ netbits_to_netmask (const int netbits)
   const int addrlen = sizeof (in_addr_t) * 8;
   in_addr_t mask = 0;
   if (netbits > 0 && netbits <= addrlen)
-    mask = ~0 << (addrlen-netbits);
+    mask = IPV4_NETMASK_HOST << (addrlen-netbits);
   return mask;
 }
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e6a7bc8..8531175 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -489,7 +489,7 @@ init_tun (const char *dev,       /* --dev option */
 	  if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
 	    check_subnet_conflict (tt->local, tt->remote_netmask, "TUN/TAP adapter");
 	  else if (tt->type == DEV_TYPE_TUN)
-	    check_subnet_conflict (tt->local, ~0, "TUN/TAP adapter");
+	    check_subnet_conflict (tt->local, IPV4_NETMASK_HOST, "TUN/TAP adapter");
 	}
 
       /*
@@ -579,7 +579,7 @@ init_tun_post (struct tuntap *tt,
   overlapped_io_init (&tt->writes, frame, TRUE, true);
   tt->rw_handle.read = tt->reads.overlapped.hEvent;
   tt->rw_handle.write = tt->writes.overlapped.hEvent;
-  tt->adapter_index = ~0;
+  tt->adapter_index = dwMINUS_ONE;
 #endif
 }
 
@@ -3250,7 +3250,7 @@ get_per_adapter_info (const DWORD index, struct gc_arena *gc)
   IP_PER_ADAPTER_INFO *pi = NULL;
   DWORD status;
 
-  if (index != ~0)
+  if (index != dwMINUS_ONE)
     {
       if ((status = GetPerAdapterInfo (index, NULL, &size)) != ERROR_BUFFER_OVERFLOW)
 	{
@@ -3327,7 +3327,7 @@ get_interface_info (DWORD index, struct gc_arena *gc)
 const IP_ADAPTER_INFO *
 get_adapter (const IP_ADAPTER_INFO *ai, DWORD index)
 {
-  if (ai && index != (DWORD)~0)
+  if (ai && index != dwMINUS_ONE)
     {
       const IP_ADAPTER_INFO *a;
 
@@ -3504,7 +3504,7 @@ adapter_index_of_ip (const IP_ADAPTER_INFO *list,
 		     in_addr_t *netmask)
 {
   struct gc_arena gc = gc_new ();
-  DWORD ret = ~0;
+  DWORD ret = dwMINUS_ONE;
   in_addr_t highest_netmask = 0;
   bool first = true;
 
@@ -3540,7 +3540,7 @@ adapter_index_of_ip (const IP_ADAPTER_INFO *list,
        (int)ret,
        count ? *count : -1);
 
-  if (ret == ~0 && count)
+  if (ret == dwMINUS_ONE && count)
     *count = 0;
 
   if (netmask)
@@ -3564,7 +3564,7 @@ dhcp_status (DWORD index)
 {
   struct gc_arena gc = gc_new ();
   int ret = DHCP_STATUS_UNDEF;
-  if (index != ~0)
+  if (index != dwMINUS_ONE)
     {
       const IP_ADAPTER_INFO *ai = get_adapter_info (index, &gc);
 
@@ -3627,22 +3627,22 @@ static DWORD
 get_adapter_index_method_1 (const char *guid)
 {
   struct gc_arena gc = gc_new ();
-  ULONG index = ~0;
+  ULONG index = (ULONG)-1L;
   DWORD status;
   wchar_t wbuf[256];
   _snwprintf (wbuf, SIZE (wbuf), L"\\DEVICE\\TCPIP_%S", guid);
   wbuf [SIZE(wbuf) - 1] = 0;
   if ((status = GetAdapterIndex (wbuf, &index)) != NO_ERROR)
-    index = ~0;
+    index = (ULONG)-1L;
   gc_free (&gc);
-  return index;
+  return (DWORD)index;
 }
 
 static DWORD
 get_adapter_index_method_2 (const char *guid)
 {
   struct gc_arena gc = gc_new ();
-  DWORD index = ~0;
+  DWORD index = dwMINUS_ONE;
 
   const IP_ADAPTER_INFO *list = get_adapter_info_list (&gc);
 
@@ -3665,9 +3665,9 @@ get_adapter_index (const char *guid)
 {
   DWORD index;
   index = get_adapter_index_method_1 (guid);
-  if (index == ~0)
+  if (index == dwMINUS_ONE)
     index = get_adapter_index_method_2 (guid);
-  if (index == ~0)
+  if (index == dwMINUS_ONE)
     msg (M_INFO, "NOTE: could not get adapter index for %s", guid);
   return index;
 }
@@ -3678,18 +3678,18 @@ get_adapter_index_flexible (const char *name) /* actual name or GUID */
   struct gc_arena gc = gc_new ();
   DWORD index;
   index = get_adapter_index_method_1 (name);
-  if (index == ~0)
+  if (index == dwMINUS_ONE)
     index = get_adapter_index_method_2 (name);
-  if (index == ~0)
+  if (index == dwMINUS_ONE)
     {
       const struct tap_reg *tap_reg = get_tap_reg (&gc);
       const struct panel_reg *panel_reg = get_panel_reg (&gc);
       const char *guid = name_to_guid (name, tap_reg, panel_reg);
       index = get_adapter_index_method_1 (guid);
-      if (index == ~0)
+      if (index == dwMINUS_ONE)
 	index = get_adapter_index_method_2 (guid);
     }
-  if (index == ~0)
+  if (index == dwMINUS_ONE)
     msg (M_INFO, "NOTE: could not get adapter index for name/GUID '%s'", name);
   gc_free (&gc);
   return index;
@@ -3920,7 +3920,7 @@ dhcp_release_by_adapter_index(const DWORD adapter_index)
 static bool
 dhcp_release (const struct tuntap *tt)
 {
-  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != ~0)
+  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != dwMINUS_ONE)
     return dhcp_release_by_adapter_index (tt->adapter_index);
   else
     return false;
@@ -3953,7 +3953,7 @@ dhcp_renew_by_adapter_index (const DWORD adapter_index)
 static bool
 dhcp_renew (const struct tuntap *tt)
 {
-  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != ~0)
+  if (tt && tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ && tt->adapter_index != dwMINUS_ONE)
     return dhcp_renew_by_adapter_index (tt->adapter_index);
   else
     return false;
@@ -4838,7 +4838,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     const DWORD index = tt->adapter_index;
     
     /* flush arp cache */
-    if (index != (DWORD)~0)
+    if (index != dwMINUS_ONE)
       {
 	DWORD status;
 
@@ -4880,7 +4880,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 	const char *error_suffix = "I am having trouble using the Windows 'IP helper API' to automatically set the IP address -- consider using other --ip-win32 methods (not 'ipapi')";
 
 	/* couldn't get adapter index */
-	if (index == (DWORD)~0)
+	if (index == dwMINUS_ONE)
 	  {
 	    msg (M_FATAL, "ERROR: unable to get adapter index for interface %s -- %s",
 		 device_guid,
-- 
1.7.3.4


