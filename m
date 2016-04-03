From: Mike Auty <mike.auty@...277...>
Message-ID: <57016655.7070604@...277...>
Date: Sun, 3 Apr 2016 19:52:05 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/7] vlan: Prepend and remove VLAN
 identifiers on outgoing and, incoming frames
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

This patch adds parsing of the IEEE 802.1Q headers for incoming and outgoing
ethernet frames.

For frames coming in from the tap device, the 802.1Q header is parsed and
translated into a regular Ethernet II header.

For frames where the Priority Code Point (PCP) is non-zero, the 802.1Q tagging
behaviour is to completely drop the tagging.  Some tagging-aware appliances
that set both the VID and PCP fields would cause OpenVPN to forward
prio-tagged frames to clients, which wouldn't understand and therefore
drop them.

The only case where the tagging is kept is when the frame isn't vlan-tagged and
only prio-tagged.  In that case the sender clearly wanted to send a tagged
frame on an otherwise untagged network and we honour that decision by not
fiddling with it.

For frames going out over the tap interface, the Ethernet II header is
replaced with a 802.1Q-based header.  PCP and CFI are permanently set to 0,
unless the frame was a frame tagged only with priority, in which case the priority
is copied across.  The VID is set according to the instance's vlan_pvid value
(also see patch adding the "--vlan-pvid" option).

In "--vlan-accept untagged" mode, VLAN-tagged frames coming in from the tap
device are dropped.  Untagged or priority tagged frames are assigned the VID of
the global "--vlan-pvid" setting.  Outgoing frames are sent untagged or
priority-tagged. Outgoing frames are dropped if the VID does not match the
global "--vlan-pvid" setting.

In "--vlan-accept all" mode, VLAN-tagged frames coming in from the tap device
are handled the same way as in the "tagged" mode. Untagged or priority
tagged frames are handled the same was as in "untagged" mode. Outgoing frames
are tagged if they don't match the global tag_pvid value. Otherwise they go
out untagged.

Broadcasts from client to client or from tap interface to clients are now
filtered based on whether the client belongs to the correct VLAN id.

Thanks for suggestions and code snippets to Peter Stuge.

Patch authored by Fabian Knittel <fabian.knittel@...2126...>.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/multi.h |  33 ++++++++
 2 files changed, 249 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 61180f6..09bd947 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -2135,6 +2136,10 @@ multi_bcast (struct multi_context *m,
 		    }
 		}
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+	      if (vid != 0 && vid != mi->context.options.vlan_pvid)
+		continue;
+#endif
 	      multi_add_mbuf (m, mi, mb);
 	    }
 	}
@@ -2350,6 +2355,37 @@ done:
     gc_free (&gc);
 }
 
+#ifdef ENABLE_VLAN_TAGGING
+/*
+ * Decides whether or not to drop an ethernet frame.  VLAN-tagged frames are
+ * dropped.  All other frames are accepted.
+ *
+ * @param buf The ethernet frame.
+ * @return    Returns true if the frame should be dropped, false otherwise.
+ */
+static bool
+buf_filter_incoming_8021q_vlan_tag (const struct buffer *buf)
+{
+  const struct openvpn_8021qhdr *vlanhdr;
+  uint16_t vid;
+
+  if (BLEN (buf) < (int) sizeof (struct openvpn_8021qhdr))
+    return false; /* Frame too small.  */
+
+  vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
+
+  if (ntohs (vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
+    return false; /* Frame is untagged.  */
+
+  vid = vlanhdr_get_vid (vlanhdr);
+  if (vid == 0)
+    return false; /* Frame only priority-tagged.  */
+
+  msg (D_VLAN_DEBUG, "dropping VLAN-tagged incoming frame, vid: %u", vid);
+  return true;
+}
+#endif
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
@@ -2502,6 +2538,18 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	      struct mroute_addr edest;
 	      mroute_addr_reset (&edest);
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+	      if (m->top.options.vlan_tagging)
+		{
+		  if (buf_filter_incoming_8021q_vlan_tag (&c->c2.to_tun))
+		    {
+		      /* Drop VLAN-tagged frame. */
+		      c->c2.to_tun.len = 0;
+		    }
+		  else
+		    vid = c->options.vlan_pvid;
+		}
+#endif
 	      /* extract packet source and dest addresses */
 	      mroute_flags = mroute_extract_addr_from_packet (&src,
 							      &dest,
@@ -2582,6 +2630,165 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
   return ret;
 }
 
+#ifdef ENABLE_VLAN_TAGGING
+/*
+ * For vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY:
+ *   Only untagged frames and frames that are priority-tagged (VID == 0) are
+ *   accepted.  (This means that VLAN-tagged frames are dropped.)  For frames
+ *   that aren't dropped, the global vlan_pvid is returned as VID.
+ *
+ * For vlan_accept == VAF_ONLY_VLAN_TAGGED:
+ *   If a frame is VLAN-tagged the tagging is removed and the embedded VID is
+ *   returned.  Any included priority information is lost.
+ *   If a frame isn't VLAN-tagged, the frame is dropped.
+ *
+ * For vlan_accept == VAF_ALL:
+ *   Accepts both VLAN-tagged and untagged (or priority-tagged) frames and
+ *   and handles them as described above.
+ *
+ * @param c   The global context.
+ * @param buf The ethernet frame.
+ * @return    Returns -1 if the frame is dropped or the VID if it is accepted.
+ */
+static int16_t
+multi_remove_8021q_vlan_tag (const struct context *c, struct buffer *buf)
+{
+  struct openvpn_ethhdr eth;
+  struct openvpn_8021qhdr vlanhdr;
+  uint16_t vid;
+  uint16_t pcp;
+
+  if (BLEN (buf) < (sizeof (struct openvpn_8021qhdr)))
+    goto drop;
+
+  vlanhdr = *(const struct openvpn_8021qhdr *) BPTR (buf);
+
+  if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
+    {
+      /* Untagged frame. */
+
+      if (c->options.vlan_accept == VAF_ONLY_VLAN_TAGGED)
+	{
+	  /* We only accept vlan-tagged frames, so drop frames without vlan-tag
+	   */
+	  msg (D_VLAN_DEBUG, "dropping frame without vlan-tag (proto/len 0x%04x)",
+	       ntohs (vlanhdr.tpid));
+	  goto drop;
+	}
+
+      msg (D_VLAN_DEBUG, "assuming pvid for frame without vlan-tag, pvid: %u (proto/len 0x%04x)",
+	   c->options.vlan_pvid, ntohs (vlanhdr.tpid));
+      /* We return the global PVID as the VID for the untagged frame. */
+      return c->options.vlan_pvid;
+    }
+
+  /* Tagged frame. */
+
+  vid = vlanhdr_get_vid (&vlanhdr);
+  pcp = vlanhdr_get_pcp (&vlanhdr);
+
+  if (c->options.vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY)
+    {
+      /* We only accept untagged / prio-tagged frames.
+       */
+
+      if (vid != 0)
+	{
+	  /* VLAN-tagged frame - which isn't acceptable here - so drop it. */
+	  msg (D_VLAN_DEBUG, "dropping frame with vlan-tag, vid: %u (proto/len 0x%04x)",
+	       vid, ntohs (vlanhdr.proto));
+	  goto drop;
+	}
+
+      /* Fall-through for prio-tagged frames. */
+    }
+
+  /* At this point the frame is acceptable to us.  It may be prio-tagged and/or
+     VLAN-tagged. */
+
+  if (vid != 0)
+    {
+      /* VLAN-tagged frame.  Strip the tagging.  Any priority information is lost. */
+
+      msg (D_VLAN_DEBUG, "removing vlan-tag from frame: vid: %u, wrapped proto/len: 0x%04x",
+           vid, ntohs (vlanhdr.proto));
+      memcpy (&eth, &vlanhdr, sizeof (eth));
+      eth.proto = vlanhdr.proto;
+
+      buf_advance (buf, SIZE_ETH_TO_8021Q_HDR);
+      memcpy (BPTR (buf), &eth, sizeof eth);
+
+      return vid;
+    }
+  else
+    {
+      /* Prio-tagged frame.  We assume that the sender knows what it's doing and
+         don't stript the tagging. */
+
+      /* We return the global PVID as the VID for the priority-tagged frame. */
+      return c->options.vlan_pvid;
+    }
+drop:
+  /* Drop the frame. */
+  buf->len = 0;
+  return -1;
+}
+
+/*
+ * Adds VLAN tagging to a frame.  Assumes vlan_accept == VAF_ONLY_VLAN_TAGGED
+ * or VAF_ALL and a matching PVID.
+ */
+void
+multi_prepend_8021q_vlan_tag (const struct context *c, struct buffer *buf)
+{
+  struct openvpn_ethhdr eth;
+  struct openvpn_8021qhdr *vlanhdr;
+
+  /* Frame too small? */
+  if (BLEN (buf) < (int) sizeof (struct openvpn_ethhdr))
+    goto drop;
+
+  eth = *(const struct openvpn_ethhdr *) BPTR (buf);
+  if (ntohs (eth.proto) == OPENVPN_ETH_P_8021Q)
+    {
+      /* Priority-tagged frame.  (VLAN-tagged frames couldn't have reached us
+         here.)  */
+
+      /* Frame too small for header type? */
+      if (BLEN (buf) < (int) (sizeof (struct openvpn_8021qhdr)))
+	goto drop;
+
+      vlanhdr = (struct openvpn_8021qhdr *) BPTR (buf);
+    }
+  else
+    {
+      /* Untagged frame. */
+
+      /* Not enough head room for VLAN tag? */
+      if (buf_reverse_capacity (buf) < SIZE_ETH_TO_8021Q_HDR)
+	goto drop;
+
+      vlanhdr = (struct openvpn_8021qhdr *) buf_prepend (buf, SIZE_ETH_TO_8021Q_HDR);
+
+      /* Initialise VLAN-tag ... */
+      memcpy (vlanhdr, &eth, sizeof eth);
+      vlanhdr->tpid = htons (OPENVPN_ETH_P_8021Q);
+      vlanhdr->proto = eth.proto;
+      vlanhdr_set_pcp (vlanhdr, 0);
+      vlanhdr_set_cfi (vlanhdr, 0);
+    }
+
+  vlanhdr_set_vid (vlanhdr, c->options.vlan_pvid);
+
+  msg (D_VLAN_DEBUG, "tagging frame: vid %u (wrapping proto/len: %04x)",
+       c->options.vlan_pvid, vlanhdr->proto);
+  return;
+drop:
+  /* Drop the frame. */
+  buf->len = 0;
+}
+#endif /* ENABLE_VLAN_TAGGING */
+
 /*
  * Process packets in the TUN/TAP interface -> TCP/UDP socket direction,
  * i.e. server -> client direction.
@@ -2629,6 +2836,15 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
        * the appropriate multi_instance object.
        */
 
+#ifdef ENABLE_VLAN_TAGGING
+      if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
+        {
+	  if ((vid = multi_remove_8021q_vlan_tag (&m->top,
+						  &m->top.c2.buf)) == -1)
+	    return false;
+        }
+#endif
+
       mroute_flags = mroute_extract_addr_from_packet (&src,
 						      &dest,
 #ifdef ENABLE_PF
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index ec1e7ab..d34445b 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -585,6 +585,10 @@ multi_get_timeout (struct multi_context *m, struct timeval *dest)
 static inline bool
 multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flags)
 {
+#ifdef ENABLE_VLAN_TAGGING
+  void multi_prepend_8021q_vlan_tag (const struct context *c,
+				     struct buffer *buf);
+#endif
   struct multi_instance *mi = m->pending;
   bool ret = true;
 
@@ -595,6 +599,35 @@ multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flag
 	  mi->context.c2.to_tun.len);
 #endif
   set_prefix (mi);
+#ifdef ENABLE_VLAN_TAGGING
+  if (m->top.options.vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY)
+    {
+      /* Packets aren't VLAN-tagged on the tap device.  */
+
+      if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
+	{
+	  /* Packet is coming from the wrong VID, drop it.  */
+	  mi->context.c2.to_tun.len = 0;
+	}
+    }
+  else if (m->top.options.vlan_accept == VAF_ALL)
+    {
+      /* Packets either need to be VLAN-tagged or not, depending on the
+	 packet's originating VID and the port's native VID (PVID).  */
+
+      if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
+	{
+	  /* Packets need to be VLAN-tagged, because the packet's VID does not
+	     match the port's PVID.  */
+	  multi_prepend_8021q_vlan_tag (&mi->context, &mi->context.c2.to_tun);
+	}
+    }
+  else if (m->top.options.vlan_accept == VAF_ONLY_VLAN_TAGGED)
+    {
+      /* All packets on the port (the tap device) need to be VLAN-tagged.  */
+      multi_prepend_8021q_vlan_tag (&mi->context, &mi->context.c2.to_tun);
+    }
+#endif
   process_outgoing_tun (&mi->context);
   ret = multi_process_post (m, mi, mpp_flags);
   clear_prefix ();
-- 
2.7.1

