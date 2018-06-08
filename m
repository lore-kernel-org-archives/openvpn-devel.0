From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Jun 2018 13:20:15 +0800
Message-Id: <20180608052017.6696-7-a@...2181...>
In-Reply-To: <20180608052017.6696-1-a@...2181...>
References: <20180608052017.6696-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 6/8] pool: add support for
 ifconfig-pool-persist with IPv6 only
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

Without altering the pool logic, this patch enables using
a persistent IP pool also when the server is configured
with IPv6 only.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/options.c |   7 ++-
 src/openvpn/pool.c    | 136 ++++++++++++++++++++++++++++++++----------
 2 files changed, 110 insertions(+), 33 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 426057ab..4d9e4a3f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2349,9 +2349,12 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--up-delay cannot be used with --mode server");
         }
-        if (!options->ifconfig_pool_defined && options->ifconfig_pool_persist_filename)
+        if (!options->ifconfig_pool_defined
+            && !options->ifconfig_ipv6_pool_defined
+            && options->ifconfig_pool_persist_filename)
         {
-            msg(M_USAGE, "--ifconfig-pool-persist must be used with --ifconfig-pool");
+            msg(M_USAGE,
+                "--ifconfig-pool-persist must be used with --ifconfig-pool or --ifconfig-ipv6-pool");
         }
         if (options->ifconfig_ipv6_pool_defined && !options->ifconfig_ipv6_local)
         {
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 08addc6f..64822794 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -34,6 +34,7 @@
 #include "error.h"
 #include "socket.h"
 #include "otime.h"
+#include "options.h"
 
 #include "memdbg.h"
 
@@ -359,12 +360,48 @@ ifconfig_pool_ip_base_to_handle(const struct ifconfig_pool *pool, const in_addr_
     return ret;
 }
 
+static ifconfig_pool_handle
+ifconfig_pool_ipv6_base_to_handle(const struct ifconfig_pool *pool,
+                                  const struct in6_addr *in_addr)
+{
+    ifconfig_pool_handle ret;
+    uint32_t base, addr;
+
+    /* IPv6 pool is always IFCONFIG_POOL_INDIV.
+     *
+     * We assume the offset can't be larger than 2^32-1, therefore we compute
+     * the difference only among the last 4 bytes like if they were two 32bit
+     * long integers. The rest of the address must match.
+     */
+    for (int i = 4; i < 16; i++)
+    {
+        if (pool->ipv6.base.s6_addr[i] != in_addr->s6_addr[i])
+        {
+            return -1;
+        }
+    }
+
+    base = pool->ipv6.base.s6_addr[0] << 24 | pool->ipv6.base.s6_addr[1] << 16
+           || pool->ipv6.base.s6_addr[2] << 8 | pool->ipv6.base.s6_addr[0];
+
+    addr = in_addr->s6_addr[0] << 24 | in_addr->s6_addr[1] << 16
+           || in_addr->s6_addr[2] << 8 | in_addr->s6_addr[0];
+
+    ret = addr - base;
+    if (ret < 0 || ret >= pool->ipv6.size)
+    {
+        ret = -1;
+    }
+
+    return ret;
+}
+
 static in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_handle hand)
 {
     in_addr_t ret = 0;
 
-    if (hand >= 0 && hand < pool->ipv4.size)
+    if (pool->ipv4.enabled && hand >= 0 && hand < pool->ipv4.size)
     {
         switch (pool->ipv4.type)
         {
@@ -394,7 +431,7 @@ ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool, ifconfig_poo
     struct in6_addr ret = in6addr_any;
 
     /* IPv6 pools are always INDIV (--linear) */
-    if (hand >= 0 && hand < pool->ipv6.size)
+    if (pool->ipv6.enabled && hand >= 0 && hand < pool->ipv6.size)
     {
         ret = add_in6_addr( pool->ipv6.base, hand );
     }
@@ -402,9 +439,34 @@ ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool, ifconfig_poo
 }
 
 static void
-ifconfig_pool_set(struct ifconfig_pool *pool, const char *cn, const in_addr_t addr, const bool fixed)
+ifconfig_pool_set(struct ifconfig_pool *pool, const char *cn,
+                  const in_addr_t addr, const struct in6_addr *addr6,
+                  const bool fixed)
 {
-    ifconfig_pool_handle h = ifconfig_pool_ip_base_to_handle(pool, addr);
+    ifconfig_pool_handle h = -1, h6 = -1;
+
+    if (pool->ipv6.enabled)
+    {
+        h = h6 = ifconfig_pool_ipv6_base_to_handle(pool, addr6);
+    }
+
+    if (pool->ipv4.enabled)
+    {
+        h = ifconfig_pool_ip_base_to_handle(pool, addr);
+        /* at the moment IPv4 and IPv6 share the same pool, therefore offsets
+         * have to match for the same client
+         */
+        if ((pool->ipv6.enabled) && (h != h6))
+        {
+            struct gc_arena gc = gc_new();
+            msg(M_WARN,
+                "pool: IPv4 (%s) and IPv6 (%s) have different offsets! Relying on IPv4",
+                print_in_addr_t(addr, 0, &gc),
+                print_in6_addr(*addr6, 0, &gc));
+            gc_free(&gc);
+        }
+    }
+
     if (h >= 0)
     {
         struct ifconfig_pool_entry *e = &pool->list[h];
@@ -427,23 +489,26 @@ ifconfig_pool_list(const struct ifconfig_pool *pool, struct status_output *out)
         for (i = 0; i < pool_size; ++i)
         {
             const struct ifconfig_pool_entry *e = &pool->list[i];
+            struct in6_addr ip6;
+            in_addr_t ip;
+            const char *ip6_str = "";
+            const char *ip_str = "";
+
             if (e->common_name)
             {
-                const in_addr_t ip = ifconfig_pool_handle_to_ip_base(pool, i);
-                if (pool->ipv6.enabled)
+                if (pool->ipv4.enabled)
                 {
-                    struct in6_addr ip6 = ifconfig_pool_handle_to_ipv6_base(pool, i);
-                    status_printf(out, "%s,%s,%s",
-                                  e->common_name,
-                                  print_in_addr_t(ip, 0, &gc),
-                                  print_in6_addr(ip6, 0, &gc));
+                    ip = ifconfig_pool_handle_to_ip_base(pool, i);
+                    ip_str = print_in_addr_t(ip, 0, &gc);
                 }
-                else
+
+                if (pool->ipv6.enabled)
                 {
-                    status_printf(out, "%s,%s",
-                                  e->common_name,
-                                  print_in_addr_t(ip, 0, &gc));
+                    ip6 = ifconfig_pool_handle_to_ipv6_base(pool, i);
+                    ip6_str = print_in6_addr(ip6, 0, &gc);
                 }
+
+                status_printf(out, "%s,%s,%s", e->common_name, ip_str, ip6_str);
             }
         }
         gc_free(&gc);
@@ -518,24 +583,16 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
 
     update_time();
 
-    /* IPv6 logic not implemented yet, therefore bail out if no IPv4 pool was
-     * configured
-     */
-    if (pool && !pool->ipv4.enabled)
-    {
-        return;
-    }
-
     if (persist && persist->file && pool)
     {
         struct gc_arena gc = gc_new();
         struct buffer in = alloc_buf_gc(256, &gc);
-        char *cn_buf;
-        char *ip_buf;
+        char *cn_buf, *ip_buf, *ip6_buf;
         int line = 0;
 
         ALLOC_ARRAY_CLEAR_GC(cn_buf, char, buf_size, &gc);
         ALLOC_ARRAY_CLEAR_GC(ip_buf, char, buf_size, &gc);
+        ALLOC_ARRAY_CLEAR_GC(ip6_buf, char, buf_size, &gc);
 
         while (true)
         {
@@ -552,18 +609,35 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
                 {
                     continue;
                 }
-                msg( M_INFO, "ifconfig_pool_read(), in='%s', TODO: IPv6",
-                     BSTR(&in) );
+                msg(M_INFO, "ifconfig_pool_read(), in='%s'", BSTR(&in));
 
                 if (buf_parse(&in, ',', cn_buf, buf_size)
-                    && buf_parse(&in, ',', ip_buf, buf_size))
+                    && buf_parse(&in, ',', ip_buf, buf_size)
+                    && buf_parse(&in, ',', ip6_buf, buf_size))
                 {
-                    bool succeeded;
-                    const in_addr_t addr = getaddr(GETADDR_HOST_ORDER, ip_buf, 0, &succeeded, NULL);
+                    bool succeeded = true;
+                    struct in6_addr addr6 = { 0 };
+                    in_addr_t addr = { 0 };
+
+                    if (strlen(ip_buf) > 0)
+                    {
+                        addr = getaddr(GETADDR_HOST_ORDER, ip_buf, 0,
+                                       &succeeded, NULL);
+                    }
+
+                    if (strlen(ip6_buf) > 0)
+                    {
+                        if (!get_ipv6_addr(ip6_buf, &addr6, NULL, M_WARN))
+                        {
+                            succeeded = false;
+                        }
+                    }
+
                     if (succeeded)
                     {
                         msg( M_INFO, "succeeded -> ifconfig_pool_set()");
-                        ifconfig_pool_set(pool, cn_buf, addr, persist->fixed);
+                        ifconfig_pool_set(pool, cn_buf, addr, &addr6,
+                                          persist->fixed);
                     }
                 }
             }
-- 
2.17.1


