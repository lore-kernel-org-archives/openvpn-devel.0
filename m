Message-ID: <09c8b16b-f3cc-40da-279f-8ff704393d3b@...2181...>
Date: Wed, 17 May 2023 23:14:43 +0200
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
 <CAFHpkQER6g7MPu07_0TbKnnvc6poGsD2nZqLyATFXQN4JwiseQ@...278...>
 <DEA80ADA-574E-431E-A61E-89F4840AD9AF@...1376...>
 <CAFHpkQFUYAbi=XPer39VshqN=Qcbcatcg1FGLpLHmxcKYKKDRA@...278...>
 <4C50099D-11A0-4BE2-8E88-8E9C1327519B@...1376...>
Content-Language: en-US
In-Reply-To: <4C50099D-11A0-4BE2-8E88-8E9C1327519B@...1376...>
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Kristof Provost <kp@...1376...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC4?= =?UTF-8?B?0L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 17/05/2023 23:10, Kristof Provost wrote:
> On 17 May 2023, at 17:06, Илья Шипицин wrote:
>> ср, 17 мая 2023 г. в 23:04, Kristof Provost <kp@...1249...>:
>>
>>> On 17 May 2023, at 16:58, Илья Шипицин wrote:
>>>> ср, 17 мая 2023 г. в 22:43, Kristof Provost <kp@...1249...>:
>>>>
>>>>> On 17 May 2023, at 16:01, Ilya Shipitsin wrote:
>>>>>> malloc was not checked against NULL, I was able
>>>>>> to get core dump in case of failure
>>>>>>
>>>>>> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
>>>>>> ---
>>>>>>   src/openvpn/dco_freebsd.c | 5 +++++
>>>>>>   1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
>>>>>> index 1111abeb..adbd1120 100644
>>>>>> --- a/src/openvpn/dco_freebsd.c
>>>>>> +++ b/src/openvpn/dco_freebsd.c
>>>>>> @@ -594,6 +594,11 @@ dco_available(int msglevel)
>>>>>>       }
>>>>>>
>>>>>>       buf = malloc(ifcr.ifcr_total * IFNAMSIZ);
>>>>>> +    if (buf == NULL)
>>>>>> +    {
>>>>>
>>>>> I’d ‘goto out;’ instead, because that’s how we handle other errors in
>>> this
>>>>> function.
>>>>> (free(NULL) is guaranteed to be safe, so we can just do that.)
>>>>>
>>>>
>>>> on "goto out" we'll end with "return available;"
>>>>
>>> ‘available’ defaults to ‘false’, so that seems fine to me.
>>>
>>
>> looks fragile :)
>>
>> I do not see benefits of such an approach. But it will work indeed
>>
> The reasoning is that it keeps the error handing consistent. If we ever extend the function to e.g. open another file descriptor we’d only have to change the error handling in one location.
> 
> We’re not adding new ways for the function to fail either. The next potential error is the ioctl() call, where we do exactly the same thing (i.e. goto out) on error, so it already relies on available being set to false.
> 

I agree on this style too.

Should we require more clean up work in the future, we can just add 
extra lines right after the out label (with the appropriate checks, of 
course), thus keeping error handling in one place.

Cheers,

> Best regards,
> Kristof
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli

-- 
Antonio Quartulli

