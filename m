Message-ID: <7ace9b86-f8c6-159e-d4a8-70e2fa44406f@...2181...>
Date: Fri, 8 Apr 2022 13:25:40 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220330205536.139-1-timo@...2669...>
 <20220407184023.249-1-timo@...2669...>
 <YlAB9NJWMd9H/EUg@...1296...>
 <69699e39-4257-2598-4b56-55ff6526fd18@...2669...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <69699e39-4257-2598-4b56-55ff6526fd18@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v3] platform: Retain CAP_NET_ADMIN when
 dropping privileges
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
To: Timo Rothenpieler <timo@...2669...>, Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/04/2022 13:18, Timo Rothenpieler wrote:
>> This one does not really look like it should be in "fallback:" - because
>> that way it always gets called, even if we jump there right at function
>> entry, if keep_caps == 0.
> 
> No, it's intentional. It ensures that it's printed even if we don't 
> HAVE_LIBCAPNG but someone called the function requesting to keep 
> capabilities, which is not possible then.

Along Gert's thoughts: maybe there should be 2 labels, one that is just 
"out" and one that is "fallback".

Simply because jumping to "fallback" when it was not requested to retain 
capabilities (keep_caps == 0) may not sound right (are we really falling 
back in this case?)

Cheers,

> 
>>> +
>>> +    if (keep_caps)
>>> +    {
>>> +        msg(err_flags, "Unable to retain capabilities");
>>> +    }
>>> +
>>> +    platform_group_set(group_state);
>>> +    platform_user_set(user_state);
>>> +}
>>> +
>>
>> Maybe "fallback:" should be right before platform_group_set()?
>>
>>
>> (Sorry for being late to the "complain about your code" party...)
>>
>> gert
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

