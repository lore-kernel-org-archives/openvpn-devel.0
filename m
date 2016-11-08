From: Gert Doering <gert@...1296...>
Date: Tue,  8 Nov 2016 09:39:23 +0100
Message-Id: <1478594363-12752-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] check c->c2.link_socket before calling
	do_init_route_ipv6_list()
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

There was an asymmetry in checks before calling do_init_route*_list(),
checking c2.link_socket for IPv4 but not for IPv6 - mainly an oversight
from the time when do_init_route_ipv6_list() did not yet look at the
remote address to determine v6-over-v6 overlaps (2.3 code).

c2.link_socket should never be NULL here, so remove the "silently not
call stuff" condition and replace with ASSERT(c2.link_socket) so we
will notice if the assumption is ever wrong.

Tested in client UDP/TCP mode and server UDP/TCP/P2P and --inetd mode.

Found by Coverity.

While at it, remove "fatal" argument to do_init_route*_list(), which
was "false" in all cases (single invocation each), and remove the
error exit code related to it.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3ec3b18..91c53f5 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1157,7 +1157,6 @@ static void
 do_init_route_list (const struct options *options,
 		    struct route_list *route_list,
 		    const struct link_socket_info *link_socket_info,
-		    bool fatal,
 		    struct env_set *es)
 {
   const char *gw = NULL;
@@ -1171,18 +1170,13 @@ do_init_route_list (const struct options *options,
   if (options->route_default_metric)
     metric = options->route_default_metric;
 
-  if (!init_route_list (route_list,
+  if (init_route_list (route_list,
 			options->routes,
 			gw,
 			metric,
 			link_socket_current_remote (link_socket_info),
 			es))
     {
-      if (fatal)
-	openvpn_exit (OPENVPN_EXIT_STATUS_ERROR);	/* exit point */
-    }
-  else
-    {
       /* copy routes to environment */
       setenv_routes (es, route_list);
     }
@@ -1192,7 +1186,6 @@ static void
 do_init_route_ipv6_list (const struct options *options,
 		    struct route_ipv6_list *route_ipv6_list,
 		    const struct link_socket_info *link_socket_info,
-		    bool fatal,
 		    struct env_set *es)
 {
   const char *gw = NULL;
@@ -1222,18 +1215,13 @@ do_init_route_ipv6_list (const struct options *options,
 	}
     }
 
-  if (!init_route_ipv6_list (route_ipv6_list,
+  if (init_route_ipv6_list (route_ipv6_list,
 			options->routes_ipv6,
 			gw,
 			metric,
 			link_socket_current_remote_ipv6 (link_socket_info),
 			es))
     {
-      if (fatal)
-	openvpn_exit (OPENVPN_EXIT_STATUS_ERROR);	/* exit point */
-    }
-  else
-    {
       /* copy routes to environment */
       setenv_routes_ipv6 (es, route_ipv6_list);
     }
@@ -1443,10 +1431,13 @@ do_open_tun (struct context *c)
       do_alloc_route_list (c);
 
       /* parse and resolve the route option list */
-      if (c->options.routes && c->c1.route_list && c->c2.link_socket)
-	do_init_route_list (&c->options, c->c1.route_list, &c->c2.link_socket->info, false, c->c2.es);
-      if (c->options.routes_ipv6 && c->c1.route_ipv6_list )
-	do_init_route_ipv6_list (&c->options, c->c1.route_ipv6_list, &c->c2.link_socket->info, false, c->c2.es);
+      ASSERT(c->c2.link_socket);
+      if (c->options.routes && c->c1.route_list)
+	do_init_route_list (&c->options, c->c1.route_list,
+			    &c->c2.link_socket->info, c->c2.es);
+      if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
+	do_init_route_ipv6_list (&c->options, c->c1.route_ipv6_list,
+				 &c->c2.link_socket->info, c->c2.es);
 
       /* do ifconfig */
       if (!c->options.ifconfig_noexec
-- 
2.7.3


