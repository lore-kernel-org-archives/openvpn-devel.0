MIME-Version: 1.0
Date: Tue, 15 May 2018 18:01:41 -0700
From: Scott Shambarger <devel@...2399...>
Message-ID: <2f575943f32de2328843b3cec3286ca1@...2399...>
Subject: [Openvpn-devel] Darwin tap ipv6 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I’m setting up a tap config on a Darwin client (Tunnelblick on OSX) to a 
Linux server (Fedora).  The config has the following (only relevant 
portions):

== server
dev tap0
server-bridge
push "redirect-gateway def1 ipv6"
push "ifconfig-ipv6 {local-ipv6-address} {linklocal-addr}”
…etc

== client
client
dev tap
remote {host} {port} udp4
…etc

The ipv4 vpn works fine, but the routes created for ipv6 are on the 
wrong interface — they're on the network transport interface, not the 
tap interface.  This causes ipv6 to not function (since the 
{linklocal-addr} cannot be reached on that network interface)

I tracked the problem to route.c around line 1880 (in v2.4.6 at least).

(a) There is Darwin/BSD specific code that modifies the gateway string 
variable to include the interface name (to “<gatewayip>%<iface>”) if 
gateway_needed is true, but it only works if r6->iface is non-NULL.

(b) the gateway_needed flag is set for tap devices, but only after it’s 
checked in (a).

I’ve included a patch below that moves (b) above (a), and uses the local 
“device" variable (which is either the tt->actual_name, or r6->iface if 
set) when creating the modified gateway string.  With this change, the 
routes are created on the correct interface — the logs show:

== before
add_route_ipv6(::/3 -> {linklocal-addr} metric -1) dev tap0
/sbin/route add -inet6 :: -prefixlen 3 {linklocal-addr}
    add net ::: gateway {linklocal-addr}

== after
add_route_ipv6(::/3 -> {linklocal-addr}%tap0 metric -1) dev tap0
/sbin/route add -inet6 :: -prefixlen 3 {linklocal-addr}%tap0
   add net ::: gateway {linklocal-addr}%tap0

NOTE1: In the process of setting this up, I noticed a warning message to 
gives the wrong advice (route.c:453):

         msg(M_WARN, PACKAGE_NAME " ROUTE6: " PACKAGE_NAME " needs a 
gateway par\
ameter for a --route-ipv6 option and no default was specified by either 
--route\
-ipv6-gateway or --ifconfig-ipv6 options");

... There is no "route-ipv6-gateway" option (although it'd be nice to 
have one, since for tap at least the {local-ipv6-address} on the 
ifconfig-ipv6 option (in my config above) appears to be ignored.

NOTE2: Since ipv6 does automatic address configuration anyway... it'd be 
nice to add a ipv6 equivalent to the dhcp_extract_router_msg() function 
(called in forward.c to get the DHCP gateway) that extracts the default 
gateway so that ifconfig-ipv6 isn't needed at all.  I'd be happy to make 
an attempt at that if it'd be useful :)

Thanks,
Scott

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2d6428b2..35ae8d09 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1879,6 +1879,18 @@ add_route_ipv6(struct route_ipv6 *r6, const 
struct tuntap *tt, unsigned int flag
      network = print_in6_addr( r6->network, 0, &gc);
      gateway = print_in6_addr( r6->gateway, 0, &gc);

+    /* On "tun" interface, we never set a gateway if the operating 
system
+     * can do "route to interface" - it does not add value, as the 
target
+     * dev already fully qualifies the route destination on 
point-to-point
+     * interfaces.   OTOH, on "tap" interface, we must always set the
+     * gateway unless the route is to be an on-link network
+     */
+    if (tt->type == DEV_TYPE_TAP
+        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
+    {
+        gateway_needed = true;
+    }
+
  #if defined(TARGET_DARWIN)    \
      || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
      || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
@@ -1887,12 +1899,12 @@ add_route_ipv6(struct route_ipv6 *r6, const 
struct tuntap *tt, unsigned int flag
       * but for link-local destinations, we MUST specify the interface, 
so
       * we build a combined "$gateway%$interface" gateway string
       */
-    if (r6->iface != NULL && gateway_needed
+    if (gateway_needed
          && IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )        /* 
fe80::...%intf */
      {
-        int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
+        int len = strlen(gateway) + 1 + strlen(device)+1;
          char *tmp = gc_malloc( len, true, &gc );
-        snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
+        snprintf( tmp, len, "%s%%%s", gateway, device );
          gateway = tmp;
      }
  #endif
@@ -1905,18 +1917,6 @@ add_route_ipv6(struct route_ipv6 *r6, const 
struct tuntap *tt, unsigned int flag
       * (not currently done for IPv6)
       */

-    /* On "tun" interface, we never set a gateway if the operating 
system
-     * can do "route to interface" - it does not add value, as the 
target
-     * dev already fully qualifies the route destination on 
point-to-point
-     * interfaces.   OTOH, on "tap" interface, we must always set the
-     * gateway unless the route is to be an on-link network
-     */
-    if (tt->type == DEV_TYPE_TAP
-        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
-    {
-        gateway_needed = true;
-    }
-
  #if defined(TARGET_LINUX)
  #ifdef ENABLE_IPROUTE
      argv_printf(&argv, "%s -6 route add %s/%d dev %s",

