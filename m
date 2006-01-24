From: Michael Renner <robe@...476...>
Message-ID: <loom.20060125T020914-740@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Problems when using a default gateway of 0.0.0.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jan 24 17:24:23 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

my ISP recently changed the default gateway address handed out when doing a pptp
session from a "normal" IP to 0.0.0.0, destroying my setup which looked
something like that:

push "route 1.2.3.34 255.255.255.255 net_gateway"
push "route 1.2.3.32 255.255.255.248 vpn_gateway"

where 1.2.3.34 is the address of the openvpn server (which needs not to get
routed over the vpn tunnel, for obvious reasons).

My current routing table (without vpn sessions) looks like that:

Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
172.25.46.38    0.0.0.0         255.255.255.255 UH    0      0        0 ppp0
172.18.125.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
0.0.0.0         0.0.0.0         0.0.0.0         U     0      0        0 ppp0

Where 172.25.46.38 is the P-t-P address of the pptp session, 172.18.125.0 being
the net of the DHCP address handed out so that I can initiate the pptp session
and 0.0.0.0 being the infamous default gateway.

Doing a manual "route add -host 1.2.3.34 ppp0" fixes it, but this is a
bandaid-patch at best.

Do you think that you can enhance the functionality/keywords available to the
route function to include the device of the default gateway so that something
like that is possible:

"route <ip> <mask> net_gateway_device"

or maybe fall-back to that behaviour if the address of the default gateway is
0.0.0.0.

best regards and thanks in advance,
Michael


