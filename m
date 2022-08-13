From: Antonio Quartulli <a@...2181...>
Date: Sat, 13 Aug 2022 14:04:28 +0200
Message-Id: <20220813120428.6767-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] do_close_tun: get rid of one level of
 indentation
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

OpenVPN often uses a multi-indentation pattern with no real gain:

if (a)
{
    if (b)
    {
        ...
    }
}

This approach makes the code harder to read because a lot of space is
eaten by indentation.

Cases like this can be easily converted by negating the first condition
and exiting immediately:

if (!a)
{
    return;
}

if (b)
{
    ...
}

Apply this change to do_close_tun() only for now in order to make the
functiona bit easier to read.

Ideally, this approach should be adopted for other parts of the code as
well.

NOTE: this patch is better viewed with "git show -w" as the real change
is only about 3 lines. The rest is indentation change.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

** the dco-win patchset is based on this patch. I should have sent this
earlier, but it slipped off.

 src/openvpn/init.c | 174 +++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 86 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d67bc5d1..82a57bef 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1924,65 +1924,38 @@ do_close_tun_simple(struct context *c)
 static void
 do_close_tun(struct context *c, bool force)
 {
-    struct gc_arena gc = gc_new();
-    if (c->c1.tuntap && c->c1.tuntap_owned)
+    if (!c->c1.tuntap || !c->c1.tuntap_owned)
     {
-        const char *tuntap_actual = string_alloc(c->c1.tuntap->actual_name, &gc);
+        return;
+    }
+
+    struct gc_arena gc = gc_new();
+    const char *tuntap_actual = string_alloc(c->c1.tuntap->actual_name, &gc);
 #ifdef _WIN32
-        DWORD adapter_index = c->c1.tuntap->adapter_index;
+    DWORD adapter_index = c->c1.tuntap->adapter_index;
 #endif
-        const in_addr_t local = c->c1.tuntap->local;
-        const in_addr_t remote_netmask = c->c1.tuntap->remote_netmask;
+    const in_addr_t local = c->c1.tuntap->local;
+    const in_addr_t remote_netmask = c->c1.tuntap->remote_netmask;
 
-        if (force || !(c->sig->signal_received == SIGUSR1 && c->options.persist_tun))
-        {
-            static_context = NULL;
+    if (force || !(c->sig->signal_received == SIGUSR1 && c->options.persist_tun))
+    {
+        static_context = NULL;
 
 #ifdef ENABLE_MANAGEMENT
-            /* tell management layer we are about to close the TUN/TAP device */
-            if (management)
-            {
-                management_pre_tunnel_close(management);
-                management_up_down(management, "DOWN", c->c2.es);
-            }
-#endif
-
-            /* delete any routes we added */
-            if (c->c1.route_list || c->c1.route_ipv6_list)
-            {
-                run_up_down(c->options.route_predown_script,
-                            c->plugins,
-                            OPENVPN_PLUGIN_ROUTE_PREDOWN,
-                            tuntap_actual,
-#ifdef _WIN32
-                            adapter_index,
+        /* tell management layer we are about to close the TUN/TAP device */
+        if (management)
+        {
+            management_pre_tunnel_close(management);
+            management_up_down(management, "DOWN", c->c2.es);
+        }
 #endif
-                            NULL,
-                            c->c2.frame.tun_mtu,
-                            print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
-                            print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
-                            "init",
-                            signal_description(c->sig->signal_received,
-                                               c->sig->signal_text),
-                            "route-pre-down",
-                            c->c2.es);
-
-                delete_routes(c->c1.route_list, c->c1.route_ipv6_list,
-                              c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
-                              c->c2.es, &c->net_ctx);
-            }
 
-            /* actually close tun/tap device based on --down-pre flag */
-            if (!c->options.down_pre)
-            {
-                do_close_tun_simple(c);
-            }
-
-            /* Run the down script -- note that it will run at reduced
-             * privilege if, for example, "--user nobody" was used. */
-            run_up_down(c->options.down_script,
+        /* delete any routes we added */
+        if (c->c1.route_list || c->c1.route_ipv6_list)
+        {
+            run_up_down(c->options.route_predown_script,
                         c->plugins,
-                        OPENVPN_PLUGIN_DOWN,
+                        OPENVPN_PLUGIN_ROUTE_PREDOWN,
                         tuntap_actual,
 #ifdef _WIN32
                         adapter_index,
@@ -1994,59 +1967,88 @@ do_close_tun(struct context *c, bool force)
                         "init",
                         signal_description(c->sig->signal_received,
                                            c->sig->signal_text),
-                        "down",
+                        "route-pre-down",
                         c->c2.es);
 
+            delete_routes(c->c1.route_list, c->c1.route_ipv6_list,
+                          c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
+                          c->c2.es, &c->net_ctx);
+        }
+
+        /* actually close tun/tap device based on --down-pre flag */
+        if (!c->options.down_pre)
+        {
+            do_close_tun_simple(c);
+        }
+
+        /* Run the down script -- note that it will run at reduced
+         * privilege if, for example, "--user nobody" was used. */
+        run_up_down(c->options.down_script,
+                    c->plugins,
+                    OPENVPN_PLUGIN_DOWN,
+                    tuntap_actual,
+#ifdef _WIN32
+                    adapter_index,
+#endif
+                    NULL,
+                    c->c2.frame.tun_mtu,
+                    print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
+                    print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
+                    "init",
+                    signal_description(c->sig->signal_received,
+                                       c->sig->signal_text),
+                    "down",
+                    c->c2.es);
+
 #if defined(_WIN32)
-            if (c->options.block_outside_dns)
+        if (c->options.block_outside_dns)
+        {
+            if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
             {
-                if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
-                {
-                    msg(M_FATAL, "Uninitialising WFP failed!");
-                }
+                msg(M_FATAL, "Uninitialising WFP failed!");
             }
+        }
 #endif
 
-            /* actually close tun/tap device based on --down-pre flag */
-            if (c->options.down_pre)
-            {
-                do_close_tun_simple(c);
-            }
+        /* actually close tun/tap device based on --down-pre flag */
+        if (c->options.down_pre)
+        {
+            do_close_tun_simple(c);
         }
-        else
+    }
+    else
+    {
+        /* run the down script on this restart if --up-restart was specified */
+        if (c->options.up_restart)
         {
-            /* run the down script on this restart if --up-restart was specified */
-            if (c->options.up_restart)
-            {
-                run_up_down(c->options.down_script,
-                            c->plugins,
-                            OPENVPN_PLUGIN_DOWN,
-                            tuntap_actual,
+            run_up_down(c->options.down_script,
+                        c->plugins,
+                        OPENVPN_PLUGIN_DOWN,
+                        tuntap_actual,
 #ifdef _WIN32
-                            adapter_index,
+                        adapter_index,
 #endif
-                            NULL,
-                            c->c2.frame.tun_mtu,
-                            print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
-                            print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
-                            "restart",
-                            signal_description(c->sig->signal_received,
-                                               c->sig->signal_text),
-                            "down",
-                            c->c2.es);
-            }
+                        NULL,
+                        c->c2.frame.tun_mtu,
+                        print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
+                        print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
+                        "restart",
+                        signal_description(c->sig->signal_received,
+                                           c->sig->signal_text),
+                        "down",
+                        c->c2.es);
+        }
 
 #if defined(_WIN32)
-            if (c->options.block_outside_dns)
+        if (c->options.block_outside_dns)
+        {
+            if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
             {
-                if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
-                {
-                    msg(M_FATAL, "Uninitialising WFP failed!");
-                }
+                msg(M_FATAL, "Uninitialising WFP failed!");
             }
+        }
 #endif
 
-        }
     }
     gc_free(&gc);
 }
-- 
2.35.1


