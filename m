Message-ID: <46A4E272.9030002@...1000...>
Date: Mon, 23 Jul 2007 19:16:34 +0200
From: Peter Warasin <peter@...1000...>
MIME-Version: 1.0
Subject: [Openvpn-devel] centralized filtering
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi guys

Is there a possibility to configure openvpn server in order to push to
it's clients a routing constellation in a manner that every traffic from
a vpn endpoint to another vpn endpoint must pass the tap device on the
openvpn server?


I have an openvpn (2.0) server and several clients which connect to it.

This is the relevant part of the server configuration:
-------------------------
dev tap1
client-to-client
server-bridge 10.0.0.1 255.255.255.0 10.0.0.160 10.0.0.180
push "route-gateway 10.0.0.1"
-------------------------

Since this pushes the following to the clients:
-------------------------
ip link set dev tap2 up
ip addr add dev tap2 10.0.0.x/24 broadcast 10.0.0.255
-------------------------

traffic from one endpoint to another will never pass the tap1 device on
the server, but go directly.

Now i would like to filter traffic between the both endpoints, but can
do it only if the traffic passes the tap device and so also netfilter.


Manually i am able to set this up:
-------------------------
ip route add 10.0.0.1/32 dev tap2
ip route add 10.0.0.x/32 dev tap2
ip route add 10.0.0.0/24 via 10.0.0.1
-------------------------


But i would like to push those routes from the server to the client. I
see no possibility to achieve this. Did i miss something or is this not
possible at all?


I tried
-------------------------
ifconfig 10.0.0.1 255.255.255.0
ifconfig-pool 10.0.0.160 10.0.0.180 255.255.255.255
push "route 10.0.0.0/24"
push "route-gateway 10.8.0.1"
-------------------------

but so certainly the hostroute which directs traffic for the vpn_gateway
10.0.0.1 to the clients tap device will not be created and thus
route 10.0.0.0/24 will not be inserted because it's gateway is unknown.


Is there no possibility to push this type of config?

I would need something like this:
push "route 10.0.0.1 0.0.0.0 0 client_device", which then explodes to
ip route add 10.0.0.1/32 dev client_device.

I thought about to patch this in (and i will, if there is no other
possibility), but since our customers like to have the choice to use the
original openvpn client from the openvpn.net page it is not a good
solution and i would prefer if there is a solution which i did not see
yet  :)

Hope for some pointers in the right direction and
thank you in advance by now.

peter


-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.com   :: peter@...1028...

