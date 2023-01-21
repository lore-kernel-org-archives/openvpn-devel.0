From: selva.nair@...277...
Date: Sat, 21 Jan 2023 14:42:26 -0500
Message-Id: <20230121194226.2081637-1-selva.nair@...277...>
In-Reply-To: <20230116194809.1980444-1-selva.nair@...277...>
References: <20230116194809.1980444-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix one more "existing route may get
 deleted" case
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

- Ensure net_route_v4/v6_add/del() functions using iproute2 return
  error when route addition fails. Return value follows the same logic
  as corresponding functions using netlink though all failure reasons
  get the same error code of -1.

TODO: Preserve any preexisting direct route to VPN and optionally the
IPv6 connected net route.

v2: Following review, removed the poorly coded RL_DID_LOCAL-related chunks.
That part needs a better fix.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/networking_iproute2.c | 32 +++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

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
-- 
2.34.1


