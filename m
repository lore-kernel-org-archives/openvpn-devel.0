From: Gert Doering <gert@...1296...>
Date: Sun,  2 Aug 2015 15:24:30 +0200
Message-Id: <1438521870-17041-2-git-send-email-gert@...1296...>
In-Reply-To: <1438521870-17041-1-git-send-email-gert@...1296...>
References: <1438521870-17041-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/2] refactor struct route_ipv6_list,
	bring in line with struct route_list again
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

adjust "struct route_ipv6_list" (and all users) to reflect changes
to "struct route_list" done in commit 7fb0e07e, namely:

 - new member "rl6->iflags"            (RL_* flags)
 - new member "rl6->spec_flags"        (RTSA_* flags)
 - new member "rl6->remote_host_ipv6"  (--remote address we're talking to)
 - "rl6->routes_added"
              --> "rl6->iflags & RL_ROUTES_ADDED"
 - "rl6->did_redirect_default_gateway"
              --> "rl6->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY"
 - "rl6->did_local"
              --> "rl6->iflags & RL_DID_LOCAL"
 - "rl6->remote_endpoint_defined"
              --> "rl6->spec_flags & RTSA_REMOTE_ENDPOINT"
 - "rl6->default_metric_defined"
              --> "rl6->spec_flags & RTSA_DEFAULT_METRIC"

deviating from IPv4 route_list, there is no "route_special_addr spec"
sub-struct, because it's not considered useful (rl->spec.flags becomes
rl6->spec_flags, the IPv6 equivalent of everything else in rl->spec just
lives inside struct route_ipv6_list)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 19 ++++++++-----------
 src/openvpn/route.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0f91652..6b2af3c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -387,7 +387,7 @@ init_route_ipv6 (struct route_ipv6 *r6,
 	  msg( M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec '%s'", r6o->gateway );
         }
     }
-  else if (rl6->remote_endpoint_defined)
+  else if (rl6->spec_flags & RTSA_REMOTE_ENDPOINT)
     {
       r6->gateway = rl6->remote_endpoint_ipv6;
     }
@@ -412,7 +412,7 @@ init_route_ipv6 (struct route_ipv6 *r6,
 	}
       r6->flags |= RT_METRIC_DEFINED;
     }
-  else if (rl6->default_metric_defined)
+  else if (rl6->spec_flags & RTSA_DEFAULT_METRIC)
     {
       r6->metric = rl6->default_metric;
       r6->flags |= RT_METRIC_DEFINED;
@@ -671,7 +671,7 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
   if (default_metric >= 0 )
     {
       rl6->default_metric = default_metric;
-      rl6->default_metric_defined = true;
+      rl6->spec_flags |= RTSA_DEFAULT_METRIC;
     }
 
   /* "default_gateway" is stuff for "redirect-gateway", which we don't
@@ -686,7 +686,7 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
       if ( inet_pton( AF_INET6, remote_endpoint, 
 			&rl6->remote_endpoint_ipv6) == 1 )
         {
-	  rl6->remote_endpoint_defined = true;
+	  rl6->spec_flags |= RTSA_REMOTE_ENDPOINT;
         }
       else
 	{
@@ -694,9 +694,6 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
           ret = false;
 	}
     }
-  else
-    rl6->remote_endpoint_defined = false;
-
 
   /* parse the routes from opt6 to rl6 */
   {
@@ -1003,7 +1000,7 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
 	}
       rl->iflags |= RL_ROUTES_ADDED;
     }
-  if (rl6 && !rl6->routes_added)
+  if (rl6 && !(rl6->iflags & RL_ROUTES_ADDED) )
     {
       struct route_ipv6 *r;
       for (r = rl6->routes_ipv6; r; r = r->next)
@@ -1012,7 +1009,7 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
 	    delete_route_ipv6 (r, tt, flags, es);
 	  add_route_ipv6 (r, tt, flags, es);
 	}
-      rl6->routes_added = true;
+      rl6->iflags |= RL_ROUTES_ADDED;
     }
 }
 
@@ -1037,14 +1034,14 @@ delete_routes (struct route_list *rl, struct route_ipv6_list *rl6,
       clear_route_list (rl);
     }
 
-  if ( rl6 && rl6->routes_added )
+  if ( rl6 && (rl6->iflags & RL_ROUTES_ADDED) )
     {
       struct route_ipv6 *r6;
       for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
 	{
 	  delete_route_ipv6 (r6, tt, flags, es);
 	}
-      rl6->routes_added = false;
+      rl6->iflags &= ~RL_ROUTES_ADDED;
     }
 
   if ( rl6 )
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 13882a4..7e96a2f 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -103,7 +103,7 @@ struct route_ipv6_option {
 };
 
 struct route_ipv6_option_list {
-  unsigned int flags;
+  unsigned int flags;		/* RG_x flags, see route_option-list */
   struct route_ipv6_option *routes_ipv6;
   struct gc_arena *gc;
 };
@@ -131,14 +131,14 @@ struct route_ipv6 {
 };
 
 struct route_ipv6_list {
-  bool routes_added;
-  unsigned int flags;
+  unsigned int iflags;			/* RL_ flags, see route_list */
+
+  unsigned int spec_flags;		/* RTSA_ flags, route_special_addr */
+  struct in6_addr remote_endpoint_ipv6;	/* inside tun */
+  struct in6_addr remote_host_ipv6;	/* --remote address */
   int default_metric;
-  bool default_metric_defined;
-  struct in6_addr remote_endpoint_ipv6;
-  bool remote_endpoint_defined;
-  bool did_redirect_default_gateway;			/* TODO (?) */
-  bool did_local;					/* TODO (?) */
+
+  unsigned int flags;			/* RG_x flags, see route_option_list */
   struct route_ipv6 *routes_ipv6;
   struct gc_arena gc;
 };
-- 
2.3.6


