Date: Sat, 26 Apr 2014 23:00:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140426210044.GF16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncIUvDqbr65b/ESw"
Content-Disposition: inline
Subject: [Openvpn-devel] socket.c issues when building snapshots on
	windows...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ncIUvDqbr65b/ESw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

with some arm-twisting, I managed to convince build-snapshot to actually
do that (it would prefer to do a git clone, autoconf, tarball, copy tarball,
ignore the tarball, fetch 2.3.3 source, extract 2.3.3 and build that, thus
never showing compilation errors...), and here we go...

socket.c: In function 'socket_bind':
socket.c:1124:40: error: 'IPV6_V6ONLY' undeclared (first use in this functi=
on)
socket.c:1124:40: note: each undeclared identifier is reported only once fo=
r each function it appears in
socket.c:1124:7: warning: passing argument 4 of 'setsockopt' from incompati=
ble pointer type [enabled by default]
/usr/lib/gcc/i686-w64-mingw32/4.6/../../../../i686-w64-mingw32/include/wins=
ock2.h:1016:34: note: expected 'const char *' but argument is of type 'int =
*'
socket.c: In function 'openvpn_connect':
socket.c:1218:32: error: 'const struct sockaddr' has no member named 'addr'
socket.c:1218:62: error: 'const struct sockaddr' has no member named 'addr'
socket.c: In function 'socket_recv_queue':
socket.c:3135:45: error: 'struct link_socket_addr' has no member named 'loc=
al'

... I'm posting this here so whoever has time can take a stab at it=20
(I won't be able to work on this for the next couple of days, will focus
on 2.3.4 release items).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ncIUvDqbr65b/ESw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1wefKkuBuNlUUl1AQKYPgP/QKRHvoIIGW9D1Scmlu2BeUKkS68xDQfZ
pBV574WUJHiZzo5TQ6vfGTCRTG123OwY9jfHdNP0W+lxAM3T7gHCgkVDYfVmstwp
Cgn0SVzbtoLV3IBXgZCXODgDtpyljBsLkVeVjPz6qp+23CGkP1NXo4X8NcDcWSyU
lUMoZzF/0sA=
=ICyl
-----END PGP SIGNATURE-----

--ncIUvDqbr65b/ESw--

