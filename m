Message-ID: <1ed2def1-a853-4a35-ac2b-5906604bff93@...2181...>
Date: Wed, 4 Feb 2026 23:42:31 +0100
MIME-Version: 1.0
References: <20260204141441.528655-1-ralf@...2726...>
 <aYOiIX41affrt998@...2915...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <aYOiIX41affrt998@...2915...>
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

Hi Sabrina!

On 04/02/2026 20:46, Sabrina Dubroca wrote:
>> this resulted in TCP throughput improvements of up to 74%.
> 
> Wow.

I was also astonished by this result!

Actually Ralf tested various options (i.e. netdev_alloc_skb vs 
pskb_extract, on all skbs vs on large ones only) and this solution 
turned to be the one giving the highest boost.

In my tests yesterday, TCP jumped from ~4.3Gbps to ~7.3Gbps after 
applying this patch, which is the same throughput I am getting over UDP!


> 
> [...]
>> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>> +{
>> +	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
>> +	struct strp_msg *msg = strp_msg(skb);
>> +	int pkt_len = msg->full_len - 2;
>> +	u8 opcode;
>> +
>> +	/* we need at least 4 bytes of data in the packet
>>   	 * to extract the opcode and the key ID later on
>>   	 */
>> -	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
>> +	if (unlikely(pkt_len < OVPN_OPCODE_SIZE)) {
>>   		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
>>   				     netdev_name(peer->ovpn->dev), peer->id);
>>   		goto err;
>>   	}
>>   
>> +	/* extract the packet into a new skb */
>> +	skb = ovpn_tcp_skb_packet(peer, skb, pkt_len, msg->offset + 2);
>> +	if (unlikely(!skb))
>> +		goto err;
> 
> 
> err:
> 	/* take reference for deferred peer deletion. should never fail */
> 	if (WARN_ON(!ovpn_peer_hold(peer)))
> 		goto err_nopeer;
> 	schedule_work(&peer->tcp.defer_del_work);
> 	dev_dstats_rx_dropped(peer->ovpn->dev);
> 
> I'm thinking that we may not need to abort the connection if we failed
> to allocate the new skb or copy the message, since we have a message
> boundary so we can still parse the following messages out of the
> stream? But we won't be able to validate that boundary since we can't
> try to decrypt the packet, so maybe it's better to still abort.
> (if the "don't abort" idea is wanted, it can be done at a later time,
> doesn't have to be part of this patch)



> 
>> +
>>   	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
>>   	opcode = ovpn_opcode_from_skb(skb, 0);
>>   	if (unlikely(opcode != OVPN_DATA_V2)) {
>> @@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>>   		/* The packet size header must be there when sending the packet
>>   		 * to userspace, therefore we put it back
>>   		 */
>> -		skb_push(skb, 2);
>> +		*((__force __be16 *)__skb_push(skb, 2)) = cpu_to_be16(pkt_len);
> 
> Why switch to __skb_push here? The skb_under_panic() would be nice in
> the (unexpected) case we have an invalid skb.
> 

We just created the skb, so it should be safe to assume that the skb is 
valid, no?

> Here we rely on the extra room that netdev_alloc_skb reserves
> (NET_SKB_PAD) in case we have to re-push the packet length, right?

The comment at 
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/skbuff.h#L3282 
about NET_SKB_PAD seems to suggest that this is actual headroom that 
networking drivers can assume to have, no?
And it should never be less than 32 bytes.


Regards,

> I'm a bit concerned about the silent assumptions that could lead to
> writing to arbitrary addresses in memory.
> 
>>   		ovpn_tcp_to_userspace(peer, strp->sk, skb);
>>   		return;
>>   	}
>> -- 
>> 2.52.0
>>
> 

-- 
Antonio Quartulli


