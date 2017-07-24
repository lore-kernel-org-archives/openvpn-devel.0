From: Antonio Quartulli <a@...2181...>
Date: Mon, 24 Jul 2017 22:35:59 +0800
Message-Id: <20170724143559.11503-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] rename mroute_extract_addr_ipv4 to
 mroute_extract_addr_ip
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

mroute_extract_addr_ipv4() is able to extract an IPv4 as well as an
IPv6. Remove the "v4" suffix from its name to make this behaviour more
explicit.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/mroute.c | 7 +++----
 src/openvpn/mroute.h | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 7b46a6a2..74ee360c 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -159,9 +159,8 @@ mroute_extract_addr_arp(struct mroute_addr *src,
 #endif /* ifdef ENABLE_PF */
 
 unsigned int
-mroute_extract_addr_ipv4(struct mroute_addr *src,
-                         struct mroute_addr *dest,
-                         const struct buffer *buf)
+mroute_extract_addr_ip(struct mroute_addr *src, struct mroute_addr *dest,
+                       const struct buffer *buf)
 {
     unsigned int ret = 0;
     if (BLEN(buf) >= 1)
@@ -267,7 +266,7 @@ mroute_extract_addr_ether(struct mroute_addr *src,
                 switch (ntohs(eth->proto))
                 {
                     case OPENVPN_ETH_P_IPV4:
-                        ret |= (mroute_extract_addr_ipv4(esrc, edest, &b) << MROUTE_SEC_SHIFT);
+                        ret |= (mroute_extract_addr_ip(esrc, edest, &b) << MROUTE_SEC_SHIFT);
                         break;
 
                     case OPENVPN_ETH_P_ARP:
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index e57a9506..35361fbd 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -181,9 +181,9 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
                                 const struct buffer *buf,
                                 int tunnel_type)
 {
-    unsigned int mroute_extract_addr_ipv4(struct mroute_addr *src,
-                                          struct mroute_addr *dest,
-                                          const struct buffer *buf);
+    unsigned int mroute_extract_addr_ip(struct mroute_addr *src,
+                                     struct mroute_addr *dest,
+                                     const struct buffer *buf);
 
     unsigned int mroute_extract_addr_ether(struct mroute_addr *src,
                                            struct mroute_addr *dest,
@@ -195,7 +195,7 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
     verify_align_4(buf);
     if (tunnel_type == DEV_TYPE_TUN)
     {
-        ret = mroute_extract_addr_ipv4(src, dest, buf);
+        ret = mroute_extract_addr_ip(src, dest, buf);
     }
     else if (tunnel_type == DEV_TYPE_TAP)
     {
-- 
2.13.3


