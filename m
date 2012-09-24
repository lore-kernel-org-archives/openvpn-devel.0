Message-ID: <50609C69.8090900@...1769...>
Date: Mon, 24 Sep 2012 19:46:17 +0200
From: Krzysztof Witek <netdev@...1769...>
MIME-Version: 1.0
References: <50609652.1060609@...1769...>
	<E1TGCQK-0000Iw-C3@...1770...>
	<506098B4.2040809@...1769...>
In-Reply-To: <506098B4.2040809@...1769...>
Subject: Re: [Openvpn-devel] [PATCH] fix sending udp datagrams from wrong ip
 address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/24/2012 07:30 PM, Krzysztof Witek wrote:
> On 09/24/2012 07:28 PM, Davide Brini wrote:
>> On Mon, 24 Sep 2012 19:20:18 +0200, Krzysztof Witek <netdev@...1769...> wrote:
>>
>>> From: Krzysztof Witek <krzysztof@...1769...>
>>>
>>> If multiple ip addresses of the same subnet are configured on an
>>> interface, openvpn may not send udp datagrams to the peer
>>> using the correct source ip address.
>>>
>>> If a host sends the udp datagrams to the ip address A, then it
>>> should receive the answer from A even if the its peer has multiple
>>> ip addresses and the default routing selects a different one.
>>>
>>> The issue can be reproduced with the following scenario:
>>>
>>> Host A is connected to two gateways each on the same subnet:
>>> gw1 with ip address 10.0.0.254
>>> gw2 with ip address 10.0.0.253
>>>
>>> Host A has two ip addresses: 10.0.0.1 and 10.0.0.2.
>>> It receives DNAT-ed traffic from gw1 via 10.0.0.1
>>> and DNAT-ed traffic from gw2 via 10.0.0.2.
>>>
>>> Two ip rules are set up on the host A:
>>> ip rule add from 10.0.0.1 table 1
>>> ip rule add from 10.0.0.2 table 2
>>>
>>> and three default routes:
>>> ip route add default via 10.0.0.254 table 1
>>> ip route add default via 10.0.0.253 table 2
>>> ip route add default via 10.0.0.254
>>>
>>> This way all traffic from 10.0.0.1 will go via 10.0.0.254
>>> and all traffic from 10.0.0.2 will go via 10.0.0.253.
>>>
>>> The current openvpn server doesn't work if it receives a connection
>>> from the router gw2 because it will send its udp datagrams via gw1.
>>>
>>> Saving the destination ip address on which the udp datagram arrived and
>>> then using it as the source ip address solves this issue.
>> I haven't checked, but doesn't --multihome work in this case?
>>
> no, it doesn't seem to work
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
sorry, checked with a wrong version, it does work with --multihome
the patch can be dropped
thanks

