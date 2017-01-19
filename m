From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Jan 2017 00:25:18 +0800
Message-Id: <20170119162518.31752-1-a@...2181...>
In-Reply-To: <20170119152156.5988-1-a@...2181...>
References: <20170119152156.5988-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2] fix redirect-gateway behaviour when an
	IPv4 default route does not exist
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

When no IPv4 default route exists, the "redirect-gateway" routine
aborts even if the sub-option "local" was specified or if we are
connecting to the remote host using IPv6.

This is not expected because in either case OpenVPN should not
bother checking the existence of the default route as it is not
required at all.

Therefore, skip the IPv4 default route check when "local" is
specified or we are connecting to an IPv6 remote host.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Actually, the fix required to consider the IPv6 case was not as big as
expected, therefore I included it in this v2.

Changes since v1:
- don't perform the default route check if remote host is IPv6
- on shutdown, don't try to re-add default route if it never existed
- move local var to narrower scope


This patch (v2) has been tested under following conditions:

Scenario 1: remove the default route and connect to an IPv4 VPN server
within the same network/LAN.

Observed behaviour when "redirect-gateway local" is specified:
- without the patch: no new default route over the VPN is added;
- with the patch: the new default route over the VPN is properly added.

Scenario 2: remove the default route and connect to an IPv6 VPN server.

Observed behaviour when "redirect-gateway" is specified:
- without the patch: no IPv4 default route over the VPN is added;
- with the patch: the IPv4 default route over the VPN is properly added.



Cheers,


 src/openvpn/route.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0c93dcd..e23f79a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -986,11 +986,19 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
 
     if (rl && rl->flags & RG_ENABLE)
     {
+        bool local = rl->flags & RG_LOCAL;
+
         if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) && (rl->flags & RG_REROUTE_GW))
         {
             msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing", err);
         }
-        else if (!(rl->rgi.flags & RGI_ADDR_DEFINED))
+        /*
+         * check if a default route is defined, unless:
+         * - we are connecting to a remote host in our network
+         * - we are connecting to a non-IPv4 remote host (i.e. we use IPv6)
+         */
+        else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local
+                 && (rl->spec.remote_host != IPV4_INVALID_ADDR))
         {
             msg(M_WARN, "%s Cannot read current default gateway from system", err);
         }
@@ -1001,7 +1009,6 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
         else
         {
 #ifndef TARGET_ANDROID
-            bool local = BOOL_CAST(rl->flags & RG_LOCAL);
             if (rl->flags & RG_AUTO_LOCAL)
             {
                 const int tla = rl->spec.remote_host_local;
@@ -1066,14 +1073,13 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
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
@@ -1145,15 +1151,12 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
                            flags,
                            &rl->rgi,
                            es);
-
-                /* restore original default route */
-                add_route3(0,
-                           0,
-                           rl->rgi.gateway.addr,
-                           tt,
-                           flags | ROUTE_REF_GW,
-                           &rl->rgi,
-                           es);
+                /* restore original default route if there was any */
+                if (rl->rgi.flags & RGI_ADDR_DEFINED)
+                {
+                    add_route3(0, 0, rl->rgi.gateway.addr, tt,
+                               flags | ROUTE_REF_GW, &rl->rgi, es);
+                }
             }
         }
 
-- 
2.11.0


