References: <20180605081407.6944-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7b4f4995-3474-8f77-14ba-bf9d0c236446@...1856...>
Date: Thu, 5 Jul 2018 22:22:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180605081407.6944-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi Antonio,

On 05-06-18 10:14, Antonio Quartulli wrote:
> In preparation to having tls-auth/crypt keys per connection
> block, it is important to ensure that such material is always
> reloaded upon SIGUSR1, no matter if `persist-key` was specified
> or not.
> 
> This is required because when moving from one remote to the
> other the key may change and thus the key context needs to
> be refreshed.
> 
> To ensure that the `persist-key` logic will still work
> as expected, the tls-auth/crypt key is pre-loaded so that
> the keyfile is not required at runtime.
> 
> Trac: #720
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> v2:
> - introduce this patch
> v3:
> - add key per-loading logic to this patch to avoid temporary features
>   breakages
> 
>  src/openvpn/buffer.c  | 29 +++++++++++++++
>  src/openvpn/buffer.h  | 13 +++++++
>  src/openvpn/crypto.c  | 20 ++--------
>  src/openvpn/init.c    | 87 ++++++++++++++++++++++++++++---------------
>  src/openvpn/options.c | 20 ++++++++++
>  5 files changed, 122 insertions(+), 47 deletions(-)
> 
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index becfeb93..cbf969a8 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -1332,3 +1332,32 @@ buffer_list_file(const char *fn, int max_line_len)
>      }
>      return bl;
>  }
> +
> +struct buffer
> +keyfile_to_buffer(const char *file, int max_size, struct gc_arena *gc)
> +{
> +    size_t size;
> +    struct buffer in = alloc_buf_gc(max_size, gc);
> +    int fd = platform_open(file, O_RDONLY, 0);
> +    if (fd == -1)
> +    {
> +        msg(M_ERR, "Cannot open key file '%s'", file);
> +    }
> +
> +    size = read(fd, in.data, in.capacity);
> +    if (size < 0)
> +    {
> +        msg(M_FATAL, "Read error on key file ('%s')", file);
> +    }
> +
> +    if (size == in.capacity)
> +    {
> +        msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", file,
> +            (int)in.capacity);
> +    }
> +    close(fd);
> +
> +    in.len = size;
> +
> +    return in;
> +}

Hm, I don't really like the FATAL errors in a function that looks
generic enough for someone to use in non-startup situations.  In that
case the FATALs might create a DoS vector.  Or, think ahead to the
connection blocks, a connection starting, then timeing out, then exiting
because the tls-auth/crypt key of the next connection block doesn't
exist (instead of just trying the next block).

While reading this, I realize I wrote a very similar function in the
"tls-crypt-v2: generate client keys" patch.  That one uses
platform_stat() to figure out the size and get rid of the maxlen
argument, and doesn't throw fatal errors.  Feel free to use that
implementation if you like it, or not if you don't (and I'll use yours
in the latter case).

> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index d848490a..ba9857eb 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -1112,4 +1112,17 @@ void buffer_list_aggregate_separator(struct buffer_list *bl,
>  
>  struct buffer_list *buffer_list_file(const char *fn, int max_line_len);
>  
> +/**
> + * keyfile_to_buffer - copy the content of a file into a buffer
> + *
> + * @param file      path to the file to read
> + * @param max_size  maximum size of the buffer to allocate
> + * @param gc        the garbage collector to use when allocating the buffer. It
> + *                  passed to alloc_buf_gc() and therefore can be NULL.
> + *
> + * @return the buffer storing the file content
> + */
> +struct buffer keyfile_to_buffer(const char *file, int max_size,
> +                                struct gc_arena *gc);
> +
>  #endif /* BUFFER_H */
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index b59c1f73..f201b533 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1224,7 +1224,7 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
>  {
>      struct gc_arena gc = gc_new();
>      struct buffer in;
> -    int fd, size;
> +    int size;
>      uint8_t hex_byte[3] = {0, 0, 0};
>      const char *error_filename = file;
>  
> @@ -1268,22 +1268,8 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
>      }
>      else /* 'file' is a filename which refers to a file containing the ascii key */
>      {
> -        in = alloc_buf_gc(2048, &gc);
> -        fd = platform_open(file, O_RDONLY, 0);
> -        if (fd == -1)
> -        {
> -            msg(M_ERR, "Cannot open key file '%s'", file);
> -        }
> -        size = read(fd, in.data, in.capacity);
> -        if (size < 0)
> -        {
> -            msg(M_FATAL, "Read error on key file ('%s')", file);
> -        }
> -        if (size == in.capacity)
> -        {
> -            msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", file, (int)in.capacity);
> -        }
> -        close(fd);
> +        in = keyfile_to_buffer(file, 2048, &gc);
> +        size = in.len;
>      }
>  
>      cp = (unsigned char *)in.data;
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 36c1a4c4..15fef08d 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2406,7 +2406,6 @@ key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
>      if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
>      {
>          tls_ctx_free(&ks->ssl_ctx);
> -        free_key_ctx_bi(&ks->tls_wrap_key);
>      }
>      CLEAR(*ks);
>  }
> @@ -2496,6 +2495,48 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
>      check_replay_consistency(&c->c1.ks.key_type, options->replay);
>  }
>  
> +/*
> + * Initialize the tls-auth/crypt key context
> + */
> +static void
> +do_init_tls_wrap_key(struct context *c)
> +{
> +    const struct options *options = &c->options;
> +
> +    /* TLS handshake authentication (--tls-auth) */
> +    if (options->tls_auth_file)
> +    {
> +        /* Initialize key_type for tls-auth with auth only */
> +        CLEAR(c->c1.ks.tls_auth_key_type);
> +        if (!streq(options->authname, "none"))
> +        {
> +            c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
> +                c->c1.ks.tls_auth_key_type.hmac_length =
> +                    md_kt_size(c->c1.ks.tls_auth_key_type.digest);
> +        }
> +        else
> +        {
> +            msg(M_FATAL, "ERROR: tls-auth enabled, but no valid --auth "
> +                "algorithm specified ('%s')", options->authname);
> +        }
> +
> +        crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type,
> +                                &c->c1.ks.tls_wrap_key,
> +                                options->tls_auth_file,
> +                                options->tls_auth_file_inline,
> +                                options->key_direction,
> +                                "Control Channel Authentication", "tls-auth");
> +    }
> +
> +    /* TLS handshake encryption+authentication (--tls-crypt) */
> +    if (options->tls_crypt_file)
> +    {
> +        tls_crypt_init_key(&c->c1.ks.tls_wrap_key,
> +                           options->tls_crypt_file,
> +                           options->tls_crypt_inline, options->tls_server);
> +    }
> +}
> +
>  /*
>   * Initialize the persistent component of OpenVPN's TLS mode,
>   * which is preserved across SIGUSR1 resets.
> @@ -2545,35 +2586,8 @@ do_init_crypto_tls_c1(struct context *c)
>          /* Initialize PRNG with config-specified digest */
>          prng_init(options->prng_hash, options->prng_nonce_secret_len);
>  
> -        /* TLS handshake authentication (--tls-auth) */
> -        if (options->tls_auth_file)
> -        {
> -            /* Initialize key_type for tls-auth with auth only */
> -            CLEAR(c->c1.ks.tls_auth_key_type);
> -            if (!streq(options->authname, "none"))
> -            {
> -                c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
> -                c->c1.ks.tls_auth_key_type.hmac_length =
> -                    md_kt_size(c->c1.ks.tls_auth_key_type.digest);
> -            }
> -            else
> -            {
> -                msg(M_FATAL, "ERROR: tls-auth enabled, but no valid --auth "
> -                    "algorithm specified ('%s')", options->authname);
> -            }
> -
> -            crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type,
> -                                    &c->c1.ks.tls_wrap_key, options->tls_auth_file,
> -                                    options->tls_auth_file_inline, options->key_direction,
> -                                    "Control Channel Authentication", "tls-auth");
> -        }
> -
> -        /* TLS handshake encryption+authentication (--tls-crypt) */
> -        if (options->tls_crypt_file)
> -        {
> -            tls_crypt_init_key(&c->c1.ks.tls_wrap_key, options->tls_crypt_file,
> -                               options->tls_crypt_inline, options->tls_server);
> -        }
> +        /* initialize tls-auth/crypt key */
> +        do_init_tls_wrap_key(c);
>  
>          c->c1.ciphername = options->ciphername;
>          c->c1.authname = options->authname;
> @@ -2595,6 +2609,12 @@ do_init_crypto_tls_c1(struct context *c)
>          c->options.ciphername = c->c1.ciphername;
>          c->options.authname = c->c1.authname;
>          c->options.keysize = c->c1.keysize;
> +
> +        /*
> +         * tls-auth/crypt key can be configured per connection block, therefore
> +         * we must reload it as it may have changed
> +         */
> +        do_init_tls_wrap_key(c);
>      }
>  }
>  
> @@ -3398,6 +3418,13 @@ do_close_tls(struct context *c)
>  static void
>  do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
>  {
> +    /*
> +     * always free the tls_auth/crypt key. If persist_key is true, the key will
> +     * be reloaded from memory (pre-cached)
> +     */
> +    free_key_ctx_bi(&c->c1.ks.tls_wrap_key);
> +    CLEAR(c->c1.ks.tls_wrap_key);
> +
>      if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_key))
>      {
>          key_schedule_free(&c->c1.ks, free_ssl_ctx);
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 426057ab..730ca6f1 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3019,6 +3019,26 @@ options_postprocess_mutate(struct options *o)
>          options_postprocess_mutate_ce(o, o->connection_list->array[i]);
>      }
>  
> +    /* pre-cache tls-auth/crypt key file if persist-key was specified */
> +    if (o->persist_key)
> +    {
> +        if (o->tls_auth_file && !o->tls_auth_file_inline)
> +        {
> +            struct buffer in = keyfile_to_buffer(o->tls_auth_file, 2048,
> +                                                 &o->gc);
> +            o->tls_auth_file = INLINE_FILE_TAG;
> +            o->tls_auth_file_inline = (char *)in.data;
> +        }
> +
> +        if (o->tls_crypt_file && !o->tls_crypt_inline)
> +        {
> +            struct buffer in = keyfile_to_buffer(o->tls_crypt_file, 2048,
> +                                                 &o->gc);
> +            o->tls_crypt_file = INLINE_FILE_TAG;
> +            o->tls_crypt_inline = (char *)in.data;
> +        }
> +    }
> +
>      if (o->tls_server)
>      {
>          /* Check that DH file is specified, or explicitly disabled */
> 

Otherwise this looks good and passes initial tests.  I want to test this
a bit more before a final ACK, but I think you'll want to look into the
above comment anyway.

-Steffan

