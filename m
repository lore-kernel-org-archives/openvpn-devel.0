Message-ID: <f2b3c121-6bca-45f7-876d-f9a88d66b5e1@...2181...>
Date: Thu, 5 Feb 2026 14:42:33 +0100
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
References: <20260204141441.528655-1-ralf@...2726...>
 <aYOiIX41affrt998@...2915...> <1ed2def1-a853-4a35-ac2b-5906604bff93@...2181...>
 <aYR0AuC6jd7XSje5@...2915...>
Content-Language: en-US
In-Reply-To: <aYR0AuC6jd7XSje5@...2915...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net] ovpn: tcp - fix packet
 extraction from stream
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
To: Sabrina Dubroca <sd@...2891...>, Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

On 05/02/2026 11:42, Sabrina Dubroca wrote:
> 2026-02-04, 23:42:31 +0100, Antonio Quartulli wrote:
>>>> @@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>>>>    		/* The packet size header must be there when sending the packet
>>>>    		 * to userspace, therefore we put it back
>>>>    		 */
>>>> -		skb_push(skb, 2);
>>>> +		*((__force __be16 *)__skb_push(skb, 2)) = cpu_to_be16(pkt_len);
>>>
>>> Why switch to __skb_push here? The skb_under_panic() would be nice in
>>> the (unexpected) case we have an invalid skb.
>>>
>>
>> We just created the skb, so it should be safe to assume that the skb is
>> valid, no?
> 
> I meant invalid in the sense of "not having the expected room to push
> the header".
> 
>>> Here we rely on the extra room that netdev_alloc_skb reserves
>>> (NET_SKB_PAD) in case we have to re-push the packet length, right?
>>
>> The comment at https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/skbuff.h#L3282
>> about NET_SKB_PAD seems to suggest that this is actual headroom that
>> networking drivers can assume to have, no?
> 
> I guess so. But I'd feel a bit safer if we had something enforcing
> that at least this push can't fail, more as a guarantee against an
> accidental code change in ovpn. But maybe we'd have bigger problems
> through the rest of the stack if ovpn skbs get bridged/forwarded and
> we don't have all that headroom.

Exactly my thought. If this assumption doesn't hold anymore, more things 
are going to break.
(I expect also other mechanisms outside ovpn to be affected)

On top of that, we ovpn_tcp_send_skb() basically relying on the same 
assumption already.
Therefore, I'd just stick with the current version.

However, I have a little nitpick: Ralf, please use the same style as the 
assignment in ovpn_tcp_send_skb(), for consistency:

584         *(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);

Regards,

> 
>> And it should never be less than 32 bytes.
>>
>>
>> Regards,
> 

-- 
Antonio Quartulli


