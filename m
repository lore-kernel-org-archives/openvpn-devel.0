From: Marek Mietus <mmietus97@...109...>
Date: Fri, 12 Sep 2025 13:24:17 +0200
Message-ID: <20250912112420.4394-1-mmietus97@...109...>
MIME-Version: 1.0
References: <20250912112420.4394-1-mmietus97.ref@...109...>
Subject: [Openvpn-devel] [PATCH net-next v2 0/3] net: tunnel: introduce
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
To: netdev@...2909..., antonio@...515..., kuba@...2912...
Cc: openvpn-devel@lists.sourceforge.net, Marek Mietus <mmietus97@...109...>

Currently, all xmit flows use dst_cache in a way that references
its dst_entry for each xmitted packet. These atomic operations
are redundant in some flows.

This patchset introduces new noref xmit helpers, and incorporates
them in the OpenVPN driver.

Changes in v2:
 - Fixed docstrings for dst_cache_get_ip4_rcu and dst_cache_steal_ip4

Link to v1: https://lore.kernel.org/netdev/20250909054333.12572-1-mmietus97@...109.../
-- 
2.51.0


