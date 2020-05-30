From: Antonio Quartulli <a@...2181...>
Date: Sat, 30 May 2020 02:06:00 +0200
Message-Id: <20200530000600.1680-8-a@...2181...>
In-Reply-To: <20200530000600.1680-1-a@...2181...>
References: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 7/7] ipv6-pool: get rid of size constraint
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/helper.c  |  7 +++----
 src/openvpn/options.c | 13 +++++++++----
 src/openvpn/pool.c    | 12 ++++++++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 277e6972..2174b580 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -198,12 +198,11 @@ helper_client_server(struct options *o)
             print_in6_addr( add_in6_addr( o->server_network_ipv6, 2), 0, &o->gc );
         o->ifconfig_ipv6_netbits = o->server_netbits_ipv6;
 
-        /* pool starts at "base address + 0x1000" - leave enough room */
-        ASSERT( o->server_netbits_ipv6 <= 112 );        /* want 16 bits */
+        /* basic sanity check */
+        ASSERT(o->server_netbits_ipv6 >= 64 && o->server_netbits_ipv6 <= 124);
 
         o->ifconfig_ipv6_pool_defined = true;
-        o->ifconfig_ipv6_pool_base =
-            add_in6_addr( o->server_network_ipv6, 0x1000 );
+        o->ifconfig_ipv6_pool_base = add_in6_addr(o->server_network_ipv6, 2);
         o->ifconfig_ipv6_pool_netbits = o->server_netbits_ipv6;
 
         push_option( o, "tun-ipv6", M_USAGE );
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3798731e..327207bd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6714,9 +6714,12 @@ add_option(struct options *options,
             msg(msglevel, "error parsing --server-ipv6 parameter");
             goto err;
         }
-        if (netbits < 64 || netbits > 112)
+        if (netbits < 64 || netbits > 124)
         {
-            msg( msglevel, "--server-ipv6 settings: only /64../112 supported right now (not /%d)", netbits );
+            msg(msglevel,
+                "--server-ipv6 settings: network must be between /64 and /124 (not /%d)",
+                netbits);
+
             goto err;
         }
         options->server_ipv6_defined = true;
@@ -6836,9 +6839,11 @@ add_option(struct options *options,
             msg(msglevel, "error parsing --ifconfig-ipv6-pool parameters");
             goto err;
         }
-        if (netbits < 64 || netbits > 112)
+        if (netbits < 64 || netbits > 124)
         {
-            msg( msglevel, "--ifconfig-ipv6-pool settings: only /64../112 supported right now (not /%d)", netbits );
+            msg(msglevel,
+                "--ifconfig-ipv6-pool settings: network must be between /64 and /124 (not /%d)",
+                netbits);
             goto err;
         }
 
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 42c6a38b..62cb0413 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -207,6 +207,12 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
                 ASSERT(0);
         }
 
+        if (pool->ipv4.size < 2)
+        {
+            msg(M_FATAL, "IPv4 pool size is too small (%d), must be at least 2",
+                pool->ipv4.size);
+        }
+
         msg(D_IFCONFIG_POOL, "IFCONFIG POOL: base=%s size=%d",
             print_in_addr_t(pool->ipv4.base, 0, &gc), pool->ipv4.size);
     }
@@ -245,6 +251,12 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
                           ? (1 << (128 - ipv6_netbits)) - base
                           : IFCONFIG_POOL_MAX;
 
+        if (pool->ipv6.size < 2)
+        {
+            msg(M_FATAL, "IPv6 pool size is too small (%d), must be at least 2",
+                pool->ipv6.size);
+        }
+
         msg(D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: base=%s size=%d netbits=%d",
             print_in6_addr(pool->ipv6.base, 0, &gc), pool->ipv6.size,
             ipv6_netbits);
-- 
2.26.2


