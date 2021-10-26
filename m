References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-16-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <011c5f85-6e10-fd33-2806-07265445d034@...2507...>
Date: Tue, 26 Oct 2021 17:27:17 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-16-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 15/21] [OSSL 3.0] Do not allow CTS
 ciphers
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
> We do not support CTS algorithms (cipher text stealing) algorithms.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/crypto_openssl.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index ab552efab..ac8287440 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -760,6 +760,9 @@ cipher_kt_mode_cbc(const cipher_kt_t *cipher)
>   {
>       return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
>              /* Exclude AEAD cipher modes, they require a different API */
> +#ifdef EVP_CIPH_FLAG_CTS
> +           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
> +#endif
>              && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
>   }
>   
> 

Together with the previous patch, this makes the tests work. One thing 
I'm unsure about is that this check is only done for CBC mode. 
Cipher-text stealing can be used in *any* block cipher mode (even CTR, 
though that would be amazingly pointless).

I compiled OpenVPN with support for OFB and CFB modes and didn't see any 
CTS in the --show-ciphers output. But do we know for sure that there's 
no supported version or configuration of OpenSSL that uses cipher-text 
stealing in non-CBC modes?

