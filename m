Date: Tue, 16 Sep 2025 12:43:31 +0200
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aMk_U3zeHviJC1GI@...2915...>
References: <20250909054333.12572-1-mmietus97.ref@...109...>
 <20250909054333.12572-1-mmietus97@...109...>
 <b8b604f7-c5c3-4257-93da-8f6881e96fe4@...515...>
 <8e6b83b3-c986-4d6e-b61a-363e13bf1ddc@...109...>
MIME-Version: 1.0
In-Reply-To: <8e6b83b3-c986-4d6e-b61a-363e13bf1ddc@...109...>
Subject: Re: [Openvpn-devel] [PATCH net-next 0/3] net: tunnel: introduce
 noref xmit flows for tunnels
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
To: Marek Mietus <mmietus97@...109...>
Cc: Antonio Quartulli <antonio@...515...>, netdev@...2909..., openvpn-devel@lists.sourceforge.net

2025-09-09, 16:43:01 +0200, Marek Mietus wrote:
> W dniu 9/9/25 o 13:17, Antonio Quartulli pisze:
> > On 09/09/2025 07:43, Marek Mietus wrote:
> >> Currently, all xmit flows use dst_cache in a way that references
> >> its dst_entry for each xmitted packet. These atomic operations
> >> are redundant in some flows.
> > 
> > Can you elaborate on the current limits/drawbacks and explain what we gain with this new approach?
> > 
> > It may be obvious for some, but it's not for me.
> > 
> 
> The only difference with the new approach is that we avoid taking an unnecessary
> reference on dst_entry. This is possible since the entire flow is protected by RCU.
> This change reduces an atomic write operation on every xmit, resulting in a performance
> improvement.

It would be nice to incorporate this information into the cover
letter, and to provide numbers showing the performance
improvement. That way, it's available to other reviewers and gets
recorded in the git log. Are you doing crypto with some accelerator?
Otherwise I'd imagine skipping a few atomic operations is not really
noticeable.

> There are other flows in the kernel where a similar approach is used (e.g. __ip_queue_xmit
> uses skb_dst_set_noref).
> 
> > Also it sounded as if more tunnels were affected, but in the end only ovpn is being changed.
> > Does it mean all other tunnels don't need this?
> > 
> 
> More tunneling code can be updated to utilize these new helpers. I only worked
> on OpenVPN, as I am more familiar with it. It was very easy to implement the
> changes in OpenVPN because it doesn't use the udp_tunnel_dst_lookup helper
> that adds some complexity.
> 
> I hope to incorporate these changes in more tunnels in the future.

It would also be good to add this to the cover letter. Something like
"For now, only ovpn is updated <for $reason>, but other tunnels could
also take advantage of this."

-- 
Sabrina

