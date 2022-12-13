Message-ID: <d56e81f8-5302-5eca-0d2f-75957355231e@...2181...>
Date: Wed, 14 Dec 2022 00:06:28 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20221213225430.1892940-1-arne@...1227...>
 <20221213225430.1892940-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221213225430.1892940-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Set DCO_NOT_INSTALLED also for keys
 not in the get_key_scan range
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 13/12/2022 23:54, Arne Schwabe wrote:
> We have 6 key slots but normally only consider 3 of them to be
> active/valid keys. Especially the secondary key of TM_LAME_DUCK can
> in rare corner cases have a key that is still installed in the kernel.
> 
> While this should not cause any issues since I do not see way for this
> key to become active ever again, it is better to keep the state correctly.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

I am fine with this because it is just "safer".
But I truly dislike that we have to "Defend ourselves" from conditions 
which we don't even know when they may happen....
Still, this is a rant for another patch/cleanup.

This patch makes sense
Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/dco.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index 36bfbf10a..20196fe5d 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -221,13 +221,17 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
>           multi->dco_keys_installed = 1;
>       }
>   
> -    /* all keys that are not installed are set to NOT installed */
> -    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
> +    /* all keys that are not installed are set to NOT installed. Include also
> +     * keys that might even be considered as active keys to be sure*/
> +    for (int i = 0; i < TM_SIZE; ++i)
>       {
> -        struct key_state *ks = get_key_scan(multi, i);
> -        if (ks != primary && ks != secondary)
> +        for (int j = 0; j < KS_SIZE; j++)
>           {
> -            ks->dco_status = DCO_NOT_INSTALLED;
> +            struct key_state *ks = &multi->session[i].key[j];
> +            if (ks != primary && ks != secondary)
> +            {
> +                ks->dco_status = DCO_NOT_INSTALLED;
> +            }
>           }
>       }
>       return true;

-- 
Antonio Quartulli

