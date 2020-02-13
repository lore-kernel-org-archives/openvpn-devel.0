From: Arne Schwabe <arne@...1227...>
References: <20191117181243.28919-1-arne@...1227...>
 <20191117181243.28919-4-arne@...1227...>
 <CAGyAFMWAkAFSYcoG=WTs6atyQAbx=v71rU6ZO1y=bV-2rt0n_w@...278...>
Message-ID: <8820628a-f647-3f35-fea0-b1756edeaeb2@...1227...>
Date: Thu, 13 Feb 2020 15:14:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMWAkAFSYcoG=WTs6atyQAbx=v71rU6ZO1y=bV-2rt0n_w@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 4/4] Normalise ncp-ciphers option and
 restrict it to 127 bytes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 13.02.20 um 13:34 schrieb Lev Stipakov:
> Hi,
> 
> su 17. marrask. 2019 klo 20.13 Arne Schwabe (arne@...1227...
> <mailto:arne@...1227...>) kirjoitti:
>>
>> -        if (!cipher_kt_get(translate_cipher_name_from_openvpn(token)))
>> +        /* translate_cipher_name_from_openvpn also normalises the
> cipher name,
>> +         * e.g. replacing AeS-128-gCm with AES-128-GCM
>> +         */
> 
> I think this comment is a bit misleading -
>  translate_cipher_name_from_openvpn()
> translates openvpn cipher name (value in --ncp-ciphers) to crypto
> library cipher name,
> for example from "aES-256-GCM" to "idaes_256_GCM" which contradicts the
> comment.
> 

Will update the comment.

> Maybe we could factor this code out into separate
> normalize_cipher_name() function, which
> 
>  - translates (possibly non-normalized) openvpn cipher name into
> cryptolib cipher name
>  - translates crypto cipher name back to openvpn cipher name, this time
> normalized


Hm, it would be only used here and make error handling more complicated,
so I think we should just stick with the two functions.

>> +        if (!ktc)
>>          {
>>              msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s",
> token);
>> -            unsupported_cipher_found = true;
>> +            error_found = true;
> 
> It seems that mutate_ncp_cipher_list() returns NULL if error_found is
> true. Maybe we could goto
> out of the loop? The label could be added before free() calls.

Yes. But I found that less user friendly. The approach here will give
you an error for every unsupported cipher. Otherwise you get only an
error for the first unsupported cipher.


>> +            if (buf_len(&new_list)> 0)
>> +            {
>> +                /* The next if condition ensure there is always space for
>> +                 * a :
>> +                 */
>> +                buf_puts(&new_list, ":");
>> +            }
>> +
>> +            /* Ensure buffer has capacity for cipher name + : + \0 */
>> +            if (!(buf_forward_capacity(&new_list) >
>> +                  strlen(ovpn_cipher_name) + 2))
> 
> This doesn't handle the case when buffer capacity is just enough
> to fit the last cipher - for that it is enough to fit cipher name and \0.
> Could we move
> 
>   >          token = strtok(NULL, ":");
> 
> here and do something like
> 
>   /* for the last cipher, token is NULL, enough to fit cipher and \0 */
>   strlen(ovpn_cipher_name) + (token ? 2 : 1);
> 
>> +            {
>> +                msg(M_WARN, "Length of --ncp-ciphers is over the"
>> +                    "limit of 127 chars");
>> +                error_found = true;


I don't think this worth fixing. If you are close or at the 127 char
limit then your cipher list is too long anyway. That we might bail out
at 126 char is acceptable. I rather prefer the simple code here.


Arne

