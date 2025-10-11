Date: Sat, 11 Oct 2025 14:50:49 +0200 (CEST)
Message-Id: <202510111250.59BConjL095846@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251011114448.14501-1-gert@...1296...>
References: <20251011114448.14501-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make recursive routing check
 more fine-grained
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at code, and tested on Linux.  Under "normal operations" (that
is "packets are directed into the tunnel by routing") this does not 
make a difference, except logging with source ip+port as well

Old:

2025-10-11 12:52:06 us=938009 Recursive routing detected, drop tun packet to [AF_INET6]2607:fc50:1001:5200::4:51194

New:

2025-10-11 12:49:11 us=326313 Recursive routing detected, packet dropped fd00:abcd:194:2::1029:38264 -> [AF_INET6]2607:fc50:1001:5200::4:51194
2025-10-11 12:50:45 us=97213 Recursive routing detected, packet dropped 10.194.20.170:40119 -> [AF_INET]199.102.77.82:51194

(by application of overlapping --route/--route-ipv6, and removing the
ipv6 host route while OpenVPN was running)


I did not test more advanced scenarios "do ip rule to send non-openvpn
traffic into the tunnel, so the target host can be pinged via tunnel
without triggering the recursion check" - we don't set up things that
way today, but it might become relevant for future Linux "ip rule"
VPN redirections.


Your patch has been applied to the master branch.

commit cf2d18de8b9d75a235dba8e84674361cf64b1489
Author: Lev Stipakov
Date:   Sat Oct 11 13:44:42 2025 +0200

     Make recursive routing check more fine-grained

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/903
     Message-Id: <20251011114448.14501-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59245301/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


