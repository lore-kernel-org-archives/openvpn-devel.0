From: "die pes" <diepes@...160...>
Mime-Version: 1.0
Message-ID: <BAY19-F4e8tlMazUSxv0000c938@...160...>
Subject: [Openvpn-devel] TUN Server: Suggested IP allocation change
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
Date: Sun Nov 14 07:56:04 2004
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi I tried Openvpn and it worked great, hardest part is setting up the pki.

Problem with openvpn routing.

Currently for IP routing using the tun device, each client is assigned a /30 
subnet.  This does not make sence as the server has only a single IP.  
(Could work if individual interface created on server with unique IP for 
each)

I suggest we simplify it into a point to multipoint setup with /32 mask per 
client.

This will reduce IP usage by 400% and simplify setup.

E.G.  server 10.1.0.0 255.255.255.0
Server:
ifconfig tun0 10.1.0.1 netmask 255.255.255.255 -broadcast -multicast 
pointopoint 0.0.0.0
ip route add 10.1.0.0/24 dev tun0

Client1:
ifconfig tun0 10.1.0.2 netmask 255.255.255.255 -broadcast -multicast 
pointopoint 10.1.0.1

Client2:
ifconfig tun0 10.1.0.3 netmask 255.255.255.255 -broadcast -multicast 
pointopoint 10.1.0.1

For security, and to enforce iptables rules, the server should not allow ip 
traffic to or from wrong IP for each client tunnel.  The IP info will also 
be used to decide witch tunnel to use.

If clients are to talk to each other directly, the host can route traffic in 
and out on the tun interface after applying iptables rules.

It is just a suggestion.

Regards,
Pieter

_________________________________________________________________
Save your chats with a single keystroke - get MSN Toolbar! 
http://messenger.msn.co.za?DI=1054&XAPID=2532


