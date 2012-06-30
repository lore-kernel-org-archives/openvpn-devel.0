From: Gert Doering <gert@...1296...>
Date: Sat, 30 Jun 2012 22:50:43 +0200
Message-Id: <1341089443-2287-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Repair "tap server" mode brokenness caused
	by <stdbool.h> fallout
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

Operator/Cast precedence wrong: casting mac[0] to (bool) first - giving
"1" for "any mac address that does not start with 00:" - and only then
bit-anding with "1" - thus always returning "true".  Which, in turn,
leads to "reject all incoming packets with 'bad source address'".

OpenVPN bug #216.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mroute.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index aecb702..850e336 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -52,7 +52,7 @@ mroute_addr_init (struct mroute_addr *addr)
 static inline bool
 is_mac_mcast_addr (const uint8_t *mac)
 {
-  return (bool) mac[0] & 1;
+  return (bool) (mac[0] & 1);
 }
 
 static inline bool
-- 
1.7.8.6


