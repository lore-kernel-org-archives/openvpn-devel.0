From: Mike Auty <mike.auty@...277...>
Message-ID: <5701664E.6080102@...277...>
Date: Sun, 3 Apr 2016 19:51:58 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/7] vlan: Add the 802.1q vlan id to
	appropriate calls.
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

This patch ensures that a vlan ID is passed to all necessary function
calls.

These changes are not yet used and the vlan ID is always defined as 0.

This will be used by future patches that will change the vid variable.

Patch authored by Fabian Knittel <fabian.knittel@...2126...>.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/mroute.c | 42 ++++++++++++++++++++++++++++++++----------
 src/openvpn/mroute.h |  8 +++++---
 src/openvpn/multi.c  | 32 +++++++++++++++++++++++---------
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 972f1dd..ae84a70 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -210,12 +210,28 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
   return ret;
 }
 
+static void mroute_copy_ether_to_addr(struct mroute_addr *maddr,
+				      const uint8_t *eth_addr,
+				      uint16_t vid)
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
+			   uint16_t vid)
 {
   unsigned int ret = 0;
   if (BLEN (buf) >= (int) sizeof (struct openvpn_ethhdr))
@@ -223,17 +239,11 @@ mroute_extract_addr_ether (struct mroute_addr *src,
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
@@ -248,7 +258,16 @@ mroute_extract_addr_ether (struct mroute_addr *src,
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
@@ -391,6 +410,9 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
 	{
 	case MR_ADDR_ETHER:
 	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
+#ifdef ENABLE_VLAN_TAGGING
+	  buf_printf (&out, "@%u", *(uint16_t*)(ma->addr + 6));
+#endif
 	  break;
 	case MR_ADDR_IPV4:
 	  {
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 608f70b..175dd2a 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -138,7 +138,8 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
 				 struct mroute_addr *esrc,
 				 struct mroute_addr *edest,
 				 const struct buffer *buf,
-				 int tunnel_type)
+				 int tunnel_type,
+				 uint16_t vid)
 {
   unsigned int mroute_extract_addr_ipv4 (struct mroute_addr *src,
 					 struct mroute_addr *dest,
@@ -148,13 +149,14 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
 					  struct mroute_addr *dest,
 					  struct mroute_addr *esrc,
 					  struct mroute_addr *edest,
-					  const struct buffer *buf);
+					  const struct buffer *buf,
+					  uint16_t vid);
   unsigned int ret = 0;
   verify_align_4 (buf);
   if (tunnel_type == DEV_TYPE_TUN)
     ret = mroute_extract_addr_ipv4 (src, dest, buf);
   else if (tunnel_type == DEV_TYPE_TAP)
-    ret = mroute_extract_addr_ether (src, dest, esrc, edest, buf);
+    ret = mroute_extract_addr_ether (src, dest, esrc, edest, buf, vid);
   return ret;
 }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6e6d457..61180f6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2089,7 +2089,8 @@ static void
 multi_bcast (struct multi_context *m,
 	     const struct buffer *buf,
 	     const struct multi_instance *sender_instance,
-	     const struct mroute_addr *sender_addr)
+	     const struct mroute_addr *sender_addr,
+	     uint16_t vid)
 {
   struct hash_iterator hi;
   struct hash_element *he;
@@ -2424,7 +2425,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 							      NULL,
 							      NULL,
 							      &c->c2.to_tun,
-							      DEV_TYPE_TUN);
+							      DEV_TYPE_TUN,
+							      0);
 
 	      /* drop packet if extract failed */
 	      if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
@@ -2454,7 +2456,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 		  if (mroute_flags & MROUTE_EXTRACT_MCAST)
 		    {
 		      /* for now, treat multicast as broadcast */
-		      multi_bcast (m, &c->c2.to_tun, m->pending, NULL);
+		      multi_bcast (m, &c->c2.to_tun, m->pending, NULL, 0);
 		    }
 		  else /* possible client to client routing */
 		    {
@@ -2491,6 +2493,11 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	    }
 	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
 	    {
+#ifdef ENABLE_VLAN_TAGGING
+	      uint16_t vid = 0;
+#else
+	      const uint16_t vid = 0;
+#endif
 #ifdef ENABLE_PF
 	      struct mroute_addr edest;
 	      mroute_addr_reset (&edest);
@@ -2505,7 +2512,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 							      NULL,
 #endif
 							      &c->c2.to_tun,
-							      DEV_TYPE_TAP);
+							      DEV_TYPE_TAP,
+							      vid);
 
 	      if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 		{
@@ -2516,7 +2524,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 			{
 			  if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
 			    {
-			      multi_bcast (m, &c->c2.to_tun, m->pending, NULL);
+			      multi_bcast (m, &c->c2.to_tun, m->pending, NULL, vid);
 			    }
 			  else /* try client-to-client routing */
 			    {
@@ -2589,6 +2597,11 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
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
@@ -2625,7 +2638,8 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 #endif
 						      NULL,
 						      &m->top.c2.buf,
-						      dev_type);
+						      dev_type,
+						      vid);
 
       if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 	{
@@ -2636,9 +2650,9 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
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
@@ -2815,7 +2829,7 @@ gremlin_flood_clients (struct multi_context *m)
 	ASSERT (buf_write_u8 (&buf, get_random () & 0xFF));
 
       for (i = 0; i < parm.n_packets; ++i)
-	multi_bcast (m, &buf, NULL, NULL);
+	multi_bcast (m, &buf, NULL, NULL, 0);
 
       gc_free (&gc);
     }
-- 
2.7.1

