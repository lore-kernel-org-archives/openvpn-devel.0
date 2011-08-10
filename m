From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 10 Aug 2011 16:20:07 +0200
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-2-git-send-email-heiko.hund@...1489...>
	<4FAA35BD289B4FD989857452D4E18777@...139...>
In-Reply-To: <4FAA35BD289B4FD989857452D4E18777@...139...>
MIME-Version: 1.0
Message-Id: <201108101620.07584.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel]
 =?iso-8859-1?q?=5BPATCH_1/2=5D_define_IN6=5FARE?=
 =?iso-8859-1?q?=5FADDR=5FEQUAL_macro_for=09WIN32?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Wednesday 10 August 2011 15:47:36 Gisle Vanem wrote:
> "Heiko Hund" <heiko.hund@...1489...> wrote:
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
>               (!memcmp ((const void*)(a), (const void*)(b), sizeof (struct
> in6_addr)))
>=20
> (almost the same as in MingW's <ws2tcpip.h>).

The version I posted is taken from eglibc 2.13 on Debian testing, by the wa=
y.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

