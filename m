Date: Thu, 5 Feb 2026 11:42:10 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aYR0AuC6jd7XSje5@...2915...>
References: <20260204141441.528655-1-ralf@...2726...>
 <aYOiIX41affrt998@...2915...>
 <1ed2def1-a853-4a35-ac2b-5906604bff93@...2181...>
MIME-Version: 1.0
In-Reply-To: <1ed2def1-a853-4a35-ac2b-5906604bff93@...2181...>
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
To: Antonio Quartulli <a@...2181...>
Cc: Ralf Lici <ralf@...2726...>, openvpn-devel@lists.sourceforge.net

2026-02-04, 23:42:31 +0100, Antonio Quartulli wrote:
> Hi Sabrina!
> 
> On 04/02/2026 20:46, Sabrina Dubroca wrote:
> > > this resulted in TCP throughput improvements of up to 74%.
> > 
> > Wow.
> 
> I was also astonished by this result!
> 
> Actually Ralf tested various options (i.e. netdev_alloc_skb vs pskb_extract,
> on all skbs vs on large ones only) and this solution turned to be the one
> giving the highest boost.
> 
> In my tests yesterday, TCP jumped from ~4.3Gbps to ~7.3Gbps after applying
> this patch, which is the same throughput I am getting over UDP!

Very nice :)


> > > @@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> > >   		/* The packet size header must be there when sending the packet
> > >   		 * to userspace, therefore we put it back
> > >   		 */
> > > -		skb_push(skb, 2);
> > > +		*((__force __be16 *)__skb_push(skb, 2)) = cpu_to_be16(pkt_len);
> > 
> > Why switch to __skb_push here? The skb_under_panic() would be nice in
> > the (unexpected) case we have an invalid skb.
> > 
> 
> We just created the skb, so it should be safe to assume that the skb is
> valid, no?

I meant invalid in the sense of "not having the expected room to push
the header".

> > Here we rely on the extra room that netdev_alloc_skb reserves
> > (NET_SKB_PAD) in case we have to re-push the packet length, right?
> 
> The comment at https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/skbuff.h#L3282
> about NET_SKB_PAD seems to suggest that this is actual headroom that
> networking drivers can assume to have, no?

I guess so. But I'd feel a bit safer if we had something enforcing
that at least this push can't fail, more as a guarantee against an
accidental code change in ovpn. But maybe we'd have bigger problems
through the rest of the stack if ovpn skbs get bridged/forwarded and
we don't have all that headroom.

> And it should never be less than 32 bytes.
> 
> 
> Regards,

-- 
Sabrina

