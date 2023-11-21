From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Nov 2023 11:13:59 +0100
Message-Id: <20231121101359.13827-1-frank@...2641...>
In-Reply-To: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
References: <gerrit.1699291967000.Ice8b95f953c3f7e71657a78ea12b02a08c60aa67@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tun: use is_tun_p2p more consistently
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne-openvpn@...1227...>

Using "tun" as the variable name for the return of
is_tun_p2p is probably a historical accident. But
it has actual consequences in that the other code
often seems to assume that it does less checks
than it actually does.

Use "tun_p2p" as the variable name and remove checks
that are not required. Also use is_tun_p2p in more
places.

Change-Id: Ice8b95f953c3f7e71657a78ea12b02a08c60aa67
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/380
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 82ab6c0..7ab51ee 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -507,31 +507,31 @@
 static const char ifconfig_warn_how_to_silence[] = "(silence this warning with --ifconfig-nowarn)";
 
 /*
- * If !tun, make sure ifconfig_remote_netmask looks
+ * If !tun_p2p, make sure ifconfig_remote_netmask looks
  *  like a netmask.
  *
- * If tun, make sure ifconfig_remote_netmask looks
+ * If tun_p2p, make sure ifconfig_remote_netmask looks
  *  like an IPv4 address.
  */
 static void
-ifconfig_sanity_check(bool tun, in_addr_t addr, int topology)
+ifconfig_sanity_check(bool tun_p2p, in_addr_t addr)
 {
     struct gc_arena gc = gc_new();
     const bool looks_like_netmask = ((addr & 0xFF000000) == 0xFF000000);
-    if (tun)
+    if (tun_p2p)
     {
-        if (looks_like_netmask && (topology == TOP_NET30 || topology == TOP_P2P))
+        if (looks_like_netmask)
         {
             msg(M_WARN, "WARNING: Since you are using --dev tun with a point-to-point topology, the second argument to --ifconfig must be an IP address.  You are using something (%s) that looks more like a netmask. %s",
                 print_in_addr_t(addr, 0, &gc),
                 ifconfig_warn_how_to_silence);
         }
     }
-    else /* tap */
+    else
     {
         if (!looks_like_netmask)
         {
-            msg(M_WARN, "WARNING: Since you are using --dev tap, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0. %s",
+            msg(M_WARN, "WARNING: Since you are using subnet topology, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0. %s",
                 ifconfig_warn_how_to_silence);
         }
     }
@@ -675,13 +675,13 @@
     struct buffer out = alloc_buf_gc(256, gc);
     if (tt->did_ifconfig_setup && !disable)
     {
-        if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
+        if (!is_tun_p2p(tt))
         {
             buf_printf(&out, "%s %s",
                        print_in_addr_t(tt->local & tt->remote_netmask, 0, gc),
                        print_in_addr_t(tt->remote_netmask, 0, gc));
         }
-        else if (tt->type == DEV_TYPE_TUN)
+        else if (tt->type == DEV_TYPE_TUN) /* tun p2p topology */
         {
             const char *l, *r;
             if (remote)
@@ -745,24 +745,24 @@
 bool
 is_tun_p2p(const struct tuntap *tt)
 {
-    bool tun = false;
+    bool tun_p2p = false;
 
     if (tt->type == DEV_TYPE_TAP
         || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         || tt->type == DEV_TYPE_NULL)
     {
-        tun = false;
+        tun_p2p = false;
     }
     else if (tt->type == DEV_TYPE_TUN)
     {
-        tun = true;
+        tun_p2p = true;
     }
     else
     {
         msg(M_FATAL, "Error: problem with tun vs. tap setting"); /* JYFIXME -- needs to be caught earlier, in init_tun? */
 
     }
-    return tun;
+    return tun_p2p;
 }
 
 /*
@@ -839,12 +839,10 @@
 
     if (ifconfig_local_parm && ifconfig_remote_netmask_parm)
     {
-        bool tun = false;
-
         /*
          * We only handle TUN/TAP devices here, not --dev null devices.
          */
-        tun = is_tun_p2p(tt);
+        bool tun_p2p = is_tun_p2p(tt);
 
         /*
          * Convert arguments to binary IPv4 addresses.
@@ -861,7 +859,7 @@
             NULL);
 
         tt->remote_netmask = getaddr(
-            (tun ? GETADDR_RESOLVE : 0)
+            (tun_p2p ? GETADDR_RESOLVE : 0)
             | GETADDR_HOST_ORDER
             | GETADDR_FATAL_ON_SIGNAL
             | GETADDR_FATAL,
@@ -876,7 +874,7 @@
         if (strict_warn)
         {
             struct addrinfo *curele;
-            ifconfig_sanity_check(tt->type == DEV_TYPE_TUN, tt->remote_netmask, tt->topology);
+            ifconfig_sanity_check(tun_p2p, tt->remote_netmask);
 
             /*
              * If local_public or remote_public addresses are defined,
@@ -907,11 +905,11 @@
                 }
             }
 
-            if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
+            if (!tun_p2p)
             {
                 check_subnet_conflict(tt->local, tt->remote_netmask, "TUN/TAP adapter");
             }
-            else if (tt->type == DEV_TYPE_TUN)
+            else
             {
                 check_subnet_conflict(tt->local, IPV4_NETMASK_HOST, "TUN/TAP adapter");
             }
@@ -922,7 +920,7 @@
          * Make sure that both ifconfig addresses are part of the
          * same .252 subnet.
          */
-        if (tun)
+        if (tun_p2p)
         {
             verify_255_255_255_252(tt->local, tt->remote_netmask);
             tt->adapter_netmask = ~3;
@@ -1305,7 +1303,7 @@
     /*
      * We only handle TUN/TAP devices here, not --dev null devices.
      */
-    bool tun = is_tun_p2p(tt);
+    bool tun_p2p = is_tun_p2p(tt);
 #endif
 
 #if !defined(TARGET_LINUX)
@@ -1332,7 +1330,7 @@
         msg(M_FATAL, "Linux can't bring %s up", ifname);
     }
 
-    if (tun)
+    if (tun_p2p)
     {
         if (net_addr_ptp_v4_add(ctx, ifname, &tt->local,
                                 &tt->remote_netmask) < 0)
@@ -1351,27 +1349,8 @@
 #elif defined(TARGET_ANDROID)
     char out[64];
 
-    char *top;
-    switch (tt->topology)
-    {
-        case TOP_NET30:
-            top = "net30";
-            break;
-
-        case TOP_P2P:
-            top = "p2p";
-            break;
-
-        case TOP_SUBNET:
-            top = "subnet";
-            break;
-
-        default:
-            top = "undef";
-    }
-
     openvpn_snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
-                     ifconfig_remote_netmask, tun_mtu, top);
+                     ifconfig_remote_netmask, tun_mtu, print_topology(tt->topology));
     management_android_control(management, "IFCONFIG", out);
 
 #elif defined(TARGET_SOLARIS)
@@ -1380,7 +1359,7 @@
      *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
      *    ifconfig tun2 netmask 255.255.255.255
      */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d up", IFCONFIG_PATH, ifname,
                     ifconfig_local, ifconfig_remote_netmask, tun_mtu);
@@ -1394,13 +1373,13 @@
         argv_printf(&argv, "%s %s netmask 255.255.255.255", IFCONFIG_PATH,
                     ifname);
     }
-    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN)
     {
         argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
                     ifname, ifconfig_local, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else
+    else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1413,7 +1392,7 @@
         solaris_error_close(tt, es, ifname, false);
     }
 
-    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    if (!tun_p2p && tt->type == DEV_TYPE_TUN)
     {
         /* Add a network route for the local tun interface */
         struct route_ipv4 r;
@@ -1437,14 +1416,14 @@
      */
 
     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv,
                     "%s %s %s %s mtu %d netmask 255.255.255.255 up -link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN)
     {
         remote_end = create_arbitrary_remote( tt );
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up -link0",
@@ -1452,7 +1431,7 @@
                     print_in_addr_t(remote_end, 0, &gc), tun_mtu,
                     ifconfig_remote_netmask);
     }
-    else
+    else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s mtu %d link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1462,7 +1441,7 @@
     openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    if (!tun_p2p && tt->type == DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1476,20 +1455,20 @@
 #elif defined(TARGET_NETBSD)
     in_addr_t remote_end = INADDR_ANY;  /* for "virtual" subnet topology */
 
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN)
     {
         remote_end = create_arbitrary_remote(tt);
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PATH,
                     ifname, ifconfig_local, print_in_addr_t(remote_end, 0, &gc),
                     tun_mtu, ifconfig_remote_netmask);
     }
-    else
+    else /* tap */
     {
         /*
          * NetBSD has distinct tun and tap devices
@@ -1504,7 +1483,7 @@
     openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    if (!tun_p2p && tt->type == DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1528,33 +1507,30 @@
 
 
     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-    if (tun)
+    if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else
+    else if (tt->type == DEV_TYPE_TUN)
     {
-        if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
-        {
-            argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
-                        IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,
-                        ifconfig_remote_netmask, tun_mtu);
-        }
-        else
-        {
-            argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
-                        ifname, ifconfig_local, ifconfig_remote_netmask,
-                        tun_mtu);
-        }
+        argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
+                    IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else /* tap */
+    {
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_remote_netmask,
+                    tun_mtu);
     }
 
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "Mac OS X ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+    if (!tun_p2p && tt->type == DEV_TYPE_TUN)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1568,7 +1544,7 @@
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-    if (tun)       /* point-to-point tun */
+    if (tun_p2p)    /* point-to-point tun */
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
@@ -1590,7 +1566,7 @@
         struct env_set *aix_es = env_set_create(NULL);
         env_set_add( aix_es, "ODMDIR=/etc/objrepos" );
 
-        if (tun)
+        if (tt->type == DEV_TYPE_TUN)
         {
             msg(M_FATAL, "no tun support on AIX (canthappen)");
         }

