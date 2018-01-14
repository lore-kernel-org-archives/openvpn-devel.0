References: <1515884446-27152-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5216e629-2cc3-a46e-c8f7-6d975231caed@...1856...>
Date: Sun, 14 Jan 2018 10:53:21 +0100
MIME-Version: 1.0
In-Reply-To: <1515884446-27152-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_meth_free instead of free
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

On 14-01-18 00:00, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - RSA_meth_new allocates memory for the name string
>   and must be released using RSA_meth_free
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/ssl_openssl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 34c31b9..d6d9acf 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1144,7 +1144,7 @@ err:
>      {
>          if (rsa_meth)
>          {
> -            free(rsa_meth);
> +            RSA_meth_free(rsa_meth);
>          }
>      }
>      crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
> 

Good find, seems we missed that in the transition to OpenSSL 1.1.

(I see we have the same pattern in cryptapi.c, but you fix that as part
of your cryptoapi.c patches.)

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

