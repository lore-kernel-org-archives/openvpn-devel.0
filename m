From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 23:26:40 +0200
Message-Id: <1332797200-9295-7-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH 6/6] cleanup: ~0 is too large for 32bit ipv4
	address
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
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/route.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bf7af63..608403b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -268,7 +268,7 @@ init_route (struct route *r,
 	    const struct route_option *ro,
 	    const struct route_list *rl)
 {
-  const in_addr_t default_netmask = ~0;
+  const in_addr_t default_netmask = 0xffffffff;
   bool status;
 
   CLEAR (*r);
-- 
1.7.3.4


