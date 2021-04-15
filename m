References: <20210408120029.19438-1-arne@...1227...>
 <20210408120029.19438-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7a2e1e5c-b7e9-4318-a7ff-ac662dd80db0@...2181...>
Date: Fri, 16 Apr 2021 00:22:42 +0200
MIME-Version: 1.0
In-Reply-To: <20210408120029.19438-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] Allow all GCM ciphers
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

On 08/04/2021 14:00, Arne Schwabe wrote:
> OpenSSL also allows ARIA-GCM and that works well with our implementation
> While the handpicked list was needed for earlier OpenSSL versions (and
> is still needed for Chacha20-Poly1305), the API nowadays with OpenSSL
> 1.0.2 and 1.1.x works as expected.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto_openssl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index f8b36bf85..235d0c321 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -728,6 +728,11 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
>  {
>      if (cipher)
>      {
> +        if (EVP_CIPHER_mode(cipher) == OPENVPN_MODE_GCM)
> +        {
> +            return true;
> +        }
> +
>          switch (EVP_CIPHER_nid(cipher))
>          {
>              case NID_aes_128_gcm:

If the hand-picked list is required only for chacha-poly1305, why not
removing all the AES variants from this list?

I tested ossl 1.0.2 and indeed EVP_CIPHER_mode(*aes-gcm*) returns GCM,
so this list should not be required.

Regards,


-- 
Antonio Quartulli

