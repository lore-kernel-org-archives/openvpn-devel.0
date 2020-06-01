From: Antonio Quartulli <a@...2181...>
Date: Mon,  1 Jun 2020 22:06:24 +0200
Message-Id: <20200601200624.14765-1-a@...2181...>
In-Reply-To: <6a0587ff-47bf-1082-2d48-a170400d0ea1@...2181...>
References: <6a0587ff-47bf-1082-2d48-a170400d0ea1@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] pool: allow to configure an IPv6-only
 ifconfig-pool
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

With this change a server is allowed to allocate an
IPv6-only pool. This is required to make it capable
of managing an IPv6-only tunnel.

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>

---
Changes from v4:
- make 'IFCONFIG POOL' message symmetric across IPv4 and IPv6
- avoid crash when ifconfig_pool_size() is invoked with NULL poll
  (will create a trivial conflict with "ipv6-pool: get rid of size constraint")

Changes from v3:
- properly compute pool size taking into account the actual base address
---
 src/openvpn/multi.c |  10 ++-
 src/openvpn/pool.c  | 181 ++++++++++++++++++++++++++++++++------------
 src/openvpn/pool.h  |   8 +-
 3 files changed, 146 insertions(+), 53 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7f61350d..2fbbe9ec 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -388,7 +388,8 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread
      * differently based on whether a tun or tap style
      * tunnel.
      */
-    if (t->options.ifconfig_pool_defined)
+    if (t->options.ifconfig_pool_defined
+        || t->options.ifconfig_ipv6_pool_defined)
     {
         int pool_type = IFCONFIG_POOL_INDIV;
 
@@ -397,7 +398,8 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread
             pool_type = IFCONFIG_POOL_30NET;
         }
 
-        m->ifconfig_pool = ifconfig_pool_init(pool_type,
+        m->ifconfig_pool = ifconfig_pool_init(t->options.ifconfig_pool_defined,
+                                              pool_type,
                                               t->options.ifconfig_pool_start,
                                               t->options.ifconfig_pool_end,
                                               t->options.duplicate_cn,
@@ -1495,7 +1497,9 @@ multi_select_virtual_addr(struct multi_context *m, struct multi_instance *mi)
             const int tunnel_topology = TUNNEL_TOPOLOGY(mi->context.c1.tuntap);
 
             msg( M_INFO, "MULTI_sva: pool returned IPv4=%s, IPv6=%s",
-                 print_in_addr_t( remote, 0, &gc ),
+                 (mi->context.options.ifconfig_pool_defined
+                  ? print_in_addr_t(remote, 0, &gc)
+                  : "(Not enabled)"),
                  (mi->context.options.ifconfig_ipv6_pool_defined
                   ? print_in6_addr( remote_ipv6, 0, &gc )
                   : "(Not enabled)") );
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 6dd72bb9..6e35fe04 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -58,6 +58,29 @@ ifconfig_pool_entry_free(struct ifconfig_pool_entry *ipe, bool hard)
     }
 }
 
+static const int
+ifconfig_pool_size(const struct ifconfig_pool *pool)
+{
+    int min = INT_MAX;
+
+    if (!pool || (!pool->ipv4.enabled && !pool->ipv6.enabled))
+    {
+        return 0;
+    }
+
+    if (pool->ipv4.enabled)
+    {
+        min = pool->ipv4.size;
+    }
+
+    if (pool->ipv6.enabled && pool->ipv6.size < min)
+    {
+        min = pool->ipv6.size;
+    }
+
+    return min;
+}
+
 static int
 ifconfig_pool_find(struct ifconfig_pool *pool, const char *common_name)
 {
@@ -65,8 +88,9 @@ ifconfig_pool_find(struct ifconfig_pool *pool, const char *common_name)
     time_t earliest_release = 0;
     int previous_usage = -1;
     int new_usage = -1;
+    int pool_size = ifconfig_pool_size(pool);
 
-    for (i = 0; i < pool->ipv4.size; ++i)
+    for (i = 0; i < pool_size; ++i)
     {
         struct ifconfig_pool_entry *ipe = &pool->list[i];
         if (!ipe->in_use)
@@ -147,34 +171,43 @@ ifconfig_pool_verify_range(const int msglevel, const in_addr_t start, const in_a
 }
 
 struct ifconfig_pool *
-ifconfig_pool_init(enum pool_type type, in_addr_t start, in_addr_t end,
-                   const bool duplicate_cn,
+ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
+                   in_addr_t end, const bool duplicate_cn,
                    const bool ipv6_pool, const struct in6_addr ipv6_base,
                    const int ipv6_netbits )
 {
     struct gc_arena gc = gc_new();
     struct ifconfig_pool *pool = NULL;
+    int pool_size = -1;
 
     ASSERT(start <= end && end - start < IFCONFIG_POOL_MAX);
     ALLOC_OBJ_CLEAR(pool, struct ifconfig_pool);
 
-    pool->ipv4.type = type;
     pool->duplicate_cn = duplicate_cn;
 
-    switch (pool->ipv4.type)
+    pool->ipv4.enabled = ipv4_pool;
+
+    if (pool->ipv4.enabled)
     {
-        case IFCONFIG_POOL_30NET:
-            pool->ipv4.base = start & ~3;
-            pool->ipv4.size = (((end | 3) + 1) - pool->ipv4.base) >> 2;
-            break;
+        pool->ipv4.type = type;
+        switch (pool->ipv4.type)
+        {
+            case IFCONFIG_POOL_30NET:
+                pool->ipv4.base = start & ~3;
+                pool->ipv4.size = (((end | 3) + 1) - pool->ipv4.base) >> 2;
+                break;
 
-        case IFCONFIG_POOL_INDIV:
-            pool->ipv4.base = start;
-            pool->ipv4.size = end - start + 1;
-            break;
+            case IFCONFIG_POOL_INDIV:
+                pool->ipv4.base = start;
+                pool->ipv4.size = end - start + 1;
+                break;
 
-        default:
-            ASSERT(0);
+            default:
+                ASSERT(0);
+        }
+
+        msg(D_IFCONFIG_POOL, "IFCONFIG POOL IPv4: base=%s size=%d",
+            print_in_addr_t(pool->ipv4.base, 0, &gc), pool->ipv4.size);
     }
 
     /* IPv6 pools are always "INDIV" type */
@@ -182,26 +215,60 @@ ifconfig_pool_init(enum pool_type type, in_addr_t start, in_addr_t end,
 
     if (pool->ipv6.enabled)
     {
+        /* the host portion of the address will always be contained in the last
+         * 4 bytes, therefore we can just extract that and use it as base in
+         * integer form
+         */
+        uint32_t base = (ipv6_base.s6_addr[12] << 24)
+                        | (ipv6_base.s6_addr[13] << 16)
+                        | (ipv6_base.s6_addr[14] << 8)
+                        | ipv6_base.s6_addr[15];
+        /* some bits of the last 4 bytes may still be part of the network
+         * portion of the address, therefore we need to set them to 0
+         */
+        if ((128 - ipv6_netbits) < 32)
+        {
+            /* extract only the bits that are really part of the host portion of
+             * the address.
+             *
+             * Example: if we have netbits=31, the first bit has to be zero'd,
+             * the following operation first computes off=0x3fffff and then uses
+             * mask to extract the wanted bits from base
+             */
+            uint32_t mask = (1 << (128 - ipv6_netbits - 1)) - 1;
+            base &= mask;
+        }
+
         pool->ipv6.base = ipv6_base;
-        pool->ipv6.size = ipv6_netbits > 112 ? (1 << (128 - ipv6_netbits))
+        pool->ipv6.size = ipv6_netbits > 112
+                          ? (1 << (128 - ipv6_netbits)) - base
                           : IFCONFIG_POOL_MAX;
 
-        msg( D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: (IPv4) size=%d, size_ipv6=%d, netbits=%d, base_ipv6=%s",
-             pool->ipv4.size, pool->ipv6.size, ipv6_netbits,
-             print_in6_addr(pool->ipv6.base, 0, &gc));
+        msg(D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: base=%s size=%d netbits=%d",
+            print_in6_addr(pool->ipv6.base, 0, &gc), pool->ipv6.size,
+            ipv6_netbits);
+    }
 
-        /* the current code is very simple and assumes that the IPv6
-         * pool is at least as big as the IPv4 pool, and we don't need
-         * to do separate math etc. for IPv6
-         */
-        ASSERT(pool->ipv4.size < pool->ipv6.size);
+    if (pool->ipv4.enabled && pool->ipv6.enabled)
+    {
+        if (pool->ipv4.size < pool->ipv6.size)
+        {
+            msg(M_INFO, "NOTE: IPv4 pool size is %d, IPv6 pool size is %d. "
+                "IPv4 pool size limits the number of clients that can be "
+                "served from the pool", pool->ipv4.size, pool->ipv6.size);
+        }
+        else if (pool->ipv4.size > pool->ipv6.size)
+        {
+            msg(M_WARN, "WARNING: IPv4 pool size is %d, IPv6 pool size is %d. "
+                "IPv6 pool size limits the number of clients that can be "
+                "served from the pool. This is likely a MISTAKE - please check "
+                "your configuration", pool->ipv4.size, pool->ipv6.size);
+        }
     }
 
-    ALLOC_ARRAY_CLEAR(pool->list, struct ifconfig_pool_entry, pool->ipv4.size);
+    pool_size = ifconfig_pool_size(pool);
 
-    msg(D_IFCONFIG_POOL, "IFCONFIG POOL: base=%s size=%d, ipv6=%d",
-        print_in_addr_t(pool->ipv4.base, 0, &gc),
-        pool->ipv4.size, pool->ipv6.enabled);
+    ALLOC_ARRAY_CLEAR(pool->list, struct ifconfig_pool_entry, pool_size);
 
     gc_free(&gc);
     return pool;
@@ -212,8 +279,9 @@ ifconfig_pool_free(struct ifconfig_pool *pool)
 {
     if (pool)
     {
-        int i;
-        for (i = 0; i < pool->ipv4.size; ++i)
+        int i, pool_size = ifconfig_pool_size(pool);
+
+        for (i = 0; i < pool_size; ++i)
         {
             ifconfig_pool_entry_free(&pool->list[i], true);
         }
@@ -239,26 +307,29 @@ ifconfig_pool_acquire(struct ifconfig_pool *pool, in_addr_t *local, in_addr_t *r
             ipe->common_name = string_alloc(common_name, NULL);
         }
 
-        switch (pool->ipv4.type)
+        if (pool->ipv4.enabled && local && remote)
         {
-            case IFCONFIG_POOL_30NET:
+            switch (pool->ipv4.type)
             {
-                in_addr_t b = pool->ipv4.base + (i << 2);
-                *local = b + 1;
-                *remote = b + 2;
-                break;
-            }
+                case IFCONFIG_POOL_30NET:
+                    {
+                        in_addr_t b = pool->ipv4.base + (i << 2);
+                        *local = b + 1;
+                        *remote = b + 2;
+                        break;
+                    }
 
-            case IFCONFIG_POOL_INDIV:
-            {
-                in_addr_t b = pool->ipv4.base + i;
-                *local = 0;
-                *remote = b;
-                break;
-            }
+                case IFCONFIG_POOL_INDIV:
+                    {
+                        in_addr_t b = pool->ipv4.base + i;
+                        *local = 0;
+                        *remote = b;
+                        break;
+                    }
 
-            default:
-                ASSERT(0);
+                default:
+                    ASSERT(0);
+            }
         }
 
         /* IPv6 pools are always INDIV (--linear) */
@@ -274,7 +345,9 @@ bool
 ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, const bool hard)
 {
     bool ret = false;
-    if (pool && hand >= 0 && hand < pool->ipv4.size)
+    int pool_size = ifconfig_pool_size(pool);
+
+    if (pool && hand >= 0 && hand < pool_size)
     {
         ifconfig_pool_entry_free(&pool->list[hand], hard);
         ret = true;
@@ -286,6 +359,7 @@ ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, con
  * private access functions
  */
 
+/* currently handling IPv4 logic only */
 static ifconfig_pool_handle
 ifconfig_pool_ip_base_to_handle(const struct ifconfig_pool *pool, const in_addr_t addr)
 {
@@ -380,9 +454,9 @@ ifconfig_pool_list(const struct ifconfig_pool *pool, struct status_output *out)
     if (pool && out)
     {
         struct gc_arena gc = gc_new();
-        int i;
+        int i, pool_size = ifconfig_pool_size(pool);
 
-        for (i = 0; i < pool->ipv4.size; ++i)
+        for (i = 0; i < pool_size; ++i)
         {
             const struct ifconfig_pool_entry *e = &pool->list[i];
             if (e->common_name)
@@ -475,6 +549,15 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
     const int buf_size = 128;
 
     update_time();
+
+    /* IPv6 logic not implemented yet, therefore bail out if no IPv4 pool was
+     * configured
+     */
+    if (pool && !pool->ipv4.enabled)
+    {
+        return;
+    }
+
     if (persist && persist->file && pool)
     {
         struct gc_arena gc = gc_new();
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 73ea5599..6af04645 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -52,6 +52,7 @@ struct ifconfig_pool
 {
     bool duplicate_cn;
     struct {
+        bool enabled;
         enum pool_type type;
         in_addr_t base;
         int size;
@@ -72,7 +73,12 @@ struct ifconfig_pool_persist
 
 typedef int ifconfig_pool_handle;
 
-struct ifconfig_pool *ifconfig_pool_init(enum pool_type type, in_addr_t start, in_addr_t end, const bool duplicate_cn, const bool ipv6_pool, const struct in6_addr ipv6_base, const int ipv6_netbits );
+struct ifconfig_pool *ifconfig_pool_init(const bool ipv4_pool,
+                                         enum pool_type type, in_addr_t start,
+                                         in_addr_t end, const bool duplicate_cn,
+                                         const bool ipv6_pool,
+                                         const struct in6_addr ipv6_base,
+                                         const int ipv6_netbits);
 
 void ifconfig_pool_free(struct ifconfig_pool *pool);
 
-- 
2.26.2


