From: Gert Doering <gert@...1296...>
Date: Sun, 10 Jun 2012 17:41:27 +0200
Message-Id: <1339342891-28443-2-git-send-email-gert@...1296...>
In-Reply-To: <1339342891-28443-1-git-send-email-gert@...1296...>
References: <1339342891-28443-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 1/5] cleanup and redefine metric handling
	for IPv6 routes
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

"no metric set" is now stored as "-1"
"metric 0" means "on-link route" (what the BSDs do)
properly initialize metric value to "0" for on-link IPv6 net on BSDs

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c  |    2 +-
 src/openvpn/route.c |    9 ++++-----
 src/openvpn/tun.c   |    4 ++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 61ced5d..b726b93 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1251,7 +1251,7 @@ do_init_route_ipv6_list (const struct options *options,
 {
   const char *gw = NULL;
   int dev = dev_type_enum (options->dev, options->dev_type);
-  int metric = 0;
+  int metric = -1;		/* no metric set */
 
   if (dev != DEV_TYPE_TUN )
     msg( M_WARN, "IPv6 routes on TAP devices are going to fail on some platforms (need gateway spec)" );	/* TODO-GERT */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7c25c77..aadbacc 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -383,7 +383,6 @@ init_route_ipv6 (struct route_ipv6 *r6,
 	         const struct route_ipv6_option *r6o,
 	         const struct route_ipv6_list *rl6 )
 {
-  r6->option = r6o;
   r6->defined = false;
 
   if ( !get_ipv6_addr( r6o->prefix, &r6->network, &r6->netbits, NULL, M_WARN ))
@@ -410,7 +409,7 @@ init_route_ipv6 (struct route_ipv6 *r6,
   /* metric */
 
   r6->metric_defined = false;
-  r6->metric = 0;
+  r6->metric = -1;
   if (is_route_parm_defined (r6o->metric))
     {
       r6->metric = atoi (r6o->metric);
@@ -700,7 +699,7 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
 
   rl6->flags = opt6->flags;
 
-  if (default_metric)
+  if (default_metric >= 0 )
     {
       rl6->default_metric = default_metric;
       rl6->default_metric_defined = true;
@@ -1582,7 +1581,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      network,
 	      r6->netbits,
 	      device);
-  if (r6->metric_defined)
+  if (r6->metric_defined && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 
 #else
@@ -1591,7 +1590,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      network,
 	      r6->netbits,
 	      device);
-  if (r6->metric_defined)
+  if (r6->metric_defined && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 633150f..460684f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -600,6 +600,8 @@ void add_route_connected_v6_net(struct tuntap * tt,
     r6.network = tt->local_ipv6;
     r6.netbits = tt->netbits_ipv6;
     r6.gateway = tt->local_ipv6;
+    r6.metric  = 0;			/* connected route */
+    r6.metric_defined = true;
     add_route_ipv6 (&r6, tt, 0, es);
 }
 
@@ -612,6 +614,8 @@ void delete_route_connected_v6_net(struct tuntap * tt,
     r6.network = tt->local_ipv6;
     r6.netbits = tt->netbits_ipv6;
     r6.gateway = tt->local_ipv6;
+    r6.metric  = 0;			/* connected route */
+    r6.metric_defined = true;
     delete_route_ipv6 (&r6, tt, 0, es);
 }
 #endif
-- 
1.7.3.4


