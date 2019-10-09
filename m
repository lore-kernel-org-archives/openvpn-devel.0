From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:16 +0200
Message-Id: <20191009143422.9419-4-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/9] maddr: export VLAN ID from client
 context to maddr object
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

When receiving a packet from a client, the associated maddr needs to
carry also the VID associated with that client. This way the VID can be
appended to the packet later, if needed.

This patch adds support for exporting the VID from the client context to
the related per-packet maddr object.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/mroute.c | 54 +++++++++++++++++++++++++++++++-------------
 src/openvpn/mroute.h | 11 ++++++---
 src/openvpn/multi.c  |  3 +++
 3 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index c52ef7b1..bdb1b0c0 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -58,7 +58,7 @@ static inline bool
 is_mac_mcast_maddr(const struct mroute_addr *addr)
 {
     return (addr->type & MR_ADDR_MASK) == MR_ADDR_ETHER
-           && is_mac_mcast_addr(addr->eth_addr);
+           && is_mac_mcast_addr(addr->ether.addr);
 }
 
 /*
@@ -249,12 +249,15 @@ mroute_extract_addr_ip(struct mroute_addr *src, struct mroute_addr *dest,
 
 static void
 mroute_copy_ether_to_addr(struct mroute_addr *maddr,
-                          const uint8_t *ether_addr)
+                          const uint8_t *ether_addr,
+                          uint16_t vid)
 {
     maddr->type = MR_ADDR_ETHER;
     maddr->netbits = 0;
     maddr->len = OPENVPN_ETH_ALEN;
-    memcpy(maddr->eth_addr, ether_addr, OPENVPN_ETH_ALEN);
+    memcpy(maddr->ether.addr, ether_addr, OPENVPN_ETH_ALEN);
+    maddr->len += sizeof(vid);
+    maddr->ether.vid = vid;
 }
 
 unsigned int
@@ -262,6 +265,7 @@ mroute_extract_addr_ether(struct mroute_addr *src,
                           struct mroute_addr *dest,
                           struct mroute_addr *esrc,
                           struct mroute_addr *edest,
+                          uint16_t vid,
                           const struct buffer *buf)
 {
     unsigned int ret = 0;
@@ -270,11 +274,11 @@ mroute_extract_addr_ether(struct mroute_addr *src,
         const struct openvpn_ethhdr *eth = (const struct openvpn_ethhdr *) BPTR(buf);
         if (src)
         {
-            mroute_copy_ether_to_addr(src, eth->source);
+            mroute_copy_ether_to_addr(src, eth->source, vid);
         }
         if (dest)
         {
-            mroute_copy_ether_to_addr(dest, eth->dest);
+            mroute_copy_ether_to_addr(dest, eth->dest, vid);
 
             /* ethernet broadcast/multicast packet? */
             if (is_mac_mcast_addr(eth->dest))
@@ -289,18 +293,35 @@ mroute_extract_addr_ether(struct mroute_addr *src,
         if (esrc || edest)
         {
             struct buffer b = *buf;
-            if (buf_advance(&b, sizeof(struct openvpn_ethhdr)))
+            if (!buf_advance(&b, sizeof(struct openvpn_ethhdr)))
             {
-                switch (ntohs(eth->proto))
-                {
-                    case OPENVPN_ETH_P_IPV4:
-                        ret |= (mroute_extract_addr_ip(esrc, edest, &b) << MROUTE_SEC_SHIFT);
-                        break;
+                return 0;
+            }
 
-                    case OPENVPN_ETH_P_ARP:
-                        ret |= (mroute_extract_addr_arp(esrc, edest, &b) << MROUTE_SEC_SHIFT);
-                        break;
+            uint16_t proto = eth->proto;
+            if (proto == htons(OPENVPN_ETH_P_8021Q))
+            {
+                if (!buf_advance(&b, SIZE_ETH_TO_8021Q_HDR))
+                {
+                    /* It's an 802.1Q packet, but doesn't have a full header,
+                     * so something went wrong */
+                    return 0;
                 }
+
+                const struct openvpn_8021qhdr *tag;
+                tag = (const struct openvpn_8021qhdr *)BPTR(buf);
+                proto = tag->proto;
+            }
+
+            switch (ntohs(proto))
+            {
+                case OPENVPN_ETH_P_IPV4:
+                    ret |= (mroute_extract_addr_ip(esrc, edest, &b) << MROUTE_SEC_SHIFT);
+                    break;
+
+                case OPENVPN_ETH_P_ARP:
+                    ret |= (mroute_extract_addr_arp(esrc, edest, &b) << MROUTE_SEC_SHIFT);
+                    break;
             }
         }
 #endif
@@ -444,8 +465,9 @@ mroute_addr_print_ex(const struct mroute_addr *ma,
         switch (maddr.type & MR_ADDR_MASK)
         {
             case MR_ADDR_ETHER:
-                buf_printf(&out, "%s", format_hex_ex(ma->eth_addr,
-                                                     sizeof(ma->eth_addr), 0, 1, ":", gc));
+                buf_printf(&out, "%s", format_hex_ex(ma->ether.addr,
+                                                     sizeof(ma->ether.addr), 0, 1, ":", gc));
+                buf_printf(&out, "@%hu", ma->ether.vid);
                 break;
 
             case MR_ADDR_IPV4:
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 7fcd9956..113aa8c5 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -82,7 +82,10 @@ struct mroute_addr {
                       * valid if MR_WITH_NETBITS is set */
     union {
         uint8_t raw_addr[MR_MAX_ADDR_LEN]; /* actual address */
-        uint8_t eth_addr[OPENVPN_ETH_ALEN];
+        struct {
+            uint8_t addr[OPENVPN_ETH_ALEN];
+            uint16_t vid;
+        } ether;
         struct {
             in_addr_t addr;     /* _network order_ IPv4 address */
             in_port_t port;     /* _network order_ TCP/UDP port */
@@ -100,7 +103,7 @@ struct mroute_addr {
 /* Wrappers to support compilers that do not grok anonymous unions */
         mroute_union
 #define raw_addr mroute_union.raw_addr
-#define eth_addr mroute_union.eth_addr
+#define ether mroute_union.ether
 #define v4 mroute_union.v4
 #define v6 mroute_union.v6
 #define v4mappedv6 mroute_union.v4mappedv6
@@ -178,6 +181,7 @@ unsigned int mroute_extract_addr_ether(struct mroute_addr *src,
                                        struct mroute_addr *dest,
                                        struct mroute_addr *esrc,
                                        struct mroute_addr *edest,
+                                       uint16_t vid,
                                        const struct buffer *buf);
 
 /*
@@ -189,6 +193,7 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
                                 struct mroute_addr *dest,
                                 struct mroute_addr *esrc,
                                 struct mroute_addr *edest,
+                                uint16_t vid,
                                 const struct buffer *buf,
                                 int tunnel_type)
 {
@@ -200,7 +205,7 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
     }
     else if (tunnel_type == DEV_TYPE_TAP)
     {
-        ret = mroute_extract_addr_ether(src, dest, esrc, edest, buf);
+        ret = mroute_extract_addr_ether(src, dest, esrc, edest, vid, buf);
     }
     return ret;
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8caaa868..95b33e7a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2570,6 +2570,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                                                                &dest,
                                                                NULL,
                                                                NULL,
+                                                               0,
                                                                &c->c2.to_tun,
                                                                DEV_TYPE_TUN);
 
@@ -2664,6 +2665,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
 #else
                                                                NULL,
 #endif
+                                                               0,
                                                                &c->c2.to_tun,
                                                                DEV_TYPE_TAP);
 
@@ -2791,6 +2793,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
                                                        NULL,
 #endif
                                                        NULL,
+                                                       0,
                                                        &m->top.c2.buf,
                                                        dev_type);
 
-- 
2.23.0


