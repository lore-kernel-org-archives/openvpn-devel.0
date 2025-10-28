From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 13:20:23 +0100
Message-ID: <20251028122028.24628-1-gert@...1296...>
In-Reply-To: <gerrit.1761570487000.I501bf780957a9c685eed5994a15de09c28efc3f0@...2715...>
References: <gerrit.1761570487000.I501bf780957a9c685eed5994a15de09c28efc3f0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] mroute: Remove unused mask argument of
 mroute_get_in*
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

These are obsolete since the removal of pf feature.
Avoids spurious conversion warnings.

Change-Id: I501bf780957a9c685eed5994a15de09c28efc3f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1309
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1309
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 88ea647..b50d48f 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -103,17 +103,12 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline void
-mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src, unsigned int mask)
+mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src)
 {
     if (ma)
     {
-        ma->type = MR_ADDR_IPV4 | mask;
+        ma->type = MR_ADDR_IPV4;
         ma->netbits = 0;
         ma->len = 4;
         ma->v4.addr = src;
@@ -121,11 +116,11 @@
 }
 
 static inline void
-mroute_get_in6_addr(struct mroute_addr *ma, const struct in6_addr src, unsigned int mask)
+mroute_get_in6_addr(struct mroute_addr *ma, const struct in6_addr src)
 {
     if (ma)
     {
-        ma->type = MR_ADDR_IPV6 | mask;
+        ma->type = MR_ADDR_IPV6;
         ma->netbits = 0;
         ma->len = 16;
         ma->v6.addr = src;
@@ -161,8 +156,8 @@
                 {
                     const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *)BPTR(buf);
 
-                    mroute_get_in_addr_t(src, ip->saddr, 0);
-                    mroute_get_in_addr_t(dest, ip->daddr, 0);
+                    mroute_get_in_addr_t(src, ip->saddr);
+                    mroute_get_in_addr_t(dest, ip->daddr);
 
                     /* multicast packet? */
                     if (mroute_is_mcast(ip->daddr))
@@ -192,8 +187,8 @@
                     gc_free(&gc);
 #endif
 
-                    mroute_get_in6_addr(src, ipv6->saddr, 0);
-                    mroute_get_in6_addr(dest, ipv6->daddr, 0);
+                    mroute_get_in6_addr(src, ipv6->saddr);
+                    mroute_get_in6_addr(dest, ipv6->daddr);
 
                     if (mroute_is_mcast_ipv6(ipv6->daddr))
                     {
@@ -342,7 +337,7 @@
             }
             else
             {
-                ma->v6.addr.s6_addr[byte--] &= (IPV4_NETMASK_HOST << bits_to_clear);
+                ma->v6.addr.s6_addr[byte--] &= (0xFF << bits_to_clear);
                 bits_to_clear = 0;
             }
         }
@@ -552,10 +547,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 mroute_helper_free(struct mroute_helper *mh)
 {

