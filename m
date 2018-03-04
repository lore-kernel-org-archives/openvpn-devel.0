From: Jeremie Courreges-Anglas <jca@...2272...>
References: <1520185442-22901-1-git-send-email-selva.nair@...277...>
Date: Sun, 04 Mar 2018 19:48:13 +0100
Message-ID: <87efkz7k42.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 04 2018, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>
> Openssl docs do not explicitly state these to be macros although they
> are currently defined as such.

Actually they are documented as macros by OpenSSL since day 1, see
NOTES.

> Use AC_CHECK_DECLS to test for these so that
> both function and macro forms could be detected.

Looks like the right way to handle such a situation.
Your diff looks good, and works for me against LibreSSL HEAD on
OpenBSD-current:

checking whether SSL_CTX_get_min_proto_version is declared... no
checking whether SSL_CTX_get_max_proto_version is declared... no
checking whether SSL_CTX_set_min_proto_version is declared... yes
checking whether SSL_CTX_set_max_proto_version is declared... yes

PASS: t_lpback.sh
The following test will take about two minutes.
If the addresses are in use, this test will retry up to two times.
PASS: t_cltsrv.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
All 2 tests passed
(1 test was not run)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> Though not meant as a fixup for libressl, as a side effect
> this also makes 2.4.5 build with newer libressl versions.
> (built on freebsd 11 using libressl 2.6.4 while testing patch 238)
> Notes: (i) libressl defines only the set functions and neither
> are macros. So get functions will get used from the compat layer.

More notes, possibly relevant:
- LibreSSL implement those as functions to provide better type checking.
  IIUC this is inspired by the same choice done in BoringSSL.
- yesterday I added macros for compatibility in LibreSSL HEAD, see
  https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/lib/libssl/ssl.h
  This should land in LibreSSL 2.7.0.
- adding the getters part is planned

>  configure.ac                 | 12 ++++++++++++
>  src/openvpn/openssl_compat.h |  8 ++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 626b4dd..2a8e87f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -948,6 +948,18 @@ if test "${with_crypto_library}" =3D "openssl"; then
>  			EC_GROUP_order_bits
>  		]
>  	)
> +	AC_CHECK_DECLS(
> +		[
> +			SSL_CTX_get_min_proto_version,
> +			SSL_CTX_get_max_proto_version,
> +			SSL_CTX_set_min_proto_version,
> +			SSL_CTX_set_max_proto_version,
> +		],
> +		,
> +		,
> +		[[#include <openssl/ssl.h>]]
> +
> +	)
>=20=20
>  	CFLAGS=3D"${saved_CFLAGS}"
>  	LIBS=3D"${saved_LIBS}"
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index d375fab..340d452 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -661,7 +661,7 @@ EC_GROUP_order_bits(const EC_GROUP *group)
>  #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRY=
PT
>  #endif
>=20=20
> -#ifndef SSL_CTX_get_min_proto_version
> +#if !HAVE_DECL_SSL_CTX_GET_MIN_PROTO_VERSION
>  /** Return the min SSL protocol version currently enabled in the context.
>   *  If no valid version >=3D TLS1.0 is found, return 0. */
>  static inline int
> @@ -684,7 +684,7 @@ SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
>  }
>  #endif /* SSL_CTX_get_min_proto_version */
>=20=20
> -#ifndef SSL_CTX_get_max_proto_version
> +#if !HAVE_DECL_SSL_CTX_GET_MAX_PROTO_VERSION
>  /** Return the max SSL protocol version currently enabled in the context.
>   *  If no valid version >=3D TLS1.0 is found, return 0. */
>  static inline int
> @@ -707,7 +707,7 @@ SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
>  }
>  #endif /* SSL_CTX_get_max_proto_version */
>=20=20
> -#ifndef SSL_CTX_set_min_proto_version
> +#if !HAVE_DECL_SSL_CTX_SET_MIN_PROTO_VERSION
>  /** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
>  static inline int
>  SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
> @@ -736,7 +736,7 @@ SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_=
ver_min)
>  }
>  #endif /* SSL_CTX_set_min_proto_version */
>=20=20
> -#ifndef SSL_CTX_set_max_proto_version
> +#if !HAVE_DECL_SSL_CTX_SET_MAX_PROTO_VERSION
>  /** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
>  static inline int
>  SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlqcP20ACgkQDfp0rhUk
5+7pMg//QrzqFpZQr5vIbvh0XVeclj32U22wwrFWM8TygjhNnIEowTzMaTLMQ3/0
8zrKxawqtI9iyqmyKEP9/7fStfu/exHqsv3gkNJ6Q/Ig7WcRPkM/8jTFgE4+B46q
gaIZBskjm7vEt+JOt8olbhcaOoyetsWLOzwGg6WnSb51HIX+txRqcYDSp09Nq7eo
8c7oXftg3f+xt7DoINSO8ah6rvFa5ztMuUKjGAXiTPYYlJROQhDnsriAV9Tpez+w
du+tsNP/KMJ+8/G52U+xn2raH1sEam+P0UZ++0LwQdCouNbwfNwWBpqarNA+kuVV
PQxmiPHySyBgy/9zSz11x2sf1sJ+qIfm0NMcbTdKvAONmnaJvGzGWQaRp2ygcl7t
aShXUqEQle49Vt6GdOkS4e0/JKqDJpKJKVGNk3Lb/VT71/QxU63Fe9cuUUpBFYhA
f29UGqX+sUIdKnMWLSilxOaiRBRya/GbT9febqkYKeEkCVymPyr5yFsCiL0VdYXY
MKjGN2uBrXNbscUPwcRZiejpaO8r58AZYu+yxlth23OBzoyYW1F4TFQ4H5kBdt2g
37Bv25TKYxAq1MARWC1NWlTKg9RyLCopyNVXx0lkx/bgi9TbXbeCAlOgZbBt4LHV
Q5hgPEhSMrPuisvVpp2DtuUe++BZ2fIJSMt6nv6nOPj4kCxbrTM=
=uKy3
-----END PGP SIGNATURE-----
--=-=-=--

