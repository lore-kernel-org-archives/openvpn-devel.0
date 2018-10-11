From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Oct 2018 02:41:57 +0800
Message-Id: <20181011184200.22175-5-a@...2181...>
In-Reply-To: <20181011184200.22175-1-a@...2181...>
References: <20181011184200.22175-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/7] tun.c: use new networking API to
 handle tun interface on Linux
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

By switching to the networking API (for Linux) openvpn will
now use any of the available implementations to handle the tun
interface.

At the moment only iproute2 and sitnl (NetLink) is implemented.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c       |  22 ++--
 src/openvpn/init.h       |   2 +-
 src/openvpn/networking.h |   6 --
 src/openvpn/openvpn.c    |   4 +-
 src/openvpn/openvpn.h    |   2 +
 src/openvpn/options.c    |   4 +-
 src/openvpn/options.h    |   1 +
 src/openvpn/tun.c        | 215 +++++++++++++++++++++------------------
 src/openvpn/tun.h        |  12 ++-
 9 files changed, 147 insertions(+), 121 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1b9f19d0..1eba49ab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1081,7 +1081,7 @@ do_genkey(const struct options *options)
  * Persistent TUN/TAP device management mode?
  */
 bool
-do_persist_tuntap(const struct options *options)
+do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
 {
     if (options->persist_config)
     {
@@ -1099,7 +1099,8 @@ do_persist_tuntap(const struct options *options)
 #ifdef ENABLE_FEATURE_TUN_PERSIST
         tuncfg(options->dev, options->dev_type, options->dev_node,
                options->persist_mode,
-               options->username, options->groupname, &options->tuntap_options);
+               options->username, options->groupname, &options->tuntap_options,
+               ctx);
         if (options->persist_mode && options->lladdr)
         {
             set_lladdr(options->dev, options->lladdr, NULL);
@@ -1672,7 +1673,8 @@ do_init_tun(struct context *c)
                             c->c1.link_socket_addr.bind_local,
                             c->c1.link_socket_addr.remote_list,
                             !c->options.ifconfig_nowarn,
-                            c->c2.es);
+                            c->c2.es,
+                            &c->net_ctx);
 
     init_tun_post(c->c1.tuntap,
                   &c->c2.frame,
@@ -1744,7 +1746,8 @@ do_open_tun(struct context *c)
                                              c->options.dev_type,
                                              c->options.dev_node,
                                              &gc);
-        do_ifconfig(c->c1.tuntap, guess, TUN_MTU_SIZE(&c->c2.frame), c->c2.es);
+        do_ifconfig(c->c1.tuntap, guess, TUN_MTU_SIZE(&c->c2.frame), c->c2.es,
+                    &c->net_ctx);
     }
 
     /* possibly add routes */
@@ -1772,7 +1775,8 @@ do_open_tun(struct context *c)
     if (!c->options.ifconfig_noexec
         && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
     {
-        do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name, TUN_MTU_SIZE(&c->c2.frame), c->c2.es);
+        do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
+                    TUN_MTU_SIZE(&c->c2.frame), c->c2.es, &c->net_ctx);
     }
 
     /* run the up script */
@@ -1880,7 +1884,7 @@ do_close_tun_simple(struct context *c)
     msg(D_CLOSE, "Closing TUN/TAP interface");
     if (c->c1.tuntap)
     {
-        close_tun(c->c1.tuntap);
+        close_tun(c->c1.tuntap, &c->net_ctx);
         c->c1.tuntap = NULL;
     }
     c->c1.tuntap_owned = false;
@@ -3321,9 +3325,11 @@ do_compute_occ_strings(struct context *c)
     struct gc_arena gc = gc_new();
 
     c->c2.options_string_local =
-        options_string(&c->options, &c->c2.frame, c->c1.tuntap, false, &gc);
+        options_string(&c->options, &c->c2.frame, c->c1.tuntap, &c->net_ctx,
+                       false, &gc);
     c->c2.options_string_remote =
-        options_string(&c->options, &c->c2.frame, c->c1.tuntap, true, &gc);
+        options_string(&c->options, &c->c2.frame, c->c1.tuntap, &c->net_ctx,
+                       true, &gc);
 
     msg(D_SHOW_OCC, "Local Options String (VER=%s): '%s'",
         options_string_version(c->c2.options_string_local, &gc),
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 085ac533..ba5eda06 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -56,7 +56,7 @@ bool print_openssl_info(const struct options *options);
 
 bool do_genkey(const struct options *options);
 
-bool do_persist_tuntap(const struct options *options);
+bool do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx);
 
 bool possibly_become_daemon(const struct options *options);
 
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 716e61a5..e624cb6b 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -21,12 +21,6 @@
 #ifndef NETWORKING_H_
 #define NETWORKING_H_
 
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
 #include "syshead.h"
 
 struct context;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 5d6a41cd..a32227da 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -215,6 +215,8 @@ openvpn_main(int argc, char *argv[])
             open_plugins(&c, true, OPENVPN_PLUGIN_INIT_PRE_CONFIG_PARSE);
 #endif
 
+            net_ctx_init(&c, &c.net_ctx);
+
             /* init verbosity and mute levels */
             init_verb_mute(&c, IVM_LEVEL_1);
 
@@ -234,7 +236,7 @@ openvpn_main(int argc, char *argv[])
             }
 
             /* tun/tap persist command? */
-            if (do_persist_tuntap(&c.options))
+            if (do_persist_tuntap(&c.options, &c.net_ctx))
             {
                 break;
             }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index bc972f22..7ec69612 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -520,6 +520,8 @@ struct context
 
     struct env_set *es;         /**< Set of environment variables. */
 
+    openvpn_net_ctx_t net_ctx;	/**< Networking API opaque context */
+
     struct signal_info *sig;    /**< Internal error signaling object. */
 
     struct plugin_list *plugins; /**< List of plug-ins. */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0421185f..55559dfd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3570,6 +3570,7 @@ char *
 options_string(const struct options *o,
                const struct frame *frame,
                struct tuntap *tt,
+               openvpn_net_ctx_t *ctx,
                bool remote,
                struct gc_arena *gc)
 {
@@ -3612,7 +3613,8 @@ options_string(const struct options *o,
                       NULL,
                       NULL,
                       false,
-                      NULL);
+                      NULL,
+                      ctx);
         if (tt)
         {
             tt_local = true;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 33b1e45a..8e777e40 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -726,6 +726,7 @@ const char *options_string_version(const char *s, struct gc_arena *gc);
 char *options_string(const struct options *o,
                      const struct frame *frame,
                      struct tuntap *tt,
+                     openvpn_net_ctx_t *ctx,
                      bool remote,
                      struct gc_arena *gc);
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 948fd17d..002c3e6c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -46,6 +46,7 @@
 #include "route.h"
 #include "win32.h"
 #include "block_dns.h"
+#include "networking.h"
 
 #include "memdbg.h"
 
@@ -631,7 +632,8 @@ init_tun(const char *dev,        /* --dev option */
          struct addrinfo *local_public,
          struct addrinfo *remote_public,
          const bool strict_warn,
-         struct env_set *es)
+         struct env_set *es,
+         openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     struct tuntap *tt;
@@ -870,35 +872,37 @@ create_arbitrary_remote( struct tuntap *tt )
  * @param ifname    the human readable interface name
  * @param mtu       the MTU value to set the interface to
  * @param es        the environment to be used when executing the commands
+ * @param ctx       the networking API opaque context
  */
 static void
 do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-    const char *ifconfig_ipv6_local = NULL;
+#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
+    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
+    || defined(TARGET_SOLARIS) || defined(_WIN32)
     struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
-
-    ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
+    const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
+#endif
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    /* set the MTU for the device and bring it up */
-    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, ifname,
-                tun_mtu);
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
+    if (net_iface_mtu_set(ctx, ifname, tun_mtu) < 0)
+    {
+        msg(M_FATAL, "Linux can't set mtu (%d) on %s", tun_mtu, ifname);
+    }
 
-    argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path,
-                ifconfig_ipv6_local, tt->netbits_ipv6, ifname);
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
-#else
-    argv_printf(&argv, "%s %s add %s/%d mtu %d up", IFCONFIG_PATH, ifname,
-                ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
-#endif
+    if (net_iface_up(ctx, ifname, true) < 0)
+    {
+        msg(M_FATAL, "Linux can't bring %s up", ifname);
+    }
+
+    if (net_addr_v6_add(ctx, ifname, &tt->local_ipv6,
+                        tt->netbits_ipv6) < 0)
+    {
+        msg(M_FATAL, "Linux can't add IPv6 to interface %s", ifname);
+    }
 #elif defined(TARGET_ANDROID)
     char out6[64];
 
@@ -1011,8 +1015,13 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* outer "if defined(TARGET_xxx)" conditional */
 
+#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
+    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
+    || defined(TARGET_SOLARIS) || defined(_WIN32)
     gc_free(&gc);
     argv_reset(&argv);
+#endif
 }
 
 /**
@@ -1022,23 +1031,27 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
  * @param ifname    the human readable interface name
  * @param mtu       the MTU value to set the interface to
  * @param es        the environment to be used when executing the commands
+ * @param ctx       the networking API opaque context
  */
 static void
 do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-    bool tun = false;
+    /*
+     * We only handle TUN/TAP devices here, not --dev null devices.
+     */
+    bool tun = is_tun_p2p(tt);
+
+#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
+    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
+    || defined(TARGET_SOLARIS) || defined(_WIN32)
     const char *ifconfig_local = NULL;
     const char *ifconfig_remote_netmask = NULL;
     const char *ifconfig_broadcast = NULL;
     struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
 
-    /*
-     * We only handle TUN/TAP devices here, not --dev null devices.
-     */
-    tun = is_tun_p2p(tt);
-
     /*
      * Set ifconfig parameters
      */
@@ -1052,53 +1065,36 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         ifconfig_broadcast = print_in_addr_t(tt->broadcast, 0, &gc);
     }
+#endif
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    /*
-     * Set the MTU for the device
-     */
-    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, ifname,
-                tun_mtu);
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
-
-    if (tun)
+    if (net_iface_mtu_set(ctx, ifname, tun_mtu) < 0)
     {
-
-        /*
-         * Set the address for the device
-         */
-        argv_printf(&argv, "%s addr add dev %s local %s peer %s", iproute_path,
-                    ifname, ifconfig_local, ifconfig_remote_netmask);
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
+        msg(M_FATAL, "Linux can't set mtu (%d) on %s", tun_mtu, ifname);
     }
-    else
+
+    if (net_iface_up(ctx, ifname, true) < 0)
     {
-        argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s",
-                    iproute_path, ifname, ifconfig_local,
-                    netmask_to_netbits2(tt->remote_netmask),
-                    ifconfig_broadcast);
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
+        msg(M_FATAL, "Linux can't bring %s up", ifname);
     }
-#else  /* ifdef ENABLE_IPROUTE */
+
     if (tun)
     {
-        argv_printf(&argv, "%s %s %s pointopoint %s mtu %d", IFCONFIG_PATH,
-                    ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+        if (net_addr_ptp_v4_add(ctx, ifname, &tt->local,
+                                &tt->remote_netmask) < 0)
+        {
+            msg(M_FATAL, "Linux can't add IP to TUN interface %s", ifname);
+        }
     }
     else
     {
-        argv_printf(&argv, "%s %s %s netmask %s mtu %d broadcast %s",
-                    IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu, ifconfig_broadcast);
+        if (net_addr_v4_add(ctx, ifname, &tt->local,
+                            netmask_to_netbits2(tt->remote_netmask),
+                            &tt->remote_netmask) < 0)
+        {
+            msg(M_FATAL, "Linux can't add IP to TAP interface %s", ifname);
+        }
     }
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig failed");
-
-#endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
     char out[64];
 
@@ -1399,14 +1395,19 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
 
+#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
+    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
+    || defined(TARGET_SOLARIS) || defined(_WIN32)
     gc_free(&gc);
     argv_reset(&argv);
+#endif
 }
 
 /* execute the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-            const struct env_set *es)
+            const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     msg(D_LOW, "do_ifconfig, ipv4=%d, ipv6=%d", tt->did_ifconfig_setup,
         tt->did_ifconfig_ipv6_setup);
@@ -1426,12 +1427,12 @@ do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
 
     if (tt->did_ifconfig_setup)
     {
-        do_ifconfig_ipv4(tt, ifname, tun_mtu, es);
+        do_ifconfig_ipv4(tt, ifname, tun_mtu, es, ctx);
     }
 
     if (tt->did_ifconfig_ipv6_setup)
     {
-        do_ifconfig_ipv6(tt, ifname, tun_mtu, es);
+        do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx);
     }
 }
 
@@ -1742,7 +1743,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -1898,7 +1899,9 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 
 void
-tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_mode, const char *username, const char *groupname, const struct tuntap_options *options)
+tuncfg(const char *dev, const char *dev_type, const char *dev_node,
+       int persist_mode, const char *username, const char *groupname,
+       const struct tuntap_options *options, openvpn_net_ctx_t *ctx)
 {
     struct tuntap *tt;
 
@@ -1937,62 +1940,74 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_
             msg(M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", groupname, dev);
         }
     }
-    close_tun(tt);
+    close_tun(tt, ctx);
     msg(M_INFO, "Persist state set to: %s", (persist_mode ? "ON" : "OFF"));
 }
 
 #endif /* ENABLE_FEATURE_TUN_PERSIST */
 
 void
-undo_ifconfig_ipv4(struct tuntap *tt, struct gc_arena *gc)
+undo_ifconfig_ipv4(struct tuntap *tt, struct gc_arena *gc,
+                   openvpn_net_ctx_t *ctx)
 {
-    struct argv argv = argv_new();
+#if defined(TARGET_LINUX)
+    int netbits = netmask_to_netbits2(tt->remote_netmask);
 
-#ifdef ENABLE_IPROUTE
     if (is_tun_p2p(tt))
     {
-        argv_printf(&argv, "%s addr del dev %s local %s peer %s", iproute_path,
-                    tt->actual_name, print_in_addr_t(tt->local, 0, gc),
-                    print_in_addr_t(tt->remote_netmask, 0, gc));
+        if (net_addr_ptp_v4_del(ctx, tt->actual_name, &tt->local,
+                                &tt->remote_netmask) < 0)
+        {
+            msg(M_WARN, "Linux can't del IP from TUN iface %s",
+                tt->actual_name);
+        }
     }
     else
     {
-        argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path,
-                    tt->actual_name, print_in_addr_t(tt->local, 0, gc),
-                    netmask_to_netbits2(tt->remote_netmask));
+        if (net_addr_v4_del(ctx, tt->actual_name, &tt->local, netbits) < 0)
+        {
+            msg(M_WARN, "Linux can't del IP from TAP iface %s",
+                tt->actual_name);
+        }
     }
-#else  /* ifdef ENABLE_IPROUTE */
+#else  /* ifdef TARGET_LINUX */
+    struct argv argv = argv_new();
+
     argv_printf(&argv, "%s %s 0.0.0.0", IFCONFIG_PATH, tt->actual_name);
-#endif /* ifdef ENABLE_IPROUTE */
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "Linux ip addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, "Generic ip addr del failed");
 
     argv_reset(&argv);
+#endif /* ifdef TARGET_LINUX */
 }
 
 void
-undo_ifconfig_ipv6(struct tuntap *tt, struct gc_arena *gc)
+undo_ifconfig_ipv6(struct tuntap *tt, struct gc_arena *gc,
+                   openvpn_net_ctx_t *ctx)
 {
+#if defined(TARGET_LINUX)
+    if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6,
+                        tt->netbits_ipv6) < 0)
+    {
+        msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
+    }
+#else  /* ifdef TARGET_LINUX */
     const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, gc);
     struct argv argv = argv_new();
 
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 addr del %s/%d dev %s", iproute_path,
-                ifconfig_ipv6_local, tt->netbits_ipv6, tt->actual_name);
-#else  /* ifdef ENABLE_IPROUTE */
     argv_printf(&argv, "%s %s del %s/%d", IFCONFIG_PATH, tt->actual_name,
                 ifconfig_ipv6_local, tt->netbits_ipv6);
-#endif
 
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
 
     argv_reset(&argv);
+#endif /* ifdef TARGET_LINUX */
 }
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -2002,12 +2017,12 @@ close_tun(struct tuntap *tt)
 
         if (tt->did_ifconfig_setup)
         {
-            undo_ifconfig_ipv4(tt, &gc);
+            undo_ifconfig_ipv4(tt, &gc, ctx);
         }
 
         if (tt->did_ifconfig_ipv6_setup)
         {
-            undo_ifconfig_ipv6(tt, &gc);
+            undo_ifconfig_ipv6(tt, &gc, ctx);
         }
 
         gc_free(&gc);
@@ -2327,7 +2342,7 @@ solaris_close_tun(struct tuntap *tt)
  * Close TUN device.
  */
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -2363,7 +2378,7 @@ solaris_error_close(struct tuntap *tt, const struct env_set *es,
 
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
-    close_tun(tt);
+    close_tun(tt, NULL);
     msg(M_FATAL, "Solaris ifconfig failed");
     argv_reset(&argv);
 }
@@ -2426,7 +2441,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  */
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -2512,7 +2527,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  * need to be explicitely destroyed
  */
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -2653,7 +2668,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  * we need to call "ifconfig ... destroy" for cleanup
  */
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -2769,7 +2784,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -3025,7 +3040,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -3173,7 +3188,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 /* tap devices need to be manually destroyed on AIX
  */
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -6069,7 +6084,7 @@ tun_show_debug(struct tuntap *tt)
 }
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
@@ -6244,7 +6259,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index cb1ab1cc..a68ecaa9 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -36,6 +36,7 @@
 #include "event.h"
 #include "proto.h"
 #include "misc.h"
+#include "networking.h"
 
 #if defined(_WIN32) || defined(TARGET_ANDROID)
 
@@ -211,7 +212,7 @@ tuntap_defined(const struct tuntap *tt)
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
               struct tuntap *tt);
 
-void close_tun(struct tuntap *tt);
+void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 int write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
@@ -219,7 +220,8 @@ int read_tun(struct tuntap *tt, uint8_t *buf, int len);
 
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node,
             int persist_mode, const char *username,
-            const char *groupname, const struct tuntap_options *options);
+            const char *groupname, const struct tuntap_options *options,
+            openvpn_net_ctx_t *ctx);
 
 const char *guess_tuntap_dev(const char *dev,
                              const char *dev_type,
@@ -237,7 +239,8 @@ struct tuntap *init_tun(const char *dev,        /* --dev option */
                         struct addrinfo *local_public,
                         struct addrinfo *remote_public,
                         const bool strict_warn,
-                        struct env_set *es);
+                        struct env_set *es,
+                        openvpn_net_ctx_t *ctx);
 
 void init_tun_post(struct tuntap *tt,
                    const struct frame *frame,
@@ -253,9 +256,10 @@ void do_ifconfig_setenv(const struct tuntap *tt,
  * @param ifname    the human readable interface name
  * @param mtu       the MTU value to set the interface to
  * @param es        the environment to be used when executing the commands
+ * @param ctx       the networking API opaque context
  */
 void do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es);
+                 const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const char *dev_type, const char *match_type);
 
-- 
2.19.1


