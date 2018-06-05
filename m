From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Jun 2018 17:04:17 +0800
Message-Id: <20180605090421.9746-2-a@...2181...>
In-Reply-To: <20180605090421.9746-1-a@...2181...>
References: <20180605090421.9746-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be configured
 with IPv6 only
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
Cc: Antonio Quartulli <antonio@...515...>, Gert Doering <gert@...1296...>

From: Antonio Quartulli <antonio@...515...>

This change ensures that an interface is properly brought
up even when only IPv6 settings are configured.

This can be useful on a client that wants to ignore the IPv4
settings pushed by the server and configure only IPv6.
To achieve the above, a client can use
`pull-filter ignore "ifconfig "` (thanks Gert for this hint).

Trac: #208
Cc: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/tun.c | 357 ++++++++++++++++++++--------------------------
 1 file changed, 158 insertions(+), 199 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 263cacdf..2e33880b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -871,6 +871,161 @@ create_arbitrary_remote( struct tuntap *tt )
 }
 #endif
 
+/**
+ * do_ifconfig_ipv6 - perform platform specific ifconfig6 commands
+ *
+ * @param tt        the tuntap interface context
+ * @param actual    the human readable interface name
+ * @param mtu       the MTU value to set the interface to
+ * @param es        the environment to be used when executing the commands
+ * @param gc        previously allocated garbage collector
+ */
+static void
+do_ifconfig_ipv6(struct tuntap *tt, const char *actual, int tun_mtu,
+                 const struct env_set *es, struct gc_arena *gc)
+{
+    const char *ifconfig_ipv6_local = NULL;
+    struct argv argv;
+
+    if (!tt->did_ifconfig_ipv6_setup)
+    {
+        return;
+    }
+
+    argv = argv_new();
+    ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, gc);
+
+#if defined(TARGET_LINUX)
+#ifdef ENABLE_IPROUTE
+    /* set the MTU for the device and bring it up */
+    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, actual,
+                tun_mtu);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
+
+    argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path,
+                ifconfig_ipv6_local, tt->netbits_ipv6, actual);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
+#else
+    argv_printf(&argv, "%s %s add %s/%d mtu %d up", IFCONFIG_PATH, actual,
+                ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
+#endif
+#elif defined(TARGET_ANDROID)
+    char out6[64];
+
+    openvpn_snprintf(out6, sizeof(out6), "%s/%d",
+                     ifconfig_ipv6_local,tt->netbits_ipv6);
+    management_android_control(management, "IFCONFIG6", out6);
+#elif defined(TARGET_SOLARIS)
+    argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, actual);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, 0, NULL);
+
+    if (tt->type == DEV_TYPE_TUN)
+    {
+        const char *ifconfig_ipv6_remote = print_in6_addr(tt->remote_ipv6, 0,
+                                                          gc);
+
+        argv_printf(&argv, "%s %s inet6 plumb %s/%d %s mtu %d up",
+                    IFCONFIG_PATH, actual, ifconfig_ipv6_local,
+                    tt->netbits_ipv6, ifconfig_ipv6_remote, tun_mtu);
+    }
+    else /* tap mode */
+    {
+        /* base IPv6 tap interface needs to be brought up first */
+        argv_printf(&argv, "%s %s inet6 plumb up", IFCONFIG_PATH, actual);
+        argv_msg(M_INFO, &argv);
+
+        if (!openvpn_execve_check(&argv, es, 0,
+                                  "Solaris ifconfig IPv6 (prepare) failed"))
+        {
+            solaris_error_close(tt, es, actual, true);
+        }
+
+        /* we might need to do "ifconfig %s inet6 auto-dhcp drop"
+         * after the system has noticed the interface and fired up
+         * the DHCPv6 client - but this takes quite a while, and the
+         * server will ignore the DHCPv6 packets anyway.  So we don't.
+         */
+
+        /* static IPv6 addresses need to go to a subinterface (tap0:1) */
+        argv_printf(&argv, "%s %s inet6 addif %s/%d mtu %d up", IFCONFIG_PATH,
+                    actual, ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    }
+    argv_msg(M_INFO, &argv);
+
+    if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig IPv6 failed"))
+    {
+        solaris_error_close(tt, es, actual, true);
+    }
+#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
+    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX)
+    argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, actual,
+                ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    argv_msg(M_INFO, &argv);
+
+#if defined(TARGET_AIX)
+    /* AIX ifconfig will complain if it can't find ODM path in env */
+    es = env_set_create(NULL);
+    env_set_add(es, "ODMDIR=/etc/objrepos");
+#endif
+
+    openvpn_execve_check(&argv, es, S_FATAL,
+                         "generic BSD ifconfig inet6 failed");
+
+#if defined(TARGET_AIX)
+    env_set_destroy(es);
+#endif
+
+#if !defined(TARGET_FREEBSD) && !defined(TARGET_DRAGONFLY) \
+    && !defined(TARGET_AIX)
+    /* and, hooray, we explicitely need to add a route... */
+    add_route_connected_v6_net(tt, es);
+#endif
+#elif defined (_WIN32)
+    if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
+    {
+        msg(M_INFO, "******** NOTE:  Please manually set the v6 IP of '%s' to %s (if it is not already set)",
+            actual, ifconfig_ipv6_local);
+    }
+    else if (tt->options.msg_channel)
+    {
+        do_address_service(true, AF_INET6, tt);
+        do_dns6_service(true, tt);
+    }
+    else
+    {
+        /* example: netsh interface ipv6 set address interface=42
+         * 2001:608:8003::d store=active
+         */
+        char iface[64];
+
+        openvpn_snprintf(iface, sizeof(iface), "interface=%lu",
+                         tt->adapter_index);
+        argv_printf(&argv, "%s%sc interface ipv6 set address %s %s store=active",
+                    get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
+                    ifconfig_ipv6_local);
+        netsh_command(&argv, 4, M_FATAL);
+        /* set ipv6 dns servers if any are specified */
+        netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, actual);
+    }
+
+    /* explicit route needed */
+    if (tt->options.ip_win32_type != IPW32_SET_MANUAL)
+    {
+        add_route_connected_v6_net(tt, es);
+    }
+#else  /* if defined(TARGET_LINUX) */
+    msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
+#endif  /* if defined(TARGET_LINUX) */
+
+    argv_reset(&argv);
+}
+
 /* execute the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap *tt,
@@ -886,8 +1041,6 @@ do_ifconfig(struct tuntap *tt,
         const char *ifconfig_local = NULL;
         const char *ifconfig_remote_netmask = NULL;
         const char *ifconfig_broadcast = NULL;
-        const char *ifconfig_ipv6_local = NULL;
-        bool do_ipv6 = false;
         struct argv argv = argv_new();
 
         msg( M_DEBUG, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
@@ -904,12 +1057,6 @@ do_ifconfig(struct tuntap *tt,
         ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
         ifconfig_remote_netmask = print_in_addr_t(tt->remote_netmask, 0, &gc);
 
-        if (tt->did_ifconfig_ipv6_setup)
-        {
-            ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
-            do_ipv6 = true;
-        }
-
         /*
          * If TAP-style device, generate broadcast address.
          */
@@ -975,18 +1122,6 @@ do_ifconfig(struct tuntap *tt,
             argv_msg(M_INFO, &argv);
             openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
         }
-        if (do_ipv6)
-        {
-            argv_printf( &argv,
-                         "%s -6 addr add %s/%d dev %s",
-                         iproute_path,
-                         ifconfig_ipv6_local,
-                         tt->netbits_ipv6,
-                         actual
-                         );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
-        }
         tt->did_ifconfig = true;
 #else  /* ifdef ENABLE_IPROUTE */
         if (tun)
@@ -1014,30 +1149,10 @@ do_ifconfig(struct tuntap *tt,
         }
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig failed");
-        if (do_ipv6)
-        {
-            argv_printf(&argv,
-                        "%s %s add %s/%d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_ipv6_local,
-                        tt->netbits_ipv6
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
-        }
         tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
-
-        if (do_ipv6)
-        {
-            char out6[64];
-            openvpn_snprintf(out6, sizeof(out6), "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
-            management_android_control(management, "IFCONFIG6", out6);
-        }
-
         char out[64];
 
         char *top;
@@ -1120,59 +1235,6 @@ do_ifconfig(struct tuntap *tt,
             solaris_error_close(tt, es, actual, false);
         }
 
-        if (do_ipv6)
-        {
-            argv_printf(&argv, "%s %s inet6 unplumb",
-                        IFCONFIG_PATH, actual );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, 0, NULL);
-
-            if (tt->type == DEV_TYPE_TUN)
-            {
-                const char *ifconfig_ipv6_remote =
-                    print_in6_addr(tt->remote_ipv6, 0, &gc);
-
-                argv_printf(&argv,
-                            "%s %s inet6 plumb %s/%d %s up",
-                            IFCONFIG_PATH,
-                            actual,
-                            ifconfig_ipv6_local,
-                            tt->netbits_ipv6,
-                            ifconfig_ipv6_remote
-                            );
-            }
-            else                                        /* tap mode */
-            {
-                /* base IPv6 tap interface needs to be brought up first
-                 */
-                argv_printf(&argv, "%s %s inet6 plumb up",
-                            IFCONFIG_PATH, actual );
-                argv_msg(M_INFO, &argv);
-                if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig IPv6 (prepare) failed"))
-                {
-                    solaris_error_close(tt, es, actual, true);
-                }
-
-                /* we might need to do "ifconfig %s inet6 auto-dhcp drop"
-                 * after the system has noticed the interface and fired up
-                 * the DHCPv6 client - but this takes quite a while, and the
-                 * server will ignore the DHCPv6 packets anyway.  So we don't.
-                 */
-
-                /* static IPv6 addresses need to go to a subinterface (tap0:1)
-                 */
-                argv_printf(&argv,
-                            "%s %s inet6 addif %s/%d up",
-                            IFCONFIG_PATH, actual,
-                            ifconfig_ipv6_local, tt->netbits_ipv6 );
-            }
-            argv_msg(M_INFO, &argv);
-            if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig IPv6 failed"))
-            {
-                solaris_error_close(tt, es, actual, true);
-            }
-        }
-
         if (!tun && tt->topology == TOP_SUBNET)
         {
             /* Add a network route for the local tun interface */
@@ -1250,21 +1312,6 @@ do_ifconfig(struct tuntap *tt,
             add_route(&r, tt, 0, NULL, es);
         }
 
-        if (do_ipv6)
-        {
-            argv_printf(&argv,
-                        "%s %s inet6 %s/%d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_ipv6_local,
-                        tt->netbits_ipv6
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig inet6 failed");
-
-            /* and, hooray, we explicitely need to add a route... */
-            add_route_connected_v6_net(tt, es);
-        }
         tt->did_ifconfig = true;
 
 #elif defined(TARGET_NETBSD)
@@ -1312,21 +1359,6 @@ do_ifconfig(struct tuntap *tt,
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
-        if (do_ipv6)
-        {
-            argv_printf(&argv,
-                        "%s %s inet6 %s/%d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_ipv6_local,
-                        tt->netbits_ipv6
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig inet6 failed");
-
-            /* and, hooray, we explicitely need to add a route... */
-            add_route_connected_v6_net(tt, es);
-        }
         tt->did_ifconfig = true;
 
 #elif defined(TARGET_DARWIN)
@@ -1398,22 +1430,6 @@ do_ifconfig(struct tuntap *tt,
             add_route(&r, tt, 0, NULL, es);
         }
 
-        if (do_ipv6)
-        {
-            argv_printf(&argv,
-                        "%s %s inet6 %s/%d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_ipv6_local,
-                        tt->netbits_ipv6
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "MacOS X ifconfig inet6 failed");
-
-            /* and, hooray, we explicitely need to add a route... */
-            add_route_connected_v6_net(tt, es);
-        }
-
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
         in_addr_t remote_end;           /* for "virtual" subnet topology */
@@ -1471,19 +1487,6 @@ do_ifconfig(struct tuntap *tt,
             add_route(&r, tt, 0, NULL, es);
         }
 
-        if (do_ipv6)
-        {
-            argv_printf(&argv,
-                        "%s %s inet6 %s/%d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_ipv6_local,
-                        tt->netbits_ipv6
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig inet6 failed");
-        }
-
 #elif defined(TARGET_AIX)
         {
             /* AIX ifconfig will complain if it can't find ODM path in env */
@@ -1509,18 +1512,6 @@ do_ifconfig(struct tuntap *tt,
             openvpn_execve_check(&argv, aix_es, S_FATAL, "AIX ifconfig failed");
             tt->did_ifconfig = true;
 
-            if (do_ipv6)
-            {
-                argv_printf(&argv,
-                            "%s %s inet6 %s/%d",
-                            IFCONFIG_PATH,
-                            actual,
-                            ifconfig_ipv6_local,
-                            tt->netbits_ipv6
-                            );
-                argv_msg(M_INFO, &argv);
-                openvpn_execve_check(&argv, aix_es, S_FATAL, "AIX ifconfig inet6 failed");
-            }
             env_set_destroy(aix_es);
         }
 #elif defined (_WIN32)
@@ -1548,46 +1539,14 @@ do_ifconfig(struct tuntap *tt,
             tt->did_ifconfig = true;
         }
 
-        if (do_ipv6)
-        {
-            if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
-            {
-                msg(M_INFO, "******** NOTE:  Please manually set the v6 IP of '%s' to %s (if it is not already set)",
-                    actual,
-                    ifconfig_ipv6_local);
-            }
-            else if (tt->options.msg_channel)
-            {
-                do_address_service(true, AF_INET6, tt);
-                do_dns6_service(true, tt);
-            }
-            else
-            {
-                /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
-                char iface[64];
-                openvpn_snprintf(iface, sizeof(iface), "interface=%lu", tt->adapter_index );
-                argv_printf(&argv,
-                            "%s%sc interface ipv6 set address %s %s store=active",
-                            get_win_sys_path(),
-                            NETSH_PATH_SUFFIX,
-                            iface,
-                            ifconfig_ipv6_local );
-                netsh_command(&argv, 4, M_FATAL);
-                /* set ipv6 dns servers if any are specified */
-                netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, actual);
-            }
-
-            /* explicit route needed */
-            if (tt->options.ip_win32_type != IPW32_SET_MANUAL)
-            {
-                add_route_connected_v6_net(tt, es);
-            }
-        }
 #else  /* if defined(TARGET_LINUX) */
         msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
         argv_reset(&argv);
     }
+
+    do_ifconfig_ipv6(tt, actual, tun_mtu, es, &gc);
+
     gc_free(&gc);
 }
 
-- 
2.17.1


