From: Antonio Quartulli <a@...2181...>
References: <20200604221628.31562-1-arne@...1227...>
 <20200622140236.15238-1-arne@...1227...>
 <257fde53-0bc8-f1e6-4fb9-a90e070df880@...2181...>
Message-ID: <abe7e3ad-c178-5b6f-a424-258fb6a766a7@...2181...>
Date: Thu, 25 Jun 2020 08:13:07 +0200
MIME-Version: 1.0
In-Reply-To: <257fde53-0bc8-f1e6-4fb9-a90e070df880@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 3/3] Implement tls-groups option to
 specify eliptic curves/groups
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

on my GitLab CI build test, the compilation failed with the following
message, while compiling against openssl-1.1:

 /usr/bin/ld: ssl_openssl.o: in function `tls_ctx_set_tls_groups':
/builds/ordex986/openvpn/src/openvpn/ssl_openssl.c:611: undefined
reference to `SSL_CTX_set1_groups'
collect2: error: ld returned 1 exit status


Any clue?

On 23/06/2020 11:21, Antonio Quartulli wrote:
> Hi,
> 
> On 22/06/2020 16:02, Arne Schwabe wrote:
> 
> [CUT]
> 
>> @@ -343,6 +348,42 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
>>      }
>>  }
>>  
>> +void
>> +tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
>> +{
>> +    ASSERT(ctx);
>> +    struct gc_arena gc = gc_new();
>> +
>> +    /* Get number of groups and allocate an array in ctx */
>> +    int groups_count = get_num_elements(groups, ':');
>> +    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
>> +
>> +    /* Parse allowed ciphers, getting IDs */
>> +    int i = 0;
>> +    char *tmp_groups = string_alloc(groups, &gc);
>> +
>> +    const char *token;
>> +    while ((token = strsep(&tmp_groups, ":")))
>> +    {
>> +        const mbedtls_ecp_curve_info *ci =
>> +            mbedtls_ecp_curve_info_from_name(token);
>> +        if (!ci)
>> +        {
>> +            msg(M_WARN, "Warning unknown curve/group specified: %s", token);
>> +        }
>> +        else
>> +        {
>> +            ctx->groups[i] = ci->grp_id;
>> +            i++;
>> +        }
>> +        token = strsep(&tmp_groups, ":");
> 
> The line above should be removed, otherwise end up doing strsep() twice
> in a row.
> 
> 
>> +    }
>> +    ctx->groups[i] = MBEDTLS_ECP_DP_NONE;
>> +
>> +    gc_free(&gc);
>> +}
>> +
>> +
>>  void
>>  tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>>  {
>> @@ -1043,6 +1084,11 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>>          mbedtls_ssl_conf_ciphersuites(ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
>>      }
>>  
>> +    if (ssl_ctx->groups)
>> +    {
>> +        mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
>> +    }
>> +
>>      /* Disable record splitting (for now).  OpenVPN assumes records are sent
>>       * unfragmented, and changing that will require thorough review and
>>       * testing.  Since OpenVPN is not susceptible to BEAST, we can just
>> diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
>> index 92381f1a..0525134f 100644
>> --- a/src/openvpn/ssl_mbedtls.h
>> +++ b/src/openvpn/ssl_mbedtls.h
>> @@ -105,6 +105,7 @@ struct tls_root_ctx {
>>  #endif
>>      struct external_context external_key; /**< External key context */
>>      int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
>> +    mbedtls_ecp_group_id *groups;     /**< List of allowed groups for this connection */
>>      mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
>>  };
>>  
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index a489053b..da7d252a 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -565,6 +565,57 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
>>  #endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
>>  }
>>  
>> +void
>> +tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
>> +{
>> +    ASSERT(ctx);
>> +    struct gc_arena gc = gc_new();
>> +    /* This method could be as easy as
>> +     *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
>> +     * but OpenSSL does not like the name secp256r1 for prime256v1
>> +     * This is one of the important curves.
>> +     * To support the same name for OpenSSL and mbedTLS, we do
>> +     * this dance.
>> +     */
>> +
>> +    int groups_count = get_num_elements(groups, ':');
>> +
>> +    int *glist;
>> +    /* Allocate an array for them */
>> +    ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &gc);
>> +
>> +    /* Parse allowed ciphers, getting IDs */
>> +    int glistlen = 0;
>> +    char *tmp_groups = string_alloc(groups, &gc);
>> +
>> +    const char *token;
>> +    while ((token = strsep(&tmp_groups, ":")))
>> +    {
>> +        if (streq(token, "secp256r1"))
>> +        {
>> +            token = "prime256v1";
>> +        }
>> +        int nid = OBJ_sn2nid(token);
>> +
>> +        if (nid == 0)
> 
> From a style perspective, I think it looks better to add an empty line
> *before* "int nid =..." and remove the one after.
> 
> This way we also follow the same pattern:
> 
> x = a();
> if (x ..)
> {
> }
> 
> as other parts of the code.
> 
> 
> 
> 
> The rest looks good to me.
> 
> Regards,
> 

-- 
Antonio Quartulli

