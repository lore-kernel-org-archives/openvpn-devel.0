From: Gert Doering <gert@...1296...>
Date: Tue, 10 Jun 2014 16:04:32 +0200
Message-Id: <1402409073-54067216-4-git-send-email-gert@...1296...>
In-Reply-To: <1402409073-54067216-3-git-send-email-gert@...1296...>
References: <1402409073-54067216-1-git-send-email-gert@...1296...>
	<1402409073-54067216-2-git-send-email-gert@...1296...>
	<1402409073-54067216-3-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 3/4] implement adding/deleting routes on AIX,
	for IPv4 and IPv6
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
Cc: Gert Doering <gd@...1505...>

From: Gert Doering <gd@...1505...>

AIX only has TAP interfaces, so always use gateway address as next hop,
not interface name.

AIX route works much more reliable if passed netbits than netmask - do so
(introducing a new helper function netmask_to_netbits2())
---
 src/openvpn/route.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 5531eda..5428e76 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1482,6 +1482,17 @@ add_route (struct route_ipv4 *r,
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD/NetBSD route add command failed");
 
+#elif defined(TARGET_AIX)
+
+  {
+  int netbits = netmask_to_netbits2(r->netmask);
+  argv_printf (&argv, "%s add -net %s/%d %s",
+		ROUTE_PATH,
+	        network, netbits, gateway);
+  argv_msg (D_ROUTE, &argv);
+  status = openvpn_execve_check (&argv, es, 0, "ERROR: AIX route add command failed");
+  }
+
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
@@ -1701,6 +1712,14 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: NetBSD route add -inet6 command failed");
 
+#elif defined(TARGET_AIX)
+
+  argv_printf (&argv, "%s add -inet6 %s/%d %s",
+		ROUTE_PATH,
+	        network, r6->netbits, gateway);
+  argv_msg (D_ROUTE, &argv);
+  status = openvpn_execve_check (&argv, es, 0, "ERROR: AIX route add command failed");
+
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
@@ -1859,8 +1878,21 @@ delete_route (struct route_ipv4 *r,
 
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
+
 #elif defined(TARGET_ANDROID)
   msg (M_NONFATAL, "Sorry, deleting routes on Android is not possible. The VpnService API allows routes to be set on connect only.");
+
+#elif defined(TARGET_AIX)
+
+  {
+  int netbits = netmask_to_netbits2(r->netmask);
+  argv_printf (&argv, "%s delete -net %s/%d %s",
+		ROUTE_PATH,
+	        network, netbits, gateway);
+  argv_msg (D_ROUTE, &argv);
+  openvpn_execve_check (&argv, es, 0, "ERROR: AIX route delete command failed");
+  }
+
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
@@ -2031,6 +2063,14 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: NetBSD route delete -inet6 command failed");
 
+#elif defined(TARGET_AIX)
+
+  argv_printf (&argv, "%s delete -inet6 %s/%d %s",
+		ROUTE_PATH,
+	        network, r6->netbits, gateway);
+  argv_msg (D_ROUTE, &argv);
+  openvpn_execve_check (&argv, es, 0, "ERROR: AIX route add command failed");
+
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif
@@ -2868,6 +2908,26 @@ netmask_to_netbits (const in_addr_t network, const in_addr_t netmask, int *netbi
   return false;
 }
 
+/* similar to netmask_to_netbits(), but don't mess with base address
+ * etc., just convert to netbits - non-mappable masks are returned as "-1"
+ */
+int netmask_to_netbits2 (in_addr_t netmask)
+{
+  int i;
+  const int addrlen = sizeof (in_addr_t) * 8;
+
+  for (i = 0; i <= addrlen; ++i)
+    {
+      in_addr_t mask = netbits_to_netmask (i);
+      if (mask == netmask)
+	{
+	  return i;
+	}
+    }
+  return -1;
+}
+
+
 /*
  * get_bypass_addresses() is used by the redirect-gateway bypass-x
  * functions to build a route bypass to selected DHCP/DNS servers,
-- 
1.6.4


