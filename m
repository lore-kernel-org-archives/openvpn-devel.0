From: selva.nair@...277...
Date: Mon, 16 Jan 2023 14:48:09 -0500
Message-Id: <20230116194809.1980444-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix more "existing route may get deleted"
 cases
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

From: Selva Nair <selva.nair@...277...>

- Set RL_DID_LOCAL only if the corresponding route addition
  succeeds. This is needed to preserve when the direct route to
  the vpn server preexists.

- Ensure net_route_v4/v6_add/del() functions using iproute2 return
  error when route addition fails. Return value follows the same logic
  as corresponding functions using netlink though all failure reasons
  get the same error code of -1.

NOTE: delete_route_connected_v6_net() is called even if the
corresponding addition fails. This looks harder to fix, but also
less critical.

Signed-off-by: Selva Nair <selva.nair@...277...>
---

This anticipates two other cases of wrongly deleted routes to be fixed by 
https://patchwork.openvpn.net/project/openvpn2/patch/20230111160848.22906-1-gert@...1296.../

 src/openvpn/networking_iproute2.c | 32 +++++++++++++++++++++++--------
 src/openvpn/route.c               | 26 ++++++++++++++-----------
 src/openvpn/route.h               |  8 ++++----
 3 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index f93756d6..0efeed0f 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -267,6 +267,7 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
 {
     struct argv argv = argv_new();
     const char *dst_str = print_in_addr_t(*dst, 0, &ctx->gc);
+    int ret = 0;
 
     argv_printf(&argv, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
 
@@ -288,11 +289,14 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route add command failed");
+    if (!openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route add command failed"))
+    {
+        ret = -1;
+    }
 
     argv_free(&argv);
 
-    return 0;
+    return ret;
 }
 
 int
@@ -302,6 +306,7 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
 {
     struct argv argv = argv_new();
     char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    int ret = 0;
 
     argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_str,
                 prefixlen, iface);
@@ -319,11 +324,14 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed");
+    if (!openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed"))
+    {
+        ret = -1;
+    }
 
     argv_free(&argv);
 
-    return 0;
+    return ret;
 }
 
 int
@@ -333,6 +341,7 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
 {
     struct argv argv = argv_new();
     const char *dst_str = print_in_addr_t(*dst, 0, &ctx->gc);
+    int ret = 0;
 
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
 
@@ -342,11 +351,14 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed");
+    if (!openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed"))
+    {
+        ret = -1;
+    }
 
     argv_free(&argv);
 
-    return 0;
+    return ret;
 }
 
 int
@@ -356,6 +368,7 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
 {
     struct argv argv = argv_new();
     char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    int ret = 0;
 
     argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_path, dst_str,
                 prefixlen, iface);
@@ -373,11 +386,14 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed");
+    if (!openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed"))
+    {
+        ret = -1;
+    }
 
     argv_free(&argv);
 
-    return 0;
+    return ret;
 }
 
 int
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3a978cb4..20dacb5e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -912,7 +912,7 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     return ret;
 }
 
-static bool
+static int
 add_route3(in_addr_t network,
            in_addr_t netmask,
            in_addr_t gateway,
@@ -1050,10 +1050,14 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                 if ((rl->spec.flags & RTSA_REMOTE_HOST)
                     && rl->spec.remote_host != IPV4_INVALID_ADDR)
                 {
-                    ret = add_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
-                                     rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW,
-                                     &rl->rgi, es, ctx);
-                    rl->iflags |= RL_DID_LOCAL;
+                    int status = add_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
+                                            rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW,
+                                            &rl->rgi, es, ctx);
+                    if (status == RTA_SUCCESS)
+                    {
+                        rl->iflags |= RL_DID_LOCAL;
+                    }
+                    ret = (status != RTA_ERROR);
                 }
                 else
                 {
@@ -1551,7 +1555,7 @@ is_on_link(const int is_local_route, const unsigned int flags, const struct rout
     return rgi && (is_local_route == LR_MATCH || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
 
-bool
+int
 add_route(struct route_ipv4 *r,
           const struct tuntap *tt,
           unsigned int flags,
@@ -1564,7 +1568,7 @@ add_route(struct route_ipv4 *r,
 
     if (!(r->flags & RT_DEFINED))
     {
-        return true; /* no error */
+        return RTA_SUCCESS; /* no error */
     }
 
     struct argv argv = argv_new();
@@ -1858,7 +1862,7 @@ done:
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
 
-    return (status != RTA_ERROR);
+    return status;
 }
 
 
@@ -1885,7 +1889,7 @@ route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
     }
 }
 
-bool
+int
 add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                unsigned int flags, const struct env_set *es,
                openvpn_net_ctx_t *ctx)
@@ -1895,7 +1899,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
 
     if (!(r6->flags & RT_DEFINED) )
     {
-        return true; /* no error */
+        return RTA_SUCCESS; /* no error */
     }
 
     struct argv argv = argv_new();
@@ -2131,7 +2135,7 @@ done:
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
 
-    return (status != RTA_ERROR);
+    return status;
 }
 
 static void
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 71b4cf4e..1e110911 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -259,13 +259,13 @@ void copy_route_ipv6_option_list(struct route_ipv6_option_list *dest,
 
 void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );
 
-bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
+int add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
-bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
-               const struct route_gateway_info *rgi, const struct env_set *es,
-               openvpn_net_ctx_t *ctx);
+int add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
+              const struct route_gateway_info *rgi, const struct env_set *es,
+              openvpn_net_ctx_t *ctx);
 
 void add_route_to_option_list(struct route_option_list *l,
                               const char *network,
-- 
2.34.1


