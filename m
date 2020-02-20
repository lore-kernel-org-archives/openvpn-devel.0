From: Arne Schwabe <arne@...1227...>
References: <20200220083825.29131-1-arne@...1227...>
Message-ID: <261cca13-ca61-0fa7-7c37-f000f3d6d444@...1227...>
Date: Thu, 20 Feb 2020 09:42:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200220083825.29131-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vQ0OHIMi5tZ0lSGJH4CUc1aAwIoFKvqiR"
Subject: Re: [Openvpn-devel] [PATCH] Fix float comparisons of
 OPENVPN_VERSION_NUMBER
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vQ0OHIMi5tZ0lSGJH4CUc1aAwIoFKvqiR
Content-Type: multipart/mixed; boundary="nxM8PDdoOHoqjoxHD7IwtS2iW1Ipjr0gN"

--nxM8PDdoOHoqjoxHD7IwtS2iW1Ipjr0gN
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.02.20 um 09:38 schrieb Arne Schwabe:
> These checks are probably the result of copying a
> check from the LibreSSL and modifying it to be
> a OpenSSL check. For some arcane reason LibreSSL decided
> that its version number should be a long float (double) rather
> than an integer.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl_openssl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 21651a3e..bcdfb543 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -231,7 +231,7 @@ tls_version_max(void)
>       * We only need to check this for OpenSSL versions that can be
>       * upgraded to 1.1.1 without recompile (>=3D 1.1.0)
>       */
> -    if (OpenSSL_version_num() >=3D 0x1010100fL)
> +    if (OpenSSL_version_num() >=3D 0x1010100L)
>      {
>          return TLS_VER_1_3;
>      }
> @@ -2104,7 +2104,7 @@ show_available_tls_ciphers_list(const char *cipher_=
list,
>          crypto_msg(M_FATAL, "Cannot create SSL object");
>      }
>=20=20
> -#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)    \
> +#if (OPENSSL_VERSION_NUMBER < 0x1010000L)    \
>      || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <=3D=
 0x2090000fL)
>      STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);
>  #else
> @@ -2134,7 +2134,7 @@ show_available_tls_ciphers_list(const char *cipher_=
list,
>              printf("%s\n", pair->iana_name);
>          }
>      }
> -#if (OPENSSL_VERSION_NUMBER >=3D 0x1010000fL)
> +#if (OPENSSL_VERSION_NUMBER >=3D 0x1010000L)
>      sk_SSL_CIPHER_free(sk);
>  #endif
>      SSL_free(ssl);
>=20


Ignore that patch. I am not awake yet. the fL is not a suffix. LibreSSL
has has its patch version to be 0f.

Arne


--nxM8PDdoOHoqjoxHD7IwtS2iW1Ipjr0gN--

--vQ0OHIMi5tZ0lSGJH4CUc1aAwIoFKvqiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5ORpAACgkQFRhsZwKx
RFSAdg//ft+tQKZCXYzwPdYk22KgiK/CIn2Nrjyz7clsidq6dZf6qr291anWsMVJ
LvRk3OOaoeiuTPEMnHYD/aHGJVGVZxa2D0K+jTA0Qc0ilzSZm2LtvwawIkSwWVzc
xmg2+yh/oEACpXUkZSs21eehZuMcBsrNaA45Lq4cW4qbesCw1EIxKKF7DkI2ScZP
pjdNwhlYwU97i2urm7u2pwJMwL+mBNXr0zBs5cThQKn9xzj38Xy5UUCdAYHSzxRH
TWZZvYYoo1JTMS2vWpurLpLNWERLSxNQDdT/K1FdZPEjgjjniMQGySRQtqSCICDA
oz7XXR+Ro4jr6Z47vkBn8JaLgtHD9vocuZhv3G9hdvhWgQ4LI5vnNqE6GHjajKqW
VpWhTIQIa7GJRlTZ1C7T5yBjiQkvXZp8QrEpeCjTjpVrfvt48MVgdxXy5YUwhwT+
yxTHbyxS7DdcXxTrFgAbQUy4aw+w+Mmx7UjGf/Wu9pdsOuIemMSqZTlxzdIHKZNZ
HWDxFUpgucBb5Wy9jyUDqXq5lzmLE556p5dZKM34fokGcbK138nYJ4LYo9DqCi9C
3FmHRrizLdQozIcWEAmPflAVjOx0xmOpT7jDKsUKPNCoXytNUb4bNioP7YXP1CDf
sHEQBLj3J+aYiEKbTPjqy32pUCklg992rdRlA5MX5vMV6tTLHK4=
=W1BB
-----END PGP SIGNATURE-----

--vQ0OHIMi5tZ0lSGJH4CUc1aAwIoFKvqiR--

