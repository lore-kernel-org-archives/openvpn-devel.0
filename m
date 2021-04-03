References: <20210402112403.6873-1-maximilian.fillinger@...2507...>
 <E1lSI8m-0000tY-FA@...2508...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d2ba0cf7-f0f9-29b5-8ddd-f649628470ed@...1227...>
Date: Sat, 3 Apr 2021 14:08:53 +0200
MIME-Version: 1.0
In-Reply-To: <E1lSI8m-0000tY-FA@...2508...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/1] Let mbedtls_ssl_configs find
 reloaded CRLs
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
Cc: Maximilian Fillinger <maximilian.fillinger@...1435...>


>  }
>  
>  void
> +make_empty_crl(struct tls_root_ctx *ctx)
> +{
> +    if (ctx->crl == NULL)
> +    {
> +        ALLOC_OBJ_CLEAR(ctx->crl, mbedtls_x509_crl);
> +    }
> +    else
> +    {
> +        mbedtls_x509_crl_free(ctx->crl);
> +    }
> +}
> +

This function is confsung me. This needs at least more documentation
what it is doing as docstring etc. I would also expect to have
mbedtls_x509_crl_init to init the struct and not just a malloc that set
the whole structure to zero. And mbedtls_x509_crl_free does from its
description doesn't guarantee that the object is left in a proper state.

Arne

