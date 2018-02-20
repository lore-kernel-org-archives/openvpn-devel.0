Date: Tue, 20 Feb 2018 13:03:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220120355.GA66512@...1296...>
References: <1516909513-31683-1-git-send-email-selva.nair@...277...>
 <201802201030.w1KAUZKR065496@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <201802201030.w1KAUZKR065496@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow external EC key
 through --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 11:30:35AM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> (I have not done any real review on it, except "compile test" and "stare
> a bit at the code for really obvious issues" - trusting Arne since his
> GUI seems to be the only thing really using it today, so if he's happy,
> I am as well)
>=20
> commit 7eca140c70ff76177371dc94c19aeb8644c2c3b5
> Author: Selva Nair
> Date:   Thu Jan 25 14:45:13 2018 -0500
>=20
>      Allow external EC key through --management-external-key

*sigh*

Today's the day of buildbot exploisions.

*This* one breaks LibreSSL compilation (namely, the OpenBSD buildbot),
because

ssl_openssl.c: In function 'tls_ctx_use_external_ec_key':
ssl_openssl.c:1229: error: 'EC_KEY_METHOD' undeclared (first use in this fu=
nction)
ssl_openssl.c:1229: error: 'ec_method' undeclared (first use in this functi=
on)
ssl_openssl.c:1233: warning: implicit declaration of function 'EC_KEY_METHO=
D_new'
ssl_openssl.c:1233: warning: implicit declaration of function 'EC_KEY_OpenS=
SL'
ssl_openssl.c:1240: warning: implicit declaration of function 'EC_KEY_METHO=
D_set_init'
ssl_openssl.c:1241: warning: implicit declaration of function 'EC_KEY_METHO=
D_set_sign'
ssl_openssl.c:1249: warning: implicit declaration of function 'EC_KEY_set_m=
ethod'

So we need another "&& !defined(LIBRESSL)" here, I think.

(And this, dear OpenBSD folks, is why application developers are just
a tiny little bit unhappy with the way LibreSSL claims OpenSSL "recent API"
compatibility by means of OPENSSL_VERSION but then... doesn't)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajA6qAAoJEB2Cnv7KVigSRKML/1HWXEgL74S47yAudKKVJAvA
UvTp29ZAGqA7hP1UNs1FTxMkZJUsaQAQgv4k57jxDCdQL4n0h4D09mjBbqYaKkYF
hUDzH6e68QgwLgYPbZRU5QB4bM6YL5MjLCLVkfEblVgH9clwh9n+4+eXlPZ+6dbG
KPuZLJKykkpYNL+UUKX01nqFsBJLf+SSmpnhpeDsic2eLVAgzpDbczVBW0vScPbc
Kot5i+85sEDOejMy9nxjBda0II9XEn52yEJBJVTFdWcfCfTM6QxlAEJ8g5m4R27k
qFJ8IvzY/PcLCv49B1Y3d7GAJhJnjXGcGRWj08ZCmUwxGwxGVb1IiDb6LGcWXA4I
3B6AEL6RaqFfiemUHOaILuwoTDpG0RZP0kH2yyfYGqsQzLj2W8z1MP/dHbo24jy2
PlA0L4MjaIkrc83X54T3PyGdUviK7TMpd2f50wzwD/yqYbTeQfAZnk30Tazj1kRO
6qhS1jPf1ubQD2/KRiU+mWA9yTbv1JtTs9haNGbdYw==
=XXip
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

