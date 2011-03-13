Date: Sun, 13 Mar 2011 15:22:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110313142200.GJ9835@...1296...>
References: <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Content-Disposition: inline
In-Reply-To: <20110313014000.27475.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 13, 2011 at 02:40:00AM +0100, Peter Stuge wrote:
> Changing startup scripts or wrapping openvpn is one way. But I would
> probably drive everything from the DHCP client instead.
>=20
> As I wrote, udhcpc is very very easy to deal with.

udhcp can notify components if the IP address of a PPP(!) interface changes?

"No DHCP involved on PPP links".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTXzTCKkuBuNlUUl1AQKuhAP+L6FqPQLhtHLKZXWQX17UhVVzzROcemmA
rKjfQt/IZLfQ+HIMoISGO2RFaztNab23I7kfiezvi4fUOX1dr/1z4FCfKhjhqq6U
WTNdFNbvrgGSYGLTQEqo9wZylrDPirbufaue/qfnTEnC+tHrR1XMGhIdVvEtl8fb
pqbs4voP6AA=
=yVOE
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--

