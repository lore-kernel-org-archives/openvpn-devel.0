From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:18 +0200
Message-Id: <20191009143422.9419-6-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/9] is_ipv_X: add support for parsing IP
 header inside a 802.1q frame
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

Extend is_ipv_X() routine by properly parsing 802.1q frame rather than
dropping them.

This change is required in order to allow OpenVPN to accept VLAN tagged
frames, which otherwise would be dropped when trying to access the inner
IP header.

While at it, slightly fix the function style.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/proto.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 3bf22174..6f4d9294 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -38,17 +38,17 @@
  * If raw tunnel packet is IPv<X>, return true and increment
  * buffer offset to start of IP header.
  */
-static
-bool
-is_ipv_X( int tunnel_type, struct buffer *buf, int ip_ver )
+static bool
+is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)
 {
     int offset;
+    uint16_t proto;
     const struct openvpn_iphdr *ih;
 
     verify_align_4(buf);
     if (tunnel_type == DEV_TYPE_TUN)
     {
-        if (BLEN(buf) < (int) sizeof(struct openvpn_iphdr))
+        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
         {
             return false;
         }
@@ -57,24 +57,46 @@ is_ipv_X( int tunnel_type, struct buffer *buf, int ip_ver )
     else if (tunnel_type == DEV_TYPE_TAP)
     {
         const struct openvpn_ethhdr *eh;
-        if (BLEN(buf) < (int)(sizeof(struct openvpn_ethhdr)
-                              + sizeof(struct openvpn_iphdr)))
+        if (BLEN(buf) < (sizeof(struct openvpn_ethhdr)
+                         + sizeof(struct openvpn_iphdr)))
         {
             return false;
         }
-        eh = (const struct openvpn_ethhdr *) BPTR(buf);
-        if (ntohs(eh->proto) != (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
+        eh = (const struct openvpn_ethhdr *)BPTR(buf);
+
+        /* start by assuming this is a standard Eth fram */
+        proto = eh->proto;
+        offset = sizeof(struct openvpn_ethhdr);
+
+        /* if this is a 802.1q frame, parse the header using the according
+         * format
+         */
+        if (proto == htons(OPENVPN_ETH_P_8021Q))
+        {
+            const struct openvpn_8021qhdr *evh;
+            if (BLEN(buf) < (sizeof(struct openvpn_ethhdr)
+                             + sizeof(struct openvpn_iphdr)))
+            {
+                return false;
+            }
+
+            evh = (const struct openvpn_8021qhdr *)BPTR(buf);
+
+            proto = evh->proto;
+            offset = sizeof(struct openvpn_8021qhdr);
+        }
+
+        if (ntohs(proto) != (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
         {
             return false;
         }
-        offset = sizeof(struct openvpn_ethhdr);
     }
     else
     {
         return false;
     }
 
-    ih = (const struct openvpn_iphdr *) (BPTR(buf) + offset);
+    ih = (const struct openvpn_iphdr *)(BPTR(buf) + offset);
 
     /* IP version is stored in the same bits for IPv4 or IPv6 header */
     if (OPENVPN_IPH_GET_VER(ih->version_len) == ip_ver)
-- 
2.23.0


