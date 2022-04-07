From: Antonio Quartulli <a@...2181...>
Date: Thu,  7 Apr 2022 10:39:53 +0200
Message-Id: <20220407083953.24322-1-a@...2181...>
In-Reply-To: <20220402070902.30282-4-a@...2181...>
References: <20220402070902.30282-4-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/7] networking: implement net_iface_new
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

Changes from v1:
* removed enum iface_type -> just use strings to make code simpler
** adapt test_networking.c accordigly
* don't initialize ifichange as we are not changing any ifi_flag
* remove S_FATAL flag from net_iface_del() iproute2 implementation

---
 src/openvpn/networking.h                   | 21 ++++++++
 src/openvpn/networking_iproute2.c          | 28 ++++++++++
 src/openvpn/networking_sitnl.c             | 63 ++++++++++++++++++++++
 tests/unit_tests/openvpn/test_networking.c | 22 +++++++-
 4 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 9335701e..647718e0 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -87,6 +87,27 @@ void net_ctx_reset(openvpn_net_ctx_t *ctx);
  */
 void net_ctx_free(openvpn_net_ctx_t *ctx);
 
+/**
+ * Add a new interface
+ *
+ * @param ctx       the implementation specific context
+ * @param iface     interface to create
+ * @param type      string describing interface type
+ * @param arg       extra data required by the specific type
+ * @return int 0 on success, negative error code on error
+ */
+int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+                  const char *type, void *arg);
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
index 3ca2bb35..1911a6a2 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -63,6 +63,34 @@ net_ctx_free(openvpn_net_ctx_t *ctx)
     gc_free(&ctx->gc);
 }
 
+int
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,
+	      void *arg)
+{
+    struct argv argv = argv_new();
+
+    argv_printf(&argv, "%s link add %s type %s", iproute_path, iface, iface_type);
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
+    openvpn_execve_check(&argv, ctx->es, 0, "Linux ip link del failed");
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
index 9b2f58d9..98e0685e 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -56,6 +56,18 @@
 #define NLMSG_TAIL(nmsg) \
     ((struct rtattr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
 
+#define SITNL_NEST(_msg, _max_size, _attr)              \
+    ({                                                  \
+        struct rtattr *_nest = NLMSG_TAIL(_msg);        \
+        SITNL_ADDATTR(_msg, _max_size, _attr, NULL, 0); \
+        _nest;                                          \
+    })
+
+#define SITNL_NEST_END(_msg, _nest)                                 \
+    {                                                               \
+        _nest->rta_len = (void *)NLMSG_TAIL(_msg) - (void *)_nest;  \
+    }
+
 /**
  * Generic address data structure used to pass addresses and prefixes as
  * argument to AF family agnostic functions
@@ -596,6 +608,7 @@ net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
 }
 
 #ifdef ENABLE_SITNL
+
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
                      in_addr_t *best_gw, char *best_iface)
@@ -1313,6 +1326,56 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
                            table, metric);
 }
 
+
+int
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,
+              void *arg)
+{
+    struct sitnl_link_req req = { };
+    int ret = -1;
+
+    ASSERT(iface);
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+    req.n.nlmsg_type = RTM_NEWLINK;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_IFNAME, iface, strlen(iface) + 1);
+
+    struct rtattr *linkinfo = SITNL_NEST(&req.n, sizeof(req), IFLA_LINKINFO);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type) + 1);
+    SITNL_NEST_END(&req.n, linkinfo);
+
+    req.i.ifi_family = AF_PACKET;
+
+    msg(D_ROUTE, "%s: add %s type %s", __func__,  iface, type);
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
index 9e9744f4..10ed2cb5 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -13,6 +13,20 @@ net__iface_up(bool up)
     return net_iface_up(NULL, iface, up);
 }
 
+static int
+net__iface_new(const char *name, const char *type)
+{
+    printf("CMD: ip link add %s type %s\n", name, type);
+    return net_iface_new(NULL, name, type, NULL);
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
+            return net__iface_new("dummy0815", "dummy");
+
+        case 9:
+            return net__iface_del("dummy0815");
+
         default:
             printf("invalid test: %d\n", test);
             break;
-- 
2.35.1


