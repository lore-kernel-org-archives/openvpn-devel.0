References: <20180707171356.26209-1-a@...2181...>
 <20180708024517.27108-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6630a648-b7e0-dbb1-f76a-ce694020d405@...1856...>
Date: Sun, 8 Jul 2018 11:23:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180708024517.27108-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6 1/2] crypto: always reload
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

Hi,

On 08-07-18 04:45, Antonio Quartulli wrote:
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
> v2:
> - introduce this patch
> v3:
> - add key per-loading logic to this patch to avoid temporary features
>   breakages
> v4:
> - rebase on top of master
> - use buffer_read_from_file() implementation from "tls-crypt-v2: generate
>   client keys". Minor change: in case of error, free buffer and remove
>   it from gc (with free_buf_gc()), if provided.
> - don't go FATAL inside buffer_read_from_file() in case of error, but
>   let external logic decide
> v5:
> - fix various bits of pointer logic in free_buf_gc()
> - implement unit test for free_buf_gc()
> - use CLEAR() instead of free_buf() at the end of free_buf_gc()
> v6:
> - rebase on top of latest master
> - fix typ0 in function doc
> - use cmocka_unit_test() instead of cmocka_unit_test_setup_teardown()
> 
>  src/openvpn/buffer.c                   | 61 ++++++++++++++++++
>  src/openvpn/buffer.h                   | 12 ++++
>  src/openvpn/crypto.c                   | 21 ++-----
>  src/openvpn/init.c                     | 87 +++++++++++++++++---------
>  src/openvpn/options.c                  | 26 ++++++++
>  tests/unit_tests/openvpn/Makefile.am   |  1 -
>  tests/unit_tests/openvpn/test_buffer.c | 45 +++++++++++++
>  7 files changed, 206 insertions(+), 47 deletions(-)
> 
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index becfeb93..0972139f 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -189,6 +189,34 @@ free_buf(struct buffer *buf)
>      CLEAR(*buf);
>  }
>  
> +static void
> +free_buf_gc(struct buffer *buf, struct gc_arena *gc)
> +{
> +    if (gc)
> +    {
> +        struct gc_entry **e = &gc->list;
> +
> +        while (*e)
> +        {
> +            /* check if this object is the one we want to delete */
> +            if ((uint8_t *)(*e + 1) == buf->data)
> +            {
> +                struct gc_entry *to_delete = *e;
> +
> +                /* remove element from linked list and free it */
> +                *e = (*e)->next;
> +                free(to_delete);
> +
> +                break;
> +            }
> +
> +            e = &(*e)->next;
> +        }
> +    }
> +
> +    CLEAR(*buf);
> +}
> +
>  /*
>   * Return a buffer for write that is a subset of another buffer
>   */
> @@ -1332,3 +1360,36 @@ buffer_list_file(const char *fn, int max_line_len)
>      }
>      return bl;
>  }
> +
> +struct buffer
> +buffer_read_from_file(const char *filename, struct gc_arena *gc)
> +{
> +    struct buffer ret = { 0 };
> +
> +    platform_stat_t file_stat = {0};
> +    if (platform_stat(filename, &file_stat) < 0)
> +    {
> +        return ret;
> +    }
> +
> +    FILE *fp = platform_fopen(filename, "r");
> +    if (!fp)
> +    {
> +        return ret;
> +    }
> +
> +    const size_t size = file_stat.st_size;
> +    ret = alloc_buf_gc(size + 1, gc); /* space for trailing \0 */
> +    ssize_t read_size = fread(BPTR(&ret), 1, size, fp);
> +    if (read_size < 0)
> +    {
> +        free_buf_gc(&ret, gc);
> +        goto cleanup;
> +    }
> +    ASSERT(buf_inc_len(&ret, read_size));
> +    buf_null_terminate(&ret);
> +
> +cleanup:
> +    fclose(fp);
> +    return ret;
> +}
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index d848490a..6b6025ed 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -1112,4 +1112,16 @@ void buffer_list_aggregate_separator(struct buffer_list *bl,
>  
>  struct buffer_list *buffer_list_file(const char *fn, int max_line_len);
>  
> +/**
> + * buffer_read_from_file - copy the content of a file into a buffer
> + *
> + * @param file      path to the file to read
> + * @param gc        the garbage collector to use when allocating the buffer. It
> + *                  is passed to alloc_buf_gc() and therefore can be NULL.
> + *
> + * @return the buffer storing the file content or an invalid buffer in case of
> + * error
> + */
> +struct buffer buffer_read_from_file(const char *filename, struct gc_arena *gc);
> +
>  #endif /* BUFFER_H */
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index b59c1f73..5381ef2a 100644
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
> @@ -1268,22 +1268,11 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
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
> +        in = buffer_read_from_file(file, &gc);
> +        if (!buf_valid(&in))
>              msg(M_FATAL, "Read error on key file ('%s')", file);
> -        }
> -        if (size == in.capacity)
> -        {
> -            msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", file, (int)in.capacity);
> -        }
> -        close(fd);
> +
> +        size = in.len;
>      }
>  
>      cp = (unsigned char *)in.data;
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index f6c8f08e..90c987b2 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2409,7 +2409,6 @@ key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
>      if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
>      {
>          tls_ctx_free(&ks->ssl_ctx);
> -        free_key_ctx_bi(&ks->tls_wrap_key);
>      }
>      CLEAR(*ks);
>  }
> @@ -2499,6 +2498,48 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
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
> @@ -2548,35 +2589,8 @@ do_init_crypto_tls_c1(struct context *c)
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
> @@ -2598,6 +2612,12 @@ do_init_crypto_tls_c1(struct context *c)
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
> @@ -3401,6 +3421,13 @@ do_close_tls(struct context *c)
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
> index 426057ab..b2ca2738 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3019,6 +3019,32 @@ options_postprocess_mutate(struct options *o)
>          options_postprocess_mutate_ce(o, o->connection_list->array[i]);
>      }
>  
> +    /* pre-cache tls-auth/crypt key file if persist-key was specified */
> +    if (o->persist_key)
> +    {
> +        if (o->tls_auth_file && !o->tls_auth_file_inline)
> +        {
> +            struct buffer in = buffer_read_from_file(o->tls_auth_file, &o->gc);
> +            if (!buf_valid(&in))
> +                msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
> +                    o->tls_auth_file);
> +
> +            o->tls_auth_file = INLINE_FILE_TAG;
> +            o->tls_auth_file_inline = (char *)in.data;
> +        }
> +
> +        if (o->tls_crypt_file && !o->tls_crypt_inline)
> +        {
> +            struct buffer in = buffer_read_from_file(o->tls_crypt_file, &o->gc);
> +            if (!buf_valid(&in))
> +                msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
> +                    o->tls_auth_file);
> +
> +            o->tls_crypt_file = INLINE_FILE_TAG;
> +            o->tls_crypt_inline = (char *)in.data;
> +        }
> +    }
> +
>      if (o->tls_server)
>      {
>          /* Check that DH file is specified, or explicitly disabled */
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
> index db4d46e1..fe39f809 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -28,7 +28,6 @@ buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
>  buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
>  buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
>  	mock_get_random.c \
> -	$(openvpn_srcdir)/buffer.c \
>  	$(openvpn_srcdir)/platform.c
>  
>  packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
> diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
> index d083b78f..7c9a9e2f 100644
> --- a/tests/unit_tests/openvpn/test_buffer.c
> +++ b/tests/unit_tests/openvpn/test_buffer.c
> @@ -33,6 +33,7 @@
>  #include <cmocka.h>
>  
>  #include "buffer.h"
> +#include "buffer.c"
>  
>  static void
>  test_buffer_strprefix(void **state)
> @@ -197,6 +198,48 @@ test_buffer_list_aggregate_separator_emptybuffers(void **state)
>      assert_int_equal(BLEN(buf), 0);
>  }
>  
> +static void
> +test_buffer_free_gc_one(void **state)
> +{
> +    struct gc_arena gc = gc_new();
> +    struct buffer buf = alloc_buf_gc(1024, &gc);
> +
> +    assert_ptr_equal(gc.list + 1, buf.data);
> +    free_buf_gc(&buf, &gc);
> +    assert_null(gc.list);
> +
> +    gc_free(&gc);
> +}
> +
> +static void
> +test_buffer_free_gc_two(void **state)
> +{
> +    struct gc_arena gc = gc_new();
> +    struct buffer buf1 = alloc_buf_gc(1024, &gc);
> +    struct buffer buf2 = alloc_buf_gc(1024, &gc);
> +    struct buffer buf3 = alloc_buf_gc(1024, &gc);
> +
> +    struct gc_entry *e;
> +
> +    e = gc.list;
> +
> +    assert_ptr_equal(e + 1, buf3.data);
> +    assert_ptr_equal(e->next + 1, buf2.data);
> +    assert_ptr_equal(e->next->next + 1, buf1.data);
> +
> +    free_buf_gc(&buf2, &gc);
> +
> +    assert_non_null(gc.list);
> +
> +    while (e)
> +    {
> +        assert_ptr_not_equal(e + 1, buf2.data);
> +        e = e->next;
> +    }
> +
> +    gc_free(&gc);
> +}
> +
>  int
>  main(void)
>  {
> @@ -226,6 +269,8 @@ main(void)
>          cmocka_unit_test_setup_teardown(test_buffer_list_aggregate_separator_emptybuffers,
>                                          test_buffer_list_setup,
>                                          test_buffer_list_teardown),
> +        cmocka_unit_test(test_buffer_free_gc_one),
> +        cmocka_unit_test(test_buffer_free_gc_two),
>      };
>  
>      return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);
> 

Thanks, this looks all good now!

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

