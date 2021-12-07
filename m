From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:30 +0100
Message-Id: <20211207121137.3221-2-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
References: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 1/8] networking: remove duplicate methods from
 networking_sitnl.c
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
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

The net_ctx_init/reset/free methods of sitnl are the same dummy
methods that are already defined for non-Linux platforms in the
networking.h header.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking.h       |  7 ++++++-
 src/openvpn/networking_sitnl.c | 22 ----------------------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index d43979f0..ad25fc79 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -33,7 +33,12 @@ struct context;
 /* define mock types to ensure code builds on any platform */
 typedef void *openvpn_net_ctx_t;
 typedef void *openvpn_net_iface_t;
+#endif /* ifdef ENABLE_SITNL */
 
+/* Only the iproute2 backend implements these functions,
+ * the rest can rely on these stubs
+ */
+#if !defined(ENABLE_IPROUTE)
 static inline int
 net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
@@ -51,7 +56,7 @@ net_ctx_free(openvpn_net_ctx_t *ctx)
 {
     (void)ctx;
 }
-#endif /* ifdef ENABLE_SITNL */
+#endif /* !defined(ENABLE_IPROUTE) */
 
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
 
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 8610e1d2..e0003f5c 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -595,28 +595,6 @@ net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
 }
 
 #ifdef ENABLE_SITNL
-
-int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
-{
-    (void)c;
-    (void)ctx;
-
-    return 0;
-}
-
-void
-net_ctx_reset(openvpn_net_ctx_t *ctx)
-{
-    (void)ctx;
-}
-
-void
-net_ctx_free(openvpn_net_ctx_t *ctx)
-{
-    (void)ctx;
-}
-
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
                      in_addr_t *best_gw, char *best_iface)
-- 
2.32.0


