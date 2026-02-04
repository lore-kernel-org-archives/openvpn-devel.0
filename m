Date: Wed, 4 Feb 2026 11:07:48 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aYMadMQ2NDugvtFl@...2915...>
References: <20260130173250.664943-1-ralf@...2726...>
 <20260130173250.664943-3-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20260130173250.664943-3-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net v3 3/3] ovpn: fix VPN TX bytes
 counting
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

2026-01-30, 18:32:50 +0100, Ralf Lici wrote:
> In ovpn_net_xmit, after GSO segmentation and segment processing, the
> first segment on the list is used to increment VPN TX statistics, which
> fails to account for any subsequent segments in the chain.
> 
> Fix this by accumulating the length of every segment that successfully
> passes skb_share_check into a tx_bytes variable. This ensures the peer
> statistics accurately reflect the total data volume sent, regardless of
> whether the original packet was segmented.
> 
> Fixes: 04ca14955f9a ("ovpn: store tunnel and transport statistics")
> Signed-off-by: Ralf Lici <ralf@...2726...>

Reviewed-by: Sabrina Dubroca <sd@...2891...>

-- 
Sabrina

