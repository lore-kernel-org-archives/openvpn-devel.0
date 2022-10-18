Message-ID: <58fd1437-c75d-fb04-b9fe-224e69d44cf6@...1227...>
Date: Tue, 18 Oct 2022 12:28:31 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220909195902.2011798-1-arne@...1227...>
 <20220909195902.2011798-3-arne@...1227...> <1919509.yKVeVyVuyW@...2664...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <1919509.yKVeVyVuyW@...2664...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Introduce dynamic tls-crypt for
 secure soft_reset/session renegotiation
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net


> 
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -8553,6 +8553,10 @@ add_option(struct options *options,
>>               {
>>                   options->imported_protocol_flags |=
>> CO_USE_TLS_KEY_MATERIAL_EXPORT; }
>> +            else if (streq(p[j], "secure-renog"))
> 
> Should be rewritten to use --protocol-flags instead.

It is already using protocol-flags. That is in the middle of 
protocol-flags in options.c

>>
>>       tls_crypt_v2_load_client_key(key, &key2, false);
>> -    secure_memzero(&key2, sizeof(key2));
>> +    *original_key = key2;
> 
> We should do the zeroing in tls_session_generate_secure_renegotiation_key()
> shortly after we used it to XOR then. And maybe only delay it if we need to
> XOR anyways, could use original_key == NULL as indication.

We cannot do that. The reason is that a client might reconnect to the 
same session (using the TM_UNTRUSTED session slot) or if we have a 
simple reconnect. And after the reconnect we need to calculate a new 
key. And anyway the data is memory anyway just implicit in the OpenSSL 
data structure (tls_wrap.opt.key_ctx_bi) that holds the HMAC/encryption 
key for the session just not explicitly.

> 
>> @@ -587,8 +655,8 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
>>       ctx->cleanup_key_ctx = true;
>>       ctx->opt.flags |= CO_PACKET_ID_LONG_FORM;
>>       memset(&ctx->opt.key_ctx_bi, 0, sizeof(ctx->opt.key_ctx_bi));
>> -    tls_crypt_v2_load_client_key(&ctx->opt.key_ctx_bi, &client_key, true);
>> -    secure_memzero(&client_key, sizeof(client_key));
>> +    tls_crypt_v2_load_client_key(&ctx->opt.key_ctx_bi,
>> +                                 &ctx->original_tlscrypt_keydata, true);
> 
> Same as above for the server side. Could zero here immediately if
> original_tlscrypt_keydata == NULL
> 

If we zero the key here, it will not be available when we want to 
calculate the secure renegotiation key with xor.

Arne

