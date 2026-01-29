Message-ID: <e43962f9370b768d778dcfa9fce213ece6a69878.camel@...2726...>
From: Ralf Lici <ralf@...2726...>
Date: Thu, 29 Jan 2026 15:29:13 +0100
In-Reply-To: <aXtBpNaxSVkl9t2G@...2915...>
References: <20260128124410.429529-1-ralf@...2726...>
 <20260128124410.429529-2-ralf@...2726...> <aXtBpNaxSVkl9t2G@...2915...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 2026-01-29 at 12:16 +0100, Sabrina Dubroca wrote:
> 2026-01-28, 13:44:09 +0100, Ralf Lici wrote:
> > During GSO fragmentation, skb_share_check may clone the first
> > segment
> > and free the original skb. The current implementation continues to
> > use
> > the stale skb pointer for peer lookup.
> >=20
> > Fix this by updating the skb variable to point to the new head of
> > the
> > segment list after the processing loop. Additionally, return early
> > if
> > all segments were dropped during the loop to avoid double-counting
> > statistics and double-freeing memory in the drop path.
> >=20
> > Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> > Signed-off-by: Ralf Lici <ralf@...2726...>
> > ---
> > Changes since v1
> > - this is a new patch that replaces the previous "ovpn: use
> > sk_buff_head
> > =C2=A0 properly in ovpn_net_xmit"
> >=20
> > =C2=A0drivers/net/ovpn/io.c | 11 +++++++++++
> > =C2=A01 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > index 3e9e7f8444b3..95c3518e067c 100644
> > --- a/drivers/net/ovpn/io.c
> > +++ b/drivers/net/ovpn/io.c
> > @@ -396,6 +396,17 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb,
> > struct net_device *dev)
> > =C2=A0
> > =C2=A0		__skb_queue_tail(&skb_list, curr);
> > =C2=A0	}
> > +
> > +	/* no segments survived: don't jump to 'drop' because we
> > already
> > +	 * incremented the counter for each failure in the loop
> > +	 */
> > +	if (unlikely(skb_queue_empty(&skb_list)))
> > +		return NETDEV_TX_OK;
> > +
> > +	/* the original 'skb' might have been freed/cloned in the
> > loop: use the
> > +	 * first element of our list for the other operations
> > +	 */
> > +	skb =3D skb_list.next;
> > =C2=A0	skb_list.prev->next =3D NULL;
> > =C2=A0
> > =C2=A0	/* retrieve peer serving the destination IP of this packet
> > */
>=20
> This patch looks ok, but maybe it would be better to fix this using a
> chunk of your sk_buff_head rework instead. I think all segments
> produced by skb_gso_segment will have a dst attached
> (__copy_skb_header(nskb, head_skb) in skb_segment), so the
> skb_dst_drop after peer selection will only affect the first segment,
> and not the others. Doing peer selection + skb_dst_drop before calling
> skb_gso_segment would solve this as well as the UAF.

Ah right, the dst is indeed copied to the segments. I will make sure to
move the peer selection earlier, while we are still using the original
skb, so that we can call skb_dst_drop only on that one.

> (your current patch would also avoid a UAF on
> ovpn_peer_stats_increment_tx,
> but you're solving that in the next patch)

Yes, now the stats patch is only responsible for fixing the stats count.
I have also updated the commit message from v1.


Thanks for the feedback.

--=20
Ralf Lici
Mandelbit Srl

