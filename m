References: <20200414185214.1863-1-juliusz@...2525...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3f3962c3-7458-af60-f703-3ddad76d136c@...2080...>
Date: Wed, 15 Apr 2020 22:58:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200414185214.1863-1-juliusz@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9Qdvekzey5HW6bJIliFYVi4uyQstRX3GB"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
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
--9Qdvekzey5HW6bJIliFYVi4uyQstRX3GB
Content-Type: multipart/mixed; boundary="WyWmsO1rGm2auCHka3BOx8vvuPZFFzU6Q";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3f3962c3-7458-af60-f703-3ddad76d136c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
References: <20200414185214.1863-1-juliusz@...2525...>
In-Reply-To: <20200414185214.1863-1-juliusz@...2525...>

--WyWmsO1rGm2auCHka3BOx8vvuPZFFzU6Q
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/04/2020 20:52, Juliusz Sosinowicz wrote:
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 30eba7b2..a82c52ad 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -39,6 +39,10 @@
>=20=20
>  #ifdef ENABLE_CRYPTOAPI
>=20=20
> +#ifdef ENABLE_CRYPTO_WOLFSSL
> +#error wolfSSL does not support CryptoAPI
> +#endif
> +

Except of the documentation effect, wouldn't it be better to handle that in
syshead.h instead?

In syshead.h, I see this:
----------------------------------
#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)
#define ENABLE_CRYPTOAPI
#endif
----------------------------------

This is the only place I could find defining this macro.  So extending it w=
ith
&& !defined(ENABLE_CRYPTO_WOLFSSL) would eliminate the need to worry about =
the
ENABLE_CRYPTOAPI elsewhere.

Has this patch been tested against Windows builds with WolfSSL enabled, like
via mingw?


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--WyWmsO1rGm2auCHka3BOx8vvuPZFFzU6Q--

--9Qdvekzey5HW6bJIliFYVi4uyQstRX3GB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJel3VtAAoJEIbPlEyWcf3ylkgP/RIJNm0C/M3HGeWQ75RP2Spb
vJoCN1D2jzXM/miSMoxx76kyRZJLJYT4d6GgRwJyDh2GwD8AL0GDfLyzlLNtoGxF
R7Zn/2BbJAUnG9RPaVcZN1sWCGX1Jo8Oal59UWYTjjRG78GolNWUE5lU9oj5jqX4
3eRhMqF5c33xdNhcgJAX3Vf3qr1wx7/3rUfLfu3WiPTnNU6uMxQkkPB214+TociU
j8sAwMrbnW/cTdS0d6wl+UdcQuVl6rWfzYKeQdoQZK66QpreGXYzjMPjPywCekmB
XCoMNcsbKTMRkI7vDX6SP2GIx4MxXni0xDfrIQJb346ZNjA6d9Iej6un2hqCeKiX
2TKfJ6PR++p1wXaCOVjiOobfVp8ILQcoNWXc5L7q8wZ8hl+lNolSRxV9N5EO6HfW
D+SvPDIrOa5t4PGyjgAqD6tELtzCjP91+lJhm7O1bUMyNKnGW/q48hiFuiKZWlmw
0Ry40m1hF7IT1STGkz5Zbf4pfUFyJVOCglKiT5zr8VTe1vlf/91SiJa7smf/6djo
ttACU55OfG2EUBS3s0vkzQSpkhNKu1G5kD4pLYEmNUdoJ0N14u8l6BfBnej6Fnpq
LJrVe1H5QyhU8sgIDeFYfLWExWP03xF2JPyMH0pGqE6itRltKELG/g7l24GRZLYb
v+BV8pmSWR5lvLcs8qPe
=fJtx
-----END PGP SIGNATURE-----

--9Qdvekzey5HW6bJIliFYVi4uyQstRX3GB--

