From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu, 29 Mar 2012 11:16:41 +0200
Message-Id: <1333012602-5419-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
Subject: [Openvpn-devel] [PATCH 3/4] cleanup: avoid using ~0 - netmask
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Use IPV4_NETMASK_HOST constant.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/basic.h  |    2 ++
 src/openvpn/mroute.c |    2 +-
 src/openvpn/pf.c     |    2 +-
 src/openvpn/route.c  |   12 ++++++------
 src/openvpn/route.h  |    2 +-
 src/openvpn/tun.c    |    2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 88539e2..7c13e22 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -46,4 +46,6 @@
 /* clear an object */
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
 
+#define IPV4_NETMASK_HOST 0xffffffffU
+
 #endif
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 5b53571..aecb702 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -342,7 +342,7 @@ mroute_addr_mask_host_bits (struct mroute_addr *ma)
 	  if ( bits_to_clear >= 8 )
 	    { ma->addr[byte--] = 0; bits_to_clear -= 8; }
 	  else
-	    { ma->addr[byte--] &= (~0 << bits_to_clear); bits_to_clear = 0; }
+	    { ma->addr[byte--] &= (IPV4_NETMASK_HOST << bits_to_clear); bits_to_clear = 0; }
         }
       ASSERT( bits_to_clear == 0 );
     }
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 7ed1e70..3c46801 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -125,7 +125,7 @@ add_subnet (const char *line, const char *prefix, const int line_num, struct pf_
     {
       /* match special "unknown" tag for addresses unrecognized by mroute */
       network.s_addr = htonl(0);
-      netmask = ~0;
+      netmask = IPV4_NETMASK_HOST;
     }
 
   {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dda71c9..f681a58 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -268,7 +268,7 @@ init_route (struct route *r,
 	    const struct route_option *ro,
 	    const struct route_list *rl)
 {
-  const in_addr_t default_netmask = ~0;
+  const in_addr_t default_netmask = IPV4_NETMASK_HOST;
   bool status;
 
   CLEAR (*r);
@@ -797,7 +797,7 @@ add_bypass_routes (struct route_bypass *rb,
     {
       if (rb->bypass[i])
 	add_route3 (rb->bypass[i],
-		    ~0,
+		    IPV4_NETMASK_HOST,
 		    gateway,
 		    tt,
 		    flags | ROUTE_REF_GW,
@@ -819,7 +819,7 @@ del_bypass_routes (struct route_bypass *rb,
     {
       if (rb->bypass[i])
 	del_route3 (rb->bypass[i],
-		    ~0,
+		    IPV4_NETMASK_HOST,
 		    gateway,
 		    tt,
 		    flags | ROUTE_REF_GW,
@@ -870,7 +870,7 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 	       * adding this special /32 route */
 	      if (rl->spec.remote_host != IPV4_INVALID_ADDR) {
 		add_route3 (rl->spec.remote_host,
-			    ~0,
+			    IPV4_NETMASK_HOST,
 			    rl->rgi.gateway.addr,
 			    tt,
 			    flags | ROUTE_REF_GW,
@@ -944,7 +944,7 @@ undo_redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *
       if (rl->iflags & RL_DID_LOCAL)
 	{
 	  del_route3 (rl->spec.remote_host,
-		      ~0,
+		      IPV4_NETMASK_HOST,
 		      rl->rgi.gateway.addr,
 		      tt,
 		      flags | ROUTE_REF_GW,
@@ -3125,7 +3125,7 @@ netmask_to_netbits (const in_addr_t network, const in_addr_t netmask, int *netbi
 static void
 add_host_route_if_nonlocal (struct route_bypass *rb, const in_addr_t addr)
 {
-  if (test_local_addr(addr, NULL) == TLA_NONLOCAL && addr != 0 && addr != ~0)
+  if (test_local_addr(addr, NULL) == TLA_NONLOCAL && addr != 0 && addr != IPV4_NETMASK_HOST)
     add_bypass_address (rb, addr);
 }
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 25ecaee..c0f5f57 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -317,7 +317,7 @@ netbits_to_netmask (const int netbits)
   const int addrlen = sizeof (in_addr_t) * 8;
   in_addr_t mask = 0;
   if (netbits > 0 && netbits <= addrlen)
-    mask = ~0 << (addrlen-netbits);
+    mask = IPV4_NETMASK_HOST << (addrlen-netbits);
   return mask;
 }
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e6a7bc8..21778a2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -489,7 +489,7 @@ init_tun (const char *dev,       /* --dev option */
 	  if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
 	    check_subnet_conflict (tt->local, tt->remote_netmask, "TUN/TAP adapter");
 	  else if (tt->type == DEV_TYPE_TUN)
-	    check_subnet_conflict (tt->local, ~0, "TUN/TAP adapter");
+	    check_subnet_conflict (tt->local, IPV4_NETMASK_HOST, "TUN/TAP adapter");
 	}
 
       /*
-- 
1.7.3.4


