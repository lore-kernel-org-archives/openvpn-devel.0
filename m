From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:21 +0200
Message-Id: <7beaba866768378115b52c8e39eebaa005f4859d.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 8/9] vlan: add debug logging to tagging /
	untagging
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

---
 multi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/multi.c b/multi.c
index 822ae29..661fd98 100644
--- a/multi.c
+++ b/multi.c
@@ -2143,11 +2143,15 @@ remove_vlan_identifier (struct buffer *buf)
   if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
     {
       /* Drop untagged frames */
+      msg (M_INFO, "dropping untagged ethernet frame (proto/len 0x%04x)",
+	   ntohs (vlanhdr.tpid));
       goto err;
     }
 
   /* Ethernet II frame with 802.1Q */
   vid = ntohs (vlan_get_vid (&vlanhdr));
+  msg (M_INFO, "untagging ethernet frame: vid: %u, wrapped proto/len: 0x%04x",
+       vid, ntohs (vlanhdr.proto));
   memcpy (&eth, &vlanhdr, sizeof (eth));
   eth.proto = vlanhdr.proto;
 
@@ -2189,6 +2193,8 @@ multi_prepend_vlan_identifier (struct multi_instance *mi, struct buffer *buf)
 
   ASSERT (p = buf_prepend (buf, SIZE_ETH_TO_8021Q_HDR));
   memcpy (p, &vlanhdr, sizeof vlanhdr);
+
+  msg (M_INFO, "tagging frame with vid %u, type is %04x", mi->context.options.vlan_tag, vlanhdr.proto);
 }
 
 /*
-- 
1.7.0


