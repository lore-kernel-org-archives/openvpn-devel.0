From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 28 Apr 2010 16:55:13 +0200
Message-Id: <1272466514-18866-6-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
References: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 5/6] vlan: is_ipv4: fix position of variable
	definition
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

To avoid difficulties on older / stricter C compilers, this patch moves the
variable definition to the beginning of the block in is_ipv4().

Found by Peter Stuge.

Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 proto.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/proto.c b/proto.c
index 64486de..5a9d3a6 100644
--- a/proto.c
+++ b/proto.c
@@ -54,10 +54,10 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
       if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
+        const struct openvpn_8021qhdr *evh;
         if (BLEN (buf) < (int)(sizeof (struct openvpn_8021qhdr)
 	    + sizeof (struct openvpn_iphdr)))
 	  return false;
-        const struct openvpn_8021qhdr *evh;
         evh = (const struct openvpn_8021qhdr *) BPTR (buf);
         if (ntohs (evh->proto) != OPENVPN_ETH_P_IPV4)
           return false;
-- 
1.7.0


