Date: Tue, 7 Oct 2025 18:41:05 +0200 (CEST)
Message-Id: <202510071641.597Gf5iS045465@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251007160826.4614-1-gert@...1296...>
References: <20251007160826.4614-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow route_ipv6_match_host to
 be used outside of route.c
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

I do remember this function! ;-)

Tested with the lone caller...

2025-10-07 18:05:47 ROUTE6: 2607:fc50:1001:5200::1:8/111 overlaps IPv6 remote 2607:fc50:1001:5200::4, adding host route to VPN endpoint

.. still works, for "match" and "no match" and "slightly odd netbits".

At some point we might see if we can move this "somewhere" (socket_util.c?)
that is suitable for an unit test, and add one...  but not today.

Your patch has been applied to the master branch.

commit 790b812014708aa21a12743d5a73dfc4fc29d938
Author: Arne Schwabe
Date:   Tue Oct 7 18:08:18 2025 +0200

     Allow route_ipv6_match_host to be used outside of route.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1191
     Message-Id: <20251007160826.4614-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243387/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


