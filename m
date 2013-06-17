Date: Mon, 17 Jun 2013 13:51:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130617115112.GQ20843@...1296...>
References: <20130617110003.GX4767@...1330...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhVIuFYUg5EX4UVz"
Content-Disposition: inline
In-Reply-To: <20130617110003.GX4767@...1330...>
Subject: Re: [Openvpn-devel] Fix for CVE-2013-2061 breaks multihome?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, 712414@...40...

--RhVIuFYUg5EX4UVz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 17, 2013 at 01:00:03PM +0200, Alberto Gonzalez Iniesta wrote:
> I applied the fix for CVE-2013-2061 [0] to Debian's stable version of
> openvpn (2.2.1) [1]. When the new package was sent to the mirrors I got
> a couple of reports of broken VPNs [2]. After some testing I think the
> problem arises with the use of "multihome" option. The server daemon
> starts to log lots of these:
> Jun 17 12:43:52 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument (co=
de=3D22)
> Jun 17 12:43:53 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument (co=
de=3D22)
>=20
> If the "multihome" option is removed, the VPN comes back to live.
>=20
> Could a patch to fix this be made or should we go back to 2.2.1 without
> the patch to fix CVE-2013-2061?

This patch is most definitely not affecting multihome.  If you look at
the patch, there is nothing in there that could affect external behaviour
(except remove the timing variance).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RhVIuFYUg5EX4UVz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUb74MKkuBuNlUUl1AQJ4tQP/bCC3rJpa7PZKlFIekeWe3FIXv1TIg7P7
6m7x9gLQ1KZVWKCrKElSFMc6rMIJ7qV8hk7ZyLhvJzqAuvAyEOPCH4kksoLiOIzP
D6H4X8hyeWo5FLEY0hHV7946MldUkX3iIGF12LqglFnKI3RUCA9ZZPCLX+qK+Vss
nZuIdayhce4=
=xezr
-----END PGP SIGNATURE-----

--RhVIuFYUg5EX4UVz--

