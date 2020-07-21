References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0b251f8c-9745-319b-db9e-58a661cd7e13@...2181...>
Date: Tue, 21 Jul 2020 15:46:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200717134739.21168-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 4/9] Implement tls-groups option to
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

I think a comment in my previous review was overlooked.

On 17/07/2020 15:47, Arne Schwabe wrote:
> @@ -343,6 +348,42 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
>      }
>  }
>  
> +void
> +tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
> +{
> +    ASSERT(ctx);
> +    struct gc_arena gc = gc_new();
> +
> +    /* Get number of groups and allocate an array in ctx */
> +    int groups_count = get_num_elements(groups, ':');
> +    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
> +
> +    /* Parse allowed ciphers, getting IDs */
> +    int i = 0;
> +    char *tmp_groups = string_alloc(groups, &gc);
> +
> +    const char *token;
> +    while ((token = strsep(&tmp_groups, ":")))
> +    {
> +        const mbedtls_ecp_curve_info *ci =
> +            mbedtls_ecp_curve_info_from_name(token);
> +        if (!ci)
> +        {
> +            msg(M_WARN, "Warning unknown curve/group specified: %s", token);
> +        }
> +        else
> +        {
> +            ctx->groups[i] = ci->grp_id;
> +            i++;
> +        }
> +        token = strsep(&tmp_groups, ":");

Aren't we calling strsep() twice in a row now?
Once in the while() condition and once at the end of the cycle?

I think Arne agreed on the issue on IRC, but maybe forgot to fix the patch?



Regards,


-- 
Antonio Quartulli

