Date: Wed, 19 Nov 2025 14:41:07 +0100 (CET)
Message-Id: <202511191341.5AJDf7dm000485@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251119114041.17665-1-gert@...1296...>
References: <20251119114041.17665-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: handle default gateway
 (net_gateway) and nexthop towards VPN server separately
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

In it goes, at last...  I was wondering for a long time if we really need
this, but it turns out that we have users that do stuff like "talk openvpn
via a proxy on 127.0.0.5" plus "--route 1.1.1.1 net_gateway" and this now
broke with 2.7* (see GH #890).  The initial patch fixed $env{net_gateway}
but not "--route net_gateway" - for that we really need to store the 
two different sorts of gateway in the "route_list" / "route_ipv6_list" 
structures.

The log will look a bit redundant now

2025-11-19 12:40:14 net_route_v4_best_gw query: dst 0.0.0.0
2025-11-19 12:40:14 net_route_v4_best_gw result: via 194.97.140.30 dev enp0s18
2025-11-19 12:40:14 net_route_v4_best_gw query: dst 0.0.0.0
2025-11-19 12:40:14 net_route_v4_best_gw result: via 194.97.140.30 dev enp0s18
2025-11-19 12:40:14 net_route_v6_best_gw query: dst ::
2025-11-19 12:40:14 net_route_v6_best_gw result: via 2001:608:0:814::ffff dev enp0s18
2025-11-19 12:40:14 net_route_v6_best_gw query: dst ::1
2025-11-19 12:40:14 net_route_v6_best_gw result: via :: dev lo

(this was "--remote ::1") - but adding another clause to "only call the
other gateway query if the address is different" or more #ifdefs to 
"only do this on Linux and Windows where it makes a difference" would 
have been a bit excessive...

Now let's see if we'll hit even more corner cases :-) - it passes all
my normal tests, plus the things I've learned from #860.

Your patch has been applied to the master branch.

commit 2777cdd3783776a91514804233c5e2b715d11d64 (master)
Author: Marco Baffo
Date:   Wed Nov 19 12:40:35 2025 +0100

     route: handle default gateway (net_gateway) and nexthop towards VPN server separately

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1222
     Message-Id: <20251119114041.17665-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34529.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


