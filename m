Date: Mon, 26 Jan 2026 16:48:45 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aXeM3flINLwElheF@...2915...>
References: <20260119131400.424161-1-ralf@...2726...>
 <20260119131400.424161-3-ralf@...2726...>
 <aXEEi_Nxl3nyNwkV@...2915...>
 <b8f0ca93f2f242bfccc0ae1627ac71dea91b242d.camel@...2726...>
MIME-Version: 1.0
In-Reply-To: <b8f0ca93f2f242bfccc0ae1627ac71dea91b242d.camel@...2726...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

2026-01-22, 13:48:11 +0100, Ralf Lici wrote:
> On Wed, 2026-01-21 at 17:53 +0100, Sabrina Dubroca wrote:
> > You're submitting this for "net" but this looks more like a clean up
> > that should be sent to net-next. I don't know how Antonio will handle
> > this, but for netdev submissions this distinction matters, see
> > https://docs.kernel.org/process/maintainer-netdev.html
> 
> I think you are right. I initially considered this a fix, but I agree
> it's more appropriate for net-next. I'll leave it to Antonio to place it
> in the right PR.
> 
> > 2026-01-19, 14:14:00 +0100, Ralf Lici wrote:
> > > The current code builds an sk_buff_head after GSO segmentation but
> > > then
> > > treats it as a raw skb list: accessing elements via skb_list.next
> > > and
> > > breaking the list circularity by setting skb_list.prev->next to
> > > NULL.
> > > 
> > > Clean this up by changing ovpn_send to take an sk_buff_head
> > > parameter
> > > and use standard sk_buff_head APIs. Introduce ovpn_send_one helper
> > > to
> > > wrap single skbs in an sk_buff_head for ovpn_xmit_special.
> > 
> > Not a strong objection, but I'm not so convinced by this clean
> > up. Using a sk_buff_head is maybe a little bit nicer conceptually, but
> > it doesn't result in a code improvement, especially since you have to
> > add ovpn_send_one().
> > 
> 
> I agree this adds a small helper, but what motivated this change is that
> the current usage of sk_buff_head in ovpn_net_xmit looks a bit like a
> hack or an API violation. In the current code, we build an sk_buff_head
> but then manually break the ring (skb_list.prev->next = NULL) to treat
> it as a raw singly linked chain.

I'd say we're building a skb list and happen to use an sk_buff_head to
make it easier. So I'm not really convinced by the benefit of this
patch.

> This relies on implementation details
> rather than the API. Even though we do not (and likely will not) need
> the circularity, staying within the API feels safer and more
> maintainable.
> 
> Also, the overhead added by ovpn_send_one should be negligible, since it
> is only used for keepalives.

Sure, my comment was more about code simplicity than runtime overhead.

> Hopefully that makes sense.
>  
> 
> > A few small comments on the implementation:
> > 
> > > Signed-off-by: Ralf Lici <ralf@...2726...>
> > > ---
> > >  drivers/net/ovpn/io.c | 74 +++++++++++++++++++++++++++-------------
> > > ---
> > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > > index c59501344d97..249751cd630b 100644
> > > --- a/drivers/net/ovpn/io.c
> > > +++ b/drivers/net/ovpn/io.c
> > > @@ -329,8 +329,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer
> > > *peer, struct sk_buff *skb)
> > >  	return true;
> > >  }
> > >  
> > > -/* send skb to connected peer, if any */
> > > -static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
> > > +/* send skb_list to connected peer, if any */
> > > +static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff_head
> > > *skb_list,
> > >  		      struct ovpn_peer *peer)
> > >  {
> > >  	struct sk_buff *curr, *next;
> > > @@ -338,7 +338,8 @@ static void ovpn_send(struct ovpn_priv *ovpn,
> > > struct sk_buff *skb,
> > >  	/* this might be a GSO-segmented skb list: process each skb
> > >  	 * independently
> > >  	 */
> > > -	skb_list_walk_safe(skb, curr, next) {
> > > +	skb_queue_walk_safe(skb_list, curr, next) {
> > > +		__skb_unlink(curr, skb_list);
> > 
> > Why is this needed now but wasn't before?
> 
> Since the new code aims to use skb_list as a proper circular doubly
> linked list and to comply with the sk_buff_head API, the unlinking is
> necessary to maintain a valid skb_list while processing each of its
> elements. This also seems to be a common pattern throughout the kernel.
> 
> It is true, though, that after ovpn_send we do not use skb_list anymore,
> so this is not strictly necessary. Let me know if you think I should
> remove it.

If the aim is to properly use the sk_buff_head API, then I guess it
makes sense.

The skb_mark_not_on_list() call in ovpn_encrypt_post is not needed
anymore.

> > >  		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
> > >  			dev_dstats_tx_dropped(ovpn->dev);
> > >  			kfree_skb(curr);
> > > @@ -368,6 +369,26 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb,
> > > struct net_device *dev)
> > >  	if (unlikely(!proto || skb->protocol != proto))
> > >  		goto drop;
> > >  
> > > +	/* retrieve peer serving the destination IP of this packet
> > > */
> > > +	peer = ovpn_peer_get_by_dst(ovpn, skb);
> > > +	if (unlikely(!peer)) {
> > > +		switch (skb->protocol) {
> > > +		case htons(ETH_P_IP):
> > > +			net_dbg_ratelimited("%s: no peer to send
> > > data to dst=%pI4\n",
> > > +					    netdev_name(ovpn->dev),
> > > +					    &ip_hdr(skb)->daddr);
> > > +			break;
> > > +		case htons(ETH_P_IPV6):
> > > +			net_dbg_ratelimited("%s: no peer to send
> > > data to dst=%pI6c\n",
> > > +					    netdev_name(ovpn->dev),
> > > +					    &ipv6_hdr(skb)->daddr);
> > > +			break;
> > > +		}
> > > +		goto drop;
> > > +	}
> > > +	/* dst was needed for peer selection - it can now be
> > > dropped */
> > > +	skb_dst_drop(skb);
> > 
> > Moving this code looks like a separate clean up? Or is this needed for
> > the conversion to sk_buff_head?
> 
> While this could technically be a separate cleanup, I included it here
> because it reorganizes the function to accommodate the new lifecycle of
> the skb variable. Once we commit to populating the sk_buff_head and
> nullifying the original skb, the peer lookup logically has to happen
> earlier. Grouping these changes keeps the function coherent throughout
> the refactoring. Otherwise we would have had to pass skb_list.next to
> ovpn_peer_get_by_dst, which would have defeated the purpose of the
> patch.
> 
> That said, I recognize it could also be viewed as a standalone patch. If
> you prefer a 2-step cleanup for better atomicity, I am happy to split
> this into two commits: one for the peer retrieval move and another for
> the sk_buff_head API transition. Please let me know your preference.

Maybe. Either way, I think you're missing a call to ovpn_peer_put() in
the error cases that happen after fetching the peer. Before this patch
there was no possible failure once we'd grabbed the peer.


One more semi-nitpicky comment:

> +	if (unlikely(skb_queue_empty(&skb_list)))
>  		goto drop;

Is this needed? If the queue is empty we've already counted one drop
for each segment during the list-to-sk_buff_head loop, and ovpn_send
should handle an empty queue without problem?

-- 
Sabrina

