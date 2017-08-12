References: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
 <1502531632-16833-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ce87a825-e626-c75a-0162-655bf3ff2606@...2181...>
Date: Sat, 12 Aug 2017 18:26:34 +0800
MIME-Version: 1.0
In-Reply-To: <1502531632-16833-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="diTQnolgmFkffenEEjBQJoLMr29skbodg"
Subject: Re: [Openvpn-devel] [PATCH v2] tls-crypt: introduce tls_crypt_kt()
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
--diTQnolgmFkffenEEjBQJoLMr29skbodg
Content-Type: multipart/mixed; boundary="8jG3JsMmUOS3nA47Tfr6CUl4Gf7bqrI8K";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ce87a825-e626-c75a-0162-655bf3ff2606@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] tls-crypt: introduce tls_crypt_kt()
References: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
 <1502531632-16833-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1502531632-16833-1-git-send-email-steffan.karger@...1435...>

--8jG3JsMmUOS3nA47Tfr6CUl4Gf7bqrI8K
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/08/17 17:53, Steffan Karger wrote:
> Reduces code duplication (and prepares for tls-crypt-v2, which needs the
> same functionality at more places).
>=20
> Because tls_crypt_kt() is a static function we now need to include
> tls_crypt.c from the tests, rather than tls_crypt.h.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: improve error handling
>=20
>  src/openvpn/tls_crypt.c                   | 40 ++++++++++++++++++++-----=
------
>  tests/unit_tests/openvpn/Makefile.am      |  3 +--
>  tests/unit_tests/openvpn/test_tls_crypt.c | 20 ++++------------
>  3 files changed, 32 insertions(+), 31 deletions(-)
>=20
> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> index e13bb4e..403060d 100644
> --- a/src/openvpn/tls_crypt.c
> +++ b/src/openvpn/tls_crypt.c
> @@ -35,35 +35,47 @@
>=20=20
>  #include "tls_crypt.h"
>=20=20
> -int
> -tls_crypt_buf_overhead(void)
> -{
> -    return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_S=
IZE;
> -}
> -
> -void
> -tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
> -                   const char *key_inline, bool tls_server)
> +static struct key_type
> +tls_crypt_kt(void)
>  {
> -    const int key_direction =3D tls_server ?
> -                              KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVER=
SE;
> -
>      struct key_type kt;
>      kt.cipher =3D cipher_kt_get("AES-256-CTR");
>      kt.digest =3D md_kt_get("SHA256");
>=20=20
>      if (!kt.cipher)
>      {
> -        msg(M_FATAL, "ERROR: --tls-crypt requires AES-256-CTR support.");
> +        msg(M_WARN, "ERROR: --tls-crypt requires AES-256-CTR support.");
> +        return (struct key_type) { 0 };
>      }
>      if (!kt.digest)
>      {
> -        msg(M_FATAL, "ERROR: --tls-crypt requires HMAC-SHA-256 support."=
);
> +        msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
> +        return (struct key_type) { 0 };
>      }
>=20=20
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
> +    if (!kt.cipher || !kt.digest)
> +    {
> +        msg (M_FATAL, "ERROR: --tls-crypt not supported");

there should be no space between 'msg' and '('.
I hope who will commit this patch will also be able to remove it.

> +    }
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
> index 9b82035..0a6a08f 100644
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
> @@ -60,23 +60,13 @@ setup(void **state) {
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
> +    struct key key =3D { 0 };
> +
> +    ctx->kt =3D tls_crypt_kt();
> +    if (!ctx->kt.cipher || !ctx->kt.digest)
>      {
> -        printf("No HMAC-SHA256 support, skipping test.\n");
>          return 0;
>      }
> -    ctx->kt.cipher_length =3D cipher_kt_key_size(ctx->kt.cipher);
> -    ctx->kt.hmac_length =3D md_kt_size(ctx->kt.digest);
> -
> -    struct key key =3D { 0 };
> -
>      init_key_ctx(&ctx->co.key_ctx_bi.encrypt, &key, &ctx->kt, true, "TES=
T");
>      init_key_ctx(&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TE=
ST");
>=20=20
>=20


Much better error handling.
Even if I don't like the "return .. { 0 }" from a style perspective, the
patch is fine and does what it says. ACK.

Cheers,

--=20
Antonio Quartulli


--8jG3JsMmUOS3nA47Tfr6CUl4Gf7bqrI8K--

--diTQnolgmFkffenEEjBQJoLMr29skbodg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmO19oACgkQ0+HICM1s
oFDA9g/8CpRakDNcDNzNtfOiTgeg4e5yfSnchGJC9ko44X7vPWWya0g9ijXXkIVh
d0RaNs4pgCt/WqNlcGehARRc+pjEH/M4N2Ix85ZYYEmreiRfVxFV+j+FgyGqMl4t
F6tpBjdgL50EiCUoFObl6YElqJtZWAATzKCiXimesILPAdc5IoWk/ZxUATkphDiA
ojM+7c/4l2DC3omTq7X1/q7a8R8vfB218kD6i/SaKtAUvM1meT6J6nOqql2I3BUZ
96d+oPkKlAh/6/hcWIuMPnv1YdKNJpguLwE+aIM0hm9HmnHPPG19AsbqxgJSgDii
+LLyRSkKcn4bAPK47YrPDzjJDwVlZavmqBv0zwkkeeGLp3eR/QDVEofZ95DIEuH7
URmRkzng6A54ScohI8SOXf6bHn6GQRDF22vTy2kXma2mEfVZals5m4C6b2oQvpLd
Yu0zSkkuHhhhzvot5BBXTy7Hc7Zz3YNTjkvKUg9/ABwtbYWPpDxb10q//aMQe0uD
cz4RGW0iVMKtgX/9YRRa2m3Q2PnFDoscGlgHeAGcnj4GWYYgxASlGdXw8wpRMnCF
tZZPforyfTCrnc/RsUxZDpvC5FpZ8YCBw9ypworUrvVBfZaqs4VIgmgqs8n/T1Ai
MgdyA4zPiAbWKm/jpbpsIChYdui6eDugZxaG9PiQtgSr4WxheHw=
=yvqA
-----END PGP SIGNATURE-----

--diTQnolgmFkffenEEjBQJoLMr29skbodg--

