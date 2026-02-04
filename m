Date: Wed, 4 Feb 2026 20:46:41 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aYOiIX41affrt998@...2915...>
References: <20260204141441.528655-1-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260204141441.528655-1-ralf@...2726...>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Sorry Ralf, December and January flew by and I didn't get a chance to
dive deeper into your previous RFC patch.

2026-02-04, 15:14:41 +0100, Ralf Lici wrote:
> When processing TCP stream data in ovpn_tcp_recv, we receive large
> cloned skbs from __strp_rcv that may contain multiple coalesced packets.
> The current implementation has two bugs:
> 
> 1. Header offset overflow: Using pskb_pull with large offsets on
>    coalesced skbs causes skb->data - skb->head to exceed the u16 storage
>    of skb->network_header. This causes skb_reset_network_header to fail
>    on the inner decapsulated packet, resulting in packet drops.
> 
> 2. Unaligned protocol headers: Extracting packets from arbitrary
>    positions within the coalesced TCP stream provides no alignment
>    guarantees for the packet data causing performance penalties on
>    architectures without efficient unaligned access. Additionally,
>    openvpn's 2-byte length prefix on TCP packets causes the subsequent
>    4-byte opcode and packet ID fields to be inherently misaligned.
> 
> Fix both issues by allocating a new skb for each openvpn packet and
> using skb_copy_bits to extract only the packet content into the new
> buffer, skipping the 2-byte length prefix. Also, check the length before
> invoking the function that performs the allocation to avoid creating an
> invalid skb.
> 
> If the packet has to be forwarded to userspace the 2-byte prefix can be
> pushed to the head safely, without misalignment.
> 
> As a side effect, this approach also avoids the expensive linearization
> that pskb_pull triggers on cloned skbs with page fragments. In testing,

We don't really avoid the linearization (because
netdev_alloc_skb+skb_copy_bits is pretty much doing that) but we're
only linearizing pkt_len instead of offset + pkt_len?

> this resulted in TCP throughput improvements of up to 74%.

Wow.

[...]
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
> +	struct strp_msg *msg = strp_msg(skb);
> +	int pkt_len = msg->full_len - 2;
> +	u8 opcode;
> +
> +	/* we need at least 4 bytes of data in the packet
>  	 * to extract the opcode and the key ID later on
>  	 */
> -	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
> +	if (unlikely(pkt_len < OVPN_OPCODE_SIZE)) {
>  		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
>  				     netdev_name(peer->ovpn->dev), peer->id);
>  		goto err;
>  	}
>  
> +	/* extract the packet into a new skb */
> +	skb = ovpn_tcp_skb_packet(peer, skb, pkt_len, msg->offset + 2);
> +	if (unlikely(!skb))
> +		goto err;


err:
	/* take reference for deferred peer deletion. should never fail */
	if (WARN_ON(!ovpn_peer_hold(peer)))
		goto err_nopeer;
	schedule_work(&peer->tcp.defer_del_work);
	dev_dstats_rx_dropped(peer->ovpn->dev);

I'm thinking that we may not need to abort the connection if we failed
to allocate the new skb or copy the message, since we have a message
boundary so we can still parse the following messages out of the
stream? But we won't be able to validate that boundary since we can't
try to decrypt the packet, so maybe it's better to still abort.
(if the "don't abort" idea is wanted, it can be done at a later time,
doesn't have to be part of this patch)

> +
>  	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
>  	opcode = ovpn_opcode_from_skb(skb, 0);
>  	if (unlikely(opcode != OVPN_DATA_V2)) {
> @@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>  		/* The packet size header must be there when sending the packet
>  		 * to userspace, therefore we put it back
>  		 */
> -		skb_push(skb, 2);
> +		*((__force __be16 *)__skb_push(skb, 2)) = cpu_to_be16(pkt_len);

Why switch to __skb_push here? The skb_under_panic() would be nice in
the (unexpected) case we have an invalid skb.

Here we rely on the extra room that netdev_alloc_skb reserves
(NET_SKB_PAD) in case we have to re-push the packet length, right?
I'm a bit concerned about the silent assumptions that could lead to
writing to arbitrary addresses in memory.

>  		ovpn_tcp_to_userspace(peer, strp->sk, skb);
>  		return;
>  	}
> -- 
> 2.52.0
> 

-- 
Sabrina

