References: <20190403225657.8003-1-rosenp@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <278719f4-68df-7a60-4245-0909a8a6b731@...1227...>
Date: Wed, 8 May 2019 16:14:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190403225657.8003-1-rosenp@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PJUGxrJZzU91xCAjGtXMNXfwl6ybhnc1a"
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
--PJUGxrJZzU91xCAjGtXMNXfwl6ybhnc1a
Content-Type: multipart/mixed; boundary="AhEWGycslK0UjiwNrAcFeqsQYBl3PY9aW";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <278719f4-68df-7a60-4245-0909a8a6b731@...1227...>
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
References: <20190403225657.8003-1-rosenp@...277...>
In-Reply-To: <20190403225657.8003-1-rosenp@...277...>

--AhEWGycslK0UjiwNrAcFeqsQYBl3PY9aW
Content-Language: de-DE
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

> +#if !defined(HAVE_EVP_CIPHER_CTX_INIT)
> +#define EVP_CIPHER_CTX_init EVP_CIPHER_CTX_reset
> +#endif
> +
> +#if !defined(HAVE_EVP_CIPHER_CTX_CLEANUP)
> +#define EVP_CIPHER_CTX_cleanup EVP_CIPHER_CTX_reset
> +#endif
> +

Generally we tried to avoid things like implementing the old API with
the new API but instead try to only use the current OpenSSL API and
implement it using the older API on older OpenSSL version. Is there way
for these functions to do that as well?

Arne


--AhEWGycslK0UjiwNrAcFeqsQYBl3PY9aW--

--PJUGxrJZzU91xCAjGtXMNXfwl6ybhnc1a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzS5C0ACgkQFRhsZwKx
RFQwiw/9FdolBXz8/rditWi3ng07ZDJXxrN0+pQ5uh7JCwzXXeIQxdDmyocSbMXj
K+iaX1fdJbB/RH5OeQA5MebnzGwAG9wkGtxEMM0CqkgKA9E+Pz+WXQkiOZcCdILa
dTHSQlSwXcJwH9PbYPpsAtTAlYHoixNKroXXdF6Igec+CXRo387YNXAuBaesfiR2
ishRrLCzHbZZ33kjTclx0rjOHqZi9bDpSZ/sm8bSthgRVSXWMHPWq6GxqmzR/KKX
ZXf/+kSLNIp282dWqZLDHqPDt8ePeyK15/tInz0f8PA22q3LDeL8MUqqco6VjMxX
0oo3GOrcqlwc1uwUdalhT0A1lNUDbe1mxQjl14OGYaa+Ozq3Bjcqyq4i6vSiNC6c
5LpRJyzWolVVjlXAALiqMB4B3FG69vJQZE8MGhEZdFyS0JIXw3bKVXRMqc6gV9mb
/JGG6gYqeHfU5qQRz0NI54NlajthiUPnhPTsN+uj4EzNihrVZ0ROcfn7ddUunQBo
6WtaS3CgNKb5zAv4cKwljx/Pylg0X3N/qoLoryJ0ML/A5L/QCoFsJtTuYdTvYJNT
fHJWFor0G2C95IFL/iUrj7fXVIiX14S8e/M/VVSAgj8PC7rXHuOw64uOpVtgjb1W
J0+UNEzFu/JbiPoywc5nS/h1qytFzgdTdcTPbn3eaJTDoqnAUsQ=
=w4zV
-----END PGP SIGNATURE-----

--PJUGxrJZzU91xCAjGtXMNXfwl6ybhnc1a--

