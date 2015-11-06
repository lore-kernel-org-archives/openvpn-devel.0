From: Steffan Karger <steffan@...1856...>
Date: Fri,  6 Nov 2015 08:42:39 +0100
Message-Id: <1446795759-3288-1-git-send-email-steffan@...1856...>
In-Reply-To: <1446761780-13816-1-git-send-email-steffan@...1856...>
References: <1446761780-13816-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (master,
	v2)] Fix (potential) memory leak in init_route_list()
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

This fix is for master only.  The release/2.3 branch cleans up netlist
immediately, and needs a different patch for a similar problem.

Found using coverity.

v2: initialize netlist to NULL

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/route.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 096e3bc..58b16c0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -634,7 +634,7 @@ init_route_list (struct route_list *rl,
     struct route_option *ro;
     for (ro = opt->routes; ro; ro = ro->next)
       {
-        struct addrinfo* netlist;
+        struct addrinfo* netlist = NULL;
 	struct route_ipv4 r;
 
 	if (!init_route (&r, &netlist, ro, rl))
@@ -642,7 +642,6 @@ init_route_list (struct route_list *rl,
 	else
 	  {
             struct addrinfo* curele;
-            gc_addspecial(netlist, &gc_freeaddrinfo_callback, &gc);
             for (curele	= netlist; curele; curele = curele->ai_next)
 	      {
                 struct route_ipv4 *new;
@@ -653,6 +652,8 @@ init_route_list (struct route_list *rl,
                 rl->routes = new;
 	      }
 	  }
+	if (netlist)
+	  gc_addspecial(netlist, &gc_freeaddrinfo_callback, &gc);
       }
   }
 
-- 
2.5.0


