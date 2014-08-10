From: Gavin Shrubbery <gavin.shrubbery@...277...>
Date: Mon, 11 Aug 2014 09:45:08 +1200
Message-Id: <1407707108-16310-1-git-send-email-gavin.shrubbery@...277...>
In-Reply-To: <20140808095617.GY1118@...1296...>
References: <20140808095617.GY1118@...1296...>
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
---
 src/openvpn/tun.c | 366 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 188 insertions(+), 178 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e92edc2..927b6e8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -642,16 +642,10 @@ do_ifconfig (struct tuntap *tt,
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
@@ -663,13 +657,6 @@ do_ifconfig (struct tuntap *tt,
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
@@ -728,18 +715,6 @@ do_ifconfig (struct tuntap *tt,
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
       tt->did_ifconfig = true;
 #else
       if (tun)
@@ -763,29 +738,10 @@ do_ifconfig (struct tuntap *tt,
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
       tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
-
-      if (do_ipv6) {
-          struct buffer out6 = alloc_buf_gc (64, &gc);
-          buf_printf (&out6, "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
-          management_android_control(management, "IFCONFIG6",buf_bptr(&out6));
-      }
-
       struct buffer out = alloc_buf_gc (64, &gc);
 
       char* top;
@@ -860,52 +816,6 @@ do_ifconfig (struct tuntap *tt,
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
@@ -964,32 +874,9 @@ do_ifconfig (struct tuntap *tt,
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
-
-	  /* and, hooray, we explicitely need to add a route... */
-	  add_route_connected_v6_net(tt, es);
-	}
       tt->did_ifconfig = true;
 
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
@@ -1030,26 +917,6 @@ do_ifconfig (struct tuntap *tt,
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
@@ -1115,22 +982,6 @@ do_ifconfig (struct tuntap *tt,
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
@@ -1181,19 +1032,6 @@ do_ifconfig (struct tuntap *tt,
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
 #elif defined(TARGET_AIX)
       {
 	/* AIX ifconfig will complain if it can't find ODM path in env */
@@ -1216,19 +1054,6 @@ do_ifconfig (struct tuntap *tt,
 	argv_msg (M_INFO, &argv);
 	openvpn_execve_check (&argv, aix_es, S_FATAL, "AIX ifconfig failed");
 	tt->did_ifconfig = true;
-
-	if ( do_ipv6 )
-	  {
-	    argv_printf (&argv,
-				"%s %s inet6 %s/%d",
-				IFCONFIG_PATH,
-				actual,
-				ifconfig_ipv6_local,
-				tt->netbits_ipv6
-				);
-	    argv_msg (M_INFO, &argv);
-	    openvpn_execve_check (&argv, aix_es, S_FATAL, "AIX ifconfig inet6 failed");
-	  }
 	env_set_destroy (aix_es);
       }
 #elif defined (WIN32)
@@ -1270,8 +1095,193 @@ do_ifconfig (struct tuntap *tt,
 	tt->did_ifconfig = true;
       }
 
-    /* IPv6 always uses "netsh" interface */
-    if ( do_ipv6 )
+#else
+      msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
+#endif
+      argv_reset (&argv);
+
+}
+
+
+  if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
+  {
+      const char *ifconfig_ipv6_local = NULL;
+      const char *ifconfig_ipv6_remote = NULL;
+      struct argv argv;
+
+      argv_init (&argv);
+
+      msg( M_INFO, "do_ifconfig, tt->ipv6=%d, tt->did_ifconfig_ipv6_setup=%d",
+	           tt->ipv6, tt->did_ifconfig_ipv6_setup );
+
+      ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
+      ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
+
+
+#if defined(TARGET_LINUX)
+#ifdef ENABLE_IPROUTE
+      argv_printf( &argv,
+		  "%s -6 addr add %s/%d dev %s",
+		  iproute_path,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6,
+		  actual
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr add failed");
+      tt->did_ifconfig = true;
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
+      tt->did_ifconfig = true;
+
+#endif /*ENABLE_IPROUTE*/
+#elif defined(TARGET_ANDROID)
+      struct buffer out6 = alloc_buf_gc (64, &gc);
+      buf_printf (&out6, "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
+      management_android_control(management, "IFCONFIG6",buf_bptr(&out6));
+
+#elif defined(TARGET_SOLARIS)
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
+      tt->did_ifconfig = true;
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
+#endif
+
+#elif defined(TARGET_DARWIN)
+      /*
+       * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour to OpenBSD...
+       */
+
+      argv_printf (&argv,
+		  "%s %s inet6 %s/%d",
+		  IFCONFIG_PATH,
+		  actual,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "MacOS X ifconfig inet6 failed");
+
+      /* and, hooray, we explicitely need to add a route... */
+      add_route_connected_v6_net(tt, es);
+
+#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+
+      argv_printf (&argv,
+		  "%s %s inet6 %s/%d",
+		  IFCONFIG_PATH,
+		  actual,
+		  ifconfig_ipv6_local,
+		  tt->netbits_ipv6
+		  );
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig inet6 failed");
+
+#elif defined(TARGET_AIX)
+      {
+	/* AIX ifconfig will complain if it can't find ODM path in env */
+	struct env_set *aix_es = env_set_create (NULL);
+	env_set_add( aix_es, "ODMDIR=/etc/objrepos" );
+
+	argv_printf (&argv,
+		    "%s %s inet6 %s/%d",
+		    IFCONFIG_PATH,
+		    actual,
+		    ifconfig_ipv6_local,
+		    tt->netbits_ipv6
+		    );
+	argv_msg (M_INFO, &argv);
+	openvpn_execve_check (&argv, aix_es, S_FATAL, "AIX ifconfig inet6 failed");
+	env_set_destroy (aix_es);
+      }
+#elif defined (WIN32)
+      /* IPv6 always uses "netsh" interface */
       {
 	char * saved_actual;
 
@@ -5211,7 +5221,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
   if (tt->type == DEV_TYPE_TUN)
     {
-      if (!tt->did_ifconfig_setup)
+      if (!(tt->did_ifconfig_setup || tt->did_ifconfig_ipv6_setup))
 	{
 	  msg (M_FATAL, "ERROR: --dev tun also requires --ifconfig");
 	}
-- 
2.0.2


