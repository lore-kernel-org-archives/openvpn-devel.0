From: Gert Doering <gert@...1296...>
Date: Sun, 10 Jun 2012 17:41:28 +0200
Message-Id: <1339342891-28443-3-git-send-email-gert@...1296...>
In-Reply-To: <1339342891-28443-1-git-send-email-gert@...1296...>
References: <1339342891-28443-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/5] remove "*option" element in "struct
	route_ipv6"
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

this used to point to the "route_ipv6_option" that created this specific
route entry, but nobody ever queried this field -> dead code.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index c0f5f57..e63db59 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -124,7 +124,6 @@ struct route {
 
 struct route_ipv6 {
   bool defined;
-  const struct route_ipv6_option *option;
   struct in6_addr network;
   unsigned int netbits;
   struct in6_addr gateway;
-- 
1.7.3.4


