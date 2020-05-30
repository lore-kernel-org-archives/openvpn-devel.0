From: Antonio Quartulli <a@...2181...>
Date: Sat, 30 May 2020 02:05:54 +0200
Message-Id: <20200530000600.1680-2-a@...2181...>
In-Reply-To: <20200530000600.1680-1-a@...2181...>
References: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 1/7] pool: prevent IPv6 pools to be
 larger than 2^16 addresses
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
 src/openvpn/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 5d503a33..6dd72bb9 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -183,7 +183,7 @@ ifconfig_pool_init(enum pool_type type, in_addr_t start, in_addr_t end,
     if (pool->ipv6.enabled)
     {
         pool->ipv6.base = ipv6_base;
-        pool->ipv6.size = ipv6_netbits > 96 ? (1 << (128 - ipv6_netbits))
+        pool->ipv6.size = ipv6_netbits > 112 ? (1 << (128 - ipv6_netbits))
                           : IFCONFIG_POOL_MAX;
 
         msg( D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: (IPv4) size=%d, size_ipv6=%d, netbits=%d, base_ipv6=%s",
-- 
2.26.2


