From: David Sommerseth <dazo@...384...>
Date: Tue, 30 Nov 2010 00:06:14 +0100
Message-Id: <1291071974-23749-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Provide 'dev_type' environment variable to
	plug-ins and script hooks
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

Normally OpenVPN is configured with --dev {tun,tap}, but it is also possible
to use --dev myvpn instead.  In these situations, OpenVPN will request
--dev-type as well to be able to set up a tun or tap device properly.

The 'dev' environment variable will contain the value provided by --dev.  In
those cases where the plug-in/script need to behave differently when using a tun
device versus using a tap device, there are no possibilities for it to know what
kind of device --dev myvpn would be.

This patch adds a 'dev_type' environment variable which contains a string of the
device type, either automatically discovered based on the --dev name, or set using
the --dev-type option.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 init.c |    4 ++++
 misc.c |    3 +++
 misc.h |    1 +
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/init.c b/init.c
index b4a0384..f86aa35 100644
--- a/init.c
+++ b/init.c
@@ -1088,6 +1088,7 @@ do_open_tun (struct context *c)
 		   c->plugins,
 		   OPENVPN_PLUGIN_UP,
 		   c->c1.tuntap->actual_name,
+		   dev_type_string (c->options.dev, c->options.dev_type),
 		   TUN_MTU_SIZE (&c->c2.frame),
 		   EXPANDED_SIZE (&c->c2.frame),
 		   print_in_addr_t (c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
@@ -1123,6 +1124,7 @@ do_open_tun (struct context *c)
 		     c->plugins,
 		     OPENVPN_PLUGIN_UP,
 		     c->c1.tuntap->actual_name,
+		     dev_type_string (c->options.dev, c->options.dev_type),
 		     TUN_MTU_SIZE (&c->c2.frame),
 		     EXPANDED_SIZE (&c->c2.frame),
 		     print_in_addr_t (c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
@@ -1186,6 +1188,7 @@ do_close_tun (struct context *c, bool force)
 		       c->plugins,
 		       OPENVPN_PLUGIN_DOWN,
 		       tuntap_actual,
+		       NULL,
 		       TUN_MTU_SIZE (&c->c2.frame),
 		       EXPANDED_SIZE (&c->c2.frame),
 		       print_in_addr_t (local, IA_EMPTY_IF_UNDEF, &gc),
@@ -1208,6 +1211,7 @@ do_close_tun (struct context *c, bool force)
 			 c->plugins,
 			 OPENVPN_PLUGIN_DOWN,
 			 tuntap_actual,
+			 NULL,
 			 TUN_MTU_SIZE (&c->c2.frame),
 			 EXPANDED_SIZE (&c->c2.frame),
 			 print_in_addr_t (local, IA_EMPTY_IF_UNDEF, &gc),
diff --git a/misc.c b/misc.c
index 815c057..a9882f1 100644
--- a/misc.c
+++ b/misc.c
@@ -174,6 +174,7 @@ run_up_down (const char *command,
 	     const struct plugin_list *plugins,
 	     int plugin_type,
 	     const char *arg,
+	     const char *dev_type,
 	     int tun_mtu,
 	     int link_mtu,
 	     const char *ifconfig_local,
@@ -191,6 +192,8 @@ run_up_down (const char *command,
   setenv_int (es, "tun_mtu", tun_mtu);
   setenv_int (es, "link_mtu", link_mtu);
   setenv_str (es, "dev", arg);
+  if (dev_type)
+    setenv_str (es, "dev_type", dev_type);
 
   if (!ifconfig_local)
     ifconfig_local = "";
diff --git a/misc.h b/misc.h
index 4695d3e..d064043 100644
--- a/misc.h
+++ b/misc.h
@@ -93,6 +93,7 @@ void run_up_down (const char *command,
 		  const struct plugin_list *plugins,
 		  int plugin_type,
 		  const char *arg,
+		  const char *dev_type,
 		  int tun_mtu,
 		  int link_mtu,
 		  const char *ifconfig_local,
-- 
1.7.2.3


