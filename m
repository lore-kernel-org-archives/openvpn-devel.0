From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Jun 2018 17:04:18 +0800
Message-Id: <20180605090421.9746-3-a@...2181...>
In-Reply-To: <20180605090421.9746-1-a@...2181...>
References: <20180605090421.9746-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/5] pool: restyle ipv4/ipv6 members to
 improve readability
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

(This is only code refactoring)

IPv4 and IPv6 members are all part of the same flat hierarchy
in the pool data structure, without a proper name convention.

Create 2 sub-structures to properly saperate IPv4 from IPv6
relate members. This should make the structure more organized
and also slightly improve code readability.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/pool.c | 72 +++++++++++++++++++++++-----------------------
 src/openvpn/pool.h | 16 +++++++----
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index da28bc06..26eb0ebd 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -66,7 +66,7 @@ ifconfig_pool_find(struct ifconfig_pool *pool, const char *common_name)
     int previous_usage = -1;
     int new_usage = -1;
 
-    for (i = 0; i < pool->size; ++i)
+    for (i = 0; i < pool->ipv4.size; ++i)
     {
         struct ifconfig_pool_entry *ipe = &pool->list[i];
         if (!ipe->in_use)
@@ -158,19 +158,19 @@ ifconfig_pool_init(int type, in_addr_t start, in_addr_t end,
     ASSERT(start <= end && end - start < IFCONFIG_POOL_MAX);
     ALLOC_OBJ_CLEAR(pool, struct ifconfig_pool);
 
-    pool->type = type;
+    pool->ipv4.type = type;
     pool->duplicate_cn = duplicate_cn;
 
-    switch (type)
+    switch (pool->ipv4.type)
     {
         case IFCONFIG_POOL_30NET:
-            pool->base = start & ~3;
-            pool->size = (((end | 3) + 1) - pool->base) >> 2;
+            pool->ipv4.base = start & ~3;
+            pool->ipv4.size = (((end | 3) + 1) - pool->ipv4.base) >> 2;
             break;
 
         case IFCONFIG_POOL_INDIV:
-            pool->base = start;
-            pool->size = end - start + 1;
+            pool->ipv4.base = start;
+            pool->ipv4.size = end - start + 1;
             break;
 
         default:
@@ -178,30 +178,30 @@ ifconfig_pool_init(int type, in_addr_t start, in_addr_t end,
     }
 
     /* IPv6 pools are always "INDIV" type */
-    pool->ipv6 = ipv6_pool;
+    pool->ipv6.enabled = ipv6_pool;
 
-    if (pool->ipv6)
+    if (pool->ipv6.enabled)
     {
-        pool->base_ipv6 = ipv6_base;
-        pool->size_ipv6 = ipv6_netbits>96 ? ( 1<<(128-ipv6_netbits) )
+        pool->ipv6.base = ipv6_base;
+        pool->ipv6.size = ipv6_netbits > 96 ? (1 << (128 - ipv6_netbits))
                           : IFCONFIG_POOL_MAX;
 
         msg( D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: (IPv4) size=%d, size_ipv6=%d, netbits=%d, base_ipv6=%s",
-             pool->size, pool->size_ipv6, ipv6_netbits,
-             print_in6_addr( pool->base_ipv6, 0, &gc ));
+             pool->ipv4.size, pool->ipv6.size, ipv6_netbits,
+             print_in6_addr(pool->ipv6.base, 0, &gc));
 
         /* the current code is very simple and assumes that the IPv6
          * pool is at least as big as the IPv4 pool, and we don't need
          * to do separate math etc. for IPv6
          */
-        ASSERT( pool->size < pool->size_ipv6 );
+        ASSERT(pool->ipv4.size < pool->ipv6.size);
     }
 
-    ALLOC_ARRAY_CLEAR(pool->list, struct ifconfig_pool_entry, pool->size);
+    ALLOC_ARRAY_CLEAR(pool->list, struct ifconfig_pool_entry, pool->ipv4.size);
 
     msg(D_IFCONFIG_POOL, "IFCONFIG POOL: base=%s size=%d, ipv6=%d",
-        print_in_addr_t(pool->base, 0, &gc),
-        pool->size, pool->ipv6 );
+        print_in_addr_t(pool->ipv4.base, 0, &gc),
+        pool->ipv4.size, pool->ipv6.enabled);
 
     gc_free(&gc);
     return pool;
@@ -213,7 +213,7 @@ ifconfig_pool_free(struct ifconfig_pool *pool)
     if (pool)
     {
         int i;
-        for (i = 0; i < pool->size; ++i)
+        for (i = 0; i < pool->ipv4.size; ++i)
         {
             ifconfig_pool_entry_free(&pool->list[i], true);
         }
@@ -239,11 +239,11 @@ ifconfig_pool_acquire(struct ifconfig_pool *pool, in_addr_t *local, in_addr_t *r
             ipe->common_name = string_alloc(common_name, NULL);
         }
 
-        switch (pool->type)
+        switch (pool->ipv4.type)
         {
             case IFCONFIG_POOL_30NET:
             {
-                in_addr_t b = pool->base + (i << 2);
+                in_addr_t b = pool->ipv4.base + (i << 2);
                 *local = b + 1;
                 *remote = b + 2;
                 break;
@@ -251,7 +251,7 @@ ifconfig_pool_acquire(struct ifconfig_pool *pool, in_addr_t *local, in_addr_t *r
 
             case IFCONFIG_POOL_INDIV:
             {
-                in_addr_t b = pool->base + i;
+                in_addr_t b = pool->ipv4.base + i;
                 *local = 0;
                 *remote = b;
                 break;
@@ -262,9 +262,9 @@ ifconfig_pool_acquire(struct ifconfig_pool *pool, in_addr_t *local, in_addr_t *r
         }
 
         /* IPv6 pools are always INDIV (--linear) */
-        if (pool->ipv6 && remote_ipv6)
+        if (pool->ipv6.enabled && remote_ipv6)
         {
-            *remote_ipv6 = add_in6_addr( pool->base_ipv6, i );
+            *remote_ipv6 = add_in6_addr(pool->ipv6.base, i);
         }
     }
     return i;
@@ -274,7 +274,7 @@ bool
 ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, const bool hard)
 {
     bool ret = false;
-    if (pool && hand >= 0 && hand < pool->size)
+    if (pool && hand >= 0 && hand < pool->ipv4.size)
     {
         ifconfig_pool_entry_free(&pool->list[hand], hard);
         ret = true;
@@ -291,17 +291,17 @@ ifconfig_pool_ip_base_to_handle(const struct ifconfig_pool *pool, const in_addr_
 {
     ifconfig_pool_handle ret = -1;
 
-    switch (pool->type)
+    switch (pool->ipv4.type)
     {
         case IFCONFIG_POOL_30NET:
         {
-            ret = (addr - pool->base) >> 2;
+            ret = (addr - pool->ipv4.base) >> 2;
             break;
         }
 
         case IFCONFIG_POOL_INDIV:
         {
-            ret = (addr - pool->base);
+            ret = (addr - pool->ipv4.base);
             break;
         }
 
@@ -309,7 +309,7 @@ ifconfig_pool_ip_base_to_handle(const struct ifconfig_pool *pool, const in_addr_
             ASSERT(0);
     }
 
-    if (ret < 0 || ret >= pool->size)
+    if (ret < 0 || ret >= pool->ipv4.size)
     {
         ret = -1;
     }
@@ -322,19 +322,19 @@ ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_
 {
     in_addr_t ret = 0;
 
-    if (hand >= 0 && hand < pool->size)
+    if (hand >= 0 && hand < pool->ipv4.size)
     {
-        switch (pool->type)
+        switch (pool->ipv4.type)
         {
             case IFCONFIG_POOL_30NET:
             {
-                ret = pool->base + (hand << 2);
+                ret = pool->ipv4.base + (hand << 2);
                 break;
             }
 
             case IFCONFIG_POOL_INDIV:
             {
-                ret = pool->base + hand;
+                ret = pool->ipv4.base + hand;
                 break;
             }
 
@@ -352,9 +352,9 @@ ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool, ifconfig_poo
     struct in6_addr ret = in6addr_any;
 
     /* IPv6 pools are always INDIV (--linear) */
-    if (hand >= 0 && hand < pool->size_ipv6)
+    if (hand >= 0 && hand < pool->ipv6.size)
     {
-        ret = add_in6_addr( pool->base_ipv6, hand );
+        ret = add_in6_addr( pool->ipv6.base, hand );
     }
     return ret;
 }
@@ -382,13 +382,13 @@ ifconfig_pool_list(const struct ifconfig_pool *pool, struct status_output *out)
         struct gc_arena gc = gc_new();
         int i;
 
-        for (i = 0; i < pool->size; ++i)
+        for (i = 0; i < pool->ipv4.size; ++i)
         {
             const struct ifconfig_pool_entry *e = &pool->list[i];
             if (e->common_name)
             {
                 const in_addr_t ip = ifconfig_pool_handle_to_ip_base(pool, i);
-                if (pool->ipv6)
+                if (pool->ipv6.enabled)
                 {
                     struct in6_addr ip6 = ifconfig_pool_handle_to_ipv6_base(pool, i);
                     status_printf(out, "%s,%s,%s",
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 6de28ac5..544d4180 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -47,13 +47,17 @@ struct ifconfig_pool_entry
 
 struct ifconfig_pool
 {
-    in_addr_t base;
-    int size;
-    int type;
     bool duplicate_cn;
-    bool ipv6;
-    struct in6_addr base_ipv6;
-    unsigned int size_ipv6;
+    struct {
+        int type;
+        in_addr_t base;
+        int size;
+    } ipv4;
+    struct {
+        bool enabled;
+        struct in6_addr base;
+        unsigned int size;
+    } ipv6;
     struct ifconfig_pool_entry *list;
 };
 
-- 
2.17.1


