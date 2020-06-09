From: Gert Doering <gert@...1296...>
Date: Tue,  9 Jun 2020 10:02:29 +0200
Message-Id: <20200609080229.2564-1-gert@...1296...>
In-Reply-To: <20200530000600.1680-1-a@...2181...>
References: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Simplify pool size handling,
 fix possible array overrun on pool reading.
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

Remove separate ipv4.size and ipv6.size in the pool structure, return
to a single pool_size, which is also the allocated array size.

All calls to ifconfig_pool_size() change to "pool->size" now.

pool->size is set to the size of the active pool, or if both IPv4 and IPv6
are in use, to the smaller size (same underlying logic as in 452113155e7,
but really put it into the size field).

This fixes a SIGSEGV crash if an ifconfig-pool-persist file is loaded
that has IPv6 and no IPv4 (= ipv6 handle is used) and that has more
entries than the IPv4 pool size (comparison was done with ipv6.size,
not with actual pool size), introduced by commit 6a8cd033b18.

While at it, fix pool size calculation for IPv6 pools >= /112
(too many -1), introduced by commit 452113155e7.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/pool.c | 96 ++++++++++++++++++++--------------------------
 src/openvpn/pool.h |  3 +-
 2 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 29667623..f60cf291 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -59,29 +59,6 @@ ifconfig_pool_entry_free(struct ifconfig_pool_entry *ipe, bool hard)
     }
 }
 
-static const int
-ifconfig_pool_size(const struct ifconfig_pool *pool)
-{
-    int min = INT_MAX;
-
-    if (!pool || (!pool->ipv4.enabled && !pool->ipv6.enabled))
-    {
-        return 0;
-    }
-
-    if (pool->ipv4.enabled)
-    {
-        min = pool->ipv4.size;
-    }
-
-    if (pool->ipv6.enabled && pool->ipv6.size < min)
-    {
-        min = pool->ipv6.size;
-    }
-
-    return min;
-}
-
 static int
 ifconfig_pool_find(struct ifconfig_pool *pool, const char *common_name)
 {
@@ -89,9 +66,8 @@ ifconfig_pool_find(struct ifconfig_pool *pool, const char *common_name)
     time_t earliest_release = 0;
     int previous_usage = -1;
     int new_usage = -1;
-    int pool_size = ifconfig_pool_size(pool);
 
-    for (i = 0; i < pool_size; ++i)
+    for (i = 0; i < pool->size; ++i)
     {
         struct ifconfig_pool_entry *ipe = &pool->list[i];
         if (!ipe->in_use)
@@ -179,12 +155,13 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
 {
     struct gc_arena gc = gc_new();
     struct ifconfig_pool *pool = NULL;
-    int pool_size = -1;
+    int pool_ipv4_size = -1, pool_ipv6_size = -1;
 
     ASSERT(start <= end && end - start < IFCONFIG_POOL_MAX);
     ALLOC_OBJ_CLEAR(pool, struct ifconfig_pool);
 
     pool->duplicate_cn = duplicate_cn;
+    pool->size = 0;
 
     pool->ipv4.enabled = ipv4_pool;
 
@@ -195,26 +172,28 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
         {
             case IFCONFIG_POOL_30NET:
                 pool->ipv4.base = start & ~3;
-                pool->ipv4.size = (((end | 3) + 1) - pool->ipv4.base) >> 2;
+                pool_ipv4_size = (((end | 3) + 1) - pool->ipv4.base) >> 2;
                 break;
 
             case IFCONFIG_POOL_INDIV:
                 pool->ipv4.base = start;
-                pool->ipv4.size = end - start + 1;
+                pool_ipv4_size = end - start + 1;
                 break;
 
             default:
                 ASSERT(0);
         }
 
-        if (pool->ipv4.size < 2)
+        if (pool_ipv4_size < 2)
         {
             msg(M_FATAL, "IPv4 pool size is too small (%d), must be at least 2",
-                pool->ipv4.size);
+                pool_ipv4_size);
         }
 
         msg(D_IFCONFIG_POOL, "IFCONFIG POOL IPv4: base=%s size=%d",
-            print_in_addr_t(pool->ipv4.base, 0, &gc), pool->ipv4.size);
+            print_in_addr_t(pool->ipv4.base, 0, &gc), pool_ipv4_size);
+
+        pool->size = pool_ipv4_size;
     }
 
     /* IPv6 pools are always "INDIV" type */
@@ -239,49 +218,57 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
              * the address.
              *
              * Example: if we have netbits=31, the first bit has to be zero'd,
-             * the following operation first computes off=0x3fffff and then uses
-             * mask to extract the wanted bits from base
+             * the following operation first computes mask=0x3fffff and then
+             * uses mask to extract the wanted bits from base
              */
-            uint32_t mask = (1 << (128 - ipv6_netbits - 1)) - 1;
+            uint32_t mask = (1 << (128 - ipv6_netbits) ) - 1;
             base &= mask;
         }
 
         pool->ipv6.base = ipv6_base;
-        pool->ipv6.size = ipv6_netbits > 112
+        pool_ipv6_size = ipv6_netbits >= 112
                           ? (1 << (128 - ipv6_netbits)) - base
                           : IFCONFIG_POOL_MAX;
 
-        if (pool->ipv6.size < 2)
+        if (pool_ipv6_size < 2)
         {
             msg(M_FATAL, "IPv6 pool size is too small (%d), must be at least 2",
-                pool->ipv6.size);
+                pool_ipv6_size);
         }
 
         msg(D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: base=%s size=%d netbits=%d",
-            print_in6_addr(pool->ipv6.base, 0, &gc), pool->ipv6.size,
+            print_in6_addr(pool->ipv6.base, 0, &gc), pool_ipv6_size,
             ipv6_netbits);
+
+        /* if there is no v4 pool, or the v6 pool is smaller, use
+         * v6 pool size as "unified pool size"
+         */
+        if ( pool->size <= 0 || pool_ipv6_size < pool->size )
+        {
+            pool->size = pool_ipv6_size;
+        }
     }
 
     if (pool->ipv4.enabled && pool->ipv6.enabled)
     {
-        if (pool->ipv4.size < pool->ipv6.size)
+        if (pool_ipv4_size < pool_ipv6_size)
         {
             msg(M_INFO, "NOTE: IPv4 pool size is %d, IPv6 pool size is %d. "
                 "IPv4 pool size limits the number of clients that can be "
-                "served from the pool", pool->ipv4.size, pool->ipv6.size);
+                "served from the pool", pool_ipv4_size, pool_ipv6_size);
         }
-        else if (pool->ipv4.size > pool->ipv6.size)
+        else if (pool_ipv4_size > pool_ipv6_size)
         {
             msg(M_WARN, "WARNING: IPv4 pool size is %d, IPv6 pool size is %d. "
                 "IPv6 pool size limits the number of clients that can be "
                 "served from the pool. This is likely a MISTAKE - please check "
-                "your configuration", pool->ipv4.size, pool->ipv6.size);
+                "your configuration", pool_ipv4_size, pool_ipv6_size);
         }
     }
 
-    pool_size = ifconfig_pool_size(pool);
+    ASSERT(pool->size>0);
 
-    ALLOC_ARRAY_CLEAR(pool->list, struct ifconfig_pool_entry, pool_size);
+    ALLOC_ARRAY_CLEAR(pool->list, struct ifconfig_pool_entry, pool->size);
 
     gc_free(&gc);
     return pool;
@@ -292,9 +279,9 @@ ifconfig_pool_free(struct ifconfig_pool *pool)
 {
     if (pool)
     {
-        int i, pool_size = ifconfig_pool_size(pool);
+        int i;
 
-        for (i = 0; i < pool_size; ++i)
+        for (i = 0; i < pool->size; ++i)
         {
             ifconfig_pool_entry_free(&pool->list[i], true);
         }
@@ -358,9 +345,8 @@ bool
 ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, const bool hard)
 {
     bool ret = false;
-    int pool_size = ifconfig_pool_size(pool);
 
-    if (pool && hand >= 0 && hand < pool_size)
+    if (pool && hand >= 0 && hand < pool->size)
     {
         ifconfig_pool_entry_free(&pool->list[hand], hard);
         ret = true;
@@ -396,7 +382,7 @@ ifconfig_pool_ip_base_to_handle(const struct ifconfig_pool *pool, const in_addr_
             ASSERT(0);
     }
 
-    if (ret < 0 || ret >= pool->ipv4.size)
+    if (ret < 0 || ret >= pool->size)
     {
         ret = -1;
     }
@@ -436,7 +422,7 @@ ifconfig_pool_ipv6_base_to_handle(const struct ifconfig_pool *pool,
            | in_addr->s6_addr[15];
 
     ret = addr - base;
-    if (ret < 0 || ret >= pool->ipv6.size)
+    if (ret < 0 || ret >= pool->size)
     {
         ret = -1;
     }
@@ -449,7 +435,7 @@ ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_
 {
     in_addr_t ret = 0;
 
-    if (pool->ipv4.enabled && hand >= 0 && hand < pool->ipv4.size)
+    if (pool->ipv4.enabled && hand >= 0 && hand < pool->size)
     {
         switch (pool->ipv4.type)
         {
@@ -479,7 +465,7 @@ ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool, ifconfig_poo
     struct in6_addr ret = IN6ADDR_ANY_INIT;
 
     /* IPv6 pools are always INDIV (--linear) */
-    if (pool->ipv6.enabled && hand >= 0 && hand < pool->ipv6.size)
+    if (pool->ipv6.enabled && hand >= 0 && hand < pool->size)
     {
         ret = add_in6_addr( pool->ipv6.base, hand );
     }
@@ -504,9 +490,9 @@ ifconfig_pool_list(const struct ifconfig_pool *pool, struct status_output *out)
     if (pool && out)
     {
         struct gc_arena gc = gc_new();
-        int i, pool_size = ifconfig_pool_size(pool);
+        int i;
 
-        for (i = 0; i < pool_size; ++i)
+        for (i = 0; i < pool->size; ++i)
         {
             const struct ifconfig_pool_entry *e = &pool->list[i];
             struct in6_addr ip6;
@@ -720,7 +706,7 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
              */
             if (h >= 0)
             {
-                msg(M_INFO, "succeeded -> ifconfig_pool_set()");
+                msg(M_INFO, "succeeded -> ifconfig_pool_set(hand=%d)",h);
                 ifconfig_pool_set(pool, cn_buf, h, persist->fixed);
             }
         }
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 6af04645..b06424c9 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -55,13 +55,12 @@ struct ifconfig_pool
         bool enabled;
         enum pool_type type;
         in_addr_t base;
-        int size;
     } ipv4;
     struct {
         bool enabled;
         struct in6_addr base;
-        unsigned int size;
     } ipv6;
+    int size;
     struct ifconfig_pool_entry *list;
 };
 
-- 
2.26.2


