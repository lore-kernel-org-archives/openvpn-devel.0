From: ValdikSS <iam@...2070...>
Date: Sun,  7 Aug 2016 14:44:03 +0300
Message-Id: <1470570245-28327-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH 1/3] Do not pass env for system commands on
	Linux
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

It's possible to have so much routes that they won't fit into
stack and execve would fail with E2BIG (Argument list too long).

This commit fixes this issue by not adding route information
into execve'd application env.
---
 src/openvpn/lladdr.c |  2 +-
 src/openvpn/route.c  |  8 ++++----
 src/openvpn/tun.c    | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 57f447b..d537379 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -58,7 +58,7 @@ int set_lladdr(const char *ifname, const char *lladdr,
 #endif
 
   argv_msg (M_INFO, &argv);
-  r = openvpn_execve_check (&argv, es, M_WARN, "ERROR: Unable to set link layer address.");
+  r = openvpn_execve_check (&argv, NULL, M_WARN, "ERROR: Unable to set link layer address.");
   if (r)
     msg (M_INFO, "TUN/TAP link layer address set to %s", lladdr);
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a90195f..c327866 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1444,7 +1444,7 @@ add_route (struct route_ipv4 *r,
 
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
-  status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
+  status = openvpn_execve_check (&argv, NULL, 0, "ERROR: Linux route add command failed");
 
 #elif defined (TARGET_ANDROID)
   struct buffer out = alloc_buf_gc (128, &gc);
@@ -1769,7 +1769,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
-  status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
+  status = openvpn_execve_check (&argv, NULL, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
 #elif defined (TARGET_ANDROID)
     struct buffer out = alloc_buf_gc (64, &gc);
@@ -1967,7 +1967,7 @@ delete_route (struct route_ipv4 *r,
   if (r->flags & RT_METRIC_DEFINED)
     argv_printf_cat (&argv, "metric %d", r->metric);
   argv_msg (D_ROUTE, &argv);
-  openvpn_execve_check (&argv, es, 0, "ERROR: Linux route delete command failed");
+  openvpn_execve_check (&argv, NULL, 0, "ERROR: Linux route delete command failed");
 
 #elif defined (WIN32)
   
@@ -2188,7 +2188,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
-  openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
+  openvpn_execve_check (&argv, NULL, 0, "ERROR: Linux route -6/-A inet6 del command failed");
 
 #elif defined (WIN32)
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b7a29f7..963460e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -794,7 +794,7 @@ do_ifconfig (struct tuntap *tt,
 			  tun_mtu
 			  );
 	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip link set failed");
+	  openvpn_execve_check (&argv, NULL, S_FATAL, "Linux ip link set failed");
 
 	if (tun) {
 
@@ -809,7 +809,7 @@ do_ifconfig (struct tuntap *tt,
 				  ifconfig_remote_netmask
 				  );
 		  argv_msg (M_INFO, &argv);
-		  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip addr add failed");
+		  openvpn_execve_check (&argv, NULL, S_FATAL, "Linux ip addr add failed");
 	} else {
 		argv_printf (&argv,
 				  "%s addr add dev %s %s/%d broadcast %s",
@@ -820,7 +820,7 @@ do_ifconfig (struct tuntap *tt,
 				  ifconfig_broadcast
 				  );
 		  argv_msg (M_INFO, &argv);
-		  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip addr add failed");
+		  openvpn_execve_check (&argv, NULL, S_FATAL, "Linux ip addr add failed");
 	}
       if ( do_ipv6 )
 	{
@@ -832,7 +832,7 @@ do_ifconfig (struct tuntap *tt,
 		      actual
 		      );
 	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr add failed");
+	  openvpn_execve_check (&argv, NULL, S_FATAL, "Linux ip -6 addr add failed");
 	}
       tt->did_ifconfig = true;
 #else
@@ -856,7 +856,7 @@ do_ifconfig (struct tuntap *tt,
 			  ifconfig_broadcast
 			  );
       argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig failed");
+      openvpn_execve_check (&argv, NULL, S_FATAL, "Linux ifconfig failed");
       if ( do_ipv6 )
 	{
 	  argv_printf (&argv,
@@ -867,7 +867,7 @@ do_ifconfig (struct tuntap *tt,
 			  tt->netbits_ipv6
 			  );
 	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
+	  openvpn_execve_check (&argv, NULL, S_FATAL, "Linux ifconfig inet6 failed");
 	}
       tt->did_ifconfig = true;
 
-- 
2.5.5


