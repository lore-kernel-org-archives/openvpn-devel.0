Message-ID: <dca91e77-175c-9540-7993-112ca7a4661b@...2181...>
Date: Mon, 19 Sep 2022 00:29:20 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220917231030.22565-1-a@...2181...>
 <Yyb07u4pG0Ii9vQf@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Yyb07u4pG0Ii9vQf@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] implement --session-timeout
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
To: Gert Doering <gert@...1296...>
Cc: Dmitry Zelenkovsky <Dmitry.Zelenkovskiy@...1719...>, openvpn-devel@lists.sourceforge.net



On 18/09/2022 12:37, Gert Doering wrote:
> HI,
> 
> On Sun, Sep 18, 2022 at 01:10:30AM +0200, Antonio Quartulli wrote:
>> From: Dmitry Zelenkovsky <Dmitry.Zelenkovskiy@...1719...>
>>
>> Disconnect clients after session-timeout expires.
>> session-timeout can be defined in ccd files in order to limit
>> per-user connection time.
> 
> I find this implementation needlessly complicated.
> 
>> +/*
>> + * Should we exit due to session timeout?
>> + */
>> +static void
>> +check_session_timeout(struct context *c)
>> +{
>> +    if (c->options.session_timeout
>> +        && event_timeout_trigger(&c->c2.session_interval, &c->c2.timeval,
>> +                                 ETT_DEFAULT))
>> +    {
>> +        msg(M_INFO, "Session timeout, exiting");
>> +        register_signal(c, SIGTERM, "session-timeout");
>> +    }
>> +}
> 
> Why are we working with event triggers here, if all we *want* to do is
> a single-shot
> 
>   if ( now > $somectx->session_must_end_at_this_time )
>   {
>        /* kick out this user now */
>        ...
>   }
> 

we don't get here at all, if we have no event object that is timing out.
So, although one shot, we still need to setup a timer object that will 
trigger the machinery upon timeout.

>> +    else if (streq(p[0], "session-timeout") && p[1] && !p[2])
>> +    {
>> +        VERIFY_PERMISSION(OPT_P_TIMER);
> 
> OPT_P_INSTANCE?

makes sense to add OPT_P_INSTANCE, although I wonder why other 
activity/timeout knobs are not marks as such, i.e. --inactivity)

Cheers,

> 
> gert
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli

