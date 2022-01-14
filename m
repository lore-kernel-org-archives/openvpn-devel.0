From: Antonio Quartulli <a@...2181...>
Date: Fri, 14 Jan 2022 18:14:42 +0100
Message-Id: <20220114171446.26446-4-a@...2181...>
In-Reply-To: <20220114171446.26446-1-a@...2181...>
References: <20220114171446.26446-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC v2 3/7] networking: implement net_iface_new
 and net_iface_del APIs
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

These two new methods can be used to create and delete a tun or an
ovpn-dco interface via networking API.

Implementations for SITNL and iproute2 are provided

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking.h                   | 26 ++++++++++
 src/openvpn/networking_iproute2.c          | 34 ++++++++++++
 src/openvpn/networking_sitnl.c             | 60 ++++++++++++++++++++++
 tests/unit_tests/openvpn/test_networking.c | 22 +++++++-
 4 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 2f0ee160..a21d38f4 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -35,6 +35,12 @@ typedef void *openvpn_net_ctx_t;
 typedef void *openvpn_net_iface_t;
 #endif /* ifdef ENABLE_SITNL */
 
+enum iface_type {
+    IFACE_DUMMY,
+    IFACE_TUN,
+    IFACE_OVPN_DCO,
+};
+
 /* Only the iproute2 backend implements these functions,
  * the rest can rely on these stubs
  */
@@ -87,6 +93,26 @@ void net_ctx_reset(openvpn_net_ctx_t *ctx);
  */
 void net_ctx_free(openvpn_net_ctx_t *ctx);
 
+/**
+ * Add a new interface
+ *
+ * @param ctx       the implementation specific context
+ * @param iface     interface to create
+ * @param type      interface type (see enum iface_type declaration)
+ * @return int 0 on success, negative error code on error
+ */
+int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+                  enum iface_type type);
+
+/**
+ * Remove an interface
+ *
+ * @param ctx       the implementation specific context
+ * @param iface     interface to delete
+ * @return int 0 on success, negative error code on error
+ */
+int net_iface_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);
+
 /**
  * Bring interface up or down.
  *
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 67b8894b..f8bd6618 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -38,6 +38,12 @@
 #include <stdbool.h>
 #include <netinet/in.h>
 
+static const char *iface_type_str[] = {
+    [IFACE_DUMMY] = "dummy",
+    [IFACE_TUN] = "tun",
+    [IFACE_OVPN_DCO] = "ovpn-dco",
+};
+
 int
 net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
@@ -63,6 +69,34 @@ net_ctx_free(openvpn_net_ctx_t *ctx)
     gc_free(&ctx->gc);
 }
 
+int
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, enum iface_type type)
+{
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s link add %s type %s", iproute_path, iface,
+                iface_type_str[type]);
+    argv_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link add failed");
+
+    argv_free(&argv);
+
+    return 0;
+}
+
+int
+net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
+{
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s link del %s", iproute_path, iface);
+    openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link del failed");
+
+    argv_free(&argv);
+
+    return 0;
+}
+
 int
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index e0003f5c..550a0904 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -595,6 +595,13 @@ net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
 }
 
 #ifdef ENABLE_SITNL
+
+static const char *iface_type_str[] = {
+    [IFACE_DUMMY] = "dummy",
+    [IFACE_TUN] = "tun",
+    [IFACE_OVPN_DCO] = "ovpn-dco",
+};
+
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
                      in_addr_t *best_gw, char *best_iface)
@@ -1312,6 +1319,59 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
                            table, metric);
 }
 
+
+int
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, enum iface_type type)
+{
+    struct sitnl_link_req req = { };
+    struct rtattr *tail = NULL;
+    int ret = -1;
+
+    ASSERT(iface);
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL ;
+    req.n.nlmsg_type = RTM_NEWLINK;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_IFNAME, iface, strlen(iface) + 1);
+
+    tail = NLMSG_TAIL(&req.n);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_LINKINFO, NULL, 0);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_INFO_KIND, iface_type_str[type],
+                  strlen(iface_type_str[type]) + 1);
+    tail->rta_len = (uint8_t *)NLMSG_TAIL(&req.n) - (uint8_t *)tail;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_change = 0xFFFFFFFF;
+
+    msg(D_ROUTE, "%s: add %s type %s", __func__,  iface, iface_type_str[type]);
+
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+err:
+    return ret;
+}
+
+int
+net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
+{
+    struct sitnl_link_req req = { };
+    int ifindex = if_nametoindex(iface);
+
+    if (!ifindex)
+        return errno;
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.n.nlmsg_type = RTM_DELLINK;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_index = ifindex;
+
+    msg(D_ROUTE, "%s: delete %s", __func__, iface);
+
+    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+}
+
 #endif /* !ENABLE_SITNL */
 
 #endif /* TARGET_LINUX */
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 9e9744f4..27b487bd 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -13,6 +13,20 @@ net__iface_up(bool up)
     return net_iface_up(NULL, iface, up);
 }
 
+static int
+net__iface_new(const char *name, enum iface_type type, char *type_str)
+{
+    printf("CMD: ip link add %s type %s\n", name, type_str);
+    return net_iface_new(NULL, name, type);
+}
+
+static int
+net__iface_del(const char *name)
+{
+    printf("CMD: ip link del %s\n", name);
+    return net_iface_del(NULL, name);
+}
+
 static int
 net__iface_mtu_set(int mtu)
 {
@@ -191,7 +205,7 @@ net__route_v6_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
 static void
 usage(char *name)
 {
-    printf("Usage: %s <0-7>\n", name);
+    printf("Usage: %s <0-9>\n", name);
 }
 
 int
@@ -243,6 +257,12 @@ main(int argc, char *argv[])
         case 7:
             return net__route_v6_add_gw("2001:cafe:babe::", 48, "2001::2", 600);
 
+        case 8:
+            return net__iface_new("dummy0815", IFACE_DUMMY, "dummy");
+
+        case 9:
+            return net__iface_del("dummy0815");
+
         default:
             printf("invalid test: %d\n", test);
             break;
-- 
2.34.1


