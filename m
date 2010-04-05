Message-ID: <4BBA5672.3090503@...1338...>
Date: Mon, 05 Apr 2010 23:30:26 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA144CF26E544C4DF8AF0EA28"
Subject: [Openvpn-devel] [PATCH-SET v2] VLAN-tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA144CF26E544C4DF8AF0EA28
Content-Type: multipart/mixed; boundary="------------050601070600030707090809"

This is a multi-part message in MIME format.
--------------050601070600030707090809
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

I didn't have much time the last few days, but as I'll be without
Internet access Tuesday through Friday I wanted to push out what I've
come up with so far.  I've attached the diff between my first
patch-series and this posting.  If people would prefer to see the
individual patches in their reworked form, just say so and I'll post
those in the future.  For now, they're available on the feat_vlan/r12 tag at

git://fsmi-dev.fsmi.uni-karlsruhe.de/openvpn.git

or
  http://opensource.fsmi.uni-karlsruhe.de/cgi-bin/gitweb.cgi?p=3Dopenvpn.git

The changes:

 * Fixed the valid VID range to be from 1-0xFFFE to 1-4094 (0xFFE).
   Changed the VID field mask to 0x0FFF. (If someone can explain a
   use-case for VID=3D0 to me, I might allow that too.)

 * "--vlan-tag" was renamed to "--vlan-pvid" and is now also valid in
   global context (where it configures the PVID for the tap device).

 * The boolean "--vlan-tagging" option was replaced by
   "--vlan-accept raw | tagged | untagged | all". "raw" corresponds to
   the old "no --vlan-tagging" and "tagged" corresponds to the old
   "--vlan-tagging". "untagged" accepts only untagged (or priority
   tagged) packets on the tap device. It assumes they belong to the VID
   set by the global "--vlan-pvid". "all" accepts VLAN-tagged and
   untagged packets and handles them the way the "tagged" and "untagged"
   modes would.

   I'm planning to reintroduce the previous on/off switch and just
   supplement that with the new "--vlan-accept mode" (which would
   then only allow you to choose between 'tagged | untagged | all'.
   The thinking behind the two separate switches would be, that
   "raw" mode makes OpenVPN behave different on a global level, while
   "tagged", "untagged" and "all" only change the behaviour regarding
   the tap device. (In theory, "--vlan-accept" could be made into an
   instance option, allowing clients to send tagged packets, etc..)

 * Compile-time switch ("--disable-vlan-tagging" /
   "--enable-vlan-tagging") to enable/disable the VLAN-tagging feature
   Default is enabled. When disabled, OpenVPN should behave the same way
   as in "--vlan-accept raw" mode.

 * Added a first attempt at documentation to openvpn.8

 * VLAN-tagged packets coming in via the client links are dropped
   if "--vlan-accept" is in non-"raw" mode. (Priority-tagged packets
   aren't affected.)

 * VLAN-tagged packets coming in through tap, that contain priority
   information have their priority information preserved and get sent
   on as priority-tagged packets.  I'm not sure whether this is a good
   idea though.  The decision is based on whether the PCP-field is
   non-zero.  I haven't been able to find out what the standard has
   to say on the matter or what switches typically do in that situation.

   Linux allows you to do fixed egress and ingress priority tagging
   (or more precise: mapping from the TOS field), so that would imply
   changing the IP-header's TOS field.


Again, the patches have only received light testing so far.  I've tested
all accept modes though, so there hopefully shouldn't be any obvious
brown-paper bag bugs.  More thorough testing will hopefully start next week.

BTW, I'll add Signed-Off-By-lines as soon as I'm a bit more confident in
the patches. (And ... assuming I don't forget adding the flag, like I
did this time. :) )

If you haven't had a thorough look at my previous patch-set yet, I
strongly suggest you go through my individual patches from my git tree,
as they're IMHO easier to understand one by one.

Cheers
Fabian


--------------050601070600030707090809
Content-Type: text/x-patch;
 name="vlan_interdiff_r6r12.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="vlan_interdiff_r6r12.patch"

diff --git a/configure.ac b/configure.ac
index 116ff7c..b99bc11 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,12 @@ AC_ARG_ENABLE(selinux,
    [SELINUX=3D"yes"]
 )
=20
+AC_ARG_ENABLE(vlan-tagging,
+   [  --disable-vlan-tagging  Disable support for VLAN tagging/untagging=
],
+   [VLAN_TAGGING=3D"$enableval"],
+   [VLAN_TAGGING=3D"yes"]
+)
+
 AC_ARG_WITH(ssl-headers,
    [  --with-ssl-headers=3DDIR  Crypto/SSL Include files location],
    [CS_HDR_DIR=3D"$withval"]
@@ -886,6 +892,12 @@ if test "$SELINUX" =3D "yes"; then
    )
 fi
=20
+dnl enable --vlan-tagging
+if test "$VLAN_TAGGING" =3D "yes"; then
+   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable VLAN tagging/untagging])
+fi
+
+
 TAP_ID=3D"PRODUCT_TAP_ID"
 TAP_WIN32_MIN_MAJOR=3D"PRODUCT_TAP_WIN32_MIN_MAJOR"
 TAP_WIN32_MIN_MINOR=3D"PRODUCT_TAP_WIN32_MIN_MINOR"
diff --git a/errlevel.h b/errlevel.h
index a092d3f..68128b9 100644
--- a/errlevel.h
+++ b/errlevel.h
@@ -144,6 +144,8 @@
 #define D_PF_DROPPED_BCAST   LOGLEV(7, 71, M_DEBUG)  /* packet filter dr=
opped a broadcast packet */
 #define D_PF_DEBUG           LOGLEV(7, 72, M_DEBUG)  /* packet filter de=
bugging, must also define PF_DEBUG in pf.h */
=20
+#define D_VLAN_DEBUG         LOGLEV(7, 72, M_DEBUG)  /* show VLAN taggin=
g/untagging debug info */
+
 #define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed de=
scription of each handshake */
 #define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info fro=
m tls_session routines */
 #define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h =
debugging info */
diff --git a/mroute.c b/mroute.c
index 4aa7bb4..72ef91a 100644
--- a/mroute.c
+++ b/mroute.c
@@ -164,6 +164,21 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
   return ret;
 }
=20
+static void mroute_copy_ether_to_addr(struct mroute_addr *maddr,
+				      const uint8_t *eth_addr,
+				      int16_t vid)
+{
+  maddr->type =3D MR_ADDR_ETHER;
+  maddr->netbits =3D 0;
+  memcpy (maddr->addr, eth_addr, 6);
+#ifdef ENABLE_VLAN_TAGGING
+  maddr->len =3D 8;
+  memcpy (maddr->addr + 6, &vid, 2);
+#else
+  maddr->len =3D 6;
+#endif
+}
+
 unsigned int
 mroute_extract_addr_ether (struct mroute_addr *src,
 			   struct mroute_addr *dest,
@@ -178,19 +193,11 @@ mroute_extract_addr_ether (struct mroute_addr *src,=

       const struct openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr =
*) BPTR (buf);
       if (src)
 	{
-	  src->type =3D MR_ADDR_ETHER;
-	  src->netbits =3D 0;
-	  src->len =3D 8;
-	  memcpy (src->addr, eth->source, 6);
-	  memcpy (src->addr + 6, &vid, 2);
+          mroute_copy_ether_to_addr(src, eth->source, vid);
 	}
       if (dest)
 	{
-	  dest->type =3D MR_ADDR_ETHER;
-	  dest->netbits =3D 0;
-	  dest->len =3D 8;
-	  memcpy (dest->addr, eth->dest, 6);
-	  memcpy (dest->addr + 6, &vid, 2);
+          mroute_copy_ether_to_addr(dest, eth->dest, vid);
=20
 	  /* ethernet broadcast/multicast packet? */
 	  if (is_mac_mcast_addr (eth->dest))
@@ -206,7 +213,8 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 	  if (buf_advance (&b, sizeof (struct openvpn_ethhdr)))
 	    {
 	      uint16_t proto =3D ntohs (eth->proto);
-	      if (proto =3D=3D OPENVPN_ETH_P_8021Q)
+	      if (proto =3D=3D OPENVPN_ETH_P_8021Q &&
+		  BLEN (buf) >=3D (int) sizeof (struct openvpn_8021qhdr))
 		{
 		  const struct openvpn_8021qhdr *tag =3D (const struct openvpn_8021qhd=
r *) BPTR (buf);
 		  proto =3D ntohs (tag->proto);
@@ -314,7 +322,9 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
 	{
 	case MR_ADDR_ETHER:
 	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); =

+#ifdef ENABLE_VLAN_TAGGING
 	  buf_printf (&out, "@%d", *(int16_t*)(ma->addr + 6));
+#endif
 	  break;
 	case MR_ADDR_IPV4:
 	  {
diff --git a/multi.c b/multi.c
index 641d464..73b3794 100644
--- a/multi.c
+++ b/multi.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...1341...=
t>
+ *  Copyright (C) 2010 Fabian Knittel <fabian.knittel@...1338...>
  *
  *  This program is free software; you can redistribute it and/or modify=

  *  it under the terms of the GNU General Public License version 2
@@ -1805,22 +1806,10 @@ multi_bcast (struct multi_context *m,
 		    }
 		}
 #endif
-	      if (vid !=3D 0 && vid !=3D mi->context.options.vlan_tag)
-		{
-		  struct gc_arena gc =3D gc_new ();
-		  msg (M_INFO, "VLAN: addr[%s]@%d -> client[%s]@%d packet dropped by B=
CAST VLAN filter",
-		      mroute_addr_print_ex (sender_addr, MAPF_SHOW_ARP, &gc),
-		      vid, mi_prefix (mi), mi->context.options.vlan_tag);
-		  gc_free (&gc);
-		  continue;
-		}
-		{
-		  struct gc_arena gc =3D gc_new ();
-		  msg (M_INFO, "BCAST: addr[%s]@%d -> client[%s]@%d",
-		      mroute_addr_print_ex (sender_addr, MAPF_SHOW_ARP, &gc),
-		      vid, mi_prefix (mi), mi->context.options.vlan_tag);
-		  gc_free (&gc);
-		}
+#ifdef ENABLE_VLAN_TAGGING
+	      if (vid !=3D 0 && vid !=3D mi->context.options.vlan_pvid)
+		continue;
+#endif
 	      multi_add_mbuf (m, mi, mb);
 	    }
 	}
@@ -1935,6 +1924,28 @@ multi_process_post (struct multi_context *m, struc=
t multi_instance *mi, const un
   return ret;
 }
=20
+#ifdef ENABLE_VLAN_TAGGING
+bool
+buf_filter_incoming_vlan_tags (const struct buffer *buf)
+{
+  if (BLEN (buf) >=3D (int) sizeof (struct openvpn_8021qhdr))
+    {
+      const struct openvpn_8021qhdr *vlanhdr =3D (const struct openvpn_8=
021qhdr *) BPTR (buf);
+
+      if (ntohs (vlanhdr->tpid) =3D=3D OPENVPN_ETH_P_8021Q)
+        {
+	  const int16_t vid =3D vlanhdr_get_vid(vlanhdr);
+	  if (vid !=3D 0)
+	    {
+	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %d", vid=
);
+	      return true;
+	    }
+	}
+    }
+  return false;
+}
+#endif
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,=

  * i.e. client -> server direction.
@@ -2051,13 +2062,27 @@ multi_process_incoming_link (struct multi_context=
 *m, struct multi_instance *ins
 	    }
 	  else if (TUNNEL_TYPE (m->top.c1.tuntap) =3D=3D DEV_TYPE_TAP)
 	    {
+#ifdef ENABLE_VLAN_TAGGING
 	      int16_t vid =3D 0;
+#else
+	      const int16_t vid =3D 0;
+#endif
 #ifdef ENABLE_PF
 	      struct mroute_addr edest;
 	      mroute_addr_reset (&edest);
 #endif
-	      if (m->top.options.vlan_tagging)
-		vid =3D c->options.vlan_tag;
+#ifdef ENABLE_VLAN_TAGGING
+	      if (m->top.options.vlan_accept !=3D VAF_RAW)
+		{
+		  if (buf_filter_incoming_vlan_tags (&c->c2.to_tun))
+		    {
+		      /* Drop tagged frames. */
+		      c->c2.to_tun.len =3D 0;
+		    }
+		  else
+		    vid =3D c->options.vlan_pvid;
+		}
+#endif
 	      /* extract packet source and dest addresses */
 	      mroute_flags =3D mroute_extract_addr_from_packet (&src,
 							      &dest,
@@ -2138,78 +2163,158 @@ multi_process_incoming_link (struct multi_contex=
t *m, struct multi_instance *ins
   return ret;
 }
=20
+#ifdef ENABLE_VLAN_TAGGING
 /*
- * Removes the VLAN tagging of a frame and returns the frame's VID.  Fra=
mes
- * without tagging are dropped.
+ * For vlan_accept =3D=3D VAF_ONLY_UNTAGGED_OR_PRIORITY:
+ *   If a frame is VLAN-tagged, it is dropped.  Otherwise, the global
+ *   vlan_pvid is returned as VID.
+ *
+ * For vlan_accept =3D=3D VAF_ONLY_VLAN_TAGGED:
+ *   If a frame is VLAN-tagged and contains no priority information, the=

+ *   tagging is removed and the embedded VID is returned.
+ *   If a frame is VLAN-tagged and contains priority information, the fr=
ame
+ *   is turned into a priority frame and the embedded VID is returned.
+ *   If a frame isn't VLAN-tagged, the frame is dropped.
+ *
+ * For vlan_accept =3D=3D VAF_ALL:
+ *   Accepts both VLAN-tagged and untagged (or priority-tagged) frames a=
nd
+ *   and handles them as described above.
  */
 static int16_t
-remove_vlan_identifier (struct buffer *buf)
+remove_vlan_tag (const struct context *c, struct buffer *buf)
 {
   struct openvpn_ethhdr eth;
   struct openvpn_8021qhdr vlanhdr;
   int16_t vid;
+  int16_t pcp;
=20
   if (BLEN (buf) < (sizeof (struct openvpn_8021qhdr)))
-    goto err;
+    goto drop;
=20
   vlanhdr =3D *(const struct openvpn_8021qhdr *) BPTR (buf);
=20
   if (ntohs (vlanhdr.tpid) !=3D OPENVPN_ETH_P_8021Q)
     {
-      /* Drop untagged frames */
-      msg (M_INFO, "dropping untagged ethernet frame (proto/len 0x%04x)"=
,
-	   ntohs (vlanhdr.tpid));
-      goto err;
+      /* Untagged packet. */
+
+      if (c->options.vlan_accept =3D=3D VAF_ONLY_VLAN_TAGGED)
+	{
+	  /* We only accept vlan-tagged frames, so drop frames without vlan-tag=

+	   */
+	  msg (D_VLAN_DEBUG, "dropping frame without vlan-tag (proto/len 0x%04x=
)",
+	       ntohs (vlanhdr.tpid));
+	  goto drop;
+	}
+
+      msg (D_VLAN_DEBUG, "assuming pvid for frame without vlan-tag, pvid=
: %d (proto/len 0x%04x)",
+	   c->options.vlan_pvid, ntohs (vlanhdr.tpid));
+      /* We return the global PVID as the VID for the untagged frame. */=

+      return c->options.vlan_pvid;
     }
=20
-  /* Ethernet II frame with 802.1Q */
-  vid =3D ntohs (vlan_get_vid (&vlanhdr));
-  msg (M_INFO, "untagging ethernet frame: vid: %u, wrapped proto/len: 0x=
%04x",
-       vid, ntohs (vlanhdr.proto));
-  memcpy (&eth, &vlanhdr, sizeof (eth));
-  eth.proto =3D vlanhdr.proto;
+  /* Tagged packet. */
+
+  vid =3D ntohs (vlanhdr_get_vid (&vlanhdr));
+  pcp =3D ntohs (vlanhdr_get_pcp (&vlanhdr));
=20
-  buf_advance (buf, SIZE_ETH_TO_8021Q_HDR);
-  memcpy (BPTR (buf), &eth, sizeof eth);
+  if (c->options.vlan_accept =3D=3D VAF_ONLY_UNTAGGED_OR_PRIORITY)
+    {
+      if (vid !=3D 0)
+	{
+	  /* We only accept untagged frames or priority-tagged frames. So drop
+	     VLAN-tagged frames. */
+	  msg (D_VLAN_DEBUG, "dropping frame with vlan-tag, vid: %d (proto/len =
0x%04x)",
+	       vid, ntohs (vlanhdr.proto));
+	  goto drop;
+	}
+
+      /* We return the global PVID as the VID for the priority-tagged fr=
ame. */
+      return c->options.vlan_pvid;
+    }
+
+  if (pcp =3D=3D 0)
+    {
+      /* VLAN-tagged without priority information. */
+
+      msg (D_VLAN_DEBUG, "removing vlan-tag from frame: vid: %d, wrapped=
 proto/len: 0x%04x",
+           vid, ntohs (vlanhdr.proto));
+      memcpy (&eth, &vlanhdr, sizeof (eth));
+      eth.proto =3D vlanhdr.proto;
+
+      buf_advance (buf, SIZE_ETH_TO_8021Q_HDR);
+      memcpy (BPTR (buf), &eth, sizeof eth);
+    }
+  else
+    {
+      /* VLAN-tagged _with_ priority information.  We turn this frame in=
to
+	 a pure priority frame.  I.e. we clear out the VID but leave the rest
+	 of the header intact. */
+      msg (D_VLAN_DEBUG, "removing vlan-tag from priority frame: vid: %d=
, wrapped proto/len: 0x%04x, prio: %d",
+           vid, ntohs (vlanhdr.proto), pcp);
+      vlanhdr_set_vid (&vlanhdr, htons (0));
+      memcpy (BPTR (buf), &vlanhdr, sizeof vlanhdr);
+    }
=20
   return vid;
-err:
+drop:
   /* Drop the frame. */
   buf->len =3D 0;
   return -1;
 }
=20
 /*
- * Adds VLAN tagging to a frame.  Short frames that can't be tagged are
- * dropped.
+ * Adds VLAN tagging to a frame.  Assumes vlan_accept =3D=3D VAF_ONLY_VL=
AN_TAGGED
+ * or VAF_ALL and a matching PVID.
  */
 void
-multi_prepend_vlan_identifier (struct multi_instance *mi, struct buffer =
*buf)
+multi_prepend_vlan_tag (const struct context *c, struct buffer *buf)
 {
   struct openvpn_ethhdr eth;
-  struct openvpn_8021qhdr vlanhdr;
-  uint8_t *p;
+  struct openvpn_8021qhdr *vlanhdr;
+
+  /* Frame too small? */
+  if (BLEN (buf) < (int) sizeof (struct openvpn_ethhdr))
+    goto drop;
=20
-  /* Frame too small or not enough head room for VLAN tag? */
-  if ((BLEN (buf) < (int) sizeof (struct openvpn_ethhdr)) ||
-      (buf_reverse_capacity (buf) < SIZE_ETH_TO_8021Q_HDR))
+  eth =3D *(const struct openvpn_ethhdr *) BPTR (buf);
+  if (ntohs (eth.proto) =3D=3D OPENVPN_ETH_P_8021Q)
     {
-      /* Drop the frame. */
-      buf->len =3D 0;
-      return;
+      /* Priority-tagged frame. */
+
+      /* Frame too small for header type? */
+      if (BLEN (buf) < (int) (sizeof (struct openvpn_8021qhdr)))
+	goto drop;
+
+      vlanhdr =3D (struct openvpn_8021qhdr *) BPTR (buf);
     }
+  else
+    {
+      /* Untagged frame. */
=20
-  eth =3D *(const struct openvpn_ethhdr *) BPTR (buf);
-  memcpy (&vlanhdr, &eth, sizeof eth);
-  vlanhdr.tpid =3D htons (OPENVPN_ETH_P_8021Q);
-  vlanhdr.proto =3D eth.proto;
-  vlan_set_vid (&vlanhdr, htons (mi->context.options.vlan_tag));
+      /* Not enough head room for VLAN tag? */
+      if (buf_reverse_capacity (buf) < SIZE_ETH_TO_8021Q_HDR)
+	goto drop;
+
+      vlanhdr =3D (struct openvpn_8021qhdr *) buf_prepend (buf, SIZE_ETH=
_TO_8021Q_HDR);
+
+      /* Initialise VLAN-tag ... */
+      memcpy (vlanhdr, &eth, sizeof eth);
+      vlanhdr->tpid =3D htons (OPENVPN_ETH_P_8021Q);
+      vlanhdr->proto =3D eth.proto;
+      vlanhdr_set_pcp (vlanhdr, htons (0));
+      vlanhdr_set_cfi (vlanhdr, htons (0));
+    }
=20
-  ASSERT (p =3D buf_prepend (buf, SIZE_ETH_TO_8021Q_HDR));
-  memcpy (p, &vlanhdr, sizeof vlanhdr);
+  vlanhdr_set_vid (vlanhdr, htons (c->options.vlan_pvid));
=20
-  msg (M_INFO, "tagging frame with vid %u, type is %04x", mi->context.op=
tions.vlan_tag, vlanhdr.proto);
+  msg (D_VLAN_DEBUG, "tagging frame: vid %d (wrapping proto/len: %04x)",=

+       c->options.vlan_pvid, vlanhdr->proto);
+  return;
+drop:
+  /* Drop the frame. */
+  buf->len =3D 0;
 }
+#endif /* ENABLE_VLAN_TAGGING */
=20
 /*
  * Process packets in the TUN/TAP interface -> TCP/UDP socket direction,=

@@ -2226,7 +2331,11 @@ multi_process_incoming_tun (struct multi_context *=
m, const unsigned int mpp_flag
       unsigned int mroute_flags;
       struct mroute_addr src, dest;
       const int dev_type =3D TUNNEL_TYPE (m->top.c1.tuntap);
+#ifdef ENABLE_VLAN_TAGGING
       int16_t vid =3D 0;
+#else
+      const int16_t vid =3D 0;
+#endif
=20
 #ifdef ENABLE_PF
       struct mroute_addr esrc, *e1, *e2;
@@ -2254,11 +2363,15 @@ multi_process_incoming_tun (struct multi_context =
*m, const unsigned int mpp_flag
        * the appropriate multi_instance object.
        */
=20
-      if (dev_type =3D=3D DEV_TYPE_TAP && m->top.options.vlan_tagging)
+#ifdef ENABLE_VLAN_TAGGING
+      if (dev_type =3D=3D DEV_TYPE_TAP && m->top.options.vlan_accept !=3D=
 VAF_RAW)
         {
-	  if ((vid =3D remove_vlan_identifier (&m->top.c2.buf)) =3D=3D -1)
-	    return false;
+	  if ((vid =3D remove_vlan_tag (&m->top, &m->top.c2.buf)) =3D=3D -1)
+	    {
+	      return false;
+	    }
         }
+#endif
=20
       mroute_flags =3D mroute_extract_addr_from_packet (&src,
 						      &dest,
diff --git a/multi.h b/multi.h
index 26b3e1a..3ed1981 100644
--- a/multi.h
+++ b/multi.h
@@ -405,7 +405,9 @@ multi_get_timeout (struct multi_context *m, struct ti=
meval *dest)
 static inline bool
 multi_process_outgoing_tun (struct multi_context *m, const unsigned int =
mpp_flags)
 {
-  void multi_prepend_vlan_identifier (struct multi_instance *mi, struct =
buffer *buf);
+#ifdef ENABLE_VLAN_TAGGING
+  void multi_prepend_vlan_tag (const struct context *c, struct buffer *b=
uf);
+#endif
   struct multi_instance *mi =3D m->pending;
   bool ret =3D true;
=20
@@ -416,10 +418,26 @@ multi_process_outgoing_tun (struct multi_context *m=
, const unsigned int mpp_flag
 	  mi->context.c2.to_tun.len);
 #endif
   set_prefix (mi);
-  if (mi->context.options.vlan_tag)
+#ifdef ENABLE_VLAN_TAGGING
+  if (m->top.options.vlan_accept =3D=3D VAF_ONLY_UNTAGGED_OR_PRIORITY)
     {
-      multi_prepend_vlan_identifier (mi, &mi->context.c2.to_tun);
+      /* Packets aren't tagged on the tap device. */
+
+      if (m->top.options.vlan_pvid !=3D mi->context.options.vlan_pvid)
+	{
+	  /* Packet is coming from the wrong VID, drop it. */
+	  mi->context.c2.to_tun.len =3D 0;
+	}
     }
+  else if (m->top.options.vlan_accept =3D=3D VAF_ONLY_VLAN_TAGGED ||
+	   (m->top.options.vlan_accept =3D=3D VAF_ALL &&
+	    m->top.options.vlan_pvid !=3D mi->context.options.vlan_pvid))
+    {
+      /* Packets need to be tagged.  Either because all packets are tagg=
ed or
+         because the vid matches the port's pvid. */
+      multi_prepend_vlan_tag (&mi->context, &mi->context.c2.to_tun);
+    }
+#endif
   process_outgoing_tun (&mi->context);
   ret =3D multi_process_post (m, mi, mpp_flags);
   clear_prefix ();
diff --git a/openvpn.8 b/openvpn.8
index 45e61fa..1768e19 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -3194,6 +3194,87 @@ other protocols such as ssh.
=20
 Not implemented on Windows.
 .\"*********************************************************
+.TP
+.B \-\-vlan\-accept raw | tagged | untagged | all
+Allows the routing space of an OpenVPN server to be split into several v=
irtual
+LANs (VLANs).
+
+Setting this to
+.B tagged
+("Admit Only VLAN-tagged frames"),
+.B untagged
+("Admit Only Untagged and Priority-tagged frames") or
+.B all
+("Admit All frames") is only possible in
+.B \-\-dev tap
+mode.
+The default mode is \fB\-\-vlan\-accept raw\fR, in which OpenVPN does no=

+parsing and accepts any Ethernet frames.
+
+For the other three modes, the OpenVPN server instance is turned into a =
switch
+that understands VLAN-tagging. The tap device and each of the connecting=

+clients is seen as a port of the switch. All client ports are in untagge=
d mode
+and the tap device is VLAN-tagged, untagged or accepts both, depending o=
n the
+.B \-\-vlan\-accept
+setting.
+
+Using the
+.B \-\-vlan\-pvid v
+option once per client, each port can be associated with a certain VLAN
+Identifier (VID). Packets can only be distributed between ports with a
+matching VID. Therefore, clients with differing VIDs are completely sepa=
rated
+from one-another, even if
+.B \-\-client-to-client
+is activated.
+
+The filtering of packets takes place in the OpenVPN server. Clients do n=
ot
+need support for VLAN tagging.
+
+Incoming untagged packets from clients are assigned with the client's Po=
rt
+VLAN Identifier (PVID) as their VID. In
+.B untagged
+mode, incoming untagged packets on the tap device are associated with th=
e
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
+mode. Outgoing packets are tagged, unless the VID matches the global PVI=
D, in
+which case the packets go out untagged.
+.\"*********************************************************
+.TP
+.B \-\-vlan\-pvid v
+Specifies which VLAN identifier a "port" is associated with. Not valid i=
n
+.B \-\-vlan\-accept raw
+mode.
+
+In client context, the setting specifies which VLAN identifier a client =
is
+associated with. In global context, the tap device's VLAN identifier is =
set.
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
+In some switch implementations, the Port VLAN Identifier is also referre=
d
+to as Native VLAN.
+.\"*********************************************************
 .SS Client Mode
 Use client mode when connecting to an OpenVPN server
 which has
diff --git a/options.c b/options.c
index aaf92f0..18c2ee1 100644
--- a/options.c
+++ b/options.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...1341...=
t>
+ *  Copyright (C) 2010 Fabian Knittel <fabian.knittel@...1338...>
  *
  *  This program is free software; you can redistribute it and/or modify=

  *  it under the terms of the GNU General Public License version 2
@@ -420,6 +421,11 @@ static const char usage_message[] =3D
   "--port-share host port : When run in TCP mode, proxy incoming HTTPS s=
essions\n"
   "                  to a web server at host:port.\n"
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  "--vlan-accept mode : Set VLAN tagging/untagging mode to either 'raw',=
 'tagged'\n"
+  "                  or untagged.  Default is 'raw'.\n"
+  "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
+#endif
 #endif
   "\n"
   "Client options (when connecting to a multi-client server):\n"
@@ -651,8 +657,6 @@ static const char usage_message[] =3D
   "--show-pkcs11-ids provider [cert_private] : Show PKCS#11 available id=
s.\n"=20
   "                                            --verb option can be adde=
d *BEFORE* this.\n"
 #endif				/* ENABLE_PKCS11 */
-  "\n"
-  "--vlan-tagging  : Enable VLAN tagging/untagging to/from TAP device.\n=
"
  ;
=20
 #endif /* !ENABLE_SMALL */
@@ -756,6 +760,10 @@ init_options (struct options *o, const bool init_gc)=

 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period =3D -1;
 #endif			/* ENABLE_PKCS11 */
+#ifdef ENABLE_VLAN_TAGGING
+  o->vlan_accept =3D VAF_RAW;
+  o->vlan_pvid =3D 1;
+#endif
 }
=20
 void
@@ -950,6 +958,25 @@ dhcp_option_address_parse (const char *name, const c=
har *parm, in_addr_t *array,
=20
 #endif
=20
+#ifdef ENABLE_VLAN_TAGGING
+static const char *
+print_vlan_accept (enum vlan_acceptable_frames mode)
+{
+  switch (mode)
+   {
+    case VAF_RAW:
+      return "raw";
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
=20
 #ifdef ENABLE_DEBUG
@@ -1008,6 +1035,10 @@ show_p2mp_parms (const struct options *o)
   SHOW_STR (port_share_host);
   SHOW_INT (port_share_port);
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  msg (D_SHOW_PARMS, "  vlan_accept =3D %s", print_vlan_accept (o->vlan_=
accept));
+  SHOW_INT (vlan_pvid);
+#endif
 #endif /* P2MP_SERVER */
=20
   SHOW_BOOL (client);
@@ -1177,9 +1208,6 @@ show_settings (const struct options *o)
   SHOW_BOOL (ifconfig_noexec);
   SHOW_BOOL (ifconfig_nowarn);
=20
-  SHOW_BOOL (vlan_tagging);
-  SHOW_INT (vlan_tag);
-
 #ifdef HAVE_GETTIMEOFDAY
   SHOW_INT (shaper);
 #endif
@@ -1747,10 +1775,11 @@ options_postprocess_verify_ce (const struct optio=
ns *options, const struct conne
=20
 	if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) && script_method =3D=3D=
 SM_SYSTEM)
 	  msg (M_USAGE, "--script-security method=3D'system' cannot be combined=
 with --no-name-remapping");
-      if (options->vlan_tagging && dev !=3D DEV_TYPE_TAP)
-	msg (M_USAGE, "--vlan-tagging only works with --dev tap");
-      if (!options->vlan_tagging && options->vlan_tag)
-	msg (M_USAGE, "--vlan-tag must be used with activated --vlan-tagging");=

+#ifdef ENABLE_VLAN_TAGGING
+      if (options->vlan_accept !=3D VAF_RAW && dev !=3D DEV_TYPE_TAP)
+	msg (M_USAGE, "--vlan-accept set to '%s' only works with --dev tap",
+	     print_vlan_accept (options->vlan_accept));
+#endif
     }
   else
     {
@@ -1797,9 +1826,11 @@ options_postprocess_verify_ce (const struct option=
s *options, const struct conne
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --p=
roto tcp-server)");
 #endif
-      if (options->vlan_tagging || options->vlan_tag)
-	msg (M_USAGE, "--vlan-tagging/--vlan-tag requires --mode server");
-
+#ifdef ENABLE_VLAN_TAGGING
+      if (options->vlan_accept !=3D VAF_RAW)
+	msg (M_USAGE, "--vlan-accept set to '%s' requires --mode server",
+	     print_vlan_accept (options->vlan_accept));
+#endif
     }
 #endif /* P2MP_SERVER */
=20
@@ -5741,29 +5772,44 @@ add_option (struct options *options,
       options->persist_mode =3D 1;
     }
 #endif
-  else if (streq (p[0], "vlan-tagging"))
+#ifdef ENABLE_VLAN_TAGGING
+  else if (streq (p[0], "vlan-accept") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->vlan_tagging =3D true;
-    }
-  else if (streq (p[0], "vlan-tag"))
-    {
-      VERIFY_PERMISSION (OPT_P_INSTANCE);
-      if (p[1])
+      if (streq (p[1], "raw"))
 	{
-	  options->vlan_tag =3D positive_atoi (p[1]);
-	  if (options->vlan_tag < OPENVPN_8021Q_MIN_VID || options->vlan_tag > =
OPENVPN_8021Q_MAX_VID)
-	    {
-	      msg (msglevel, "the parameter of --vlan-tag parameters must be >=3D=
 %d and <=3D %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
-	      goto err;
-	    }
+	  options->vlan_accept =3D VAF_RAW;
+	}
+      else if (streq (p[1], "tagged"))
+	{
+	  options->vlan_accept =3D VAF_ONLY_VLAN_TAGGED;
+	}
+      else if (streq (p[1], "untagged"))
+	{
+	  options->vlan_accept =3D VAF_ONLY_UNTAGGED_OR_PRIORITY;
+	}
+      else if (streq (p[1], "all"))
+	{
+	  options->vlan_accept =3D VAF_ALL;
 	}
       else
 	{
-	  msg (msglevel, "error parsing --vlan-tag parameters");
+	  msg (msglevel, "--vlan-accept must be 'raw', 'tagged' or 'untagged'")=
;
+	  goto err;
+	}
+    }
+  else if (streq (p[0], "vlan-pvid") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
+      options->vlan_pvid =3D positive_atoi (p[1]);
+      if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
+	  options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
+	{
+	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >=3D =
%d and <=3D %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
 	  goto err;
 	}
     }
+#endif
   else
     {
       if (file)
diff --git a/options.h b/options.h
index f4ca502..8d67011 100644
--- a/options.h
+++ b/options.h
@@ -126,6 +126,16 @@ struct remote_list
=20
 #endif
=20
+#ifdef ENABLE_VLAN_TAGGING
+enum vlan_acceptable_frames
+{
+  VAF_RAW =3D 0,
+  VAF_ONLY_VLAN_TAGGED,
+  VAF_ONLY_UNTAGGED_OR_PRIORITY,
+  VAF_ALL,
+};
+#endif
+
 /* Command line options */
 struct options
 {
@@ -510,8 +520,10 @@ struct options
   int route_method;
 #endif
=20
-  bool vlan_tagging;
-  int vlan_tag;
+#ifdef ENABLE_VLAN_TAGGING
+  enum vlan_acceptable_frames vlan_accept;
+  int vlan_pvid;
+#endif
 };
=20
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/proto.h b/proto.h
index 671331f..5c641ff 100644
--- a/proto.h
+++ b/proto.h
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...1341...=
t>
+ *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1338...>
  *
  *  This program is free software; you can redistribute it and/or modify=

  *  it under the terms of the GNU General Public License version 2
@@ -71,8 +72,10 @@ struct openvpn_8021qhdr
   uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
=20
   uint16_t tpid;                      /* 802.1Q Tag Protocol Identifier =
*/
-# define OPENVPN_8021Q_MASK_VID htons (0xFFFE) /* mask VID out of tag */=

-  uint16_t tag;                       /* tag field containing PCP, CFI, =
VID */
+# define OPENVPN_8021Q_MASK_VID htons (0x0FFF) /* mask VID out of pcp_cf=
i_vid */
+# define OPENVPN_8021Q_MASK_PCP htons (0xE000) /* mask PCP out of pcp_cf=
i_vid */
+# define OPENVPN_8021Q_MASK_CFI htons (0x1000) /* mask CFI out of pcp_cf=
i_vid */
+  uint16_t pcp_cfi_vid;               /* bit fields, see IEEE 802.1Q */
   uint16_t proto;                     /* contained packet type ID field =
*/
 };
=20
@@ -217,26 +220,59 @@ void ipv4_packet_size_verify (const uint8_t *data,
 			      counter_type *errors);
 #endif
=20
+#ifdef ENABLE_VLAN_TAGGING
+# define OPENVPN_8021Q_MIN_VID 1
+# define OPENVPN_8021Q_MAX_VID 4094
=20
-#define OPENVPN_8021Q_MIN_VID 1
-#define OPENVPN_8021Q_MAX_VID ntohs (OPENVPN_8021Q_MASK_VID)
-
+/*
+ * Retrieve the Priority Code Point (PCP) from the IEEE 802.1Q header.
+ */
+static inline int
+vlanhdr_get_pcp (const struct openvpn_8021qhdr *hdr)
+{
+  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_PCP;
+}
+/*
+ * Retrieve the Canonical Format Indicator (CFI) from the IEEE 802.1Q he=
ader.
+ */
+static inline int
+vlanhdr_get_cfi (const struct openvpn_8021qhdr *hdr)
+{
+  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_CFI;
+}
 /*
  * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
  */
 static inline int
-vlan_get_vid (const struct openvpn_8021qhdr *hdr)
+vlanhdr_get_vid (const struct openvpn_8021qhdr *hdr)
 {
-  return hdr->tag & OPENVPN_8021Q_MASK_VID;
+  return hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID;
 }
=20
 /*
+ * Set the Priority Code Point (PCP) in an IEEE 802.1Q header.
+ */
+static inline void
+vlanhdr_set_pcp (struct openvpn_8021qhdr *hdr, const int pcp)
+{
+  hdr->pcp_cfi_vid =3D (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_PCP) | (p=
cp & OPENVPN_8021Q_MASK_PCP);
+}
+/*
+ * Set the Canonical Format Indicator (CFI) in an IEEE 802.1Q header.
+ */
+static inline void
+vlanhdr_set_cfi (struct openvpn_8021qhdr *hdr, const int cfi)
+{
+  hdr->pcp_cfi_vid =3D (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_CFI) | (c=
fi & OPENVPN_8021Q_MASK_CFI);
+}
+/*
  * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
  */
 static inline void
-vlan_set_vid (struct openvpn_8021qhdr *hdr, const int vid)
+vlanhdr_set_vid (struct openvpn_8021qhdr *hdr, const int vid)
 {
-  hdr->tag =3D (hdr->tag & ~OPENVPN_8021Q_MASK_VID) | (vid & OPENVPN_802=
1Q_MASK_VID);
+  hdr->pcp_cfi_vid =3D (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (v=
id & OPENVPN_8021Q_MASK_VID);
 }
+#endif
=20
 #endif


--------------050601070600030707090809--

--------------enigA144CF26E544C4DF8AF0EA28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku6VnkACgkQARH1aMTipzOOGQCgr2DAWuXSMN0/7Z/pP1NIEp5T
k90AnR5uP/Z2WjiGopyV0B/KnUlRtAWE
=z6Ul
-----END PGP SIGNATURE-----

--------------enigA144CF26E544C4DF8AF0EA28--

