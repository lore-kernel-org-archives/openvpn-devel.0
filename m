From: Antonio Quartulli <a@...2181...>
Date: Sat, 30 May 2020 02:05:58 +0200
Message-Id: <20200530000600.1680-6-a@...2181...>
In-Reply-To: <20200530000600.1680-1-a@...2181...>
References: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 5/7] route: warn on IPv4 routes
 installation when no IPv4 is configured
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Same as already happens for IPv6, it is useful for the user to throw a
warning when an IPv4 route is about to be installed and the tun interface
has no IPv4 configured.

The twin message for IPv4 is adapted to have the same format.

The warning is not fatal, becuase the route might actually be external
to the tun interface and therefore it may still work.

At the same time, modify the error message used for a route
installation failure to explicitly mention "IPv4" since this it is
used in the IPv4 code path only.

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>

---
Changes from v4:
- edit commit message
- modify IPv4 warning as well (moved from next patch)

Changes from v3:
- patchset rebased on top of pre-ipv6-only patchset


 src/openvpn/route.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 51f76318..9ff36359 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -987,7 +987,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                               unsigned int flags, const struct env_set *es,
                               openvpn_net_ctx_t *ctx)
 {
-    const char err[] = "NOTE: unable to redirect default gateway --";
+    const char err[] = "NOTE: unable to redirect IPv4 default gateway --";
 
     if (rl && rl->flags & RG_ENABLE)
     {
@@ -1192,6 +1192,14 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
     {
         struct route_ipv4 *r;
 
+        if (rl->routes && !tt->did_ifconfig_setup)
+        {
+            msg(M_INFO, "WARNING: OpenVPN was configured to add an IPv4 "
+                "route. However, no IPv4 has been configured for %s, "
+                "therefore the route installation may fail or may not work "
+                "as expected.", tt->actual_name);
+        }
+
 #ifdef ENABLE_MANAGEMENT
         if (management && rl->routes)
         {
@@ -1223,9 +1231,9 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
         if (!tt->did_ifconfig_ipv6_setup)
         {
             msg(M_INFO, "WARNING: OpenVPN was configured to add an IPv6 "
-                "route over %s. However, no IPv6 has been configured for "
-                "this interface, therefore the route installation may "
-                "fail or may not work as expected.", tt->actual_name);
+                "route. However, no IPv6 has been configured for %s, "
+                "therefore the route installation may fail or may not work "
+                "as expected.", tt->actual_name);
         }
 
         for (r = rl6->routes_ipv6; r; r = r->next)
-- 
2.26.2


