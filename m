MIME-Version: 1.0
Date: Fri, 24 Feb 2012 15:29:53 +0100
Message-ID: <CAAbSJMWS36mkdv0vswbRGOMdjLEe2rrQdmc3pCWDb5qwFo6t=Q@...278...>
From: Mickael Chazaux <mickael.chazaux@...277...>
Subject: [Openvpn-devel] [PATCH] Add gateway argument to Linux ip route del
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

In some use cases, it is valuable to have the gateway
passed when deleting a route. Even if is ignored by
iproute2, custom tools selected via the --iproute option
can make use of it.

Signed-off-by: Mickael Chazaux <mickael.chazaux@...277...>
---

 route.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/route.c b/route.c
index cf9a5ea..6fd44ca 100644
--- a/route.c
+++ b/route.c
@@ -1718,10 +1718,12 @@ delete_route (struct route *r,

 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s route del %s/%d",
+  argv_printf (&argv, "%s route del %s/%d via %s",
             iproute_path,
             network,
-             count_netmask_bits(netmask));
+             count_netmask_bits(netmask),
+             gateway
+       );
 #else
  argv_printf (&argv, "%s del -net %s netmask %s",
              ROUTE_PATH,
--
1.7.0.4

