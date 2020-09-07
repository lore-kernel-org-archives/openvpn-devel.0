From: Vladislav Grishenko <themiron@...2010...>
Date: Mon,  7 Sep 2020 18:17:34 +0500
Message-Id: <20200907131734.31164-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Fix best gateway selection over netlink
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
To: openvpn-devel@lists.sourceforge.net

Netlink route request with NLM_F_DUMP flag set means to
return all entries matching criteria passed in message
content - matching supplied dst address in our case.
So, gateway from the first returned route was always used
even there were more specific routes present.
By a chance, after route refactoring in ~2.6.38 first route
is the default route, so default gateway was always used,
hiding the problem.
On earlier kernels default route is the last one, so
route w/o gateway is likely be returned as first causes
gateway always to be 0.0.0.0.

Fix this behavior by requesting exact route, not dump along
with specifying correct dst perfix size.

Tested on 5.4.0, 4.1.51 and 2.6.36 kernels.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/networking_sitnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 713a213a..150dfa5c 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -477,11 +477,12 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
     {
         case AF_INET:
             res.addr_size = sizeof(in_addr_t);
-            req.n.nlmsg_flags |= NLM_F_DUMP;
+            req.r.rtm_dst_len = 32;
             break;
 
         case AF_INET6:
             res.addr_size = sizeof(struct in6_addr);
+            req.r.rtm_dst_len = 128;
             break;
 
         default:
-- 
2.17.1


