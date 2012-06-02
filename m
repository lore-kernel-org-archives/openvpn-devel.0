From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:41 +0200
Message-Id: <1338642223-20324-7-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 6/8] Allow routes to be set before opening
	tun, similar to ifconfig before opening tun
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c |   11 +++++++++--
 src/openvpn/tun.h  |   11 +++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 61ced5d..a25de5d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1478,6 +1478,13 @@ do_open_tun (struct context *c)
 	  do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c->c2.es);
 	}
 
+      /* possibly add routes */
+      if(ifconfig_order() == ROUTE_BEFORE_TUN) {
+		  /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
+		  do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+					c->c1.tuntap, c->plugins, c->c2.es);
+    }
+
       /* open the tun device */
       open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
 		c->c1.tuntap);
@@ -1509,7 +1516,7 @@ do_open_tun (struct context *c)
 		   c->c2.es);
 
       /* possibly add routes */
-      if (!c->options.route_delay_defined)
+      if ((ifconfig_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
 	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
 		  c->c1.tuntap, c->plugins, c->c2.es);
 
@@ -1717,7 +1724,7 @@ do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
 #endif
 
 	  /* if --route-delay was specified, start timer */
-	  if (c->options.route_delay_defined)
+	  if ((ifconfig_order() == ROUTE_AFTER_TUN) && c->options.route_delay_defined)
 	    {
 	      event_timeout_init (&c->c2.route_wakeup, c->options.route_delay, now);
 	      event_timeout_init (&c->c2.route_wakeup_expire, c->options.route_delay + c->options.route_delay_window, now);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9bd990f..60d75c8 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -297,6 +297,17 @@ ifconfig_order(void)
 #endif
 }
 
+#define ROUTE_BEFORE_TUN 0
+#define ROUTE_AFTER_TUN 1
+#define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
+
+static inline int
+route_order(void)
+{
+    return ROUTE_ORDER_DEFAULT;
+}
+
+
 #ifdef WIN32
 
 #define TUN_PASS_BUFFER
-- 
1.7.7.5 (Apple Git-26)


