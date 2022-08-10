From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 10 Aug 2022 17:30:06 +0200
Message-ID: <20220810153006.18860-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Don't "undo" ifconfig on exit if it
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

v2: Fix tabs-vs-spaces.
v3: Fix another style mistake.
v4: Move undo_ifconfig{4,6}() out of #ifdef TARGET_LINUX.
v5: Keep ctx argument in close_tun().
v6: Fix bug in non-Linux non-Windows version of undo_ifconfig_ipv6

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/init.c |   4 ++
 src/openvpn/tun.c  | 159 +++++++++++++++++++++++----------------------
 src/openvpn/tun.h  |   8 +++
 3 files changed, 95 insertions(+), 76 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b6705921..ee800880 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1913,6 +1913,10 @@ do_close_tun_simple(struct context *c)
     msg(D_CLOSE, "Closing TUN/TAP interface");
     if (c->c1.tuntap)
     {
+        if (!c->options.ifconfig_noexec)
+        {
+            undo_ifconfig(c->c1.tuntap, &c->net_ctx);
+        }
         close_tun(c->c1.tuntap, &c->net_ctx);
         c->c1.tuntap = NULL;
     }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f3152a52..2df36c74 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1604,6 +1604,89 @@ do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
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
+#endif /* if defined(TARGET_LINUX) */
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
+    const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s %s del %s/%d", IFCONFIG_PATH, tt->actual_name,
+                ifconfig_ipv6_local, tt->netbits_ipv6);
+
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, NULL, 0, "Generic ip -6 addr del failed");
+
+    argv_free(&argv);
+    gc_free(&gc);
+#endif /* if defined(TARGET_LINUX) */
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
@@ -2213,87 +2296,11 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
 
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
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
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
 #ifdef TARGET_LINUX
     if (tun_dco_enabled(tt))
     {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8ec8f51f..3fdfcce6 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -300,6 +300,14 @@ void do_ifconfig_setenv(const struct tuntap *tt,
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


