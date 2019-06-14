References: <20190403225657.8003-1-rosenp@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
Date: Fri, 14 Jun 2019 12:38:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190403225657.8003-1-rosenp@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G3YTlc4I8EIWOCLETagfJdRzxX8CRx396"
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
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
--G3YTlc4I8EIWOCLETagfJdRzxX8CRx396
Content-Type: multipart/mixed; boundary="iaOpYLmr8y2aWm2ANp0f7PYvAsZ9gLEEv";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
References: <20190403225657.8003-1-rosenp@...277...>
In-Reply-To: <20190403225657.8003-1-rosenp@...277...>

--iaOpYLmr8y2aWm2ANp0f7PYvAsZ9gLEEv
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 04.04.19 um 00:56 schrieb Rosen Penev:
> EVP_CIPHER_CTX_init and _cleanup were deprecated in 1.1 and both were
> replaced with _reset.
>=20
> Also removed initialization with OpenSSL 1.1 as it is no longer needed and
> causes compilation errors when disabling deprecated APIs.
>=20
> Same with SSL_CTX_set_ecdh_auto as it got removed.
>=20

This gets kind of an ACK but needs some additional changes to be really
good.


>=20=20
> +#if !defined(HAVE_EVP_CIPHER_CTX_INIT)
> +#define EVP_CIPHER_CTX_init EVP_CIPHER_CTX_reset
> +#endif
> +
> +#if !defined(HAVE_EVP_CIPHER_CTX_CLEANUP)
> +#define EVP_CIPHER_CTX_cleanup EVP_CIPHER_CTX_reset
> +#endif

These two keep the older API instead of switching to the new one, from
OpenSSL.

# if OPENSSL_API_COMPAT < 0x10100000L
#  define EVP_CIPHER_CTX_init(c)      EVP_CIPHER_CTX_reset(c)
#  define EVP_CIPHER_CTX_cleanup(c)   EVP_CIPHER_CTX_reset(c)
# endif

Since just using only the new API in this case does not really work I
think in case it would be better to rather always use
EVP_CIPHER_CTX_reset isntead of init and  have ifdefs in the 2-3 places
where we actually use EVP_CIPHER_CTX_cleanup so we can remove the old
API when we bump our minimum OpenSSL version (and find this thing easy
since it is an ifdef depending on the openssl version).

> +
> +#if !defined(HAVE_X509_GET0_NOTBEFORE)
> +#define X509_get0_notBefore X509_get_notBefore
> +#endif
> +
> +#if !defined(HAVE_X509_GET0_NOTAFTER)
> +#define X509_get0_notAfter X509_get_notAfter
> +#endif
> +
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

The space between # and ifndef looks wrong.


Arne


--iaOpYLmr8y2aWm2ANp0f7PYvAsZ9gLEEv--

--G3YTlc4I8EIWOCLETagfJdRzxX8CRx396
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl0DeQgACgkQFRhsZwKx
RFTcWg/9H5iNqgKMaGBLIFikvujKxML51CqmzCHbUjiJuwjv9bw7VKbgvsfev3rB
MPkpfD4Bxiqwuyi8IOQ3JE4HjI20W3h0+x5AgNeYXpQ1Miyxpq3JOBqI6WtDi1Mn
HK5Ch8m7qhrXA3RB2W1baeznsXGXAVl0i99PyHRixaEjv3+sv9AT/KNtDn/bZM6Z
wcIYa4JmEkoyQH2HsW6kcraWSU11Vv6Ajz444+qWKPvBiuPNH5tYtXA4l3ly4hAY
lfF+D9LdY1UhA+711Qvv0JGdXzqpNeQaDUDdcaVdavBhQ0tETvaKOkN/jDTOGXoY
aGz3UcP3r6kJMArJ8Q4p8jnQa46c3y4AYVCEkcLh8jghooPh1Uog90puoE411EEc
g1X1L5xV4R7Os3vomfiZj3ApaLHA6odX85neD80EX3P/0TPQyAX/YIAWrpLjcbOi
7EKs/Gar1rNhDWC2isOaUW1S39ywYWnhfflIFjxY4R2cLhqAbqX6U3BC6GC3RZVj
44+iVO6+jGiJBVAVJSsn9+m9vBo4juMQveBqk/3c2xGE/JFPNzShcbnptSpviDtd
k+n2ayZlxaDnkqQa3qUZAt9lgpJIHeGkRWq7xu8yTiM8ECxtYO2V46fY2q3/iYUv
6wHDX1FFAgiDYh5FDCgGOrouMRurU43sd5mAetVcyGucbX5edKQ=
=cKJk
-----END PGP SIGNATURE-----

--G3YTlc4I8EIWOCLETagfJdRzxX8CRx396--

