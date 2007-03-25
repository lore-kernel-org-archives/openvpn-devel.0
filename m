From: "Brane F. =?utf-8?q?Gra=C4=8Dnar?=" <bfg@...1012...>
Date: Sun, 25 Mar 2007 22:57:25 +0200
MIME-Version: 1.0
Message-Id: <200703252257.25726.bfg@...1012...>
Subject: [Openvpn-devel] BUG: ifconfig-push in client config when using
	topology = subnet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: OpenVPN Users ML <openvpn-users@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

Hello :)

I think, that i found bug (using 2.1-rc1 for both client and server) which=
=20
shows up when the following conditions are met:

- server uses topology "subnet"
- client has it's own configuration file inside --ccd-dir

My server configuration:

server.conf:
--- snip ---
topology subnet
server    10.16.0.0 255.255.0.0
--- snip ---

client configuration inside ccd-dir:
--- snip ---
#
ifconfig-push 10.16.0.13 10.16.0.1
#
--- snip ---

When client (linux openvpn 2.1-rc1) authenticates,=20
it get the following pushed options:

PUSH: Received control message: 'PUSH_REPLY,route 192.168.0.0=20
255.255.0.0,route-gateway 10.16.0.1,topology subnet,ping 2,ping-restart=20
4,ifconfig 10.16.0.13 10.16.0.1'


... and therefore performs the following commands:

/bin/ip link set dev tun0 up mtu 1500
/bin/ip addr add dev tun0 10.16.0.13/4 broadcast 255.255.255.255
/bin/ip route add 192.168.0.0/16 via 10.16.0.1
RTNETLINK answers: Network is unreachable


Which is wrong... ofcourse.
If i manually perform the following commands on client, everything works ok=
ay:

/bin/ip addr flush dev tun0
/bin/ip addr add dev tun0 10.16.0.13/16
/bin/ip route add 192.168.0.0/16 via 10.16.0.1 dev tun0

Well, it seems that openvpn client doesn't know which netmask should apply =
to=20
pushed tun device address. Changing client configuration file to

--- snip ---
#
ifconfig-push 10.16.0.13 10.16.0.1-255.255.0.0
#
--- snip ---

doesn't help, becouse netmask parameter is completely ignored (it is not=20
pushed to client).

However, everything works okay with topology p2p, when client runs the=20
following command:

/bin/ip addr add dev tun0 local 10.16.0.13 peer 10.16.0.1

... reason why i want to use topology subnet? I want to assign only one ip =
per=20
client and i want also support windows and unix clients at the same time.


Best regards, Brane

--=20
Brane F. Gra=C4=8Dnar
Sistemski administrator za UNIX okolje
Interseek d.o.o., Stegne 31, SI-1000 Ljubljana
e-mail > bfg@...1012...
www.interseek.si, www.najdi.si

