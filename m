References: <20161129063843.14526-1-a@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
Date: Tue, 29 Nov 2016 17:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <20161129063843.14526-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

Thanks for following up.  I did some stare-at-code and trivial tests.
Will test more thoroughly tonight (hopefully on Windows too), but have a
lot of faith that those will succeed.  I have some comments from staring
at the code though, see below.

On 29-11-16 07:38, Antonio Quartulli wrote:
> In order to prevent annoying delays upon client connection,
> reload the CRL file only if it was modified since the last
> reload operation.
> If not, keep on using the already stored CRL.
>=20
> This change will boost client connection time in instances
> where the CRL file is quite large (dropping from several
> seconds to few milliseconds).
>=20
> Cc: Steffan Karger <steffan.karger@...1435...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> Tested on linux by using my VM.
> No test was performed on Windows* (compiled-only).
>=20
> Note: the check "!(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))" may n=
ot
> always work as expected. The user may forge a wrong, but still compliant,
> configuration that would fool this test. This issue exists even before ap=
plying
> this patch.
>=20
> Cheers,
>=20
>  src/openvpn/ssl.c         | 40 +++++++++++++++++++++++++++++++++++++---
>  src/openvpn/ssl_backend.h |  2 +-
>  src/openvpn/ssl_mbedtls.c |  2 +-
>  src/openvpn/ssl_mbedtls.h |  1 +
>  src/openvpn/ssl_openssl.c |  2 +-
>  src/openvpn/ssl_openssl.h |  1 +
>  6 files changed, 42 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 7347a78..235f7df 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -612,7 +612,8 @@ init_ssl (const struct options *options, struct tls_r=
oot_ctx *new_ctx)
>    /* Read CRL */
>    if (options->crl_file && !(options->ssl_flags & SSLF_CRL_VERIFY_DIR))
>      {
> -      tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_i=
nline);
> +      tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_i=
nline,
> +			 false);
>      }
>=20=20
>    /* Once keys and cert are loaded, load ECDH parameters */
> @@ -2450,6 +2451,36 @@ auth_deferred_expire_window (const struct tls_opti=
ons *o)
>    return ret;
>  }
>=20=20
> +void
> +tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
> +		   const char *crl_file_inline, bool reload)

This is only used within ssl.c, so should be static and have a function
declaration, preferably doxygen-documented, at the beginning of ssl.c.

> +{
> +  /* if something goes wrong with stat(), we'll store 0 as mtime */
> +  platform_stat_t crl_stat =3D {0};
> +
> +  /*
> +   * an inline CRL can't change at runtime, therefore there is no need to
> +   * reload it. It will be reloaded upon config change + SIGHUP.
> +   */
> +  if (crl_file_inline && reload)
> +    return;
> +
> +  if (!crl_file_inline)
> +    platform_stat(crl_file, &crl_stat);
> +
> +  /*
> +   * If this is not a reload, update the CRL right away.
> +   * Otherwise, update only if the CRL file was modified after the last =
reload.
> +   * Note: Windows does not support tv_nsec.
> +   */
> +  if (reload &&
> +      (ssl_ctx->crl_last_mtime.tv_sec >=3D crl_stat.st_mtime))
> +    return;
> +
> +  ssl_ctx->crl_last_mtime.tv_sec =3D crl_stat.st_mtime;
> +  backend_tls_ctx_reload_crl(ssl_ctx, crl_file, crl_file_inline);
> +}

This can be done without the 'reload' argument too, something like:

  /* if something goes wrong with stat(), we'll store 0 as mtime */
  platform_stat_t crl_stat =3D {0};

  if (crl_file_inline)
    {
      /*
       * an inline CRL can't change at runtime, therefore there is no
need to
       * reload it. It will be reloaded upon config change + SIGHUP.
       */
      if (ssl_ctx->crl_last_mtime.tv_sec)
	return;
      else
        crl_stat.st_mtime =3D now; /* Set dummy mtime */
    }
  else
    {
      platform_stat (crl_file, &crl_stat);
    }

  /*
   * If this is not a reload, update the CRL right away.
   * Otherwise, update only if the CRL file was modified after the last
reload.
   * Note: Windows does not support tv_nsec.
   */
  if (ssl_ctx->crl_last_mtime.tv_sec <=3D crl_stat.st_mtime)
    {
      ssl_ctx->crl_last_mtime.tv_sec =3D crl_stat.st_mtime;
      backend_tls_ctx_reload_crl (ssl_ctx, crl_file, crl_file_inline);
    }

I slightly prefer this over adding the extra argument, but can live with
your approach just fine too.  Pick what you like best :)

-Steffan

