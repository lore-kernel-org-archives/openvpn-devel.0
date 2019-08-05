From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Aug 2019 11:25:25 +0200
Message-Id: <20190805092529.9467-3-a@...2181...>
In-Reply-To: <20190805092529.9467-1-a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/6] networking/best_gw: remove useless
 prefixlen parameter
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

The prefixlen parameter is not used at all while retrieving a route
therefore it can safely be removed.

Signed-off-by: Antonio Quartulli <antonio2openvpn.net>
---
 src/openvpn/networking.h          |  7 ++-----
 src/openvpn/networking_iproute2.c |  4 ++--
 src/openvpn/networking_sitnl.c    | 20 +++++++++-----------
 src/openvpn/route.c               |  4 ++--
 4 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index add45edc..cf967116 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -241,15 +241,13 @@ int net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
  *
  * @param ctx           the implementation specific context
  * @param dst           The destination to lookup
- * @param prefixlen     The length of the prefix of the destination
  * @param best_gw       Location where the retrieved GW has to be stored
  * @param best_iface    Location where the retrieved interface has to be stored
  *
  * @return              0 on success, a negative error code otherwise
  */
 int net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
-                         int prefixlen, in_addr_t *best_gw,
-                         openvpn_net_iface_t *best_iface);
+                         in_addr_t *best_gw, openvpn_net_iface_t *best_iface);
 
 /**
  * Retrieve the gateway and outgoing interface for the specified IPv6
@@ -257,14 +255,13 @@ int net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
  *
  * @param ctx           the implementation specific context
  * @param dst           The destination to lookup
- * @param prefixlen     The length of the prefix of the destination
  * @param best_gw       Location where the retrieved GW has to be stored
  * @param best_iface    Location where the retrieved interface has to be stored
  *
  * @return              0 on success, a negative error code otherwise
  */
 int net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
-                         int prefixlen, struct in6_addr *best_gw,
+                         struct in6_addr *best_gw,
                          openvpn_net_iface_t *best_iface);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index a5824306..5db9a78b 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -325,7 +325,7 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
 
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
-                     int prefixlen, in_addr_t *best_gw, char *best_iface)
+                     in_addr_t *best_gw, char *best_iface)
 {
     best_iface[0] = '\0';
 
@@ -378,7 +378,7 @@ net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
  * uses the sitnl implementation from networking_sitnl.c.
  *
  * int
- * net_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
+ * net_route_v6_best_gw(const struct in6_addr *dst,
  *                      struct in6_addr *best_gw, char *best_iface)
  */
 
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index ea730ec7..21563905 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -451,7 +451,7 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
 
 static int
 sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
-                    int prefixlen, void *best_gw, char *best_iface)
+                    void *best_gw, char *best_iface)
 {
     struct sitnl_route_req req;
     route_res_t res;
@@ -468,7 +468,6 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
     req.n.nlmsg_flags = NLM_F_REQUEST;
 
     req.r.rtm_family = af_family;
-    req.r.rtm_dst_len = prefixlen;
 
     switch (af_family)
     {
@@ -503,7 +502,7 @@ err:
 /* used by iproute2 implementation too */
 int
 net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
-                     int prefixlen, struct in6_addr *best_gw, char *best_iface)
+                     struct in6_addr *best_gw, char *best_iface)
 {
     inet_address_t dst_v6 = {0};
     char buf[INET6_ADDRSTRLEN];
@@ -514,11 +513,10 @@ net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
         dst_v6.ipv6 = *dst;
     }
 
-    msg(D_ROUTE, "%s query: dst %s/%d", __func__,
-        inet_ntop(AF_INET6, &dst_v6.ipv6, buf, sizeof(buf)), prefixlen);
+    msg(D_ROUTE, "%s query: dst %s", __func__,
+        inet_ntop(AF_INET6, &dst_v6.ipv6, buf, sizeof(buf)));
 
-    ret = sitnl_route_best_gw(AF_INET6, &dst_v6, prefixlen, best_gw,
-                              best_iface);
+    ret = sitnl_route_best_gw(AF_INET6, &dst_v6, best_gw, best_iface);
     if (ret < 0)
     {
         return ret;
@@ -544,7 +542,7 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
-                     int prefixlen, in_addr_t *best_gw, char *best_iface)
+                     in_addr_t *best_gw, char *best_iface)
 {
     inet_address_t dst_v4 = {0};
     char buf[INET_ADDRSTRLEN];
@@ -555,10 +553,10 @@ net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
         dst_v4.ipv4 = htonl(*dst);
     }
 
-    msg(D_ROUTE, "%s query: dst %s/%d", __func__,
-        inet_ntop(AF_INET, &dst_v4.ipv4, buf, sizeof(buf)), prefixlen);
+    msg(D_ROUTE, "%s query: dst %s", __func__,
+        inet_ntop(AF_INET, &dst_v4.ipv4, buf, sizeof(buf)));
 
-    ret = sitnl_route_best_gw(AF_INET, &dst_v4, prefixlen, best_gw, best_iface);
+    ret = sitnl_route_best_gw(AF_INET, &dst_v4, best_gw, best_iface);
     if (ret < 0)
     {
         return ret;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1341b4d2..bf036689 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3172,7 +3172,7 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 
 #ifndef TARGET_ANDROID
     /* get default gateway IP addr */
-    if (net_route_v4_best_gw(ctx, NULL, 0, &rgi->gateway.addr, best_name) == 0)
+    if (net_route_v4_best_gw(ctx, NULL, &rgi->gateway.addr, best_name) == 0)
     {
         rgi->flags |= RGI_ADDR_DEFINED;
         if (!rgi->gateway.addr && best_name[0])
@@ -3330,7 +3330,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 
     CLEAR(*rgi6);
 
-    if (net_route_v6_best_gw(ctx, dest, 0, &rgi6->gateway.addr_ipv6,
+    if (net_route_v6_best_gw(ctx, dest, &rgi6->gateway.addr_ipv6,
                              rgi6->iface) == 0)
     {
         if (!IN6_IS_ADDR_UNSPECIFIED(rgi6->gateway.addr_ipv6.s6_addr))
-- 
2.22.0


