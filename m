MIME-Version: 1.0
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
Date: Mon, 2 Apr 2012 12:13:10 +0300
Message-ID: <CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
	RNG
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

Hello Adriaan,

I don't think that PolarSSL is so popular that we need to support
complex backward compatibility.

Supporting PolarSSL-1.1 should be sufficient, we can make the
configure script verify this minimum.

I also intend to work and cleanup the whole PolarSSL/OpenSSL mess...

Design will be to introduce crypto engine callback structure,
registering openssl and polarssl, in a way that code is using the
callback structure while using runtime configuration one can select
which engine to use (if both are available).

Are you interested in helping me? I have other major cleanups to do as well.

Alon.

On Mon, Apr 2, 2012 at 10:28 AM, Adriaan de Jong <dejong@...1435...> wrote:
>
> This patch, while retaining PolarSSL 1.0 support, introduces the PolarSSL
> 1.1 DRBG. This RNG adds a number of features, including support for
> personalisation strings and multiple entropy sources.
>
> Personalisation strings have been implemented, based on PID, program name,
> place within memory, and a hash of the user's certificate.
>
> The entropy sources used are the platform default ones. Which ones these
> are depends on how PolarSSL was built, but usually this includes:
>
> =C2=A0- /dev/urandom or the Windows CryptoAPI RNG
> =C2=A0- the HAVEGE RNG
> =C2=A0- the output of PolarSSL's hardclock() call (usually RDTSC)
>
> Finally, this patch moves to only one instance of the RNG =C2=A0per OpenV=
PN
> instance, instead of one per keystate
>
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
> ---
> =C2=A0src/openvpn/crypto_polarssl.c | =C2=A0 84
> ++++++++++++++++++++++++++++++++++++-----
> =C2=A0src/openvpn/crypto_polarssl.h | =C2=A0 25 ++++++++++++
> =C2=A0src/openvpn/ssl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A05 ++
> =C2=A0src/openvpn/ssl_backend.h =C2=A0 =C2=A0 | =C2=A0 10 +++++
> =C2=A0src/openvpn/ssl_polarssl.c =C2=A0 =C2=A0| =C2=A0 44 +++++++++++++++=
+-----
> =C2=A0src/openvpn/ssl_polarssl.h =C2=A0 =C2=A0| =C2=A0 =C2=A02 -
> =C2=A06 files changed, 148 insertions(+), 22 deletions(-)
>
> diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
> index 0e6728c..158ccfc 100644
> --- a/src/openvpn/crypto_polarssl.c
> +++ b/src/openvpn/crypto_polarssl.c
> @@ -42,12 +42,18 @@
> =C2=A0#include "buffer.h"
> =C2=A0#include "integer.h"
> =C2=A0#include "crypto_backend.h"
> +#include "otime.h"
> +#include "misc.h"
>
> =C2=A0#include <polarssl/des.h>
> =C2=A0#include <polarssl/md5.h>
> =C2=A0#include <polarssl/cipher.h>
> =C2=A0#include <polarssl/havege.h>
>
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> +#include <polarssl/entropy.h>
> +#endif
> +
> =C2=A0/*
> =C2=A0*
> =C2=A0* Hardware engine support. Allows loading/unloading of engines.
> @@ -149,7 +155,6 @@ show_available_engines ()
> =C2=A0 =C2=A0 =C2=A0 "available\n");
> =C2=A0}
>
> -
> =C2=A0/*
> =C2=A0*
> =C2=A0* Random number functions, used in cases where we want
> @@ -159,29 +164,88 @@ show_available_engines ()
> =C2=A0*
> =C2=A0*/
>
> -int
> -rand_bytes (uint8_t *output, int len)
> +/*
> + * Initialise the given ctr_drbg context, using a personalisation string
> and an
> + * entropy gathering function.
> + */
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> +ctr_drbg_context * rand_ctx_get()
> +{
> + =C2=A0static entropy_context ec =3D {0};
> + =C2=A0static ctr_drbg_context cd_ctx =3D {0};
> + =C2=A0static bool rand_initialised =3D false;
> +
> + =C2=A0if (!rand_initialised)
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();
> + =C2=A0 =C2=A0 =C2=A0struct buffer pers_string =3D alloc_buf_gc(100, &gc=
);
> +
> + =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 * Personalisation string, should be as unique as p=
ossible (see
> NIST
> + =C2=A0 =C2=A0 =C2=A0 * 800-90 section 8.7.1). We have very little infor=
mation at this
> stage.
> + =C2=A0 =C2=A0 =C2=A0 * Include Program Name, memory address of the cont=
ext and PID.
> + =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0buf_printf(&pers_string, "OpenVPN %0u %p %s", platf=
orm_getpid(),
> &cd_ctx, time_string(0, 0, 0, &gc));
> +
> + =C2=A0 =C2=A0 =C2=A0/* Initialise PolarSSL RNG, and built-in entropy so=
urces */
> + =C2=A0 =C2=A0 =C2=A0entropy_init(&ec);
> +
> + =C2=A0 =C2=A0 =C2=A0if (0 !=3D ctr_drbg_init(&cd_ctx, entropy_func, &ec,
> BPTR(&pers_string), BLEN(&pers_string)))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "Failed to initialize random g=
enerator");
> +
> + =C2=A0 =C2=A0 =C2=A0gc_free(&gc);
> + =C2=A0 =C2=A0 =C2=A0rand_initialised =3D true;
> + =C2=A0}
> +
> + =C2=A0return &cd_ctx;
> +}
> +
> +#else /* (POLARSSL_VERSION_NUMBER < 0x01010000) */
> +
> +havege_state * rand_ctx_get()
> =C2=A0{
> =C2=A0 static havege_state hs =3D {0};
> - =C2=A0static bool hs_initialised =3D false;
> - =C2=A0const int int_size =3D sizeof(int);
> + =C2=A0static bool rand_initialised =3D false;
>
> - =C2=A0if (!hs_initialised)
> + =C2=A0if (!rand_initialised)
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 /* Initialise PolarSSL RNG */
> =C2=A0 =C2=A0 =C2=A0 havege_init(&hs);
> - =C2=A0 =C2=A0 =C2=A0hs_initialised =3D true;
> + =C2=A0 =C2=A0 =C2=A0rand_initialised =3D true;
> =C2=A0 =C2=A0 }
>
> + =C2=A0return &hs;
> +}
> +
> +#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> +
> +int
> +rand_bytes (uint8_t *output, int len)
> +{
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> + =C2=A0ctr_drbg_context *rng_ctx =3D rand_ctx_get();
> +#else /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> + =C2=A0havege_state *rng_ctx =3D rand_ctx_get();
> +#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> +
> =C2=A0 while (len > 0)
> =C2=A0 =C2=A0 {
> - =C2=A0 =C2=A0 =C2=A0const int blen =C2=A0 =3D min_int (len, int_size);
> - =C2=A0 =C2=A0 =C2=A0const int rand_int =C2=A0 =C2=A0 =C2=A0 =3D havege_=
rand(&hs);
> -
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> + =C2=A0 =C2=A0 =C2=A0const size_t blen =3D min_int (len, CTR_DRBG_MAX_RE=
QUEST);
> + =C2=A0 =C2=A0 =C2=A0if (0 !=3D ctr_drbg_random(rng_ctx, output, blen))
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +#else /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> + =C2=A0 =C2=A0 =C2=A0const size_t blen =3D min_int (len, sizeof(int));
> + =C2=A0 =C2=A0 =C2=A0const int rand_int =3D havege_rand(rng_ctx);
> =C2=A0 =C2=A0 =C2=A0 memcpy (output, &rand_int, blen);
> +
> +#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
> +
> =C2=A0 =C2=A0 =C2=A0 output +=3D blen;
> =C2=A0 =C2=A0 =C2=A0 len -=3D blen;
> =C2=A0 =C2=A0 }
> +
> =C2=A0 return 1;
> =C2=A0}
>
> diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
> index 358483a..2f303db 100644
> --- a/src/openvpn/crypto_polarssl.h
> +++ b/src/openvpn/crypto_polarssl.h
> @@ -30,9 +30,16 @@
> =C2=A0#ifndef CRYPTO_POLARSSL_H_
> =C2=A0#define CRYPTO_POLARSSL_H_
>
> +#include <polarssl/version.h>
> =C2=A0#include <polarssl/cipher.h>
> =C2=A0#include <polarssl/md.h>
>
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> +# =C2=A0include <polarssl/ctr_drbg.h>
> +#else
> +# =C2=A0include <polarssl/havege.h>
> +#endif
> +
> =C2=A0/** Generic cipher key type %context. */
> =C2=A0typedef cipher_info_t cipher_kt_t;
>
> @@ -71,4 +78,22 @@ typedef md_context_t hmac_ctx_t;
> =C2=A0#define SHA_DIGEST_LENGTH =C2=A0 =C2=A0 =C2=A020
> =C2=A0#define DES_KEY_LENGTH 8
>
> +/**
> + * Returns a singleton instance of the PolarSSL random number generator.
> + *
> + * For PolarSSL 1.0, this is the HAVEGE random number generator.
> + *
> + * For PolarSSL 1.1+, this is the CTR_DRBG random number generator. If it
> + * hasn't been initialised yet, the RNG will be initialised using the
> default
> + * entropy sources. Aside from the default platform entropy sources, an
> + * additional entropy source, the HAVEGE random number generator will
> also be
> + * added. During initialisation, a personalisation string will be added
> based
> + * on the time, the PID, and a pointer to the random context.
> + */
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> +ctr_drbg_context * rand_ctx_get();
> +#else
> +havege_state * rand_ctx_get();
> +#endif
> +
> =C2=A0#endif /* CRYPTO_POLARSSL_H_ */
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 251f8ed..767bc8e 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -391,6 +391,11 @@ init_ssl (const struct options *options, struct
> tls_root_ctx *new_ctx)
> =C2=A0 =C2=A0 =C2=A0 tls_ctx_restrict_ciphers(new_ctx, options->cipher_li=
st);
> =C2=A0 =C2=A0 }
>
> +#ifdef ENABLE_CRYPTO_POLARSSL
> + =C2=A0/* Fox-IT hardening: Personalise the random by mixing in the
> certificate */
> + =C2=A0tls_ctx_personalise_random (new_ctx);
> +#endif
> +
> =C2=A0 tls_clear_error ();
> =C2=A0 return;
>
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 5ea6a06..f3e69dd 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -272,6 +272,16 @@ void tls_ctx_load_extra_certs (struct tls_root_ctx
> *ctx, const char *extra_certs
> =C2=A0#endif
> =C2=A0 =C2=A0 );
>
> +#ifdef ENABLE_CRYPTO_POLARSSL
> +/**
> + * Add a personalisation string to the PolarSSL RNG, based on the
> certificate
> + * loaded into the given context.
> + *
> + * @param ctx =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0TLS context to use
> + */
> +void tls_ctx_personalise_random(struct tls_root_ctx *ctx);
> +#endif
> +
> =C2=A0/* **************************************
> =C2=A0*
> =C2=A0* Key-state specific functions
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index d4d85c8..8f35608 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -44,6 +44,9 @@
> =C2=A0#include "manage.h"
> =C2=A0#include "ssl_common.h"
>
> +#include <polarssl/sha2.h>
> +#include <polarssl/havege.h>
> +
> =C2=A0#include "ssl_verify_polarssl.h"
> =C2=A0#include <polarssl/pem.h>
>
> @@ -85,9 +88,6 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
> =C2=A0 ASSERT(NULL !=3D ctx);
> =C2=A0 CLEAR(*ctx);
>
> - =C2=A0ALLOC_OBJ_CLEAR(ctx->hs, havege_state);
> - =C2=A0havege_init(ctx->hs);
> -
> =C2=A0 ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
> =C2=A0 ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
>
> @@ -103,12 +103,8 @@ void
> =C2=A0tls_ctx_client_new(struct tls_root_ctx *ctx)
> =C2=A0{
> =C2=A0 ASSERT(NULL !=3D ctx);
> -
> =C2=A0 CLEAR(*ctx);
>
> - =C2=A0ALLOC_OBJ_CLEAR(ctx->hs, havege_state);
> - =C2=A0havege_init(ctx->hs);
> -
> =C2=A0 ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
> =C2=A0 ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
>
> @@ -143,8 +139,6 @@ tls_ctx_free(struct tls_root_ctx *ctx)
> =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0#endif
>
> - =C2=A0 =C2=A0 =C2=A0free(ctx->hs);
> -
> =C2=A0 =C2=A0 =C2=A0 if (ctx->allowed_ciphers)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(ctx->allowed_ciphers);
>
> @@ -504,6 +498,30 @@ static void my_debug( void *ctx, int level, const
> char *str )
> =C2=A0 =C2=A0 }
> =C2=A0}
>
> +/*
> + * Further personalise the RNG using a hash of the public key
> + */
> +void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
> +{
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> + =C2=A0static char old_sha256_hash[32] =3D {0};
> + =C2=A0char sha256_hash[32] =3D {0};
> + =C2=A0ctr_drbg_context *cd_ctx =3D rand_ctx_get();
> +
> + =C2=A0if (NULL !=3D ctx->crt_chain)
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0x509_cert *cert =3D ctx->crt_chain;
> +
> + =C2=A0 =C2=A0 =C2=A0sha2(cert->tbs.p, cert->tbs.len, sha256_hash, false=
);
> + =C2=A0 =C2=A0 =C2=A0if ( 0 !=3D memcmp(old_sha256_hash, sha256_hash,
> sizeof(sha256_hash)))
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctr_drbg_update(cd_ctx, sha256_hash, 32);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(old_sha256_hash, sha256_hash, sizeof=
(old_sha256_hash));
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0}
> +#endif /* POLARSSL_VERSION_NUMBER >=3D 0x01010000 */
> +}
> +
> =C2=A0void key_state_ssl_init(struct key_state_ssl *ks_ssl,
> =C2=A0 =C2=A0 const struct tls_root_ctx *ssl_ctx, bool is_server, void *s=
ession)
> =C2=A0{
> @@ -517,7 +535,13 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
> =C2=A0 =C2=A0 =C2=A0 /* Initialise SSL context */
> =C2=A0 =C2=A0 =C2=A0 ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
> =C2=A0 =C2=A0 =C2=A0 ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
> - =C2=A0 =C2=A0 =C2=A0ssl_set_rng (ks_ssl->ctx, havege_rand, ssl_ctx->hs);
> +
> +#if (POLARSSL_VERSION_NUMBER >=3D 0x01010000)
> + =C2=A0 =C2=A0 =C2=A0ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx=
_get());
> +#else /* POLARSSL_VERSION_NUMBER >=3D 0x01010000 */
> + =C2=A0 =C2=A0 =C2=A0ssl_set_rng (ks_ssl->ctx, havege_rand, rand_ctx_get=
());
> +#endif /* POLARSSL_VERSION_NUMBER >=3D 0x01010000 */
> +
> =C2=A0 =C2=A0 =C2=A0 ALLOC_OBJ_CLEAR (ks_ssl->ssn, ssl_session);
> =C2=A0 =C2=A0 =C2=A0 ssl_set_session (ks_ssl->ctx, 0, 0, ks_ssl->ssn );
> =C2=A0 =C2=A0 =C2=A0 if (ssl_ctx->allowed_ciphers)
> diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
> index e6149b6..2b02a6f 100644
> --- a/src/openvpn/ssl_polarssl.h
> +++ b/src/openvpn/ssl_polarssl.h
> @@ -30,7 +30,6 @@
> =C2=A0#ifndef SSL_POLARSSL_H_
> =C2=A0#define SSL_POLARSSL_H_
>
> -#include <polarssl/havege.h>
> =C2=A0#include <polarssl/ssl.h>
> =C2=A0#include "config.h"
>
> @@ -63,7 +62,6 @@ struct tls_root_ctx {
>
> =C2=A0 =C2=A0 int endpoint; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/**< Whether or not this is a server or a
> client */
>
> - =C2=A0 =C2=A0havege_state *hs; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/**< H=
AVEGE random number state */
> =C2=A0 =C2=A0 dhm_context *dhm_ctx; =C2=A0 =C2=A0 =C2=A0/**< Diffie-Helma=
nn-Merkle context */
> =C2=A0 =C2=A0 x509_cert *crt_chain; =C2=A0 =C2=A0 =C2=A0/**< Local Certif=
icate chain */
> =C2=A0 =C2=A0 x509_cert *ca_chain; =C2=A0 =C2=A0 =C2=A0 /**< CA chain for=
 remote verification */
> --
> 1.7.5.4
>
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

