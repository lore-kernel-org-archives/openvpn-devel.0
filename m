From: Antonio Quartulli <a@...2181...>
Date: Sat,  6 Jun 2020 23:16:24 +0200
Message-Id: <20200606211624.10877-1-a@...2181...>
In-Reply-To: <20200606152643.GA1431@...1296...>
References: <20200606152643.GA1431@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] pool: add support for
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

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>

---
Changes from v4:
- prevent persist-pool parser from bailing out when only IPv4 addresses
  are used
- simplify ifconfig_pool_set() function
- re-arrange ifconfig_pool_read() function to better deal with all cases
  (i.e. only ipv6 or invalid ipv4 but not ipv6..etc..)

Changes from v3:
- patchset rebased on top of pre-ipv6-only patchset
---
 src/openvpn/options.c |   7 +-
 src/openvpn/pool.c    | 208 ++++++++++++++++++++++++++++++++----------
 2 files changed, 165 insertions(+), 50 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4f03a27e..327207bd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2346,9 +2346,12 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
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
index a7981b8d..29667623 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -34,6 +34,7 @@
 #include "error.h"
 #include "socket.h"
 #include "otime.h"
+#include "options.h"
 
 #include "memdbg.h"
 
@@ -403,12 +404,52 @@ ifconfig_pool_ip_base_to_handle(const struct ifconfig_pool *pool, const in_addr_
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
+    for (int i = 0; i < (12); i++)
+    {
+        if (pool->ipv6.base.s6_addr[i] != in_addr->s6_addr[i])
+        {
+            return -1;
+        }
+    }
+
+    base = (pool->ipv6.base.s6_addr[12] << 24)
+           | (pool->ipv6.base.s6_addr[13] << 16)
+           | (pool->ipv6.base.s6_addr[14] << 8)
+           | pool->ipv6.base.s6_addr[15];
+
+    addr = (in_addr->s6_addr[12] << 24)
+           | (in_addr->s6_addr[13] << 16)
+           | (in_addr->s6_addr[14] << 8)
+           | in_addr->s6_addr[15];
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
@@ -435,10 +476,10 @@ ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_
 static struct in6_addr
 ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool, ifconfig_pool_handle hand)
 {
-    struct in6_addr ret = in6addr_any;
+    struct in6_addr ret = IN6ADDR_ANY_INIT;
 
     /* IPv6 pools are always INDIV (--linear) */
-    if (hand >= 0 && hand < pool->ipv6.size)
+    if (pool->ipv6.enabled && hand >= 0 && hand < pool->ipv6.size)
     {
         ret = add_in6_addr( pool->ipv6.base, hand );
     }
@@ -446,18 +487,15 @@ ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool, ifconfig_poo
 }
 
 static void
-ifconfig_pool_set(struct ifconfig_pool *pool, const char *cn, const in_addr_t addr, const bool fixed)
+ifconfig_pool_set(struct ifconfig_pool *pool, const char *cn,
+                  ifconfig_pool_handle h, const bool fixed)
 {
-    ifconfig_pool_handle h = ifconfig_pool_ip_base_to_handle(pool, addr);
-    if (h >= 0)
-    {
-        struct ifconfig_pool_entry *e = &pool->list[h];
-        ifconfig_pool_entry_free(e, true);
-        e->in_use = false;
-        e->common_name = string_alloc(cn, NULL);
-        e->last_release = now;
-        e->fixed = fixed;
-    }
+    struct ifconfig_pool_entry *e = &pool->list[h];
+    ifconfig_pool_entry_free(e, true);
+    e->in_use = false;
+    e->common_name = string_alloc(cn, NULL);
+    e->last_release = now;
+    e->fixed = fixed;
 }
 
 static void
@@ -471,23 +509,26 @@ ifconfig_pool_list(const struct ifconfig_pool *pool, struct status_output *out)
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
@@ -562,24 +603,16 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
 
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
@@ -589,28 +622,107 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
                 break;
             }
             ++line;
-            if (BLEN(&in))
+            if (!BLEN(&in))
             {
-                int c = *BSTR(&in);
-                if (c == '#' || c == ';')
+                continue;
+            }
+
+            int c = *BSTR(&in);
+            if (c == '#' || c == ';')
+            {
+                continue;
+            }
+
+            msg(M_INFO, "ifconfig_pool_read(), in='%s'", BSTR(&in));
+
+            /* The expected format of a line is: "CN,IP4,IP6".
+             *
+             * IP4 or IP6 may be empty when respectively no v4 or v6 pool
+             * was previously specified.
+             *
+             * This means that accepted strings can be:
+             * - CN,IP4,IP6
+             * - CN,IP4
+             * - CN,,IP6
+             */
+            if (!buf_parse(&in, ',', cn_buf, buf_size)
+                || !buf_parse(&in, ',', ip_buf, buf_size))
+            {
+                continue;
+            }
+
+            ifconfig_pool_handle h = -1, h6 = -1;
+
+            if (strlen(ip_buf) > 0)
+            {
+                bool v4_ok = true;
+                in_addr_t addr = getaddr(GETADDR_HOST_ORDER, ip_buf, 0, &v4_ok,
+                                         NULL);
+
+                if (!v4_ok)
+                {
+                    msg(M_WARN, "pool: invalid IPv4 (%s) for CN=%s", ip_buf,
+                        cn_buf);
+                }
+                else
                 {
-                    continue;
+                    h = ifconfig_pool_ip_base_to_handle(pool, addr);
+                    if (h < 0)
+                    {
+                        msg(M_WARN,
+                            "pool: IPv4 (%s) out of pool range for CN=%s",
+                            ip_buf, cn_buf);
+                    }
                 }
-                msg( M_INFO, "ifconfig_pool_read(), in='%s', TODO: IPv6",
-                     BSTR(&in) );
+            }
+
+            if (buf_parse(&in, ',', ip6_buf, buf_size) && strlen(ip6_buf) > 0)
+            {
+                struct in6_addr addr6;
 
-                if (buf_parse(&in, ',', cn_buf, buf_size)
-                    && buf_parse(&in, ',', ip_buf, buf_size))
+                if (!get_ipv6_addr(ip6_buf, &addr6, NULL, M_WARN))
+                {
+                    msg(M_WARN, "pool: invalid IPv6 (%s) for CN=%s", ip6_buf,
+                        cn_buf);
+                }
+                else
                 {
-                    bool succeeded;
-                    const in_addr_t addr = getaddr(GETADDR_HOST_ORDER, ip_buf, 0, &succeeded, NULL);
-                    if (succeeded)
+                    h6 = ifconfig_pool_ipv6_base_to_handle(pool, &addr6);
+                    if (h6 < 0)
                     {
-                        msg( M_INFO, "succeeded -> ifconfig_pool_set()");
-                        ifconfig_pool_set(pool, cn_buf, addr, persist->fixed);
+                        msg(M_WARN,
+                            "pool: IPv6 (%s) out of pool range for CN=%s",
+                            ip6_buf, cn_buf);
                     }
+
+                    /* Rely on IPv6 if no IPv4 was provided or the one provided
+                     * was not valid
+                     */
+                    if (h < 0)
+                        h = h6;
                 }
             }
+
+            /* at the moment IPv4 and IPv6 share the same pool, therefore offsets
+             * have to match for the same client.
+             *
+             * If offsets differ we use the IPv4, therefore warn the user about this.
+             */
+            if ((h6 >= 0) && (h != h6))
+            {
+                msg(M_WARN,
+                    "pool: IPv4 (%s) and IPv6 (%s) have different offsets! Relying on IPv4",
+                    ip_buf, ip6_buf);
+            }
+
+            /* if at least one among v4 and v6 was properly parsed, attempt
+             * setting an handle for this client
+             */
+            if (h >= 0)
+            {
+                msg(M_INFO, "succeeded -> ifconfig_pool_set()");
+                ifconfig_pool_set(pool, cn_buf, h, persist->fixed);
+            }
         }
 
         ifconfig_pool_msg(pool, D_IFCONFIG_POOL);
-- 
2.27.0


