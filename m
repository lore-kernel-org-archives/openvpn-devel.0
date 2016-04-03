From: Mike Auty <mike.auty@...277...>
Message-ID: <57016648.70107@...277...>
Date: Sun, 3 Apr 2016 19:51:52 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] vlan: Add in functions for working with
 802.1q vlan, headers.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch adds in functions for extracting data from the 802.1q header.

The vlan_hdr_* functions now expect and return the values in host byte
order.  The callee doesn't need to perform any kind of conversion.

These functions are not used yet, but will be used in future patches.

Patch authored by Fabian Knittel <fabian.knittel@...2126...>.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/proto.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 428d10f..b24fd28 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -258,6 +258,76 @@ void ipv4_packet_size_verify (const uint8_t *data,
 # define OPENVPN_8021Q_MIN_VID 1
 # define OPENVPN_8021Q_MAX_VID 4094
 
+/*
+ * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the PCP in host byte order.
+ */
+static inline uint16_t
+vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
+{
+  return ntohs (hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP);
+}
+/*
+ * Retrieve the Canonical Format Indicator (CFI) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the CFI in host byte order.
+ */
+static inline uint16_t
+vlanhdr_get_cfi (const struct openvpn_8021qhdr *hdr)
+{
+  return ntohs (hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_CFI);
+}
+/*
+ * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the VID in host byte order.
+ */
+static inline uint16_t
+vlanhdr_get_vid (const struct openvpn_8021qhdr *hdr)
+{
+  return ntohs (hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
+}
+
+/*
+ * Set the Priority Code Point (PCP) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param pcp The PCP to set (in host byte order).
+ */
+static inline void
+vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const uint16_t pcp)
+{
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_PCP) |
+		     (htons (pcp) & OPENVPN_8021Q_MASK_PCP);
+}
+/*
+ * Set the Canonical Format Indicator (CFI) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param cfi The CFI to set (in host byte order).
+ */
+static inline void
+vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const uint16_t cfi)
+{
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_CFI) |
+		     (htons (cfi) & OPENVPN_8021Q_MASK_CFI);
+}
+/*
+ * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param vid The VID to set (in host byte order).
+ */
+static inline void
+vlanhdr_set_vid (struct openvpn_8021qhdr *hdr, const uint16_t vid)
+{
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) |
+		     (htons (vid) & OPENVPN_8021Q_MASK_VID);
+}
 #endif
 
 #endif
-- 
2.7.1

