References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-9-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <5c446430-2a36-f0cb-8b62-731d4cc13646@...2507...>
Date: Mon, 25 Oct 2021 13:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-9-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 08/21] [OSSL 3.0] Use
 EVP_PKEY_get_group_name to query group name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> EC_Key methods are deprecated in OpenSSL 3.0. Use
> EVP_PKEY_get_group_name instead to query the EC group name from an
> EVP_PKEY and add a compatibility function for older OpenSSL versions.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/openssl_compat.h | 42 ++++++++++++++++++++++++++++++++++++
>   src/openvpn/ssl_openssl.c    | 14 ++++++------
>   2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index ce8e2b360..dda47d76c 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -718,4 +718,46 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
>       return 1;
>   }
>   #endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL) */
> +
> +/* Functionality missing in 1.1.1 */
> +#if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC)
> +
> +/* Note that this is not a perfect emulation of the new function but
> + * is good enough for our case of printing certificate details during
> + * handshake */
> +static inline
> +int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
> +                            size_t *gname_len)
> +{
> +    const EC_KEY* ec = EVP_PKEY_get0_EC_KEY(pkey);
> +    if (ec == NULL)
> +    {
> +        return 0;
> +    }
> +    const EC_GROUP* group = EC_KEY_get0_group(ec);
> +    int nid = EC_GROUP_get_curve_name(group);
> +
> +    if (nid == 0)
> +    {
> +        return 0;
> +    }
> +    const char *curve = OBJ_nid2sn(nid);

The old code also has a curve == NULL check. Is that not necessary here?

