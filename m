References: <7fbf60b2-e417-5436-e1df-f6bc8ed57692@...1856...>
 <20171112103713.16486-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5f8d8043-5725-f535-e623-da042984196b@...2181...>
Date: Sun, 12 Nov 2017 22:15:48 +0800
MIME-Version: 1.0
In-Reply-To: <20171112103713.16486-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kBsdtdLMPnjEBxDALUCqfhUCAItK3HheF"
Subject: Re: [Openvpn-devel] [PATCH v5] Add --tls-cert-profile option for
 mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kBsdtdLMPnjEBxDALUCqfhUCAItK3HheF
Content-Type: multipart/mixed; boundary="pEuqWAdeC7fqPe3nEXE420sTk4RtTSsDg";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5f8d8043-5725-f535-e623-da042984196b@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5] Add --tls-cert-profile option for
 mbedtls builds
References: <7fbf60b2-e417-5436-e1df-f6bc8ed57692@...1856...>
 <20171112103713.16486-1-steffan@...1856...>
In-Reply-To: <20171112103713.16486-1-steffan@...1856...>

--pEuqWAdeC7fqPe3nEXE420sTk4RtTSsDg
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/11/17 18:37, Steffan Karger wrote:
[CUT]

> +void
> +tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
> +{
> +    /* OpenSSL does not have certificate profiles, but a complex set of
> +     * callbacks that we could try to implement to achieve something sim=
ilar.
> +     * For now, use OpenSSL's security levels to achieve similar (but no=
t equal)
> +     * behaviour. */
> +    if (0 =3D=3D strcmp(profile, "preferred"))
> +    {
> +        SSL_CTX_set_security_level(ctx->ctx, 2);


unfortunately this function does not exist in OpenSSL 1.0.x and openvpn
does not compile.

However, we don't need anything equivalent for openssl-1.0.x because the
legacy profile is implicitly supported there.


Cheers,


--=20
Antonio Quartulli


--pEuqWAdeC7fqPe3nEXE420sTk4RtTSsDg--

--kBsdtdLMPnjEBxDALUCqfhUCAItK3HheF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloIV5UACgkQB6U8WA7y
zXSOEBAAr1YUaTDaVHJ2nKfoRYR0BuaYvNNtgxKO3IJP23hb/pyN41/flWhlJ77J
xB3Ja80+u+lAUko4LGuGwo15RpTsyYt9fxkzsGqap8zRFKKhXrA3bMFd4sunON1p
/MoR4dHhbKLRJ1yzEcvdE4ouMLMMaxSwnbdQgxz4UQ4VurGzfJh4KcmkHkqVJ7zx
oyNUGbTgDPdc3f7gRJ/5sH96u5febzCmLUsLMyVPOPNGIghV/+EuxzSp50ODR174
clNkYwe57Nc3x4DcQwu1+m90eXBRZlPVJDxh9F0pTG7KyLcbFlIlxbn38znmeh/7
j52nEFCuuf7dbcUxRzY7VGie5KUTpnMUbae/V455z2aPQFd8HpOytoxryX9hnCT+
oofznQIKNNAsrEBxj3k4GtwSpbSVTo1i/wGqbG4leNG0yqwOvLObQ9wn6oDXoyRd
2DMG4oOIVIzUJgAW6AZXU6Zpub7G0fP9Zrya/YOyyUVmNq6o8qS3NgPcZHPdYFCD
ucBVHlkboUAGCAPO9420EqBq9pVojU++fE3WQn6rUjoIgwHog/bA3E5a26uYlprG
SLFKSnZCu10WVrl8dmYnFnziF8bN83Qa8p1jYnpjtsHkDc5FiWvmm5kiZJbudwz3
5jTTDIsRPG+pczz/13oJ6u2wI4+9XX3taL1f8OtneI19RjRBe6Y=
=ebyK
-----END PGP SIGNATURE-----

--kBsdtdLMPnjEBxDALUCqfhUCAItK3HheF--

