Sender: "scottywz@...277..." <scottywz@...277...>
From: Scott Zeid <s@...1497...>
Date: Tue, 30 Aug 2011 03:47:16 -0500
Message-Id: <1314694036-3749-1-git-send-email-s@...1497...>
Subject: [Openvpn-devel] [PATCH] Add IPv6 gateway support for Linux, FreeBSD,
	and Darwin
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
Cc: Scott Zeid <s@...1497...>

This patch adds IPv6 gateway configuration for Linux, FreeBSD, and Darwin.
Apparently this functionality already exists on Win32, Solaris, OpenBSD, and
NetBSD.

This patch does not implement the --route-ipv6-gateway option; it only
implements adding the gateway in add_route_ipv6().

I am only able to test this patch on Linux; the FreeBSD and Darwin code was
guessed by reading the respective route(8) man pages.

(Thoughts:  Some platforms do not specify the TUN/TAP interface in the route
commands.  Is this intentional?)

Signed-off-by: Scott Zeid <s@...1497...>
---
 route.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/route.c b/route.c
index d632b45..7f7b6fc 100644
--- a/route.c
+++ b/route.c
@@ -1537,20 +1537,22 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s -6 route add %s/%d dev %s",
+  argv_printf (&argv, "%s -6 route add %s/%d dev %s via %s",
   	      iproute_path,
 	      network,
 	      r6->netbits,
-	      device);
+	      device,
+	      gateway);
   if (r6->metric_defined)
     argv_printf_cat (&argv, " metric %d", r6->metric);
 
 #else
-  argv_printf (&argv, "%s -A inet6 add %s/%d dev %s",
+  argv_printf (&argv, "%s -A inet6 add %s/%d dev %s gw %s",
 		ROUTE_PATH,
 	      network,
 	      r6->netbits,
-	      device);
+	      device,
+	      gateway);
   if (r6->metric_defined)
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*CONFIG_FEATURE_IPROUTE*/
@@ -1613,20 +1615,21 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
-  argv_printf (&argv, "%s add -inet6 %s/%d -iface %s",
+  argv_printf (&argv, "%s add -inet6 %s/%d -iface %s %s",
 		ROUTE_PATH,
 	        network,
 	        r6->netbits,
-	        device );
+	        device,
+		gateway );
 
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
 
 #elif defined(TARGET_DARWIN) 
 
-  argv_printf (&argv, "%s add -inet6 %s -prefixlen %d -iface %s",
+  argv_printf (&argv, "%s add -inet6 %s -prefixlen %d -iface %s %s",
 		ROUTE_PATH,
-	        network, r6->netbits, device );
+	        network, r6->netbits, device, gateway );
 
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
-- 
1.7.4.1


