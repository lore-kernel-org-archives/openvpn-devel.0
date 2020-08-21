References: <acdbc6b7-d9ef-7824-6511-d7bec7713b1d@...1856...>
 <20200814145153.12895-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d6cf7b19-9222-9049-0fa3-76832ca828d7@...1856...>
Date: Fri, 21 Aug 2020 21:31:34 +0200
MIME-Version: 1.0
In-Reply-To: <20200814145153.12895-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/3] Refactor
 key_state_export_keying_material functions
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 14-08-2020 16:51, Arne Schwabe wrote:
> This refactors the common code between mbed SSL and OpenSSL into
> export_user_keying_material and also prepares the backend functions
> to export more than one key.
> 
> Also fix checking the return value of SSL_export_keying_material
> only 1 is a sucess, -1 is also an error.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V2: Cache secrets for mbed TLS instead generating all ekms
>           in the call back function
> 
> Patch V3: comment is no longer a lie. (fixed doxygen)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c         | 36 ++++++++++++++++++-
>  src/openvpn/ssl_backend.h | 20 +++++++----
>  src/openvpn/ssl_mbedtls.c | 73 ++++++++++++++++++++-------------------
>  src/openvpn/ssl_mbedtls.h | 12 +++++--
>  src/openvpn/ssl_openssl.c | 43 +++++++++--------------
>  5 files changed, 114 insertions(+), 70 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index f16114c2..3fcaa25f 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2412,6 +2412,40 @@ error:
>      return false;
>  }
>  
> +static void
> +export_user_keying_material(struct key_state_ssl *ssl,
> +                            struct tls_session *session)
> +{
> +    if (session->opt->ekm_size > 0)
> +    {
> +        unsigned int size = session->opt->ekm_size;
> +        struct gc_arena gc = gc_new();
> +
> +        unsigned char *ekm;
> +        if ((ekm = key_state_export_keying_material(session,
> +                                                    session->opt->ekm_label,
> +                                                    session->opt->ekm_label_size,
> +                                                    session->opt->ekm_size,
> +                                                    &gc)))
> +        {
> +            unsigned int len = (size * 2) + 2;
> +
> +            const char *key = format_hex_ex(ekm, size, len, 0, NULL, &gc);
> +            setenv_str(session->opt->es, "exported_keying_material", key);
> +
> +            dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
> +                 __func__, key);
> +            secure_memzero(ekm, size);
> +        }
> +        else
> +        {
> +            msg(M_WARN, "WARNING: Export keying material failed!");
> +            setenv_del(session->opt->es, "exported_keying_material");
> +        }
> +        gc_free(&gc);
> +    }
> +}
> +
>  /**
>   * Handle reading key data, peer-info, username/password, OCC
>   * from the TLS control channel (cleartext).
> @@ -2541,7 +2575,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>      if ((ks->authenticated > KS_AUTH_FALSE)
>          && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
>      {
> -        key_state_export_keying_material(&ks->ks_ssl, session);
> +        export_user_keying_material(&ks->ks_ssl, session);
>  
>          if (plugin_call(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
>          {
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 7f52ab1e..cf9fba25 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -394,13 +394,21 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
>   * derived from existing TLS channel. This exported keying material can then be
>   * used for a variety of purposes.
>   *
> - * @param ks_ssl       The SSL channel's state info
>   * @param session      The session associated with the given key_state
> - */
> -
> -void
> -key_state_export_keying_material(struct key_state_ssl *ks_ssl,
> -                                 struct tls_session *session) __attribute__((nonnull));
> + * @param label        The label to use when exporting the key
> + * @param label_size   The size of the label to use when exporting the key
> + * @param ekm_size     THe size of the exported/returned key material
> + * @param gc           gc_arena that might be used to allocate the string
> + *                     returned
> + * @returns            The exported key material, the caller may zero the
> + *                     string but should not free it
> + */
> +
> +unsigned char*
> +key_state_export_keying_material(struct tls_session *session,
> +                                 const char* label, size_t label_size,
> +                                 size_t ekm_size,
> +                                 struct gc_arena *gc) __attribute__((nonnull));
>  
>  /**************************************************************************/
>  /** @addtogroup control_tls
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 9c874788..4287b59e 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -206,51 +206,54 @@ mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
>  {
>      struct tls_session *session = p_expkey;
>      struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
> -    unsigned char client_server_random[64];
> +    struct tls_key_cache *cache = &ks_ssl->tls_key_cache;
>  
> -    ks_ssl->exported_key_material = gc_malloc(session->opt->ekm_size,
> -                                              true, NULL);
> +    static_assert(sizeof(ks_ssl->ctx->session->master)
> +                    == sizeof(cache->master_secret), "master size mismatch");
>  
> -    memcpy(client_server_random, client_random, 32);
> -    memcpy(client_server_random + 32, server_random, 32);
> +    memcpy(cache->client_server_random, client_random, 32);
> +    memcpy(cache->client_server_random + 32, server_random, 32);
> +    memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
> +    cache->tls_prf_type = tls_prf_type;
>  
> -    const size_t ms_len = sizeof(ks_ssl->ctx->session->master);
> -    int ret = mbedtls_ssl_tls_prf(tls_prf_type, ms, ms_len,
> -                                  session->opt->ekm_label, client_server_random,
> -                                  sizeof(client_server_random), ks_ssl->exported_key_material,
> -                                  session->opt->ekm_size);
> -
> -    if (!mbed_ok(ret))
> -    {
> -        secure_memzero(ks_ssl->exported_key_material, session->opt->ekm_size);
> -    }
> -
> -    secure_memzero(client_server_random, sizeof(client_server_random));
> -
> -    return ret;
> +    return true;
>  }
> -#endif /* HAVE_EXPORT_KEYING_MATERIAL */
>  
> -void
> -key_state_export_keying_material(struct key_state_ssl *ssl,
> -                                 struct tls_session *session)
> +unsigned char *
> +key_state_export_keying_material(struct tls_session *session,
> +                                 const char* label, size_t label_size,
> +                                 size_t ekm_size,
> +                                 struct gc_arena *gc)
>  {
> -    if (ssl->exported_key_material)
> +    ASSERT(strlen(label) == label_size);
> +
> +    struct tls_key_cache *cache = &session->key[KS_PRIMARY].ks_ssl.tls_key_cache;
> +
> +    /* If the type is NONE, we either have no cached secrets or
> +     * there is no PRF, in both cases we cannot generate key material */
> +    if (cache->tls_prf_type == MBEDTLS_SSL_TLS_PRF_NONE)
>      {
> -        unsigned int size = session->opt->ekm_size;
> -        struct gc_arena gc = gc_new();
> -        unsigned int len = (size * 2) + 2;
> +        return NULL;
> +    }
>  
> -        const char *key = format_hex_ex(ssl->exported_key_material,
> -                                        size, len, 0, NULL, &gc);
> -        setenv_str(session->opt->es, "exported_keying_material", key);
> +    unsigned char *ekm = (unsigned char *) gc_malloc(ekm_size, true, gc);
> +    int ret = mbedtls_ssl_tls_prf(cache->tls_prf_type, cache->master_secret,
> +                                  sizeof(cache->master_secret),
> +                                  label, cache->client_server_random,
> +                                  sizeof(cache->client_server_random),
> +                                  ekm, ekm_size);
>  
> -        dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
> -             __func__, key);
> -        gc_free(&gc);
> +    if (mbed_ok(ret))
> +    {
> +        return ekm;
> +    }
> +    else
> +    {
> +        secure_memzero(ekm, session->opt->ekm_size);
> +        return  NULL;
>      }
>  }
> -
> +#endif /* HAVE_EXPORT_KEYING_MATERIAL */
>  
>  bool
>  tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
> @@ -1178,7 +1181,7 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
>  {
>      if (ks_ssl)
>      {
> -        free(ks_ssl->exported_key_material);
> +        CLEAR(ks_ssl->tls_key_cache);
>  
>          if (ks_ssl->ctx)
>          {
> diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
> index 0525134f..17aae551 100644
> --- a/src/openvpn/ssl_mbedtls.h
> +++ b/src/openvpn/ssl_mbedtls.h
> @@ -82,6 +82,15 @@ struct external_context {
>      void *sign_ctx;
>  };
>  
> +/** struct to cache TLS secrets for keying material exporter (RFC 5705).
> + * The constants (64 and 48) are inherent to TLS version and
> + * the whole keying material export will likely change when they change */
> +struct tls_key_cache {
> +    unsigned char client_server_random[64];
> +    mbedtls_tls_prf_types tls_prf_type;
> +    unsigned char master_secret[48];
> +};
> +
>  /**
>   * Structure that wraps the TLS context. Contents differ depending on the
>   * SSL library used.
> @@ -114,8 +123,7 @@ struct key_state_ssl {
>      mbedtls_ssl_context *ctx;           /**< mbedTLS connection context */
>      bio_ctx *bio_ctx;
>  
> -    /** Keying material exporter cache (RFC 5705). */
> -    uint8_t *exported_key_material;
> +    struct tls_key_cache tls_key_cache;
>  
>  };
>  
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 5ba74402..f52c7c39 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -158,35 +158,26 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
>      return NULL != ctx->ctx;
>  }
>  
> -void
> -key_state_export_keying_material(struct key_state_ssl *ssl,
> -                                 struct tls_session *session)
> -{
> -    if (session->opt->ekm_size > 0)
> -    {
> -        unsigned int size = session->opt->ekm_size;
> -        struct gc_arena gc = gc_new();
> -        unsigned char *ekm = (unsigned char *) gc_malloc(size, true, &gc);
> +unsigned char*
> +key_state_export_keying_material(struct tls_session *session,
> +                                 const char* label, size_t label_size,
> +                                 size_t ekm_size,
> +                                 struct gc_arena *gc)
>  
> -        if (SSL_export_keying_material(ssl->ssl, ekm, size,
> -                                       session->opt->ekm_label,
> -                                       session->opt->ekm_label_size,
> -                                       NULL, 0, 0))
> -        {
> -            unsigned int len = (size * 2) + 2;
> +{
> +    unsigned char *ekm = (unsigned char *) gc_malloc(ekm_size, true, gc);
>  
> -            const char *key = format_hex_ex(ekm, size, len, 0, NULL, &gc);
> -            setenv_str(session->opt->es, "exported_keying_material", key);
> +    SSL* ssl = session->key[KS_PRIMARY].ks_ssl.ssl;
>  
> -            dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
> -                 __func__, key);
> -        }
> -        else
> -        {
> -            msg(M_WARN, "WARNING: Export keying material failed!");
> -            setenv_del(session->opt->es, "exported_keying_material");
> -        }
> -        gc_free(&gc);
> +    if (SSL_export_keying_material(ssl, ekm, ekm_size, label,
> +                                   label_size, NULL, 0, 0) == 1)
> +    {
> +        return ekm;
> +    }
> +    else
> +    {
> +        secure_memzero(ekm, ekm_size);
> +        return NULL;
>      }
>  }
>  
> 

Thanks, looks good to me now. Changes wrt v2 in comments and whitespace
only, so didn't re-test.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

