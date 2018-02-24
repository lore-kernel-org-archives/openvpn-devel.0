References: <20180102222002.21454-1-steffan@...1856...>
 <20180102222854.29198-1-steffan@...1856...>
 <CAKuzo_gmd62oK5_VsAi5c-XMCXOzyb9EMAA-sHtvY6Lx0NOpOg@...278...>
 <CAKuzo_h-_JXxPnTtSTyqzR4nDnfWZ-M1px7gJNjeDNH2oUgN2A@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <cc39fbc4-998d-7e4a-204a-f621e6f8dc87@...1856...>
Date: Sat, 24 Feb 2018 15:07:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h-_JXxPnTtSTyqzR4nDnfWZ-M1px7gJNjeDNH2oUgN2A@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Check for time_t overflow in
 event_timeout_trigger()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On 23-02-18 00:02, Selva Nair wrote:
> On Thu, Feb 22, 2018 at 5:37 PM, Selva Nair <selva.nair@...277...> wrote:
>>> +/** Return true if the addition of a and b would overflow. */
>>> +static inline bool
>>> +time_t_add_overflow(time_t a, time_t b) {
>>> +    static_assert(((time_t) -1) < 0, "OpenVPN assumes time_t is signed");
>>> +    static_assert(((time_t) .9) == 0, "OpenVPN assumes time_t is integer type");
>>> +    static_assert(sizeof(time_t) == sizeof(long) || sizeof(time_t) == sizeof(long long),
>>> +        "OpenVPN assumes that time_t is of type long int or long long int");
>>> +    static const time_t TIME_MAX = sizeof(time_t) == sizeof(long) ?
>>> +            LONG_MAX : LLONG_MAX;
>>> +    static const time_t TIME_MIN = sizeof(time_t) == sizeof(long) ?
>>> +            LONG_MIN : LLONG_MIN;
>>> +    return (a > 0 && b > TIME_MAX - a) || (a < 0 && b < TIME_MIN - a);
>>
>> Interesting. But I think this can be simplified much. Addition of
>> identically sized integers a and b overflows if and only if
>>
>> ((a > 0 && a + b < b) || (a < 0 && a + b > b))
>>
>> As overflow is possible only when both have same sign it can also be written as
>>
>> ((a > 0 && a + b < a) || (a < 0 && a + b > a))
>>
>> So the TIME_MAX and TIME_MIN may be eliminated and that means no need
>> to check signed/unsigned or long/long-long.
>>
>> Am I missing something?
> 
> Hm... replying to self: I suppose the worry is related to unsigned int
> arithmetic overflow being undefined behaviour in C. So potentially a
> compiler can treat those statements as always true if it wishes..
> 
> Well, excuse the noise I caused then.

Yeah, at least, *signed* integer overflow is undefined, and time_t is
(usually) a signed type.

-Steffan

