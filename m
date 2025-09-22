From: Marek Mietus <mmietus97@...109...>
Date: Mon, 22 Sep 2025 13:06:19 +0200
Message-ID: <20250922110622.10368-1-mmietus97@...109...>
MIME-Version: 1.0
References: <20250922110622.10368-1-mmietus97.ref@...109...>
Subject: [Openvpn-devel] [PATCH net-next v3 0/3] net: tunnel: introduce
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
To: netdev@...2909..., sd@...2891..., antonio@...515...
Cc: openvpn-devel@lists.sourceforge.net

Currently, all xmit flows use dst_cache in a way that references
its dst_entry for each xmitted packet. These atomic operations
are redundant in some flows.

This patchset introduces new noref xmit helpers and incorporates
them in the OpenVPN driver. A similar improvement can also be
applied to other tunnel code in the future. The implementation
for OpenVPN is a good starting point as it doesn't use the
udp_tunnel_dst_lookup helper which adds some complexity.

There are already noref optimizations in both ipv4 and ip6 
(See __ip_queue_xmit, inet6_csk_xmit). This patchset allows for
similar optimizations in udp tunnels. Referencing the dst_entry
is now redundant, as the entire flow is protected under RCU, so
it is removed.

With this patchset, I was able to observe a 4% decrease in the total
time for ovpn_udp_send_skb using perf.

Changes in v3:
 - Added implementation for ip6
 - Updated cover letter and commit messages

Link to v2: https://lore.kernel.org/netdev/20250912112420.4394-1-mmietus97@...109.../
-- 
2.51.0

