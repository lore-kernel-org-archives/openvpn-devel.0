References: <cover.1487368114.git.logout@...260...>
	<9ce17efda7b1ed100e73554b1916c0bfa687d9d1.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <8d875740-e3a0-2c3c-08d4-a0490c28d69e@...1856...>
Date: Thu, 2 Mar 2017 21:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <9ce17efda7b1ed100e73554b1916c0bfa687d9d1.1487368114.git.logout@...260...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 13/15] OpenSSL: SSLeay symbols
 are no longer available in OpenSSL 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> The old symbols do not exist anymore but the library gained new
> equivalent symbols (OSSL). Use them instead of the old ones
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  src/openvpn/openssl_compat.h | 5 +++++
>  src/openvpn/ssl_openssl.c    | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index f81ec59c134fb6da2b802e66339ecd0d67040928..054fd56cd1833bb5278eb5fd88a4c4d1908d6415 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -601,4 +601,9 @@ RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)
>  }
>  #endif
>  
> +/* SSLeay symbols have been renamed in OpenSSL 1.1 */
> +#if !defined(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT)
> +#define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
> +#endif
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index a9ae20f45fe60d35af97e7d14bfd2332f9360c30..2ff3e12b93d6f829e4b27aefc2622d52e41ce589 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -996,7 +996,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>  
>      if (padding != RSA_PKCS1_PADDING)
>      {
> -        RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
>          goto done;
>      }
>  
> 

ACK

-Steffan

