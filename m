From: R P Herrold <herrold@...43...>
Message-ID: <Pine.LNX.4.44.0209161639420.29967-100000@...44...>
MIME-Version: 1.0
Subject: [Openvpn-devel] hub and spoke topology checklist.txt
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=openvpn-devel>
Date: Mon Sep 16 14:06:02 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, R P Herrold <herrold@...43...>

I was working through the openvpn material, and had been 
testing with the following design checklist (see bottom)

The thought is to provide a hub and spoke design for isolated
non-routable subnets at the end of the spokes, behind
otherwise properly routed outbound-only NATting (which allow 
return packets ...), where there is available a central
routable IP hub available (to allow static custom routing 
between those subnets).

I can ping, and indeed set up an SSH session, out to the hub,
which indicates that encapsulation of TCP within the OpenVPN
client is occurring -- I leave encryption off, as I am in
process diagnosing where things are falling apart --

-- after a couple minutes, it locks up tight, and I have 
to go kill the remote Hub routing, out of band.

As such, I have not gotten the second subnet set up yet.

The tracing shows packets for a while, but then the consoles 
lock (in which the tracing is occurring), and I cannot 
ctrl-C to regain control.  Network connectivity remains active 
-- I can work out of band on the Hub, the enar spoke terminus 
is local ...

Any thoughts on a theoretical reason this should not work?

-- Russ Herrold

=============================================================

Hub and Spoke Topology:

HUB x.y.z.a is a static IP, in routable space -- all other
devices are masqueraded, and not reachible from the outside,

The VPN gateway will encapsulate VPN network destination traffic into the
TUN interface, and pass the rest along to the next hop exterior NAT device

Subnets:

                         |
           10.1.1.1      |
client --- gateway ---- NAT ------ internet ----- HUB
10.1.1.2      |       10.1.1.254    0.0.0.0     x.y.z.a
              \          |
               \--- 192.168.1.2 ----------- 192.168.1.1
                         |         P-t-P
     10.1.1.x segment    |
                        /
-----------------------/



                         |
          10.10.10.1     |
client --- gateway ---- NAT ------ internet ----- HUB
10.10.10.2    |      10.10.10.254   0.0.0.0     x.y.z.a
              \          |
               \--- 192.168.10.2 ----------- 192.168.10.1
                         |          P-t-P
     10.10.10.x segment  |
                        /
-----------------------/


Routing:

on VPN gateway-10.1.1.1

( next hop: route add default gateway 10.1.1.254 )
route add -host 192.168.1.1 gateway 192.168.1.2
route add -net 10.0.0.0 gateway 192.168.1.1


on VPN gateway-10.10.10.1

( next hop: route add default gateway 10.10.10.254 )
route add -host 192.168.10.1 gateway 192.168.10.2
route add -net 10.0.0.0 gateway 192.168.10.1


on HUB -- simple reciprocal routing for each VPN'd subnet

route add -host 192.168.1.2 gateway 192.168.1.1
route add -net 10.1.1.0 gateway 192.168.1.2
route add -host 192.168.10.2 gateway 192.168.10.1
route add -net 10.10.10.0 gateway 192.168.10.2


Local gateway behind NAT

	modprobe tun
	echo 1 > /proc/sys/net/ipv4/ip_forward   
	openvpn --remote x.y.z.a --dev tun --port 5001 \
		--ifconfig 192.168.1.2 192.168.1.1 --verb 8

Local gateway behind NAT

	modprobe tun
	echo 1 > /proc/sys/net/ipv4/ip_forward   
	openvpn --remote x.y.z.a --dev tun --port 5010 \
		--ifconfig 192.168.10.2 192.168.10.1 --verb 8

Central HUB (== x.y.z.a )

	modprobe tun
	echo 1 > /proc/sys/net/ipv4/ip_forward
	openvpn --dev tun --port 5001 \
		--ifconfig 192.168.1.1 192.168.1.2 --verb 8
	openvpn --dev tun --port 5010 \
		--ifconfig 192.168.10.1 192.168.10.2 --verb 8

===================================


