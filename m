Date: Wed, 4 Feb 2026 11:07:28 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aYMaYLqj4Tuqt0I_@...2915...>
References: <20260130173250.664943-1-ralf@...2726...>
 <20260130173250.664943-2-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260130173250.664943-2-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net v3 2/3] ovpn: fix possible
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

2026-01-30, 18:32:49 +0100, Ralf Lici wrote:
> When building the skb_list in ovpn_net_xmit, skb_share_check will free
> the original skb if it is shared. The current implementation continues
> to use the stale skb pointer for subsequent operations:
> - peer lookup,
> - skb_dst_drop (even though all segments produced by skb_gso_segment
>   will have a dst attached),
> - ovpn_peer_stats_increment_tx.
> 
> Fix this by moving the peer lookup and skb_dst_drop before segmentation
> so that the original skb is still valid when used. Return early if all
> segments fail skb_share_check and the list ends up empty.
> Also switch ovpn_peer_stats_increment_tx to use skb_list.next; the next
> patch fixes the stats logic.
> 
> Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> Signed-off-by: Ralf Lici <ralf@...2726...>

Reviewed-by: Sabrina Dubroca <sd@...2891...>

Thanks Ralf.

-- 
Sabrina

