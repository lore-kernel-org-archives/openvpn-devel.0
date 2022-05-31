From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Tue, 31 May 2022 17:17:46 +0200
Message-ID: <20220531151746.101904-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Don't "undo" ifconfig on exit if it
 wasn't done
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

When running with --ifconfig-noexec, OpenVPN does not execute ifconfig,
but on exit, it still tries to "undo" the configuration it would have
done. This patch fixes it by extracting an undo_ifconfig() function from
close_tun(). The undo function is called before close_tun(), but only if
--ifconfig-noexec isn't set. This is symmetric to how open_tun() and
do_ifconfig() are used.

This change also allows us to drop the second argument from close_tun().

v2: Fix tabs-vs-spaces.
v3: Fix another style mistake.
v4: Move undo_ifconfig{4,6}() out of #ifdef TARGET_LINUX.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/init.c |   9 ++-
 src/openvpn/tun.c  | 187 +++++++++++++++++++++++----------------------
 src/openvpn/tun.h  |  13 +++-
 3 files changed, 113 insertions(+), 96 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b0c62a85..949cdad0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1072,8 +1072,7 @@ do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
 #ifdef ENABLE_FEATURE_TUN_PERSIST
         tuncfg(options->dev, options->dev_type, options->dev_node,
                options->persist_mode,
-               options->username, options->groupname, &options->tuntap_options,
-               ctx);
+               options->username, options->groupname, &options->tuntap_options);
         if (options->persist_mode && options->lladdr)
         {
             set_lladdr(ctx, options->dev, options->lladdr, NULL);
@@ -1858,7 +1857,11 @@ do_close_tun_simple(struct context *c)
     msg(D_CLOSE, "Closing TUN/TAP interface");
     if (c->c1.tuntap)
     {
-        close_tun(c->c1.tuntap, &c->net_ctx);
+        if (!c->options.ifconfig_noexec)
+        {
+            undo_ifconfig(c->c1.tuntap, &c->net_ctx);
+        }
+        close_tun(c->c1.tuntap);
         c->c1.tuntap = NULL;
     }
     c->c1.tuntap_owned = false;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e12f0369..b863e9c9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1605,6 +1605,89 @@ do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
     net_ctx_free(ctx);
 }
 
+static void
+undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+#if defined(TARGET_LINUX)
+    int netbits = netmask_to_netbits2(tt->remote_netmask);
+
+    if (is_tun_p2p(tt))
+    {
+        if (net_addr_ptp_v4_del(ctx, tt->actual_name, &tt->local,
+                                &tt->remote_netmask) < 0)
+        {
+            msg(M_WARN, "Linux can't del IP from iface %s",
+                tt->actual_name);
+        }
+    }
+    else
+    {
+        if (net_addr_v4_del(ctx, tt->actual_name, &tt->local, netbits) < 0)
+        {
+            msg(M_WARN, "Linux can't del IP from iface %s",
+                tt->actual_name);
+        }
+    }
+#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32) */
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s %s 0.0.0.0", IFCONFIG_PATH, tt->actual_name);
+
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, NULL, 0, "Generic ip addr del failed");
+
+    argv_free(&argv);
+#endif /* ifdef TARGET_LINUX */
+       /* Empty for _WIN32. */
+}
+
+static void
+undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+#if defined(TARGET_LINUX)
+    if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6,
+                        tt->netbits_ipv6) < 0)
+    {
+        msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
+    }
+#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32) */
+    struct gc_arena gc = gc_new();
+    const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, gc);
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s %s del %s/%d", IFCONFIG_PATH, tt->actual_name,
+                ifconfig_ipv6_local, tt->netbits_ipv6);
+
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
+
+    argv_free(&argv);
+    gc_free(&gc);
+#endif /* ifdef TARGET_LINUX */
+       /* Empty for _WIN32. */
+}
+
+void
+undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+    if (tt->type != DEV_TYPE_NULL)
+    {
+        if (tt->did_ifconfig_setup)
+        {
+            undo_ifconfig_ipv4(tt, ctx);
+        }
+
+        if (tt->did_ifconfig_ipv6_setup)
+        {
+            undo_ifconfig_ipv6(tt, ctx);
+        }
+
+        /* release resources potentially allocated during undo */
+        net_ctx_reset(ctx);
+    }
+
+}
+
 static void
 clear_tuntap(struct tuntap *tuntap)
 {
@@ -1910,7 +1993,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2073,7 +2156,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node,
        int persist_mode, const char *username, const char *groupname,
-       const struct tuntap_options *options, openvpn_net_ctx_t *ctx)
+       const struct tuntap_options *options)
 {
     struct tuntap *tt;
 
@@ -2112,93 +2195,17 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
             msg(M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev);
         }
     }
-    close_tun(tt, ctx);
+    close_tun(tt);
     msg(M_INFO, "Persist state set to: %s", (persist_mode ? "ON" : "OFF"));
 }
 
 #endif /* ENABLE_FEATURE_TUN_PERSIST */
 
-static void
-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
-{
-#if defined(TARGET_LINUX)
-    int netbits = netmask_to_netbits2(tt->remote_netmask);
-
-    if (is_tun_p2p(tt))
-    {
-        if (net_addr_ptp_v4_del(ctx, tt->actual_name, &tt->local,
-                                &tt->remote_netmask) < 0)
-        {
-            msg(M_WARN, "Linux can't del IP from iface %s",
-                tt->actual_name);
-        }
-    }
-    else
-    {
-        if (net_addr_v4_del(ctx, tt->actual_name, &tt->local, netbits) < 0)
-        {
-            msg(M_WARN, "Linux can't del IP from iface %s",
-                tt->actual_name);
-        }
-    }
-#else  /* ifndef TARGET_LINUX */
-    struct argv argv = argv_new();
-
-    argv_printf(&argv, "%s %s 0.0.0.0", IFCONFIG_PATH, tt->actual_name);
-
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "Generic ip addr del failed");
-
-    argv_free(&argv);
-#endif /* ifdef TARGET_LINUX */
-}
-
-static void
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
-{
-#if defined(TARGET_LINUX)
-    if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6,
-                        tt->netbits_ipv6) < 0)
-    {
-        msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
-    }
-#else  /* ifndef TARGET_LINUX */
-    struct gc_arena gc = gc_new();
-    const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, gc);
-    struct argv argv = argv_new();
-
-    argv_printf(&argv, "%s %s del %s/%d", IFCONFIG_PATH, tt->actual_name,
-                ifconfig_ipv6_local, tt->netbits_ipv6);
-
-    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
-
-    argv_free(&argv);
-    gc_free(&gc);
-#endif /* ifdef TARGET_LINUX */
-}
-
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
-    if (tt->type != DEV_TYPE_NULL)
-    {
-        if (tt->did_ifconfig_setup)
-        {
-            undo_ifconfig_ipv4(tt, ctx);
-        }
-
-        if (tt->did_ifconfig_ipv6_setup)
-        {
-            undo_ifconfig_ipv6(tt, ctx);
-        }
-
-        /* release resources potentially allocated during undo */
-        net_ctx_reset(ctx);
-    }
-
     close_tun_generic(tt);
     free(tt);
 }
@@ -2513,7 +2520,7 @@ solaris_close_tun(struct tuntap *tt)
  * Close TUN device.
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2546,7 +2553,7 @@ solaris_error_close(struct tuntap *tt, const struct env_set *es,
 
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
-    close_tun(tt, NULL);
+    close_tun(tt);
     msg(M_FATAL, "Solaris ifconfig failed");
     argv_free(&argv);
 }
@@ -2609,7 +2616,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  */
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2695,7 +2702,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  * need to be explicitly destroyed
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2836,7 +2843,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  * we need to call "ifconfig ... destroy" for cleanup
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2952,7 +2959,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -3218,7 +3225,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -3366,7 +3373,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 /* tap devices need to be manually destroyed on AIX
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -6704,7 +6711,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -6887,7 +6894,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4bc35916..4e41f6ff 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -247,7 +247,7 @@ tuntap_ring_empty(struct tuntap *tt)
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
               struct tuntap *tt);
 
-void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void close_tun(struct tuntap *tt);
 
 int write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
@@ -255,8 +255,7 @@ int read_tun(struct tuntap *tt, uint8_t *buf, int len);
 
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node,
             int persist_mode, const char *username,
-            const char *groupname, const struct tuntap_options *options,
-            openvpn_net_ctx_t *ctx);
+            const char *groupname, const struct tuntap_options *options);
 
 const char *guess_tuntap_dev(const char *dev,
                              const char *dev_type,
@@ -296,6 +295,14 @@ void do_ifconfig_setenv(const struct tuntap *tt,
 void do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
                  const struct env_set *es, openvpn_net_ctx_t *ctx);
 
+/**
+ * undo_ifconfig - undo configuration of the tunnel interface
+ *
+ * @param tt    the tuntap interface context
+ * @param ctx   the networking API opaque context
+ */
+void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+
 bool is_dev_type(const char *dev, const char *dev_type, const char *match_type);
 
 int dev_type_enum(const char *dev, const char *dev_type);
-- 
2.30.2


