References: <20210922211254.7570-1-selva.nair@...277...>
 <20210922211254.7570-3-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <671f5f59-8627-36ac-2fe1-b3d31094677b@...1227...>
Date: Thu, 23 Sep 2021 21:59:33 +0200
MIME-Version: 1.0
In-Reply-To: <20210922211254.7570-3-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/9] Initialize the xkey provider and
 use it in SSL context
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net


>  #include <openssl/conf.h>
>  #include <openssl/des.h>
> @@ -75,6 +76,8 @@ static bool engine_initialized = false; /* GLOBAL */
>  
>  static ENGINE *engine_persist = NULL;   /* GLOBAL */
>  
> +static void *xkey_prov;
> +

This is under HAVE_OPENSSL_ENGINE instead have HAVE_XKEY_PROVIDER


>  /* Try to load an engine in a shareable library */
>  static ENGINE *
>  try_load_engine(const char *engine)
> @@ -161,6 +164,15 @@ crypto_init_lib(void)
>      OPENSSL_config(NULL);
>  #endif
>  #endif /* _WIN32 */
> +
> +#ifdef HAVE_XKEY_PROVIDER
> +     if (!xkey_prov)
> +     {
> +        OSSL_PROVIDER_add_builtin(NULL, "ovpn.xkey", xkey_provider_init);
> +        xkey_prov = OSSL_PROVIDER_load(NULL, "ovpn.xkey");
> +     }
> +#endif
> +
>      /*
>       * If you build the OpenSSL library and OpenVPN with
>       * CRYPTO_MDEBUG, you will get a listing of OpenSSL
> @@ -190,6 +202,13 @@ crypto_uninit_lib(void)
>          engine_initialized = false;
>      }
>  #endif
> +#ifdef HAVE_XKEY_PROVIDER
> +    if (xkey_prov)
> +    {
> +        OSSL_PROVIDER_unload(xkey_prov);
> +    }
> +#endif
> +    xkey_prov = NULL;
>  }


The xkey_prov seems to be only used with HAVE_XKEY_PROVIDER, the last
line should probably also be under it.



This is not a full review, just noting the compile errors trying to test
the whole set.

Arne

