From: "Serge Wautier" <serge@...635...>
Date: Mon, 12 Mar 2007 23:37:03 +0100
Message-ID: <009a01c764f6$f4cf57b0$0201a8c0@...1010...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Problem with bridge and client to client
	communication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Env.: Server: OpenVPN 2.0.6 / Debian / TAP
      Clients: OpenVPN 2.0.5 / XP SP2

Hi Devs,

Sorry for the intrusion. Since I couldn't find help on openvpn-users, I tho=
ught I'd ask you guys.

Server setup: Bridge of dummy interface (dummy0) and tap0. The purpose is t=
o make client-to-client communications using filtering rules (hence no --cl=
ient-to-client rule).

Note: TUN is not an option in this setup.

Bridge setup looks fine. (10.8.0.1/24)
Clients can connect to the VPN. They receive the expected IPs. They can pin=
g the server. So far so good!

Problem: They can't ping each other.

Checks I made:=20
- no filtering whatsoever. Iptables, arptables and ebtables -L are all empt=
y with default policy ACCEPT.
- The settings in /proc/sys/net/bridge are set to 1. But since the correspo=
nding filter tables are empty...
- when issuing a ping from clientA to clientB, clientA sends an ARP request=
. ClientB never sees it (hence does not reply).
- It's not only an ARP problem: I 'hardcoded' each other's MAC address in e=
ach client's ARP table. Same result: Sent ping packets are not seen by the =
other one.
- When using --client-to-client, clients can ping each other. Of course, ip=
tables filtering doesn't work.

Q: What do I do wrong? Is this setup supposed to work? If not, why?

TIA for your lights,

Serge.

PS:=20

Server config:
-------------

mode server
tls-server

port 1194
proto udp
dev tap0
local 192.168.1.30

ifconfig-pool 10.8.0.10 10.8.0.254 255.255.255.0
keepalive 10 40

log-append logudp.txt

ca   ca.crt
cert server.crt
key  server.key
dh   dh.pem

comp-lzo
persist-key
persist-tun
status openvpn-status-udp.log
verb 3
mute 5

Client config:
-------------

client
dev tap
proto udp

remote 192.168.1.30 1194
keepalive 10 40

ip-win32 netsh
dev-node VPN

ca   ca.crt
cert client.crt
key  client.key

resolv-retry infinite
nobind

comp-lzo
persist-key
persist-tun
verb 3
mute 20


