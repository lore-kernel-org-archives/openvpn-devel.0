From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 28 Apr 2010 16:55:14 +0200
Message-Id: <1272466514-18866-7-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
References: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 6/6] vlan: move htons / ntohs into
	vlanhdr_get/_set functions
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

The vlanhdr_set_*() family of methods expected the passed values to be in
network byte order.  Therefore all invocations used htons() on the parameter.

The vlanhdr_get_*() family of methods returned the values in network byte
order.  Therefore all invocations used ntohs() on the return value.

The patch moves all htons() and ntohs() conversions into the vlan_hdr_*
functions to avoid the needless repetition.  The vlan_hdr_* functions now
expect and return the values in host byte order.  The callee doesn't need
to perform any kind of conversion.

Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 multi.c |   14 +++++++-------
 proto.h |   33 +++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/multi.c b/multi.c
index 2f531c2..b77791a 100644
--- a/multi.c
+++ b/multi.c
@@ -1946,7 +1946,7 @@ buf_filter_incoming_vlan_tags (const struct buffer *buf)
   if (ntohs (vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
     return false; /* Frame is untagged.  */
 
-  vid = vlanhdr_get_vid(vlanhdr);
+  vid = vlanhdr_get_vid (vlanhdr);
   if (vid == 0)
     return false; /* Frame only priority-tagged.  */
 
@@ -2228,8 +2228,8 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
 
   /* Tagged packet. */
 
-  vid = ntohs (vlanhdr_get_vid (&vlanhdr));
-  pcp = ntohs (vlanhdr_get_pcp (&vlanhdr));
+  vid = vlanhdr_get_vid (&vlanhdr);
+  pcp = vlanhdr_get_pcp (&vlanhdr);
 
   if (c->options.vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY)
     {
@@ -2265,7 +2265,7 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
 	 of the header intact. */
       msg (D_VLAN_DEBUG, "removing vlan-tag from priority frame: vid: %u, wrapped proto/len: 0x%04x, prio: %u",
            vid, ntohs (vlanhdr.proto), pcp);
-      vlanhdr_set_vid (&vlanhdr, htons (0));
+      vlanhdr_set_vid (&vlanhdr, 0);
       memcpy (BPTR (buf), &vlanhdr, sizeof vlanhdr);
     }
 
@@ -2315,11 +2315,11 @@ multi_prepend_vlan_tag (const struct context *c, struct buffer *buf)
       memcpy (vlanhdr, &eth, sizeof eth);
       vlanhdr->tpid = htons (OPENVPN_ETH_P_8021Q);
       vlanhdr->proto = eth.proto;
-      vlanhdr_set_pcp (vlanhdr, htons (0));
-      vlanhdr_set_cfi (vlanhdr, htons (0));
+      vlanhdr_set_pcp (vlanhdr, 0);
+      vlanhdr_set_cfi (vlanhdr, 0);
     }
 
-  vlanhdr_set_vid (vlanhdr, htons (c->options.vlan_pvid));
+  vlanhdr_set_vid (vlanhdr, c->options.vlan_pvid);
 
   msg (D_VLAN_DEBUG, "tagging frame: vid %u (wrapping proto/len: %04x)",
        c->options.vlan_pvid, vlanhdr->proto);
diff --git a/proto.h b/proto.h
index d8e5ea7..c1bd606 100644
--- a/proto.h
+++ b/proto.h
@@ -226,52 +226,73 @@ void ipv4_packet_size_verify (const uint8_t *data,
 
 /*
  * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the PCP in host byte order.
  */
 static inline uint16_t
 vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
 {
-  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP;
+  return ntohs (hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP);
 }
 /*
  * Retrieve the Canonical Format Indicator (CFI) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the CFI in host byte order.
  */
 static inline uint16_t
 vlanhdr_get_cfi (const struct openvpn_8021qhdr *hdr)
 {
-  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_CFI;
+  return ntohs (hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_CFI);
 }
 /*
  * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the VID in host byte order.
  */
 static inline uint16_t
 vlanhdr_get_vid (const struct openvpn_8021qhdr *hdr)
 {
-  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID;
+  return ntohs (hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }
 
 /*
  * Set the Priority Code Point (PCP) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param pcp The PCP to set (in host byte order).
  */
 static inline void
 vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const uint16_t pcp)
 {
-  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_PCP) | (pcp & OPENVPN_8021Q_MASK_PCP);
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_PCP) |
+		     (htons (pcp) & OPENVPN_8021Q_MASK_PCP);
 }
 /*
  * Set the Canonical Format Indicator (CFI) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param cfi The CFI to set (in host byte order).
  */
 static inline void
 vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const uint16_t cfi)
 {
-  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_CFI) | (cfi & OPENVPN_8021Q_MASK_CFI);
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_CFI) |
+		     (htons (cfi) & OPENVPN_8021Q_MASK_CFI);
 }
 /*
  * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param vid The VID to set (in host byte order).
  */
 static inline void
 vlanhdr_set_vid (struct openvpn_8021qhdr *hdr, const uint16_t vid)
 {
-  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (vid & OPENVPN_8021Q_MASK_VID);
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) |
+		     (htons (vid) & OPENVPN_8021Q_MASK_VID);
 }
 #endif
 
-- 
1.7.0


