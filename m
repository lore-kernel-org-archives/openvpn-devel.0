Date: Sat, 12 Aug 2017 17:07:00 +0200
From: Michael Kress <m-kress@...1660...>
Message-ID: <20170812170700.31a0868b@...1661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] In P2P and IPv6 only mode: do_ifconfig() does not
 set up tun interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello list,

it seems that OpenVPN in P2P mode (static keys) doesn't configure and
start the tun interface when there are no configured IPv4 addresses:

OpenVPN 2.4.3
In "void do_ifconfig()" of tun.c line 881: if (tt->did_ifconfig_setup)

The flag tt->did_ifconfig_ipv6_setup is not considered at all. Is there
a reason to not start an IPv6 only tun device? Maybe this has simply
been overseen?

For testing I changed it to:
if (tt->did_ifconfig_setup || tt->did_ifconfig_ipv6_setup)

I'm on Linux. The IPv4 addresses are initialized with 0.0.0.0, the "ip"
tool doesn't complain, the IPv6 address is configured, the tun
interface gets up.

A trick would be to use something like this in the config file:
ifconfig 0.0.0.0 0.0.0.1

Alternatively one would have to set up the tun interface manually after
starting the tunnel. 

-- 
Servus
  Michael

