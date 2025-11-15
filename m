Date: Sat, 15 Nov 2025 11:09:11 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aRhRR2-I0gAiGqJS@...2915...>
References: <20251114103940.238076-1-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20251114103940.238076-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn v2] ovpn: notify userspace on
 client float event
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
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

2025-11-14, 11:39:40 +0100, Ralf Lici wrote:
> Send a netlink notification when a client updates its remote UDP
> endpoint. The notification includes the new IP address, port, and scope
> ID (for IPv6).
> 
> Signed-off-by: Ralf Lici <ralf@...2726...>
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
> Changes since v1:
> - correctly set return value for unsupported AF in
>   ovpn_nl_peer_float_notify
> 
>  Documentation/netlink/specs/ovpn.yaml       |  6 ++
>  drivers/net/ovpn/netlink.c                  | 82 +++++++++++++++++++++
>  drivers/net/ovpn/netlink.h                  |  2 +
>  drivers/net/ovpn/peer.c                     |  2 +
>  include/uapi/linux/ovpn.h                   |  1 +
>  tools/testing/selftests/net/ovpn/ovpn-cli.c |  3 +
>  6 files changed, 96 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@...2891...>

-- 
Sabrina

