From: Torge Szczepanek <openvpn-devel@...239...>
Subject: Re: [Openvpn-devel] Setting source address for UDP replies on multihomed server
References: <16622.28948.53644.813410@...253...>
In-Reply-To: <16622.28948.53644.813410@...253...>
MIME-Version: 1.0
Message-Id: <200407091634.19714.openvpn-devel@...239...>
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
Date: Fri Jul  9 07:38:03 2004
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 09 July 2004 12:19, Neil Brown wrote:
> My server that I hope to use as an OPENVPN server is multi-homed.
> i.e. it has multiple network interfaces and multiple addresses on
> multiple subnets.

I have the same problem on my multihomed server, which is running PBR (poli=
cy=20
based routing).

eth0 is the device with the default route.

eth3.81 ist a device (on a VLAN trunk) with vlan 81

I have a PBR setup which routes traffic outgoing on eth3.81 through another=
=20
default gateway connected to eth3.81.

Like this:

ifconfig eth0 192.168.2.100
route add default gw 192.168.2.1 dev eth0

ifconfig eth3.81 192.168.1.100=20
ip rule add from 192.168.1.100 lookup table 100
ip route add default via 192.168.1.1 table 100
ip route flush cache

OpenVPN seems to answer all incoming OpenVPN connections on eth3.81to=20
192.168.1.100 through the default route on eth0 with source adress=20
192.168.2.100
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7qzrosmtDiD9dbIRArbEAKCcopV+QLnMPDye4Tv+6OWEyr/jtwCgvnam
EMkoCEWy4jku32YPl7Wwf2I=3D
=3DYYVq
-----END PGP SIGNATURE-----

