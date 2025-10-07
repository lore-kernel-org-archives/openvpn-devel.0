From: Gert Doering <gert@...1296...>
Date: Tue,  7 Oct 2025 18:08:18 +0200
Message-ID: <20251007160826.4614-1-gert@...1296...>
In-Reply-To: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Allow route_ipv6_match_host to be used
 outside of route.c
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

From: Arne Schwabe <arne@...1227...>

Also adjust style a bit to C99

Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1191
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1191
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 05a0c8f..0044794 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -710,25 +710,20 @@
     return ret;
 }
 
-/* check whether an IPv6 host address is covered by a given route_ipv6
- * (not the most beautiful implementation in the world, but portable and
- * "good enough")
- */
-static bool
-route_ipv6_match_host(const struct route_ipv6 *r6, const struct in6_addr *host)
+bool
+ipv6_net_contains_host(const struct in6_addr *network, unsigned int bits, const struct in6_addr *host)
 {
-    unsigned int bits = r6->netbits;
-    int i;
-    unsigned int mask;
-
+    /* not the most beautiful implementation in the world, but portable and
+     * "good enough" */
     if (bits > 128)
     {
         return false;
     }
 
+    int i;
     for (i = 0; bits >= 8; i++, bits -= 8)
     {
-        if (r6->network.s6_addr[i] != host->s6_addr[i])
+        if (network->s6_addr[i] != host->s6_addr[i])
         {
             return false;
         }
@@ -739,9 +734,9 @@
         return true;
     }
 
-    mask = 0xff << (8 - bits);
+    unsigned int mask = 0xff << (8 - bits);
 
-    if ((r6->network.s6_addr[i] & mask) == (host->s6_addr[i] & mask))
+    if ((network->s6_addr[i] & mask) == (host->s6_addr[i] & mask))
     {
         return true;
     }
@@ -830,7 +825,8 @@
                  * avoiding routing loops, so ignore this part and let
                  * need_remote_ipv6_route always evaluate to false
                  */
-                if (remote_host_ipv6 && route_ipv6_match_host(r6, remote_host_ipv6))
+                if (remote_host_ipv6
+                    && ipv6_net_contains_host(&r6->network, r6->netbits, remote_host_ipv6))
                 {
                     need_remote_ipv6_route = true;
                     msg(D_ROUTE,
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index c5006ae..54fa137 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -426,4 +426,17 @@
     return rl && BOOL_CAST(rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY);
 }
 
+
+/**
+ * check whether an IPv6 host address is covered by a given network/bits
+ * @param network the network address
+ * @param bits the network mask
+ * @param host the host address to be checked if it is contained by the network
+ *
+ * @return true if the host address is covered by the network with the given
+ *         network mask by bits
+ */
+bool
+ipv6_net_contains_host(const struct in6_addr *network, unsigned int bits, const struct in6_addr *host);
+
 #endif /* ifndef ROUTE_H */

