Reply-To: garth_fisher@...87...
From: "garth_fisher@...87..." <garth_fisher@...87...>
MIME-Version: 1.0
Message-Id: <20030813213722.56656BF99@...88...>
Subject: [Openvpn-devel] Multiple connections over single listener port
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Aug 13 15:15:09 2003
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: 

Hi all,

I need to listen for many connections on one machine, but I am only allowed one hole in the firewall.  I have seen some discussion of adding support for this to OpenVPN.  I have come up with a technique that achieves my goals without modifying OpenVPN ...

I know the IP address and port of each initiating end point.  So, I just use iptables to NAT each connection to the appropriate local listener port.  For my proof of concept I set up three machines.  A listener, initiator, and a router/fw.

Listener 
--------
eth0:  192.168.1.50
lo alias: 10.5.10.5
route to 10.0.10.10 through 192.168.1.52
OpenVPN listening on 10.5.10.5:5001

Initiator
---------
eth0:  10.0.10.10
route to 192.168.1.50 through 10.0.10.1
OpenVPN initiator port: 5000
OpenVPN initiating connection to 192.168.1.50:5000

Router/FW 
---------
ethO:  192.168.1.52
eth1:  10.0.10.1
firewall rule allows traffic to and from 192.168.1.50 udp port 5000

On the Listener machine I added this rule:
iptables -t nat -A PREROUTING -p udp --sport 5000 -s 10.0.10.10 -d 192.168.1.50 --dport 5000 -j DNAT --to-destination 10.5.10.51:5001

... and viola!  You would need a good firewall like iptables to use this technique of course so it may not be an option for everybody.  Any thoughts?

.garth




_______________________________________________


