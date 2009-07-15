Date: Wed, 15 Jul 2009 12:42:30 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20090715104230.GJ3056@...30...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Fwd: openvpn 2.1~rc11-1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

The following bug report was sent to me by Oliver Seufer.
Might be importante to take a look at it.
Regards,

Alberto


----- Forwarded message from Oliver Seufer <Oliver@...1236...> -----

Date: Mon, 29 Jun 2009 10:57:56 +0200
From: Oliver Seufer <Oliver@...1236...>
To: Alberto Gonzalez Iniesta <agi@...64...>
Subject: openvpn 2.1~rc11-1

Hi Alberto,

after upgradeing from openvpn 2.0.9 to openvpn 2.1 rc18 the shaper option i=
s=20
not working correctly anymore. Ping times are extremly high even there
is less traffic then specified in the shapper option.=20

Kernel-version: 2.6.26-2-686
Debian-version: 5.0.1
OpenVPN-version: 2.1 rc18

side1.conf
dev tun
shaper 100000
local 192.168.2.37
ifconfig 192.168.123.1 192.168.123.2
secret /tmp/openvpn-test/openvpn.key
log-append /tmp/openvpn-test/side1.log

side2.conf
dev tun
##shaper 100000
remote 192.168.2.37
ifconfig 192.168.123.2 192.168.123.1
secret /tmp/openvpn-test/openvpn.key
log-append /tmp/openvpn-test/side2.log

side1 $ ping -s 1200 -i 0.5 192.168.123.2
PING 192.168.123.2 (192.168.123.2) 1200(1228) bytes of data.
1208 bytes from 192.168.123.2: icmp_seq=3D1 ttl=3D64 time=3D1.36 ms
1208 bytes from 192.168.123.2: icmp_seq=3D2 ttl=3D64 time=3D379 ms
1208 bytes from 192.168.123.2: icmp_seq=3D3 ttl=3D64 time=3D882 ms
1208 bytes from 192.168.123.2: icmp_seq=3D4 ttl=3D64 time=3D1380 ms
1208 bytes from 192.168.123.2: icmp_seq=3D5 ttl=3D64 time=3D1876 ms
1208 bytes from 192.168.123.2: icmp_seq=3D6 ttl=3D64 time=3D2360 ms
1208 bytes from 192.168.123.2: icmp_seq=3D7 ttl=3D64 time=3D2856 ms
1208 bytes from 192.168.123.2: icmp_seq=3D8 ttl=3D64 time=3D3356 ms
1208 bytes from 192.168.123.2: icmp_seq=3D9 ttl=3D64 time=3D3856 ms
1208 bytes from 192.168.123.2: icmp_seq=3D10 ttl=3D64 time=3D4339 ms
1208 bytes from 192.168.123.2: icmp_seq=3D11 ttl=3D64 time=3D4837 ms
1208 bytes from 192.168.123.2: icmp_seq=3D12 ttl=3D64 time=3D5325 ms
1208 bytes from 192.168.123.2: icmp_seq=3D13 ttl=3D64 time=3D5825 ms
1208 bytes from 192.168.123.2: icmp_seq=3D14 ttl=3D64 time=3D6309 ms
1208 bytes from 192.168.123.2: icmp_seq=3D15 ttl=3D64 time=3D6805 ms
1208 bytes from 192.168.123.2: icmp_seq=3D16 ttl=3D64 time=3D6800 ms
1208 bytes from 192.168.123.2: icmp_seq=3D17 ttl=3D64 time=3D6798 ms

The ping times will stay between 6 and 7 seconds.

The ping creates a bandwith utilisation of 10 kbits per second. This is
less then 2 kbytes per second, but shaping is set to ~100 kbytes per
seconds.

With version 2.0.9 everything works as expected.

Kind regards

Oliver Seufer

----- End forwarded message -----

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

