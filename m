From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Jun 2018 13:20:16 +0800
Message-Id: <20180608052017.6696-8-a@...2181...>
In-Reply-To: <20180608052017.6696-1-a@...2181...>
References: <20180608052017.6696-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 7/8] route: warn on IPv4 routes
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

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/route.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8990a986..64fd08c0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -981,7 +981,7 @@ del_bypass_routes(struct route_bypass *rb,
 static void
 redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
 {
-    const char err[] = "NOTE: unable to redirect default gateway --";
+    const char err[] = "NOTE: unable to redirect IPv4 default gateway --";
 
     if (rl && rl->flags & RG_ENABLE)
     {
@@ -1171,6 +1171,14 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
     {
         struct route_ipv4 *r;
 
+        if (rl->routes && !tt->did_ifconfig_setup)
+        {
+            msg(M_INFO, "WARNING: OpenVPN was configured to add an IPv4 "
+                "route over %s. However, no IPv4 has been configured for "
+                "this interface, therefore the route installation may "
+                "fail or may not work as expected.", tt->actual_name);
+        }
+
 #ifdef ENABLE_MANAGEMENT
         if (management && rl->routes)
         {
-- 
2.17.1


