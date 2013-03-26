From: Gert Doering <gert@...1296...>
Date: Tue, 26 Mar 2013 17:09:35 +0100
Message-Id: <1364314175-20758-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix directly connected routes for "topology
	subnet" on Solaris.
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

This basically brings back the previously-working metric setting for
directly connected routes (add a "0" to the "route add" command) on
Solaris/OpenSolaris.  It was working in f0eac1a59790, and got broken
by the route.c/route.h refactoring in 576dc96ca1ef1 - the patch
un-does that change to the TARGET_SOLARIS code, plus adds some more
descriptive comments.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 134ed58..d848db6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1397,17 +1397,20 @@ add_route (struct route *r,
   argv_printf (&argv, "%s add",
 		ROUTE_PATH);
 
-#if 0
-  if (r->flags & RT_METRIC_DEFINED)
-    argv_printf_cat (&argv, "-rtt %d", r->metric);
-#endif
-
   argv_printf_cat (&argv, "%s -netmask %s %s",
 	      network,
 	      netmask,
 	      gateway);
 
-  /* FIXME -- add on-link support for Solaris */
+  /* Solaris can only distinguish between "metric 0" == "on-link on the
+   * interface where the IP address given is configured" and "metric > 0" 
+   * == "use gateway specified" (no finer-grained route metrics available)
+   * 
+   * More recent versions of Solaris can also do "-interface", but that 
+   * would break backwards compatibility with older versions for no gain.
+   */
+  if (r->flags & RT_METRIC_DEFINED )
+    argv_printf_cat (&argv, "%d", r->metric);
 
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Solaris route add command failed");
-- 
1.5.6.5


