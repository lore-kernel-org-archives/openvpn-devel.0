Date: Fri, 16 Sep 2016 21:39:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160916193919.GN78279@...1296...>
References: <20160916190242.44897-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OqepWtsWobMV49gt"
Content-Disposition: inline
In-Reply-To: <20160916190242.44897-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix IP_PKTINFO related compilation
 failure on NetBSD 7.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--OqepWtsWobMV49gt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 16, 2016 at 09:02:42PM +0200, Gert Doering wrote:
> NetBSD has introduced IP_PKTINFO and struct in_pktinfo, but does not
> have the "ipi_spec_dst" structure element, causing compilation errors.
>=20
> Introduce a check for that (AC_CHECK_MEMBER) in configure.ac, and
> change all "#ifdef HAVE_IN_PKTINFO" to also check "HAVE_IPI_SPEC_DST".
>=20
> Patch inspired by NetBSD pkgsrc patch set.
>=20
> (Note: with that patch, OpenVPN --multihome is still broken for IPv4
> on NetBSD 7.0.1 / amd64, but that's a different issue)

Just as a side note: tested on Linux (Gentoo 64bit), and "linux --multihome"
still works correctly.  That was the main risk of this patch: wrongly disab=
le
IP_PKTINFO for those platform(s) that should have it, because autoconf isn't
finding the ipi_spec_dst element.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OqepWtsWobMV49gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV9xKZ6kuBuNlUUl1AQJ4zwP+Nv13G7nd4knrI2dD39MvO7bLSMTMOwV1
gnUV6EjgWKJy8JpMZj76i3umzKaExIBSUPvRJuXDSlpKz3/I4HqG/D+FanYqk0jV
2C48sbcy96OwCtyoS8S2q1+fvs1tUsvUdCCZFuWfqN3MLgZXUWQycEeiuy75WryS
4FDIe0mY00I=
=KBBQ
-----END PGP SIGNATURE-----

--OqepWtsWobMV49gt--

