MIME-Version: 1.0
In-Reply-To: <1457188484-26986-1-git-send-email-arne@...1227...>
References: <1457188484-26986-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 6 Mar 2016 11:17:07 +0100
Message-ID: <CAA1Abx+7O+zgtd+pJ=MPcBYDKLwtDakRiwz=NGjqDgyjyKUKyw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Implement inlining of crl files
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

Hi,

On Sat, Mar 5, 2016 at 3:34 PM, Arne Schwabe <arne@...1227...> wrote:
> While crl files can change regulary and it is usually not a good idea to =
statically include them into config files, handling multiple files and upda=
ting files on mobile files is tiresome/problematic. Inlining a static versi=
on of the crl file is better in these use cases than to use no crl at all.
>
> OpenVPN 3 already supports inlining crl-verify, so <crl-verify> is alread=
y used in config files.

Feature-ACK, but some remarks:

> @@ -6498,7 +6498,7 @@ X509_1_C=3DKG
>  .\"*********************************************************
>  .SH INLINE FILE SUPPORT
>  OpenVPN allows including files in the main configuration for the
> -.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-=
secret
> +.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-=
secret, \-\-crl-verify
>  and
>  .B \-\-tls\-auth
>  options.

Real nitpicking, but now that I'm sending mail anyway: this exceeds
the 80-char 'limit', while the surrounding text seems to obey.  Would
you mind putting .B \-\-crl-verify on a new line instead?

> @@ -2729,10 +2729,11 @@ options_postprocess_filechecks (struct options *o=
ptions)
>                               "--pkcs12");
>
>    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
> -    errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
, options->crl_file, R_OK|X_OK,
> +    errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE,
> +                                    options->crl_file, R_OK|X_OK,
>                                 "--crl-verify directory");

This looks like an accidental formatting change.

>    else
> -    errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
, options->crl_file, R_OK,
> +    errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
|CHKACC_INLINE, options->crl_file, R_OK,
>                                 "--crl-verify");

This line too becomes quite long (it at least exceeds my default
editor window width ;) ).

> --- a/src/openvpn/ssl_verify_backend.h
> +++ b/src/openvpn/ssl_verify_backend.h
> @@ -254,7 +254,7 @@ result_t x509_write_pem(FILE *peercert_file, openvpn_=
x509_cert_t *peercert);
>   *                     certificate or does not contain an entry for it.
>   *                     \c FAILURE otherwise.
>   */
> -result_t x509_verify_crl(const char *crl_file, openvpn_x509_cert_t *cert,
> -    const char *subject);
> +result_t x509_verify_crl(const char *crl_file, const char *crl_inline,
> +                         openvpn_x509_cert_t *cert, const char *subject);

Could you add the new parameter to the doxygen too?

> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -578,7 +578,7 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
>   * check peer cert against CRL
>   */
>  result_t
> -x509_verify_crl(const char *crl_file, X509 *peer_cert, const char *subje=
ct)
> +x509_verify_crl(const char *crl_file, const char* crl_inline, X509 *peer=
_cert, const char *subject)

This becomes a quite long line.

> --- a/src/openvpn/ssl_verify_polarssl.c
> +++ b/src/openvpn/ssl_verify_polarssl.c
> @@ -359,18 +359,29 @@ x509_write_pem(FILE *peercert_file, x509_crt *peerc=
ert)
>   * check peer cert against CRL
>   */
>  result_t
> -x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subjec=
t)
> +x509_verify_crl(const char *crl_file, const char* crl_inline, x509_crt *=
cert, const char *subject)

This becomes a quite long line.

>  {
>    result_t retval =3D FAILURE;
>    x509_crl crl =3D {0};
>    struct gc_arena gc =3D gc_new();
>    char *serial;
>
> -  if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
> +  if (!strcmp (cert_file, INLINE_FILE_TAG) && crl_inline)

This doesn't compile.  I think you meant to write crl_file there, not cert_=
file.

>      {
> -      msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
> -      goto end;
> +      if (!polar_ok(x509_crl_parse_(&crl, crl_inline, strlen(crl_inline)=
)))

This doesn't compile.  The final _ of x509_crl_parse_() should be removed.

> +        {
> +           msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
> +           goto end;
> +        }

This warning message does not make sense for an inline crl.  Change to
"cannot parse inline CRL"?

After the above changes, I tested the code and it works as expected.

-Steffan

