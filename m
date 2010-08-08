Date: Sun, 8 Aug 2010 12:48:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100808104834.GE740@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] feat_ipv6_payload on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

here's a patch on top of feat_ipv6_payload to make IPv6 payload work
on OpenBSD.  Tested on 4.7.

I've pushed it to git://compile.srv01.mucip.net/openvpn-gert.git (master),
so David can "just pull" it to the feat_ipv6_payload branch - but he asked
me to send all changes to the mailing list as well to get review.

Well, here you are :-)

gert


From e1f41b55a294c4f70a72d02e77aca140ac10a3a3 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 8 Aug 2010 12:34:00 +0200
Subject: [PATCH] implement IPv6 ifconfig + route setup/deletion on OpenBSD
 destroy tunX interface on tun_close()
 tested on OpenBSD 4.7

Signed-off-by: Gert Doering <gert@...1296...>
---
 ChangeLog.IPv6 |   18 ++++++++++++++++++
 route.c        |   28 ++++++++++++++++++++--------
 tun.c          |   36 +++++++++++++++++++++++++++++++++---
 3 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/ChangeLog.IPv6 b/ChangeLog.IPv6
index 6fcfaa4..4275389 100644
--- a/ChangeLog.IPv6
+++ b/ChangeLog.IPv6
@@ -315,3 +315,21 @@ Sun Mar  7 19:17:33 CET 2010
     is older than 9.7, log warning and disable IPv6 (won't work anyway).
 
   * release as patch 20100307-1
+
+Sat Jul 10 14:37:52 CEST 2010
+
+  * TEST SUCCESS: point-to-point tun mode with --ifconfig-ipv6 between
+                  Solaris10/sparc and Linux (Michal Ludvig)
+    (using the whiteboard tun driver on Solaris, otherwise "no IPv6")
+
+Sun Aug  8 12:30:44 CEST 2010
+
+  * route.c: split NetBSD and OpenBSD parts of add_route_ipv6() and
+             delete_route_ipv6(), implement OpenBSD variant
+             (needs "-prefixlen nn" while NetBSD uses "/nn")
+
+  * tun.c: implement IPv6 ifconfig for OpenBSD
+
+  * tun.c: destroy tunX interface at tun_close() on OpenBSD (cleanup)
+
+  * TEST SUCCESS: OpenBSD 4.7: client-tun/net30, v4+v6
diff --git a/route.c b/route.c
index 820a3a3..84d155d 100644
--- a/route.c
+++ b/route.c
@@ -1400,17 +1400,23 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
 
-#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#elif defined(TARGET_OPENBSD)
 
-  /* GERT-TODO: this needs real-world testing on OpenBSD, but it should work
-   */
+  argv_printf (&argv, "%s add -inet6 %s -prefixlen %d %s",
+		ROUTE_PATH,
+	        network, r6->netbits, gateway );
+
+  argv_msg (D_ROUTE, &argv);
+  status = openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD route add -inet6 command failed");
+
+#elif defined(TARGET_NETBSD)
 
   argv_printf (&argv, "%s add -inet6 %s/%d %s",
 		ROUTE_PATH,
 	        network, r6->netbits, gateway );
 
   argv_msg (D_ROUTE, &argv);
-  status = openvpn_execve_check (&argv, es, 0, "ERROR: NetBSD/OpenBSD route add -inet6 command failed");
+  status = openvpn_execve_check (&argv, es, 0, "ERROR: NetBSD route add -inet6 command failed");
 
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
@@ -1670,17 +1676,23 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: *BSD route delete -inet6 command failed");
 
-#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#elif defined(TARGET_OPENBSD)
 
-  /* GERT-TODO: this needs real-world testing on OpenBSD, but it should work
-   */
+  argv_printf (&argv, "%s delete -inet6 %s -prefixlen %d %s",
+		ROUTE_PATH,
+	        network, r6->netbits, gateway );
+
+  argv_msg (D_ROUTE, &argv);
+  openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD route delete -inet6 command failed");
+
+#elif defined(TARGET_NETBSD)
 
   argv_printf (&argv, "%s delete -inet6 %s/%d %s",
 		ROUTE_PATH,
 	        network, r6->netbits, gateway );
 
   argv_msg (D_ROUTE, &argv);
-  openvpn_execve_check (&argv, es, 0, "ERROR: NetBSD/OpenBSD route delete -inet6 command failed");
+  openvpn_execve_check (&argv, es, 0, "ERROR: NetBSD route delete -inet6 command failed");
 
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
diff --git a/tun.c b/tun.c
index b038ce9..3e4b37f 100644
--- a/tun.c
+++ b/tun.c
@@ -572,7 +572,7 @@ init_tun_post (struct tuntap *tt,
 }
 
 #if defined(TARGET_WIN32) || \
-    defined(TARGET_DARWIN) || defined(TARGET_NETBSD)
+    defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 
 /* some of the platforms will auto-add a "network route" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -846,7 +846,18 @@ do_ifconfig (struct tuntap *tt,
       openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig failed");
       if ( do_ipv6 )
 	{
-	  msg( M_FATAL, "can't configure IPv6 on OpenBSD yet - unimplemented" );
+	  argv_printf (&argv,
+			  "%s %s inet6 %s/%d",
+			  IFCONFIG_PATH,
+			  actual,
+			  ifconfig_ipv6_local,
+			  tt->netbits_ipv6
+			  );
+	  argv_msg (M_INFO, &argv);
+	  openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig inet6 failed");
+
+	  /* and, hooray, we explicitely need to add a route... */
+	  add_route_connected_v6_net(tt, es);
 	}
       tt->did_ifconfig = true;
 
@@ -907,7 +918,7 @@ do_ifconfig (struct tuntap *tt,
 			  tt->netbits_ipv6
 			  );
 	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig failed");
+	  openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig inet6 failed");
 
 	  /* and, hooray, we explicitely need to add a route... */
 	  add_route_connected_v6_net(tt, es);
@@ -1807,12 +1818,31 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     }
 }
 
+/* the current way OpenVPN handles tun devices on OpenBSD leads to
+ * lingering tunX interfaces after close -> for a full cleanup, they
+ * need to be explicitely destroyed
+ */
+
 void
 close_tun (struct tuntap* tt)
 {
   if (tt)
     {
+      struct gc_arena gc = gc_new ();
+      struct argv argv;
+
+      /* setup command, close tun dev (clears tt->actual_name!), run command
+       */
+
+      argv_init (&argv);
+      argv_printf (&argv, "%s %s destroy",
+                          IFCONFIG_PATH, tt->actual_name);
+
       close_tun_generic (tt);
+
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
+
       free (tt);
     }
 }
-- 
1.6.4.4

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

