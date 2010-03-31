From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:14 +0200
Message-Id: <c69b3d5e769d7d586643da4a95236747aa6ed04a.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 1/9] is_ipv4(): add packet length check for
	802.1Q packets
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

This patch adds an additional length check to is_ipv4().

Currently is_ipv4() only checks whether the frame is large enough for struct
openvpn_ethhdr. In case of an 802.1Q packet the function now also checks
whether the frame is large enough for struct openvpn_8021qhdr, which is 4 bytes
larger than struct openvpn_ethhdr.
---
 proto.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/proto.c b/proto.c
index 1f582ce..64486de 100644
--- a/proto.c
+++ b/proto.c
@@ -54,6 +54,9 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
       if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
+        if (BLEN (buf) < (int)(sizeof (struct openvpn_8021qhdr)
+	    + sizeof (struct openvpn_iphdr)))
+	  return false;
         const struct openvpn_8021qhdr *evh;
         evh = (const struct openvpn_8021qhdr *) BPTR (buf);
         if (ntohs (evh->proto) != OPENVPN_ETH_P_IPV4)
-- 
1.7.0


