Date: Tue, 21 Feb 2012 21:17:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120221201702.GC7024@...1296...>
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1gsfN/+pS0/2Ta7u"
Content-Disposition: inline
In-Reply-To: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--1gsfN/+pS0/2Ta7u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2012 at 05:15:22PM +0200, Alon Bar-Lev wrote:
> OpenVPN supports minimum openssl version of 0.9.6, while this version
> is unsupported by upstream and probably a security risk.
>=20
> What would be a suitable minimum version to support?
>=20
> I think that 0.9.8 is the one.

FreeBSD 7.3 has 0.9.8e, and that's the oldest version supported by
the FreeBSD security team.  So if anyone wants to run OpenVPN on an
older version of FreeBSD, they need to use the ports version of=20
openssl - but that's their decision to not upgrade.

I'm not exactly sure at which point NetBSD and OpenBSD moved to 0.9.8,
but I'm fairly sure that dropping support for anything older than
that is OK for these platforms as well (and if needed, the pkgsrc
version of openssl can be used).

So "+1" on that one.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1gsfN/+pS0/2Ta7u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0P7vakuBuNlUUl1AQKGhAQAsnirur0j37Qpk23F4xZw0er91CNcg2sc
H6FDn4J7LQvLITvJ66wTSyIxEr/CKja/IwL19JKPKQ3RsodRhbWRqndt8GdpfW1T
C1UzpARvsGcdr3DPJEmXWWUFadV+ypsoUhrn/1NscLRaV2HIuVa6XKg2Gq9Pyukj
aMkmVMl77eE=
=NMoq
-----END PGP SIGNATURE-----

--1gsfN/+pS0/2Ta7u--

