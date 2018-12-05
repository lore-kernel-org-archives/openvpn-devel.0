From: Gert Doering <gert@...1296...>
Date: Wed,  5 Dec 2018 22:07:34 +0100
Message-Id: <20181205210734.62565-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Stop complaining about IPv6 routes without
 gateway address.
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

The IPv6 routing code inherited assumptions and the message

   "OpenVPN ROUTE6: OpenVPN needs a gateway parameter for a --route-ipv6
    option and no default was specified by either --route-ipv6-gateway or
    --ifconfig-ipv6 options"

from the IPv4 routing code.

This was never really correct, as no gateway is needed for "into tun
device" IPv6 routes, and the "--route-ipv6-gateway" option it refers
to also never existed.  (Routes on tap interfaces *do* need a gateway
due to neighbour discovery being involved.  As do routes on Windows,
but there we fake the gateway in tun mode anyway).

Change the code to generally accept IPv6 routes with no gateway
specification (so "--block-ipv6 --redirect-gateway ipv6" can work
without additional config).  When installing IPv6 routes, check
if a gateway is needed (tap mode) but missing, and if yes, print
correct message.

Trac: #1143

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d97e8dba..cf51063b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -448,11 +448,6 @@ init_route_ipv6(struct route_ipv6 *r6,
     {
         r6->gateway = rl6->remote_endpoint_ipv6;
     }
-    else
-    {
-        msg(M_WARN, PACKAGE_NAME " ROUTE6: " PACKAGE_NAME " needs a gateway parameter for a --route-ipv6 option and no default was specified by either --route-ipv6-gateway or --ifconfig-ipv6 options");
-        goto fail;
-    }
 
     /* metric */
 
@@ -1917,6 +1912,16 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
         gateway_needed = true;
     }
 
+    if (gateway_needed && IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+    {
+        msg(M_WARN, "ROUTE6 WARNING: " PACKAGE_NAME " needs a gateway "
+            "parameter for a --route-ipv6 option and no default was set via "
+            "--ifconfig-ipv6 option.  Not installing IPv6 route to %s/%d.",
+            network, r6->netbits );
+        status = false;
+        goto done;
+    }
+
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
     argv_printf(&argv, "%s -6 route add %s/%d dev %s",
@@ -2114,6 +2119,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
+done:
     if (status)
     {
         r6->flags |= RT_ADDED;
-- 
2.18.1


