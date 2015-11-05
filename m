From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 Nov 2015 23:17:01 +0100
Message-Id: <1446761821-14013-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (2.3)] Fix (potential) memory leak in
	init_route_list()
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

init_route() can allocate memory in netlist, but fail in many more ways
than just fail to allocate.  Thus, always check and clean up netlist if
needed, instead of just when init_route() succeeds.

This fix is for release/2.3 only.  The master branch uses a gc to clean
up the netlist, and needs a different patch for a similar problem.

Found using coverity.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/route.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bb998cb..a3d4b71 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -648,7 +648,7 @@ init_route_list (struct route_list *rl,
     bool warned = false;
     for (i = 0; i < opt->n; ++i)
       {
-        struct addrinfo* netlist;
+        struct addrinfo* netlist = NULL;
 	struct route_ipv4 r;
 
 	if (!init_route (&r,
@@ -675,8 +675,9 @@ init_route_list (struct route_list *rl,
 		      }
 		  }
 	      }
-            freeaddrinfo(netlist);
 	  }
+	if (netlist)
+	  freeaddrinfo(netlist);
       }
     rl->n = j;
   }
-- 
2.5.0


