Date: Sat, 13 Aug 2016 11:40:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160813094014.GQ78279@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471031614.4080.135.camel@...1866...>
	<20160812210223.GJ78279@...1296...>
	<1471037962.4080.148.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GTcZWaq9rmc9jFqg"
Content-Disposition: inline
In-Reply-To: <1471037962.4080.148.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Change timestamps to POSIX format.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

--GTcZWaq9rmc9jFqg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2016 at 11:39:22PM +0200, David Woodhouse wrote:
> Yeah, I once made git use strftime("%z") but that is... handled
> differently now.
>=20
> =A0 =A0 =A0 =A0 time(&now);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0offset =3D tm_to_time_t(localtime(&now)) - now;
> =A0=A0=A0=A0=A0=A0=A0=A0offset /=3D 60;
>=20
> Where tm_to_time_t() is basically mktime() except that *that* has
> bizarre issues on some platforms too. But fundamentally, comparing
> gmtime(now) with localtime(now) might be the way to go.

After having looked at "man localtime" and "man strftime" on a few
platforms we support, I conclude that tm_adjtime and tm_gmtoffs are
both out (not on Solaris and AIX) and "%z" as well (not on AIX).  Meh.

Can you remember what the "bizarre issues" in mktime() are, and on
which platforms?  That would be a halfway compact way to find the=20
offset, while reimplementing the "comparing gmtime to localtime" bit
(and repeating all possible errors that people have made there in the
past) is not something I'm looking forward to...

> The alternative option is just to *always* log in UTC, of course... :)

Dunno about others, but I *like* local time in timestamps - it helps my
brain put things together, and for some reason, my brain works in local
time...

(And yes, it would be much easier indeed... "just log seconds since the
Epoch in UTC!" - good enough for log correlation, bad for silly humans :-) )

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GTcZWaq9rmc9jFqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV67q/akuBuNlUUl1AQIhIQP/TEArRLH4WGREY18d114mtFlql85b3JPj
4RuoRGdZRyz3sKhWTvb4rywvuLJTFGGoabyrvsYMjRKxUYtWOti3jkv8rsCaOORm
L8hEB3w15r0d3mrMF3p7R2ILubGPM6k2OHSF2OvMx3cfIzhcF3ceORVyRbhJDdcb
WBhXV/x2Vxk=
=MNm2
-----END PGP SIGNATURE-----

--GTcZWaq9rmc9jFqg--

