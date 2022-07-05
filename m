Message-ID: <0354cc34-b89e-9af6-54d4-cb1358988cc8@...2181...>
Date: Tue, 5 Jul 2022 14:38:37 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-14-a@...2181...> <9760205.XyttyQAm76@...2664...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <9760205.XyttyQAm76@...2664...>
Subject: Re: [Openvpn-devel] [PATCH 13/25] dco: implement dco support for
 p2p/client code path
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

Hi,

On 05/07/2022 14:30, Heiko Hund wrote:
> On Freitag, 24. Juni 2022 10:37:57 CEST Antonio Quartulli wrote:
>> +    /* These inet_pton conversion are fatal since options.c already
>> implements
>> +     * checks to have only valid addresses when setting the
>> options */
>> +    if (c->options.ifconfig_ipv6_remote)
>> +    {
>> +        if (inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote,
>> &remote_ip6) != 1) +        {
>> +            msg(M_FATAL,
>> +                "DCO peer init: problem converting IPv6 ifconfig remote
>> address %s to binary", +                c->options.ifconfig_ipv6_remote);
>> +        }
>> +        remote_addr6 = &remote_ip6;
>> +    }
> 
> I'm undecided if these fatal errors are justified with respect to defensive
> programming or overly paranoid, because they will never appear.

I'd say they are simply ASSERTs in disguise :-)

When a function returns an error I think it is always good habit to 
check it..then why not printing something meaningful at this point?

Cheers,


> 
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

