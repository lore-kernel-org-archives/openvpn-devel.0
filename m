From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Aug 2019 11:25:29 +0200
Message-Id: <20190805092529.9467-7-a@...2181...>
In-Reply-To: <20190805092529.9467-1-a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/6] route.c: simplify ifdef logic
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
Cc: Antonio Quartulli <a@...2181...>, Antonio Quartulli <antonio@...515...>

With the introduction of the new networking API layer on linux, some
ifdefs can be pruned or simplified.

While at it move some variable to improve readability.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/route.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2d53c459..3ad87e26 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1554,13 +1554,10 @@ add_route(struct route_ipv4 *r,
     struct argv argv = argv_new();
 #if !defined(TARGET_LINUX)
     const char *network;
-#if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
+#if !defined(TARGET_AIX)
     const char *netmask;
 #endif
     const char *gateway;
-#else
-    const char *iface;
-    int metric;
 #endif
     bool status = false;
     int is_local_route;
@@ -1574,7 +1571,7 @@ add_route(struct route_ipv4 *r,
 
 #if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
-#if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
+#if !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
     gateway = print_in_addr_t(r->gateway, 0, &gc);
@@ -1587,13 +1584,14 @@ add_route(struct route_ipv4 *r,
     }
 
 #if defined(TARGET_LINUX)
-    iface = NULL;
+    const char *iface = NULL;
+    int metric = -1;
+
     if (is_on_link(is_local_route, flags, rgi))
     {
         iface = rgi->iface;
     }
 
-    metric = -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
         metric = r->metric;
@@ -2148,10 +2146,10 @@ delete_route(struct route_ipv4 *r,
     struct argv argv = argv_new();
 #if !defined(TARGET_LINUX)
     const char *network;
-#if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
+#if !defined(TARGET_AIX)
     const char *netmask;
 #endif
-#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
+#if !defined(TARGET_ANDROID)
     const char *gateway;
 #endif
 #else
@@ -2168,10 +2166,10 @@ delete_route(struct route_ipv4 *r,
 
 #if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
-#if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
+#if !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
-#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
+#if !defined(TARGET_ANDROID)
     gateway = print_in_addr_t(r->gateway, 0, &gc);
 #endif
 #endif
-- 
2.22.0


