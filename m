References: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
Date: Sat, 12 Aug 2017 12:36:22 +0800
MIME-Version: 1.0
In-Reply-To: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MUsKXFiJ9h6RmhwFB170wjvUhWB8bDEOb"
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: introduce tls_crypt_kt()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MUsKXFiJ9h6RmhwFB170wjvUhWB8bDEOb
Content-Type: multipart/mixed; boundary="xHopvbeddK0Tw5FuTosrXNXeqEWPm215g";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: introduce tls_crypt_kt()
References: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>

--xHopvbeddK0Tw5FuTosrXNXeqEWPm215g
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/07/17 22:33, Steffan Karger wrote:
> Reduces code duplication: less lines, same functionality.
>=20
> Because cipher_ctx_block_size() is a static function we now need to
> include tls_crypt.c from the tests, rather than tls_crypt.h.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/tls_crypt.c                   | 30 ++++++++++++++++++-------=
-----
>  tests/unit_tests/openvpn/Makefile.am      |  3 +--
>  tests/unit_tests/openvpn/test_tls_crypt.c | 18 ++----------------
>  3 files changed, 21 insertions(+), 30 deletions(-)
>=20
> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> index e13bb4e..c8d26c7 100644
> --- a/src/openvpn/tls_crypt.c
> +++ b/src/openvpn/tls_crypt.c
> @@ -35,19 +35,9 @@
>=20=20
>  #include "tls_crypt.h"
>=20=20
> -int
> -tls_crypt_buf_overhead(void)
> +static struct key_type
> +tls_crypt_kt(void)
>  {
> -    return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_S=
IZE;
> -}
> -
> -void
> -tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
> -                   const char *key_inline, bool tls_server)
> -{
> -    const int key_direction =3D tls_server ?
> -                              KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVER=
SE;
> -
>      struct key_type kt;
>      kt.cipher =3D cipher_kt_get("AES-256-CTR");
>      kt.digest =3D md_kt_get("SHA256");
> @@ -64,6 +54,22 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char =
*key_file,
>      kt.cipher_length =3D cipher_kt_key_size(kt.cipher);
>      kt.hmac_length =3D md_kt_size(kt.digest);
>=20=20
> +    return kt;
> +}
> +
> +int
> +tls_crypt_buf_overhead(void)
> +{
> +    return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_S=
IZE;
> +}
> +
> +void
> +tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
> +                   const char *key_inline, bool tls_server)
> +{
> +    const int key_direction =3D tls_server ?
> +                              KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVER=
SE;
> +    struct key_type kt =3D tls_crypt_kt();
>      crypto_read_openvpn_key(&kt, key, key_file, key_inline, key_directio=
n,
>                              "Control Channel Encryption", "tls-crypt");
>  }
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/open=
vpn/Makefile.am
> index 3bd382c..7b44f42 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -54,5 +54,4 @@ tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_=
msg.c \
>  	$(openvpn_srcdir)/crypto_openssl.c \
>  	$(openvpn_srcdir)/otime.c \
>  	$(openvpn_srcdir)/packet_id.c \
> -	$(openvpn_srcdir)/platform.c \
> -	$(openvpn_srcdir)/tls_crypt.c
> +	$(openvpn_srcdir)/platform.c
> diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests=
/openvpn/test_tls_crypt.c
> index 9b82035..0a58a7d 100644
> --- a/tests/unit_tests/openvpn/test_tls_crypt.c
> +++ b/tests/unit_tests/openvpn/test_tls_crypt.c
> @@ -39,7 +39,7 @@
>  #include <setjmp.h>
>  #include <cmocka.h>
>=20=20
> -#include "tls_crypt.h"
> +#include "tls_crypt.c"
>=20=20
>  #include "mock_msg.h"
>=20=20
> @@ -60,23 +60,9 @@ setup(void **state) {
>      struct test_context *ctx =3D calloc(1, sizeof(*ctx));
>      *state =3D ctx;
>=20=20
> -    ctx->kt.cipher =3D cipher_kt_get("AES-256-CTR");
> -    ctx->kt.digest =3D md_kt_get("SHA256");
> -    if (!ctx->kt.cipher)
> -    {
> -        printf("No AES-256-CTR support, skipping test.\n");
> -        return 0;
> -    }
> -    if (!ctx->kt.digest)
> -    {
> -        printf("No HMAC-SHA256 support, skipping test.\n");
> -        return 0;
> -    }
> -    ctx->kt.cipher_length =3D cipher_kt_key_size(ctx->kt.cipher);
> -    ctx->kt.hmac_length =3D md_kt_size(ctx->kt.digest);
> -
>      struct key key =3D { 0 };
>=20=20
> +    ctx->kt =3D tls_crypt_kt();

Now we don't have the NULL checks on ctx->kt.digest and ctx->kt.cipher
anymore.
I understand this there is no variable involved as we statically search
for "AES-256-CTR" and "SHA256", however, shouldn't we at least assert
for them being not NULL ? Somebody may mess up the main code and the
unitest should properly detect the wrong condition instead of segfaulting.

>      init_key_ctx(&ctx->co.key_ctx_bi.encrypt, &key, &ctx->kt, true, "TES=
T");
>      init_key_ctx(&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TE=
ST");
>=20=20
>=20

the rest looks good!

Cheers,

--=20
Antonio Quartulli


--xHopvbeddK0Tw5FuTosrXNXeqEWPm215g--

--MUsKXFiJ9h6RmhwFB170wjvUhWB8bDEOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmOhcYACgkQ0+HICM1s
oFBZFw//YgVqaDzgjy467fzgas54r0xaGye7nSiajkgLy1bbX3W+F8esXeJTSAQ4
xms1qdX9YUjevfUN9aGuGygLJpJrBs8BBfH6RvLveJZ+yWXDhEI9S9AF0Wk6+TpN
0LPigZ1uwHrA/MeP2XTxmFYx973AVXmYnnjAFedKnKhyFIkA4gaaEJbpqVKuGgDF
XZqbilO4c8UtNOGMvdNGhttg2zt8FaAYrZwsa9LVeTKlJa911PV0/cEGXzxHxrL0
eoUdEf5aWqA064qmxgXp1TVr52PkBDyOYprj48s2Rar2exzAJ69D749cWdChGzaO
hAy9H3WVtSxnLgyA6ZW/1jUHI30Rhb7AQoWrGaumlwKgTpkUAKIcWL0TQLG7hsqB
1peCtZfXVonWlxL6NM8OIOq62uKLluC0Z+gLUzAqt48JQvfOnTQUKpy4yX5/cPz+
7ugdE2c4rndbGpe/j8n2SMiVjtcRXsWXaPu6OEb6G4l79et9VuXdazavpZePy4s0
NG7EujXJQ5DQ+clIuP2hLf5/AquDM+m954lBtWKRECYtaHrWgdLLo/IrRUNL26G3
eSlxUo/mSWu/tf/8wx+v4ZgO6ctTv2gz7kq6N7r0hwfQVbOQQStzi99PZ+c5/QC7
2K+VQCfTYZZ5qfgRUgIP89KB2SuLohGV2COXEJRFpqw80wpM2NU=
=CZF8
-----END PGP SIGNATURE-----

--MUsKXFiJ9h6RmhwFB170wjvUhWB8bDEOb--

