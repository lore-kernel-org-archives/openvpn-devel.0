From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:47 +0200
Message-Id: <1441985627-14822-11-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 10/10] get_default_gateway_ipv6(): Win32
	implementation using GetBestRoute2()
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
To: openvpn-devel@lists.sourceforge.net

To get access to that functionality, bump Windows API level for MinGW
compilation from NTDDI_WINXP/_WIN32_WINNT_WINXP to ..._VISTA, and
shuffle around WIN32 includes a bit in syshead.h

MinGW 32 seems to be broken regarding MIB_TCP_STATE enum, so add typedef
for that - surrounding #ifdefs found by googling do not work yet -> TODO!

Extend add_route_ipv6() and delete_route_ipv6() to handle routes not on
the tap adapter but on ifindex-addressed interfaces ("interface=nn"),
and while at it, fix deletion of IPv6 routes with gateway address.

NOTE: this breaks Windows XP compatibility as GetBestRoute2() is not
available there, so even when not using IPv6, the binary will not run.

(Lightly) tested on Win7/64.

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac          |  2 +-
 src/openvpn/route.c   | 92 +++++++++++++++++++++++++++++++++++++++++++++++----
 src/openvpn/syshead.h |  7 +++-
 3 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 51ef93b..0a8255c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -348,7 +348,7 @@ case "$host" in
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
-		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_WINXP -D_WIN32_WINNT=_WIN32_WINNT_WINXP"
+		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA"
 		WIN32=yes
 		;;
 	*-*-dragonfly*)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d97968c..d45a02e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1757,6 +1757,14 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #elif defined (WIN32)
 
+  if ( r6->adapter_index )		/* vpn server special route */
+    {
+      struct buffer out = alloc_buf_gc (64, &gc);
+      buf_printf (&out, "interface=%d", r6->adapter_index );
+      device = buf_bptr(&out);
+      gateway_needed = true;
+    }
+
   /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
   argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d %s",
 	       get_win_sys_path(),
@@ -1772,7 +1780,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
    */
   if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
 	argv_printf_cat( &argv, " %s", "fe80::8" );
-  else
+  else if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
 	argv_printf_cat( &argv, " %s", gateway );
 
 #if 0
@@ -2144,6 +2152,14 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
 #elif defined (WIN32)
 
+  if ( r6->adapter_index )		/* vpn server special route */
+    {
+      struct buffer out = alloc_buf_gc (64, &gc);
+      buf_printf (&out, "interface=%d", r6->adapter_index );
+      device = buf_bptr(&out);
+      gateway_needed = true;
+    }
+
   /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
   argv_printf (&argv, "%s%sc interface ipv6 delete route %s/%d %s",
 	       get_win_sys_path(),
@@ -2158,9 +2174,9 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
    *   knows about and will answer ND (neighbor discovery) packets for
    * (and "route deletion without specifying next-hop" does not work...)
    */
-  if ( tt->type == DEV_TYPE_TUN )
+  if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
 	argv_printf_cat( &argv, " %s", "fe80::8" );
-  else
+  else if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
 	argv_printf_cat( &argv, " %s", gateway );
 
 #if 0
@@ -2485,15 +2501,79 @@ windows_route_find_if_index (const struct route_ipv4 *r, const struct tuntap *tt
   return ret;
 }
 
-/* IPv6 implementation using GetIpForwardTable2() and dynamic linking (TBD)
- * https://msdn.microsoft.com/en-us/library/windows/desktop/aa814416(v=vs.85).aspx
+/* IPv6 implementation using GetBestRoute2()
+ *   (TBD: dynamic linking so the binary can still run on XP?)
+ * https://msdn.microsoft.com/en-us/library/windows/desktop/aa365922(v=vs.85).aspx
+ * https://msdn.microsoft.com/en-us/library/windows/desktop/aa814411(v=vs.85).aspx
  */
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 			 const struct in6_addr *dest)
 {
-    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (windows)");
+    struct gc_arena gc = gc_new ();
+    MIB_IPFORWARD_ROW2 BestRoute;
+    SOCKADDR_INET DestinationAddress, BestSourceAddress;
+    DWORD BestIfIndex;
+    DWORD status;
+    NET_LUID InterfaceLuid;
+
     CLEAR(*rgi6);
+    CLEAR(InterfaceLuid);		// cleared = not used for lookup
+    CLEAR(DestinationAddress);
+
+    DestinationAddress.si_family = AF_INET6;
+    if ( dest )
+    {
+        DestinationAddress.Ipv6.sin6_addr = *dest;
+    }
+
+    status = GetBestInterfaceEx( &DestinationAddress, &BestIfIndex );
+
+    if (status != NO_ERROR)
+    {
+	msg (D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=%u)",
+	       strerror_win32 (status, &gc),
+	       (unsigned int)status);
+	goto done;
+    }
+
+    msg( D_ROUTE, "GetBestInterfaceEx() returned if=%d", (int) BestIfIndex );
+
+    status = GetBestRoute2( &InterfaceLuid, BestIfIndex, NULL,
+                            &DestinationAddress, 0,
+                            &BestRoute, &BestSourceAddress );
+
+    if (status != NO_ERROR)
+    {
+	msg (D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=%u)",
+	       strerror_win32 (status, &gc),
+	       (unsigned int)status);
+	goto done;
+    }
+
+    msg( D_ROUTE, "GDG6: II=%d DP=%s/%d NH=%s",
+	BestRoute.InterfaceIndex,
+	print_in6_addr( BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0, &gc),
+	BestRoute.DestinationPrefix.PrefixLength,
+	print_in6_addr( BestRoute.NextHop.Ipv6.sin6_addr, 0, &gc) );
+    msg( D_ROUTE, "GDG6: Metric=%d, Loopback=%d, AA=%d, I=%d",
+	(int) BestRoute.Metric,
+	(int) BestRoute.Loopback,
+	(int) BestRoute.AutoconfigureAddress,
+	(int) BestRoute.Immortal );
+
+    rgi6->gateway.addr_ipv6 = BestRoute.NextHop.Ipv6.sin6_addr;
+    rgi6->adapter_index     = BestRoute.InterfaceIndex;
+    rgi6->flags |= RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+
+    /* on-link is signalled by receiving an empty (::) NextHop */
+    if ( IN6_IS_ADDR_UNSPECIFIED(&BestRoute.NextHop.Ipv6.sin6_addr) )
+      {
+	rgi6->flags |= RGI_ON_LINK;
+      }
+
+  done:
+    gc_free (&gc);
 }
 
 bool
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index ff0bf41..e00af48 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -358,8 +358,13 @@
 #endif /* TARGET_DARWIN */
 
 #ifdef WIN32
-#include <iphlpapi.h>
+ // Missing declarations for MinGW 32.
+ // #if !defined(__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 2
+ typedef int MIB_TCP_STATE;
+ // #endif
+#include <naptypes.h>
 #include <ntddndis.h>
+#include <iphlpapi.h>
 #include <wininet.h>
 #include <shellapi.h>
 /* The following two headers are needed of PF_INET6 */
-- 
2.3.6


