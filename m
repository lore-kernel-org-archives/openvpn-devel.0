From: Antonio Quartulli <a@...2181...>
Date: Sun,  3 Dec 2017 00:24:53 +0800
Message-Id: <20171202162453.29838-2-a@...2181...>
In-Reply-To: <20171202162453.29838-1-a@...2181...>
References: <20171202162453.29838-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/2] PF: never drop essential ICMPv6 packets
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
Cc: Antonio Quartulli <a@...2181...>

Some ICMPv6 packets can't be dropped otherwise the entire
overlaying network layer (IPv6) would just stop working.

Such packets are described in RFC4890, sec. 4.4.1.

Improve the mroute packet parsing routine in order to detect
these specific packets types and thus avoid PF to drop them.

This way, when PF is enabled, the user won't need to whitelist
any specific multicats IPv6 address. PF will just work as
expected.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/mroute.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/mroute.h |  4 ++-
 src/openvpn/multi.c  | 19 +++++++++++---
 src/openvpn/proto.h  | 16 ++++++++++++
 4 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 8b364efd..68a440f6 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -126,6 +126,71 @@ mroute_is_mcast_ipv6(const struct in6_addr addr)
 }
 
 #ifdef ENABLE_PF
+/**
+ * Return the ICMPv6 sub-packet type
+ *
+ * @param buf packet buffer pointing to the beginning of the IMCPv6 header
+ */
+static uint8_t
+mroute_icmp6_get_type(const struct buffer *buf)
+{
+    const struct openvpn_icmp6hdr *icmp6;
+
+    if (BLEN (buf) < (int) sizeof (struct openvpn_icmp6hdr))
+    {
+        return 0;
+    }
+
+    icmp6 = (const struct openvpn_icmp6hdr *) BPTR (buf);
+
+    return icmp6->icmp6_type;
+}
+
+/**
+ * Check if this IPv6 packet is essential to IPv6 basic communications and,
+ * therefore, should not be dropped (based on RFC4890, sec. 4.4.1)
+ *
+ * @param ipv6	pointer to the current IPv6 header
+ * @param buf	packet buffer pointing to the beginning of the IPv6 header
+ */
+static bool
+mroute_ipv6_should_not_drop(const struct openvpn_ipv6hdr *ipv6,
+                            const struct buffer *buf)
+{
+    struct buffer b = *buf;
+    uint8_t type;
+
+    /* packets to "save" are a subset of ICMPv6 */
+    if (ipv6->nexthdr != IPPROTO_ICMPV6)
+    {
+        return false;
+    }
+
+    if (!buf_advance (&b, sizeof (struct openvpn_ipv6hdr)))
+    {
+        return false;
+    }
+
+    type = mroute_icmp6_get_type (&b);
+
+    switch (type)
+    {
+        /*
+         * By following the guideline of RFC4890, sec. 4.4.1, the
+         * following are the ICMPv6 packet types that are strictly
+         * required to let a host join a IPv6 network.
+         * Therefore, such packets can't be dropped by PF.
+         */
+        case OPENVPN_ND_ROUTER_SOLICIT:
+        case OPENVPN_ND_ROUTER_ADVERT:
+        case OPENVPN_ND_NEIGHBOR_SOLICIT:
+        case OPENVPN_ND_NEIGHBOR_ADVERT:
+        case OPENVPN_ND_INVERSE_SOLICIT:
+        case OPENVPN_ND_INVERSE_ADVERT:
+            return true;
+    }
+    return false;
+}
 
 static unsigned int
 mroute_extract_addr_arp(struct mroute_addr *src,
@@ -212,9 +277,15 @@ mroute_extract_addr_ip(struct mroute_addr *src, struct mroute_addr *dest,
                     }
 
                     ret |= MROUTE_EXTRACT_SUCCEEDED;
+
+#ifdef ENABLE_PF
+                    if (mroute_ipv6_should_not_drop (ipv6, buf))
+                    {
+                        ret |= MROUTE_EXTRACT_NO_DROP;
+                    }
+#endif
                 }
                 break;
-
             default:
                 msg(M_WARN, "IP packet with unknown IP version=%d seen",
                     OPENVPN_IPH_GET_VER(*BPTR(buf)));
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index eacb1239..ab04c98a 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -41,13 +41,15 @@
 #define MROUTE_EXTRACT_BCAST     (1<<1)
 #define MROUTE_EXTRACT_MCAST     (1<<2)
 #define MROUTE_EXTRACT_IGMP      (1<<3)
+#define MROUTE_EXTRACT_NO_DROP   (1<<4)
 
 #define MROUTE_SEC_EXTRACT_SUCCEEDED (1<<(0+MROUTE_SEC_SHIFT))
 #define MROUTE_SEC_EXTRACT_BCAST     (1<<(1+MROUTE_SEC_SHIFT))
 #define MROUTE_SEC_EXTRACT_MCAST     (1<<(2+MROUTE_SEC_SHIFT))
 #define MROUTE_SEC_EXTRACT_IGMP      (1<<(3+MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_NO_DROP   (1<<(4+MROUTE_SEC_SHIFT))
 
-#define MROUTE_SEC_SHIFT         4
+#define MROUTE_SEC_SHIFT         5
 
 /*
  * Choose the largest address possible with
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 82a0b9d9..8b2afcd5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2627,7 +2627,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
             {
 #ifdef ENABLE_PF
                 struct mroute_addr edest;
-                mroute_addr_reset(&edest);
+                mroute_addr_reset (&edest);
+                unsigned int no_drop;
 #endif
                 /* extract packet source and dest addresses */
                 mroute_flags = mroute_extract_addr_from_packet(&src,
@@ -2676,10 +2677,20 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                             }
                         }
 #ifdef ENABLE_PF
-                        if (c->c2.to_tun.len && !pf_addr_test(c, &edest, "tap_dest_addr"))
+                        /*
+                         * If a packet is marked as "do not drop", then no PF
+                         * test has to be performed on it, but has to be allowed
+                         * right away.
+                         */
+                        no_drop = MROUTE_EXTRACT_NO_DROP | MROUTE_SEC_EXTRACT_NO_DROP;
+                        if ((mroute_flags & MROUTE_SEC_EXTRACT_SUCCEEDED) &&
+                            !(mroute_flags & no_drop) && c->c2.to_tun.len &&
+                            !pf_addr_test(c, &edest, "tap_dest_addr"))
                         {
-                            msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TAP packet filter",
-                                mroute_addr_print_ex(&edest, MAPF_SHOW_ARP, &gc));
+                            msg(D_PF_DROPPED,
+                                "PF: client -> addr[%s] packet dropped by TAP packet filter",
+                                mroute_addr_print_ex(&edest, MAPF_SHOW_ARP,
+                                                     &gc));
                             c->c2.to_tun.len = 0;
                         }
 #endif
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 57f25c90..48acc39e 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -120,6 +120,22 @@ struct openvpn_ipv6hdr {
     struct  in6_addr daddr;
 };
 
+/*
+ * ICMPv6 header
+ */
+struct openvpn_icmp6hdr {
+#define OPENVPN_ND_ROUTER_SOLICIT	133
+#define OPENVPN_ND_ROUTER_ADVERT	134
+#define OPENVPN_ND_NEIGHBOR_SOLICIT	135
+#define OPENVPN_ND_NEIGHBOR_ADVERT	136
+#define OPENVPN_ND_INVERSE_SOLICIT	141
+#define OPENVPN_ND_INVERSE_ADVERT	142
+    uint8_t		icmp6_type;
+
+    uint8_t		icmp6_code;
+    uint16_t	icmp6_cksum;
+    uint8_t		icmp6_dataun[4];
+};
 
 /*
  * UDP header
-- 
2.15.1


