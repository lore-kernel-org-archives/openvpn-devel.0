Date: Wed, 10 Aug 2011 22:32:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110810203250.GB8496@...1296...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-2-git-send-email-heiko.hund@...1489...>
	<4FAA35BD289B4FD989857452D4E18777@...139...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+1a/1p256hrSZOG"
Content-Disposition: inline
In-Reply-To: <4FAA35BD289B4FD989857452D4E18777@...139...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] define IN6_ARE_ADDR_EQUAL macro
	for	WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gisle Vanem <gvanem@...139...>
Cc: openvpn-devel@lists.sourceforge.net

--z+1a/1p256hrSZOG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 10, 2011 at 03:47:36PM +0200, Gisle Vanem wrote:
> "Heiko Hund" <heiko.hund@...1489...> wrote:
>=20
> > +#ifndef IN6_ARE_ADDR_EQUAL
> > +#define IN6_ARE_ADDR_EQUAL(a,b) \
> > +    ((((__const uint32_t *) (a))[0] =3D=3D ((__const uint32_t *) (b))[=
0]) \
> > +  && (((__const uint32_t *) (a))[1] =3D=3D ((__const uint32_t *) (b))[=
1]) \
> > +  && (((__const uint32_t *) (a))[2] =3D=3D ((__const uint32_t *) (b))[=
2]) \
> > +  && (((__const uint32_t *) (a))[3] =3D=3D ((__const uint32_t *) (b))[=
3]))
> > +#endif
>=20
> A little more readable:
>   #define IN6_ARE_ADDR_EQUAL(a, b)   \
>               (!memcmp ((const void*)(a), (const void*)(b), sizeof (struc=
t in6_addr)))

... and guaranteed to be safe regarding alignment... so I like the second
one better.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--z+1a/1p256hrSZOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTkLq8qkuBuNlUUl1AQJiFQQAratAzHAxrGhW7tXelBHVKdN59djdSFwY
FIXwTFvZex41ZiHU9RQpkjWREcfR+hORPfeXplTvsVL0cUctQinMTbyqsP78Aisj
aSkbsq3sOLT6iuGdyGO/qTIcwKfiCcNxc2nHHG5CvjFRtRkIB8LL0MDuwpPwIDik
yovzI97pMU8=
=5vyY
-----END PGP SIGNATURE-----

--z+1a/1p256hrSZOG--

