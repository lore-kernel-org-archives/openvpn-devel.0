From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:17 +0200
Message-Id: <1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and remove VLAN
	identifiers on outgoing and incoming frames
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

This patch adds parsing of the IEEE 802.1Q headers for incoming and outgoing
ethernet frames.

For frames coming in from the tap interface, the 802.1Q header is parsed and
translated into a regular Ethernet II header.  Note that the Priority Code
Point (PCP) and Canonical Format Indicator (CFI) fields contained within the
802.1Q header are ignored.  Only the VLAN Identifier (VID) is used.

For frames going out over the tap interface, the Ethernet II header is
replaced with a 802.1Q-based header.  PCP and CFI are permanently set to 0.
The VID is set according to the instance's vlan_tag value (also see patch
adding the "--vlan-tag" option).
---
 multi.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multi.h |    5 ++++
 proto.h |   34 +++++++++++++++++++++++++----
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/multi.c b/multi.c
index 342871a..c2563a0 100644
--- a/multi.c
+++ b/multi.c
@@ -2117,6 +2117,73 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 }
 
 /*
+ * Removes the VLAN tagging of a frame and returns the frame's VID.  Frames
+ * without tagging are dropped.
+ */
+static int16_t
+remove_vlan_identifier (struct buffer *buf)
+{
+  struct openvpn_ethhdr eth;
+  struct openvpn_8021qhdr vlanhdr;
+  int16_t vid;
+
+  if (BLEN (buf) < (sizeof (struct openvpn_8021qhdr)))
+    goto err;
+
+  vlanhdr = *(const struct openvpn_8021qhdr *) BPTR (buf);
+
+  if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
+    {
+      /* Drop untagged frames */
+      goto err;
+    }
+
+  /* Ethernet II frame with 802.1Q */
+  vid = ntohs (vlan_get_vid (&vlanhdr));
+  memcpy (&eth, &vlanhdr, sizeof (eth));
+  eth.proto = vlanhdr.proto;
+
+  buf_advance (buf, SIZE_ETH_TO_8021Q_HDR);
+  memcpy (BPTR (buf), &eth, sizeof eth);
+
+  return vid;
+err:
+  /* Drop the frame. */
+  buf->len = 0;
+  return -1;
+}
+
+/*
+ * Adds VLAN tagging to a frame.  Short frames that can't be tagged are
+ * dropped.
+ */
+void
+multi_prepend_vlan_identifier (struct multi_instance *mi, struct buffer *buf)
+{
+  struct openvpn_ethhdr eth;
+  struct openvpn_8021qhdr vlanhdr;
+  uint8_t *p;
+
+  /* Frame too small or not enough head room for VLAN tag? */
+  if ((BLEN (buf) < (int) sizeof (struct openvpn_ethhdr)) ||
+      (buf_reverse_capacity (buf) < SIZE_ETH_TO_8021Q_HDR))
+    {
+      /* Drop the frame. */
+      buf->len = 0;
+      return;
+    }
+
+  eth = *(const struct openvpn_ethhdr *) BPTR (buf);
+  memcpy (&vlanhdr, &eth, sizeof eth);
+  vlanhdr.tpid = htons (OPENVPN_ETH_P_8021Q);
+  vlanhdr.proto = eth.proto;
+  vlan_set_vid (&vlanhdr, htons (mi->context.options.vlan_tag));
+
+  ASSERT (p = buf_prepend (buf, SIZE_ETH_TO_8021Q_HDR));
+  memcpy (p, &vlanhdr, sizeof vlanhdr);
+}
+
+/*
  * Process packets in the TUN/TAP interface -> TCP/UDP socket direction,
  * i.e. server -> client direction.
  */
@@ -2158,6 +2225,12 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
        * the appropriate multi_instance object.
        */
 
+      if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
+        {
+	  if (remove_vlan_identifier (&m->top.c2.buf) == -1)
+	    return false;
+        }
+
       mroute_flags = mroute_extract_addr_from_packet (&src,
 						      &dest,
 #ifdef ENABLE_PF
diff --git a/multi.h b/multi.h
index ad26c12..26b3e1a 100644
--- a/multi.h
+++ b/multi.h
@@ -405,6 +405,7 @@ multi_get_timeout (struct multi_context *m, struct timeval *dest)
 static inline bool
 multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flags)
 {
+  void multi_prepend_vlan_identifier (struct multi_instance *mi, struct buffer *buf);
   struct multi_instance *mi = m->pending;
   bool ret = true;
 
@@ -415,6 +416,10 @@ multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flag
 	  mi->context.c2.to_tun.len);
 #endif
   set_prefix (mi);
+  if (mi->context.options.vlan_tag)
+    {
+      multi_prepend_vlan_identifier (mi, &mi->context.c2.to_tun);
+    }
   process_outgoing_tun (&mi->context);
   ret = multi_process_post (m, mi, mpp_flags);
   clear_prefix ();
diff --git a/proto.h b/proto.h
index f26cbc0..671331f 100644
--- a/proto.h
+++ b/proto.h
@@ -61,20 +61,26 @@ struct openvpn_ethhdr
 # define OPENVPN_ETH_P_IPV4   0x0800  /* IPv4 protocol */
 # define OPENVPN_ETH_P_IPV6   0x86DD  /* IPv6 protocol */
 # define OPENVPN_ETH_P_ARP    0x0806  /* ARP protocol */
+# define OPENVPN_ETH_P_8021Q  0x8100  /* 802.1Q protocol */
   uint16_t proto;                     /* packet type ID field */
 };
 
-# define OPENVPN_ETH_P_8021Q  0x8100  /* 802.1Q protocol */
-
 struct openvpn_8021qhdr
 {
   uint8_t dest[OPENVPN_ETH_ALEN];     /* destination ethernet addr */
   uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
 
-  uint32_t tag;                       /* packet 802.1Q Vlan Tag */
-  uint16_t proto;                     /* packet type ID field */
+  uint16_t tpid;                      /* 802.1Q Tag Protocol Identifier */
+# define OPENVPN_8021Q_MASK_VID htons (0xFFFE) /* mask VID out of tag */
+  uint16_t tag;                       /* tag field containing PCP, CFI, VID */
+  uint16_t proto;                     /* contained packet type ID field */
 };
 
+/*
+ * Size difference between a regular Ethernet II header and an Ethernet II
+ * header with additional IEEE 802.1Q tagging.
+ */
+#define SIZE_ETH_TO_8021Q_HDR (sizeof (struct openvpn_8021qhdr) - sizeof (struct openvpn_ethhdr))
 
 struct openvpn_arp {
 # define ARP_MAC_ADDR_TYPE 0x0001
@@ -213,6 +219,24 @@ void ipv4_packet_size_verify (const uint8_t *data,
 
 
 #define OPENVPN_8021Q_MIN_VID 1
-#define OPENVPN_8021Q_MAX_VID 0xFFFE
+#define OPENVPN_8021Q_MAX_VID ntohs (OPENVPN_8021Q_MASK_VID)
+
+/*
+ * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
+ */
+static inline int
+vlan_get_vid (const struct openvpn_8021qhdr *hdr)
+{
+  return hdr->tag & OPENVPN_8021Q_MASK_VID;
+}
+
+/*
+ * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
+ */
+static inline void
+vlan_set_vid (struct openvpn_8021qhdr *hdr, const int vid)
+{
+  hdr->tag = (hdr->tag & ~OPENVPN_8021Q_MASK_VID) | (vid & OPENVPN_8021Q_MASK_VID);
+}
 
 #endif
-- 
1.7.0


