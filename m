From: Antonio Quartulli <a@...2181...>
Date: Sun, 18 Sep 2022 00:42:27 +0200
Message-Id: <20220917224227.16988-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] delete_routes(_ipv6): avoid memleak if
 RT_DEFINED is not set
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
Cc: Antonio Quartulli <a@...2181...>, =?UTF-8?q?Camille=20Gu=C3=A9rin?= <guerincamille56@...277...>

In this case the function would exit without releasing the argv object
initialized via argv_new().

Move initialization of argv after thic check is performed.

While at it, also move the declaration of gc and initizlize it with
gc_new().

Reported-by: Camille Guérin <guerincamille56@...277...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/route.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7eaf1121..ded8fec8 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2145,8 +2145,6 @@ delete_route(struct route_ipv4 *r,
              const struct env_set *es,
              openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc;
-    struct argv argv = argv_new();
 #if !defined(TARGET_LINUX)
     const char *network;
 #if !defined(TARGET_AIX)
@@ -2165,7 +2163,8 @@ delete_route(struct route_ipv4 *r,
         return;
     }
 
-    gc_init(&gc);
+    struct gc_arena gc = gc_new();
+    struct argv argv = argv_new();
 
 #if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
@@ -2336,8 +2335,6 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
                   unsigned int flags, const struct env_set *es,
                   openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc;
-    struct argv argv = argv_new();
     const char *network;
 #if !defined(TARGET_LINUX)
     const char *gateway;
@@ -2360,7 +2357,8 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     }
 #endif
 
-    gc_init(&gc);
+    struct gc_arena gc = gc_new();
+    struct argv argv = argv_new();
 
     network = print_in6_addr( r6->network, 0, &gc);
 #if !defined(TARGET_LINUX)
-- 
2.35.1


