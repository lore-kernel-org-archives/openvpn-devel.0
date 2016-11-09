From: Gert Doering <gert@...1296...>
Date: Wed,  9 Nov 2016 21:19:32 +0100
Message-Id: <20161109201932.80991-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Repair topology subnet on OpenBSD
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

Turns out that "topology subnet" never worked totally right on
OpenBSD - the "netmask" parameter to ifconfig is ignored, and one
needs to add a subnet route  (and this issue is hidden if an
encompassing route is pushed, like, by using --redirect-gateway).

While add it, apply the hack used for FreeBSD where "an arbitrary
address from the subnet" is used to set the "remote" end of the
tunnel, and point the route to that - so if OpenBSD decides to
change their kernel routing structure the same way, our code still
works (copying from commit 433b3813d8c38b4, trac #425 and commit
60fd44e501f2002, trac #481).

Tested on OpenBSD 6.0 and 4.9

Trac #710

Signed-off-by: Gert Doering <gert@...2189...>
---
 src/openvpn/tun.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a6d38d5..a312d91 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -711,7 +711,8 @@ void delete_route_connected_v6_net(struct tuntap * tt,
 }
 #endif
 
-#if defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+#if defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)||\
+    defined(TARGET_OPENBSD)
 /* we can't use true subnet mode on tun on all platforms, as that
  * conflicts with IPv6 (wants to use ND then, which we don't do),
  * but the OSes want "a remote address that is different from ours"
@@ -1032,6 +1033,8 @@ do_ifconfig (struct tuntap *tt,
 
 #elif defined(TARGET_OPENBSD)
 
+      in_addr_t remote_end;		/* for "virtual" subnet topology */
+
       /*
        * On OpenBSD, tun interfaces are persistent if created with
        * "ifconfig tunX create", and auto-destroyed if created by
@@ -1051,12 +1054,13 @@ do_ifconfig (struct tuntap *tt,
       else
 	if ( tt->topology == TOP_SUBNET )
 	{
+	    remote_end = create_arbitrary_remote( tt );
 	    argv_printf (&argv,
 			  "%s %s %s %s mtu %d netmask %s up -link0",
 			  IFCONFIG_PATH,
 			  actual,
 			  ifconfig_local,
-			  ifconfig_local,
+			  print_in_addr_t (remote_end, 0, &gc),
 			  tun_mtu,
 			  ifconfig_remote_netmask
 			  );
@@ -1073,6 +1077,19 @@ do_ifconfig (struct tuntap *tt,
 			  );
       argv_msg (M_INFO, &argv);
       openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig failed");
+
+      /* Add a network route for the local tun interface */
+      if (!tun && tt->topology == TOP_SUBNET)
+        {
+          struct route_ipv4 r;
+          CLEAR (r);
+          r.flags = RT_DEFINED;
+          r.network = tt->local & tt->remote_netmask;
+          r.netmask = tt->remote_netmask;
+          r.gateway = remote_end;
+          add_route (&r, tt, 0, NULL, es);
+        }
+
       if ( do_ipv6 )
 	{
 	  argv_printf (&argv,
-- 
2.9.0


