From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Aug 2022 15:06:48 +0200
Message-Id: <20220812130657.29899-2-a@...2181...>
In-Reply-To: <20220812130657.29899-1-a@...2181...>
References: <20220812130657.29899-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v100 01/10] do_open_tun: restyle "can
 preserve TUN" check
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
Cc: Antonio Quartulli <a@...2181...>

The current condition checking if the TUN interface was preserved is
dependant on the platform being Android or not. This makes the code
reasonably ugly, especially because uncrustify can't indent properly.

On top of that, we will require an extra condition only for windows+DCO,
which will make the check even uglier.

For this reason, factor out the check in a separate function which can
keep the ifdefs craziness well hidden, while do_open_tun becomes
(a bit) cleaner.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c | 282 +++++++++++++++++++++++----------------------
 1 file changed, 144 insertions(+), 138 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 82a57bef..4d4c7192 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1716,161 +1716,120 @@ do_init_tun(struct context *c)
  * Open tun/tap device, ifconfig, call up script, etc.
  */
 
+
+static bool
+can_preserve_tun(struct tuntap *tt)
+{
+#ifdef TARGET_ANDROID
+    return false;
+#else
+    return tt;
+#endif
+}
+
 static bool
 do_open_tun(struct context *c)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
 
-#ifndef TARGET_ANDROID
-    if (!c->c1.tuntap)
+    if (!can_preserve_tun(c->c1.tuntap))
     {
-#endif
-
 #ifdef TARGET_ANDROID
-    /* If we emulate persist-tun on android we still have to open a new tun and
-     * then close the old */
-    int oldtunfd = -1;
-    if (c->c1.tuntap)
-    {
-        oldtunfd = c->c1.tuntap->fd;
-        free(c->c1.tuntap);
-        c->c1.tuntap = NULL;
-        c->c1.tuntap_owned = false;
-    }
+        /* If we emulate persist-tun on android we still have to open a new tun and
+         * then close the old */
+        int oldtunfd = -1;
+        if (c->c1.tuntap)
+        {
+            oldtunfd = c->c1.tuntap->fd;
+            free(c->c1.tuntap);
+            c->c1.tuntap = NULL;
+            c->c1.tuntap_owned = false;
+        }
 #endif
 
-    /* initialize (but do not open) tun/tap object */
-    do_init_tun(c);
+        /* initialize (but do not open) tun/tap object */
+        do_init_tun(c);
 
-    /* inherit the dco context from the tuntap object */
-    if (c->c2.tls_multi)
-    {
-        c->c2.tls_multi->dco = &c->c1.tuntap->dco;
-    }
+        /* inherit the dco context from the tuntap object */
+        if (c->c2.tls_multi)
+        {
+            c->c2.tls_multi->dco = &c->c1.tuntap->dco;
+        }
 
 #ifdef _WIN32
-    /* store (hide) interactive service handle in tuntap_options */
-    c->c1.tuntap->options.msg_channel = c->options.msg_channel;
-    msg(D_ROUTE, "interactive service msg_channel=%" PRIu64, (unsigned long long) c->options.msg_channel);
+        /* store (hide) interactive service handle in tuntap_options */
+        c->c1.tuntap->options.msg_channel = c->options.msg_channel;
+        msg(D_ROUTE, "interactive service msg_channel=%" PRIu64, (unsigned long long) c->options.msg_channel);
 #endif
 
-    /* allocate route list structure */
-    do_alloc_route_list(c);
+        /* allocate route list structure */
+        do_alloc_route_list(c);
 
-    /* parse and resolve the route option list */
-    ASSERT(c->c2.link_socket);
-    if (c->options.routes && c->c1.route_list)
-    {
-        do_init_route_list(&c->options, c->c1.route_list,
-                           &c->c2.link_socket->info, c->c2.es, &c->net_ctx);
-    }
-    if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
-    {
-        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
-                                &c->c2.link_socket->info, c->c2.es,
-                                &c->net_ctx);
-    }
+        /* parse and resolve the route option list */
+        ASSERT(c->c2.link_socket);
+        if (c->options.routes && c->c1.route_list)
+        {
+            do_init_route_list(&c->options, c->c1.route_list,
+                               &c->c2.link_socket->info, c->c2.es, &c->net_ctx);
+        }
+        if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
+        {
+            do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
+                                    &c->c2.link_socket->info, c->c2.es,
+                                    &c->net_ctx);
+        }
 
-    /* do ifconfig */
-    if (!c->options.ifconfig_noexec
-        && ifconfig_order() == IFCONFIG_BEFORE_TUN_OPEN)
-    {
-        /* guess actual tun/tap unit number that will be returned
-         * by open_tun */
-        const char *guess = guess_tuntap_dev(c->options.dev,
-                                             c->options.dev_type,
-                                             c->options.dev_node,
-                                             &gc);
-        do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                    &c->net_ctx);
-    }
+        /* do ifconfig */
+        if (!c->options.ifconfig_noexec
+            && ifconfig_order() == IFCONFIG_BEFORE_TUN_OPEN)
+        {
+            /* guess actual tun/tap unit number that will be returned
+             * by open_tun */
+            const char *guess = guess_tuntap_dev(c->options.dev,
+                                                 c->options.dev_type,
+                                                 c->options.dev_node,
+                                                 &gc);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
+                        &c->net_ctx);
+        }
 
-    /* possibly add routes */
-    if (route_order() == ROUTE_BEFORE_TUN)
-    {
-        /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
-        do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
-    }
+        /* possibly add routes */
+        if (route_order() == ROUTE_BEFORE_TUN)
+        {
+            /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
+            do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                     c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+        }
 #ifdef TARGET_ANDROID
-    /* Store the old fd inside the fd so open_tun can use it */
-    c->c1.tuntap->fd = oldtunfd;
-#endif
-    if (dco_enabled(&c->options))
-    {
-        ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
-    }
-
-    /* open the tun device */
-    open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap, &c->net_ctx);
-
-    /* set the hardware address */
-    if (c->options.lladdr)
-    {
-        set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.lladdr,
-                   c->c2.es);
-    }
-
-    /* do ifconfig */
-    if (!c->options.ifconfig_noexec
-        && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
-    {
-        do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                    c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
-    }
-
-    /* run the up script */
-    run_up_down(c->options.up_script,
-                c->plugins,
-                OPENVPN_PLUGIN_UP,
-                c->c1.tuntap->actual_name,
-#ifdef _WIN32
-                c->c1.tuntap->adapter_index,
+        /* Store the old fd inside the fd so open_tun can use it */
+        c->c1.tuntap->fd = oldtunfd;
 #endif
-                dev_type_string(c->options.dev, c->options.dev_type),
-                c->c2.frame.tun_mtu,
-                print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
-                print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
-                "init",
-                NULL,
-                "up",
-                c->c2.es);
-
-#if defined(_WIN32)
-    if (c->options.block_outside_dns)
-    {
-        dmsg(D_LOW, "Blocking outside DNS");
-        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
+        if (dco_enabled(&c->options))
         {
-            msg(M_FATAL, "Blocking DNS failed!");
+            ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
         }
-    }
-#endif
 
-    /* possibly add routes */
-    if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
-    {
-        do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
-    }
+        /* open the tun device */
+        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
+                 c->c1.tuntap, &c->net_ctx);
 
-    ret = true;
-    static_context = c;
-#ifndef TARGET_ANDROID
-}
-else
-{
-    msg(M_INFO, "Preserving previous TUN/TAP instance: %s",
-        c->c1.tuntap->actual_name);
+        /* set the hardware address */
+        if (c->options.lladdr)
+        {
+            set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.lladdr,
+                       c->c2.es);
+        }
 
-    /* explicitly set the ifconfig_* env vars */
-    do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
+        /* do ifconfig */
+        if (!c->options.ifconfig_noexec
+            && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
+        {
+            do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
+                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
+        }
 
-    /* run the up script if user specified --up-restart */
-    if (c->options.up_restart)
-    {
+        /* run the up script */
         run_up_down(c->options.up_script,
                     c->plugins,
                     OPENVPN_PLUGIN_UP,
@@ -1882,24 +1841,71 @@ else
                     c->c2.frame.tun_mtu,
                     print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                     print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
-                    "restart",
+                    "init",
                     NULL,
                     "up",
                     c->c2.es);
-    }
+
 #if defined(_WIN32)
-    if (c->options.block_outside_dns)
-    {
-        dmsg(D_LOW, "Blocking outside DNS");
-        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
+        if (c->options.block_outside_dns)
+        {
+            dmsg(D_LOW, "Blocking outside DNS");
+            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
+            {
+                msg(M_FATAL, "Blocking DNS failed!");
+            }
+        }
+#endif
+
+        /* possibly add routes */
+        if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
         {
-            msg(M_FATAL, "Blocking DNS failed!");
+            do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                     c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
         }
+
+        ret = true;
+        static_context = c;
     }
+    else
+    {
+        msg(M_INFO, "Preserving previous TUN/TAP instance: %s",
+            c->c1.tuntap->actual_name);
+
+        /* explicitly set the ifconfig_* env vars */
+        do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
+
+        /* run the up script if user specified --up-restart */
+        if (c->options.up_restart)
+        {
+            run_up_down(c->options.up_script,
+                        c->plugins,
+                        OPENVPN_PLUGIN_UP,
+                        c->c1.tuntap->actual_name,
+#ifdef _WIN32
+                        c->c1.tuntap->adapter_index,
+#endif
+                        dev_type_string(c->options.dev, c->options.dev_type),
+                        c->c2.frame.tun_mtu,
+                        print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
+                        print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
+                        "restart",
+                        NULL,
+                        "up",
+                        c->c2.es);
+        }
+#if defined(_WIN32)
+        if (c->options.block_outside_dns)
+        {
+            dmsg(D_LOW, "Blocking outside DNS");
+            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
+            {
+                msg(M_FATAL, "Blocking DNS failed!");
+            }
+        }
 #endif
 
-}
-#endif /* ifndef TARGET_ANDROID */
+    }
     gc_free(&gc);
     return ret;
 }
-- 
2.35.1


