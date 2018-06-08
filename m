From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Jun 2018 13:20:17 +0800
Message-Id: <20180608052017.6696-9-a@...2181...>
In-Reply-To: <20180608052017.6696-1-a@...2181...>
References: <20180608052017.6696-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 8/8] options: enable IPv4 redirection
 logic only if really required
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

If no IPv4 redirection flag is set, do not enable the IPv4
redireciton logic at all so that it won't bother adding any
useless IPv4 route.

At the same the warning message (for both IPv4 and IPv6) have
been modified by removing the tunnel interface name, as routes
being added might actually be going over other interfaces.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/options.c | 9 ++++++++-
 src/openvpn/route.c   | 8 ++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d9e4a3f..90dee4f2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6337,7 +6337,14 @@ add_option(struct options *options,
         /* we need this here to handle pushed --redirect-gateway */
         remap_redirect_gateway_flags(options);
 #endif
-        options->routes->flags |= RG_ENABLE;
+        /* enable IPv4 redirection logic only if at least one IPv4 flag is set.
+         * For instance, when "redirect-gateway !ipv4 ipv6" is specified no
+         * IPv4 redirection should be activated.
+         */
+        if (options->routes->flags)
+        {
+            options->routes->flags |= RG_ENABLE;
+        }
     }
     else if (streq(p[0], "remote-random-hostname") && !p[1])
     {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 64fd08c0..a9c2934f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1174,9 +1174,9 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
         if (rl->routes && !tt->did_ifconfig_setup)
         {
             msg(M_INFO, "WARNING: OpenVPN was configured to add an IPv4 "
-                "route over %s. However, no IPv4 has been configured for "
+                "route. However, no IPv4 has been configured for "
                 "this interface, therefore the route installation may "
-                "fail or may not work as expected.", tt->actual_name);
+                "fail or may not work as expected.");
         }
 
 #ifdef ENABLE_MANAGEMENT
@@ -1210,9 +1210,9 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
         if (!tt->did_ifconfig_ipv6_setup)
         {
             msg(M_INFO, "WARNING: OpenVPN was configured to add an IPv6 "
-                "route over %s. However, no IPv6 has been configured for "
+                "route. However, no IPv6 has been configured for "
                 "this interface, therefore the route installation may "
-                "fail or may not work as expected.", tt->actual_name);
+                "fail or may not work as expected.");
         }
 
         for (r = rl6->routes_ipv6; r; r = r->next)
-- 
2.17.1


