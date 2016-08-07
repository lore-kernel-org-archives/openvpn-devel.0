From: ValdikSS <iam@...2070...>
Date: Sun,  7 Aug 2016 14:44:05 +0300
Message-Id: <1470570245-28327-3-git-send-email-iam@...2070...>
In-Reply-To: <1470570245-28327-1-git-send-email-iam@...2070...>
References: <1470570245-28327-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH 3/3] Do not pass env for system commands on
	OS X
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

---
 src/openvpn/route.c | 8 ++++----
 src/openvpn/tun.c   | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 822d02b..c1ce7fd 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1601,7 +1601,7 @@ add_route (struct route_ipv4 *r,
     }
 
   argv_msg (D_ROUTE, &argv);
-  status = openvpn_execve_check (&argv, es, 0, "ERROR: OS X route add command failed");
+  status = openvpn_execve_check (&argv, NULL, 0, "ERROR: OS X route add command failed");
 
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
@@ -1884,7 +1884,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
     argv_printf_cat (&argv, "-iface %s", device);
 
   argv_msg (D_ROUTE, &argv);
-  status = openvpn_execve_check (&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
+  status = openvpn_execve_check (&argv, NULL, 0, "ERROR: MacOS X route add -inet6 command failed");
 
 #elif defined(TARGET_OPENBSD)
 
@@ -2066,7 +2066,7 @@ delete_route (struct route_ipv4 *r,
     }
 
   argv_msg (D_ROUTE, &argv);
-  openvpn_execve_check (&argv, es, 0, "ERROR: OS X route delete command failed");
+  openvpn_execve_check (&argv, NULL, 0, "ERROR: OS X route delete command failed");
 
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
@@ -2285,7 +2285,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
     argv_printf_cat (&argv, "-iface %s", device);
 
   argv_msg (D_ROUTE, &argv);
-  openvpn_execve_check (&argv, es, 0, "ERROR: MacOS X route delete -inet6 command failed");
+  openvpn_execve_check (&argv, NULL, 0, "ERROR: MacOS X route delete -inet6 command failed");
 
 #elif defined(TARGET_OPENBSD)
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 963460e..ada7c4a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1156,7 +1156,7 @@ do_ifconfig (struct tuntap *tt,
 			IFCONFIG_PATH,
 			actual);
       argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, 0, NULL);
+      openvpn_execve_check (&argv, NULL, 0, NULL);
       msg (M_INFO, "NOTE: Tried to delete pre-existing tun/tap instance -- No Problem if failure");
 
 
@@ -1194,7 +1194,7 @@ do_ifconfig (struct tuntap *tt,
 	}
 
       argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, S_FATAL, "Mac OS X ifconfig failed");
+      openvpn_execve_check (&argv, NULL, S_FATAL, "Mac OS X ifconfig failed");
       tt->did_ifconfig = true;
 
       /* Add a network route for the local tun interface */
@@ -1219,7 +1219,7 @@ do_ifconfig (struct tuntap *tt,
                               tt->netbits_ipv6
                               );
 	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "MacOS X ifconfig inet6 failed");
+	  openvpn_execve_check (&argv, NULL, S_FATAL, "MacOS X ifconfig inet6 failed");
 
 	  /* and, hooray, we explicitely need to add a route... */
 	  add_route_connected_v6_net(tt, es);
-- 
2.5.5


