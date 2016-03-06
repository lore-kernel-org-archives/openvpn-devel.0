MIME-Version: 1.0
In-Reply-To: <1457293149-10526-1-git-send-email-arne@...1227...>
References: <CAA1Abx+7O+zgtd+pJ=MPcBYDKLwtDakRiwz=NGjqDgyjyKUKyw@...278...>
	<1457293149-10526-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 6 Mar 2016 20:49:04 +0100
Message-ID: <CAA1AbxKoWCXz6OUsvmnYFwBA96Nrxb_BBpR0=gL_ZQTBauWzfg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Implement inlining of crl files
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sun, Mar 6, 2016 at 8:39 PM, Arne Schwabe <arne@...1227...> wrote:
> While crl files can change regulary and it is usually not a good idea to =
statically include them into config files, handling multiple files and upda=
ting files on mobile files is tiresome/problematic. Inlining a static versi=
on of the crl file is better in these use cases than to use no crl at all.
>
> OpenVPN 3 already supports inlining crl-verify, so <crl-verify> is alread=
y used in config files.
>
> V2: Fixed PolarSSL and made formatting respect the 80 column limit
> V3: Accidentally reverted one change too much in V2
> ---
>  doc/openvpn.8                     |  3 ++-
>  src/openvpn/init.c                |  1 +
>  src/openvpn/options.c             | 11 ++++++++---
>  src/openvpn/options.h             |  1 +
>  src/openvpn/ssl_common.h          |  1 +
>  src/openvpn/ssl_verify.c          |  2 +-
>  src/openvpn/ssl_verify_backend.h  |  5 +++--
>  src/openvpn/ssl_verify_openssl.c  |  8 ++++++--
>  src/openvpn/ssl_verify_polarssl.c | 20 ++++++++++++++++----
>  9 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 628d877..decffc7 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -6490,7 +6490,8 @@ X509_1_C=3DKG
>  .\"*********************************************************
>  .SH INLINE FILE SUPPORT
>  OpenVPN allows including files in the main configuration for the
> -.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-=
secret
> +.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-=
secret,
> +.B \-\-crl-verify
>  and
>  .B \-\-tls\-auth
>  options.
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index cb73a3d..33a1420 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2323,6 +2323,7 @@ do_init_crypto_tls (struct context *c, const unsign=
ed int flags)
>    to.verify_x509_type =3D (options->verify_x509_type & 0xff);
>    to.verify_x509_name =3D options->verify_x509_name;
>    to.crl_file =3D options->crl_file;
> +  to.crl_file_inline =3D options->crl_file_inline;
>    to.ssl_flags =3D options->ssl_flags;
>    to.ns_cert_type =3D options->ns_cert_type;
>    memmove (to.remote_cert_ku, options->remote_cert_ku, sizeof (to.remote=
_cert_ku));
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 02def3a..57f3dc5 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2747,8 +2747,8 @@ options_postprocess_filechecks (struct options *opt=
ions)
>      errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
, options->crl_file, R_OK|X_OK,
>                                 "--crl-verify directory");
>    else
> -    errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
, options->crl_file, R_OK,
> -                               "--crl-verify");
> +    errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
|CHKACC_INLINE,
> +                                      options->crl_file, R_OK, "--crl-ve=
rify");
>
>    errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_a=
uth_file, R_OK,
>                               "--tls-auth");
> @@ -6783,12 +6783,17 @@ add_option (struct options *options,
>        VERIFY_PERMISSION (OPT_P_GENERAL);
>        options->cipher_list =3D p[1];
>      }
> -  else if (streq (p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "=
dir")) || !p[2]) && !p[3])
> +  else if (streq (p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "=
dir"))
> +                 || (p[2] && streq (p[1], INLINE_FILE_TAG) ) || !p[2]) &=
& !p[3])
>      {
>        VERIFY_PERMISSION (OPT_P_GENERAL);
>        if (p[2] && streq(p[2], "dir"))
>         options->ssl_flags |=3D SSLF_CRL_VERIFY_DIR;
>        options->crl_file =3D p[1];
> +      if (streq (p[1], INLINE_FILE_TAG) && p[2])
> +       {
> +         options->crl_file_inline =3D p[2];
> +       }
>      }
>    else if (streq (p[0], "tls-verify") && p[1])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 23d3992..8a26e14 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -511,6 +511,7 @@ struct options
>    const char *ca_file_inline;
>    const char *cert_file_inline;
>    const char *extra_certs_file_inline;
> +  const char *crl_file_inline;
>    char *priv_key_file_inline;
>    const char *dh_file_inline;
>    const char *pkcs12_file_inline; /* contains the base64 encoding of pkc=
s12 file */
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index eaf4a91..334ccb0 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -247,6 +247,7 @@ struct tls_options
>    int verify_x509_type;
>    const char *verify_x509_name;
>    const char *crl_file;
> +  const char *crl_file_inline;
>    int ns_cert_type;
>    unsigned remote_cert_ku[MAX_PARMS];
>    const char *remote_cert_eku;
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index ccfa9d2..ea381f8 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -690,7 +690,7 @@ verify_cert(struct tls_session *session, openvpn_x509=
_cert_t *cert, int cert_dep
>        }
>        else
>        {
> -       if (SUCCESS !=3D x509_verify_crl(opt->crl_file, cert, subject))
> +       if (SUCCESS !=3D x509_verify_crl(opt->crl_file, opt->crl_file_inl=
ine, cert, subject))
>           goto cleanup;
>        }
>      }
> diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_ba=
ckend.h
> index 4e9ad60..17e88fb 100644
> --- a/src/openvpn/ssl_verify_backend.h
> +++ b/src/openvpn/ssl_verify_backend.h
> @@ -248,13 +248,14 @@ result_t x509_write_pem(FILE *peercert_file, openvp=
n_x509_cert_t *peercert);
>   *
>   * @param crl_file     File name of the CRL file
>   * @param cert         Certificate to verify
> + * @param crl_inline   Contents of the crl file if it is inlined
>   * @param subject      Subject of the given certificate
>   *
>   * @return             \c SUCCESS if the CRL was not signed by the issue=
r of the
>   *                     certificate or does not contain an entry for it.
>   *                     \c FAILURE otherwise.
>   */
> -result_t x509_verify_crl(const char *crl_file, openvpn_x509_cert_t *cert,
> -    const char *subject);
> +result_t x509_verify_crl(const char *crl_file, const char *crl_inline,
> +                         openvpn_x509_cert_t *cert, const char *subject);
>
>  #endif /* SSL_VERIFY_BACKEND_H_ */
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index d014f9d..edbc2e4 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -578,7 +578,8 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
>   * check peer cert against CRL
>   */
>  result_t
> -x509_verify_crl(const char *crl_file, X509 *peer_cert, const char *subje=
ct)
> +x509_verify_crl(const char *crl_file, const char* crl_inline,
> +                X509 *peer_cert, const char *subject)
>  {
>    X509_CRL *crl=3DNULL;
>    X509_REVOKED *revoked;
> @@ -588,7 +589,10 @@ x509_verify_crl(const char *crl_file, X509 *peer_cer=
t, const char *subject)
>    struct gc_arena gc =3D gc_new();
>    char *serial;
>
> -  in =3D BIO_new_file (crl_file, "r");
> +  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
> +    in =3D BIO_new_mem_buf ((char *)crl_inline, -1);
> +  else
> +    in =3D BIO_new_file (crl_file, "r");
>
>    if (in =3D=3D NULL) {
>      msg (M_WARN, "CRL: cannot read: %s", crl_file);
> diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_p=
olarssl.c
> index a2e6a8e..d1b9f02 100644
> --- a/src/openvpn/ssl_verify_polarssl.c
> +++ b/src/openvpn/ssl_verify_polarssl.c
> @@ -359,18 +359,30 @@ x509_write_pem(FILE *peercert_file, x509_crt *peerc=
ert)
>   * check peer cert against CRL
>   */
>  result_t
> -x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subjec=
t)
> +x509_verify_crl(const char *crl_file, const char* crl_inline,
> +                x509_crt *cert, const char *subject)
>  {
>    result_t retval =3D FAILURE;
>    x509_crl crl =3D {0};
>    struct gc_arena gc =3D gc_new();
>    char *serial;
>
> -  if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
> +  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
>      {
> -      msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
> -      goto end;
> +      if (!polar_ok(x509_crl_parse(&crl, crl_inline, strlen(crl_inline))=
))
> +        {
> +           msg (M_WARN, "CRL: cannot parse inline CRL");
> +           goto end;
> +        }
>      }
> +  else
> +    {
> +      if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
> +      {
> +          msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
> +          goto end;
> +      }
> +  }
>
>    if(cert->issuer_raw.len !=3D crl.issuer_raw.len ||
>        memcmp(crl.issuer_raw.p, cert->issuer_raw.p, crl.issuer_raw.len) !=
=3D 0)

Thanks, I'm happy now ;)  ACK

-Steffan

