References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-5-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <4f84f1cf-d7e8-c0d0-9adb-4e2a21206796@...2507...>
Date: Thu, 21 Oct 2021 11:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 04/21] [OSSL 3.0] Remove DES check
 with OpenSSL 3.0
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
> DES is very deprecated and accidently getting on the of the 16 insecure
> keys that OpenSSL checks is extremely unlikely so we no longer use the
> deprecated functions without replacement in OpenSSL 3.0.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/crypto_openssl.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 021698f12..8db2ddd09 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -521,6 +521,11 @@ key_des_num_cblocks(const EVP_CIPHER *kt)
>   bool
>   key_des_check(uint8_t *key, int key_len, int ndc)
>   {
> +#if OPENSSL_VERSION_NUMBER < 0x30000000L
> +    /* DES is deprecated and the method to even check the keys is deprecated
> +     * in OpenSSL 3.0. Instead of checking for the 16 weak/semi-weak keys
> +     * we just accept them in OpenSSL 3.0 since the risk of randomly getting
> +     * these is pretty weak */
>       int i;
>       struct buffer b;
>   
> @@ -553,6 +558,9 @@ key_des_check(uint8_t *key, int key_len, int ndc)
>   err:
>       ERR_clear_error();
>       return false;
> +#else
> +    return true;
> +#endif
>   }
>   
>   void
> 

The code change looks good to me. Dropping the check is no loss because 
*all* DES keys are weak keys.

The comment probably makes more sense in the #else branch, or before the 
version check. Since I'm already nitpicking, it should be "the risk is 
low", not "weak".

