References: <bbaef48a-56ea-106f-b68f-abe0d5a11fe6@...1227...>
 <1548164463-13366-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <93414030-de59-fc66-71f7-8184eb93783e@...1227...>
Date: Tue, 22 Jan 2019 14:45:50 +0100
MIME-Version: 1.0
In-Reply-To: <1548164463-13366-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8SratVrbT3BVOJd8qhGPLGlCWVgXT5Nui"
Subject: Re: [Openvpn-devel] [PATCH v2] crypto_openssl.c: fix
 heap-buffer-overflow found by AddressSanitizer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8SratVrbT3BVOJd8qhGPLGlCWVgXT5Nui
Content-Type: multipart/mixed; boundary="62ZAUNar9b5FYPOPB2lKgT2E65w35MKw8";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <93414030-de59-fc66-71f7-8184eb93783e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] crypto_openssl.c: fix
 heap-buffer-overflow found by AddressSanitizer
References: <bbaef48a-56ea-106f-b68f-abe0d5a11fe6@...1227...>
 <1548164463-13366-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1548164463-13366-1-git-send-email-lstipakov@...277...>

--62ZAUNar9b5FYPOPB2lKgT2E65w35MKw8
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.01.19 um 14:41 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> OpenSSL's version of crypto_pem_encode() uses PEM_write_bio()
> function to write PEM-encoded data to BIO object. That method doesn't
> add NUL termanator, unlike its mbedTLS counterpart mbedtls_pem_write_buff=
er().
>=20
> The code which uses PEM data treats it as a string, so missing NUL
> terminator makes sanitizer to compain.
>=20
> Fix by adding a NUL terminator.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v2: use a dedivcated function to add a nul terminator
                 ^^^ :)

Acked-By: Arne Schwabe

Arne


--62ZAUNar9b5FYPOPB2lKgT2E65w35MKw8--

--8SratVrbT3BVOJd8qhGPLGlCWVgXT5Nui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHHo8ACgkQFRhsZwKx
RFS63Q/+N+4en0/WRnLAbjjkkvvnQaZljdvaeS5zZn2t7HPCj8cPMQWKCFlg01Y1
AUQiAu9cK+CBilb2MxT0216E4VXDDFB5SNhJ8msdCHVg1wa2609PSa160wi1hCt8
59F+JzJps3y+RWgJwYkC+AlvCOW4N4Gd6QDkrQTlIY/JOBxiBsECAdG2h1an4Aqp
QtRgDegAGie84TUkIWK02gvzqGv09MrMthoDqKiydRIJMUlczdFmJRrD6bNceEyX
S/Q5Lp8K11zQtfR5cCXcoqe7wuhLC7hlV46jAid2M587RlbJTgmK2K2FC8ZlGIx8
ptzJ1Qr+j31sWOC8Pbq+mfTQ+l1sye71wA6CneaVXxwrMh5EGwDK6YzprVGsys/9
s8XwB+nIB/pEgA4Go9las9xmLE730WZH3gzRHrvMj8QLgnPuxkTrDL0s0pN4VIv9
fQql2UYEHvGmn8BcnojlsLmUGpVRc9YjbtU3sZAWmwdVoY1h4kIbiYWskt1g2IP+
H0JfkCXMd2TsjBQttUYiHDteIjypxLwCR6rUh7xYswYJb0uukEmOOKd5Hg0bjHIZ
YBQxYiPrJ6F0mQKpoIqtSjOYA14aADwwnLOJQcpoG6Ow3GDoRkeFV9puEqkR7DZH
7HP0YbbIXdlXrs4ab9n8iE+xCcE3MeA+X41MNOI3ysPZ3+aK3VI=
=putO
-----END PGP SIGNATURE-----

--8SratVrbT3BVOJd8qhGPLGlCWVgXT5Nui--

