From: Antonio Quartulli <a@...2181...>
Date: Fri,  3 Sep 2021 18:11:13 +0200
Message-Id: <20210903161113.30498-2-a@...2181...>
In-Reply-To: <20210903161113.30498-1-a@...2181...>
References: <20210903161113.30498-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] set_lladdr: use networking API
 net_addr_ll_set() on Linux
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
Cc: Antonio Quartulli <a@...2181...>, Jan Hugo Prins <jprins@...2634...>

Make sure that set_addr() uses the proper networking backend when
setting the LL address of a TAP interface.

This operation was overlooked while implementing the networking APIs on
the Linux platform.

Reported-by: Jan Hugo Prins <jprins@...2634...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

This patch (along with 1/2) has been tested on buildbots, but I couldn't
run any specific test on any *BSD or Windows platform.

Linux with both iproute2 and sitnl works as expected.


 src/openvpn/init.c   |  5 +++--
 src/openvpn/lladdr.c | 30 +++++++++++++-----------------
 src/openvpn/lladdr.h |  3 ++-
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 386aee23..a17fe859 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1176,7 +1176,7 @@ do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
                ctx);
         if (options->persist_mode && options->lladdr)
         {
-            set_lladdr(options->dev, options->lladdr, NULL);
+            set_lladdr(ctx, options->dev, options->lladdr, NULL);
         }
         return true;
 #else  /* ifdef ENABLE_FEATURE_TUN_PERSIST */
@@ -1853,7 +1853,8 @@ do_open_tun(struct context *c)
     /* set the hardware address */
     if (c->options.lladdr)
     {
-        set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
+        set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.lladdr,
+                   c->c2.es);
     }
 
     /* do ifconfig */
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 22857eb7..f12c146f 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -15,10 +15,9 @@
 #include "lladdr.h"
 
 int
-set_lladdr(const char *ifname, const char *lladdr,
+set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,
            const struct env_set *es)
 {
-    struct argv argv = argv_new();
     int r;
 
     if (!ifname || !lladdr)
@@ -27,17 +26,13 @@ set_lladdr(const char *ifname, const char *lladdr,
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv,
-                "%s link set addr %s dev %s",
-                iproute_path, lladdr, ifname);
-#else
-    argv_printf(&argv,
-                "%s %s hw ether %s",
-                IFCONFIG_PATH,
-                ifname, lladdr);
-#endif
-#elif defined(TARGET_SOLARIS)
+    uint8_t addr[ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
+    r = net_addr_ll_set(ctx, ifname, addr) == 0;
+#else /* if defined(TARGET_LINUX) */
+    struct argv argv = argv_new();
+#if defined(TARGET_SOLARIS)
     argv_printf(&argv,
                 "%s %s ether %s",
                 IFCONFIG_PATH,
@@ -57,18 +52,19 @@ set_lladdr(const char *ifname, const char *lladdr,
                 "%s %s ether %s",
                 IFCONFIG_PATH,
                 ifname, lladdr);
-#else  /* if defined(TARGET_LINUX) */
+#else  /* if defined(TARGET_SOLARIS) */
     msg(M_WARN, "Sorry, but I don't know how to configure link layer addresses on this operating system.");
     return -1;
-#endif /* if defined(TARGET_LINUX) */
-
+#endif /* if defined(TARGET_SOLARIS) */
     argv_msg(M_INFO, &argv);
     r = openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address.");
+    argv_free(&argv);
+#endif /* if defined(TARGET_LINUX) */
+
     if (r)
     {
         msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr);
     }
 
-    argv_free(&argv);
     return r;
 }
diff --git a/src/openvpn/lladdr.h b/src/openvpn/lladdr.h
index f6ea2b12..0c8b4164 100644
--- a/src/openvpn/lladdr.h
+++ b/src/openvpn/lladdr.h
@@ -3,6 +3,7 @@
  */
 
 #include "misc.h"
+#include "networking.h"
 
-int set_lladdr(const char *ifname, const char *lladdr,
+int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,
                const struct env_set *es);
-- 
2.32.0


