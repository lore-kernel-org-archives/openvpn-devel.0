References: <20210412164545.11151-1-maximilian.fillinger@...2507...>
 <E1lVzi7-00011Y-AY@...2479...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dcd5b87c-6a68-a191-dae9-cc35ecb99b65@...2181...>
Date: Tue, 13 Apr 2021 21:37:26 +0200
MIME-Version: 1.0
In-Reply-To: <E1lVzi7-00011Y-AY@...2479...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] In init_ssl,
 open the correct CRL path pre-chroot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>


Hi,

Thanks a lot for reworking your contribution!

On 12/04/2021 18:45, Max Fillinger wrote:
> When using the chroot option, the init_ssl function can be called before
> entering the chroot or, when OpenVPN receives a SIGHUP, afterwards. This
> commit ensures that OpenVPN tries to open the correct path for the CRL
> file in either situations.
> 
> This commit does not address key and certificate files. For these, the
> --persist-key option should be used.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> ---
>  src/openvpn/init.c    |  3 ++-
>  src/openvpn/misc.c    | 11 +++++++++++
>  src/openvpn/misc.h    |  7 +++++++
>  src/openvpn/options.c |  8 +-------
>  src/openvpn/ssl.c     | 20 ++++++++++++++++++--
>  src/openvpn/ssl.h     |  2 +-
>  6 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 28d183aa..ba38e548 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2702,7 +2702,8 @@ do_init_crypto_tls_c1(struct context *c)
>           * Initialize the OpenSSL library's global
>           * SSL context.
>           */
> -        init_ssl(options, &(c->c1.ks.ssl_ctx));
> +        bool in_chroot = (c->c0 != NULL) ? c->c0->uid_gid_chroot_set : false;
> +        init_ssl(options, &(c->c1.ks.ssl_ctx), in_chroot);

Our codestyle (that is not yet 100% consistent all over the place...)
prefers checks for pointers to simply be "if (ptr)" or "if (!ptr)".
Explicit comparison with NULL is not required.

This said, I would simplify these two lines above as:

2706         init_ssl(options, &(c->c1.ks.ssl_ctx),
2707                  c->c0 && c->c0->uid_gid_chroot_set);

(I removed the local variable, but that's more a matter of taste)

>          if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
>          {
>              switch (auth_retry_get())
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index feaefb3b..a64803a7 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -767,3 +767,14 @@ get_num_elements(const char *string, char delimiter)
>  
>      return element_count;
>  }
> +
> +struct buffer
> +prepend_chroot(const char *chroot_dir, const char *path, struct gc_arena *gc)
> +{

maybe we should just call this prepend_dir(dir, path, gc) ?
After all this is just doing a dir + '/' + filename; the fact that the
dir is the chroot-dir is due to the usecase, not about what the function
does.

> +    size_t len = strlen(chroot_dir) + strlen(PATH_SEPARATOR_STR) + strlen(path) + 1;
> +    struct buffer combined_path = alloc_buf_gc(len, gc);
> +    buf_printf(&combined_path, "%s%s%s", chroot_dir, PATH_SEPARATOR_STR, path);
> +    ASSERT(combined_path.len > 0);
> +
> +    return combined_path;
> +}
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 9b018eb5..9f352754 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -190,4 +190,11 @@ void output_peer_info_env(struct env_set *es, const char *peer_info);
>  int
>  get_num_elements(const char *string, char delimiter);
>  
> +/**
> + * Prepend the chroot directory to a path. Used when we need to access
> + * a file in the chroot directory before we have chroot-ed.
> + */
> +struct buffer
> +prepend_chroot(const char *chroot_dir, const char *path, struct gc_arena *gc);
> +
>  #endif /* ifndef MISC_H */
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 9e61b1e0..d6ba2938 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3317,14 +3317,8 @@ check_file_access_chroot(const char *chroot, const int type, const char *file, c
>      {
>          struct gc_arena gc = gc_new();
>          struct buffer chroot_file;
> -        int len = 0;
> -
> -        /* Build up a new full path including chroot directory */
> -        len = strlen(chroot) + strlen(PATH_SEPARATOR_STR) + strlen(file) + 1;
> -        chroot_file = alloc_buf_gc(len, &gc);
> -        buf_printf(&chroot_file, "%s%s%s", chroot, PATH_SEPARATOR_STR, file);
> -        ASSERT(chroot_file.len > 0);
>  
> +        chroot_file = prepend_chroot(chroot, file, &gc);
>          ret = check_file_access(type, BSTR(&chroot_file), mode, opt);
>          gc_free(&gc);
>      }
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index d8662d00..8782b140 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -584,7 +584,7 @@ tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
>   * All files are in PEM format.
>   */
>  void
> -init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
> +init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_chroot)
>  {
>      ASSERT(NULL != new_ctx);
>  
> @@ -702,7 +702,23 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
>      /* Read CRL */
>      if (options->crl_file && !(options->ssl_flags & SSLF_CRL_VERIFY_DIR))
>      {
> -        tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
> +        /* If we're running with the chroot option, we may run init_ssl() before
> +         * and after chroot-ing. We can use the crl_file path as-is if we're
> +         * not going to chroot, or if we already are inside the chroot.

"if" not going to chroot ?

> +         *
> +         * If we're going to chroot later, we need to prefix the path of the
> +         * chroot directory to crl_file. */

multiline comments should always end with */ on the last line

> +        if (options->chroot_dir == NULL || in_chroot || options->crl_file_inline)
> +        {
> +            tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
> +        }
> +        else
> +        {
> +            struct gc_arena gc = gc_new();
> +            struct buffer crl_file_buf = prepend_chroot(options->chroot_dir, options->crl_file, &gc);
> +            tls_ctx_reload_crl(new_ctx, BSTR(&crl_file_buf), options->crl_file_inline);
> +            gc_free(&gc);
> +        }

Arne: any opinion on using c->c2.gc here? init_ssl() is invoked once per
instance and re-invoked upon SIGUSR1. I believe it is fine to use the
c2's gc?


Assuming the answer to the above is true, I would suggest the following
simplification (compile tested only!):

 704     if (options->crl_file && !(options->ssl_flags &
SSLF_CRL_VERIFY_DIR))
 705     {
 706         const char *crl_data = options->crl_file;
 707
 708         /* If we're running with the chroot option, we may run
init_ssl() before
 709          * and after chroot-ing. We can use the crl_file path as-is
if we're
 710          * not going to chroot, or if we already are inside the chroot.
 711          *
 712          * If we're going to chroot later, we need to prefix the
path of the
 713          * chroot directory to crl_file.
 714          */
 715         if (!in_chroot && !options->crl_file_inline &&
options->chroot_dir)
 716         {
 717             struct buffer crl_file_buf =
prepend_chroot(options->chroot_dir,
 718
options->crl_file, gc);
 719             crl_data = BSTR(&crl_file_buf);
 720         }
 721
 722         tls_ctx_reload_crl(new_ctx, crl_data,
options->crl_file_inline);
 723     }

what do you think?

>      }
>  
>      /* Once keys and cert are loaded, load ECDH parameters */
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 300a70d3..45ebe720 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -159,7 +159,7 @@ void free_ssl_lib(void);
>   * Build master SSL context object that serves for the whole of OpenVPN
>   * instantiation
>   */
> -void init_ssl(const struct options *options, struct tls_root_ctx *ctx);
> +void init_ssl(const struct options *options, struct tls_root_ctx *ctx, bool in_chroot);
>  
>  /** @addtogroup control_processor
>   *  @{ */
> 


Regards,

-- 
Antonio Quartulli

