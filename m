From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Apr 2018 19:16:17 +0800
Message-Id: <20180420111624.7230-2-a@...2181...>
In-Reply-To: <20180420111624.7230-1-a@...2181...>
References: <20180420111624.7230-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/8] implement platform generic networking
 API
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

tun.c and route.c contain all the code used by openvpn
to manage the tun interface and the routing table on all
the supported platforms.

Across the years, this resulted in a longer functions
and series of ifdefs.

This patch introduces a new "networking API" which aims at
creating a simple abstraction between the tun/route logic
and the platform dependent code.

The is API expected to be implemented outside of tun.c/route.c
by using platform specific functionalities.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/Makefile.am  |   1 +
 src/openvpn/networking.h | 225 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 src/openvpn/networking.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index eda08351..c94296d3 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -80,6 +80,7 @@ openvpn_SOURCES = \
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
+	networking.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h occ-inline.h \
 	openssl_compat.h \
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
new file mode 100644
index 00000000..87157dea
--- /dev/null
+++ b/src/openvpn/networking.h
@@ -0,0 +1,225 @@
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
+#ifndef NETWORKING_H_
+#define NETWORKING_H_
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#ifdef TARGET_LINUX
+
+#include <stdbool.h>
+#include <netinet/in.h>
+
+/**
+ * Bring interface up or down.
+ *
+ * @param iface     the interface to modify
+ * @param up        true if the interface has to be brought up, false otherwise
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_iface_up(const char *iface, bool up);
+
+/**
+ * Set the MTU for an interface
+ *
+ * @param iface     the interface to modify
+ * @param mtru      the new MTU
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_iface_mtu_set(const char *iface, uint32_t mtu);
+
+/**
+ * Add an IPv4 address to an interface
+ *
+ * @param iface     the interface where the address has to be added
+ * @param addr      the address to add
+ * @param prefixlen the prefix length of the network associated with the address
+ * @param broadcast the broadcast address to configure on the interface
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_addr_v4_add(const char *iface, const in_addr_t *addr, int prefixlen,
+                    const in_addr_t *broadcast);
+
+/**
+ * Add an IPv6 address to an interface
+ *
+ * @param iface     the interface where the address has to be added
+ * @param addr      the address to add
+ * @param prefixlen the prefix length of the network associated with the address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+
+int net_addr_v6_add(const char *iface, const struct in6_addr *addr,
+                    int prefixlen);
+
+/**
+ * Remove an IPv4 from an interface
+ *
+ * @param iface     the interface to remove the address from
+ * @param prefixlen the prefix length of the network associated with the address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_addr_v4_del(const char *iface, const in_addr_t *addr, int prefixlen);
+
+/**
+ * Remove an IPv6 from an interface
+ *
+ * @param iface     the interface to remove the address from
+ * @param prefixlen the prefix length of the network associated with the address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_addr_v6_del(const char *iface, const struct in6_addr *addr,
+                    int prefixlen);
+
+/**
+ * Add a point-to-point IPv4 address to an interface
+ *
+ * @param iface     the interface where the address has to be added
+ * @param local     the address to add
+ * @param remote    the associated p-t-p remote address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_addr_ptp_v4_add(const char *iface, const in_addr_t *local,
+                        const in_addr_t *remote);
+
+/**
+ * Remove a point-to-point IPv4 address from an interface
+ *
+ * @param iface     the interface to remove the address from
+ * @param local     the address to remove
+ * @param remote    the associated p-t-p remote address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_addr_ptp_v4_del(const char *iface, const in_addr_t *local,
+                        const in_addr_t *remote);
+
+
+/**
+ * Add a route for an IPv4 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_route_v4_add(const in_addr_t *dst, int prefixlen,
+                     const in_addr_t *gw, const char *iface, uint32_t table,
+                     int metric);
+
+/**
+ * Add a route for an IPv6 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_route_v6_add(const struct in6_addr *dst, int prefixlen,
+                     const struct in6_addr *gw, const char *iface,
+                     uint32_t table, int metric);
+
+/**
+ * Delete a route for an IPv4 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_route_v4_del(const in_addr_t *dst, int prefixlen,
+                     const in_addr_t *gw, const char *iface, uint32_t table,
+                     int metric);
+
+/**
+ * Delete a route for an IPv4 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_route_v6_del(const struct in6_addr *dst, int prefixlen,
+                     const struct in6_addr *gw, const char *iface,
+                     uint32_t table, int metric);
+
+/**
+ * Retrieve the gateway and outgoing interface for the specified IPv4
+ * address/network
+ *
+ * @param dst           The destination to lookup
+ * @param prefixlen     The length of the prefix of the destination
+ * @param best_gw       Location where the retrieved GW has to be stored
+ * @param best_iface    Location where the retrieved interface has to be stored
+ *
+ * @return              0 on success, a negative error code otherwise
+ */
+int net_route_v4_best_gw(const in_addr_t *dst, int prefixlen,
+                         in_addr_t *best_gw, char *best_iface);
+
+/**
+ * Retrieve the gateway and outgoing interface for the specified IPv6
+ * address/network
+ *
+ * @param dst           The destination to lookup
+ * @param prefixlen     The length of the prefix of the destination
+ * @param best_gw       Location where the retrieved GW has to be stored
+ * @param best_iface    Location where the retrieved interface has to be stored
+ *
+ * @return              0 on success, a negative error code otherwise
+ */
+int net_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
+                         struct in6_addr *best_gw, char *best_iface);
+
+#endif /* TARGET_LINUX */
+
+#endif /* NETWORKING_H_ */
-- 
2.17.0


