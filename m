From: Gert Doering <gert@...1296...>
Date: Thu, 17 Sep 2020 10:59:41 +0200
Message-Id: <20200917085941.20972-1-gert@...1296...>
In-Reply-To: <20200911115916.16117-1-gert@...1296...>
References: <20200911115916.16117-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] If IPv6 pool specification sets pool
 start to ::0 address, increment.
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

The first IPv6 address in a subnet is not usable (IPv6 anycast address),
but our pool code ignored this.

Instead of assigning an unusable address or erroring out, just log the
fact, and increment the pool start to <pool_base>::1

NOTE: this is a bit simplistic.  A pool that is larger than /96 and
has non-0 bits in the "uppermost bits" will still get the increment
as we only look at the lowermost 32 bits.

NOTE2: if the pool is specified with "--server-ipv6 $base/$bits", this
is a non-issue, as the address for the pool start will be incremented
anyway.

v2: make comment more explicit about "we're only talking about the
    host part here" and "base sees only only 32 bit of the host part"

Reported-by: NicolaF_ in Trac
Trac: #1282

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/man-sections/server-options.rst |  3 ++-
 src/openvpn/pool.c                  | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 2009953c..56ffff9a 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -204,7 +204,8 @@ fast hardware. SSL/TLS authentication must be used in this mode.
      ifconfig-ipv6-pool ipv6addr/bits
 
   The pool starts at ``ipv6addr`` and matches the offset determined from
-  the start of the IPv4 pool.
+  the start of the IPv4 pool.  If the host part of the given IPv6
+  address is ``0``, the pool starts at ``ipv6addr`` +1.
 
 --ifconfig-pool-persist args
   Persist/unpersist ifconfig-pool data to ``file``, at ``seconds``
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 1f74ac57..2c5dd72d 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -224,6 +224,24 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
         }
 
         pool->ipv6.base = ipv6_base;
+
+        /* if a pool starts at a base address that has all-zero in the
+         * host part, that first IPv6 address must not be assigned to
+         * clients because it is not usable (subnet anycast address).
+         * Start with 1, then.
+         *
+         * NOTE: this will also (mis-)fire for something like
+         *    ifconfig-ipv6-pool 2001:db8:0:1:1234::0/64
+         * as we only check the rightmost 32 bits of the host part.  So be it.
+         */
+        if (base == 0)
+        {
+            msg(D_IFCONFIG_POOL, "IFCONFIG POOL IPv6: incrementing pool start "
+		"to avoid ::0 assignment");
+            base++;
+            pool->ipv6.base.s6_addr[15]++;
+        }
+
         pool_ipv6_size = ipv6_netbits >= 112
                           ? (1 << (128 - ipv6_netbits)) - base
                           : IFCONFIG_POOL_MAX;
-- 
2.26.2


