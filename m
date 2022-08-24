Message-ID: <8e8cb534-445d-2f4f-c991-bc0e93175961@...1227...>
Date: Wed, 24 Aug 2022 14:56:49 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-4-arne@...1227...> <2695184.KalutWefUj@...2664...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <2695184.KalutWefUj@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/4] Implement AUTH_FAIL,
 TEMP message support
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


>> diff --git a/doc/man-sections/script-options.rst
> 
> This is more related to 4/4 and should go there for code archaeology reasons.
> 
>> +    /* the server can suggest a backoff time to the client, it
>> +     * will still be capped by the max timeout between connections
>> +     * (300s by default) */
>> +    int server_backoff_time;
> 
> This should be (parsed as) an unsigned value. Negative backup requires too
> advanced physics. ;-)

*All* other connect related settings (connect_retry_seconds, 
connect_retry_seconds_max, connect_timeout, ...) are int. Making this
single one unsigned int means mixing integer types and having to cast
one parameter of max_int(a, b), so I would rather be consistent in 
having all the same type.


> 
>> +++ b/src/openvpn/options_util.h
>> \ No newline at end of file
> 
> Again

uncrustify does not complain about that. Will add manually

> 
>> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
>> index 1c4e637e4..3b3dce642 100644
>> --- a/src/openvpn/push.c
>> +++ b/src/openvpn/push.c
>> @@ -51,7 +52,6 @@ void
>>   receive_auth_failed(struct context *c, const struct buffer *buffer)
>>   {
>>       msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
>> -    c->options.no_advance = true;
>>
>>       if (!c->options.pull)
>>       {
> 
> I think we want to keep this as the default. If I read the code correctly, at
> the moment the default behavior is "advance addr" if none is given, which feel
> wrong to me, given what I have read about the feature.
> 

That looks like a mistake

Arne


