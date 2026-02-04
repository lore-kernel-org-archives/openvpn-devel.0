Message-ID: <03719c6c394baef70bfa8a7e9b5741ed9d603059.camel@...2726...>
From: Ralf Lici <ralf@...2726...>
Date: Wed, 04 Feb 2026 15:40:32 +0100
In-Reply-To: <20260204141441.528655-1-ralf@...2726...>
References: <20260204141441.528655-1-ralf@...2726...>
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
To: openvpn-devel@lists.sourceforge.net
Cc: Sabrina Dubroca <sd@...2891...>

On Wed, 2026-02-04 at 15:14 +0100, Ralf Lici wrote:
> When processing TCP stream data in ovpn_tcp_recv, we receive large
> cloned skbs from __strp_rcv that may contain multiple coalesced
> packets.
> The current implementation has two bugs:
>=20
> 1. Header offset overflow: Using pskb_pull with large offsets on
> =C2=A0=C2=A0 coalesced skbs causes skb->data - skb->head to exceed the u16
> storage
> =C2=A0=C2=A0 of skb->network_header. This causes skb_reset_network_header=
 to
> fail
> =C2=A0=C2=A0 on the inner decapsulated packet, resulting in packet drops.
>=20
> 2. Unaligned protocol headers: Extracting packets from arbitrary
> =C2=A0=C2=A0 positions within the coalesced TCP stream provides no alignm=
ent
> =C2=A0=C2=A0 guarantees for the packet data causing performance penalties=
 on
> =C2=A0=C2=A0 architectures without efficient unaligned access. Additional=
ly,
> =C2=A0=C2=A0 openvpn's 2-byte length prefix on TCP packets causes the sub=
sequent
> =C2=A0=C2=A0 4-byte opcode and packet ID fields to be inherently misalign=
ed.
>=20
> Fix both issues by allocating a new skb for each openvpn packet and
> using skb_copy_bits to extract only the packet content into the new
> buffer, skipping the 2-byte length prefix. Also, check the length
> before
> invoking the function that performs the allocation to avoid creating
> an
> invalid skb.
>=20
> If the packet has to be forwarded to userspace the 2-byte prefix can
> be
> pushed to the head safely, without misalignment.
>=20
> As a side effect, this approach also avoids the expensive
> linearization
> that pskb_pull triggers on cloned skbs with page fragments. In
> testing,
> this resulted in TCP throughput improvements of up to 74%.
>=20
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Ralf Lici <ralf@...2726...>
> ---
> =C2=A0drivers/net/ovpn/tcp.c | 53 ++++++++++++++++++++++++++++-----------=
--
> -
> =C2=A01 file changed, 36 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index b7348da9b040..ffe8db69d76d 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -70,37 +70,56 @@ static void ovpn_tcp_to_userspace(struct ovpn_peer
> *peer, struct sock *sk,
> =C2=A0	peer->tcp.sk_cb.sk_data_ready(sk);
> =C2=A0}
> =C2=A0
> -static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +static struct sk_buff *ovpn_tcp_skb_packet(const struct ovpn_peer
> *peer,
> +					=C2=A0=C2=A0 struct sk_buff *orig_skb,
> +					=C2=A0=C2=A0 const int pkt_len, const
> int pkt_off)
> =C2=A0{
> -	struct ovpn_peer *peer =3D container_of(strp, struct ovpn_peer,
> tcp.strp);
> -	struct strp_msg *msg =3D strp_msg(skb);
> -	size_t pkt_len =3D msg->full_len - 2;
> -	size_t off =3D msg->offset + 2;
> -	u8 opcode;
> +	struct sk_buff *ovpn_skb;
> +	int err;
> =C2=A0
> -	/* ensure skb->data points to the beginning of the openvpn
> packet */
> -	if (!pskb_pull(skb, off)) {
> -		net_warn_ratelimited("%s: packet too small for peer
> %u\n",
> -				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> peer->id);
> +	/* create a new skb with only the content of the current
> packet */
> +	ovpn_skb =3D netdev_alloc_skb(peer->ovpn->dev, pkt_len);
> +	if (unlikely(!ovpn_skb))
> =C2=A0		goto err;
> -	}
> =C2=A0
> -	/* strparser does not trim the skb for us, therefore we do it
> now */
> -	if (pskb_trim(skb, pkt_len) !=3D 0) {
> -		net_warn_ratelimited("%s: trimming skb failed for
> peer %u\n",
> +	skb_copy_header(ovpn_skb, orig_skb);
> +	err =3D skb_copy_bits(orig_skb, pkt_off, skb_put(ovpn_skb,
> pkt_len),
> +			=C2=A0=C2=A0=C2=A0 pkt_len);
> +	if (unlikely(err)) {
> +		net_warn_ratelimited("%s: skb_copy_bits failed for
> peer %u\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> peer->id);
> +		kfree_skb(ovpn_skb);
> =C2=A0		goto err;
> =C2=A0	}
> =C2=A0
> -	/* we need the first 4 bytes of data to be accessible
> +	consume_skb(orig_skb);
> +	return ovpn_skb;
> +err:
> +	kfree_skb(orig_skb);
> +	return NULL;
> +}
> +
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
> +	struct ovpn_peer *peer =3D container_of(strp, struct ovpn_peer,
> tcp.strp);
> +	struct strp_msg *msg =3D strp_msg(skb);
> +	int pkt_len =3D msg->full_len - 2;
> +	u8 opcode;
> +
> +	/* we need at least 4 bytes of data in the packet
> =C2=A0	 * to extract the opcode and the key ID later on
> =C2=A0	 */
> -	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
> +	if (unlikely(pkt_len < OVPN_OPCODE_SIZE)) {
> =C2=A0		net_warn_ratelimited("%s: packet too small to fetch
> opcode for peer %u\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> peer->id);
> =C2=A0		goto err;
> =C2=A0	}
> =C2=A0
> +	/* extract the packet into a new skb */
> +	skb =3D ovpn_tcp_skb_packet(peer, skb, pkt_len, msg->offset +
> 2);
> +	if (unlikely(!skb))
> +		goto err;
> +
> =C2=A0	/* DATA_V2 packets are handled in kernel, the rest goes to
> user space */
> =C2=A0	opcode =3D ovpn_opcode_from_skb(skb, 0);
> =C2=A0	if (unlikely(opcode !=3D OVPN_DATA_V2)) {
> @@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp,
> struct sk_buff *skb)
> =C2=A0		/* The packet size header must be there when sending
> the packet
> =C2=A0		 * to userspace, therefore we put it back
> =C2=A0		 */
> -		skb_push(skb, 2);
> +		*((__force __be16 *)__skb_push(skb, 2)) =3D
> cpu_to_be16(pkt_len);
> =C2=A0		ovpn_tcp_to_userspace(peer, strp->sk, skb);
> =C2=A0		return;
> =C2=A0	}

This issue manifests as the following warning (on
skb_reset_network_header):


[  126.764066] ------------[ cut here ]------------
[  126.764541] WARNING: CPU: 1 PID: 22 at ./include/linux/skbuff.h:3122
ovpn_decrypt_post+0x531/0x7b0 [ovpn]
[  126.765698] Modules linked in: ovpn ip6_udp_tunnel udp_tunnel chacha
libchacha chacha20poly1305 libpoly1305 veth [last unloaded:
ip6_udp_tunnel]
[  126.767085] CPU: 1 UID: 0 PID: 22 Comm: ksoftirqd/1 Not tainted
6.17.0+ #222 PREEMPT(none)=20
[  126.768053] RIP: 0010:ovpn_decrypt_post+0x531/0x7b0 [ovpn]
[  126.768769] Code: cc cc cc cc 48 2b 93 c8 00 00 00 83 c2 28 0f 88 62
02 00 00 89 c8 29 f0 39 d0 0f 82 2e 02 00 00 b8 86 dd ff ff e9 68 fe ff
ff <0f> 0b e9 20 fc ff ff 0f 0b e9 35 fc ff ff 39 c1 0f 82 5b fc ff ff
[  126.770834] RSP: 0018:ffffc900000d77f0 EFLAGS: 00010216
[  126.771503] RAX: 000000000001034c RBX: ffff88810c7ac100 RCX:
0000000000000588
[  126.772386] RDX: ffff888116ee0000 RSI: 0000000000000000 RDI:
ffffffff8359f040
[  126.773251] RBP: ffffc900000d7820 R08: 00000000000005a0 R09:
ffff888116ef034c
[  126.774126] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff888116bec800
[  126.774980] R13: ffff888108118000 R14: 0000000000000018 R15:
ffff888103a6cc00
[  126.775871] FS:  0000000000000000(0000) GS:ffff8882f446b000(0000)
knlGS:0000000000000000
[  126.776839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.777605] CR2: 00007f5f9d2fc000 CR3: 000000011659b000 CR4:
0000000000750eb0
[  126.778434] PKRU: 55555554
[  126.778887] Call Trace:
[  126.779324]  <TASK>
[  126.779728]  ovpn_recv+0x15b/0x3a0 [ovpn]
[  126.780299]  ovpn_tcp_rcv+0xbd/0x320 [ovpn]
[  126.780886]  __strp_recv+0x172/0x640
[  126.781430]  strp_recv+0x27/0x30
[  126.781931]  __tcp_read_sock+0x92/0x260
[  126.782483]  ? __pfx_strp_recv+0x10/0x10
[  126.783055]  tcp_read_sock+0x1b/0x30
[  126.783586]  strp_read_sock+0xce/0xe0
[  126.784162]  strp_data_ready+0x6a/0xa0
[  126.784721]  ovpn_tcp_data_ready+0x90/0x220 [ovpn]
[  126.785441]  tcp_data_ready+0x30/0xd0
[  126.785992]  tcp_data_queue+0x8a4/0x1000
[  126.786560]  tcp_rcv_established+0x328/0xca0
[  126.787170]  tcp_v4_do_rcv+0x18f/0x3c0
[  126.787726]  tcp_v4_rcv+0xf51/0x1520
[  126.788264]  ip_protocol_deliver_rcu+0x4a/0x200
[  126.788898]  ? process_backlog+0x14b/0x630
[  126.789552]  ip_local_deliver_finish+0xd7/0x220
[  126.790193]  ip_local_deliver+0x63/0x250
[  126.790769]  ? lock_is_held_type+0x9c/0x110
[  126.791366]  ? process_backlog+0x14b/0x630
[  126.791995]  ip_rcv+0x26f/0x340
[  126.792516]  ? process_backlog+0x14b/0x630
[  126.793114]  ? process_backlog+0x14b/0x630
[  126.793714]  __netif_receive_skb_one_core+0x6b/0x80
[  126.794358]  __netif_receive_skb+0x16/0x60
[  126.794951]  process_backlog+0x18b/0x630
[  126.795515]  ? process_backlog+0x6a/0x630
[  126.796109]  __napi_poll.constprop.0+0x2e/0x1e0
[  126.796721]  net_rx_action+0x384/0x420
[  126.797252]  ? local_clock_noinstr+0x13/0xf0
[  126.797861]  handle_softirqs+0xc8/0x3f0
[  126.798401]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  126.799024]  run_ksoftirqd+0x36/0x50
[  126.799548]  smpboot_thread_fn+0xfe/0x230
[  126.800110]  kthread+0x103/0x210
[  126.800602]  ? __pfx_kthread+0x10/0x10
[  126.801145]  ret_from_fork+0x18a/0x1e0
[  126.801705]  ? __pfx_kthread+0x10/0x10
[  126.802284]  ret_from_fork_asm+0x1a/0x30
[  126.802879]  </TASK>
[  126.803288] irq event stamp: 41024
[  126.803799] hardirqs last  enabled at (41032): [<ffffffff8137676c>]
__up_console_sem+0x5c/0x70
[  126.804799] hardirqs last disabled at (41039): [<ffffffff81376751>]
__up_console_sem+0x41/0x70
[  126.805812] softirqs last  enabled at (33936): [<ffffffff812e6486>]
run_ksoftirqd+0x36/0x50
[  126.806819] softirqs last disabled at (33941): [<ffffffff812e6486>]
run_ksoftirqd+0x36/0x50
[  126.807822] ---[ end trace 0000000000000000 ]---

--=20
Ralf Lici
Mandelbit Srl

