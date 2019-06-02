Date: Sun, 2 Jun 2019 21:10:28 +0200 (CEST)
Message-Id: <201906021910.x52JASld044676@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-4-a@...2181...>
References: <20181219050118.6568-4-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: use new networking API
 to handle tun interface on Linux
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

The change to options_string() surprised me a bit, then I found that
it's calling init_tun() under the hood (sometimes) and now I do not
want to know anymore...  or maybe I want to have someone tell me "oh,
with Heiko's windows change of ordering, we do not need this anymore
*anyway*, we can rip it out".  Or maybe Android needs it...  I'm tempted
to put an ASSERT(tt) in there and test a few platforms...

Anyway.  This patch is now finally something I could actually *test* :-) -
so, I ran the t_client tests with an --enable-iproute2 build and an
"no options" build (which should give me netlink).  

OpenVPN output showed suitably nice differences...

Sun Jun  2 20:50:35 2019 net_iface_mtu_set: mtu 1500 for tun0
Sun Jun  2 20:50:35 2019 net_iface_up: set tun0 up
Sun Jun  2 20:50:35 2019 net_addr_v4_add: x.x.x.74/29 brd 255.255.255.248 dev tun0
Sun Jun  2 20:50:35 2019 net_iface_mtu_set: mtu 1500 for tun0
Sun Jun  2 20:50:35 2019 net_iface_up: set tun0 up
Sun Jun  2 20:50:35 2019 net_addr_v6_add: 2001:x:x:x::1000/64 dev tun0

vs.

Sun Jun  2 20:55:57 2019 /bin/ip link set dev tun0 up mtu 1500
Sun Jun  2 20:55:57 2019 /bin/ip link set dev tun0 up
Sun Jun  2 20:55:57 2019 /bin/ip addr add dev tun0 x.x.x.74/29 broadcast 255.255.255.248
Sun Jun  2 20:55:57 2019 /bin/ip link set dev tun0 up mtu 1500
Sun Jun  2 20:55:57 2019 /bin/ip link set dev tun0 up
Sun Jun  2 20:55:57 2019 /bin/ip -6 addr add 2001:x.x.x::1000/64 dev tun0

and manual "ip addr show" reflected the correctness while OpenVPN was
up.  Great :-)


commit dc7fcd714188989966ac2bd9315485603813fe0f
Author: Antonio Quartulli
Date:   Wed Dec 19 15:01:14 2018 +1000

     tun.c: use new networking API to handle tun interface on Linux

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20181219050118.6568-4-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18028.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


