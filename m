From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 28 Apr 2010 16:55:10 +0200
Message-Id: <1272466514-18866-3-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
References: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 2/6] vlan: use uint16_t for storage of the
	VID where possible
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

This patch switches from signed to unsigned short integers for storage of
the VID.  The change attempts to clarify, that the VID can't ever be negative.

The only place where the patch doesn't use unsigned int is for the return value
of remove_vlan_tag(): The function indicates errors by returning -1.

The patch should not cause any changes in behaviour.

The improvement was suggested by Peter Stuge.

Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 mroute.c  |    6 +++---
 mroute.h  |    6 +++---
 multi.c   |   24 ++++++++++++------------
 options.c |    2 +-
 options.h |    2 +-
 proto.h   |   12 ++++++------
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/mroute.c b/mroute.c
index 72ef91a..1263342 100644
--- a/mroute.c
+++ b/mroute.c
@@ -166,7 +166,7 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
 
 static void mroute_copy_ether_to_addr(struct mroute_addr *maddr,
 				      const uint8_t *eth_addr,
-				      int16_t vid)
+				      uint16_t vid)
 {
   maddr->type = MR_ADDR_ETHER;
   maddr->netbits = 0;
@@ -185,7 +185,7 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 			   struct mroute_addr *esrc,
 			   struct mroute_addr *edest,
 			   const struct buffer *buf,
-			   int16_t vid)
+			   uint16_t vid)
 {
   unsigned int ret = 0;
   if (BLEN (buf) >= (int) sizeof (struct openvpn_ethhdr))
@@ -323,7 +323,7 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
 	case MR_ADDR_ETHER:
 	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
 #ifdef ENABLE_VLAN_TAGGING
-	  buf_printf (&out, "@%d", *(int16_t*)(ma->addr + 6));
+	  buf_printf (&out, "@%u", *(uint16_t*)(ma->addr + 6));
 #endif
 	  break;
 	case MR_ADDR_IPV4:
diff --git a/mroute.h b/mroute.h
index ccf79ec..95ea443 100644
--- a/mroute.h
+++ b/mroute.h
@@ -140,7 +140,7 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
 				 struct mroute_addr *edest,
 				 const struct buffer *buf,
 				 int tunnel_type,
-				 int16_t bcast_domain)
+				 uint16_t vid)
 {
   unsigned int mroute_extract_addr_ipv4 (struct mroute_addr *src,
 					 struct mroute_addr *dest,
@@ -151,13 +151,13 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
 					  struct mroute_addr *esrc,
 					  struct mroute_addr *edest,
 					  const struct buffer *buf,
-					  int16_t vid);
+					  uint16_t vid);
   unsigned int ret = 0;
   verify_align_4 (buf);
   if (tunnel_type == DEV_TYPE_TUN)
     ret = mroute_extract_addr_ipv4 (src, dest, buf);
   else if (tunnel_type == DEV_TYPE_TAP)
-    ret = mroute_extract_addr_ether (src, dest, esrc, edest, buf, bcast_domain);
+    ret = mroute_extract_addr_ether (src, dest, esrc, edest, buf, vid);
   return ret;
 }
 
diff --git a/multi.c b/multi.c
index dfd23a3..1a8bbbf 100644
--- a/multi.c
+++ b/multi.c
@@ -1761,7 +1761,7 @@ multi_bcast (struct multi_context *m,
 	     const struct buffer *buf,
 	     const struct multi_instance *sender_instance,
 	     const struct mroute_addr *sender_addr,
-	     int16_t vid)
+	     uint16_t vid)
 {
   struct hash_iterator hi;
   struct hash_element *he;
@@ -1934,10 +1934,10 @@ buf_filter_incoming_vlan_tags (const struct buffer *buf)
 
       if (ntohs (vlanhdr->tpid) == OPENVPN_ETH_P_8021Q)
         {
-	  const int16_t vid = vlanhdr_get_vid(vlanhdr);
+	  const uint16_t vid = vlanhdr_get_vid(vlanhdr);
 	  if (vid != 0)
 	    {
-	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %d", vid);
+	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %u", vid);
 	      return true;
 	    }
 	}
@@ -2063,9 +2063,9 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
 	    {
 #ifdef ENABLE_VLAN_TAGGING
-	      int16_t vid = 0;
+	      uint16_t vid = 0;
 #else
-	      const int16_t vid = 0;
+	      const uint16_t vid = 0;
 #endif
 #ifdef ENABLE_PF
 	      struct mroute_addr edest;
@@ -2185,8 +2185,8 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
 {
   struct openvpn_ethhdr eth;
   struct openvpn_8021qhdr vlanhdr;
-  int16_t vid;
-  int16_t pcp;
+  uint16_t vid;
+  uint16_t pcp;
 
   if (BLEN (buf) < (sizeof (struct openvpn_8021qhdr)))
     goto drop;
@@ -2206,7 +2206,7 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
 	  goto drop;
 	}
 
-      msg (D_VLAN_DEBUG, "assuming pvid for frame without vlan-tag, pvid: %d (proto/len 0x%04x)",
+      msg (D_VLAN_DEBUG, "assuming pvid for frame without vlan-tag, pvid: %u (proto/len 0x%04x)",
 	   c->options.vlan_pvid, ntohs (vlanhdr.tpid));
       /* We return the global PVID as the VID for the untagged frame. */
       return c->options.vlan_pvid;
@@ -2223,7 +2223,7 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
 	{
 	  /* We only accept untagged frames or priority-tagged frames. So drop
 	     VLAN-tagged frames. */
-	  msg (D_VLAN_DEBUG, "dropping frame with vlan-tag, vid: %d (proto/len 0x%04x)",
+	  msg (D_VLAN_DEBUG, "dropping frame with vlan-tag, vid: %u (proto/len 0x%04x)",
 	       vid, ntohs (vlanhdr.proto));
 	  goto drop;
 	}
@@ -2236,7 +2236,7 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
     {
       /* VLAN-tagged without priority information. */
 
-      msg (D_VLAN_DEBUG, "removing vlan-tag from frame: vid: %d, wrapped proto/len: 0x%04x",
+      msg (D_VLAN_DEBUG, "removing vlan-tag from frame: vid: %u, wrapped proto/len: 0x%04x",
            vid, ntohs (vlanhdr.proto));
       memcpy (&eth, &vlanhdr, sizeof (eth));
       eth.proto = vlanhdr.proto;
@@ -2249,7 +2249,7 @@ remove_vlan_tag (const struct context *c, struct buffer *buf)
       /* VLAN-tagged _with_ priority information.  We turn this frame into
 	 a pure priority frame.  I.e. we clear out the VID but leave the rest
 	 of the header intact. */
-      msg (D_VLAN_DEBUG, "removing vlan-tag from priority frame: vid: %d, wrapped proto/len: 0x%04x, prio: %d",
+      msg (D_VLAN_DEBUG, "removing vlan-tag from priority frame: vid: %u, wrapped proto/len: 0x%04x, prio: %u",
            vid, ntohs (vlanhdr.proto), pcp);
       vlanhdr_set_vid (&vlanhdr, htons (0));
       memcpy (BPTR (buf), &vlanhdr, sizeof vlanhdr);
@@ -2307,7 +2307,7 @@ multi_prepend_vlan_tag (const struct context *c, struct buffer *buf)
 
   vlanhdr_set_vid (vlanhdr, htons (c->options.vlan_pvid));
 
-  msg (D_VLAN_DEBUG, "tagging frame: vid %d (wrapping proto/len: %04x)",
+  msg (D_VLAN_DEBUG, "tagging frame: vid %u (wrapping proto/len: %04x)",
        c->options.vlan_pvid, vlanhdr->proto);
   return;
 drop:
diff --git a/options.c b/options.c
index 2d47f20..827b9f0 100644
--- a/options.c
+++ b/options.c
@@ -5810,7 +5810,7 @@ add_option (struct options *options,
       if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
 	  options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
 	{
-	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %d and <= %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
+	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %u and <= %u", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
 	  goto err;
 	}
     }
diff --git a/options.h b/options.h
index 5c4851f..a278561 100644
--- a/options.h
+++ b/options.h
@@ -522,7 +522,7 @@ struct options
 #ifdef ENABLE_VLAN_TAGGING
   bool vlan_tagging;
   enum vlan_acceptable_frames vlan_accept;
-  int vlan_pvid;
+  uint16_t vlan_pvid;
 #endif
 };
 
diff --git a/proto.h b/proto.h
index 5c641ff..d8e5ea7 100644
--- a/proto.h
+++ b/proto.h
@@ -227,7 +227,7 @@ void ipv4_packet_size_verify (const uint8_t *data,
 /*
  * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
  */
-static inline int
+static inline uint16_t
 vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
 {
   return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP;
@@ -235,7 +235,7 @@ vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
 /*
  * Retrieve the Canonical Format Indicator (CFI) from the IEEE 802.1Q header.
  */
-static inline int
+static inline uint16_t
 vlanhdr_get_cfi (const struct openvpn_8021qhdr *hdr)
 {
   return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_CFI;
@@ -243,7 +243,7 @@ vlanhdr_get_cfi (const struct openvpn_8021qhdr *hdr)
 /*
  * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
  */
-static inline int
+static inline uint16_t
 vlanhdr_get_vid (const struct openvpn_8021qhdr *hdr)
 {
   return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID;
@@ -253,7 +253,7 @@ vlanhdr_get_vid (const struct openvpn_8021qhdr *hdr)
  * Set the Priority Code Point (PCP) in an IEEE 802.1Q header.
  */
 static inline void
-vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const int pcp)
+vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const uint16_t pcp)
 {
   hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_PCP) | (pcp & OPENVPN_8021Q_MASK_PCP);
 }
@@ -261,7 +261,7 @@ vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const int pcp)
  * Set the Canonical Format Indicator (CFI) in an IEEE 802.1Q header.
  */
 static inline void
-vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const int cfi)
+vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const uint16_t cfi)
 {
   hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_CFI) | (cfi & OPENVPN_8021Q_MASK_CFI);
 }
@@ -269,7 +269,7 @@ vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const int cfi)
  * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
  */
 static inline void
-vlanhdr_set_vid (struct openvpn_8021qhdr *hdr, const int vid)
+vlanhdr_set_vid (struct openvpn_8021qhdr *hdr, const uint16_t vid)
 {
   hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (vid & OPENVPN_8021Q_MASK_VID);
 }
-- 
1.7.0


