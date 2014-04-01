From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 1 Apr 2014 12:06:43 +0200
Message-ID: <1396346803-31772-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
References: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix route struct name
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

This slipped in with commit d0085293.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 13eed5f..825ea47 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2117,7 +2117,7 @@ test_routes (const struct route_list *rl, const struct tuntap *tt)
 
       if (rl)
 	{
-	  struct route *r;
+	  struct route_ipv4 *r;
 	  for (r = rl->routes, len = 0; r; r = r->next, ++len)
 	    test_route_helper (&ret, &count, &good, &ambig, adapters, r->gateway);
 
-- 
1.7.9.5


