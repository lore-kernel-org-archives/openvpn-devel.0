MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
In-Reply-To: <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Dec 2022 22:50:19 +0200
Message-ID: <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

> This data will also show up as stats on the adapter (device node) and should include all traffic that passes through it, no?

System adapter stats show only tun traffic - the one driver indicates
to NetAdapter. For BYTECOUNT we (userspace client) currently show link
traffic - encapsulated control and data packets.

> The userspace reporting can handle either approach as long as all dco platforms count stats the same way.

On Windows control packets are handled by userspace via link
read/write routines (which use device handle from CreateFile). Both
FreeBSD and Linux implementations use additional, netlink-based (or
FreeBSD analogue) channel to send/receive control packets,
so existing link read/write routines are not called (except initial
handshake, before socket handover to kernel) and therefore stats for
control packets are not duplicated.

-- 
-Lev

