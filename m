From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 28 Feb 2010 23:07:47 +0100
Message-Id: <1267394867-2823-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Implement --passtos for tagged ethernet
	frames
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
Cc: David Sommerseth <dazo@...384...>, Davide Guerri <dguerri@...384...>

From: Davide Guerri <dguerri@...384...>

This patch makes it possible to use the --passtos option with 802.1Q tagged
ethernet frames.

sf.net tracker:
<https://sourceforge.net/tracker/?func=detail&aid=2829878&group_id=48978&atid=454721>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 proto.c |   14 +++++++++++---
 proto.h |   12 ++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/proto.c b/proto.c
index 72a3c6b..1f582ce 100644
--- a/proto.c
+++ b/proto.c
@@ -53,9 +53,17 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
 	  + sizeof (struct openvpn_iphdr)))
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
-      if (ntohs (eh->proto) != OPENVPN_ETH_P_IPV4)
-	return false;
-      offset = sizeof (struct openvpn_ethhdr);
+      if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
+        const struct openvpn_8021qhdr *evh;
+        evh = (const struct openvpn_8021qhdr *) BPTR (buf);
+        if (ntohs (evh->proto) != OPENVPN_ETH_P_IPV4)
+          return false;
+        else
+          offset = sizeof (struct openvpn_8021qhdr);
+      } else if (ntohs (eh->proto) != OPENVPN_ETH_P_IPV4)
+        return false;
+      else
+        offset = sizeof (struct openvpn_ethhdr);
     }
   else
     return false;
diff --git a/proto.h b/proto.h
index f26fc8c..628e991 100644
--- a/proto.h
+++ b/proto.h
@@ -64,6 +64,18 @@ struct openvpn_ethhdr
   uint16_t proto;                     /* packet type ID field */
 };
 
+# define OPENVPN_ETH_P_8021Q  0x8100  /* 802.1Q protocol */
+
+struct openvpn_8021qhdr
+{
+  uint8_t dest[OPENVPN_ETH_ALEN];     /* destination ethernet addr */
+  uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
+
+  uint32_t tag;                       /* packet 802.1Q Vlan Tag */
+  uint16_t proto;                     /* packet type ID field */
+};
+
+
 struct openvpn_arp {
 # define ARP_MAC_ADDR_TYPE 0x0001
   uint16_t mac_addr_type;       /* 0x0001 */
-- 
1.6.6.1


