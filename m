From: Antonio Quartulli <a@...2181...>
Date: Tue,  9 May 2017 23:24:22 +0800
Message-Id: <20170509152422.12606-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH release/2.3] fix redirect-gateway behaviour
	when an IPv4 default route does not exist
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

Backport of the same patch from 2.4 to 2.3.
Compiled tested only.

 src/openvpn/route.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 74f0a011..4ae0d6a4 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -840,11 +840,18 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 
   if ( rl && rl->flags & RG_ENABLE )
     {
+      bool local = BOOL_CAST(rl->flags & RG_LOCAL);
       if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) && (rl->flags & RG_REROUTE_GW))
 	{
 	  msg (M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing", err);
 	}
-      else if (!(rl->rgi.flags & RGI_ADDR_DEFINED))
+      /*
+       * check if a default route is defined, unless:
+       * - we are connecting to a remote host in our network
+       * - we are connecting to a non-IPv4 remote host (i.e. we use IPv6)
+       */
+      else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local
+	       && (rl->spec.remote_host != IPV4_INVALID_ADDR))
 	{
 	  msg (M_WARN, "%s Cannot read current default gateway from system", err);
 	}
@@ -854,7 +861,6 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 	}
       else
 	{
-	  bool local = BOOL_CAST(rl->flags & RG_LOCAL);
 	  if (rl->flags & RG_AUTO_LOCAL) {
 	    const int tla = rl->spec.remote_host_local;
 	    if (tla == TLA_NONLOCAL)
@@ -914,14 +920,18 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 		}
 	      else
 		{
-		  /* delete default route */
-		  del_route3 (0,
-			      0,
-			      rl->rgi.gateway.addr,
-			      tt,
-			      flags | ROUTE_REF_GW,
-			      &rl->rgi,
-			      es);
+		  /* don't try to remove the def route if it does not exist */
+		  if (rl->rgi.flags & RGI_ADDR_DEFINED)
+		  {
+		      /* delete default route */
+		      del_route3 (0,
+				  0,
+				  rl->rgi.gateway.addr,
+				  tt,
+				  flags | ROUTE_REF_GW,
+				  &rl->rgi,
+				  es);
+		  }
 
 		  /* add new default route */
 		  add_route3 (0,
@@ -994,14 +1004,18 @@ undo_redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *
 			  &rl->rgi,
 			  es);
 
-	      /* restore original default route */
-	      add_route3 (0,
-			  0,
-			  rl->rgi.gateway.addr,
-			  tt,
-			  flags | ROUTE_REF_GW,
-			  &rl->rgi,
-			  es);
+	      /* restore original default route if there was any */
+	      if (rl->rgi.flags & RGI_ADDR_DEFINED)
+	        {
+		  /* restore original default route */
+		  add_route3 (0,
+			      0,
+			      rl->rgi.gateway.addr,
+			      tt,
+			      flags | ROUTE_REF_GW,
+			      &rl->rgi,
+			      es);
+	        }
 	    }
 	}
 
-- 
2.12.2


