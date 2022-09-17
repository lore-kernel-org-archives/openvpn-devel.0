From: Antonio Quartulli <a@...2181...>
Date: Sat, 17 Sep 2022 23:31:54 +0200
Message-Id: <20220917213154.29285-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] is_ipv_X: improve packet consistency checks
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

This patch brings the following improvements:
* check that ETH proto and version in IP header are consistent;
* check that length of the packet is enough to store the expected IP
  header (it may be an IPv4 or an IPv6 header)
* restyle a bit to improve readability;
* remove spaces before ')' in invocations.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/proto.c | 91 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 88abd199..345df341 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -41,31 +41,40 @@
 static bool
 is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)
 {
+    uint16_t eth_ip_proto;
     int offset;
-    uint16_t proto;
-    const struct openvpn_iphdr *ih;
+
+    switch (ip_ver)
+    {
+        case 4:
+            eth_ip_proto = OPENVPN_ETH_P_IPV4;
+            break;
+
+        case 6:
+            eth_ip_proto = OPENVPN_ETH_P_IPV6;
+            break;
+
+        default:
+            /* invalid input provided */
+            return false;
+    }
 
     verify_align_4(buf);
     if (tunnel_type == DEV_TYPE_TUN)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
-        {
-            return false;
-        }
         offset = 0;
     }
     else if (tunnel_type == DEV_TYPE_TAP)
     {
-        const struct openvpn_ethhdr *eh;
-        if (BLEN(buf) < (sizeof(struct openvpn_ethhdr)
-                         + sizeof(struct openvpn_iphdr)))
+        if (BLEN(buf) < sizeof(struct openvpn_ethhdr))
         {
             return false;
         }
-        eh = (const struct openvpn_ethhdr *)BPTR(buf);
 
-        /* start by assuming this is a standard Eth fram */
-        proto = eh->proto;
+        /* start by assuming this is a standard Eth frame */
+        const struct openvpn_ethhdr *eh;
+        eh = (const struct openvpn_ethhdr *)BPTR(buf);
+        uint16_t proto = eh->proto;
         offset = sizeof(struct openvpn_ethhdr);
 
         /* if this is a 802.1q frame, parse the header using the according
@@ -74,19 +83,17 @@ is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)
         if (proto == htons(OPENVPN_ETH_P_8021Q))
         {
             const struct openvpn_8021qhdr *evh;
-            if (BLEN(buf) < (sizeof(struct openvpn_ethhdr)
-                             + sizeof(struct openvpn_iphdr)))
+            if (BLEN(buf) < sizeof(struct openvpn_8021qhdr))
             {
                 return false;
             }
 
             evh = (const struct openvpn_8021qhdr *)BPTR(buf);
-
             proto = evh->proto;
             offset = sizeof(struct openvpn_8021qhdr);
         }
 
-        if (ntohs(proto) != (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
+        if (ntohs(proto) != eth_ip_proto)
         {
             return false;
         }
@@ -96,28 +103,68 @@ is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)
         return false;
     }
 
-    ih = (const struct openvpn_iphdr *)(BPTR(buf) + offset);
+    /* ensure that there is enough room for a header of the expected version */
+    size_t ih_len = 0;
+    switch (eth_ip_proto)
+    {
+        case OPENVPN_ETH_P_IPV4:
+            ih_len = sizeof(struct openvpn_iphdr);
+            break;
+
+        case OPENVPN_ETH_P_IPV6:
+            ih_len = sizeof(struct openvpn_ipv6hdr);
+            break;
+    }
+    if (BLEN(buf) < (offset + ih_len))
+    {
+        return false;
+    }
 
     /* IP version is stored in the same bits for IPv4 or IPv6 header */
-    if (OPENVPN_IPH_GET_VER(ih->version_len) == ip_ver)
+    const struct openvpn_iphdr *ih;
+    ih = (const struct openvpn_iphdr *)(BPTR(buf) + offset);
+    uint8_t hdr_ip_ver = OPENVPN_IPH_GET_VER(ih->version_len);
+
+    if (tunnel_type == DEV_TYPE_TAP)
     {
-        return buf_advance(buf, offset);
+        /* ensure consistency between the version in the IP header and
+         * the Eth proto that was retrieved previously
+         */
+        switch (eth_ip_proto)
+        {
+            case OPENVPN_ETH_P_IPV4:
+                if (hdr_ip_ver != 4)
+                {
+                    return false;
+                }
+                break;
+
+            case OPENVPN_ETH_P_IPV6:
+                if (hdr_ip_ver != 6)
+                {
+                    return false;
+                }
+                break;
+        }
     }
-    else
+
+    if (hdr_ip_ver != ip_ver)
     {
         return false;
     }
+
+    return buf_advance(buf, offset);
 }
 
 bool
 is_ipv4(int tunnel_type, struct buffer *buf)
 {
-    return is_ipv_X( tunnel_type, buf, 4 );
+    return is_ipv_X(tunnel_type, buf, 4);
 }
 bool
 is_ipv6(int tunnel_type, struct buffer *buf)
 {
-    return is_ipv_X( tunnel_type, buf, 6 );
+    return is_ipv_X(tunnel_type, buf, 6);
 }
 
 
-- 
2.35.1


