From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Oct 2018 02:41:55 +0800
Message-Id: <20181011184200.22175-3-a@...2181...>
In-Reply-To: <20181011184200.22175-1-a@...2181...>
References: <20181011184200.22175-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/7] implement networking API for iproute2
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

iproute2 is the first user of the new networking API and
its one of the two currently supported functionalities on
Linux (the other being net-tools).

This patch simply copies the current code from tun.c/route.c
to networking_ip.c without introducing any funcional
change to the code.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/Makefile.am     |   2 +-
 src/openvpn/networking_ip.c | 386 ++++++++++++++++++++++++++++++++++++
 src/openvpn/networking_ip.h |  36 ++++
 3 files changed, 423 insertions(+), 1 deletion(-)
 create mode 100644 src/openvpn/networking_ip.c
 create mode 100644 src/openvpn/networking_ip.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 8afc4146..3caad17d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -80,7 +80,7 @@ openvpn_SOURCES = \
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
-	networking.h \
+	networking_ip.c networking_ip.h networking.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h \
 	openssl_compat.h \
diff --git a/src/openvpn/networking_ip.c b/src/openvpn/networking_ip.c
new file mode 100644
index 00000000..ae667a9c
--- /dev/null
+++ b/src/openvpn/networking_ip.c
@@ -0,0 +1,386 @@
+/*
+ *  Networking API implementation for iproute2
+ *
+ *  Copyright (C) 2018 Antonio Quartulli <a@...2181...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(TARGET_LINUX) && defined(ENABLE_IPROUTE)
+
+#include "syshead.h"
+
+#include "networking.h"
+#include "networking_ip.h"
+#include "misc.h"
+#include "openvpn.h"
+#include "run_command.h"
+#include "socket.h"
+
+#include <stdbool.h>
+#include <netinet/in.h>
+
+int
+net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+{
+    ctx->es = NULL;
+    if (c)
+        ctx->es = c->es;
+
+    return 0;
+}
+
+int
+net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
+{
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s link set dev %s %s", iproute_path, iface,
+                up ? "up" : "down");
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
+{
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, iface,
+                mtu);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
+
+    return 0;
+}
+
+int
+net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
+                const in_addr_t *addr, int prefixlen,
+                const in_addr_t *broadcast)
+{
+    struct argv argv = argv_new();
+
+    char *addr_str = (char *)print_in_addr_t(*addr, 0, NULL);
+    char *brd_str = (char *)print_in_addr_t(*broadcast, 0, NULL);
+
+    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_path,
+                iface, addr_str, prefixlen, brd_str);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
+
+    free(addr_str);
+    free(brd_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
+                const struct in6_addr *addr, int prefixlen)
+{
+    struct argv argv = argv_new();
+    char *addr_str = (char *)print_in6_addr(*addr, 0, NULL);
+
+    argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path, addr_str,
+                prefixlen, iface);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL,
+                         "Linux ip -6 addr add failed");
+
+    free(addr_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
+                const in_addr_t *addr, int prefixlen)
+{
+    struct argv argv = argv_new();
+    char *addr_str = (char *)print_in_addr_t(*addr, 0, NULL);
+
+    argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface,
+                addr_str, prefixlen);
+
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
+
+    free(addr_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface,
+                const struct in6_addr *addr, int prefixlen)
+{
+    struct argv argv = argv_new();
+    char *addr_str = (char *)print_in6_addr(*addr, 0, NULL);
+
+    argv_printf(&argv, "%s -6 addr del %s/%d dev %s", iproute_path,
+                addr_str, prefixlen, iface);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "Linux ip -6 addr del failed");
+
+    free(addr_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
+                    const in_addr_t *local, const in_addr_t *remote)
+{
+    struct argv argv = argv_new();
+    char *local_str = (char *)print_in_addr_t(*local, 0, NULL);
+    char *remote_str = (char *)print_in_addr_t(*remote, 0, NULL);
+
+    argv_printf(&argv, "%s addr add dev %s local %s peer %s", iproute_path,
+                iface, local_str, remote_str);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
+
+    free(local_str);
+    free(remote_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
+                    const in_addr_t *local, const in_addr_t *remote)
+{
+    struct argv argv = argv_new();
+    char *local_str = (char *)print_in_addr_t(*local, 0, NULL);
+    char *remote_str = (char *)print_in_addr_t(*remote, 0, NULL);
+
+    argv_printf(&argv, "%s addr del dev %s local %s peer %s", iproute_path,
+                iface, local_str, remote_str);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
+
+    free(local_str);
+    free(remote_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+                 const in_addr_t *gw, const char *iface, uint32_t table,
+                 int metric)
+{
+    struct argv argv = argv_new();
+    char *dst_str = (char *)print_in_addr_t(*dst, 0, NULL);
+
+    argv_printf(&argv, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
+
+    if (metric > 0)
+        argv_printf_cat(&argv, "metric %d", metric);
+
+    if (iface)
+        argv_printf_cat(&argv, "dev %s", iface);
+
+    if (gw)
+    {
+        char *gw_str = (char *)print_in_addr_t(*gw, 0, NULL);
+
+        argv_printf_cat(&argv, "via %s", gw_str);
+
+        free(gw_str);
+    }
+
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route add command failed");
+
+    free(dst_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                 int prefixlen, const struct in6_addr *gw, const char *iface,
+                 uint32_t table, int metric)
+{
+    struct argv argv = argv_new();
+    char *dst_str = (char *)print_in6_addr(*dst, 0, NULL);
+
+    argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_str,
+                prefixlen, iface);
+
+    if (gw)
+    {
+        char *gw_str = (char *)print_in6_addr(*gw, 0, NULL);
+
+        argv_printf_cat(&argv, "via %s", gw_str);
+
+        free(gw_str);
+    }
+
+    if (metric > 0)
+        argv_printf_cat(&argv, "metric %d", metric);
+
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed");
+
+    free(dst_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+                 const in_addr_t *gw, const char *iface, uint32_t table,
+                 int metric)
+{
+    struct argv argv = argv_new();
+    char *dst_str = (char *)print_in_addr_t(*dst, 0, NULL);
+
+    argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
+
+    if (metric > 0)
+        argv_printf_cat(&argv, "metric %d", metric);
+
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed");
+
+    free(dst_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                 int prefixlen, const struct in6_addr *gw, const char *iface,
+                 uint32_t table, int metric)
+{
+    struct argv argv = argv_new();
+    char *dst_str = (char *)print_in6_addr(*dst, 0, NULL);
+
+    argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_path, dst_str,
+                prefixlen, iface);
+
+    if (gw)
+    {
+        char *gw_str = (char *)print_in6_addr(*gw, 0, NULL);
+
+        argv_printf_cat(&argv, "via %s", gw_str);
+
+        free(gw_str);
+    }
+
+    if (metric > 0)
+        argv_printf_cat(&argv, "metric %d", metric);
+
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed");
+
+    free(dst_str);
+
+    argv_reset(&argv);
+
+    return 0;
+}
+
+int
+net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
+                     int prefixlen, in_addr_t *best_gw, char *best_iface)
+{
+    best_iface[0] = '\0';
+
+    FILE *fp = fopen("/proc/net/route", "r");
+    if (!fp)
+        return -1;
+
+    char line[256];
+    int count = 0;
+    unsigned int lowest_metric = UINT_MAX;
+    while (fgets(line, sizeof(line), fp) != NULL)
+    {
+        if (count)
+        {
+            unsigned int net_x = 0;
+            unsigned int mask_x = 0;
+            unsigned int gw_x = 0;
+            unsigned int metric = 0;
+            unsigned int flags = 0;
+            char name[16];
+            name[0] = '\0';
+
+            const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
+                                  name, &net_x, &gw_x, &flags, &metric,
+                                  &mask_x);
+
+            if (np == 6 && (flags & IFF_UP))
+            {
+                const in_addr_t net = ntohl(net_x);
+                const in_addr_t mask = ntohl(mask_x);
+                const in_addr_t gw = ntohl(gw_x);
+
+                if (!net && !mask && metric < lowest_metric)
+                {
+                    *best_gw = gw;
+                    strcpy(best_iface, name);
+                    lowest_metric = metric;
+                }
+            }
+        }
+        ++count;
+    }
+    fclose(fp);
+
+    return 0;
+}
+
+/*
+ * The following function is not implemented in the iproute backend as it
+ * already uses netlink in route.c.
+ *
+ * int
+ * net_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
+ *                      struct in6_addr *best_gw, char *best_iface)
+ */
+
+#endif /* ENABLE_IPROUTE && TARGET_LINUX */
diff --git a/src/openvpn/networking_ip.h b/src/openvpn/networking_ip.h
new file mode 100644
index 00000000..47b50a9f
--- /dev/null
+++ b/src/openvpn/networking_ip.h
@@ -0,0 +1,36 @@
+/*
+ *  Generic interface to platform specific networking code
+ *
+ *  Copyright (C) 2016-2018 Antonio Quartulli <a@...2181...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifndef NETWORKING_IP_H_
+#define NETWORKING_IP_H_
+
+#include "env_set.h"
+
+typedef char openvpn_net_iface_t;
+
+struct openvpn_net_ctx
+{
+    struct env_set *es;
+};
+
+typedef struct openvpn_net_ctx openvpn_net_ctx_t;
+
+#endif /* NETWORKING_IP_H_ */
-- 
2.19.1


