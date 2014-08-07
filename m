From: Gavin Shrubbery <gavin.shrubbery@...277...>
Date: Fri,  8 Aug 2014 11:10:32 +1200
Message-Id: <1407453032-588-1-git-send-email-gavin.shrubbery@...277...>
Subject: [Openvpn-devel] [PATCH] Tease apart ipv6 and ipv4 ifconfig code.
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

This change makes it possible to configure an IPv6 address on a
tunnel without also having an IPv4 address.

Signed-off-by: Gavin Shrubbery <gavin.shrubbery@...277...>
---
 src/openvpn/tun.c | 367 +++++++++++++++++++++++++++---------------------------
 1 file changed, 183 insertions(+), 184 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ba4b15e..d1a8a03 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -634,16 +634,10 @@ do_ifconfig (struct tuntap *tt,
       const char *ifconfig_local = NULL;
       const char *ifconfig_remote_netmask = NULL;
       const char *ifconfig_broadcast = NULL;
-      const char *ifconfig_ipv6_local = NULL;
-      const char *ifconfig_ipv6_remote = NULL;
-      bool do_ipv6 = false;
       struct argv argv;
 
       argv_init (&argv);
 
-      msg( M_INFO, "do_ifconfig, tt->ipv6=%d, tt->did_ifconfig_ipv6_setup=%d",
-	           tt->ipv6, tt->did_ifconfig_ipv6_setup );
-
       /*
        * We only handle TUN/TAP devices here, not --dev null devices.
        */
@@ -655,13 +649,6 @@ do_ifconfig (struct tuntap *tt,
       ifconfig_local = print_in_addr_t (tt->local, 0, &gc);
       ifconfig_remote_netmask = print_in_addr_t (tt->remote_netmask, 0, &gc);
 
-      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
-        {
-	  ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
-	  ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
-	  do_ipv6 = true;
-	}
-
       /*
        * If TAP-style device, generate broadcast address.
        */
@@ -679,7 +666,6 @@ do_ifconfig (struct tuntap *tt,
     }
 #endif
 
-
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
 	/*
@@ -720,19 +706,6 @@ do_ifconfig (struct tuntap *tt,
 		  argv_msg (M_INFO, &argv);
 		  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip addr add failed");
 	}
-      if ( do_ipv6 )
-	{
-	  argv_printf( &argv,
-		      "%s -6 addr add %s/%d dev %s",
-		      iproute_path,
-		      ifconfig_ipv6_local,
-		      tt->netbits_ipv6,
-		      actual
-		      );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr add failed");
-	}
-      tt->did_ifconfig = true;
 #else
       if (tun)
 	argv_printf (&argv,
@@ -755,21 +728,8 @@ do_ifconfig (struct tuntap *tt,
 			  );
       argv_msg (M_INFO, &argv);
       openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig failed");
-      if ( do_ipv6 )
-	{
-	  argv_printf (&argv,
-			  "%s %s add %s/%d",
-			  IFCONFIG_PATH,
-			  actual,
-			  ifconfig_ipv6_local,
-			  tt->netbits_ipv6
-			  );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
-	}
-      tt->did_ifconfig = true;
-
 #endif /*ENABLE_IPROUTE*/
+      tt->did_ifconfig = true;
 #elif defined(TARGET_SOLARIS)
 
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -824,52 +784,6 @@ do_ifconfig (struct tuntap *tt,
       if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig phase-2 failed"))
 	solaris_error_close (tt, es, actual, false);
 
-      if ( do_ipv6 )
-        {
- 	  argv_printf (&argv, "%s %s inet6 unplumb",
-			    IFCONFIG_PATH, actual );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, 0, NULL);
-
-	  if ( tt->type == DEV_TYPE_TUN )
-	   {
-	      argv_printf (&argv,
-			    "%s %s inet6 plumb %s/%d %s up",
-			    IFCONFIG_PATH,
-			    actual,
-			    ifconfig_ipv6_local,
-			    tt->netbits_ipv6,
-			    ifconfig_ipv6_remote
-			    );
-	    }
-	  else						/* tap mode */
-	    {
-	      /* base IPv6 tap interface needs to be brought up first
-	       */
-	      argv_printf (&argv, "%s %s inet6 plumb up",
-			    IFCONFIG_PATH, actual );
-	      argv_msg (M_INFO, &argv);
-	      if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig IPv6 (prepare) failed"))
-		solaris_error_close (tt, es, actual, true);
-
-	      /* we might need to do "ifconfig %s inet6 auto-dhcp drop"
-	       * after the system has noticed the interface and fired up
-	       * the DHCPv6 client - but this takes quite a while, and the 
-	       * server will ignore the DHCPv6 packets anyway.  So we don't.
-	       */
-
-	      /* static IPv6 addresses need to go to a subinterface (tap0:1)
-	       */
-	      argv_printf (&argv,
-			    "%s %s inet6 addif %s/%d up",
-			    IFCONFIG_PATH, actual,
-			    ifconfig_ipv6_local, tt->netbits_ipv6 );
-	    }
-	  argv_msg (M_INFO, &argv);
-	  if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig IPv6 failed"))
-	    solaris_error_close (tt, es, actual, true);
-        }
-
       if (!tun && tt->topology == TOP_SUBNET)
 	{
 	  /* Add a network route for the local tun interface */
@@ -928,32 +842,9 @@ do_ifconfig (struct tuntap *tt,
 			  );
       argv_msg (M_INFO, &argv);
       openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig failed");
-      if ( do_ipv6 )
-	{
-	  argv_printf (&argv,
-			  "%s %s inet6 %s/%d",
-			  IFCONFIG_PATH,
-			  actual,
-			  ifconfig_ipv6_local,
-			  tt->netbits_ipv6
-			  );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig inet6 failed");
 
-	  /* and, hooray, we explicitely need to add a route... */
-	  add_route_connected_v6_net(tt, es);
-	}
       tt->did_ifconfig = true;
-
 #elif defined(TARGET_NETBSD)
-
-/* whether or not NetBSD can do IPv6 can be seen by the availability of
- * the TUNSIFHEAD ioctl() - see next TARGET_NETBSD block for more details
- */
-#ifdef TUNSIFHEAD
-# define NETBSD_MULTI_AF
-#endif
-
       if (tun)
 	argv_printf (&argv,
 			  "%s %s %s %s mtu %d netmask 255.255.255.255 up",
@@ -994,26 +885,6 @@ do_ifconfig (struct tuntap *tt,
       argv_msg (M_INFO, &argv);
       openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
-      if ( do_ipv6 )
-	{
-#ifdef NETBSD_MULTI_AF
-	  argv_printf (&argv,
-			  "%s %s inet6 %s/%d",
-			  IFCONFIG_PATH,
-			  actual,
-			  ifconfig_ipv6_local,
-			  tt->netbits_ipv6
-			  );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig inet6 failed");
-
-	  /* and, hooray, we explicitely need to add a route... */
-	  add_route_connected_v6_net(tt, es);
-#else
-	  msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD before 4.0 (if your system is newer, recompile openvpn)" );
-	  tt->ipv6 = false;
-#endif
-	}
       tt->did_ifconfig = true;
 
 #elif defined(TARGET_DARWIN)
@@ -1079,22 +950,6 @@ do_ifconfig (struct tuntap *tt,
 	  add_route (&r, tt, 0, NULL, es);
 	}
 
-      if ( do_ipv6 )
-	{
-          argv_printf (&argv,
-                              "%s %s inet6 %s/%d",
-                              IFCONFIG_PATH,
-                              actual,
-                              ifconfig_ipv6_local,
-                              tt->netbits_ipv6
-                              );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "MacOS X ifconfig inet6 failed");
-
-	  /* and, hooray, we explicitely need to add a route... */
-	  add_route_connected_v6_net(tt, es);
-	}
-
 #elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
 
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
@@ -1145,19 +1000,6 @@ do_ifconfig (struct tuntap *tt,
           add_route (&r, tt, 0, NULL, es);
         }
 
-      if ( do_ipv6 )
-	{
-          argv_printf (&argv,
-                              "%s %s inet6 %s/%d",
-                              IFCONFIG_PATH,
-                              actual,
-                              ifconfig_ipv6_local,
-                              tt->netbits_ipv6
-                              );
-	  argv_msg (M_INFO, &argv);
-	  openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig inet6 failed");
-	}
-
 #elif defined (WIN32)
       {
 	/*
@@ -1196,35 +1038,192 @@ do_ifconfig (struct tuntap *tt,
 	  }
 	tt->did_ifconfig = true;
       }
+#else
+      msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
+#endif
+      argv_reset (&argv);
+  }
 
-    /* IPv6 always uses "netsh" interface */
-    if ( do_ipv6 )
-      {
-	char * saved_actual;
+  if (tt->ipv6 && tt->did_ifconfig_ipv6_setup)
+    {
+      const char *ifconfig_ipv6_local = NULL;
+      const char *ifconfig_ipv6_remote = NULL;
 
-	if (!strcmp (actual, "NULL"))
-	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
+      struct argv argv;
 
-	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d store=active */
-	argv_printf (&argv,
-		    "%s%sc interface ipv6 set address %s %s store=active",
-		     get_win_sys_path(),
-		     NETSH_PATH_SUFFIX,
-		     actual,
-		     ifconfig_ipv6_local );
+      argv_init (&argv);
 
-	netsh_command (&argv, 4);
+      msg( M_INFO, "do_ifconfig, tt->ipv6=%d, tt->did_ifconfig_ipv6_setup=%d",
+	           tt->ipv6, tt->did_ifconfig_ipv6_setup );
 
-	/* explicit route needed */
-	/* on windows, OpenVPN does ifconfig first, open_tun later, so
-	 * tt->actual_name might not yet be initialized, but routing code
-	 * needs to know interface name - point to "actual", restore later
-	 */
-	saved_actual = tt->actual_name;
-	tt->actual_name = (char*) actual;
-	add_route_connected_v6_net(tt, es);
-	tt->actual_name = saved_actual;
-      }
+      ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
+      ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
+
+#if defined(TARGET_LINUX)
+#ifdef ENABLE_IPROUTE
+      argv_printf (&argv,
+		  "%s -6 addr add %s/%d dev %s",
+		  iproute_path,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6,
+		  actual
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr add failed");
+#else
+      argv_printf (&argv,
+		  "%s %s add %s/%d",
+		  IFCONFIG_PATH,
+		  actual,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
+#endif /*ENABLE_IPROUTE*/
+#elif defined(TARGET_SOLARIS)
+
+      argv_printf (&argv, "%s %s inet6 unplumb",
+		  IFCONFIG_PATH, actual );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, 0, NULL);
+
+      if ( tt->type == DEV_TYPE_TUN )
+	{
+	  argv_printf (&argv,
+		      "%s %s inet6 plumb %s/%d %s up",
+		      IFCONFIG_PATH,
+		      actual,
+		      ifconfig_ipv6_local,
+		      tt->netbits_ipv6,
+		      ifconfig_ipv6_remote
+		      );
+	}
+      else						/* tap mode */
+	{
+	  /* base IPv6 tap interface needs to be brought up first
+	   */
+	  argv_printf (&argv, "%s %s inet6 plumb up",
+		      IFCONFIG_PATH, actual );
+	  argv_msg (M_INFO, &argv);
+	  if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig IPv6 (prepare) failed"))
+	    solaris_error_close (tt, es, actual, true);
+
+	  /* we might need to do "ifconfig %s inet6 auto-dhcp drop"
+	   * after the system has noticed the interface and fired up
+	   * the DHCPv6 client - but this takes quite a while, and the 
+	   * server will ignore the DHCPv6 packets anyway.  So we don't.
+	   */
+
+	  /* static IPv6 addresses need to go to a subinterface (tap0:1)
+	   */
+	  argv_printf (&argv,
+		      "%s %s inet6 addif %s/%d up",
+		      IFCONFIG_PATH, actual,
+		      ifconfig_ipv6_local, tt->netbits_ipv6 );
+	}
+      argv_msg (M_INFO, &argv);
+      if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig IPv6 failed"))
+	solaris_error_close (tt, es, actual, true);
+
+#elif defined(TARGET_OPENBSD)
+
+      argv_printf (&argv,
+		  "%s %s inet6 %s/%d",
+		  IFCONFIG_PATH,
+		  actual,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig inet6 failed");
+
+      /* and, hooray, we explicitely need to add a route... */
+      add_route_connected_v6_net(tt, es);
+
+#elif defined(TARGET_NETBSD)
+
+/* whether or not NetBSD can do IPv6 can be seen by the availability of
+ * the TUNSIFHEAD ioctl() - see next TARGET_NETBSD block for more details
+ */
+#ifdef TUNSIFHEAD
+# define NETBSD_MULTI_AF
+#endif
+
+#ifdef NETBSD_MULTI_AF
+      argv_printf (&argv,
+		  "%s %s inet6 %s/%d",
+		  IFCONFIG_PATH,
+		  actual,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig inet6 failed");
+
+      /* and, hooray, we explicitely need to add a route... */
+      add_route_connected_v6_net(tt, es);
+#else
+      msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD before 4.0 (if your system is newer, recompile openvpn)" );
+      tt->ipv6 = false;
+#endif
+
+#elif defined(TARGET_DARWIN)
+      /*
+       * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour to OpenBSD...
+       */
+      argv_printf (&argv,
+                  "%s %s inet6 %s/%d",
+                  IFCONFIG_PATH,
+                  actual,
+                  ifconfig_ipv6_local,
+                  tt->netbits_ipv6
+                  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "MacOS X ifconfig inet6 failed");
+
+      /* and, hooray, we explicitely need to add a route... */
+      add_route_connected_v6_net(tt, es);
+
+
+#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+
+      argv_printf (&argv,
+                  "%s %s inet6 %s/%d",
+                  IFCONFIG_PATH,
+                  actual,
+                  ifconfig_ipv6_local,
+                  tt->netbits_ipv6
+                  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig inet6 failed");
+
+#elif defined (WIN32)
+      /* IPv6 always uses "netsh" interface */
+      char * saved_actual;
+
+      if (!strcmp (actual, "NULL"))
+        msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
+
+      /* example: netsh interface ipv6 set address MyTap 2001:608:8003::d store=active */
+      argv_printf (&argv,
+		  "%s%sc interface ipv6 set address %s %s store=active",
+		  get_win_sys_path(),
+		  NETSH_PATH_SUFFIX,
+		  actual,
+		  ifconfig_ipv6_local );
+
+      netsh_command (&argv, 4);
+
+      /* explicit route needed */
+      /* on windows, OpenVPN does ifconfig first, open_tun later, so
+       * tt->actual_name might not yet be initialized, but routing code
+       * needs to know interface name - point to "actual", restore later
+       */
+      saved_actual = tt->actual_name;
+      tt->actual_name = (char*) actual;
+      add_route_connected_v6_net(tt, es);
+      tt->actual_name = saved_actual;
 #else
       msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif
@@ -4932,7 +4931,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
   if (tt->type == DEV_TYPE_TUN)
     {
-      if (!tt->did_ifconfig_setup)
+      if (!(tt->did_ifconfig_setup || tt->did_ifconfig_ipv6_setup))
 	{
 	  msg (M_FATAL, "ERROR: --dev tun also requires --ifconfig");
 	}
-- 
2.0.2


