From: Antonio Quartulli <a@...2181...>
Date: Thu, 19 Jan 2017 23:21:56 +0800
Message-Id: <20170119152156.5988-1-a@...2181...>
In-Reply-To: <20170119134542.GI78624@...1296...>
References: <20170119134542.GI78624@...1296...>
Subject: [Openvpn-devel] [PATCH] fix redirect-gateway behaviour when "local"
	is specified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

When no IPv4 default route exists, the "redirect-gateway" routine aborts
even if the sub-option "local" was specified.

This is not expected because in this case OpenVPN should not bother
checking the existence of the default route at all (as specified
in the documentation).

Therefore, avoid the unsolicited abort by skipping the default
GW check when "local" is specified.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

This patch addresses the "*Flag as bug*" concern raised by Gert.


Tested by connecting to a VPN server in the same network/LAN and by
removing the default route.

Observed behaviour when "redirect-gateway local" is specified:
- without the patch: no new default route over the VPN is added;
- with the patch: the new default route over the VPN is properly added.


As Gert pointed out, the IPv6-endpoint case needs to be considered as
well while applying any routing-table-mangling logic.
However, such change will probably affect a larger portion of the code
and therefore it is worth its own patch.

Cheers,


 src/openvpn/route.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0c93dcd..e439fea 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -983,6 +983,7 @@ static void
 redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
 {
     const char err[] = "NOTE: unable to redirect default gateway --";
+    bool local = BOOL_CAST(rl->flags & RG_LOCAL);
 
     if (rl && rl->flags & RG_ENABLE)
     {
@@ -990,7 +991,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
         {
             msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing", err);
         }
-        else if (!(rl->rgi.flags & RGI_ADDR_DEFINED))
+        else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local)
         {
             msg(M_WARN, "%s Cannot read current default gateway from system", err);
         }
@@ -1001,7 +1002,6 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
         else
         {
 #ifndef TARGET_ANDROID
-            bool local = BOOL_CAST(rl->flags & RG_LOCAL);
             if (rl->flags & RG_AUTO_LOCAL)
             {
                 const int tla = rl->spec.remote_host_local;
@@ -1066,14 +1066,13 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                 }
                 else
                 {
-                    /* delete default route */
-                    del_route3(0,
-                               0,
-                               rl->rgi.gateway.addr,
-                               tt,
-                               flags | ROUTE_REF_GW,
-                               &rl->rgi,
-                               es);
+                    /* don't try to remove the def route if it does not exist */
+                    if (rl->rgi.flags & RGI_ADDR_DEFINED)
+                    {
+                        /* delete default route */
+                        del_route3(0, 0, rl->rgi.gateway.addr, tt,
+                                   flags | ROUTE_REF_GW, &rl->rgi, es);
+                    }
 
                     /* add new default route */
                     add_route3(0,
-- 
2.11.0


