References: <20190223180241.18374-1-stefan.strogin@...277...>
 <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
 <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8ad35f89-7e2a-f780-d0a9-efabc85ad97f@...1227...>
Date: Mon, 25 Feb 2019 12:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uHQKZfXgCxciaxuwADh67K4v7afJy7IAQ"
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Stefan Strogin <stefan.strogin@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uHQKZfXgCxciaxuwADh67K4v7afJy7IAQ
Content-Type: multipart/mixed; boundary="ojWoDhXg8Qz9txPkr9O242aKORH4LB1Jz";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Stefan Strogin <stefan.strogin@...277...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8ad35f89-7e2a-f780-d0a9-efabc85ad97f@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
References: <20190223180241.18374-1-stefan.strogin@...277...>
 <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
 <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>
In-Reply-To: <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>

--ojWoDhXg8Qz9txPkr9O242aKORH4LB1Jz
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.02.19 um 07:29 schrieb Stefan Strogin:
> Hi Arne,
>=20
> Thanks for the reply. Please see my comments and a clarifying question be=
low.
>=20
> On 24/02/2019 03:28, Arne Schwabe wrote:
>> And I
>> am getting quite fed up with way that LibreSSL does API compatiblity. It
>> claims to support OpenSSL 2.0.0 API when it clearly doesn't.
>=20
> Sorry, but LibreSSL officially claims only compatibility with OpenSSL 1.0=
.1:
> https://github.com/libressl-portable/portable
> However, practically most of OpenSSL 1.1 API is supported by LibreSSL.

I am speaking about the value of OPENSSL_VERSION_NUMBER and iirc that
one is set to something that equals OpenSSL 2.0.0.

Which is the main cause of these problems that we run into.


> AFAIK in theory OpenSSL >=3D1.1.1 can be built without TLS 1.3 support, u=
nlikely
> in practice though.
> Which ifdef will you prefer?



Hm, both have advantages. But if we can fix the rare corner case of
OpenSSL 1.1.1 without TLS_13 then lets go for the TLS1_3_VERSION variant.

>=20
> Regarding SSL_get1_supported_ciphers. [Based upon current LibreSSL releas=
e schedule
> (2.9.x is a current development branch which will be part of OpenBSD 6.5)=
 and that
> this method was added soon after 2.9.0 release], I think it will be corre=
ct:
> #if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || \
>     (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x2090=
100fL)


Are there really Libressl versions that do not define
LIBRESSL_VERSION_NUMBER that are worth supporting? Otherwise I would
prefer to have only the LIBRESSL_VERSION_NUMBER < 0x2090100fL or
inverted and >,. Need to double check what is true for undefined things.

>=20
> I also see other 'defined(LIBRESSL_VERSION_NUMBER)' ifdefs that don't spe=
cify
> exact LibreSSL version number. I agree that it is not correct, and it is =
not nice
> to force deprecated functions on users of newer LibreSSL, when newer API =
is
> available. So if you don't mind I'll try to fix them as well in a follow-=
up patch.

That would be good improvement indeed.

Arne


--ojWoDhXg8Qz9txPkr9O242aKORH4LB1Jz--

--uHQKZfXgCxciaxuwADh67K4v7afJy7IAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxzzSQACgkQFRhsZwKx
RFRqWhAAr7U9dBEYcP9bX5EqTkJYsQ0HWfScp3RWflHIlCuClFPDCAv9yAgU3aGH
pPqykfrBfkwGeuEHW3t9fuQ04ugjF9XTkamFmkSLi2INjw+X3LdPD75UhwXX3GfB
Sg2uY6HB3BJC4FJqun49WLS76g1nBXZ1/Q2UlC1zJ5ZqpNOVNTn5dgvMc55gNrVG
kzJ+LtJxcyS/4b5SEAY08Z9+tFPKvykiYCAqYl9WoxKRP5cWEGVb4y7Znv2ziByh
+4Et6lxJo2k3tgyPoudDgk4tZwZV0950baDDND/4HbjaDOkvZWnEPrcsQ0ccc5Ez
0EneaQFDLWk4m0lP2at5eW9ZUJFST9EOr9SKEdfuCWuB7nH65o12OoGNdER5uZjn
LwWee1Fh3MG4GWgExNauDQhnna8oHt5wQTMweLGbdMG/dMWjskelP8+G+Eiz6NyA
Y+Seu4eLoOQD3HTsfz0IpRo/F3akSZsTVVNhQcdmSQH1OYDYhvALFJ8sTkSkaQTp
aMkc/9pqruqDgrk3L93jc3g++107GS9RjokVjgOPD55l1Ys2PLZ0IXEHdxwAf71T
zjEQPJWKADy5yRVQWbXB5q8KSB100tl9FaDRtplZGR5zIiS5s/hysfBRhXSxlqCL
LIJgOXMf9ZKj06AsAZqGOZRcYqPy5Flon5N26Kx6zZZMp46bYNY=
=Xlr3
-----END PGP SIGNATURE-----

--uHQKZfXgCxciaxuwADh67K4v7afJy7IAQ--

