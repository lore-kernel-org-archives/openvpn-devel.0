From: Torge Szczepanek <openvpn-devel@...239...>
MIME-Version: 1.0
Message-Id: <200406102012.41488.openvpn-devel@...239...>
Subject: [Openvpn-devel] IP adress assignment to tun devices using server mode
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
Date: Mon Jun 14 06:46:41 2004
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I am currently trying out OpenVPN 2.0 beta 4 using server mode.

My config on the server looks like this:

dev tun
mode server
ifconfig 192.168.100.1 192.168.100.2
ifconfig-pool 192.168.100.4 192.168.100.254
push "route 192.168.100.1 255.255.255.255"
route 192.168.100.0 255.255.255.0
[...]

Everything works fine as expected. (Which is really great. I appreciate the=
=20
good work done here)

I am wondering why there is a subnet of size /30 assigned to the client. I=
=20
would expect a Point-to-Point device to receive only one ip adress and not=
=20
a /30 subnet.

tun0      Protokoll:Punkt-zu-Punkt Verbindung
          inet Adresse:192.168.100.6  P-z-P:192.168.100.5=20=20
Maske:255.255.255.255

The netmask is also not which one would expect for a /30 network.

I have some servers running with lots of ppp devices. I am assigning also=20
adresses out of a pool. The two addresses do not lie within the same subnet.

ppp138    Link encap:Point-to-Point Protocol
          inet addr:192.168.1.31  P-t-P:10.3.14.223  Mask:255.255.255.255

Is there any good reason for this /30 assignment?

Is there a config option to change this behaviour (I didn't find one)?

How many IPs can be assigned within a pool?=20

I found:

#define IFCONFIG_POOL_MAX 65536

in pool.h

Has anyone tested this beyond a class-C network?

Torge
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyKSYosmtDiD9dbIRAq95AKCL7mem4ivtrcbLbP7tFs1GdHodmgCfeQJV
O4ZsPqwgie/iAkry/8G8tvg=3D
=3D7uEu
-----END PGP SIGNATURE-----

