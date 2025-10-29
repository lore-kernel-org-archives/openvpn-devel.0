From: Gert Doering <gert@...1296...>
Date: Wed, 29 Oct 2025 08:06:56 +0100
Message-ID: <20251029070701.11457-1-gert@...1296...>
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v14] Install host routes for ifconfig-push
 routes when DCO is enabled
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

From: Arne Schwabe <arne@...1227...>

ifconfig-push and ifconfig-ipv6-push can configure the IP address of a
client. If this IP address lies inside the network that is configured
on the ovpn/tun device this works as expected as the routing table point to
the ovpn/tun interface. However, if the IP address
is outside that range, the IP packets are not forwarded to the ovpn/tun
interface.

This patch adds logic to add host routes for these
ifconfig-push/ifconfig-ipv6-push addresses to ensure that traffic for
these IP addresses is also directed to the VPN.

For Linux it is important that these extra routes are routes using scope link
rather than static since otherwise routes via these IP addresses, like
iroute, will not work. On FreeBSD we also use interface routes as works and
routes that target interfaces instead of IP addresses are less brittle.

Tested using a server with ccd:

   openvpn --server 10.33.0.0 255.255.192.0 --server-ipv6 fd00:f00f::1/64  --client-config-dir ~/ccd [...]

and a client with lwipvonpn and the following ccd file:

   iroute-ipv6 FD00:F00F:CAFE::1001/64
   ifconfig-ipv6-push FD00:F00F:D00D::77/64
   push "setenv-safe ifconfig_ipv6_local_2 FD00:F00F:CAFE::1001"
   push "setenv-safe ifconfig_ipv6_netbits_2 64"

   iroute 10.234.234.0 255.255.255.0
   ifconfig-push 10.11.12.13 255.255.255.0
   push "setenv-safe ifconfig_local_2 10.234.234.12"
   push "setenv-safe ifconfig_netmask_2 255.255.255.0"

This setups an ifconfig-push addresses outside the --server/--server-ipv6
network and additionally configures a iroute behind that client. The
setenv-safe configure lwipovpn to use that additional IP addresses to allow
testing via ping.

Windows behaves like the user space implementation. It does require these
special routes but instead (like user space) needs static routes to redirect
IP traffic for these IP addresses to the tunnel interface. E.g. in the example
above the server config needs to have:

   route 10.234.234.0 255.255.255.0
   route 10.11.12.0 255.255.255.0

   route-ipv6 FD00:F00F:CAFE::1001/64
   route-ipv6 FD00:F00F:D00D::77/64

Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1192
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1192
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index ccc1374..9c7fa46 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -314,6 +314,10 @@
   3.  Use ``--ifconfig-pool`` allocation for dynamic IP (last
       choice).
 
+  When DCO is enabled and the IP is not in contained in the network specified
+  by ``--ifconfig``, OpenVPN will install a /32 host route for the ``local``
+  IP address.
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 interface
   configuration, see ``--client-config-dir`` and ``--ifconfig-push`` for
@@ -324,6 +328,10 @@
 
      ifconfig-ipv6-push ipv6addr/bits ipv6remote
 
+  When DCO is enabled and the IP is not in contained in the network specified
+  by ``--ifconfig-ipv6``, OpenVPN will install a /128 host route for the
+  ``ipv6addr`` IP address.
+
 --multihome
   Configure a multi-homed UDP server. This option needs to be used when a
   server has more than one IP address (e.g. multiple interfaces, or
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 8fb4662..7abdad3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -664,6 +664,14 @@
         return;
     }
 
+#if defined(_WIN32)
+    if (addr->type & MR_ONLINK_DCO_ADDR)
+    {
+        /* Windows does not need these extra routes, so we ignore/skip them */
+        return;
+    }
+#endif
+
     struct context *c = &mi->context;
     if (addrtype == MR_ADDR_IPV6)
     {
@@ -671,8 +679,14 @@
         dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits,
                                 c->c2.tls_multi->peer_id);
 #else
+        const struct in6_addr *gateway = &mi->context.c2.push_ifconfig_ipv6_local;
+        if (addr->type & MR_ONLINK_DCO_ADDR)
+        {
+            gateway = NULL;
+        }
+
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
-                         &mi->context.c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name, 0,
+                         gateway, c->c1.tuntap->actual_name, 0,
                          DCO_IROUTE_METRIC);
 #endif
     }
@@ -683,7 +697,13 @@
                                 c->c2.tls_multi->peer_id);
 #else
         in_addr_t dest = htonl(addr->v4.addr);
-        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, &mi->context.c2.push_ifconfig_local,
+        const in_addr_t *gateway = &mi->context.c2.push_ifconfig_local;
+        if (addr->type & MR_ONLINK_DCO_ADDR)
+        {
+            gateway = NULL;
+        }
+
+        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, gateway,
                          c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
 #endif
     }
@@ -714,6 +734,20 @@
                              DCO_IROUTE_METRIC);
 #endif
         }
+
+#if !defined(_WIN32)
+        /* Check if we added a host route as the assigned client IP address was
+         * not in the on link scope defined by --ifconfig */
+        in_addr_t ifconfig_local = mi->context.c2.push_ifconfig_local;
+
+        if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))
+        {
+            /* On windows we do not install these routes, so we also do not need to delete them */
+            net_route_v4_del(&m->top.net_ctx, &ifconfig_local,
+                             32, NULL, c->c1.tuntap->actual_name, 0,
+                             DCO_IROUTE_METRIC);
+        }
+#endif
     }
 
     if (mi->context.c2.push_ifconfig_ipv6_defined)
@@ -728,6 +762,18 @@
                              DCO_IROUTE_METRIC);
 #endif
         }
+
+        /* Checked if we added a host route as the assigned client IP address was
+         * outside the --ifconfig-ipv6 tun interface config */
+#if !defined(_WIN32)
+        struct in6_addr *dest = &mi->context.c2.push_ifconfig_ipv6_local;
+        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
+        {
+            /* On windows we do not install these routes, so we also do not need to delete them */
+            net_route_v6_del(&m->top.net_ctx, dest, 128, NULL,
+                             c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
+        }
+#endif
     }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 5b0c694..afd2e6c 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -20,6 +20,7 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
+
 #ifndef MROUTE_H
 #define MROUTE_H
 
@@ -74,6 +75,9 @@
 /* Address type mask indicating that proto # is part of address */
 #define MR_WITH_PROTO 32
 
+/* MRoute is an on link/scope address needed for DCO on Unix platforms */
+#define MR_ONLINK_DCO_ADDR 64
+
 struct mroute_addr
 {
     uint8_t len;     /* length of address */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f60944d..ba35556 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -42,6 +42,7 @@
 #include "ssl_ncp.h"
 #include "vlan.h"
 #include "auth_token.h"
+#include "route.h"
 #include <inttypes.h>
 #include <string.h>
 
@@ -1231,11 +1232,18 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
 #endif
-    if (!primary)
+    if (primary && multi_check_push_ifconfig_extra_route(mi, addr.v4.addr))
     {
-        /* "primary" is the VPN ifconfig address of the peer and already
-         * known to DCO, so only install "extra" iroutes (primary = false)
-         */
+        /* "primary" is the VPN ifconfig address of the peer */
+        /* if it does not fall into the network defined by ifconfig_local
+         * we install this as extra onscope address on the interface  */
+        addr.netbits = 32;
+        addr.type |= MR_ONLINK_DCO_ADDR;
+
+        dco_install_iroute(m, mi, &addr);
+    }
+    else if (!primary)
+    {
         ASSERT(netbits >= 0); /* DCO requires populated netbits */
         dco_install_iroute(m, mi, &addr);
     }
@@ -1269,7 +1277,17 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
 #endif
-    if (!primary)
+    if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi, &addr.v6.addr))
+    {
+        /* "primary" is the VPN ifconfig address of the peer */
+        /* if it does not fall into the network defined by ifconfig_local
+         * we install this as extra onscope address on the interface  */
+        addr.netbits = 128;
+        addr.type |= MR_ONLINK_DCO_ADDR;
+
+        dco_install_iroute(m, mi, &addr);
+    }
+    else if (!primary)
     {
         /* "primary" is the VPN ifconfig address of the peer and already
          * known to DCO, so only install "extra" iroutes (primary = false)
@@ -4391,3 +4409,49 @@
         }
     }
 }
+
+bool
+multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)
+{
+    struct options *o = &mi->context.options;
+    in_addr_t local_addr, local_netmask;
+
+    if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
+    {
+        /* If we do not have a local address, we just return false as
+         * this check doesn't make sense. */
+        return false;
+    }
+
+    /* if it falls into the network defined by ifconfig_local we assume
+     * it is already known to DCO and only install "extra" iroutes  */
+    inet_pton(AF_INET, o->ifconfig_local, &local_addr);
+    inet_pton(AF_INET, o->ifconfig_remote_netmask, &local_netmask);
+
+    return (local_addr & local_netmask) != (dest & local_netmask);
+}
+
+bool
+multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
+                                           struct in6_addr *dest)
+{
+    struct options *o = &mi->context.options;
+
+    if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
+    {
+        /* If we do not have a local address, we just return false as
+         * this check doesn't make sense. */
+        return false;
+    }
+
+    /* if it falls into the network defined by ifconfig_local we assume
+     * it is already known to DCO and only install "extra" iroutes  */
+    struct in6_addr ifconfig_local;
+    if (inet_pton(AF_INET6, o->ifconfig_ipv6_local, &ifconfig_local) != 1)
+    {
+        return false;
+    }
+
+    return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv6_netbits,
+                                    dest));
+}
\ No newline at end of file
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 594ea3a..2fbb433 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -665,6 +665,33 @@
     return ret;
 }
 
+/**
+ * Determines if the ifconfig_push_local address falls into the range of the local
+ * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
+ *
+ * @param mi           The multi-instance to check this condition for
+ * @param dest         The destination IP address to check
+ *
+ * @return Returns true if ifconfig_push is outside that range and requires an extra
+ * route to be installed.
+ */
+bool
+multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest);
+
+/**
+ * Determines if the ifconfig_ipv6_local address falls into the range of the local
+ * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
+ *
+ * @param mi           The multi-instance to check this condition for
+ * @param dest         The destination IPv6 address to check
+ *
+ * @return Returns true if ifconfig_push is outside that range and requires an extra
+ * route to be installed.
+ */
+bool
+multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
+                                           struct in6_addr *dest);
+
 /*
  * Check for signals.
  */

