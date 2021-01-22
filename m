References: <20200825073643.15920-2-arne@...1227...>
 <20200907162221.20928-1-arne@...1227...>
 <0a0abf2e-227e-c44e-4e2e-57c59472f851@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fbddc4c1-e6bd-9696-2e3f-009e43f1d011@...1227...>
Date: Fri, 22 Jan 2021 12:19:21 +0100
MIME-Version: 1.0
In-Reply-To: <0a0abf2e-227e-c44e-4e2e-57c59472f851@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 3/5] Allow running a default
 configuration with TLS libraries without BF-CBC
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
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
>> +            init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
>> +                          options->keysize, true, true);
>> +        }
> Why do you always want to warn the user in this context?
> By passing warn=true all the time (last argument) we will have openvpn
> always warning the user about "weak cipher selected", but ciphername
> could be anything at this point.
> 

I will change the warn to be only used if the cipehr is not used for OCC
exclusively.

> 
>>          /* Initialize PRNG with config-specified digest */
>>          prng_init(options->prng_hash, options->prng_nonce_secret_len);
>>  
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 90e78a7b..01da88ad 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -3640,11 +3640,32 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
>>      {
>>          struct frame fake_frame = *frame;
>>          struct key_type fake_kt;
>> -        init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
>> -                      false);
>> +
>>          frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
>> -        crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
>> -                                       cipher_kt_mode_ofb_cfb(fake_kt.cipher));
>> +
>> +        /* o->ciphername can be still BF-CBC and our SSL library might not like
>> +         * like it, workaround this important corner case in the name of
>> +         * compatibility and not stopping openvpn on our default configuration
>> +         */
> 
> I would rephrase a bit this comment to make it more explicit for the
> casual reader. See below.
> 
>> +        if ((strcmp(o->ciphername, "BF-CBC") == 0)
>> +            && cipher_kt_get(o->ciphername) == NULL)
>> +        {
>> +            init_key_type(&fake_kt, "none", o->authname, o->keysize, true,
>> +                          false);
>> +
>> +            crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
>> +                                           cipher_kt_mode_ofb_cfb(fake_kt.cipher));
>> +            /* 64 bit block size, 64 bit IV size */
>> +            frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
>> +        }
>> +        else
>> +        {
>> +            init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
>> +                          false);
>> +
>> +            crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
>> +                                           cipher_kt_mode_ofb_cfb(fake_kt.cipher));
>> +        }
> 
> I would suggest some refactoring here.
> We can just assume that BF-CBC is not supported by the SSL library,
> while also reducing some code duplication:
> 
> const char *ciphername = o->ciphername;
> 
> ...
> 
> /* o->ciphername might be BF-CBC even though the underlying SSL library
>  * does not support it. For this reason we workaround this corner case
>  * by pretending to have no encryption enabled and by manually adding
>  * the required packet overhead to the MTU computation.
>  */
> if (strcmp(o->ciphername, "BF-CBC") == 0)
> {
>    ciphername = "none";
>    /* 64 bit block size, 64 bit IV size */
>    frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
> }

That drops the adjusting for the HMAC size.  I will add a comment to
clarify what the other lines are good for.

Arne

