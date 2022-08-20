From: Gert Doering <gert@...1296...>
Date: Sat, 20 Aug 2022 16:01:24 +0200
Message-Id: <20220820140124.11325-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] DCO: require valid netbits setting for
 non-primary iroutes.
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

The existing DCO code had extra logic for "if this is not
MR_WITH_NETBITS, set 32/128 as address length", but only for
iroute addition.  For iroute deletion, this was missing, and
subsequently iroute deletion for IPv4 host routes failed on
FreeBSD DCO (commit 3433577a99).

Iroute handling differenciates between "primary" iroutes (coming
from anm IP pool or ccd/ifconfig-push), and "non-primary" iroutes,
coming from --iroute and --iroute-ipv6 statements in per-client config.

"Primary" iroutes always use "-1" for their netbits, but since these
are not installed via DCO, this is of no concern here.  Whether these
can and should be changed needs further study on internal route
learning and cleanup.

Refactor options.c and multi.c to ensure that netbits is always set
for non-primary iroutes - and ASSERT() on this in the DCO path, so we can
find out if there might be other code violating this.

Change options.c::option_iroute() to always set netbits=32 for IPv4
host routes (options_iroute_ipv6() never differenciated).  Since
netmask_to_netbits() also insists on "-1" for host routes, change
to netmask_to_netbits2().

Remove all the extra MR_WITH_NETBITS logic from dco.c, where it should
have never appeared.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/dco.c     | 16 ++--------------
 src/openvpn/multi.c   |  2 ++
 src/openvpn/options.c |  6 ++++--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 99b544a5..cf20334c 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -603,26 +603,14 @@ dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
 
     if (addrtype == MR_ADDR_IPV6)
     {
-        int netbits = 128;
-        if (addr->type & MR_WITH_NETBITS)
-        {
-            netbits = addr->netbits;
-        }
-
-        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, netbits,
+        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
                          &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
                          DCO_IROUTE_METRIC);
     }
     else if (addrtype == MR_ADDR_IPV4)
     {
-        int netbits = 32;
-        if (addr->type & MR_WITH_NETBITS)
-        {
-            netbits = addr->netbits;
-        }
-
         in_addr_t dest = htonl(addr->v4.addr);
-        net_route_v4_add(&m->top.net_ctx, &dest, netbits,
+        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits,
                          &mi->context.c2.push_ifconfig_local, dev, 0,
                          DCO_IROUTE_METRIC);
     }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 95414429..1f9d0201 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1241,6 +1241,7 @@ multi_learn_in_addr_t(struct multi_context *m,
         /* "primary" is the VPN ifconfig address of the peer and already
          * known to DCO, so only install "extra" iroutes (primary = false)
          */
+        ASSERT(netbits>=0);		/* DCO requires populated netbits */
         dco_install_iroute(m, mi, &addr);
     }
 
@@ -1280,6 +1281,7 @@ multi_learn_in6_addr(struct multi_context *m,
         /* "primary" is the VPN ifconfig address of the peer and already
          * known to DCO, so only install "extra" iroutes (primary = false)
          */
+        ASSERT(netbits>=0);		/* DCO requires populated netbits */
         dco_install_iroute(m, mi, &addr);
     }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2b0bb20c..21e2f69b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1572,12 +1572,14 @@ option_iroute(struct options *o,
 
     ALLOC_OBJ_GC(ir, struct iroute, &o->gc);
     ir->network = getaddr(GETADDR_HOST_ORDER, network_str, 0, NULL, NULL);
-    ir->netbits = -1;
+    ir->netbits = 32;		/* host route if no netmask given */
 
     if (netmask_str)
     {
         const in_addr_t netmask = getaddr(GETADDR_HOST_ORDER, netmask_str, 0, NULL, NULL);
-        if (!netmask_to_netbits(ir->network, netmask, &ir->netbits))
+        ir->netbits = netmask_to_netbits2(netmask);
+
+        if (ir->netbits<0)
         {
             msg(msglevel, "in --iroute %s %s : Bad network/subnet specification",
                 network_str,
-- 
2.37.1


