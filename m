From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Aug 2019 11:25:26 +0200
Message-Id: <20190805092529.9467-4-a@...2181...>
In-Reply-To: <20190805092529.9467-1-a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/6] networking: extend API for better
 memory management
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

Networking backend implementations may need to allocate dynamic
resources that require an explicit free/release.
Since these cleanup are perfomed not very often, and only at specific
times, it makes sense to have the upper layer signal when it's the right
time to do so, by means of a new API call.

For this purpose two news APIs have been implemented:
- net_ctx_free() to release all backend specific resources. Expected to
  be called at application cleanup time;
- net_ctx_reset() to let backends release temporary resources (i.e.
  reset garbage collectors). To be invoked after routines that
  are expected to allocate memory (i.e. tun setup or shutdown).

In this patch related implementations for iproute2 and sitnl are also
provided.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/networking.h          | 26 +++++++++++
 src/openvpn/networking_iproute2.c | 74 ++++++++++++-------------------
 src/openvpn/networking_iproute2.h |  1 +
 src/openvpn/networking_sitnl.c    | 12 +++++
 src/openvpn/openvpn.c             |  1 +
 src/openvpn/route.c               |  8 ++++
 src/openvpn/tun.c                 |  5 +++
 7 files changed, 82 insertions(+), 45 deletions(-)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index cf967116..4075ed73 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -39,6 +39,18 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
     return 0;
 }
+
+static inline void
+net_ctx_reset(openvpn_net_ctx_t *ctx)
+{
+    (void)ctx;
+}
+
+static inline void
+net_ctx_free(openvpn_net_ctx_t *ctx)
+{
+    (void)ctx;
+}
 #endif
 
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
@@ -53,6 +65,20 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
  */
 int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);
 
+/**
+ * Release resources allocated by the internal garbage collector
+ *
+ * @param ctx       the implementation specific context
+ */
+void net_ctx_reset(openvpn_net_ctx_t *ctx);
+
+/**
+ * Release all resources allocated within the platform specific context object
+ *
+ * @param ctx       the implementation specific context to release
+ */
+void net_ctx_free(openvpn_net_ctx_t *ctx);
+
 /**
  * Bring interface up or down.
  *
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 5db9a78b..f06af724 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -43,10 +43,23 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
     ctx->es = NULL;
     if (c)
         ctx->es = c->es;
+    ctx->gc = gc_new();
 
     return 0;
 }
 
+void
+net_ctx_reset(openvpn_net_ctx_t *ctx)
+{
+    gc_reset(&ctx->gc);
+}
+
+void
+net_ctx_free(openvpn_net_ctx_t *ctx)
+{
+    gc_free(&ctx->gc);
+}
+
 int
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
@@ -82,17 +95,14 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
 {
     struct argv argv = argv_new();
 
-    char *addr_str = (char *)print_in_addr_t(*addr, 0, NULL);
-    char *brd_str = (char *)print_in_addr_t(*broadcast, 0, NULL);
+    char *addr_str = (char *)print_in_addr_t(*addr, 0, &ctx->gc);
+    char *brd_str = (char *)print_in_addr_t(*broadcast, 0, &ctx->gc);
 
     argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_path,
                 iface, addr_str, prefixlen, brd_str);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
-    free(addr_str);
-    free(brd_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -103,7 +113,7 @@ net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
                 const struct in6_addr *addr, int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in6_addr(*addr, 0, NULL);
+    char *addr_str = (char *)print_in6_addr(*addr, 0, &ctx->gc);
 
     argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path, addr_str,
                 prefixlen, iface);
@@ -111,8 +121,6 @@ net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
     openvpn_execve_check(&argv, ctx->es, S_FATAL,
                          "Linux ip -6 addr add failed");
 
-    free(addr_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -123,7 +131,7 @@ net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
                 const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in_addr_t(*addr, 0, NULL);
+    char *addr_str = (char *)print_in_addr_t(*addr, 0, &ctx->gc);
 
     argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface,
                 addr_str, prefixlen);
@@ -131,8 +139,6 @@ net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
 
-    free(addr_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -143,15 +149,13 @@ net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface,
                 const struct in6_addr *addr, int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in6_addr(*addr, 0, NULL);
+    char *addr_str = (char *)print_in6_addr(*addr, 0, &ctx->gc);
 
     argv_printf(&argv, "%s -6 addr del %s/%d dev %s", iproute_path,
                 addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip -6 addr del failed");
 
-    free(addr_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -162,17 +166,14 @@ net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
                     const in_addr_t *local, const in_addr_t *remote)
 {
     struct argv argv = argv_new();
-    char *local_str = (char *)print_in_addr_t(*local, 0, NULL);
-    char *remote_str = (char *)print_in_addr_t(*remote, 0, NULL);
+    char *local_str = (char *)print_in_addr_t(*local, 0, &ctx->gc);
+    char *remote_str = (char *)print_in_addr_t(*remote, 0, &ctx->gc);
 
     argv_printf(&argv, "%s addr add dev %s local %s peer %s", iproute_path,
                 iface, local_str, remote_str);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
-    free(local_str);
-    free(remote_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -183,17 +184,14 @@ net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
                     const in_addr_t *local, const in_addr_t *remote)
 {
     struct argv argv = argv_new();
-    char *local_str = (char *)print_in_addr_t(*local, 0, NULL);
-    char *remote_str = (char *)print_in_addr_t(*remote, 0, NULL);
+    char *local_str = (char *)print_in_addr_t(*local, 0, &ctx->gc);
+    char *remote_str = (char *)print_in_addr_t(*remote, 0, &ctx->gc);
 
     argv_printf(&argv, "%s addr del dev %s local %s peer %s", iproute_path,
                 iface, local_str, remote_str);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
 
-    free(local_str);
-    free(remote_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -205,7 +203,7 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
                  int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in_addr_t(*dst, 0, NULL);
+    char *dst_str = (char *)print_in_addr_t(*dst, 0, &ctx->gc);
 
     argv_printf(&argv, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
 
@@ -217,18 +215,14 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
 
     if (gw)
     {
-        char *gw_str = (char *)print_in_addr_t(*gw, 0, NULL);
+        char *gw_str = (char *)print_in_addr_t(*gw, 0, &ctx->gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
-
-        free(gw_str);
     }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route add command failed");
 
-    free(dst_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -240,18 +234,16 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
                  uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in6_addr(*dst, 0, NULL);
+    char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
 
     argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_str,
                 prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str = (char *)print_in6_addr(*gw, 0, NULL);
+        char *gw_str = (char *)print_in6_addr(*gw, 0, &ctx->gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
-
-        free(gw_str);
     }
 
     if (metric > 0)
@@ -260,8 +252,6 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed");
 
-    free(dst_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -273,7 +263,7 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
                  int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in_addr_t(*dst, 0, NULL);
+    char *dst_str = (char *)print_in_addr_t(*dst, 0, &ctx->gc);
 
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
 
@@ -283,8 +273,6 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed");
 
-    free(dst_str);
-
     argv_reset(&argv);
 
     return 0;
@@ -296,18 +284,16 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
                  uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in6_addr(*dst, 0, NULL);
+    char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
 
     argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_path, dst_str,
                 prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str = (char *)print_in6_addr(*gw, 0, NULL);
+        char *gw_str = (char *)print_in6_addr(*gw, 0, &ctx->gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
-
-        free(gw_str);
     }
 
     if (metric > 0)
@@ -316,8 +302,6 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed");
 
-    free(dst_str);
-
     argv_reset(&argv);
 
     return 0;
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index 47b50a9f..24c605db 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -29,6 +29,7 @@ typedef char openvpn_net_iface_t;
 struct openvpn_net_ctx
 {
     struct env_set *es;
+    struct gc_arena gc;
 };
 
 typedef struct openvpn_net_ctx openvpn_net_ctx_t;
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 21563905..976ecd28 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -540,6 +540,18 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
     return 0;
 }
 
+void
+net_ctx_reset(openvpn_net_ctx_t *ctx)
+{
+    (void)ctx;
+}
+
+void
+net_ctx_free(openvpn_net_ctx_t *ctx)
+{
+    (void)ctx;
+}
+
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
                      in_addr_t *best_gw, char *best_iface)
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index fb02b3de..a58d5075 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -332,6 +332,7 @@ openvpn_main(int argc, char *argv[])
             env_set_destroy(c.es);
             uninit_options(&c.options);
             gc_reset(&c.gc);
+            net_ctx_free(&c.net_ctx);
         }
         while (c.sig->signal_received == SIGHUP);
     }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bf036689..2d53c459 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1826,6 +1826,8 @@ done:
     }
     argv_reset(&argv);
     gc_free(&gc);
+    /* release resources potentially allocated during route setup */
+    net_ctx_reset(ctx);
 }
 
 
@@ -2130,6 +2132,8 @@ done:
     }
     argv_reset(&argv);
     gc_free(&gc);
+    /* release resources potentially allocated during route setup */
+    net_ctx_reset(ctx);
 }
 
 static void
@@ -2322,6 +2326,8 @@ done:
     r->flags &= ~RT_ADDED;
     argv_reset(&argv);
     gc_free(&gc);
+    /* release resources potentially allocated during route cleanup */
+    net_ctx_reset(ctx);
 }
 
 void
@@ -2548,6 +2554,8 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
 
     argv_reset(&argv);
     gc_free(&gc);
+    /* release resources potentially allocated during route cleanup */
+    net_ctx_reset(ctx);
 }
 
 /*
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8f8f7c6c..e66e69bf 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1435,6 +1435,9 @@ do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx);
     }
+
+    /* release resources potentially allocated during interface setup */
+    net_ctx_free(ctx);
 }
 
 static void
@@ -2027,6 +2030,8 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
 
         gc_free(&gc);
+        /* release resources potentially allocated during undo */
+        net_ctx_reset(ctx);
     }
 
     close_tun_generic(tt);
-- 
2.22.0


