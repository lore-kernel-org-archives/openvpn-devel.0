From: Antonio Quartulli <a@...2181...>
Date: Tue, 12 Jun 2018 15:42:40 +0800
Message-Id: <20180612074240.18865-1-a@...2181...>
In-Reply-To: <20180608052017.6696-2-a@...2181...>
References: <20180608052017.6696-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH v3] tun: ensure interface can be configured
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
up even when only IPv6 settings are configured/pushed.

At the same time, the do_ifconfig() function has been rearranged by
splitting the logic into a v4 and a v6 specific part. Each part has
then been moved into an idependent helper that can be invoked as
needed.

This makes the code easier to read and more "symmetric" with
respect to the two address families.

Trac: #208
Cc: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <antonio@...515...>

---

Changes from v2:
- rebased on top of master (fix conflict about D_LOW)
- commit message improved

 src/openvpn/tun.c | 1118 ++++++++++++++++++++-------------------------
 src/openvpn/tun.h |   12 +-
 2 files changed, 492 insertions(+), 638 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3eb0f78a..2a08cf2c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -871,724 +871,572 @@ create_arbitrary_remote( struct tuntap *tt )
 }
 #endif
 
-/* execute the ifconfig command through the shell */
-void
-do_ifconfig(struct tuntap *tt,
-            const char *actual,     /* actual device name */
-            int tun_mtu,
-            const struct env_set *es)
+/**
+ * do_ifconfig_ipv6 - perform platform specific ifconfig6 commands
+ *
+ * @param tt        the tuntap interface context
+ * @param ifname    the human readable interface name
+ * @param mtu       the MTU value to set the interface to
+ * @param es        the environment to be used when executing the commands
+ */
+static void
+do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
+                 const struct env_set *es)
 {
+    const char *ifconfig_ipv6_local = NULL;
+    struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
 
-    if (tt->did_ifconfig_setup)
-    {
-        bool tun = false;
-        const char *ifconfig_local = NULL;
-        const char *ifconfig_remote_netmask = NULL;
-        const char *ifconfig_broadcast = NULL;
-        const char *ifconfig_ipv6_local = NULL;
-        bool do_ipv6 = false;
-        struct argv argv = argv_new();
+    ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
 
-        msg( D_LOW, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
-             tt->did_ifconfig_ipv6_setup );
+#if defined(TARGET_LINUX)
+#ifdef ENABLE_IPROUTE
+    /* set the MTU for the device and bring it up */
+    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, ifname,
+                tun_mtu);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
 
-        /*
-         * We only handle TUN/TAP devices here, not --dev null devices.
-         */
-        tun = is_tun_p2p(tt);
+    argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path,
+                ifconfig_ipv6_local, tt->netbits_ipv6, ifname);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
+#else
+    argv_printf(&argv, "%s %s add %s/%d mtu %d up", IFCONFIG_PATH, ifname,
+                ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
+#endif
+#elif defined(TARGET_ANDROID)
+    char out6[64];
 
-        /*
-         * Set ifconfig parameters
-         */
-        ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
-        ifconfig_remote_netmask = print_in_addr_t(tt->remote_netmask, 0, &gc);
+    openvpn_snprintf(out6, sizeof(out6), "%s/%d",
+                     ifconfig_ipv6_local,tt->netbits_ipv6);
+    management_android_control(management, "IFCONFIG6", out6);
+#elif defined(TARGET_SOLARIS)
+    argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, ifname);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, 0, NULL);
 
-        if (tt->did_ifconfig_ipv6_setup)
+    if (tt->type == DEV_TYPE_TUN)
+    {
+        const char *ifconfig_ipv6_remote = print_in6_addr(tt->remote_ipv6, 0,
+                                                          gc);
+
+        argv_printf(&argv, "%s %s inet6 plumb %s/%d %s mtu %d up",
+                    IFCONFIG_PATH, ifname, ifconfig_ipv6_local,
+                    tt->netbits_ipv6, ifconfig_ipv6_remote, tun_mtu);
+    }
+    else /* tap mode */
+    {
+        /* base IPv6 tap interface needs to be brought up first */
+        argv_printf(&argv, "%s %s inet6 plumb up", IFCONFIG_PATH, ifname);
+        argv_msg(M_INFO, &argv);
+
+        if (!openvpn_execve_check(&argv, es, 0,
+                                  "Solaris ifconfig IPv6 (prepare) failed"))
         {
-            ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
-            do_ipv6 = true;
+            solaris_error_close(tt, es, ifname, true);
         }
 
-        /*
-         * If TAP-style device, generate broadcast address.
+        /* we might need to do "ifconfig %s inet6 auto-dhcp drop"
+         * after the system has noticed the interface and fired up
+         * the DHCPv6 client - but this takes quite a while, and the
+         * server will ignore the DHCPv6 packets anyway.  So we don't.
          */
-        if (!tun)
-        {
-            ifconfig_broadcast = print_in_addr_t(tt->broadcast, 0, &gc);
-        }
 
-#ifdef ENABLE_MANAGEMENT
-        if (management)
-        {
-            management_set_state(management,
-                                 OPENVPN_STATE_ASSIGN_IP,
-                                 NULL,
-                                 &tt->local,
-                                 &tt->local_ipv6,
-                                 NULL,
-                                 NULL);
-        }
+        /* static IPv6 addresses need to go to a subinterface (tap0:1) */
+        argv_printf(&argv, "%s %s inet6 addif %s/%d mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    }
+    argv_msg(M_INFO, &argv);
+
+    if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig IPv6 failed"))
+    {
+        solaris_error_close(tt, es, ifname, true);
+    }
+#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
+    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX)
+    argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname,
+                ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    argv_msg(M_INFO, &argv);
+
+#if defined(TARGET_AIX)
+    /* AIX ifconfig will complain if it can't find ODM path in env */
+    es = env_set_create(NULL);
+    env_set_add(es, "ODMDIR=/etc/objrepos");
 #endif
 
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
+            ifname, ifconfig_ipv6_local);
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
+        netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
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
+    gc_free(&gc);
+    argv_reset(&argv);
+}
+
+/**
+ * do_ifconfig_ipv4 - perform platform specific ifconfig commands
+ *
+ * @param tt        the tuntap interface context
+ * @param ifname    the human readable interface name
+ * @param mtu       the MTU value to set the interface to
+ * @param es        the environment to be used when executing the commands
+ */
+static void
+do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
+                 const struct env_set *es)
+{
+    bool tun = false;
+    const char *ifconfig_local = NULL;
+    const char *ifconfig_remote_netmask = NULL;
+    const char *ifconfig_broadcast = NULL;
+    struct argv argv = argv_new();
+    struct gc_arena gc = gc_new();
+
+    /*
+     * We only handle TUN/TAP devices here, not --dev null devices.
+     */
+    tun = is_tun_p2p(tt);
+
+    /*
+     * Set ifconfig parameters
+     */
+    ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
+    ifconfig_remote_netmask = print_in_addr_t(tt->remote_netmask, 0, &gc);
+
+    /*
+     * If TAP-style device, generate broadcast address.
+     */
+    if (!tun)
+    {
+        ifconfig_broadcast = print_in_addr_t(tt->broadcast, 0, &gc);
+    }
 
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
+    /*
+     * Set the MTU for the device
+     */
+    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, ifname,
+                tun_mtu);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
+
+    if (tun)
+    {
+
         /*
-         * Set the MTU for the device
+         * Set the address for the device
          */
-        argv_printf(&argv,
-                    "%s link set dev %s up mtu %d",
-                    iproute_path,
-                    actual,
-                    tun_mtu
-                    );
+        argv_printf(&argv, "%s addr add dev %s local %s peer %s", iproute_path,
+                    ifname, ifconfig_local, ifconfig_remote_netmask);
         argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
-
-        if (tun)
-        {
-
-            /*
-             * Set the address for the device
-             */
-            argv_printf(&argv,
-                        "%s addr add dev %s local %s peer %s",
-                        iproute_path,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
-        }
-        else
-        {
-            argv_printf(&argv,
-                        "%s addr add dev %s %s/%d broadcast %s",
-                        iproute_path,
-                        actual,
-                        ifconfig_local,
-                        netmask_to_netbits2(tt->remote_netmask),
-                        ifconfig_broadcast
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
-        }
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
-        tt->did_ifconfig = true;
-#else  /* ifdef ENABLE_IPROUTE */
-        if (tun)
-        {
-            argv_printf(&argv,
-                        "%s %s %s pointopoint %s mtu %d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-        }
-        else
-        {
-            argv_printf(&argv,
-                        "%s %s %s netmask %s mtu %d broadcast %s",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu,
-                        ifconfig_broadcast
-                        );
-        }
+        openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
+    }
+    else
+    {
+        argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s",
+                    iproute_path, ifname, ifconfig_local,
+                    netmask_to_netbits2(tt->remote_netmask),
+                    ifconfig_broadcast);
         argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig failed");
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
-        tt->did_ifconfig = true;
+        openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
+    }
+    tt->did_ifconfig = true;
+#else  /* ifdef ENABLE_IPROUTE */
+    if (tun)
+    {
+        argv_printf(&argv, "%s %s %s pointopoint %s mtu %d", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d broadcast %s",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu, ifconfig_broadcast);
+    }
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig failed");
+    tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
+    char out[64];
 
-        if (do_ipv6)
-        {
-            char out6[64];
-            openvpn_snprintf(out6, sizeof(out6), "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
-            management_android_control(management, "IFCONFIG6", out6);
-        }
-
-        char out[64];
-
-        char *top;
-        switch (tt->topology)
-        {
-            case TOP_NET30:
-                top = "net30";
-                break;
+    char *top;
+    switch (tt->topology)
+    {
+        case TOP_NET30:
+            top = "net30";
+            break;
 
-            case TOP_P2P:
-                top = "p2p";
-                break;
+        case TOP_P2P:
+            top = "p2p";
+            break;
 
-            case TOP_SUBNET:
-                top = "subnet";
-                break;
+        case TOP_SUBNET:
+            top = "subnet";
+            break;
 
-            default:
-                top = "undef";
-        }
+        default:
+            top = "undef";
+    }
 
-        openvpn_snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local, ifconfig_remote_netmask, tun_mtu, top);
-        management_android_control(management, "IFCONFIG", out);
+    openvpn_snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
+                     ifconfig_remote_netmask, tun_mtu, top);
+    management_android_control(management, "IFCONFIG", out);
 
 #elif defined(TARGET_SOLARIS)
-        /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
-         * example:
-         *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
-         *    ifconfig tun2 netmask 255.255.255.255
-         */
-        if (tun)
-        {
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-
-            argv_msg(M_INFO, &argv);
-            if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig phase-1 failed"))
-            {
-                solaris_error_close(tt, es, actual, false);
-            }
-
-            argv_printf(&argv,
-                        "%s %s netmask 255.255.255.255",
-                        IFCONFIG_PATH,
-                        actual
-                        );
-        }
-        else if (tt->topology == TOP_SUBNET)
-        {
-            argv_printf(&argv,
-                        "%s %s %s %s netmask %s mtu %d up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-        }
-        else
-        {
-            argv_printf(&argv,
-                        " %s %s %s netmask %s broadcast + up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask
-                        );
-        }
+    /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
+     * example:
+     *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
+     *    ifconfig tun2 netmask 255.255.255.255
+     */
+    if (tun)
+    {
+        argv_printf(&argv, "%s %s %s %s mtu %d up", IFCONFIG_PATH, ifname,
+                    ifconfig_local, ifconfig_remote_netmask, tun_mtu);
 
         argv_msg(M_INFO, &argv);
-        if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig phase-2 failed"))
+        if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig phase-1 failed"))
         {
-            solaris_error_close(tt, es, actual, false);
+            solaris_error_close(tt, es, ifname, false);
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
+        argv_printf(&argv, "%s %s netmask 255.255.255.255", IFCONFIG_PATH,
+                    ifname);
+    }
+    else if (tt->topology == TOP_SUBNET)
+    {
+        argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s %s netmask %s broadcast + up",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask);
+    }
 
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
+    argv_msg(M_INFO, &argv);
+    if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig phase-2 failed"))
+    {
+        solaris_error_close(tt, es, ifname, false);
+    }
 
-        if (!tun && tt->topology == TOP_SUBNET)
-        {
-            /* Add a network route for the local tun interface */
-            struct route_ipv4 r;
-            CLEAR(r);
-            r.flags = RT_DEFINED | RT_METRIC_DEFINED;
-            r.network = tt->local & tt->remote_netmask;
-            r.netmask = tt->remote_netmask;
-            r.gateway = tt->local;
-            r.metric = 0;
-            add_route(&r, tt, 0, NULL, es);
-        }
+    if (!tun && tt->topology == TOP_SUBNET)
+    {
+        /* Add a network route for the local tun interface */
+        struct route_ipv4 r;
+        CLEAR(r);
+        r.flags = RT_DEFINED | RT_METRIC_DEFINED;
+        r.network = tt->local & tt->remote_netmask;
+        r.netmask = tt->remote_netmask;
+        r.gateway = tt->local;
+        r.metric = 0;
+        add_route(&r, tt, 0, NULL, es);
+    }
 
-        tt->did_ifconfig = true;
+    tt->did_ifconfig = true;
 
 #elif defined(TARGET_OPENBSD)
 
-        in_addr_t remote_end;           /* for "virtual" subnet topology */
+    in_addr_t remote_end;           /* for "virtual" subnet topology */
 
-        /*
-         * On OpenBSD, tun interfaces are persistent if created with
-         * "ifconfig tunX create", and auto-destroyed if created by
-         * opening "/dev/tunX" (so we just use the /dev/tunX)
-         */
-
-        /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-        if (tun)
-        {
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask 255.255.255.255 up -link0",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-        }
-        else if (tt->topology == TOP_SUBNET)
-        {
-            remote_end = create_arbitrary_remote( tt );
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask %s up -link0",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        print_in_addr_t(remote_end, 0, &gc),
-                        tun_mtu,
-                        ifconfig_remote_netmask
-                        );
-        }
-        else
-        {
-            argv_printf(&argv,
-                        "%s %s %s netmask %s mtu %d broadcast %s link0",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu,
-                        ifconfig_broadcast
-                        );
-        }
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
+    /*
+     * On OpenBSD, tun interfaces are persistent if created with
+     * "ifconfig tunX create", and auto-destroyed if created by
+     * opening "/dev/tunX" (so we just use the /dev/tunX)
+     */
 
-        /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
-        {
-            struct route_ipv4 r;
-            CLEAR(r);
-            r.flags = RT_DEFINED;
-            r.network = tt->local & tt->remote_netmask;
-            r.netmask = tt->remote_netmask;
-            r.gateway = remote_end;
-            add_route(&r, tt, 0, NULL, es);
-        }
+    /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
+    if (tun)
+    {
+        argv_printf(&argv,
+                    "%s %s %s %s mtu %d netmask 255.255.255.255 up -link0",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else if (tt->topology == TOP_SUBNET)
+    {
+        remote_end = create_arbitrary_remote( tt );
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up -link0",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    print_in_addr_t(remote_end, 0, &gc), tun_mtu,
+                    ifconfig_remote_netmask);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d broadcast %s link0",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu, ifconfig_broadcast);
+    }
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
 
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
+    /* Add a network route for the local tun interface */
+    if (!tun && tt->topology == TOP_SUBNET)
+    {
+        struct route_ipv4 r;
+        CLEAR(r);
+        r.flags = RT_DEFINED;
+        r.network = tt->local & tt->remote_netmask;
+        r.netmask = tt->remote_netmask;
+        r.gateway = remote_end;
+        add_route(&r, tt, 0, NULL, es);
+    }
 
-            /* and, hooray, we explicitely need to add a route... */
-            add_route_connected_v6_net(tt, es);
-        }
-        tt->did_ifconfig = true;
+    tt->did_ifconfig = true;
 
 #elif defined(TARGET_NETBSD)
 
-        if (tun)
-        {
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask 255.255.255.255 up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-        }
-        else if (tt->topology == TOP_SUBNET)
-        {
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask %s up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_local,
-                        tun_mtu,
-                        ifconfig_remote_netmask
-                        );
-        }
-        else
-        {
-            /*
-             * NetBSD has distinct tun and tap devices
-             * so we don't need the "link0" extra parameter to specify we want to do
-             * tunneling at the ethernet level
-             */
-            argv_printf(&argv,
-                        "%s %s %s netmask %s mtu %d broadcast %s",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu,
-                        ifconfig_broadcast
-                        );
-        }
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
-
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
+    if (tun)
+    {
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else if (tt->topology == TOP_SUBNET)
+    {
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_local, tun_mtu,
+                    ifconfig_remote_netmask);
+    }
+    else
+    {
+        /*
+         * NetBSD has distinct tun and tap devices
+         * so we don't need the "link0" extra parameter to specify we want to do
+         * tunneling at the ethernet level
+         */
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d broadcast %s",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu, ifconfig_broadcast);
+    }
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
-            /* and, hooray, we explicitely need to add a route... */
-            add_route_connected_v6_net(tt, es);
-        }
-        tt->did_ifconfig = true;
+    tt->did_ifconfig = true;
 
 #elif defined(TARGET_DARWIN)
-        /*
-         * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour to OpenBSD...
-         */
+    /*
+     * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour to OpenBSD...
+     */
 
-        argv_printf(&argv,
-                    "%s %s delete",
-                    IFCONFIG_PATH,
-                    actual);
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, 0, NULL);
-        msg(M_INFO, "NOTE: Tried to delete pre-existing tun/tap instance -- No Problem if failure");
+    argv_printf(&argv, "%s %s delete", IFCONFIG_PATH, ifname);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, 0, NULL);
+    msg(M_INFO,
+        "NOTE: Tried to delete pre-existing tun/tap instance -- No Problem if failure");
 
 
-        /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-        if (tun)
+    /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
+    if (tun)
+    {
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else
+    {
+        if (tt->topology == TOP_SUBNET)
         {
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask 255.255.255.255 up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
+            argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
+                        IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,
+                        ifconfig_remote_netmask, tun_mtu);
         }
         else
         {
-            if (tt->topology == TOP_SUBNET)
-            {
-                argv_printf(&argv,
-                            "%s %s %s %s netmask %s mtu %d up",
-                            IFCONFIG_PATH,
-                            actual,
-                            ifconfig_local,
-                            ifconfig_local,
-                            ifconfig_remote_netmask,
-                            tun_mtu
-                            );
-            }
-            else
-            {
-                argv_printf(&argv,
-                            "%s %s %s netmask %s mtu %d up",
-                            IFCONFIG_PATH,
-                            actual,
-                            ifconfig_local,
-                            ifconfig_remote_netmask,
-                            tun_mtu
-                            );
-            }
+            argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
+                        ifname, ifconfig_local, ifconfig_remote_netmask,
+                        tun_mtu);
         }
+    }
 
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Mac OS X ifconfig failed");
-        tt->did_ifconfig = true;
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "Mac OS X ifconfig failed");
+    tt->did_ifconfig = true;
 
-        /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
-        {
-            struct route_ipv4 r;
-            CLEAR(r);
-            r.flags = RT_DEFINED;
-            r.network = tt->local & tt->remote_netmask;
-            r.netmask = tt->remote_netmask;
-            r.gateway = tt->local;
-            add_route(&r, tt, 0, NULL, es);
-        }
+    /* Add a network route for the local tun interface */
+    if (!tun && tt->topology == TOP_SUBNET)
+    {
+        struct route_ipv4 r;
+        CLEAR(r);
+        r.flags = RT_DEFINED;
+        r.network = tt->local & tt->remote_netmask;
+        r.netmask = tt->remote_netmask;
+        r.gateway = tt->local;
+        add_route(&r, tt, 0, NULL, es);
+    }
 
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
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
-            /* and, hooray, we explicitely need to add a route... */
-            add_route_connected_v6_net(tt, es);
-        }
+    in_addr_t remote_end;           /* for "virtual" subnet topology */
 
-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+    /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
+    if (tun)
+    {
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
+                    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    else if (tt->topology == TOP_SUBNET)
+    {
+        remote_end = create_arbitrary_remote( tt );
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, print_in_addr_t(remote_end, 0, &gc),
+                    tun_mtu, ifconfig_remote_netmask);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+    }
+
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
+    tt->did_ifconfig = true;
 
-        in_addr_t remote_end;           /* for "virtual" subnet topology */
+    /* Add a network route for the local tun interface */
+    if (!tun && tt->topology == TOP_SUBNET)
+    {
+        struct route_ipv4 r;
+        CLEAR(r);
+        r.flags = RT_DEFINED;
+        r.network = tt->local & tt->remote_netmask;
+        r.netmask = tt->remote_netmask;
+        r.gateway = remote_end;
+        add_route(&r, tt, 0, NULL, es);
+    }
+
+#elif defined(TARGET_AIX)
+    {
+        /* AIX ifconfig will complain if it can't find ODM path in env */
+        struct env_set *aix_es = env_set_create(NULL);
+        env_set_add( aix_es, "ODMDIR=/etc/objrepos" );
 
-        /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
         if (tun)
         {
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask 255.255.255.255 up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-        }
-        else if (tt->topology == TOP_SUBNET)
-        {
-            remote_end = create_arbitrary_remote( tt );
-            argv_printf(&argv,
-                        "%s %s %s %s mtu %d netmask %s up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        print_in_addr_t(remote_end, 0, &gc),
-                        tun_mtu,
-                        ifconfig_remote_netmask
-                        );
-        }
-        else
-        {
-            argv_printf(&argv,
-                        "%s %s %s netmask %s mtu %d up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
+            msg(M_FATAL, "no tun support on AIX (canthappen)");
         }
 
+        /* example: ifconfig tap0 172.30.1.1 netmask 255.255.254.0 up */
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+
         argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
+        openvpn_execve_check(&argv, aix_es, S_FATAL, "AIX ifconfig failed");
         tt->did_ifconfig = true;
 
-        /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
-        {
-            struct route_ipv4 r;
-            CLEAR(r);
-            r.flags = RT_DEFINED;
-            r.network = tt->local & tt->remote_netmask;
-            r.netmask = tt->remote_netmask;
-            r.gateway = remote_end;
-            add_route(&r, tt, 0, NULL, es);
-        }
-
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
+        env_set_destroy(aix_es);
+    }
+#elif defined (_WIN32)
+    {
+        ASSERT(ifname != NULL);
 
-#elif defined(TARGET_AIX)
+        switch (tt->options.ip_win32_type)
         {
-            /* AIX ifconfig will complain if it can't find ODM path in env */
-            struct env_set *aix_es = env_set_create(NULL);
-            env_set_add( aix_es, "ODMDIR=/etc/objrepos" );
-
-            if (tun)
-            {
-                msg(M_FATAL, "no tun support on AIX (canthappen)");
-            }
-
-            /* example: ifconfig tap0 172.30.1.1 netmask 255.255.254.0 up */
-            argv_printf(&argv,
-                        "%s %s %s netmask %s mtu %d up",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
-
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, aix_es, S_FATAL, "AIX ifconfig failed");
-            tt->did_ifconfig = true;
+            case IPW32_SET_MANUAL:
+                msg(M_INFO,
+                    "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
+                    ifname, ifconfig_local,
+                    print_in_addr_t(tt->adapter_netmask, 0, &gc));
+                break;
+            case IPW32_SET_NETSH:
+                netsh_ifconfig(&tt->options, ifname, tt->local,
+                               tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
 
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
-            env_set_destroy(aix_es);
+                break;
         }
-#elif defined (_WIN32)
-        {
-            ASSERT(actual != NULL);
+        tt->did_ifconfig = true;
+    }
 
-            switch (tt->options.ip_win32_type)
-            {
-                case IPW32_SET_MANUAL:
-                    msg(M_INFO, "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
-                        actual,
-                        ifconfig_local,
-                        print_in_addr_t(tt->adapter_netmask, 0, &gc));
-                    break;
+#else  /* if defined(TARGET_LINUX) */
+    msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
+#endif /* if defined(TARGET_LINUX) */
 
-                case IPW32_SET_NETSH:
-                    netsh_ifconfig(&tt->options,
-                                   actual,
-                                   tt->local,
-                                   tt->adapter_netmask,
-                                   NI_IP_NETMASK|NI_OPTIONS);
+    gc_free(&gc);
+    argv_reset(&argv);
+}
 
-                    break;
-            }
-            tt->did_ifconfig = true;
-        }
+/* execute the ifconfig command through the shell */
+void
+do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
+            const struct env_set *es)
+{
+    msg(D_LOW, "do_ifconfig, ipv4=%d, ipv6=%d", tt->did_ifconfig_setup,
+        tt->did_ifconfig_ipv6_setup);
 
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
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_set_state(management,
+                             OPENVPN_STATE_ASSIGN_IP,
+                             NULL,
+                             &tt->local,
+                             &tt->local_ipv6,
+                             NULL,
+                             NULL);
+    }
+#endif
 
-            /* explicit route needed */
-            if (tt->options.ip_win32_type != IPW32_SET_MANUAL)
-            {
-                add_route_connected_v6_net(tt, es);
-            }
-        }
-#else  /* if defined(TARGET_LINUX) */
-        msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
-#endif /* if defined(TARGET_LINUX) */
-        argv_reset(&argv);
+    if (tt->did_ifconfig_setup)
+    {
+        do_ifconfig_ipv4(tt, ifname, tun_mtu, es);
+    }
+
+    if (tt->did_ifconfig_ipv6_setup)
+    {
+        do_ifconfig_ipv6(tt, ifname, tun_mtu, es);
     }
-    gc_free(&gc);
 }
 
 static void
@@ -5865,7 +5713,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     if (tt->type == DEV_TYPE_TUN)
     {
-        if (!tt->did_ifconfig_setup)
+        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
         {
             msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
         }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 6c57ad0d..448a7738 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -247,9 +247,15 @@ void init_tun_post(struct tuntap *tt,
 void do_ifconfig_setenv(const struct tuntap *tt,
                         struct env_set *es);
 
-void do_ifconfig(struct tuntap *tt,
-                 const char *actual,     /* actual device name */
-                 int tun_mtu,
+/**
+ * do_ifconfig - configure the tunnel interface
+ *
+ * @param tt        the tuntap interface context
+ * @param ifname    the human readable interface name
+ * @param mtu       the MTU value to set the interface to
+ * @param es        the environment to be used when executing the commands
+ */
+void do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
                  const struct env_set *es);
 
 bool is_dev_type(const char *dev, const char *dev_type, const char *match_type);
-- 
2.17.1


