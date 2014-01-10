Date: Fri, 10 Jan 2014 16:54:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140110155403.GF226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<20140110140728.GD226@...1296...>
	<52D003F2.5050109@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="367OTzzFqQya5wJv"
Content-Disposition: inline
In-Reply-To: <52D003F2.5050109@...1227...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

--367OTzzFqQya5wJv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 10, 2014 at 03:30:10PM +0100, Arne Schwabe wrote:
> But
>=20
> [AF_INET6]::ffff:87.238.42.150:47707
>=20
> and=20
>=20
> [AF_INET6]2a02:c0:100:0:9e8e:99ff:fed1:5243:56277
>=20
> should be same the same size and handled both the same way from OpenVPN s=
ince they are both IPv6.

Good point.  So why are we ASSERT(0)ing?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--367OTzzFqQya5wJv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtAXm6kuBuNlUUl1AQLzBwP/Yy4zrurQEkxvn/MEDn8VuyiFX9V8bXLS
2lekaV31agU4XXLt6wIQHrQV9b1bNOUsJJZQZdgcsQXo+hDMVU5uVtrYJBUrg+Px
1gD36gAHvFjfzbQIM1LhaJYnzBtdCIjBF0hn4E+sluvG4VbSbQJwINhIRyUNt/B/
4jDOvMX6DAg=
=hyqw
-----END PGP SIGNATURE-----

--367OTzzFqQya5wJv--

