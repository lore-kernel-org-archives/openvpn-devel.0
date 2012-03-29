From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu, 29 Mar 2012 11:16:40 +0200
Message-Id: <1333012602-5419-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
Subject: [Openvpn-devel] [PATCH 2/4] cleanup: avoid using ~0 - ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/route.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a628e77..dda71c9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1530,7 +1530,7 @@ print_in6_addr_netbits_only( struct in6_addr network_copy, int netbits,
       if ( bits_to_clear >= 8 )
 	{ network_copy.s6_addr[byte--] = 0; bits_to_clear -= 8; }
       else
-	{ network_copy.s6_addr[byte--] &= (~0 << bits_to_clear); bits_to_clear = 0; }
+	{ network_copy.s6_addr[byte--] &= (0xff << bits_to_clear); bits_to_clear = 0; }
     }
 
   return print_in6_addr( network_copy, 0, gc);
-- 
1.7.3.4


