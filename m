Message-ID: <97cb0341-2762-3ce3-8809-d1dad6edfc66@...1227...>
Date: Mon, 27 Jun 2022 14:42:13 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-10-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220624083809.23487-10-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 09/25] dco: configure keys in DCO right
 after generating them
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
>   
> +/**
> + * Install the key material in DCO for the specified peer, at the specified slot
> + *
> + * @param multi     the TLS context of the current instance
> + * @param ks        the state of the key being installed
> + * @param key2      the container for the raw key material
> + * @param key_direction the key direction to be used to extract the material
> + * @param ciphername    the name of the cipher to use the key with
> + * @param server    whether we are running on a server instance or not
> + *
> + * @return          0 on success or a negative error code otherwise
> + */
> +int init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
> +                    const struct key2 *key2, int key_direction,
> +                    const char *ciphername, bool server);

I think here the description might be outdated. Your method does not 
have a specified slot anymore. It would be good to document that this
method instead has a hidden that it install the primary key on the first 
call and otherwards installs/overwrites the secondary key.

> +    if (dco_disabled)
> +    {
> +        init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
> +        /* Initialize implicit IVs */
> +        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].hmac,
> +                                   MAX_HMAC_KEY_LENGTH);
> +        key_ctx_update_implicit_iv(&key->decrypt,
> +                                   key2->keys[1 - (int)server].hmac,
> +                                   MAX_HMAC_KEY_LENGTH);
> +    }
> +
> +    if (!dco_disabled)
> +    {

I think an else here would be better.

> +        /* encrypt/decrypt context are unused with DCO */

Do we have actually checked this? IIrc the generation of the explicit 
exit notification might still try to generate a data channel key and use 
these contexts.

Arne

