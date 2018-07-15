From: Gert Doering <gert@...1296...>
Date: Sun, 15 Jul 2018 22:43:31 +0200
Message-Id: <20180715204331.65442-1-gert@...1296...>
In-Reply-To: <20180715190508.64874-1-gert@...1296...>
References: <20180715190508.64874-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Fix typo in IPv6 address in comment.
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

Comment talks about ff02::1::ff00:8, correct address is ff02::1:ff00:8,
and about fe80::1 where fe80::8 is the proper magic number.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/txpath.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/txpath.c b/src/txpath.c
index 97b9862..5b61177 100644
--- a/src/txpath.c
+++ b/src/txpath.c
@@ -108,8 +108,8 @@ HandleIPv6NeighborDiscovery(
     // - it's either a multicast MAC, or the userland destination MAC
     // but since the TAP driver is point-to-point, all packets are "for us"
 
-    // IPv6 target address must be ff02::1::ff00:8 (multicast for
-    // initial NS) or fe80::1 (unicast for recurrent NUD)
+    // IPv6 target address must be ff02::1:ff00:8 (multicast for
+    // initial NS) or fe80::8 (unicast for recurrent NUD)
     if ( memcmp( ipv6->daddr, IPV6_NS_TARGET_MCAST,
         sizeof(IPV6ADDR) ) != 0 &&
         memcmp( ipv6->daddr, IPV6_NS_TARGET_UNICAST,
-- 
2.18.0


