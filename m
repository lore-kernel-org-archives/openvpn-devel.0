From: Michael Setzer <michael.setzer@...1004...>
Date: Fri, 23 Feb 2007 09:27:46 +0100
MIME-Version: 1.0
Message-Id: <200702230927.46648.michael.setzer@...1004...>
Subject: [Openvpn-devel] net_gateway on kernel 2.6 machines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi there,

I've sent this already to the OpenVPN-User list but it might be possible that 
is better fits here:

---- 8< ----- snip ----- 8< -----

now something tricky: :)

I connect to an openvpn server which provides some routes to the clients via

push "route <subnet> <mask>"

Works fine with all clients. Now I try to re-route some hosts on one of my
clients (roadwarrior) to the machine's default gateway and use something like

route <address> 255.255.255.255 net_gateway

in the client's config-file.

But it only tells me

Feb  6 11:13:06 mordor ovpn-telefonica[18309]: OpenVPN ROUTE: net_gateway
undefined -- unable to get default gateway from system
Feb  6 11:13:06 mordor ovpn-telefonica[18309]: OpenVPN ROUTE: failed to
parse/resolve route for host/network: <address>

The client uses a ADSL DialIn and the routing tables look like this (only the
necessary part):

<IPADDRESS>   0.0.0.0         255.255.255.255 UH        0 0          0 ppp0
0.0.0.0         0.0.0.0         0.0.0.0         U         0 0          0 ppp0

An a machine with a 2.4 kernel it looks like

<IPADDRESS>      0.0.0.0        255.255.255.255 UH        0 0          0 ppp0
0.0.0.0        <IPADDRESS>      0.0.0.0        UG        0 0          0 ppp0

and here it works fine.

Is there any solution how I can use the net_gateway option?

I'll appreciate any help!

Regards,

Michael

