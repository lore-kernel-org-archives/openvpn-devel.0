From: Arne Schwabe <arne@...1227...>
Date: Mon, 19 Nov 2012 19:12:17 +0100
Message-Id: <1353348737-21920-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Error message if max-routes used incorrectly
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

the route/route-ipv6/redirect-gateway options allocate the route structe with max_routes number of routes. A max-routes after any of this commands has no effect. This can be problematic (http://code.google.com/p/ics-openvpn/issues/detail?id=101)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9baa4ff..5f19c27 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5141,6 +5141,11 @@ add_option (struct options *options,
 	  msg (msglevel, "--max-routes parameter is out of range");
 	  goto err;
 	}
+      if (options->routes || options->routes_ipv6)
+	{
+		msg (msglevel, "--max-routes must to be specifed before any route/route-ipv6/redirect-gateway option");
+	  goto err;
+	}
       options->max_routes = max_routes;
     }
   else if (streq (p[0], "route-gateway") && p[1])
-- 
1.7.9.5


