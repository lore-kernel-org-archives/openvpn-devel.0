Date: Mon, 8 Feb 2016 22:39:29 +0100
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20160208213929.GA20623@...2120...>
MIME-Version: 1.0
Subject: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

Is there a reason for not being allowed to set route / route-ipv6
options in the ccd?

Here is our need: we have two openvpn daemons running on the same
server, one in udp mode, the other in tcp mode. Both have the same
configuration, that setup is meant for our users to use whichever
happens to be working from their network, preferring udp whenever
possible. The server thus has tun0 and tun1. Our users may have some
additional IPs routed to them, so we record these in the ccd files, for
instance:

iroute-ipv6 2a01:474:5:100::/56
route-ipv6 2a01:474:5:100::/56

However, while iroute-ipv6 is accepted by openvpn, route-ipv6 is not
accepted:

samuel.thibault/::ffff:83.200.171.86 Options error: option 'route-ipv6' cannot be used in this context

The problem is that since one can not know in advance which openvpn
daemon users will connect to (and thus which of tun0 or tun1 should have
the route), we can not set these routes statically before the users
connect.

We could of course use the --up script to set the routes, but it looks
much simpler and straightforward to set it from the ccd, since we need
to set the iroute there already anyway.

Samuel

