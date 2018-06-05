From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Jun 2018 17:04:19 +0800
Message-Id: <20180605090421.9746-4-a@...2181...>
In-Reply-To: <20180605090421.9746-1-a@...2181...>
References: <20180605090421.9746-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 3/5] pool: convert pool 'type' to enum
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

The pool 'type' member is actually an enumered type, therefore
declare it as 'enum' to improve static code analisys and
readability.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/pool.c |  2 +-
 src/openvpn/pool.h | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 26eb0ebd..5d503a33 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -147,7 +147,7 @@ ifconfig_pool_verify_range(const int msglevel, const in_addr_t start, const in_a
 }
 
 struct ifconfig_pool *
-ifconfig_pool_init(int type, in_addr_t start, in_addr_t end,
+ifconfig_pool_init(enum pool_type type, in_addr_t start, in_addr_t end,
                    const bool duplicate_cn,
                    const bool ipv6_pool, const struct in6_addr ipv6_base,
                    const int ipv6_netbits )
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 544d4180..73ea5599 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -34,8 +34,11 @@
 #define IFCONFIG_POOL_MAX         65536
 #define IFCONFIG_POOL_MIN_NETBITS    16
 
-#define IFCONFIG_POOL_30NET   0
-#define IFCONFIG_POOL_INDIV   1
+enum pool_type
+{
+    IFCONFIG_POOL_30NET,
+    IFCONFIG_POOL_INDIV
+};
 
 struct ifconfig_pool_entry
 {
@@ -49,7 +52,7 @@ struct ifconfig_pool
 {
     bool duplicate_cn;
     struct {
-        int type;
+        enum pool_type type;
         in_addr_t base;
         int size;
     } ipv4;
@@ -69,7 +72,7 @@ struct ifconfig_pool_persist
 
 typedef int ifconfig_pool_handle;
 
-struct ifconfig_pool *ifconfig_pool_init(int type, in_addr_t start, in_addr_t end, const bool duplicate_cn, const bool ipv6_pool, const struct in6_addr ipv6_base, const int ipv6_netbits );
+struct ifconfig_pool *ifconfig_pool_init(enum pool_type type, in_addr_t start, in_addr_t end, const bool duplicate_cn, const bool ipv6_pool, const struct in6_addr ipv6_base, const int ipv6_netbits );
 
 void ifconfig_pool_free(struct ifconfig_pool *pool);
 
-- 
2.17.1


