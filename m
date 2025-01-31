From: Gert Doering <gert@...1296...>
Date: Fri, 31 Jan 2025 09:47:07 +0100
Message-ID: <20250131084707.24905-1-gert@...1296...>
In-Reply-To: <gerrit.1738260795000.I6f17140109106b37e6b0e690df1d87720ccf6f91@...2715...>
References: <gerrit.1738260795000.I6f17140109106b37e6b0e690df1d87720ccf6f91@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] get_default_gateway(): implement
 platform support for Linux/IPROUTE2
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

Remove the old "read /proc/net/route and try to parse it" implementation
and always use the sitnl/netlink implementation of net_route_v4_best_gw().

This was kept "because we had it and it was working" but does not really
provide any benefit - netlink for route queries is there for v6 anyway,
and the main argument for keeping --enable-iproute2 is "some users want
to run non-standard 'ip' binaries to do things" - which is not affected
by this change.

Change-Id: I6f17140109106b37e6b0e690df1d87720ccf6f91
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/884
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 975282c..6f13ef5 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -394,63 +394,15 @@
     return ret;
 }
 
-int
-net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
-                     in_addr_t *best_gw, char *best_iface)
-{
-    best_iface[0] = '\0';
-
-    FILE *fp = fopen("/proc/net/route", "r");
-    if (!fp)
-    {
-        return -1;
-    }
-
-    char line[256];
-    int count = 0;
-    unsigned int lowest_metric = UINT_MAX;
-    while (fgets(line, sizeof(line), fp) != NULL)
-    {
-        if (count)
-        {
-            unsigned int net_x = 0;
-            unsigned int mask_x = 0;
-            unsigned int gw_x = 0;
-            unsigned int metric = 0;
-            unsigned int flags = 0;
-            char name[16];
-            name[0] = '\0';
-
-            const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
-                                  name, &net_x, &gw_x, &flags, &metric,
-                                  &mask_x);
-
-            if (np == 6 && (flags & IFF_UP))
-            {
-                const in_addr_t net = ntohl(net_x);
-                const in_addr_t mask = ntohl(mask_x);
-                const in_addr_t gw = ntohl(gw_x);
-
-                if (!net && !mask && metric < lowest_metric)
-                {
-                    *best_gw = gw;
-                    strcpy(best_iface, name);
-                    lowest_metric = metric;
-                }
-            }
-        }
-        ++count;
-    }
-    fclose(fp);
-
-    return 0;
-}
-
 /*
- * The following function is not implemented in the iproute backend as it
+ * The following functions are not implemented in the iproute backend as it
  * uses the sitnl implementation from networking_sitnl.c.
  *
  * int
+ * net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
+ *                     in_addr_t *best_gw, char *best_iface)
+ *
+ * int
  * net_route_v6_best_gw(const struct in6_addr *dst,
  *                      struct in6_addr *best_gw, char *best_iface)
  */
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 6b750e8..9de8912 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -619,8 +619,7 @@
 
 }
 
-#ifdef ENABLE_SITNL
-
+/* used by iproute2 implementation too */
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
                      in_addr_t *best_gw, char *best_iface)
@@ -652,6 +651,8 @@
     return ret;
 }
 
+#ifdef ENABLE_SITNL
+
 int
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {

