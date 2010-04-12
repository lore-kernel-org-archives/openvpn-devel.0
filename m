Message-ID: <4BC330A0.5000209@...1338...>
Date: Mon, 12 Apr 2010 16:39:28 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040006030703050802090704"
Subject: [Openvpn-devel] [PULL-REQUEST v3] VLAN-Tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040006030703050802090704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

changes since the last round of patches:

 - Added Signed-Off-By to all patches.

 - Properly mentioned "--vlan-accept all" mode in options.c (it was
   missing in a few places).

 - Split out '--vlan-accept raw' to '--vlan-tagging' boolean switch.
   Quoting from the patch description:

>     As '--vlan-accept raw' is a global behavioural modifier, it makes more sense
>     to break it out into a global '--vlan-tagging' boolean switch. (Which
>     matches the approach chosen in the initial patch-set.)
> 
>     '--vlan-accept tagged|untagged|all' now only specifies the behaviour of the
>     tap device, while '--vlan-tagging' specifies whether OpenVPN should take a
>     closer look at the tagging of packets.
> 
>     The patch is only a configuration option change.  The behaviour should
>     remain the same.
> 
>       New                                       Old
>       ------------------------------------------------------------------
> 
>       not specifying anything is equivalent to not specifying anything
> 
>       not specifying anything is equivalent to '--vlan-accept raw'
> 
>       '--vlan-tagging' +
>       '--vlan-accept tagged'  is equivalent to '--vlan-accept tagged'
> 
>       '--vlan-tagging' +
>       '--vlan-accept untagged' is equivalent to '--vlan-accept untagged'
> 
>       '--vlan-tagging'        is equivalent to '--vlan-accept all'
> 
>       '--vlan-tagging' +
>       '--vlan-accept all'     is equivalent to '--vlan-accept all'

All further work will be bug-fix only.


The rebased changes are available from my git repo [1] on branch
'feat_vlan'. On branch 'feat_vlan_tagging' the same changes are
available as incremental patches to the 'feat_vlan_tagging' branch on
openvpn-testing.git. (Only the non-incremental patches provide all
missing Signed-Off-Bys).

For reviewers who haven't had a look at the other patches yet, I've
attached a diff containing all changes introduced by the current patch-set.

Cheers
Fabian

1: git://fsmi-dev.fsmi.uni-karlsruhe.de/openvpn.git

--------------040006030703050802090704
Content-Type: text/x-diff; name="vlan-tagging_single.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vlan-tagging_single.patch"

diff --git a/configure.ac b/configure.ac
index 116ff7c..b99bc11 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,12 @@ AC_ARG_ENABLE(selinux,
    [SELINUX="yes"]
 )
 
+AC_ARG_ENABLE(vlan-tagging,
+   [  --disable-vlan-tagging  Disable support for VLAN tagging/untagging],
+   [VLAN_TAGGING="$enableval"],
+   [VLAN_TAGGING="yes"]
+)
+
 AC_ARG_WITH(ssl-headers,
    [  --with-ssl-headers=DIR  Crypto/SSL Include files location],
    [CS_HDR_DIR="$withval"]
@@ -886,6 +892,12 @@ if test "$SELINUX" = "yes"; then
    )
 fi
 
+dnl enable --vlan-tagging
+if test "$VLAN_TAGGING" = "yes"; then
+   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable VLAN tagging/untagging])
+fi
+
+
 TAP_ID="PRODUCT_TAP_ID"
 TAP_WIN32_MIN_MAJOR="PRODUCT_TAP_WIN32_MIN_MAJOR"
 TAP_WIN32_MIN_MINOR="PRODUCT_TAP_WIN32_MIN_MINOR"
diff --git a/errlevel.h b/errlevel.h
index a092d3f..68128b9 100644
--- a/errlevel.h
+++ b/errlevel.h
@@ -144,6 +144,8 @@
 #define D_PF_DROPPED_BCAST   LOGLEV(7, 71, M_DEBUG)  /* packet filter dropped a broadcast packet */
 #define D_PF_DEBUG           LOGLEV(7, 72, M_DEBUG)  /* packet filter debugging, must also define PF_DEBUG in pf.h */
 
+#define D_VLAN_DEBUG         LOGLEV(7, 72, M_DEBUG)  /* show VLAN tagging/untagging debug info */
+
 #define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed description of each handshake */
 #define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info from tls_session routines */
 #define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h debugging info */
diff --git a/mroute.c b/mroute.c
index 9d8fa66..72ef91a 100644
--- a/mroute.c
+++ b/mroute.c
@@ -164,12 +164,28 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
   return ret;
 }
 
+static void mroute_copy_ether_to_addr(struct mroute_addr *maddr,
+				      const uint8_t *eth_addr,
+				      int16_t vid)
+{
+  maddr->type = MR_ADDR_ETHER;
+  maddr->netbits = 0;
+  memcpy (maddr->addr, eth_addr, 6);
+#ifdef ENABLE_VLAN_TAGGING
+  maddr->len = 8;
+  memcpy (maddr->addr + 6, &vid, 2);
+#else
+  maddr->len = 6;
+#endif
+}
+
 unsigned int
 mroute_extract_addr_ether (struct mroute_addr *src,
 			   struct mroute_addr *dest,
 			   struct mroute_addr *esrc,
 			   struct mroute_addr *edest,
-			   const struct buffer *buf)
+			   const struct buffer *buf,
+			   int16_t vid)
 {
   unsigned int ret = 0;
   if (BLEN (buf) >= (int) sizeof (struct openvpn_ethhdr))
@@ -177,17 +193,11 @@ mroute_extract_addr_ether (struct mroute_addr *src,
       const struct openvpn_ethhdr *eth = (const struct openvpn_ethhdr *) BPTR (buf);
       if (src)
 	{
-	  src->type = MR_ADDR_ETHER;
-	  src->netbits = 0;
-	  src->len = 6;
-	  memcpy (src->addr, eth->source, 6);
+          mroute_copy_ether_to_addr(src, eth->source, vid);
 	}
       if (dest)
 	{
-	  dest->type = MR_ADDR_ETHER;
-	  dest->netbits = 0;
-	  dest->len = 6;
-	  memcpy (dest->addr, eth->dest, 6);
+          mroute_copy_ether_to_addr(dest, eth->dest, vid);
 
 	  /* ethernet broadcast/multicast packet? */
 	  if (is_mac_mcast_addr (eth->dest))
@@ -202,7 +212,16 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 	  struct buffer b = *buf;
 	  if (buf_advance (&b, sizeof (struct openvpn_ethhdr)))
 	    {
-	      switch (ntohs (eth->proto))
+	      uint16_t proto = ntohs (eth->proto);
+	      if (proto == OPENVPN_ETH_P_8021Q &&
+		  BLEN (buf) >= (int) sizeof (struct openvpn_8021qhdr))
+		{
+		  const struct openvpn_8021qhdr *tag = (const struct openvpn_8021qhdr *) BPTR (buf);
+		  proto = ntohs (tag->proto);
+		  buf_advance (&b, SIZE_ETH_TO_8021Q_HDR);
+		}
+
+	      switch (proto)
 		{
 		case OPENVPN_ETH_P_IPV4:
 		  ret |= (mroute_extract_addr_ipv4 (esrc, edest, &b) << MROUTE_SEC_SHIFT);
@@ -303,6 +322,9 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
 	{
 	case MR_ADDR_ETHER:
 	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
+#ifdef ENABLE_VLAN_TAGGING
+	  buf_printf (&out, "@%d", *(int16_t*)(ma->addr + 6));
+#endif
 	  break;
 	case MR_ADDR_IPV4:
 	  {
diff --git a/mroute.h b/mroute.h
index 9b9087d..ccf79ec 100644
--- a/mroute.h
+++ b/mroute.h
@@ -139,7 +139,8 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
 				 struct mroute_addr *esrc,
 				 struct mroute_addr *edest,
 				 const struct buffer *buf,
-				 int tunnel_type)
+				 int tunnel_type,
+				 int16_t bcast_domain)
 {
   unsigned int mroute_extract_addr_ipv4 (struct mroute_addr *src,
 					 struct mroute_addr *dest,
@@ -149,13 +150,14 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
 					  struct mroute_addr *dest,
 					  struct mroute_addr *esrc,
 					  struct mroute_addr *edest,
-					  const struct buffer *buf);
+					  const struct buffer *buf,
+					  int16_t vid);
   unsigned int ret = 0;
   verify_align_4 (buf);
   if (tunnel_type == DEV_TYPE_TUN)
     ret = mroute_extract_addr_ipv4 (src, dest, buf);
   else if (tunnel_type == DEV_TYPE_TAP)
-    ret = mroute_extract_addr_ether (src, dest, esrc, edest, buf);
+    ret = mroute_extract_addr_ether (src, dest, esrc, edest, buf, bcast_domain);
   return ret;
 }
 
diff --git a/multi.c b/multi.c
index 342871a..dfd23a3 100644
--- a/multi.c
+++ b/multi.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fabian Knittel <fabian.knittel@...1338...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -1759,7 +1760,8 @@ static void
 multi_bcast (struct multi_context *m,
 	     const struct buffer *buf,
 	     const struct multi_instance *sender_instance,
-	     const struct mroute_addr *sender_addr)
+	     const struct mroute_addr *sender_addr,
+	     int16_t vid)
 {
   struct hash_iterator hi;
   struct hash_element *he;
@@ -1804,6 +1806,10 @@ multi_bcast (struct multi_context *m,
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
@@ -1918,6 +1924,28 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
   return ret;
 }
 
+#ifdef ENABLE_VLAN_TAGGING
+bool
+buf_filter_incoming_vlan_tags (const struct buffer *buf)
+{
+  if (BLEN (buf) >= (int) sizeof (struct openvpn_8021qhdr))
+    {
+      const struct openvpn_8021qhdr *vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
+
+      if (ntohs (vlanhdr->tpid) == OPENVPN_ETH_P_8021Q)
+        {
+	  const int16_t vid = vlanhdr_get_vid(vlanhdr);
+	  if (vid != 0)
+	    {
+	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %d", vid);
+	      return true;
+	    }
+	}
+    }
+  return false;
+}
+#endif
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
@@ -1975,7 +2003,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 							      NULL,
 							      NULL,
 							      &c->c2.to_tun,
-							      DEV_TYPE_TUN);
+							      DEV_TYPE_TUN,
+							      0);
 
 	      /* drop packet if extract failed */
 	      if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
@@ -1996,7 +2025,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 		  if (mroute_flags & MROUTE_EXTRACT_MCAST)
 		    {
 		      /* for now, treat multicast as broadcast */
-		      multi_bcast (m, &c->c2.to_tun, m->pending, NULL);
+		      multi_bcast (m, &c->c2.to_tun, m->pending, NULL, 0);
 		    }
 		  else /* possible client to client routing */
 		    {
@@ -2033,10 +2062,27 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	    }
 	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
 	    {
+#ifdef ENABLE_VLAN_TAGGING
+	      int16_t vid = 0;
+#else
+	      const int16_t vid = 0;
+#endif
 #ifdef ENABLE_PF
 	      struct mroute_addr edest;
 	      mroute_addr_reset (&edest);
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+	      if (m->top.options.vlan_tagging)
+		{
+		  if (buf_filter_incoming_vlan_tags (&c->c2.to_tun))
+		    {
+		      /* Drop tagged frames. */
+		      c->c2.to_tun.len = 0;
+		    }
+		  else
+		    vid = c->options.vlan_pvid;
+		}
+#endif
 	      /* extract packet source and dest addresses */
 	      mroute_flags = mroute_extract_addr_from_packet (&src,
 							      &dest,
@@ -2047,7 +2093,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 							      NULL,
 #endif
 							      &c->c2.to_tun,
-							      DEV_TYPE_TAP);
+							      DEV_TYPE_TAP,
+							      vid);
 
 	      if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 		{
@@ -2058,7 +2105,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 			{
 			  if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
 			    {
-			      multi_bcast (m, &c->c2.to_tun, m->pending, NULL);
+			      multi_bcast (m, &c->c2.to_tun, m->pending, NULL, vid);
 			    }
 			  else /* try client-to-client routing */
 			    {
@@ -2116,6 +2163,159 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
   return ret;
 }
 
+#ifdef ENABLE_VLAN_TAGGING
+/*
+ * For vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY:
+ *   If a frame is VLAN-tagged, it is dropped.  Otherwise, the global
+ *   vlan_pvid is returned as VID.
+ *
+ * For vlan_accept == VAF_ONLY_VLAN_TAGGED:
+ *   If a frame is VLAN-tagged and contains no priority information, the
+ *   tagging is removed and the embedded VID is returned.
+ *   If a frame is VLAN-tagged and contains priority information, the frame
+ *   is turned into a priority frame and the embedded VID is returned.
+ *   If a frame isn't VLAN-tagged, the frame is dropped.
+ *
+ * For vlan_accept == VAF_ALL:
+ *   Accepts both VLAN-tagged and untagged (or priority-tagged) frames and
+ *   and handles them as described above.
+ */
+static int16_t
+remove_vlan_tag (const struct context *c, struct buffer *buf)
+{
+  struct openvpn_ethhdr eth;
+  struct openvpn_8021qhdr vlanhdr;
+  int16_t vid;
+  int16_t pcp;
+
+  if (BLEN (buf) < (sizeof (struct openvpn_8021qhdr)))
+    goto drop;
+
+  vlanhdr = *(const struct openvpn_8021qhdr *) BPTR (buf);
+
+  if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
+    {
+      /* Untagged packet. */
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
+      msg (D_VLAN_DEBUG, "assuming pvid for frame without vlan-tag, pvid: %d (proto/len 0x%04x)",
+	   c->options.vlan_pvid, ntohs (vlanhdr.tpid));
+      /* We return the global PVID as the VID for the untagged frame. */
+      return c->options.vlan_pvid;
+    }
+
+  /* Tagged packet. */
+
+  vid = ntohs (vlanhdr_get_vid (&vlanhdr));
+  pcp = ntohs (vlanhdr_get_pcp (&vlanhdr));
+
+  if (c->options.vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY)
+    {
+      if (vid != 0)
+	{
+	  /* We only accept untagged frames or priority-tagged frames. So drop
+	     VLAN-tagged frames. */
+	  msg (D_VLAN_DEBUG, "dropping frame with vlan-tag, vid: %d (proto/len 0x%04x)",
+	       vid, ntohs (vlanhdr.proto));
+	  goto drop;
+	}
+
+      /* We return the global PVID as the VID for the priority-tagged frame. */
+      return c->options.vlan_pvid;
+    }
+
+  if (pcp == 0)
+    {
+      /* VLAN-tagged without priority information. */
+
+      msg (D_VLAN_DEBUG, "removing vlan-tag from frame: vid: %d, wrapped proto/len: 0x%04x",
+           vid, ntohs (vlanhdr.proto));
+      memcpy (&eth, &vlanhdr, sizeof (eth));
+      eth.proto = vlanhdr.proto;
+
+      buf_advance (buf, SIZE_ETH_TO_8021Q_HDR);
+      memcpy (BPTR (buf), &eth, sizeof eth);
+    }
+  else
+    {
+      /* VLAN-tagged _with_ priority information.  We turn this frame into
+	 a pure priority frame.  I.e. we clear out the VID but leave the rest
+	 of the header intact. */
+      msg (D_VLAN_DEBUG, "removing vlan-tag from priority frame: vid: %d, wrapped proto/len: 0x%04x, prio: %d",
+           vid, ntohs (vlanhdr.proto), pcp);
+      vlanhdr_set_vid (&vlanhdr, htons (0));
+      memcpy (BPTR (buf), &vlanhdr, sizeof vlanhdr);
+    }
+
+  return vid;
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
+multi_prepend_vlan_tag (const struct context *c, struct buffer *buf)
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
+      /* Priority-tagged frame. */
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
+      vlanhdr_set_pcp (vlanhdr, htons (0));
+      vlanhdr_set_cfi (vlanhdr, htons (0));
+    }
+
+  vlanhdr_set_vid (vlanhdr, htons (c->options.vlan_pvid));
+
+  msg (D_VLAN_DEBUG, "tagging frame: vid %d (wrapping proto/len: %04x)",
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
@@ -2131,6 +2331,11 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
       unsigned int mroute_flags;
       struct mroute_addr src, dest;
       const int dev_type = TUNNEL_TYPE (m->top.c1.tuntap);
+#ifdef ENABLE_VLAN_TAGGING
+      int16_t vid = 0;
+#else
+      const int16_t vid = 0;
+#endif
 
 #ifdef ENABLE_PF
       struct mroute_addr esrc, *e1, *e2;
@@ -2158,6 +2363,16 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
        * the appropriate multi_instance object.
        */
 
+#ifdef ENABLE_VLAN_TAGGING
+      if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
+        {
+	  if ((vid = remove_vlan_tag (&m->top, &m->top.c2.buf)) == -1)
+	    {
+	      return false;
+	    }
+        }
+#endif
+
       mroute_flags = mroute_extract_addr_from_packet (&src,
 						      &dest,
 #ifdef ENABLE_PF
@@ -2167,7 +2382,8 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 #endif
 						      NULL,
 						      &m->top.c2.buf,
-						      dev_type);
+						      dev_type,
+						      vid);
 
       if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 	{
@@ -2178,9 +2394,9 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 	    {
 	      /* for now, treat multicast as broadcast */
 #ifdef ENABLE_PF
-	      multi_bcast (m, &m->top.c2.buf, NULL, e2);
+	      multi_bcast (m, &m->top.c2.buf, NULL, e2, vid);
 #else
-	      multi_bcast (m, &m->top.c2.buf, NULL, NULL);
+	      multi_bcast (m, &m->top.c2.buf, NULL, NULL, vid);
 #endif
 	    }
 	  else
@@ -2349,7 +2565,7 @@ gremlin_flood_clients (struct multi_context *m)
 	ASSERT (buf_write_u8 (&buf, get_random () & 0xFF));
 
       for (i = 0; i < parm.n_packets; ++i)
-	multi_bcast (m, &buf, NULL, NULL);
+	multi_bcast (m, &buf, NULL, NULL, 0);
 
       gc_free (&gc);
     }
diff --git a/multi.h b/multi.h
index ad26c12..3ed1981 100644
--- a/multi.h
+++ b/multi.h
@@ -405,6 +405,9 @@ multi_get_timeout (struct multi_context *m, struct timeval *dest)
 static inline bool
 multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flags)
 {
+#ifdef ENABLE_VLAN_TAGGING
+  void multi_prepend_vlan_tag (const struct context *c, struct buffer *buf);
+#endif
   struct multi_instance *mi = m->pending;
   bool ret = true;
 
@@ -415,6 +418,26 @@ multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flag
 	  mi->context.c2.to_tun.len);
 #endif
   set_prefix (mi);
+#ifdef ENABLE_VLAN_TAGGING
+  if (m->top.options.vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY)
+    {
+      /* Packets aren't tagged on the tap device. */
+
+      if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
+	{
+	  /* Packet is coming from the wrong VID, drop it. */
+	  mi->context.c2.to_tun.len = 0;
+	}
+    }
+  else if (m->top.options.vlan_accept == VAF_ONLY_VLAN_TAGGED ||
+	   (m->top.options.vlan_accept == VAF_ALL &&
+	    m->top.options.vlan_pvid != mi->context.options.vlan_pvid))
+    {
+      /* Packets need to be tagged.  Either because all packets are tagged or
+         because the vid matches the port's pvid. */
+      multi_prepend_vlan_tag (&mi->context, &mi->context.c2.to_tun);
+    }
+#endif
   process_outgoing_tun (&mi->context);
   ret = multi_process_post (m, mi, mpp_flags);
   clear_prefix ();
diff --git a/openvpn.8 b/openvpn.8
index 45e61fa..b5b98f9 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -3194,6 +3194,94 @@ other protocols such as ssh.
 
 Not implemented on Windows.
 .\"*********************************************************
+.TP
+.B \-\-vlan\-tagging
+Turns the OpenVPN server instance into a switch that understands VLAN-tagging.
+The tap device and each of the connecting clients is seen as a port of the
+switch. All client ports are in untagged mode and the tap device is
+VLAN-tagged, untagged or accepts both, depending on the
+.B \-\-vlan\-accept
+setting.
+
+Using the
+.B \-\-vlan\-pvid v
+option once per client, each port can be associated with a certain VLAN
+Identifier (VID). Packets can only be distributed between ports with a
+matching VID. Therefore, clients with differing VIDs are completely separated
+from one-another, even if
+.B \-\-client-to-client
+is activated.
+
+The filtering of packets takes place in the OpenVPN server. Clients do not
+need support for VLAN tagging.
+
+The
+.B \-\-vlan\-tagging
+option is off by default. While turned off, OpenVPN
+does no parsing and accepts any Ethernet frames.
+
+The option can only be activated in
+.B \-\-dev tap
+mode.
+
+.\"*********************************************************
+.TP
+.B \-\-vlan\-accept tagged | untagged | all
+Allows the tap device's VLAN tagging policy to be configured. You can choose
+between
+.B tagged
+("Admit Only VLAN-tagged frames"),
+.B untagged
+("Admit Only Untagged and Priority-tagged frames") or
+.B all
+("Admit All frames") mode.
+
+Incoming untagged packets from clients are assigned with the client's Port
+VLAN Identifier (PVID) as their VID. In
+.B untagged
+mode, incoming untagged packets on the tap device are associated with the
+global
+.B \-\-vlan\-pvid
+setting. In
+.B tagged
+mode, any incoming untagged packets are dropped.
+
+In
+.B tagged
+mode, packets going out through the tap device are VLAN-tagged with the
+originating client's VID.
+
+In
+.B all
+mode, incoming tagged packets are handled the same way as in
+.B tagged
+mode. Incoming untagged packets are handled as in
+.B untagged
+mode. Outgoing packets are tagged, unless the VID matches the global PVID, in
+which case the packets go out untagged.
+
+Defaults to \fB\-\-vlan\-accept all\fR.
+.\"*********************************************************
+.TP
+.B \-\-vlan\-pvid v
+Specifies which VLAN identifier a "port" is associated with. Not valid without
+\fB\-\-vlan\-tagging\fR.
+
+In client context, the setting specifies which VLAN identifier a client is
+associated with. In global context, the tap device's VLAN identifier is set.
+The latter only makes sense in
+.B \-\-vlan\-accept untagged
+and
+.B \-\-vlan\-accept all
+mode.
+
+Valid values for
+.B v
+go from 1 through to 4094. Defaults to 1.
+
+In some switch implementations, the Port VLAN Identifier is also referred
+to as Native VLAN.
+.\"*********************************************************
 .SS Client Mode
 Use client mode when connecting to an OpenVPN server
 which has
diff --git a/options.c b/options.c
index 36b9913..bf8b3a1 100644
--- a/options.c
+++ b/options.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fabian Knittel <fabian.knittel@...1338...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -420,6 +421,11 @@ static const char usage_message[] =
   "--port-share host port : When run in TCP mode, proxy incoming HTTPS sessions\n"
   "                  to a web server at host:port.\n"
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  "--vlan-tagging  : Enable VLAN tagging.\n"
+  "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
+  "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
+#endif
 #endif
   "\n"
   "Client options (when connecting to a multi-client server):\n"
@@ -754,6 +760,10 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
+#ifdef ENABLE_VLAN_TAGGING
+  o->vlan_accept = VAF_ALL;
+  o->vlan_pvid = 1;
+#endif
 }
 
 void
@@ -948,6 +958,23 @@ dhcp_option_address_parse (const char *name, const char *parm, in_addr_t *array,
 
 #endif
 
+#ifdef ENABLE_VLAN_TAGGING
+static const char *
+print_vlan_accept (enum vlan_acceptable_frames mode)
+{
+  switch (mode)
+   {
+    case VAF_ONLY_VLAN_TAGGED:
+      return "tagged";
+    case VAF_ONLY_UNTAGGED_OR_PRIORITY:
+      return "untagged";
+    case VAF_ALL:
+      return "all";
+   }
+  return NULL;
+}
+#endif
+
 #if P2MP
 
 #ifdef ENABLE_DEBUG
@@ -1006,6 +1033,11 @@ show_p2mp_parms (const struct options *o)
   SHOW_STR (port_share_host);
   SHOW_INT (port_share_port);
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  SHOW_BOOL (vlan_tagging);
+  msg (D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
+  SHOW_INT (vlan_pvid);
+#endif
 #endif /* P2MP_SERVER */
 
   SHOW_BOOL (client);
@@ -1742,6 +1774,17 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
 	if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) && script_method == SM_SYSTEM)
 	  msg (M_USAGE, "--script-security method='system' cannot be combined with --no-name-remapping");
+#ifdef ENABLE_VLAN_TAGGING
+      if (options->vlan_tagging && dev != DEV_TYPE_TAP)
+	msg (M_USAGE, "--vlan-tagging must be used with --dev tap");
+      if (!options->vlan_tagging)
+	{
+	  if (options->vlan_accept != defaults.vlan_accept)
+	    msg (M_USAGE, "--vlan-accept requires --vlan-tagging");
+	  if (options->vlan_pvid != defaults.vlan_pvid)
+	    msg (M_USAGE, "--vlan-pvid requires --vlan-tagging");
+	}
+#endif
     }
   else
     {
@@ -1788,7 +1831,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
 #endif
-
+#ifdef ENABLE_VLAN_TAGGING
+      if (options->vlan_tagging)
+	msg (M_USAGE, "--vlan-tagging requires --mode server");
+#endif
     }
 #endif /* P2MP_SERVER */
 
@@ -5730,6 +5776,45 @@ add_option (struct options *options,
       options->persist_mode = 1;
     }
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  else if (streq (p[0], "vlan-tagging"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->vlan_tagging = true;
+    }
+  else if (streq (p[0], "vlan-accept") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (streq (p[1], "tagged"))
+	{
+	  options->vlan_accept = VAF_ONLY_VLAN_TAGGED;
+	}
+      else if (streq (p[1], "untagged"))
+	{
+	  options->vlan_accept = VAF_ONLY_UNTAGGED_OR_PRIORITY;
+	}
+      else if (streq (p[1], "all"))
+	{
+	  options->vlan_accept = VAF_ALL;
+	}
+      else
+	{
+	  msg (msglevel, "--vlan-accept must be 'tagged', 'untagged' or 'all'");
+	  goto err;
+	}
+    }
+  else if (streq (p[0], "vlan-pvid") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
+      options->vlan_pvid = positive_atoi (p[1]);
+      if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
+	  options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
+	{
+	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %d and <= %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
+	  goto err;
+	}
+    }
+#endif
   else
     {
       if (file)
diff --git a/options.h b/options.h
index 740e18e..5c4851f 100644
--- a/options.h
+++ b/options.h
@@ -126,6 +126,15 @@ struct remote_list
 
 #endif
 
+#ifdef ENABLE_VLAN_TAGGING
+enum vlan_acceptable_frames
+{
+  VAF_ONLY_VLAN_TAGGED,
+  VAF_ONLY_UNTAGGED_OR_PRIORITY,
+  VAF_ALL,
+};
+#endif
+
 /* Command line options */
 struct options
 {
@@ -509,6 +518,12 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+#ifdef ENABLE_VLAN_TAGGING
+  bool vlan_tagging;
+  enum vlan_acceptable_frames vlan_accept;
+  int vlan_pvid;
+#endif
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
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
diff --git a/proto.h b/proto.h
index 628e991..5c641ff 100644
--- a/proto.h
+++ b/proto.h
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1338...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -61,20 +62,28 @@ struct openvpn_ethhdr
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
+# define OPENVPN_8021Q_MASK_VID htons (0x0FFF) /* mask VID out of pcp_cfi_vid */
+# define OPENVPN_8021Q_MASK_PCP htons (0xE000) /* mask PCP out of pcp_cfi_vid */
+# define OPENVPN_8021Q_MASK_CFI htons (0x1000) /* mask CFI out of pcp_cfi_vid */
+  uint16_t pcp_cfi_vid;               /* bit fields, see IEEE 802.1Q */
+  uint16_t proto;                     /* contained packet type ID field */
 };
 
+/*
+ * Size difference between a regular Ethernet II header and an Ethernet II
+ * header with additional IEEE 802.1Q tagging.
+ */
+#define SIZE_ETH_TO_8021Q_HDR (sizeof (struct openvpn_8021qhdr) - sizeof (struct openvpn_ethhdr))
 
 struct openvpn_arp {
 # define ARP_MAC_ADDR_TYPE 0x0001
@@ -211,4 +220,59 @@ void ipv4_packet_size_verify (const uint8_t *data,
 			      counter_type *errors);
 #endif
 
+#ifdef ENABLE_VLAN_TAGGING
+# define OPENVPN_8021Q_MIN_VID 1
+# define OPENVPN_8021Q_MAX_VID 4094
+
+/*
+ * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
+ */
+static inline int
+vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
+{
+  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP;
+}
+/*
+ * Retrieve the Canonical Format Indicator (CFI) from the IEEE 802.1Q header.
+ */
+static inline int
+vlanhdr_get_cfi (const struct openvpn_8021qhdr *hdr)
+{
+  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_CFI;
+}
+/*
+ * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
+ */
+static inline int
+vlanhdr_get_vid (const struct openvpn_8021qhdr *hdr)
+{
+  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID;
+}
+
+/*
+ * Set the Priority Code Point (PCP) in an IEEE 802.1Q header.
+ */
+static inline void
+vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const int pcp)
+{
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_PCP) | (pcp & OPENVPN_8021Q_MASK_PCP);
+}
+/*
+ * Set the Canonical Format Indicator (CFI) in an IEEE 802.1Q header.
+ */
+static inline void
+vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const int cfi)
+{
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_CFI) | (cfi & OPENVPN_8021Q_MASK_CFI);
+}
+/*
+ * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
+ */
+static inline void
+vlanhdr_set_vid (struct openvpn_8021qhdr *hdr, const int vid)
+{
+  hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (vid & OPENVPN_8021Q_MASK_VID);
+}
+#endif
+
 #endif

--------------040006030703050802090704--

