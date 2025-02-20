From: Gert Doering <gert@...1296...>
Date: Thu, 20 Feb 2025 13:42:05 +0100
Message-ID: <20250220124205.27502-1-gert@...1296...>
In-Reply-To: <gerrit.1736759998000.I36a5442c0a5667628f419bc64efe5fb562ad3b57@...2715...>
References: <gerrit.1736759998000.I36a5442c0a5667628f419bc64efe5fb562ad3b57@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v15] dco-win: support for iroutes
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

From: Lev Stipakov <lev@...515...>

Unlike Linux/FreeBSD, dco-win doesn't have access to a
system routing table, so we have to maintain internal routing
table in the driver. For that, we have 4 ioctls to add/delete
IPv4/IPv6 iroutes. When adding iroute, we pass peer-id, so that
the driver is able to associate a subnet with a peer context.

Change-Id: I36a5442c0a5667628f419bc64efe5fb562ad3b57
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/857
This mail reflects revision 15 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index c65aece..02fae81 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -649,7 +649,7 @@
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
                    struct mroute_addr *addr)
 {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -665,28 +665,34 @@
     }
 
     struct context *c = &mi->context;
-    const char *dev = c->c1.tuntap->actual_name;
-
     if (addrtype == MR_ADDR_IPV6)
     {
+#if defined(_WIN32)
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits, c->c2.tls_multi->peer_id);
+#else
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
-                         &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
+                         &mi->context.c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name, 0,
                          DCO_IROUTE_METRIC);
+#endif
     }
     else if (addrtype == MR_ADDR_IPV4)
     {
+#if defined(_WIN32)
+        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits, c->c2.tls_multi->peer_id);
+#else
         in_addr_t dest = htonl(addr->v4.addr);
         net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits,
-                         &mi->context.c2.push_ifconfig_local, dev, 0,
+                         &mi->context.c2.push_ifconfig_local, c->c1.tuntap->actual_name, 0,
                          DCO_IROUTE_METRIC);
+#endif
     }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
 
 void
 dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
     {
         return;
@@ -694,7 +700,6 @@
     ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
 
     struct context *c = &mi->context;
-    const char *dev = c->c1.tuntap->actual_name;
 
     if (mi->context.c2.push_ifconfig_defined)
     {
@@ -702,9 +707,13 @@
              ir;
              ir = ir->next)
         {
+#if defined(_WIN32)
+            dco_win_del_iroute_ipv4(&c->c1.tuntap->dco, htonl(ir->network), ir->netbits);
+#else
             net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
-                             &mi->context.c2.push_ifconfig_local, dev,
+                             &mi->context.c2.push_ifconfig_local, c->c1.tuntap->actual_name,
                              0, DCO_IROUTE_METRIC);
+#endif
         }
     }
 
@@ -714,12 +723,16 @@
              ir6;
              ir6 = ir6->next)
         {
+#if defined(_WIN32)
+            dco_win_del_iroute_ipv6(&c->c1.tuntap->dco, ir6->network, ir6->netbits);
+#else
             net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
-                             &mi->context.c2.push_ifconfig_ipv6_local, dev,
+                             &mi->context.c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name,
                              0, DCO_IROUTE_METRIC);
+#endif
         }
     }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) */
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
 
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index f46c93d..45cb919 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -823,4 +823,80 @@
     return dco_get_version(&ver) && ver.Major >= 2;
 }
 
+void
+dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits, unsigned int peer_id)
+{
+    struct gc_arena gc = gc_new();
+
+    OVPN_MP_IROUTE route = {.Addr.Addr4.S_un.S_addr = dst, .Netbits = netbits, .PeerId = peer_id, .IPv6 = 0};
+
+    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc), netbits, peer_id);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed");
+    }
+
+    gc_free(&gc);
+}
+
+void
+dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits, unsigned int peer_id)
+{
+    struct gc_arena gc = gc_new();
+
+    OVPN_MP_IROUTE route = { .Addr.Addr6 = dst, .Netbits = netbits, .PeerId = peer_id, .IPv6 = 1 };
+
+    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc), netbits, peer_id);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed");
+    }
+
+    gc_free(&gc);
+}
+
+void
+dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits)
+{
+    struct gc_arena gc = gc_new();
+
+    OVPN_MP_IROUTE route = { .Addr.Addr4.S_un.S_addr = dst, .Netbits = netbits, .PeerId = -1, .IPv6 = 0 };
+
+    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc), netbits);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_DEL_IROUTE) failed");
+    }
+
+    gc_free(&gc);
+}
+
+void
+dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits)
+{
+    struct gc_arena gc = gc_new();
+
+    OVPN_MP_IROUTE route = { .Addr.Addr6 = dst, .Netbits = netbits, .PeerId = -1, .IPv6 = 1 };
+
+    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc), netbits);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route,
+                         sizeof(route), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_DEL_IROUTE) failed");
+    }
+
+    gc_free(&gc);
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 309badf..95c95c8 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -24,6 +24,8 @@
 
 #if defined(ENABLE_DCO) && defined(_WIN32)
 
+#include <in6addr.h>
+
 #include "buffer.h"
 #include "ovpn_dco_win.h"
 #include "sig.h"
@@ -69,6 +71,18 @@
 bool
 dco_win_supports_multipeer(void);
 
+void
+dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits, unsigned int peer_id);
+
+void
+dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits, unsigned int peer_id);
+
+void
+dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits);
+
+void
+dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits);
+
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */
 
 static inline void
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index bfe939d..f6d745c 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -174,6 +174,16 @@
     int PeerId;
 } OVPN_MP_SWAP_KEYS, * POVPN_MP_SWAP_KEYS;
 
+typedef struct _OVPN_MP_IROUTE {
+    union {
+        IN_ADDR Addr4;
+        IN6_ADDR Addr6;
+    } Addr;
+    int Netbits;
+    int PeerId;
+    int IPv6;
+} OVPN_MP_IROUTE, * POVPN_MP_IROUTE;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)
@@ -193,3 +203,6 @@
 
 #define OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 17, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 18, METHOD_BUFFERED, FILE_ANY_ACCESS)

