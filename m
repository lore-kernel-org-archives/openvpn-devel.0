MIME-Version: 1.0
In-Reply-To: <1333351687-3732-4-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<1333351687-3732-4-git-send-email-dejong@...1435...>
Date: Mon, 2 Apr 2012 12:17:41 +0300
Message-ID: <CAOazyz2+Y70tQF6vo=9N1J+CF7nEGt5wzU5ZWQQOaT0-9GtZjA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] Removed support for PolarSSL < 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Oh!!!
You did removed old support.
Great.

But we should do this in autoconf as well.
Testing POLARSSL_VERSION_NUMBER >=3D 0x01010000 is enough?
Which header to include?

On Mon, Apr 2, 2012 at 10:28 AM, Adriaan de Jong <dejong@...1435...> wrote:
> PolarSSL 1.0 and earlier use only the Havege RNG. Havege is based on timi=
ng certain operations, using the RDTSC instruction. Although this is fine o=
n bare metal PCs, the RDTSC instruction is virtualised on some virtual mach=
ine implementations. This can result in issues on those virtual machines. P=
olarSSL fixes this potential issue by also using platform entropy.
>
> To ensure that OpenVPN is always built against a decent RNG, PolarSSL <1.=
1 is therefore no longer supported.
>
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
> =C2=A0src/openvpn/crypto_polarssl.c | =C2=A0 34 -------------------------=
---------
> =C2=A0src/openvpn/crypto_polarssl.h | =C2=A0 13 +------------
> =C2=A0src/openvpn/ssl_polarssl.c =C2=A0 =C2=A0| =C2=A0 =C2=A06 ------
> =C2=A0src/openvpn/syshead.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 =
---
> =C2=A04 files changed, 1 insertions(+), 55 deletions(-)
>
> diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
> index 96d41b7..3978a3c 100644
> --- a/src/openvpn/crypto_polarssl.c
> +++ b/src/openvpn/crypto_polarssl.c
> @@ -50,9 +50,7 @@
> =C2=A0#include <polarssl/cipher.h>
> =C2=A0#include <polarssl/havege.h>
>
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0#include <polarssl/entropy.h>
> -#endif
>
> =C2=A0/*
> =C2=A0*
> @@ -168,7 +166,6 @@ show_available_engines ()
> =C2=A0* Initialise the given ctr_drbg context, using a personalisation st=
ring and an
> =C2=A0* entropy gathering function.
> =C2=A0*/
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0ctr_drbg_context * rand_ctx_get()
> =C2=A0{
> =C2=A0 static entropy_context ec =3D {0};
> @@ -200,25 +197,6 @@ ctr_drbg_context * rand_ctx_get()
> =C2=A0 return &cd_ctx;
> =C2=A0}
>
> -#else /* (POLARSSL_VERSION_NUMBER < 0x01010000) */
> -
> -havege_state * rand_ctx_get()
> -{
> - =C2=A0static havege_state hs =3D {0};
> - =C2=A0static bool rand_initialised =3D false;
> -
> - =C2=A0if (!rand_initialised)
> - =C2=A0 =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0/* Initialise PolarSSL RNG */
> - =C2=A0 =C2=A0 =C2=A0havege_init(&hs);
> - =C2=A0 =C2=A0 =C2=A0rand_initialised =3D true;
> - =C2=A0 =C2=A0}
> -
> - =C2=A0return &hs;
> -}
> -
> -#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> -
> =C2=A0#ifdef ENABLE_PREDICTION_RESISTANCE
> =C2=A0void rand_ctx_enable_prediction_resistance()
> =C2=A0{
> @@ -231,26 +209,14 @@ void rand_ctx_enable_prediction_resistance()
> =C2=A0int
> =C2=A0rand_bytes (uint8_t *output, int len)
> =C2=A0{
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0 ctr_drbg_context *rng_ctx =3D rand_ctx_get();
> -#else /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> - =C2=A0havege_state *rng_ctx =3D rand_ctx_get();
> -#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
>
> =C2=A0 while (len > 0)
> =C2=A0 =C2=A0 {
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0 =C2=A0 =C2=A0 const size_t blen =3D min_int (len, CTR_DRBG_MAX_REQ=
UEST);
> =C2=A0 =C2=A0 =C2=A0 if (0 !=3D ctr_drbg_random(rng_ctx, output, blen))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> -#else /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> - =C2=A0 =C2=A0 =C2=A0const size_t blen =3D min_int (len, sizeof(int));
> - =C2=A0 =C2=A0 =C2=A0const int rand_int =3D havege_rand(rng_ctx);
> - =C2=A0 =C2=A0 =C2=A0memcpy (output, &rand_int, blen);
> -
> -#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> -
> =C2=A0 =C2=A0 =C2=A0 output +=3D blen;
> =C2=A0 =C2=A0 =C2=A0 len -=3D blen;
> =C2=A0 =C2=A0 }
> diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
> index 6152878..bfabb91 100644
> --- a/src/openvpn/crypto_polarssl.h
> +++ b/src/openvpn/crypto_polarssl.h
> @@ -33,12 +33,7 @@
> =C2=A0#include <polarssl/version.h>
> =C2=A0#include <polarssl/cipher.h>
> =C2=A0#include <polarssl/md.h>
> -
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> -# =C2=A0include <polarssl/ctr_drbg.h>
> -#else
> -# =C2=A0include <polarssl/havege.h>
> -#endif
> +#include <polarssl/ctr_drbg.h>
>
> =C2=A0/** Generic cipher key type %context. */
> =C2=A0typedef cipher_info_t cipher_kt_t;
> @@ -81,8 +76,6 @@ typedef md_context_t hmac_ctx_t;
> =C2=A0/**
> =C2=A0* Returns a singleton instance of the PolarSSL random number genera=
tor.
> =C2=A0*
> - * For PolarSSL 1.0, this is the HAVEGE random number generator.
> - *
> =C2=A0* For PolarSSL 1.1+, this is the CTR_DRBG random number generator. =
If it
> =C2=A0* hasn't been initialised yet, the RNG will be initialised using th=
e default
> =C2=A0* entropy sources. Aside from the default platform entropy sources,=
 an
> @@ -90,11 +83,7 @@ typedef md_context_t hmac_ctx_t;
> =C2=A0* added. During initialisation, a personalisation string will be ad=
ded based
> =C2=A0* on the time, the PID, and a pointer to the random context.
> =C2=A0*/
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0ctr_drbg_context * rand_ctx_get();
> -#else
> -havege_state * rand_ctx_get();
> -#endif
>
> =C2=A0#ifdef ENABLE_PREDICTION_RESISTANCE
> =C2=A0/**
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index 8f35608..fc8fa6e 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -503,7 +503,6 @@ static void my_debug( void *ctx, int level, const cha=
r *str )
> =C2=A0*/
> =C2=A0void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
> =C2=A0{
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0 static char old_sha256_hash[32] =3D {0};
> =C2=A0 char sha256_hash[32] =3D {0};
> =C2=A0 ctr_drbg_context *cd_ctx =3D rand_ctx_get();
> @@ -519,7 +518,6 @@ void tls_ctx_personalise_random(struct tls_root_ctx *=
ctx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(old_sha256_hash, sha256_hash, si=
zeof(old_sha256_hash));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 }
> -#endif /* POLARSSL_VERSION_NUMBER >=3D 0x01010000 */
> =C2=A0}
>
> =C2=A0void key_state_ssl_init(struct key_state_ssl *ks_ssl,
> @@ -536,11 +534,7 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
> =C2=A0 =C2=A0 =C2=A0 ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
> =C2=A0 =C2=A0 =C2=A0 ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
>
> -#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> =C2=A0 =C2=A0 =C2=A0 ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_=
get());
> -#else /* POLARSSL_VERSION_NUMBER >=3D 0x01010000 */
> - =C2=A0 =C2=A0 =C2=A0ssl_set_rng (ks_ssl->ctx, havege_rand, rand_ctx_get=
());
> -#endif /* POLARSSL_VERSION_NUMBER >=3D 0x01010000 */
>
> =C2=A0 =C2=A0 =C2=A0 ALLOC_OBJ_CLEAR (ks_ssl->ssn, ssl_session);
> =C2=A0 =C2=A0 =C2=A0 ssl_set_session (ks_ssl->ctx, 0, 0, ks_ssl->ssn );
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index b14d50d..79a401b 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -536,10 +536,7 @@ socket_defined (const socket_descriptor_t sd)
>
> =C2=A0/* Enable PolarSSL RNG prediction resistance support */
> =C2=A0#ifdef ENABLE_CRYPTO_POLARSSL
> -#include <polarssl/version.h>
> -#if POLARSSL_VERSION_NUMBER >=3D 0x01010000
> =C2=A0#define ENABLE_PREDICTION_RESISTANCE
> -#endif
> =C2=A0#endif /* ENABLE_CRYPTO_POLARSSL */
>
> =C2=A0/*
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

