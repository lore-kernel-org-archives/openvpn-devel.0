From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:46 +0200
Message-Id: <1441985627-14822-10-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 09/10] Fix IPv6 host routes to LAN gateway
	on OpenSolaris
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

The tun/tap routes need to be set with "metric 0", while this will
prevent routes to LAN gateways from being installed.  So, set metric 0
only if no other interface is requested...

(Note: OpenSolaris can not specify host+interface gateways, so we just
use the GW addresses - it seems to still work for fe80:: addresses,
however it is done internally.  NUD maybe?)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 29dd3fa..d97968c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1800,12 +1800,17 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
    * packets will just disappear somewhere.  So we use "0" now...
    */
 
-  argv_printf (&argv, "%s add -inet6 %s/%d %s 0",
+  argv_printf (&argv, "%s add -inet6 %s/%d %s",
 		ROUTE_PATH,
 		network,
 		r6->netbits,
 		gateway );
 
+  /* only append 0 for "tun/tap" routes, not for "gateway on other interface"
+   */
+  if ( !r6->iface )
+     argv_printf_cat (&argv, "0");
+
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Solaris route add -inet6 command failed");
 
-- 
2.3.6


