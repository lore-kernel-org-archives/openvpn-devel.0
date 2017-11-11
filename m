References: <20171110161131.GZ958@...1296...>
 <20171111153653.24773-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8ae70736-ee68-ca24-cf5a-3261022d6aaa@...2181...>
Date: Sun, 12 Nov 2017 01:45:51 +0800
MIME-Version: 1.0
In-Reply-To: <20171111153653.24773-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5dMP6Ab3pOlOwuuWWBec7kTjM4ahmaCXx"
Subject: Re: [Openvpn-devel] [PATCH v4] Add --tls-cert-profile option for
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
--5dMP6Ab3pOlOwuuWWBec7kTjM4ahmaCXx
Content-Type: multipart/mixed; boundary="c67iXPN9H5htjKstWfjfH4sJn6uMSJsVb";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8ae70736-ee68-ca24-cf5a-3261022d6aaa@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] Add --tls-cert-profile option for
 mbedtls builds
References: <20171110161131.GZ958@...1296...>
 <20171111153653.24773-1-steffan@...1856...>
In-Reply-To: <20171111153653.24773-1-steffan@...1856...>

--c67iXPN9H5htjKstWfjfH4sJn6uMSJsVb
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/11/17 23:36, Steffan Karger wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> This allows the user to specify what certificate crypto algorithms to
> support.  The supported profiles are 'preferred', 'legacy' (default) and
> 'suiteb', as discussed in <84590a17-1c48-9df2-c48e-4160750b2e33@...1783...=
.>
> (https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1421=
4.html).
>=20
> This only implements the feature for mbed TLS builds, because for mbed it
> is both more easy to implement and the most relevant because mbed TLS 2+
> is by default somewhat restrictive by requiring 2048-bit+ for RSA keys.
>=20
> This patch uses 'legacy' as the default profile following discussion on
> the openvpn-devel mailing list.  This way this patch can be applied to
> both the release/2.4 and master branches.  I'll send a follow-up patch for
> the master branch to change the default to 'preferred' later.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Tested-by: Antonio Quartulli <a@...2181...>

The test consisted in configuring a server and a client with
certificates signed with SHA1.

With the default settings, the client was able to connect to the server.

When setting the cert profile to "preferred" on either one, the latter
complained about unacceptable signature.

This proved that the patch is working as expected.

To note: the server and the clients both start even though they are
using a certificate that is signed with a non-acceptable signature (for
their profile). mbedTLS could be improved to reject a certificate when
signed with an algorithm that is not part of the allowed profile.

Cheers,

> ---
> v2:
>  - add documentation (manpage, Changes.rst and --help)
>  - no longer print a warning message on each startup for OpenSSL builds
> v3:
>  - remove format changes in unrelated items (introduced in v2)
>  - Update Changes.rst text to reflect that the default in 2.4.2 is 'legac=
y'
>    and the default in 2.5 will be 'preferred' (as discussed on the ML).
>  - This patch is for the master branch only now (due to the default).
> v4:
>  - Ignore the option for OpenSSL builds, instead of rejecting the option
>    and refusing to start.
>  - Patch is for master and release/2.4 again.  A follow-up patch will
>    change the default for master later on.
>=20
>  Changes.rst               | 12 +++++++++++
>  doc/openvpn.8             | 22 ++++++++++++++++++++
>  src/openvpn/options.c     | 16 ++++++++++++++-
>  src/openvpn/options.h     |  1 +
>  src/openvpn/ssl.c         |  3 +++
>  src/openvpn/ssl_backend.h | 10 ++++++++++
>  src/openvpn/ssl_mbedtls.c | 51 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/openvpn/ssl_mbedtls.h |  1 +
>  src/openvpn/ssl_openssl.c |  6 ++++++
>  9 files changed, 121 insertions(+), 1 deletion(-)
>=20
> diff --git a/Changes.rst b/Changes.rst
> index db9b18b9..a6090cf5 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -321,6 +321,18 @@ Maintainer-visible changes
>    i386/i686 builds on RHEL5.
>=20=20
>=20=20
> +Version 2.4.5
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +New features
> +------------
> +- The new option ``--tls-cert-profile`` can be used to restrict the set =
of
> +  allowed crypto algorithms in TLS certificates in mbed TLS builds.  The
> +  default profile is 'legacy' for now, which allows SHA1+, RSA-1024+ and=
 any
> +  elliptic curve certificates.  The default will be changed to the 'pref=
erred'
> +  profile in the future, which requires SHA2+, RSA-2048+ and any curve.
> +
> +
>  Version 2.4.3
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index a4189ac2..6059c81d 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4917,6 +4917,28 @@ when using mbed TLS or
>  OpenSSL.
>  .\"*********************************************************
>  .TP
> +.B \-\-tls\-cert\-profile profile
> +Set the allowed cryptographic algorithms for certificates according to
> +.B profile\fN.
> +
> +The following profiles are supported:
> +
> +.B preferred
> +: SHA2 and newer, RSA 2048-bit+, any elliptic curve.
> +
> +.B legacy
> +(default): SHA1 and newer, RSA 2048-bit+, any elliptic curve.
> +
> +.B suiteb
> +: SHA256/SHA384, ECDSA with P-256 or P-384.
> +
> +This option is only supported for mbed TLS builds.  OpenSSL builds accep=
t any
> +certificate that OpenSSL accepts.
> +
> +OpenVPN will migrate to 'preferred' as default in the future.  Please en=
sure
> +that your keys already comply.
> +.\"*********************************************************
> +.TP
>  .B \-\-tls\-timeout n
>  Packet retransmit timeout on TLS control channel
>  if no acknowledgment from remote within
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 49ed004b..23c2c02a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -599,6 +599,8 @@ static const char usage_message[] =3D
>  #endif
>      "--tls-cipher l  : A list l of allowable TLS ciphers separated by : =
(optional).\n"
>      "                : Use --show-tls to see a list of supported TLS cip=
hers.\n"
> +    "--tls-cert-profile p : Set the allowed certificate crypto algorithm=
 profile\n"
> +    "                  (default=3D%s).\n"
>      "--tls-timeout n : Packet retransmit timeout on TLS control channel\=
n"
>      "                  if no ACK from remote within n seconds (default=
=3D%d).\n"
>      "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and=
 recvd.\n"
> @@ -872,6 +874,7 @@ init_options(struct options *o, const bool init_gc)
>      o->renegotiate_seconds =3D 3600;
>      o->handshake_window =3D 60;
>      o->transition_window =3D 3600;
> +    o->tls_cert_profile =3D "legacy";
>      o->ecdh_curve =3D NULL;
>  #ifdef ENABLE_X509ALTUSERNAME
>      o->x509_username_field =3D X509_USERNAME_FIELD_DEFAULT;
> @@ -1750,6 +1753,7 @@ show_settings(const struct options *o)
>      SHOW_STR(cryptoapi_cert);
>  #endif
>      SHOW_STR(cipher_list);
> +    SHOW_STR(tls_cert_profile);
>      SHOW_STR(tls_verify);
>      SHOW_STR(tls_export_cert);
>      SHOW_INT(verify_x509_type);
> @@ -2729,6 +2733,7 @@ options_postprocess_verify_ce(const struct options =
*options, const struct connec
>          MUST_BE_UNDEF(pkcs12_file);
>  #endif
>          MUST_BE_UNDEF(cipher_list);
> +        MUST_BE_UNDEF(tls_cert_profile);
>          MUST_BE_UNDEF(tls_verify);
>          MUST_BE_UNDEF(tls_export_cert);
>          MUST_BE_UNDEF(verify_x509_name);
> @@ -4086,7 +4091,7 @@ usage(void)
>              o.verbosity,
>              o.authname, o.ciphername,
>              o.replay_window, o.replay_time,
> -            o.tls_timeout, o.renegotiate_seconds,
> +            o.tls_cert_profile, o.tls_timeout, o.renegotiate_seconds,
>              o.handshake_window, o.transition_window);
>  #else  /* ifdef ENABLE_CRYPTO */
>      fprintf(fp, usage_message,
> @@ -7831,6 +7836,15 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->cipher_list =3D p[1];
>      }
> +    else if (streq(p[0], "tls-cert-profile") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +#ifdef ENABLE_CRYPTO_MBEDTLS
> +        options->tls_cert_profile =3D p[1];
> +#else
> +        msg(M_WARN, "WARNING: --tls-cert-profile is not yet implemented =
for OpenSSL, ignoring option.");
> +#endif
> +    }
>      else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], =
"dir"))
>                                                     || (p[2] && streq(p[1=
], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 496c1143..85ff200b 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -502,6 +502,7 @@ struct options
>      const char *priv_key_file;
>      const char *pkcs12_file;
>      const char *cipher_list;
> +    const char *tls_cert_profile;
>      const char *ecdh_curve;
>      const char *tls_verify;
>      int verify_x509_type;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index cb94229a..48c1b477 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -621,6 +621,9 @@ init_ssl(const struct options *options, struct tls_ro=
ot_ctx *new_ctx)
>       * cipher restrictions before loading certificates */
>      tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
>=20=20
> +    /* Restrict allowed certificate crypto algorithms */
> +    tls_ctx_set_cert_profile(new_ctx, options->tls_cert_profile);
> +
>      tls_ctx_set_options(new_ctx, options->ssl_flags);
>=20=20
>      if (options->pkcs12_file)
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index aba5a4de..ddc76a97 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -176,6 +176,16 @@ void tls_ctx_set_options(struct tls_root_ctx *ctx, u=
nsigned int ssl_flags);
>   */
>  void tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciph=
ers);
>=20=20
> +/**
> + * Set the TLS certificate profile.  The profile defines which crypto
> + * algorithms may be used in the supplied certificate.
> + *
> + * @param ctx           TLS context to restrict, must be valid.
> + * @param profile       The profile name ('preferred', 'legacy' or 'suit=
eb').
> + *                      Defaults to 'preferred' if NULL.
> + */
> +void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *prof=
ile);
> +
>  /**
>   * Check our certificate notBefore and notAfter fields, and warn if the =
cert is
>   * either not yet valid or has expired.  Note that this is a non-fatal e=
rror,
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 861d936d..6950abfe 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -62,6 +62,34 @@
>  #include <mbedtls/pem.h>
>  #include <mbedtls/sha256.h>
>=20=20
> +static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =3D
> +{
> +    /* Hashes from SHA-1 and above */
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
> +    0xFFFFFFF, /* Any PK alg    */
> +    0xFFFFFFF, /* Any curve     */
> +    1024,      /* RSA-1024 and larger */
> +};
> +
> +static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_preferred=
 =3D
> +{
> +    /* SHA-2 and above */
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
> +    0xFFFFFFF, /* Any PK alg    */
> +    0xFFFFFFF, /* Any curve     */
> +    2048,      /* RSA-2048 and larger */
> +};
> +
> +#define openvpn_x509_crt_profile_suiteb mbedtls_x509_crt_profile_suiteb;
> +
>  void
>  tls_init_lib(void)
>  {
> @@ -250,6 +278,27 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, c=
onst char *ciphers)
>      free(tmp_ciphers_orig);
>  }
>=20=20
> +void
> +tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
> +{
> +    if (!profile || 0 =3D=3D strcmp(profile, "preferred"))
> +    {
> +        ctx->cert_profile =3D openvpn_x509_crt_profile_preferred;
> +    }
> +    else if (0 =3D=3D strcmp(profile, "legacy"))
> +    {
> +        ctx->cert_profile =3D openvpn_x509_crt_profile_legacy;
> +    }
> +    else if (0 =3D=3D strcmp(profile, "suiteb"))
> +    {
> +        ctx->cert_profile =3D openvpn_x509_crt_profile_suiteb;
> +    }
> +    else
> +    {
> +        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
> +    }
> +}
> +
>  void
>  tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>  {
> @@ -917,6 +966,8 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>      mbedtls_ssl_conf_rng(&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
>                           rand_ctx_get());
>=20=20
> +    mbedtls_ssl_conf_cert_profile(&ks_ssl->ssl_config, &ssl_ctx->cert_pr=
ofile);
> +
>      if (ssl_ctx->allowed_ciphers)
>      {
>          mbedtls_ssl_conf_ciphersuites(&ks_ssl->ssl_config, ssl_ctx->allo=
wed_ciphers);
> diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
> index f69b6100..341da7d4 100644
> --- a/src/openvpn/ssl_mbedtls.h
> +++ b/src/openvpn/ssl_mbedtls.h
> @@ -82,6 +82,7 @@ struct tls_root_ctx {
>      struct external_context *external_key; /**< Management external key =
*/
>  #endif
>      int *allowed_ciphers;       /**< List of allowed ciphers for this co=
nnection */
> +    mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate type=
s */
>  };
>=20=20
>  struct key_state_ssl {
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 0bfb6939..aed36a26 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -383,6 +383,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, c=
onst char *ciphers)
>      }
>  }
>=20=20
> +void
> +tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
> +{
> +    /* TODO --tls-cert-profile not supported for OpenSSL builds */
> +}
> +
>  void
>  tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>  {
>=20

--=20
Antonio Quartulli


--c67iXPN9H5htjKstWfjfH4sJn6uMSJsVb--

--5dMP6Ab3pOlOwuuWWBec7kTjM4ahmaCXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloHN08ACgkQB6U8WA7y
zXTpZxAAuY3zn/d9BKtaGwRayMdXoV8wXfN9AWPD2/r/CCi5Bf8x0ox6BPLI8JCf
0w9YVl9JoDt9w9hPAIgkWIvdZLfWQWE/2miM8eiqXQWQYm8N88iCNOex40e2ZYfO
RRW6Hyu4kn0S5C6TUFVgVPexFm4dGczkD5lQXu2PDIxKixGDUNQnmoXBkKFsRvu1
wXNggzyZOsMYVkyy6+ZarNVr0P1hLPD5qN+NBQWSifjD4K6ccuUI4eUaZ6nAMtrh
ymLPzHtgduFOJJ6ebfEb+EfrXCaVVjbeEpF16xpUh3b1RXAzSejrK3eD+8uogkkB
+J4abAIIGDaWN1S4RduJt1oGNDz9iT4Fzbgf24yW90GvxtimyPb3dkZqrjo8anuB
w1PO042QJyirdSyvmfBhkGmjAdxxEIZ98U77PmQJwv0bO9q+cENmGGwabGJpkF9s
BrGzimiZlTGXCHMGh8NJ4oQf3WuG8jITT6TZpGyrdBsZK34BxP6v6HmQCOR2OWfz
3tRn6kiEAsxNYfqkYXyanL35TrDh/r4Y1zx2WWF+305BzBxbXIOZcDxQst6UWHGX
2/bwfzg8ObJ8NyAADnRyfllOifXnlFRyXCWTpqfae1jNkTFjoXzXZN7tVi7T5IiH
pozg+wO7SKvn/gfDqrmhG14J6vIYO/K8XbyThhsggYIymUTOf2g=
=1mnY
-----END PGP SIGNATURE-----

--5dMP6Ab3pOlOwuuWWBec7kTjM4ahmaCXx--

