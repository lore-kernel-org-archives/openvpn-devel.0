References: <1548154968-13019-1-git-send-email-lstipakov@...277...>
 <1548154968-13019-2-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e5ec298b-cd2e-ee95-955e-56df133e0ef8@...1227...>
Date: Tue, 22 Jan 2019 13:36:07 +0100
MIME-Version: 1.0
In-Reply-To: <1548154968-13019-2-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0ucpRX9mGhHqn8UFukedmXfChjPitnF87"
Subject: Re: [Openvpn-devel] [PATCH 2/2] test_tls_crypt.c: fix
 global-buffer-overflow found by AddressSanitizer
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
--0ucpRX9mGhHqn8UFukedmXfChjPitnF87
Content-Type: multipart/mixed; boundary="lZlCFTOpKza0AtjlOdlnK53vOs8Qq6aM5";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <e5ec298b-cd2e-ee95-955e-56df133e0ef8@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] test_tls_crypt.c: fix
 global-buffer-overflow found by AddressSanitizer
References: <1548154968-13019-1-git-send-email-lstipakov@...277...>
 <1548154968-13019-2-git-send-email-lstipakov@...277...>
In-Reply-To: <1548154968-13019-2-git-send-email-lstipakov@...277...>

--lZlCFTOpKza0AtjlOdlnK53vOs8Qq6aM5
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.01.19 um 12:02 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> When writing data to buffer we incorrectly specify source length
>  - sizeof for pointer returns 8, but actual buffer length is 1.
>=20
> Fix by replacing empty global string to local string literal and
> specifying the correct length.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  tests/unit_tests/openvpn/test_tls_crypt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests=
/openvpn/test_tls_crypt.c
> index b793a7a..b4ce03d 100644
> --- a/tests/unit_tests/openvpn/test_tls_crypt.c
> +++ b/tests/unit_tests/openvpn/test_tls_crypt.c
> @@ -49,8 +49,6 @@
>  #define PARAM1      "param1"
>  #define PARAM2      "param two"
>=20=20
> -static const char *plaintext_short =3D "";
> -
>  static const char *test_server_key =3D \
>          "-----BEGIN OpenVPN tls-crypt-v2 server key-----\n"
>          "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4=
v\n"
> @@ -148,7 +146,7 @@ test_tls_crypt_setup(void **state) {
>      ctx->unwrapped =3D alloc_buf(TESTBUF_SIZE);
>=20=20
>      /* Write test plaintext */
> -    buf_write(&ctx->source, plaintext_short, sizeof(plaintext_short));
> +    buf_write(&ctx->source, "1234567890", 10);
>=20=20
>      /* Write dummy opcode and session id */
>      buf_write(&ctx->ciphertext, "012345678", 1 + 8);
>=20

I would suggest plaintext_short=3D"12345678"; and then use
strlen(plaintext_short)+1 in the buf_write.

But I can confirm that this indeed fixes the issue it should fix.

Arne


--lZlCFTOpKza0AtjlOdlnK53vOs8Qq6aM5--

--0ucpRX9mGhHqn8UFukedmXfChjPitnF87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHDkkACgkQFRhsZwKx
RFT/4BAApz4zyKrUEnFVCAQyADjiZMEp6X2nwcN/EEQcq23NYWfaQ9cB7hkfXBj1
e3ciby+wOitvY/BogXuykMTqqkN69jD2EGt2O/pQ3A1hhWolDcGTi21Z2dmAu1Qp
gLk0ZwVGrNlgLFnCQ7+dDI7Bjq35rDJ8ysxyQeEP8Hk8kvtRt/F1JA5cobHLB9Y6
L7PFhaTxfKZE54fjbYNvVG3uk7LSNSbCtBvBayNp3FHOVIDaprfqEU9ooUrzdXZX
gYI5jzOA99A2Rc02b8KzlyOttmqbOcRUlQjj2qbF04zkGGqqY9S1mU4XD4nKqP9i
hzl0hGH3ZcT3uM/75C3Zwf1zrXZNd8VGjPc1XJy4fXp0jt81uiEEx4RW4O2gYojk
7fsvh0kPO9wO9mOIuMhMGEaD18IwMOpe1cWOVsQ6KhHRVYMDZlWlC1NWgmPz9XgE
qrVBKENJhL2eD6NHjiA7pkNqbH0koN3rBaAwM3DU1M+kbH8DZziH7JXE+pXjEfaV
IOsHtsC2FEHX5j2kgAdNUq18uGd2dTDW+LaxUS1JxzRr4HNdpVFw1cZRaviNeozN
meknzOYslexD4wO8gUxhRZ4VXVgFtDrMEXHic3SKe83XG6CDYdf5P9GelBKeueqY
+4x5Gyj1tP1nY6v2a5czTZeLXTLpsUiwAeehSVpgECLQpfpIvxc=
=WA1s
-----END PGP SIGNATURE-----

--0ucpRX9mGhHqn8UFukedmXfChjPitnF87--

