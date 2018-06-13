From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jun 2018 16:12:17 +0800
Message-Id: <20180613081218.1834-4-a@...2181...>
In-Reply-To: <20180613081218.1834-1-a@...2181...>
References: <20180613081218.1834-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/3] tun: always pass a valid tt pointer
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

This patch is a small "logic restyle" which basically moves the
check for "tt != NULL" outside of the various close_tun()
implementations and replaces it with an ASSERT.

This way the check is done only once and the function can rely
on the assumption that "tt" is always valid.

This change is mainly to improve the code style inside close_tun()
implementations by removing one level of indentation.

No functional change is present.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/init.c |   7 +-
 src/openvpn/tun.c  | 434 ++++++++++++++++++++++-----------------------
 2 files changed, 220 insertions(+), 221 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..b748357d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1847,8 +1847,11 @@ static void
 do_close_tun_simple(struct context *c)
 {
     msg(D_CLOSE, "Closing TUN/TAP interface");
-    close_tun(c->c1.tuntap);
-    c->c1.tuntap = NULL;
+    if (c->c1.tuntap)
+    {
+        close_tun(c->c1.tuntap);
+        c->c1.tuntap = NULL;
+    }
     c->c1.tuntap_owned = false;
 #if P2MP
     CLEAR(c->c1.pulled_options_digest_save);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 466d4d42..932c9d2d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1900,11 +1900,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
-    {
-        close_tun_generic(tt);
-        free(tt);
-    }
+    ASSERT(tt);
+
+    close_tun_generic(tt);
+    free(tt);
 }
 
 int
@@ -2103,77 +2102,76 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
+    ASSERT(tt);
+
+    if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
     {
-        if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
-        {
-            struct argv argv = argv_new();
-            struct gc_arena gc = gc_new();
+        struct argv argv = argv_new();
+        struct gc_arena gc = gc_new();
 
 #ifdef ENABLE_IPROUTE
-            if (is_tun_p2p(tt))
-            {
-                argv_printf(&argv,
-                            "%s addr del dev %s local %s peer %s",
-                            iproute_path,
-                            tt->actual_name,
-                            print_in_addr_t(tt->local, 0, &gc),
-                            print_in_addr_t(tt->remote_netmask, 0, &gc)
-                            );
-            }
-            else
-            {
-                argv_printf(&argv,
-                            "%s addr del dev %s %s/%d",
-                            iproute_path,
-                            tt->actual_name,
-                            print_in_addr_t(tt->local, 0, &gc),
-                            netmask_to_netbits2(tt->remote_netmask)
-                            );
-            }
-#else  /* ifdef ENABLE_IPROUTE */
+        if (is_tun_p2p(tt))
+        {
             argv_printf(&argv,
-                        "%s %s 0.0.0.0",
-                        IFCONFIG_PATH,
-                        tt->actual_name
-                        );
+                        "%s addr del dev %s local %s peer %s",
+                        iproute_path,
+                        tt->actual_name,
+                        print_in_addr_t(tt->local, 0, &gc),
+                        print_in_addr_t(tt->remote_netmask, 0, &gc)
+                       );
+        }
+        else
+        {
+            argv_printf(&argv,
+                        "%s addr del dev %s %s/%d",
+                        iproute_path,
+                        tt->actual_name,
+                        print_in_addr_t(tt->local, 0, &gc),
+                        netmask_to_netbits2(tt->remote_netmask)
+                       );
+        }
+#else  /* ifdef ENABLE_IPROUTE */
+        argv_printf(&argv,
+                    "%s %s 0.0.0.0",
+                    IFCONFIG_PATH,
+                    tt->actual_name
+                   );
 #endif /* ifdef ENABLE_IPROUTE */
 
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, NULL, 0, "Linux ip addr del failed");
+        argv_msg(M_INFO, &argv);
+        openvpn_execve_check(&argv, NULL, 0, "Linux ip addr del failed");
 
-            if (tt->did_ifconfig_ipv6_setup)
-            {
-                const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
+        if (tt->did_ifconfig_ipv6_setup)
+        {
+            const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
 
 #ifdef ENABLE_IPROUTE
-                argv_printf(&argv, "%s -6 addr del %s/%d dev %s",
-                            iproute_path,
-                            ifconfig_ipv6_local,
-                            tt->netbits_ipv6,
-                            tt->actual_name
-                            );
-                argv_msg(M_INFO, &argv);
-                openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
+            argv_printf(&argv, "%s -6 addr del %s/%d dev %s",
+                        iproute_path,
+                        ifconfig_ipv6_local,
+                        tt->netbits_ipv6,
+                        tt->actual_name
+                       );
+            argv_msg(M_INFO, &argv);
+            openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
 #else  /* ifdef ENABLE_IPROUTE */
-                argv_printf(&argv,
-                            "%s %s del %s/%d",
-                            IFCONFIG_PATH,
-                            tt->actual_name,
-                            ifconfig_ipv6_local,
-                            tt->netbits_ipv6
-                            );
-                argv_msg(M_INFO, &argv);
-                openvpn_execve_check(&argv, NULL, 0, "Linux ifconfig inet6 del failed");
+            argv_printf(&argv,
+                        "%s %s del %s/%d",
+                        IFCONFIG_PATH,
+                        tt->actual_name,
+                        ifconfig_ipv6_local,
+                        tt->netbits_ipv6
+                       );
+            argv_msg(M_INFO, &argv);
+            openvpn_execve_check(&argv, NULL, 0, "Linux ifconfig inet6 del failed");
 #endif
-            }
-
-            argv_reset(&argv);
-            gc_free(&gc);
         }
-        close_tun_generic(tt);
-        free(tt);
+
+        argv_reset(&argv);
+        gc_free(&gc);
     }
+    close_tun_generic(tt);
+    free(tt);
 }
 
 int
@@ -2491,18 +2489,17 @@ solaris_close_tun(struct tuntap *tt)
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
-    {
-        solaris_close_tun(tt);
+    ASSERT(tt);
 
-        if (tt->actual_name)
-        {
-            free(tt->actual_name);
-        }
+    solaris_close_tun(tt);
 
-        clear_tuntap(tt);
-        free(tt);
+    if (tt->actual_name)
+    {
+        free(tt->actual_name);
     }
+
+    clear_tuntap(tt);
+    free(tt);
 }
 
 static void
@@ -2511,6 +2508,8 @@ solaris_error_close(struct tuntap *tt, const struct env_set *es,
 {
     struct argv argv = argv_new();
 
+    ASSERT(tt);
+
     if (unplumb_inet6)
     {
         argv_printf( &argv, "%s %s inet6 unplumb",
@@ -2591,33 +2590,34 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
+    ASSERT(tt);
+
     /* only *TAP* devices need destroying, tun devices auto-self-destruct
      */
-    if (tt && (tt->type == DEV_TYPE_TUN || tt->persistent_if ) )
+    if (tt->type == DEV_TYPE_TUN || tt->persistent_if)
     {
         close_tun_generic(tt);
         free(tt);
+        return;
     }
-    else if (tt)
-    {
-        struct gc_arena gc = gc_new();
-        struct argv argv = argv_new();
 
-        /* setup command, close tun dev (clears tt->actual_name!), run command
-         */
+    struct gc_arena gc = gc_new();
+    struct argv argv = argv_new();
 
-        argv_printf(&argv, "%s %s destroy",
-                    IFCONFIG_PATH, tt->actual_name);
+    /* setup command, close tun dev (clears tt->actual_name!), run command
+    */
 
-        close_tun_generic(tt);
+    argv_printf(&argv, "%s %s destroy",
+                IFCONFIG_PATH, tt->actual_name);
 
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
+    close_tun_generic(tt);
 
-        free(tt);
-        argv_reset(&argv);
-        gc_free(&gc);
-    }
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
+
+    free(tt);
+    argv_reset(&argv);
+    gc_free(&gc);
 }
 
 int
@@ -2678,33 +2678,34 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
+    ASSERT(tt);
+
     /* only tun devices need destroying, tap devices auto-self-destruct
      */
-    if (tt && ( tt->type != DEV_TYPE_TUN || tt->persistent_if ) )
+    if (tt->type != DEV_TYPE_TUN || tt->persistent_if)
     {
         close_tun_generic(tt);
         free(tt);
+        return;
     }
-    else if (tt)
-    {
-        struct gc_arena gc = gc_new();
-        struct argv argv = argv_new();
 
-        /* setup command, close tun dev (clears tt->actual_name!), run command
-         */
+    struct gc_arena gc = gc_new();
+    struct argv argv = argv_new();
 
-        argv_printf(&argv, "%s %s destroy",
-                    IFCONFIG_PATH, tt->actual_name);
+    /* setup command, close tun dev (clears tt->actual_name!), run command
+    */
 
-        close_tun_generic(tt);
+    argv_printf(&argv, "%s %s destroy",
+                IFCONFIG_PATH, tt->actual_name);
 
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, NULL, 0, "NetBSD 'destroy tun interface' failed (non-critical)");
+    close_tun_generic(tt);
 
-        free(tt);
-        argv_reset(&argv);
-        gc_free(&gc);
-    }
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, NULL, 0, "NetBSD 'destroy tun interface' failed (non-critical)");
+
+    free(tt);
+    argv_reset(&argv);
+    gc_free(&gc);
 }
 
 static inline int
@@ -2820,29 +2821,31 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt && tt->persistent_if)        /* keep pre-existing if around */
+    ASSERT(tt);
+
+    if (tt->persistent_if)        /* keep pre-existing if around */
     {
         close_tun_generic(tt);
         free(tt);
+        return;
     }
-    else if (tt)                        /* close and destroy */
-    {
-        struct argv argv = argv_new();
 
-        /* setup command, close tun dev (clears tt->actual_name!), run command
-         */
+    struct argv argv = argv_new();
 
-        argv_printf(&argv, "%s %s destroy",
-                    IFCONFIG_PATH, tt->actual_name);
+    /* setup command, close tun dev (clears tt->actual_name!), run command
+    */
 
-        close_tun_generic(tt);
+    argv_printf(&argv, "%s %s destroy",
+                IFCONFIG_PATH, tt->actual_name);
 
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, NULL, 0, "FreeBSD 'destroy tun interface' failed (non-critical)");
+    close_tun_generic(tt);
 
-        free(tt);
-        argv_reset(&argv);
-    }
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, NULL, 0,
+                         "FreeBSD 'destroy tun interface' failed (non-critical)");
+
+    free(tt);
+    argv_reset(&argv);
 }
 
 int
@@ -2933,11 +2936,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
-    {
-        close_tun_generic(tt);
-        free(tt);
-    }
+    ASSERT(tt);
+
+    close_tun_generic(tt);
+    free(tt);
 }
 
 int
@@ -3190,27 +3192,26 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
-    {
-        struct gc_arena gc = gc_new();
-        struct argv argv = argv_new();
+    ASSERT(tt);
 
-        if (tt->did_ifconfig_ipv6_setup)
-        {
-            const char *ifconfig_ipv6_local =
-                print_in6_addr(tt->local_ipv6, 0, &gc);
+    struct gc_arena gc = gc_new();
+    struct argv argv = argv_new();
 
-            argv_printf(&argv, "%s delete -inet6 %s",
-                        ROUTE_PATH, ifconfig_ipv6_local );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, NULL, 0, "MacOS X 'remove inet6 route' failed (non-critical)");
-        }
+    if (tt->did_ifconfig_ipv6_setup)
+    {
+        const char *ifconfig_ipv6_local =
+            print_in6_addr(tt->local_ipv6, 0, &gc);
 
-        close_tun_generic(tt);
-        free(tt);
-        argv_reset(&argv);
-        gc_free(&gc);
+        argv_printf(&argv, "%s delete -inet6 %s",
+                    ROUTE_PATH, ifconfig_ipv6_local );
+        argv_msg(M_INFO, &argv);
+        openvpn_execve_check(&argv, NULL, 0, "MacOS X 'remove inet6 route' failed (non-critical)");
     }
+
+    close_tun_generic(tt);
+    free(tt);
+    argv_reset(&argv);
+    gc_free(&gc);
 }
 
 int
@@ -3339,15 +3340,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
+    ASSERT(tt);
+
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
     struct env_set *es = env_set_create(NULL);
 
-    if (!tt)
-    {
-        return;
-    }
-
     /* persistent devices need IP address unconfig, others need destroyal
      */
     if (tt->persistent_if)
@@ -6187,104 +6185,103 @@ tun_show_debug(struct tuntap *tt)
 void
 close_tun(struct tuntap *tt)
 {
+    ASSERT(tt);
+
     struct gc_arena gc = gc_new();
 
-    if (tt)
+    if (tt->did_ifconfig_ipv6_setup)
     {
-        if (tt->did_ifconfig_ipv6_setup)
-        {
-            /* remove route pointing to interface */
-            delete_route_connected_v6_net(tt, NULL);
+        /* remove route pointing to interface */
+        delete_route_connected_v6_net(tt, NULL);
 
-            if (tt->options.msg_channel)
+        if (tt->options.msg_channel)
+        {
+            do_address_service(false, AF_INET6, tt);
+            if (tt->options.dns6_len > 0)
             {
-                do_address_service(false, AF_INET6, tt);
-                if (tt->options.dns6_len > 0)
-                {
-                    do_dns6_service(false, tt);
-                }
+                do_dns6_service(false, tt);
             }
-            else
-            {
-                const char *ifconfig_ipv6_local;
-                struct argv argv = argv_new();
+        }
+        else
+        {
+            const char *ifconfig_ipv6_local;
+            struct argv argv = argv_new();
 
-                /* "store=active" is needed in Windows 8(.1) to delete the
-                 * address we added (pointed out by Cedric Tabary).
-                 */
+            /* "store=active" is needed in Windows 8(.1) to delete the
+             * address we added (pointed out by Cedric Tabary).
+             */
 
-                /* netsh interface ipv6 delete address \"%s\" %s */
-                ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0,  &gc);
+            /* netsh interface ipv6 delete address \"%s\" %s */
+            ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0,  &gc);
+            argv_printf(&argv,
+                        "%s%sc interface ipv6 delete address %s %s store=active",
+                        get_win_sys_path(),
+                        NETSH_PATH_SUFFIX,
+                        tt->actual_name,
+                        ifconfig_ipv6_local);
+
+            netsh_command(&argv, 1, M_WARN);
+
+            /* delete ipv6 dns servers if any were set */
+            if (tt->options.dns6_len > 0)
+            {
                 argv_printf(&argv,
-                            "%s%sc interface ipv6 delete address %s %s store=active",
+                            "%s%sc interface ipv6 delete dns %s all",
                             get_win_sys_path(),
                             NETSH_PATH_SUFFIX,
-                            tt->actual_name,
-                            ifconfig_ipv6_local);
-
+                            tt->actual_name);
                 netsh_command(&argv, 1, M_WARN);
-
-                /* delete ipv6 dns servers if any were set */
-                if (tt->options.dns6_len > 0)
-                {
-                    argv_printf(&argv,
-                                "%s%sc interface ipv6 delete dns %s all",
-                                get_win_sys_path(),
-                                NETSH_PATH_SUFFIX,
-                                tt->actual_name);
-                    netsh_command(&argv, 1, M_WARN);
-                }
-                argv_reset(&argv);
             }
+            argv_reset(&argv);
         }
+    }
 #if 1
-        if (tt->ipapi_context_defined)
+    if (tt->ipapi_context_defined)
+    {
+        DWORD status;
+        if ((status = DeleteIPAddress(tt->ipapi_context)) != NO_ERROR)
         {
-            DWORD status;
-            if ((status = DeleteIPAddress(tt->ipapi_context)) != NO_ERROR)
-            {
-                msg(M_WARN, "Warning: DeleteIPAddress[%u] failed on TAP-Windows adapter, status=%u : %s",
-                    (unsigned int)tt->ipapi_context,
-                    (unsigned int)status,
-                    strerror_win32(status, &gc));
-            }
+            msg(M_WARN, "Warning: DeleteIPAddress[%u] failed on TAP-Windows adapter, status=%u : %s",
+                (unsigned int)tt->ipapi_context,
+                (unsigned int)status,
+                strerror_win32(status, &gc));
         }
+    }
 #endif
 
-        dhcp_release(tt);
+    dhcp_release(tt);
 
-        if (tt->hand != NULL)
+    if (tt->hand != NULL)
+    {
+        dmsg(D_WIN32_IO_LOW, "Attempting CancelIO on TAP-Windows adapter");
+        if (!CancelIo(tt->hand))
         {
-            dmsg(D_WIN32_IO_LOW, "Attempting CancelIO on TAP-Windows adapter");
-            if (!CancelIo(tt->hand))
-            {
-                msg(M_WARN | M_ERRNO, "Warning: CancelIO failed on TAP-Windows adapter");
-            }
+            msg(M_WARN | M_ERRNO, "Warning: CancelIO failed on TAP-Windows adapter");
         }
+    }
 
-        dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped read event on TAP-Windows adapter");
-        overlapped_io_close(&tt->reads);
-
-        dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped write event on TAP-Windows adapter");
-        overlapped_io_close(&tt->writes);
+    dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped read event on TAP-Windows adapter");
+    overlapped_io_close(&tt->reads);
 
-        if (tt->hand != NULL)
-        {
-            dmsg(D_WIN32_IO_LOW, "Attempting CloseHandle on TAP-Windows adapter");
-            if (!CloseHandle(tt->hand))
-            {
-                msg(M_WARN | M_ERRNO, "Warning: CloseHandle failed on TAP-Windows adapter");
-            }
-        }
+    dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped write event on TAP-Windows adapter");
+    overlapped_io_close(&tt->writes);
 
-        if (tt->actual_name)
+    if (tt->hand != NULL)
+    {
+        dmsg(D_WIN32_IO_LOW, "Attempting CloseHandle on TAP-Windows adapter");
+        if (!CloseHandle(tt->hand))
         {
-            free(tt->actual_name);
+            msg(M_WARN | M_ERRNO, "Warning: CloseHandle failed on TAP-Windows adapter");
         }
+    }
 
-        clear_tuntap(tt);
-        free(tt);
+    if (tt->actual_name)
+    {
+        free(tt->actual_name);
     }
+
+    clear_tuntap(tt);
+    free(tt);
     gc_free(&gc);
 }
 
@@ -6363,11 +6360,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
-    {
-        close_tun_generic(tt);
-        free(tt);
-    }
+    ASSERT(tt);
+
+    close_tun_generic(tt);
+    free(tt);
 }
 
 int
-- 
2.17.1


