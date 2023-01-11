Message-ID: <4a1f1f0d-23e4-b2fb-1c7f-ef2fa4b26c71@...1227...>
Date: Wed, 11 Jan 2023 12:02:14 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221127142506.41986-1-frank@...2641...>
 <aff02522-a3f8-e080-054a-8f795ae10e7a@...1227...>
 <Y5xuhFRq15H3NSgv@...2685...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y5xuhFRq15H3NSgv@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] options: Always define
 options->management_flags
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Am 16.12.22 um 14:11 schrieb Frank Lichtenheld:
> On Mon, Dec 12, 2022 at 12:38:41PM +0100, Arne Schwabe wrote:
>> Am 27.11.22 um 15:25 schrieb Frank Lichtenheld:
>>> That makes it possible to remove several preprocessor
>>> directives which is a good thing. The cost should be
>>> negligible.
>>
>> Acked-By: Arne Schwabe <arne@...1227...>
>>
>> In general the commit looks good but I would like to improve the comment for
>> the management flags (see below).
>>
>>
>>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>>> index 68ad0cac..6f4b1f4a 100644
>>> --- a/src/openvpn/options.h
>>> +++ b/src/openvpn/options.h
>>> @@ -438,10 +438,12 @@ struct options
>>>        const char *management_client_user;
>>>        const char *management_client_group;
>>> -    /* Mask of MF_ values of manage.h */
>>> -    unsigned int management_flags;
>>>        const char *management_certificate;
>>>    #endif
>>> +    /* Mask of MF_ values of manage.h
>>> +     * Always available to simplify options.c
>>> +     */
>>> +    unsigned int management_flags;
>>
>> This feels a bit odd as a comment. I would expect this in the commit or
>> something like "even available when management support is not available" but
>> this comment feels a bit too "temporary".
> 
> How is this "temporary"? It does not describe the change, it actually states
> why this is handled specially. Your proposal just drops the justification, then
> the comment becomes useless IMHO.
> 
> Would you prefer "Always available to simplify option verification code"?

I feel this because it is always available to avoid ifdefs and therefore 
to simplify options.c but the information that ifdefs are the 
alternative is not obvious from the comment or code alone. We have a lot 
of other variables that are always available but are only used if 
certain compile options are used. So I feel this comment is temporary 
because it basically is from the history that here in this case we had 
ifdefs, so we added here now a comment that there now no longer ifdefs. 
But in general without the historical context the comment feels odd to me.

Arne


