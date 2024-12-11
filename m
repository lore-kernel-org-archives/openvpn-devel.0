From: Gert Doering <gert@...1296...>
Date: Wed, 11 Dec 2024 18:13:48 +0100
Message-ID: <20241211171349.8892-1-gert@...1296...>
In-Reply-To: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
References: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] forward: Fix potential unaligned access
 in drop_if_recursive_routing
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

From: Frank Lichtenheld <frank@...2641...>

ASAN error:
forward.c:1433:13: runtime error: member access within
misaligned address 0x51e00002f52e for type
'const struct in6_addr', which requires 4 byte alignment

v2: Use memcmp instead of memcpy

Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/827
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d50b24c..2c72001 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1390,8 +1390,6 @@
 
     if (proto_ver == 4)
     {
-        const struct openvpn_iphdr *pip;
-
         /* make sure we got whole IP header */
         if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offset))
         {
@@ -1404,18 +1402,16 @@
             return;
         }
 
-        pip = (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
+        struct openvpn_iphdr *pip = (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
 
         /* drop packets with same dest addr as gateway */
-        if (tun_sa.addr.in4.sin_addr.s_addr == pip->daddr)
+        if (memcmp(&tun_sa.addr.in4.sin_addr.s_addr, &pip->daddr, sizeof(pip->daddr)) == 0)
         {
             drop = true;
         }
     }
     else if (proto_ver == 6)
     {
-        const struct openvpn_ipv6hdr *pip6;
-
         /* make sure we got whole IPv6 header */
         if (BLEN(buf) < ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset))
         {
@@ -1428,9 +1424,10 @@
             return;
         }
 
+        struct openvpn_ipv6hdr *pip6 = (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);
+
         /* drop packets with same dest addr as gateway */
-        pip6 = (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);
-        if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
+        if (OPENVPN_IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
         {
             drop = true;
         }
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 7b94fbc..ac70134 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -83,6 +83,12 @@
 #define SIZE_ETH_TO_8021Q_HDR (sizeof(struct openvpn_8021qhdr) \
                                - sizeof(struct openvpn_ethhdr))
 
+/** Version of IN6_ARE_ADDR_EQUAL that is guaranteed to work for
+    unaligned access. E.g. Linux uses 32bit compares which are
+    not safe if the struct is unaligned. */
+#define OPENVPN_IN6_ARE_ADDR_EQUAL(a, b) \
+    (memcmp(a, b, sizeof(struct in6_addr)) == 0)
+
 struct openvpn_iphdr {
 #define OPENVPN_IPH_GET_VER(v) (((v) >> 4) & 0x0F)
 #define OPENVPN_IPH_GET_LEN(v) (((v) & 0x0F) << 2)

