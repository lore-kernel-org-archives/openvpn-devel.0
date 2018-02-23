References: <20171202162453.29838-1-a@...2181...>
 <20171202162453.29838-2-a@...2181...>
 <df3fcdd1-7d42-0de5-c8c1-568f297381f4@...1227...>
 <2e39cd09-fbf6-18b3-c559-c7200e99043c@...2181...>
From: fragmentux <fragmentux@...277...>
Message-ID: <7f0adbeb-5742-7cc6-51c4-9638f233f5a0@...277...>
Date: Fri, 23 Feb 2018 17:53:52 +0000
MIME-Version: 1.0
In-Reply-To: <2e39cd09-fbf6-18b3-c559-c7200e99043c@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] PF: never drop essential ICMPv6
 packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

any chance this can be moved forward ?

I have tested a server on Windows 10 and Linux (Various)
and it all appears to work ok.

The question below appears to be an outstanding issue.

Thanks


On 02/12/17 16:49, Antonio Quartulli wrote:
> 
> 
> On 03/12/17 00:47, Arne Schwabe wrote:
>> Am 02.12.17 um 17:24 schrieb Antonio Quartulli:
>>> Some ICMPv6 packets can't be dropped otherwise the entire
>>> overlaying network layer (IPv6) would just stop working.
>>>
>>> Such packets are described in RFC4890, sec. 4.4.1.
>>>
>>> Improve the mroute packet parsing routine in order to detect
>>> these specific packets types and thus avoid PF to drop them.
>>>
>>> This way, when PF is enabled, the user won't need to whitelist
>>> any specific multicats IPv6 address. PF will just work as
>>> expected.
>>
>>   (&b);
>>> +
>>> +    switch (type)
>>> +    {
>>> +        /*
>>> +         * By following the guideline of RFC4890, sec. 4.4.1, the
>>> +         * following are the ICMPv6 packet types that are strictly
>>> +         * required to let a host join a IPv6 network.
>>> +         * Therefore, such packets can't be dropped by PF.
>>> +         */
>>> +        case OPENVPN_ND_ROUTER_SOLICIT:
>>> +        case OPENVPN_ND_ROUTER_ADVERT:
>>> +        case OPENVPN_ND_NEIGHBOR_SOLICIT:
>>> +        case OPENVPN_ND_NEIGHBOR_ADVERT:
>>> +        case OPENVPN_ND_INVERSE_SOLICIT:
>>> +        case OPENVPN_ND_INVERSE_ADVERT:
>>> +            return true;
>>> +    }
>>> +    return false;
>>> +}
>>
>>
>> I think we should still drop tehse if they do not target the local
>> network. Otherwise you can just send all information hidden in these
>> packet types.
> 
> You mean dropping packets not a having link-local address as destination
> (for unicasts)?
> 



