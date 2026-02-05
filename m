Message-ID: <25d26e22e4953eef77caf386899896b571e3cbaf.camel@...2726...>
From: Ralf Lici <ralf@...2726...>
Date: Thu, 05 Feb 2026 15:28:47 +0100
In-Reply-To: <aYOiIX41affrt998@...2915...>
References: <20260204141441.528655-1-ralf@...2726...>
 <aYOiIX41affrt998@...2915...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 2026-02-04 at 20:46 +0100, Sabrina Dubroca wrote:
> Sorry Ralf, December and January flew by and I didn't get a chance to
> dive deeper into your previous RFC patch.

No problem at all. We had the opportunity to investigate this further
and run some tests, as Antonio mentioned.

> 2026-02-04, 15:14:41 +0100, Ralf Lici wrote:
> > When processing TCP stream data in ovpn_tcp_recv, we receive large
> > cloned skbs from __strp_rcv that may contain multiple coalesced
> > packets.
> > The current implementation has two bugs:
> >=20
> > 1. Header offset overflow: Using pskb_pull with large offsets on
> > =C2=A0=C2=A0 coalesced skbs causes skb->data - skb->head to exceed the =
u16
> > storage
> > =C2=A0=C2=A0 of skb->network_header. This causes skb_reset_network_head=
er to
> > fail
> > =C2=A0=C2=A0 on the inner decapsulated packet, resulting in packet drop=
s.
> >=20
> > 2. Unaligned protocol headers: Extracting packets from arbitrary
> > =C2=A0=C2=A0 positions within the coalesced TCP stream provides no alig=
nment
> > =C2=A0=C2=A0 guarantees for the packet data causing performance penalti=
es on
> > =C2=A0=C2=A0 architectures without efficient unaligned access. Addition=
ally,
> > =C2=A0=C2=A0 openvpn's 2-byte length prefix on TCP packets causes the
> > subsequent
> > =C2=A0=C2=A0 4-byte opcode and packet ID fields to be inherently misali=
gned.
> >=20
> > Fix both issues by allocating a new skb for each openvpn packet and
> > using skb_copy_bits to extract only the packet content into the new
> > buffer, skipping the 2-byte length prefix. Also, check the length
> > before
> > invoking the function that performs the allocation to avoid creating
> > an
> > invalid skb.
> >=20
> > If the packet has to be forwarded to userspace the 2-byte prefix can
> > be
> > pushed to the head safely, without misalignment.
> >=20
> > As a side effect, this approach also avoids the expensive
> > linearization
> > that pskb_pull triggers on cloned skbs with page fragments. In
> > testing,
>=20
> We don't really avoid the linearization (because
> netdev_alloc_skb+skb_copy_bits is pretty much doing that) but we're
> only linearizing pkt_len instead of offset + pkt_len?

Exactly, the main issue was the first pskb_pull in ovpn_tcp_rcv which
would linearize large amounts of data for every openvpn packet inside a
coalesced skb (strp keeps cloning the original one). In fact your
suggestion of using pskb_extract does resolve the
skb_reset_network_header issue and improves throughput but
netdev_alloc_skb performs better. I suppose that's because while
pskb_extract avoids initial data copying through frag manipulation,
skb_cow_data in ovpn_aead_decrypt still linearizes the packet for
crypto, resulting in two passes over the data (carve + linearize) versus
one direct copy with netdev_alloc_skb. Also pskb_extract requires atomic
refcount operations which are not needed with the alloc + copy approach.

>=20
> > this resulted in TCP throughput improvements of up to 74%.
>=20
> Wow.
>=20
> [...]
> > +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff
> > *skb)
> > +{
> > +	struct ovpn_peer *peer =3D container_of(strp, struct
> > ovpn_peer, tcp.strp);
> > +	struct strp_msg *msg =3D strp_msg(skb);
> > +	int pkt_len =3D msg->full_len - 2;
> > +	u8 opcode;
> > +
> > +	/* we need at least 4 bytes of data in the packet
> > =C2=A0	 * to extract the opcode and the key ID later on
> > =C2=A0	 */
> > -	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
> > +	if (unlikely(pkt_len < OVPN_OPCODE_SIZE)) {
> > =C2=A0		net_warn_ratelimited("%s: packet too small to fetch
> > opcode for peer %u\n",
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> > peer->id);
> > =C2=A0		goto err;
> > =C2=A0	}
> > =C2=A0
> > +	/* extract the packet into a new skb */
> > +	skb =3D ovpn_tcp_skb_packet(peer, skb, pkt_len, msg->offset +
> > 2);
> > +	if (unlikely(!skb))
> > +		goto err;
>=20
>=20
> err:
> 	/* take reference for deferred peer deletion. should never
> fail */
> 	if (WARN_ON(!ovpn_peer_hold(peer)))
> 		goto err_nopeer;
> 	schedule_work(&peer->tcp.defer_del_work);
> 	dev_dstats_rx_dropped(peer->ovpn->dev);
>=20
> I'm thinking that we may not need to abort the connection if we failed
> to allocate the new skb or copy the message, since we have a message
> boundary so we can still parse the following messages out of the
> stream? But we won't be able to validate that boundary since we can't
> try to decrypt the packet, so maybe it's better to still abort.
> (if the "don't abort" idea is wanted, it can be done at a later time,
> doesn't have to be part of this patch)

I agree. While an allocation failure here doesn't strictly require
aborting the connection, subsequent operations are unlikely to succeed
anyway. I can address this in a follow-up patch to keep this fix
focused.

> > +
> > =C2=A0	/* DATA_V2 packets are handled in kernel, the rest goes to
> > user space */
> > =C2=A0	opcode =3D ovpn_opcode_from_skb(skb, 0);
> > =C2=A0	if (unlikely(opcode !=3D OVPN_DATA_V2)) {
> > @@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp,
> > struct sk_buff *skb)
> > =C2=A0		/* The packet size header must be there when
> > sending the packet
> > =C2=A0		 * to userspace, therefore we put it back
> > =C2=A0		 */
> > -		skb_push(skb, 2);
> > +		*((__force __be16 *)__skb_push(skb, 2)) =3D
> > cpu_to_be16(pkt_len);
>=20
> Why switch to __skb_push here? The skb_under_panic() would be nice in
> the (unexpected) case we have an invalid skb.
>=20
> Here we rely on the extra room that netdev_alloc_skb reserves
> (NET_SKB_PAD) in case we have to re-push the packet length, right?
> I'm a bit concerned about the silent assumptions that could lead to
> writing to arbitrary addresses in memory.
>=20
> > =C2=A0		ovpn_tcp_to_userspace(peer, strp->sk, skb);
> > =C2=A0		return;
> > =C2=A0	}
> > --=20
> > 2.52.0
> >=20

--=20
Ralf Lici
Mandelbit Srl

