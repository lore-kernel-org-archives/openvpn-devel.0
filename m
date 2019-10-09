From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:15 +0200
Message-Id: <20191009143422.9419-3-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/9] VLAN: add basic VLAN tagging support
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

This patch introduces basic support for VLAN tagging on the server side.
The introduced functionality consists in allowing the user to assign
a VID to the server TAP device and a VID to each client port.

Client specific VID are assigned by means of files in CCD (like for
other client specific settings).

Once VIDs have been assigned, everything works as before, except that
communications are allowed only between hosts having the same VID.

With this patch all broadcast and client-to-client traffic is yet
separated by VLAN: only client-to-server unicasts are affected.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/Makefile.am |   1 +
 src/openvpn/errlevel.h  |   2 +
 src/openvpn/multi.c     |  27 +++++++---
 src/openvpn/multi.h     |   2 +
 src/openvpn/options.c   |  54 ++++++++++++++++++++
 src/openvpn/options.h   |   9 ++++
 src/openvpn/proto.h     |  25 +++++++++
 src/openvpn/vlan.c      | 110 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/vlan.h      |  44 ++++++++++++++++
 9 files changed, 268 insertions(+), 6 deletions(-)
 create mode 100644 src/openvpn/vlan.c
 create mode 100644 src/openvpn/vlan.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 30caa01f..bc976019 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -123,6 +123,7 @@ openvpn_SOURCES = \
 	syshead.h \
 	tls_crypt.c tls_crypt.h \
 	tun.c tun.h \
+	vlan.c vlan.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 60896c1f..e448fc37 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -148,6 +148,8 @@
 #define D_PF_DEBUG           LOGLEV(7, 72, M_DEBUG)  /* packet filter debugging, must also define PF_DEBUG in pf.h */
 #define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG)  /* show push/pull debugging info */
 
+#define D_VLAN_DEBUG         LOGLEV(7, 74, M_DEBUG)  /* show VLAN tagging/untagging debug info */
+
 #define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed description of each handshake */
 #define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info from tls_session routines */
 #define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h debugging info */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d1f9c72e..8caaa868 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -45,6 +45,7 @@
 #include "gremlin.h"
 #include "mstats.h"
 #include "ssl_verify.h"
+#include "vlan.h"
 #include <inttypes.h>
 
 #include "memdbg.h"
@@ -2208,7 +2209,8 @@ static void
 multi_bcast(struct multi_context *m,
             const struct buffer *buf,
             const struct multi_instance *sender_instance,
-            const struct mroute_addr *sender_addr)
+            const struct mroute_addr *sender_addr,
+            uint16_t vid)
 {
     struct hash_iterator hi;
     struct hash_element *he;
@@ -2258,6 +2260,10 @@ multi_bcast(struct multi_context *m,
                     }
                 }
 #endif /* ifdef ENABLE_PF */
+                if (vid != 0 && vid != mi->context.options.vlan_pvid)
+                {
+                    continue;
+                }
                 multi_add_mbuf(m, mi, mb);
             }
         }
@@ -2595,7 +2601,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                     if (mroute_flags & MROUTE_EXTRACT_MCAST)
                     {
                         /* for now, treat multicast as broadcast */
-                        multi_bcast(m, &c->c2.to_tun, m->pending, NULL);
+                        multi_bcast(m, &c->c2.to_tun, m->pending, NULL, 0);
                     }
                     else /* possible client to client routing */
                     {
@@ -2640,6 +2646,15 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                 struct mroute_addr edest;
                 mroute_addr_reset(&edest);
 #endif
+                if (m->top.options.vlan_tagging)
+                {
+                    if (vlan_is_tagged(&c->c2.to_tun))
+                    {
+                        /* Drop VLAN-tagged frame. */
+                        msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
+                        c->c2.to_tun.len = 0;
+                    }
+                }
                 /* extract packet source and dest addresses */
                 mroute_flags = mroute_extract_addr_from_packet(&src,
                                                                &dest,
@@ -2661,7 +2676,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         {
                             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
                             {
-                                multi_bcast(m, &c->c2.to_tun, m->pending, NULL);
+                                multi_bcast(m, &c->c2.to_tun, m->pending, NULL, 0);
                             }
                             else /* try client-to-client routing */
                             {
@@ -2788,9 +2803,9 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
             {
                 /* for now, treat multicast as broadcast */
 #ifdef ENABLE_PF
-                multi_bcast(m, &m->top.c2.buf, NULL, e2);
+                multi_bcast(m, &m->top.c2.buf, NULL, e2, 0);
 #else
-                multi_bcast(m, &m->top.c2.buf, NULL, NULL);
+                multi_bcast(m, &m->top.c2.buf, NULL, NULL, 0);
 #endif
             }
             else
@@ -2972,7 +2987,7 @@ gremlin_flood_clients(struct multi_context *m)
 
         for (i = 0; i < parm.n_packets; ++i)
         {
-            multi_bcast(m, &buf, NULL, NULL);
+            multi_bcast(m, &buf, NULL, NULL, 0);
         }
 
         gc_free(&gc);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index d87f21b9..cfd86bbe 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -40,6 +40,7 @@
 #include "mudp.h"
 #include "mtcp.h"
 #include "perf.h"
+#include "vlan.h"
 
 #define MULTI_PREFIX_MAX_LENGTH 256
 
@@ -620,6 +621,7 @@ multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags
            mi->context.c2.to_tun.len);
 #endif
     set_prefix(mi);
+    vlan_process_outgoing_tun(m, mi);
     process_outgoing_tun(&mi->context);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d3865a6..caba6494 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -53,6 +53,7 @@
 #include "win32.h"
 #include "push.h"
 #include "pool.h"
+#include "proto.h"
 #include "helper.h"
 #include "manage.h"
 #include "forward.h"
@@ -404,6 +405,8 @@ static const char usage_message[] =
     "--plugin m [str]: Load plug-in module m passing str as an argument\n"
     "                  to its initialization function.\n"
 #endif
+    "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
+    "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
 #if P2MP
 #if P2MP_SERVER
     "\n"
@@ -849,6 +852,8 @@ init_options(struct options *o, const bool init_gc)
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
 #endif
+    o->vlan_accept = VLAN_ONLY_UNTAGGED_OR_PRIORITY;
+    o->vlan_pvid = 1;
 #if P2MP_SERVER
     o->real_hash_size = 256;
     o->virtual_hash_size = 256;
@@ -1224,6 +1229,17 @@ dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array,
 
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 
+static const char *
+print_vlan_accept(enum vlan_acceptable_frames mode)
+{
+    switch (mode)
+    {
+        case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
+            return "untagged";
+    }
+    return NULL;
+}
+
 #if P2MP
 
 #ifndef ENABLE_SMALL
@@ -1293,6 +1309,9 @@ show_p2mp_parms(const struct options *o)
     SHOW_STR(port_share_host);
     SHOW_STR(port_share_port);
 #endif
+    SHOW_BOOL(vlan_tagging);
+    msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
+    SHOW_INT(vlan_pvid);
 #endif /* P2MP_SERVER */
 
     SHOW_BOOL(client);
@@ -2355,6 +2374,18 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
                 msg(M_USAGE, "--auth-user-pass-optional %s", postfix);
             }
         }
+
+        if (options->vlan_tagging && dev != DEV_TYPE_TAP)
+        {
+            msg(M_USAGE, "--vlan-tagging must be used with --dev tap");
+        }
+        if (!options->vlan_tagging)
+        {
+            if (options->vlan_pvid != defaults.vlan_pvid)
+            {
+                msg(M_USAGE, "--vlan-pvid requires --vlan-tagging");
+            }
+        }
     }
     else
     {
@@ -2444,6 +2475,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--stale-routes-check requires --mode server");
         }
+
+        if (options->vlan_tagging)
+        {
+            msg(M_USAGE, "--vlan-tagging requires --mode server");
+        }
     }
 #endif /* P2MP_SERVER */
 
@@ -8359,6 +8395,24 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->allow_recursive_routing = true;
     }
+    else if (streq(p[0], "vlan-tagging") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->vlan_tagging = true;
+    }
+    else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
+        options->vlan_pvid = positive_atoi(p[1]);
+        if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID
+            || options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
+        {
+            msg(msglevel,
+                "the parameter of --vlan-pvid parameters must be >= %u and <= %u",
+                OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
+            goto err;
+        }
+    }
     else
     {
         int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 63f0f4cb..3f5c5465 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -169,6 +169,11 @@ struct remote_list
     struct remote_entry *array[CONNECTION_LIST_SIZE];
 };
 
+enum vlan_acceptable_frames
+{
+    VLAN_ONLY_UNTAGGED_OR_PRIORITY,
+};
+
 struct remote_host_store
 {
 #define RH_HOST_LEN 80
@@ -632,6 +637,10 @@ struct options
     int keying_material_exporter_length;
 #endif
 
+    bool vlan_tagging;
+    enum vlan_acceptable_frames vlan_accept;
+    uint16_t vlan_pvid;
+
     struct pull_filter_list *pull_filter_list;
 
     /* Useful when packets sent by openvpn itself are not subject
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 4ddffc7d..c1ff3e14 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -60,9 +60,31 @@ struct openvpn_ethhdr
 #define OPENVPN_ETH_P_IPV4   0x0800   /* IPv4 protocol */
 #define OPENVPN_ETH_P_IPV6   0x86DD   /* IPv6 protocol */
 #define OPENVPN_ETH_P_ARP    0x0806   /* ARP protocol */
+#define OPENVPN_ETH_P_8021Q  0x8100   /* 802.1Q protocol */
     uint16_t proto;                   /* packet type ID field */
 };
 
+struct openvpn_8021qhdr
+{
+    uint8_t dest[OPENVPN_ETH_ALEN];     /* destination ethernet addr */
+    uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
+
+    uint16_t tpid;                      /* 802.1Q Tag Protocol Identifier */
+#define OPENVPN_8021Q_MASK_PCP htons(0xE000) /* mask PCP out of pcp_cfi_vid */
+#define OPENVPN_8021Q_MASK_CFI htons(0x1000) /* mask CFI out of pcp_cfi_vid */
+#define OPENVPN_8021Q_MASK_VID htons(0x0FFF) /* mask VID out of pcp_cfi_vid */
+    uint16_t pcp_cfi_vid;               /* bit fields, see IEEE 802.1Q */
+    uint16_t proto;                     /* contained packet type ID field */
+};
+
+/*
+ * Size difference between a regular Ethernet II header and an Ethernet II
+ * header with additional IEEE 802.1Q tagging.
+ */
+#define SIZE_ETH_TO_8021Q_HDR (sizeof(struct openvpn_8021qhdr) \
+                               - sizeof(struct openvpn_ethhdr))
+
+
 struct openvpn_arp {
 #define ARP_MAC_ADDR_TYPE 0x0001
     uint16_t mac_addr_type;     /* 0x0001 */
@@ -311,4 +333,7 @@ void ipv4_packet_size_verify(const uint8_t *data,
 
 #endif
 
+#define OPENVPN_8021Q_MIN_VID 1
+#define OPENVPN_8021Q_MAX_VID 4094
+
 #endif /* ifndef PROTO_H */
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
new file mode 100644
index 00000000..8e987277
--- /dev/null
+++ b/src/openvpn/vlan.c
@@ -0,0 +1,110 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if P2MP_SERVER
+
+#include "multi.h"
+#include "options.h"
+#include "vlan.h"
+
+/*
+ * Retrieve the VLAN Identifier (VID) from the IEEE 802.1Q header.
+ *
+ * @param hdr Pointer to the Ethernet header with IEEE 802.1Q tagging.
+ * @return    Returns the VID in host byte order.
+ */
+static uint16_t
+vlanhdr_get_vid(const struct openvpn_8021qhdr *hdr)
+{
+    return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
+}
+
+/*
+ * vlan_is_tagged - check if a packet is VLAN-tagged
+ *
+ * Checks whether ethernet frame is VLAN-tagged.
+ *
+ * @param buf The ethernet frame.
+ * @return    Returns true if the frame is VLAN-tagged, false otherwise.
+ */
+bool
+vlan_is_tagged(const struct buffer *buf)
+{
+    const struct openvpn_8021qhdr *vlanhdr;
+    uint16_t vid;
+
+    if (BLEN(buf) < sizeof(struct openvpn_8021qhdr))
+    {
+        /* frame too small to be VLAN-tagged */
+        return false;
+    }
+
+    vlanhdr = (const struct openvpn_8021qhdr *)BPTR(buf);
+
+    if (ntohs(vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
+    {
+        /* non tagged frame */
+        return false;
+    }
+
+    vid = vlanhdr_get_vid(vlanhdr);
+    if (vid == 0)
+    {
+        /* no vid: piority tagged only */
+        return false;
+    }
+
+    return true;
+}
+
+void
+vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
+{
+    if (!m->top.options.vlan_tagging)
+    {
+        return;
+    }
+
+    if (m->top.options.vlan_accept == VLAN_ONLY_UNTAGGED_OR_PRIORITY)
+    {
+        /* Packets forwarded to the TAP devices aren't VLAN-tagged. Only packets
+         * matching the PVID configured globally are allowed to be received
+         */
+        if (m->top.options.vlan_pvid != mi->context.options.vlan_pvid)
+        {
+            /* Packet is coming from the wrong VID, drop it.  */
+            mi->context.c2.to_tun.len = 0;
+        }
+    }
+}
+
+#endif /* P2MP_SERVER */
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
new file mode 100644
index 00000000..1ef68813
--- /dev/null
+++ b/src/openvpn/vlan.h
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2019 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef VLAN_H
+#define VLAN_H
+
+#if P2MP_SERVER
+
+#include "buffer.h"
+#include "mroute.h"
+
+struct multi_context;
+struct multi_instance;
+
+bool
+vlan_is_tagged(const struct buffer *buf);
+
+void
+vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
+
+#endif /* P2MP_SERVER */
+
+#endif /* VLAN_H */
-- 
2.23.0


