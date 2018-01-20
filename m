References: <1516423647-21932-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e99f70db-3d9e-cb44-649c-02d2a73674a2@...1856...>
Date: Sat, 20 Jan 2018 10:50:59 +0100
MIME-Version: 1.0
In-Reply-To: <1516423647-21932-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add SSL_CTX_get_max_proto_version() not
 in openssl 1.0
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

On 20-01-18 05:47, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - No change in functionality. This is used in a subsequent
>   patch for extending TLS1.2 support with cryptoapicert
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/openssl_compat.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 9f1e92a..c94341a 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -670,6 +670,29 @@ SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
>  }
>  #endif /* SSL_CTX_get_min_proto_version */
>  
> +#ifndef SSL_CTX_get_max_proto_version
> +/** Return the max SSL protocol version currently enabled in the context.
> + *  If no valid version >= TLS1.0 is found, return 0. */
> +static inline int
> +SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
> +{
> +    long sslopt = SSL_CTX_get_options(ctx);
> +    if (!(sslopt & SSL_OP_NO_TLSv1_2))
> +    {
> +	return TLS1_2_VERSION;
> +    }
> +    if (!(sslopt & SSL_OP_NO_TLSv1_1))
> +    {
> +	return TLS1_1_VERSION;
> +    }
> +    if (!(sslopt & SSL_OP_NO_TLSv1))
> +    {
> +	return TLS1_VERSION;
> +    }
> +    return 0;
> +}
> +#endif /* SSL_CTX_get_max_proto_version */
> +
>  #ifndef SSL_CTX_set_min_proto_version
>  /** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
>  static inline int
> 

Looks good and compiles fine.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

