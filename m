Date: Wed, 21 Jan 2026 17:53:31 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aXEEi_Nxl3nyNwkV@...2915...>
References: <20260119131400.424161-1-ralf@...2726...>
 <20260119131400.424161-3-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260119131400.424161-3-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net 3/3] ovpn: use sk_buff_head
 properly in ovpn_net_xmit
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

You're submitting this for "net" but this looks more like a clean up
that should be sent to net-next. I don't know how Antonio will handle
this, but for netdev submissions this distinction matters, see
https://docs.kernel.org/process/maintainer-netdev.html

2026-01-19, 14:14:00 +0100, Ralf Lici wrote:
> The current code builds an sk_buff_head after GSO segmentation but then
> treats it as a raw skb list: accessing elements via skb_list.next and
> breaking the list circularity by setting skb_list.prev->next to NULL.
> 
> Clean this up by changing ovpn_send to take an sk_buff_head parameter
> and use standard sk_buff_head APIs. Introduce ovpn_send_one helper to
> wrap single skbs in an sk_buff_head for ovpn_xmit_special.

Not a strong objection, but I'm not so convinced by this clean
up. Using a sk_buff_head is maybe a little bit nicer conceptually, but
it doesn't result in a code improvement, especially since you have to
add ovpn_send_one().


A few small comments on the implementation:

> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
>  drivers/net/ovpn/io.c | 74 +++++++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index c59501344d97..249751cd630b 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -329,8 +329,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>  	return true;
>  }
>  
> -/* send skb to connected peer, if any */
> -static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
> +/* send skb_list to connected peer, if any */
> +static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff_head *skb_list,
>  		      struct ovpn_peer *peer)
>  {
>  	struct sk_buff *curr, *next;
> @@ -338,7 +338,8 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
>  	/* this might be a GSO-segmented skb list: process each skb
>  	 * independently
>  	 */
> -	skb_list_walk_safe(skb, curr, next) {
> +	skb_queue_walk_safe(skb_list, curr, next) {
> +		__skb_unlink(curr, skb_list);

Why is this needed now but wasn't before?

>  		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
>  			dev_dstats_tx_dropped(ovpn->dev);
>  			kfree_skb(curr);
> @@ -368,6 +369,26 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (unlikely(!proto || skb->protocol != proto))
>  		goto drop;
>  
> +	/* retrieve peer serving the destination IP of this packet */
> +	peer = ovpn_peer_get_by_dst(ovpn, skb);
> +	if (unlikely(!peer)) {
> +		switch (skb->protocol) {
> +		case htons(ETH_P_IP):
> +			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
> +					    netdev_name(ovpn->dev),
> +					    &ip_hdr(skb)->daddr);
> +			break;
> +		case htons(ETH_P_IPV6):
> +			net_dbg_ratelimited("%s: no peer to send data to dst=%pI6c\n",
> +					    netdev_name(ovpn->dev),
> +					    &ipv6_hdr(skb)->daddr);
> +			break;
> +		}
> +		goto drop;
> +	}
> +	/* dst was needed for peer selection - it can now be dropped */
> +	skb_dst_drop(skb);

Moving this code looks like a separate clean up? Or is this needed for
the conversion to sk_buff_head?

-- 
Sabrina

