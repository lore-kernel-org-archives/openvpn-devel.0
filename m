References: <1548154968-13019-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bbaef48a-56ea-106f-b68f-abe0d5a11fe6@...1227...>
Date: Tue, 22 Jan 2019 13:36:58 +0100
MIME-Version: 1.0
In-Reply-To: <1548154968-13019-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uVwHuZzPpXlcPPNhEZw8mJh9Kfi8sBte4"
Subject: Re: [Openvpn-devel] [PATCH 1/2] crypto_openssl.c: fix
 heap-buffer-overflow found by AddressSanitizer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uVwHuZzPpXlcPPNhEZw8mJh9Kfi8sBte4
Content-Type: multipart/mixed; boundary="sLyjTqzZc2bucDlVtyNfqAffcjyYMVxrb";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <bbaef48a-56ea-106f-b68f-abe0d5a11fe6@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] crypto_openssl.c: fix
 heap-buffer-overflow found by AddressSanitizer
References: <1548154968-13019-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1548154968-13019-1-git-send-email-lstipakov@...277...>

--sLyjTqzZc2bucDlVtyNfqAffcjyYMVxrb
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.01.19 um 12:02 schrieb Lev Stipakov:
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
>  src/openvpn/crypto_openssl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 9691ce0..6a49067 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -400,8 +400,9 @@ crypto_pem_encode(const char *name, struct buffer *ds=
t,
>      BUF_MEM *bptr;
>      BIO_get_mem_ptr(bio, &bptr);
>=20=20
> -    *dst =3D alloc_buf_gc(bptr->length, gc);
> +    *dst =3D alloc_buf_gc(bptr->length + 1, gc);
>      ASSERT(buf_write(dst, bptr->data, bptr->length));
> +    *BEND(dst) =3D '\0';

buf_null_terminate(dst) is a better function here :)

Otherwise ACK, fixes the problem.

Arne


--sLyjTqzZc2bucDlVtyNfqAffcjyYMVxrb--

--uVwHuZzPpXlcPPNhEZw8mJh9Kfi8sBte4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHDmoACgkQFRhsZwKx
RFQ5YhAAkS/3aiuOBvL3GTkr5UEWFMRxmElb29mxaelXe9bXxyWMoXF+MAfTTzmH
FPDWkuZ9U8U1ZC5QJQkY77kotXePh8ZgXmBLULDi+gWC1sBidjvdTOsS+tmBlrib
KygfpkPc21/uXeL+iqvOSn1xd7SiKQ5QBltUdwyvI7G9XtixMSZ8BhN5o9NrNSSQ
E3U+MRyHwYnPadYAZwXmidZBjecaItQe/tC7YO/jGtP2UQlEkotHOjmE/a6YxDL/
P/zK/p6nPY0So/U6zbkcPobYEc7hzAW2ev2sdlx0YD9Y8wcYwmWaFJ1/gyZGvpRz
mS5w2O3mLV2zlSg31zVSqqD7XloortXPvMz/aYdHg4CMkvp/+P+B3sOSjc9polWX
nANZ4c0uF8cYo/iHZ+Yluab+TyS59m1k55mZQadXWGhN27iSa2VBEYEs2cNePKuY
41GErgCcnoFbtJbcygG2lAe0LMpsPvdenkDc961oWUpVl4zhl+Ip5J55S2miPWjy
g+dK0COPYA2GGnib60BfuU9MCMZkb/UjhzgwAbJ8Ahy/Wmm2gR+v6Ue9+28hpQAF
pSgp8Ary3oIOFdP9gW/kBEZO5dP+5iiiz/HeorM5fF1mri/RlUhkB95uXNDOD9VH
IYWLgA7rY1HPsf6cDx6n00h2W/GLO7/x4eZxmEKxiSC3t2JVQ0k=
=BqMU
-----END PGP SIGNATURE-----

--uVwHuZzPpXlcPPNhEZw8mJh9Kfi8sBte4--

