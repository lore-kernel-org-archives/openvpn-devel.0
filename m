From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:18 +0200
Message-Id: <3622b7d8ee5a1a037a45cffb8a50374c2515c0f4.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 5/9] vlan: Add VLAN identifier to
	mroute_addr for ethernet addresses
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

This patch appends the VID to the ethernet address in mroute_addr.

By including the VID in mroute_addr, the routing space is divided by VLAN.
This means:
 - duplicate MAC addresses on different VLANs no longer conflict and
 - all unicast-traffic is constrained to whatever VLAN the traffic came
   from (i.e. cross-VLAN unicast routing is no longer possible).

(This patch doesn't take care of broadcast traffic.  Broadcast traffic across
VLANs is still be possible at this point.)
---
 mroute.c |   10 +++++++---
 mroute.h |    8 +++++---
 multi.c  |   15 +++++++++++----
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/mroute.c b/mroute.c
index 9d8fa66..1040b8f 100644
--- a/mroute.c
+++ b/mroute.c
@@ -169,7 +169,8 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 			   struct mroute_addr *dest,
 			   struct mroute_addr *esrc,
 			   struct mroute_addr *edest,
-			   const struct buffer *buf)
+			   const struct buffer *buf,
+			   int16_t vid)
 {
   unsigned int ret = 0;
   if (BLEN (buf) >= (int) sizeof (struct openvpn_ethhdr))
@@ -179,15 +180,17 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 	{
 	  src->type = MR_ADDR_ETHER;
 	  src->netbits = 0;
-	  src->len = 6;
+	  src->len = 8;
 	  memcpy (src->addr, eth->source, 6);
+	  memcpy (src->addr + 6, &vid, 2);
 	}
       if (dest)
 	{
 	  dest->type = MR_ADDR_ETHER;
 	  dest->netbits = 0;
-	  dest->len = 6;
+	  dest->len = 8;
 	  memcpy (dest->addr, eth->dest, 6);
+	  memcpy (dest->addr + 6, &vid, 2);
 
 	  /* ethernet broadcast/multicast packet? */
 	  if (is_mac_mcast_addr (eth->dest))
@@ -303,6 +306,7 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
 	{
 	case MR_ADDR_ETHER:
 	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
+	  buf_printf (&out, "@%d", *(int16_t*)(ma->addr + 6));
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
index c2563a0..96644e5 100644
--- a/multi.c
+++ b/multi.c
@@ -1975,7 +1975,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 							      NULL,
 							      NULL,
 							      &c->c2.to_tun,
-							      DEV_TYPE_TUN);
+							      DEV_TYPE_TUN,
+							      0);
 
 	      /* drop packet if extract failed */
 	      if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
@@ -2033,10 +2034,13 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	    }
 	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
 	    {
+	      int16_t vid = 0;
 #ifdef ENABLE_PF
 	      struct mroute_addr edest;
 	      mroute_addr_reset (&edest);
 #endif
+	      if (m->top.options.vlan_tagging)
+		vid = c->options.vlan_tag;
 	      /* extract packet source and dest addresses */
 	      mroute_flags = mroute_extract_addr_from_packet (&src,
 							      &dest,
@@ -2047,7 +2051,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 							      NULL,
 #endif
 							      &c->c2.to_tun,
-							      DEV_TYPE_TAP);
+							      DEV_TYPE_TAP,
+							      vid);
 
 	      if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 		{
@@ -2198,6 +2203,7 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
       unsigned int mroute_flags;
       struct mroute_addr src, dest;
       const int dev_type = TUNNEL_TYPE (m->top.c1.tuntap);
+      int16_t vid = 0;
 
 #ifdef ENABLE_PF
       struct mroute_addr esrc, *e1, *e2;
@@ -2227,7 +2233,7 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 
       if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
         {
-	  if (remove_vlan_identifier (&m->top.c2.buf) == -1)
+	  if ((vid = remove_vlan_identifier (&m->top.c2.buf)) == -1)
 	    return false;
         }
 
@@ -2240,7 +2246,8 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 #endif
 						      NULL,
 						      &m->top.c2.buf,
-						      dev_type);
+						      dev_type,
+						      vid);
 
       if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 	{
-- 
1.7.0


