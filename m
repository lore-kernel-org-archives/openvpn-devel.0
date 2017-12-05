References: <20171205085711.25075-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6e094f4e-d763-7356-67de-364b26523b80@...1856...>
Date: Tue, 5 Dec 2017 23:03:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171205085711.25075-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: fix typ0 in comment
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



On 05-12-17 09:57, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> the function used to set the verify callback in mbedTLS is
> actually called mbedtls_ssl_conf_verify() and it is invoked
> in key_state_ssl_init().
> 
> Fix comment accordingly.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/ssl_verify_mbedtls.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
> index 8b0a5ae9..2fba362f 100644
> --- a/src/openvpn/ssl_verify_mbedtls.h
> +++ b/src/openvpn/ssl_verify_mbedtls.h
> @@ -48,9 +48,9 @@ typedef mbedtls_x509_crt openvpn_x509_cert_t;
>   * This callback function is called when a new TLS session is being setup to
>   * determine whether the remote OpenVPN peer's certificate is allowed to
>   * connect. It is called for once for every certificate in the chain. The
> - * callback functionality is configured in the \c init_ssl() function, which
> - * calls the mbed TLS library's \c ssl_set_verify_callback() function with \c
> - * verify_callback() as its callback argument.
> + * callback functionality is configured in the \c key_state_ssl_init() function,
> + * which calls the mbed TLS library's \c mbedtls_ssl_conf_verify() function with
> + * \c verify_callback() as its callback argument.
>   *
>   * It checks *flags and registers the certificate hash. If these steps succeed,
>   * it calls the \c verify_cert() function, which performs OpenVPN-specific
> 

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

