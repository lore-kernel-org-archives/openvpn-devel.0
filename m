From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:19 +0200
Message-Id: <20191009143422.9419-7-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/9] VLAN: implement support for forwarding
 only pre-tagged VLAN packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>, Fabian Knittel <fabian.knittel@...1547...>

By building on top of the VLAN basic support, allow the user to configure
the server in VLAN_TAGGED-only mode. This way, only packets that reach
the TAP interface with an 802.1Q header are considered for forwarding -
untagged packets are all dropped.

A VLAN-tagged packet is then treated like any other packet by the
OpenVPN routing engine, with the exception of being allowed to reach
only clients configured with the same VID.

The logic applies to all server-to-client and client-to-client traffic.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c   |  16 +++-
 src/openvpn/options.c |  24 +++++
 src/openvpn/options.h |   1 +
 src/openvpn/vlan.c    | 210 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/vlan.h    |   4 +
 5 files changed, 252 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e733ca9a..d594dd25 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2763,6 +2763,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
         unsigned int mroute_flags;
         struct mroute_addr src, dest;
         const int dev_type = TUNNEL_TYPE(m->top.c1.tuntap);
+        int16_t vid = 0;
 
 #ifdef ENABLE_PF
         struct mroute_addr esrc, *e1, *e2;
@@ -2787,6 +2788,15 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
             return true;
         }
 
+        if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
+        {
+            vid = vlan_decapsulate(&m->top, &m->top.c2.buf);
+            if (vid < 0)
+            {
+                return false;
+            }
+        }
+
         /*
          * Route an incoming tun/tap packet to
          * the appropriate multi_instance object.
@@ -2800,7 +2810,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
                                                        NULL,
 #endif
                                                        NULL,
-                                                       0,
+                                                       vid,
                                                        &m->top.c2.buf,
                                                        dev_type);
 
@@ -2813,9 +2823,9 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
             {
                 /* for now, treat multicast as broadcast */
 #ifdef ENABLE_PF
-                multi_bcast(m, &m->top.c2.buf, NULL, e2, 0);
+                multi_bcast(m, &m->top.c2.buf, NULL, e2, vid);
 #else
-                multi_bcast(m, &m->top.c2.buf, NULL, NULL, 0);
+                multi_bcast(m, &m->top.c2.buf, NULL, NULL, vid);
 #endif
             }
             else
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index caba6494..5be6a6a8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -406,6 +406,7 @@ static const char usage_message[] =
     "                  to its initialization function.\n"
 #endif
     "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
+    "--vlan-accept tagged|untagged : Set VLAN tagging mode.\n"
     "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
 #if P2MP
 #if P2MP_SERVER
@@ -1234,6 +1235,8 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
 {
     switch (mode)
     {
+        case VLAN_ONLY_TAGGED:
+            return "tagged";
         case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
             return "untagged";
     }
@@ -2381,6 +2384,10 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         }
         if (!options->vlan_tagging)
         {
+            if (options->vlan_accept != defaults.vlan_accept)
+            {
+                msg(M_USAGE, "--vlan-accept requires --vlan-tagging");
+            }
             if (options->vlan_pvid != defaults.vlan_pvid)
             {
                 msg(M_USAGE, "--vlan-pvid requires --vlan-tagging");
@@ -8400,6 +8407,23 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->vlan_tagging = true;
     }
+    else if (streq(p[0], "vlan-accept") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (streq(p[1], "tagged"))
+        {
+            options->vlan_accept = VLAN_ONLY_TAGGED;
+        }
+        else if (streq(p[1], "untagged"))
+        {
+            options->vlan_accept = VLAN_ONLY_UNTAGGED_OR_PRIORITY;
+        }
+        else
+        {
+            msg(msglevel, "--vlan-accept must be 'tagged', 'untagged'");
+            goto err;
+        }
+    }
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3f5c5465..3447b7e2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -171,6 +171,7 @@ struct remote_list
 
 enum vlan_acceptable_frames
 {
+    VLAN_ONLY_TAGGED,
     VLAN_ONLY_UNTAGGED_OR_PRIORITY,
 };
 
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 8e987277..88c90574 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -48,6 +48,211 @@ vlanhdr_get_vid(const struct openvpn_8021qhdr *hdr)
     return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }
 
+/*
+ * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @param vid The VID to set (in host byte order).
+ */
+static void
+vlanhdr_set_vid(struct openvpn_8021qhdr *hdr, const uint16_t vid)
+{
+    hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID)
+                        | (htons(vid) & OPENVPN_8021Q_MASK_VID);
+}
+
+/*
+ * vlan_decapsulate - remove 802.1q header and return VID
+ *
+ * For vlan_accept == VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+ *   Only untagged frames and frames that are priority-tagged (VID == 0) are
+ *   accepted.  (This means that VLAN-tagged frames are dropped.)  For frames
+ *   that aren't dropped, the global vlan_pvid is returned as VID.
+ *
+ * For vlan_accept == VLAN_ONLY_TAGGED:
+ *   If a frame is VLAN-tagged the tagging is removed and the embedded VID is
+ *   returned.  Any included priority information is lost.
+ *   If a frame isn't VLAN-tagged, the frame is dropped.
+ *
+ * @param c   The global context.
+ * @param buf The ethernet frame.
+ * @return    Returns -1 if the frame is dropped or the VID if it is accepted.
+ */
+int16_t
+vlan_decapsulate(const struct context *c, struct buffer *buf)
+{
+    const struct openvpn_8021qhdr *vlanhdr;
+    struct openvpn_ethhdr *ethhdr;
+    uint16_t vid;
+
+    /* assume untagged frame */
+    if (BLEN(buf) < sizeof(*ethhdr))
+    {
+        goto drop;
+    }
+
+    ethhdr = (struct openvpn_ethhdr *)BPTR(buf);
+    if (ethhdr->proto != htons(OPENVPN_ETH_P_8021Q))
+    {
+        /* reject untagged frame */
+        if (c->options.vlan_accept == VLAN_ONLY_TAGGED)
+        {
+            msg(D_VLAN_DEBUG,
+                "dropping frame without vlan-tag (proto/len 0x%04x)",
+                ntohs(ethhdr->proto));
+            goto drop;
+        }
+
+        /* untagged frame is accepted and associated with the global VID */
+        msg(D_VLAN_DEBUG,
+            "assuming pvid for frame without vlan-tag, pvid: %u (proto/len 0x%04x)",
+            c->options.vlan_pvid, ntohs(ethhdr->proto));
+
+        return c->options.vlan_pvid;
+    }
+
+    /* tagged frame */
+    if (BLEN(buf) < sizeof(*vlanhdr))
+    {
+        goto drop;
+    }
+
+    vlanhdr = (const struct openvpn_8021qhdr *)BPTR(buf);
+    vid = vlanhdr_get_vid(vlanhdr);
+
+    switch (c->options.vlan_accept)
+    {
+        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+            /* VLAN-tagged frame: drop packet */
+            if (vid != 0)
+            {
+                msg(D_VLAN_DEBUG, "dropping frame with vlan-tag, vid: %u (proto/len 0x%04x)",
+                    vid, ntohs(vlanhdr->proto));
+                goto drop;
+            }
+
+            /* vid == 0 means prio-tagged packet: don't drop and fall-through */
+        case VLAN_ONLY_TAGGED:
+            /* tagged frame can be accepted: extract vid and strip encapsulation */
+
+            /* in case of prio-tagged frame (vid == 0), assume the sender
+             * knows what he is doing and forward the packet as it is, so to
+             * keep the priority information intact.
+             */
+            if (vid == 0)
+            {
+                /* return the global VID for priority-tagged frames */
+                return c->options.vlan_pvid;
+            }
+
+            /* here we have a proper VLAN tagged frame: perform decapsulation
+             * and return embedded VID
+             */
+            msg(D_VLAN_DEBUG,
+                "removing vlan-tag from frame: vid: %u, wrapped proto/len: 0x%04x",
+                vid, ntohs(vlanhdr->proto));
+
+            /* save inner protocol to be restored later after decapsulation */
+            uint16_t proto = vlanhdr->proto;
+            /* move the buffer head forward to adjust the headroom to a
+             * non-tagged frame
+             */
+            buf_advance(buf, SIZE_ETH_TO_8021Q_HDR);
+            /* move the content of the 802.1q header to the new head, so that
+             * src/dst addresses are copied over
+             */
+            ethhdr = memmove(BPTR(buf), vlanhdr, sizeof(*ethhdr));
+            /* restore the inner protocol value */
+            ethhdr->proto = proto;
+
+            return vid;
+    }
+
+drop:
+    buf->len = 0;
+    return -1;
+}
+
+/*
+ * vlan_encapsulate - add 802.1q header and set the context related VID
+ *
+ * Assumes vlan_accept == VLAN_ONLY_TAGGED
+ *
+ * @param c   The current context.
+ * @param buf The ethernet frame to encapsulate.
+ */
+void
+vlan_encapsulate(const struct context *c, struct buffer *buf)
+{
+    const struct openvpn_ethhdr *ethhdr;
+    struct openvpn_8021qhdr *vlanhdr;
+
+    if (BLEN(buf) < sizeof(*ethhdr))
+    {
+        goto drop;
+    }
+
+    ethhdr = (const struct openvpn_ethhdr *)BPTR(buf);
+    if (ethhdr->proto == htons(OPENVPN_ETH_P_8021Q))
+    {
+        /* Priority-tagged frame. (VLAN-tagged frames have been dropped before
+         * getting to this point)
+         */
+
+        /* Frame too small for header type? */
+        if (BLEN(buf) < sizeof(*vlanhdr))
+        {
+            goto drop;
+        }
+
+        vlanhdr = (struct openvpn_8021qhdr *)BPTR(buf);
+
+        /* sanity check: ensure this packet is really just prio-tagged */
+        uint16_t vid = vlanhdr_get_vid(vlanhdr);
+        if (vid != 0)
+        {
+            goto drop;
+        }
+    }
+    else
+    {
+        /* Untagged frame. */
+
+        /* Not enough head room for VLAN tag? */
+        if (buf_reverse_capacity(buf) < SIZE_ETH_TO_8021Q_HDR)
+        {
+            goto drop;
+        }
+
+        vlanhdr = (struct openvpn_8021qhdr *)buf_prepend(buf,
+                                                         SIZE_ETH_TO_8021Q_HDR);
+
+        /* Initialise VLAN/802.1q header.
+         * Move the Eth header so to keep dst/src addresses the same and then
+         * assign the other fields.
+         *
+         * Also, save the inner protocol first, so that it can be restored later
+         * after the memmove()
+         */
+        uint16_t proto = ethhdr->proto;
+        memmove(vlanhdr, ethhdr, sizeof(*ethhdr));
+        vlanhdr->tpid = htons(OPENVPN_ETH_P_8021Q);
+        vlanhdr->pcp_cfi_vid = 0;
+        vlanhdr->proto = proto;
+    }
+
+    /* set the VID corresponding to the current context (client) */
+    vlanhdr_set_vid(vlanhdr, c->options.vlan_pvid);
+
+    msg(D_VLAN_DEBUG, "tagging frame: vid %u (wrapping proto/len: %04x)",
+        c->options.vlan_pvid, vlanhdr->proto);
+    return;
+
+drop:
+    /* Drop the frame. */
+    buf->len = 0;
+}
+
 /*
  * vlan_is_tagged - check if a packet is VLAN-tagged
  *
@@ -105,6 +310,11 @@ vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
             mi->context.c2.to_tun.len = 0;
         }
     }
+    else if (m->top.options.vlan_accept == VLAN_ONLY_TAGGED)
+    {
+        /* All packets on the port (the tap device) need to be VLAN-tagged.  */
+        vlan_encapsulate(&mi->context, &mi->context.c2.to_tun);
+    }
 }
 
 #endif /* P2MP_SERVER */
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index 1ef68813..a67ad0e1 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -29,10 +29,14 @@
 
 #include "buffer.h"
 #include "mroute.h"
+#include "openvpn.h"
 
 struct multi_context;
 struct multi_instance;
 
+int16_t
+vlan_decapsulate(const struct context *c, struct buffer *buf);
+
 bool
 vlan_is_tagged(const struct buffer *buf);
 
-- 
2.23.0


