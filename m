References: <20210312150629.57302-1-juliusz@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <908a46d4-ad36-e980-b099-a45a87b9df77@...1227...>
Date: Wed, 17 Mar 2021 14:52:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210312150629.57302-1-juliusz@...2525...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] EVP_DigestSignFinal siglen parameter
 correction
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
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

Am 12.03.21 um 16:06 schrieb Juliusz Sosinowicz:
> In the EVP_DigestSignFinal API, "before the call the siglen parameter should contain the length of the sig buffer".
> 
> Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
> ---
>  src/openvpn/crypto_openssl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 49698e4b3..4486d246d 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -1195,7 +1195,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
>      EVP_MD_CTX ctx, ctx_tmp, ctx_init;
>      EVP_PKEY *mac_key;
>      unsigned char A1[EVP_MAX_MD_SIZE];
> -    size_t A1_len;
> +    size_t A1_len = EVP_MAX_MD_SIZE;
>      int ret = false;
>  
>      chunk = EVP_MD_size(md);
> @@ -1249,6 +1249,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
>  
>          if (olen > chunk)
>          {
> +            j = olen;
>              if (!EVP_DigestSignFinal(&ctx, out, &j))
>              {
>                  goto err;
> @@ -1263,6 +1264,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
>          }
>          else
>          {
> +            A1_len = EVP_MAX_MD_SIZE;
>              /* last one */
>              if (!EVP_DigestSignFinal(&ctx, A1, &A1_len))
>              {
> 

Acked-By: Arne Schwabe <arne@...1227...>

The uninitialised parameter should not work and the OpenSSL
documentation says that it should contain the size of the buffer but the
internal code of OpenVPN seems to ignore that and somehow it still
works. But I cannot blame wolfSSL being lax about the OpenSSL API :)

