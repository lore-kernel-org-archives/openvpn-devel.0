Message-ID: <53F1D97B.8010801@...1085...>
Date: Mon, 18 Aug 2014 05:46:19 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000002060003070209050407"
Subject: [Openvpn-devel] IPv6 pool and handling CIDR masks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000002060003070209050407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

First, an overview of IPv6 pool and CIDR handling.

The handling of the --ifconfig-ipv6-pool `bits` CIDR netmask value seems to
need adjustment. Today, if this value does not exactly match the same CIDR
mask applied to --ifconfig-ipv6, clients connectivity breaks in odd ways.

I am proposing that we update the behavior to effectively ignore this value,
remove the documentation references to the problematic `bits` setting, and
use the server's own CIDR mask to use when pushing to clients. An
anti-climatic patch to do this will be sent as a reply, and is
backwards-compatible with existing configurations because the CIDR mask will
be accepted and ignored.

In short, clients should be pushed the CIDR mask of the server, not the mask
of the pool size. This is how IPv4 works (a pool using 128 IPs does not mean
we push a /25, but we still push the /24 used by the server.) The pool need
to be independent of the actual CIDR mask assigned to the VPN network. Until
the code can handle IPv6 pools of a smaller size and correctly refuse to use
IPs outside the pool range, it is best to not offer v6 pool size selection
at all.


So what's the problem?


The manpage says the `bits` value to the v6 pool controls the size of the
pool, which we would get in IPv4 by controlling the start/stop values.
However, this value actually has nothing to do with the pool size, and only
the initial IP is used meaningfully.

When a client connects, the multi_select_virtual_addr() function is
responsible for picking IPs for the client, based on either --ifconfig-push
values, or the pool (and their v6 equivalents.) This function in turn calls
ifconfig_pool_acquire(), which finds the first free IPv4 IP in the pool
using ifconfig_pool_find(). However, the IPv6 pool selection happens in
add_in6_addr(). This function simply counts forward from the initial IPv6
pool IP to an offset determined by the IPv4 pool IP selected.

This has a few ramifications, first of which is that the `bits` value to the
--ifconfig-ipv6-pool has no relation to the IPv6 pool size. The IPv6 pool
size is dependent on the largest offset from the start of the IPv4 pool. At
the very least this makes the manpage description misleading.

The situation gets stranger when you have configs that attempt to use a
specific "size" IPv6 pool that varies from the server's configured CIDR
mask.


And now, some examples of problematic configs.


In case #1, the server uses a /64 with a v6 pool size of /112. The client
can successfully ping the server, but not clients issued an IP (perhaps by
--ifconfig-ipv6-push) outside of this /112, even though the entire /64
should be reachable through the server. This is because the client is
incorrectly pushed a CIDR mask of /112 when that value should have only
defined the size of the v6 pool.

Case #2 is nearly the same as #1, except the /112 used for the pool is not
in the same /112, but still within the server's /64. This has the effect of
preventing the client from pinging even the server itself as the client is
told to configure its tun device on a /112 while the server is not in that
/112.

More ugly side-effects happen in case #3 where the server is configured with
ifconfig-ipv6 with a server CIDR mask of /122 (we'll come back to this value
in a moment.) However, the smallest allowed v6 pool is /112, causing clients
to think the tun link contains many more IPs than it really does, and the
client will incorrectly route things not on the VPN network across the VPN.

Case #3 gets even worse in net30 mode for IPv4, where the 63rd VPN client to
connect (which would normally be given 10.8.0.252/30) will consume the
"252nd" IPv6 IP past the start of the pool. However, a /122 only has 64 IPs,
which should normally be enough to account for the 63 clients allowed by the
v4 pool. Because of how add_in6_addr() works, the 63rd client attempts to
consume the 252nd IP past the start of a pool that cannot handle it, and is
in fact off the server's IPv6 subnet. This is the case even if the pool is
configured to handle CIDR masks as small as a /124 (smallest allowed by
--ifconfig-ipv6.)


--------------000002060003070209050407
Content-Type: text/plain; charset=UTF-8;
 name="case_1.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="case_1.conf"

# Case #1: clients issued /112, not /64 used by server
dev tun
keepalive 5 15
pkcs12 server1.p12
dh dh.pem
topology subnet
server 10.8.0.0 255.255.255.0
tun-ipv6
push "tun-ipv6"
ifconfig-ipv6 fd29:884a:4456:123::1/64 fd29:884a:4456:123::2
ifconfig-ipv6-pool fd29:884a:4456:123::/112

--------------000002060003070209050407
Content-Type: text/plain; charset=UTF-8;
 name="case_2.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="case_2.conf"

# Case #2: clients issued non-lowest /112, can't ping server
dev tun
keepalive 5 15
pkcs12 server1.p12
dh dh.pem
topology subnet
server 10.8.0.0 255.255.255.0
tun-ipv6
push "tun-ipv6"
ifconfig-ipv6 fd29:884a:4456:123::1/64 fd29:884a:4456:123::2
ifconfig-ipv6-pool fd29:884a:4456:123:a:b:c::/112

--------------000002060003070209050407
Content-Type: text/plain; charset=UTF-8;
 name="case_3.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="case_3.conf"

# Case #3: server using /122
dev tun
keepalive 5 15
pkcs12 server1.p12
dh dh.pem
topology subnet
server 10.8.0.0 255.255.255.0
tun-ipv6
push "tun-ipv6"
ifconfig-ipv6 fd29:884a:4456:123::1/122 fd29:884a:4456:123::0
# NB: even if the pool supported /122, it'll issue every 4th IP
ifconfig-ipv6-pool fd29:884a:4456:123::/112

--------------000002060003070209050407--

