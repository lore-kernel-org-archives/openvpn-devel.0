From: Kristof Provost <kprovost@...2661...>
Date: Fri, 12 Aug 2022 15:41:54 +0200
Message-Id: <20220812134154.16729-3-kprovost@...2661...>
In-Reply-To: <20220812134154.16729-1-kprovost@...2661...>
References: <20220812134154.16729-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Support creating iroute route entries
 on FreeBSD
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/Makefile.am          |   1 +
 src/openvpn/dco.c                |   8 +--
 src/openvpn/dco_freebsd.h        |   2 +
 src/openvpn/networking.h         |   9 +++
 src/openvpn/networking_freebsd.c | 101 +++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 src/openvpn/networking_freebsd.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2a139b23..5155a180 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -88,6 +88,7 @@ openvpn_SOURCES = \
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
+	networking_freebsd.c \
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
 	networking.h \
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 07dc1087..3ffc56d1 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -599,7 +599,7 @@ void
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
                    struct mroute_addr *addr)
 {
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -642,13 +642,13 @@ dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
                          &mi->context.c2.push_ifconfig_local, dev, 0,
                          DCO_IROUTE_METRIC);
     }
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */
 }
 
 void
 dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -681,7 +681,7 @@ dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
                              0, DCO_IROUTE_METRIC);
         }
     }
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */
 }
 
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 3594f229..7de11697 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -27,6 +27,8 @@
 
 #include "ovpn_dco_freebsd.h"
 
+#define DCO_IROUTE_METRIC   100
+
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_key_cipher dco_cipher_t;
 
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index cf6d39ac..b0b31ea1 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -31,6 +31,9 @@ struct context;
 #include "networking_sitnl.h"
 #elif ENABLE_IPROUTE
 #include "networking_iproute2.h"
+#elif defined(TARGET_FREEBSD)
+typedef void *openvpn_net_ctx_t;
+typedef char openvpn_net_iface_t;
 #else
 /* define mock types to ensure code builds on any platform */
 typedef void *openvpn_net_ctx_t;
@@ -238,7 +241,9 @@ int net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx,
                         const openvpn_net_iface_t *iface,
                         const in_addr_t *local, const in_addr_t *remote);
 
+#endif /* ENABLE_SITNL || ENABLE_IPROUTE */
 
+#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE) || defined(TARGET_FREEBSD)
 /**
  * Add a route for an IPv4 address/network
  *
@@ -315,6 +320,10 @@ int net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
                      const openvpn_net_iface_t *iface,
                      uint32_t table, int metric);
 
+#endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */
+
+#if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
+
 /**
  * Retrieve the gateway and outgoing interface for the specified IPv4
  * address/network
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
new file mode 100644
index 00000000..4e36941e
--- /dev/null
+++ b/src/openvpn/networking_freebsd.c
@@ -0,0 +1,101 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+#include "syshead.h"
+#include "errlevel.h"
+#include "run_command.h"
+#include "networking.h"
+
+#if defined(TARGET_FREEBSD)
+
+static int
+net_route_v4(const char *op, const in_addr_t *dst, int prefixlen,
+             const in_addr_t *gw, const char *iface, uint32_t table,
+             int metric)
+{
+    char buf1[16], buf2[16];
+    in_addr_t _dst, _gw;
+    struct argv argv = argv_new();
+    bool status;
+
+    _dst = ntohl(*dst);
+    _gw = ntohl(*gw);
+
+    argv_printf(&argv, "%s %s",
+                ROUTE_PATH, op);
+    argv_printf_cat(&argv, "-net %s/%d %s -fib %d",
+                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)),
+                    prefixlen,
+                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)),
+                    table);
+
+    argv_msg(M_INFO, &argv);
+    status = openvpn_execve_check(&argv, NULL, 0,
+                                  "ERROR: FreeBSD route add command failed");
+
+    argv_free(&argv);
+
+    return (!status);
+}
+
+static int
+net_route_v6(const char *op, const struct in6_addr *dst,
+             int prefixlen, const struct in6_addr *gw, const char *iface,
+             uint32_t table, int metric)
+{
+    char buf1[64], buf2[64];
+    struct argv argv = argv_new();
+    bool status;
+
+    argv_printf(&argv, "%s -6 %s",
+                ROUTE_PATH, op);
+    argv_printf_cat(&argv, "-net %s/%d %s -fib %d",
+                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)),
+                    prefixlen,
+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)),
+                    table);
+
+    argv_msg(M_INFO, &argv);
+    status = openvpn_execve_check(&argv, NULL, 0,
+                                  "ERROR: FreeBSD route add command failed");
+
+    argv_free(&argv);
+
+    return (!status);
+}
+
+int
+net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+                 const in_addr_t *gw, const char *iface, uint32_t table,
+                 int metric)
+{
+    return net_route_v4("add", dst, prefixlen, gw, iface, table, metric);
+}
+
+int
+net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                 int prefixlen, const struct in6_addr *gw, const char *iface,
+                 uint32_t table, int metric)
+{
+    return net_route_v6("add", dst, prefixlen, gw, iface, table, metric);
+}
+
+int
+net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+                 const in_addr_t *gw, const char *iface, uint32_t table,
+                 int metric)
+{
+    return net_route_v4("del", dst, prefixlen, gw, iface, table, metric);
+}
+
+int
+net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                 int prefixlen, const struct in6_addr *gw, const char *iface,
+                 uint32_t table, int metric)
+{
+    return net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
+}
+
+#endif
-- 
2.37.1


