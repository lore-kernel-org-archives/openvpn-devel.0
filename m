From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Aug 2019 11:25:27 +0200
Message-Id: <20190805092529.9467-5-a@...2181...>
In-Reply-To: <20190805092529.9467-1-a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/6] tun.c: undo_ifconfig_ipv4/6 remove
 useless gc argument
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

With the new networking APIs, each implementation handles garbage
collection internally and therefore does not require a gc object to be
provided by the outer layer.

However, there are a few cases where a garbage collector is still required.
In close_tun() move the declaration and cleanup of gc to the
area where it is used and simplify the surrounding code a bit.

While at it, fix a typo in a nearby ifdef comment.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/tun.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e66e69bf..bda4df95 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1950,9 +1950,8 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
 
 #endif /* ENABLE_FEATURE_TUN_PERSIST */
 
-void
-undo_ifconfig_ipv4(struct tuntap *tt, struct gc_arena *gc,
-                   openvpn_net_ctx_t *ctx)
+static void
+undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits = netmask_to_netbits2(tt->remote_netmask);
@@ -1974,7 +1973,7 @@ undo_ifconfig_ipv4(struct tuntap *tt, struct gc_arena *gc,
                 tt->actual_name);
         }
     }
-#else  /* ifdef TARGET_LINUX */
+#else  /* ifndef TARGET_LINUX */
     struct argv argv = argv_new();
 
     argv_printf(&argv, "%s %s 0.0.0.0", IFCONFIG_PATH, tt->actual_name);
@@ -1986,9 +1985,8 @@ undo_ifconfig_ipv4(struct tuntap *tt, struct gc_arena *gc,
 #endif /* ifdef TARGET_LINUX */
 }
 
-void
-undo_ifconfig_ipv6(struct tuntap *tt, struct gc_arena *gc,
-                   openvpn_net_ctx_t *ctx)
+static void
+undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6,
@@ -1996,7 +1994,8 @@ undo_ifconfig_ipv6(struct tuntap *tt, struct gc_arena *gc,
     {
         msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
     }
-#else  /* ifdef TARGET_LINUX */
+#else  /* ifndef TARGET_LINUX */
+    struct gc_arena gc = gc_new();
     const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, gc);
     struct argv argv = argv_new();
 
@@ -2007,6 +2006,7 @@ undo_ifconfig_ipv6(struct tuntap *tt, struct gc_arena *gc,
     openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
 
     argv_reset(&argv);
+    gc_free(&gc);
 #endif /* ifdef TARGET_LINUX */
 }
 
@@ -2017,19 +2017,16 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     if (tt->type != DEV_TYPE_NULL)
     {
-        struct gc_arena gc = gc_new();
-
         if (tt->did_ifconfig_setup)
         {
-            undo_ifconfig_ipv4(tt, &gc, ctx);
+            undo_ifconfig_ipv4(tt, ctx);
         }
 
         if (tt->did_ifconfig_ipv6_setup)
         {
-            undo_ifconfig_ipv6(tt, &gc, ctx);
+            undo_ifconfig_ipv6(tt, ctx);
         }
 
-        gc_free(&gc);
         /* release resources potentially allocated during undo */
         net_ctx_reset(ctx);
     }
-- 
2.22.0


