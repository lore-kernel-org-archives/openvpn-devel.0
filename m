Date: Thu, 29 Jan 2026 12:16:52 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aXtBpNaxSVkl9t2G@...2915...>
References: <20260128124410.429529-1-ralf@...2726...>
 <20260128124410.429529-2-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260128124410.429529-2-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 2/3] ovpn: fix possible
 use-after-free in ovpn_net_xmit
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

2026-01-28, 13:44:09 +0100, Ralf Lici wrote:
> During GSO fragmentation, skb_share_check may clone the first segment
> and free the original skb. The current implementation continues to use
> the stale skb pointer for peer lookup.
> 
> Fix this by updating the skb variable to point to the new head of the
> segment list after the processing loop. Additionally, return early if
> all segments were dropped during the loop to avoid double-counting
> statistics and double-freeing memory in the drop path.
> 
> Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
> Changes since v1
> - this is a new patch that replaces the previous "ovpn: use sk_buff_head
>   properly in ovpn_net_xmit"
> 
>  drivers/net/ovpn/io.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 3e9e7f8444b3..95c3518e067c 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -396,6 +396,17 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		__skb_queue_tail(&skb_list, curr);
>  	}
> +
> +	/* no segments survived: don't jump to 'drop' because we already
> +	 * incremented the counter for each failure in the loop
> +	 */
> +	if (unlikely(skb_queue_empty(&skb_list)))
> +		return NETDEV_TX_OK;
> +
> +	/* the original 'skb' might have been freed/cloned in the loop: use the
> +	 * first element of our list for the other operations
> +	 */
> +	skb = skb_list.next;
>  	skb_list.prev->next = NULL;
>  
>  	/* retrieve peer serving the destination IP of this packet */

This patch looks ok, but maybe it would be better to fix this using a
chunk of your sk_buff_head rework instead. I think all segments
produced by skb_gso_segment will have a dst attached
(__copy_skb_header(nskb, head_skb) in skb_segment), so the
skb_dst_drop after peer selection will only affect the first segment,
and not the others. Doing peer selection + skb_dst_drop before calling
skb_gso_segment would solve this as well as the UAF.

(your current patch would also avoid a UAF on ovpn_peer_stats_increment_tx,
but you're solving that in the next patch)

-- 
Sabrina

