Date: Wed, 15 Apr 2020 11:48:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200415094851.GE1431@...1296...>
References: <20200414185214.1863-1-juliusz@...2525...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yx93Kc6BzsIU1RZq"
Content-Disposition: inline
In-Reply-To: <20200414185214.1863-1-juliusz@...2525...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

--yx93Kc6BzsIU1RZq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as Arne said, this is much better.

On Tue, Apr 14, 2020 at 08:52:14PM +0200, Juliusz Sosinowicz wrote:
> This patch adds support for wolfSSL in OpenVPN. Support is added by using=
 wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged a=
nd instead the OpenSSL includes point to wolfSSL headers and OpenVPN is lin=
ked against the wolfSSL library.
[..]

There is one thing, though:

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

I do not like this very much.  It will, effectively, break win32 builds
with WolfSSL - and add yet another #ifdef to our .c files.

ENABLE_CRYPTOAPI is defined in syshead.h

#if defined(_WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPEN=
SSL)
#define ENABLE_CRYPTOAPI
#endif

... could you investigate whether it would be sufficient to just=20
conditionalize this on WolfSSL, like this?

#if defined(_WIN32) && defined(ENABLE_CRYPTO) && \
	defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL)
#define ENABLE_CRYPTOAPI
#endif

so you can have WolfSSL-linked binaries for Windows, just without
CryptoAPI support (as with mbedtls)...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yx93Kc6BzsIU1RZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeltiDAAoJEB2Cnv7KVigSAIQMAJ5KnQKs6gE5AnPxPc1TNF3d
6RtKdp9wfZ3b6ahJlk3MDEHDfvd+iEUQdb1cZ9H9vPkjbk7A0RPPzmF3Syk857Gs
3ZrKCbb0maHQi1YXIeN7SKmbvtNnE0LuOTwoD28R/EySSHnSkWLTLRLm3YhtXGNA
ffjc5dJ53uPIHEwSunkHH3prMG/vMxyhXnFTV7L3lafjTQ0c7CTXCdeaxlPQpj+U
L64vECXFny94NorD9l0ktnKzIdOHUHucVgqFhmhptwhiDxZteuTaU9KKUlhRv/nb
VhbWQgepxcIuUQNl4f4+Z9P9L0KvsZ44chDg5ffuglY+MASswOc9Bf9vsYNndDsz
TUMxa9Inlz+pLabrJsokpmqwkaAtNQs6uMErJxlW5T2tkLKSRqZmGvsGgArhFpUK
oAAZGvmaf2YCZJeuUYSvC8E7mzYAyEOi+PDHkDXPJw3phl33NiR/U0QDiVQ8XD4B
sTUiK7EszFCJeBA6ZNBfxbOCIEXp+H94JTTfHPMCIA==
=YXLN
-----END PGP SIGNATURE-----

--yx93Kc6BzsIU1RZq--

