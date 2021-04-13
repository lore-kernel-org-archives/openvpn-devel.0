References: <20210412164545.11151-1-maximilian.fillinger@...2507...>
 <E1lVziU-0007K9-3x@...2487...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4743b2e0-89bf-29f9-f406-867d35c9bb1d@...2181...>
Date: Tue, 13 Apr 2021 21:46:16 +0200
MIME-Version: 1.0
In-Reply-To: <E1lVziU-0007K9-3x@...2487...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Abort if CRL file can't be
 stat-ed in init_ssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net



On 12/04/2021 18:45, Max Fillinger wrote:
> Now that the path for the CRL file is handled correctly when using
> chroot, there's no good reason for the file to be inaccessible during
> init_ssl().
> 
> This commit ensures that the CRL file is accessed successfully at least
> once, which fixes a bug where the mbedtls version of OpenVPN wouldn't
> use a reloaded CRL if it initially failed to access the file.
> 
> In tls_process(), we stick with the previous behavior of logging a
> warning and keeping the old CRL to ensure that the CRL file can be
> updated on-the-fly.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> ---
>  src/openvpn/ssl.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 8782b140..a42b639c 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -539,10 +539,14 @@ tls_version_parse(const char *vstr, const char *extra)
>   * @param crl_file      The file name to load the CRL from, or
>   *                      "[[INLINE]]" in the case of inline files.
>   * @param crl_inline    A string containing the CRL
> + * @param abort_on_err  If this is true, OpenVPN exits if it can't stat
> + *                      the CRL file. If it is false, it will instead
> + *                      log a warning and continue using the previously
> + *                      loaded CRL.
>   */
>  static void
>  tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
> -                   bool crl_file_inline)
> +                   bool crl_file_inline, bool abort_on_err)
>  {
>      /* if something goes wrong with stat(), we'll store 0 as mtime */
>      platform_stat_t crl_stat = {0};
> @@ -559,7 +563,14 @@ tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
>      }
>      else if (platform_stat(crl_file, &crl_stat) < 0)
>      {
> -        msg(M_WARN, "WARNING: Failed to stat CRL file, not (re)loading CRL.");
> +        if (abort_on_err)

Do you think it would make sense to simply check:

if (!ssl_ctx->crl_last_mtime)
    abort
else
    warn

?

the last_mtime field should tell us if this is the first time we try
initializing the CRL or not.
And we want to abort only if the failure happens during the first
initialization.

This way we avoid adding yet another state flag that has to be conveyed
from the caller.


Regards,

> +        {
> +            msg(M_FATAL, "ERROR: Failed to stat CRL file during init_ssl, exiting.");
> +        }
> +        else
> +        {
> +            msg(M_WARN, "WARNING: Failed to stat CRL file, not (re)loading CRL.");
> +        }
>          return;
>      }
>  
> @@ -710,13 +721,13 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_ch
>           * chroot directory to crl_file. */
>          if (options->chroot_dir == NULL || in_chroot || options->crl_file_inline)
>          {
> -            tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
> +            tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline, true);
>          }
>          else
>          {
>              struct gc_arena gc = gc_new();
>              struct buffer crl_file_buf = prepend_chroot(options->chroot_dir, options->crl_file, &gc);
> -            tls_ctx_reload_crl(new_ctx, BSTR(&crl_file_buf), options->crl_file_inline);
> +            tls_ctx_reload_crl(new_ctx, BSTR(&crl_file_buf), options->crl_file_inline, true);
>              gc_free(&gc);
>          }
>      }
> @@ -2752,7 +2763,7 @@ tls_process(struct tls_multi *multi,
>                  && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
>              {
>                  tls_ctx_reload_crl(&session->opt->ssl_ctx,
> -                                   session->opt->crl_file, session->opt->crl_file_inline);
> +                                   session->opt->crl_file, session->opt->crl_file_inline, false);
>              }
>  
>              /* New connection, remove any old X509 env variables */
> 

-- 
Antonio Quartulli

