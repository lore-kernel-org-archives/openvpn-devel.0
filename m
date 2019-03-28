References: <20190327215626.23502-1-rosenp@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6acbad2c-9f73-3db8-c9e7-69a10c3de4cc@...1227...>
Date: Thu, 28 Mar 2019 09:45:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190327215626.23502-1-rosenp@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ITYcpunT1Eknw4Feui9gp6rybpLO9rK83"
Subject: Re: [Openvpn-devel] [PATCH] openssl: Replace not[Before/After]
 functions with get0 variants
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITYcpunT1Eknw4Feui9gp6rybpLO9rK83
Content-Type: multipart/mixed; boundary="TVVoezMZs5DpGLzr4ZIfz8oSLZYyWNKHI";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6acbad2c-9f73-3db8-c9e7-69a10c3de4cc@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: Replace not[Before/After]
 functions with get0 variants
References: <20190327215626.23502-1-rosenp@...277...>
In-Reply-To: <20190327215626.23502-1-rosenp@...277...>

--TVVoezMZs5DpGLzr4ZIfz8oSLZYyWNKHI
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> diff --git a/configure.ac b/configure.ac
> index dfb268ca..2617f344 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -922,6 +922,8 @@ if test "${with_crypto_library}" =3D "openssl"; then
>  			SSL_CTX_get_default_passwd_cb \
>  			SSL_CTX_get_default_passwd_cb_userdata \
>  			SSL_CTX_set_security_level \
> +			X509_get0_notBefore \
> +			X509_get0_notAfter \
>  			X509_get0_pubkey \
>  			X509_STORE_get0_objects \
>  			X509_OBJECT_free \
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index a4072b9a..788843a2 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -89,6 +89,14 @@ EVP_MD_CTX_new(void)
>  }
>  #endif
>=20=20
> +#if !defined(HAVE_X509_GET0_NOTBEFORE)
> +#define X509_get0_notBefore X509_get_notBefore
> +#endif
> +
> +#if !defined(HAVE_X509_GET0_NOTAFTER)
> +#define X509_get0_notAfter X509_get_notAfter
> +#endif
> +


This is fine.


>  #if !defined(HAVE_HMAC_CTX_RESET)
>  /**
>   * Reset a HMAC context
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 8bcebac4..e41cafa5 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -76,12 +76,13 @@ int mydata_index; /* GLOBAL */
>  void
>  tls_init_lib(void)
>  {
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_N=
UMBER))
>      SSL_library_init();
> -#ifndef ENABLE_SMALL
> +# ifndef ENABLE_SMALL
>      SSL_load_error_strings();
> -#endif
> +# endif
>      OpenSSL_add_all_algorithms();
> -
> +#endif


Please add a comment like
/* On OpenSSL 1.1.0 or above, then the library will initialize itself
automatically. */
Otherwise people will be very confused why this code is that way.


>      mydata_index =3D SSL_get_ex_new_index(0, "struct session *", NULL, N=
ULL, NULL);
>      ASSERT(mydata_index >=3D 0);
>  }
> @@ -89,9 +90,11 @@ tls_init_lib(void)
>  void
>  tls_free_lib(void)
>  {
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_N=
UMBER))
>      EVP_cleanup();
> -#ifndef ENABLE_SMALL
> +# ifndef ENABLE_SMALL
>      ERR_free_strings();
> +# endif
>  #endif
>  }

Same as above.

>=20=20
> @@ -541,7 +544,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ct=
x)
>          goto cleanup; /* Nothing to check if there is no certificate */
>      }
>=20=20
> -    ret =3D X509_cmp_time(X509_get_notBefore(cert), NULL);
> +    ret =3D X509_cmp_time(X509_get0_notBefore(cert), NULL);
>      if (ret =3D=3D 0)
>      {
>          msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore field=
.");
> @@ -551,7 +554,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ct=
x)
>          msg(M_WARN, "WARNING: Your certificate is not yet valid!");
>      }
>=20=20
> -    ret =3D X509_cmp_time(X509_get_notAfter(cert), NULL);
> +    ret =3D X509_cmp_time(X509_get0_notAfter(cert), NULL);
>      if (ret =3D=3D 0)
>      {
>          msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.=
");
> @@ -634,10 +637,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, =
const char *curve_name
>      else
>      {
>  #if OPENSSL_VERSION_NUMBER >=3D 0x10002000L
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_N=
UMBER))
> +
>          /* OpenSSL 1.0.2 and newer can automatically handle ECDH paramet=
er
>           * loading */
>          SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
>          return;
> +#endif
>  #else
>          /* For older OpenSSL we have to extract the curve from key on ou=
r own */
>          EC_KEY *eckey =3D NULL;
>=20


In general it be better split this patch into two: renaming the get/set
methods and removing the initialisation from OpenSSL >=3D1.1.0

Arne


--TVVoezMZs5DpGLzr4ZIfz8oSLZYyWNKHI--

--ITYcpunT1Eknw4Feui9gp6rybpLO9rK83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlycibwACgkQFRhsZwKx
RFQwsg/3djWRQDyE7XiRvhugAY9Cqpxj68OqKVrkII4dN+bO63IkUnG+zFXGvhsH
u0xE3IaQIilPz5mDagG+by5nPT4HerydOGUzAjS8iPII+CvYQaj02BMV9YdUKX+S
dUa4XqXx/Dnnirnt3JXpnGj5wnEiNVE7h9h0WyoTM7WLgEna+iMTDsiER5/kHz2j
4C0VWKPFO0bz2hRuFDH6+JylzeY0EcJuOY/3rcJAy7rx/H1jI1oZBQeWIwGUH9BM
n1AnBDQklh95XUTittPnQvsaAk9RjIWodtu8P/79pq1lylrxZYCR5Cljtc3DsUki
9rclhMRwnnhy1tDlWQlqv32SPOvtIkVgLMMD4a1Jt3w5yu0XJNVv/SPzF9lmFHwO
DMhxvXt/pqn5vEY960LqcxhPyvWObKzpj4589TSESPrXEWiJbgBLuoZIfoaWVlDX
ICVZE26DWd4uOWcMLEXl+aqeJyc5B3/TZ8YcQNKNsXn/oBG1DM+HZm0CvxBMHV/8
WMEWjFyEoN4A37knY17qXVLNkLuR3mh2hiHGE3K6itUtuA8N0ljIzYlz0TtNBggC
kjX/3OhLscyV/ZTj0aDHfHohoTApxkpxpkdintzXNCKSHHLpps6u7sSaVK9neZQa
UzS4WM1g05msJ9HVBJPTPpuFFiIHQc0A0xUg3GnIvIJIURCKtA==
=bgL+
-----END PGP SIGNATURE-----

--ITYcpunT1Eknw4Feui9gp6rybpLO9rK83--

