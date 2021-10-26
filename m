References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-15-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <1717c64a-b237-9b5f-0278-830048d0e74d@...2507...>
Date: Tue, 26 Oct 2021 16:37:28 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-15-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 14/21] [OSSL 3.0] Use
 TYPE_do_all_provided function for listing cipher/digest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> With OpenSSL 3.0 the use of nid values is deprecated and new algorithms
> do not even have NID values anymore.
> 
> This also works nicely with providers now:
> 
>     openvpn --provider legacy:default --show-ciphers
> 
> shows more ciphers (e.g. BF-CBC) than just
> 
>     openvpn --show-ciphers
> 
> when compiled with OpenSSL 3.0
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Looks good, and the tests work with OpenSSL 3 and OpenSSL 1.1.1 when I 
also apply the "Do not allow CTS ciphers" patch.

One nitpick:

> +struct collect_ciphers {
> +    /* If we ever exceed this, we must be more selective */
> +    const EVP_CIPHER *list[1000];
> +    size_t num;
> +};
> +
> +static void collect_ciphers(EVP_CIPHER *cipher, void *list)
> +{
> +    struct collect_ciphers* cipher_list = list;
> +    if (cipher_list->num == (sizeof(cipher_list->list)/sizeof(*cipher_list->list)))
> +    {
> +        msg(M_WARN, "WARNING: Too many ciphers, not showing all");
> +        return;
> +    }

I think it would be more readable to use a const (or a #define) for the 
length of the cipher list array, instead of using sizeof.

