From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 12 Dec 2015 14:34:20 +0200
Message-Id: <1449923660-27363-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Pass adapter index to up/down scripts
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

Trac #637

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/init.c | 18 ++++++++++++++++++
 src/openvpn/misc.c |  6 ++++++
 src/openvpn/misc.h |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 179c7ef..b0c0e26 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1485,6 +1485,9 @@ do_open_tun (struct context *c)
 		   c->plugins,
 		   OPENVPN_PLUGIN_UP,
 		   c->c1.tuntap->actual_name,
+#ifdef WIN32
+		   c->c1.tuntap->adapter_index,
+#endif
 		   dev_type_string (c->options.dev, c->options.dev_type),
 		   TUN_MTU_SIZE (&c->c2.frame),
 		   EXPANDED_SIZE (&c->c2.frame),
@@ -1526,6 +1529,9 @@ do_open_tun (struct context *c)
 		     c->plugins,
 		     OPENVPN_PLUGIN_UP,
 		     c->c1.tuntap->actual_name,
+#ifdef WIN32
+		     c->c1.tuntap->adapter_index,
+#endif
 		     dev_type_string (c->options.dev, c->options.dev_type),
 		     TUN_MTU_SIZE (&c->c2.frame),
 		     EXPANDED_SIZE (&c->c2.frame),
@@ -1564,6 +1570,9 @@ do_close_tun (struct context *c, bool force)
   if (c->c1.tuntap && c->c1.tuntap_owned)
     {
       const char *tuntap_actual = string_alloc (c->c1.tuntap->actual_name, &gc);
+#ifdef WIN32
+      DWORD adapter_index = c->c1.tuntap->adapter_index;
+#endif
       const in_addr_t local = c->c1.tuntap->local;
       const in_addr_t remote_netmask = c->c1.tuntap->remote_netmask;
 
@@ -1587,6 +1596,9 @@ do_close_tun (struct context *c, bool force)
                            c->plugins,
                            OPENVPN_PLUGIN_ROUTE_PREDOWN,
                            tuntap_actual,
+#ifdef WIN32
+                           adapter_index,
+#endif
                            NULL,
                            TUN_MTU_SIZE (&c->c2.frame),
                            EXPANDED_SIZE (&c->c2.frame),
@@ -1612,6 +1624,9 @@ do_close_tun (struct context *c, bool force)
 		       c->plugins,
 		       OPENVPN_PLUGIN_DOWN,
 		       tuntap_actual,
+#ifdef WIN32
+		       adapter_index,
+#endif
 		       NULL,
 		       TUN_MTU_SIZE (&c->c2.frame),
 		       EXPANDED_SIZE (&c->c2.frame),
@@ -1635,6 +1650,9 @@ do_close_tun (struct context *c, bool force)
 			 c->plugins,
 			 OPENVPN_PLUGIN_DOWN,
 			 tuntap_actual,
+#ifdef WIN32
+			 adapter_index,
+#endif
 			 NULL,
 			 TUN_MTU_SIZE (&c->c2.frame),
 			 EXPANDED_SIZE (&c->c2.frame),
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index bc411bf..05ed073 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -62,6 +62,9 @@ run_up_down (const char *command,
 	     const struct plugin_list *plugins,
 	     int plugin_type,
 	     const char *arg,
+#ifdef WIN32
+	     DWORD adapter_index,
+#endif
 	     const char *dev_type,
 	     int tun_mtu,
 	     int link_mtu,
@@ -82,6 +85,9 @@ run_up_down (const char *command,
   setenv_str (es, "dev", arg);
   if (dev_type)
     setenv_str (es, "dev_type", dev_type);
+#ifdef WIN32
+  setenv_int (es, "dev_idx", adapter_index);
+#endif
 
   if (!ifconfig_local)
     ifconfig_local = "";
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index dbe899e..65a6e55 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -63,6 +63,9 @@ void run_up_down (const char *command,
 		  const struct plugin_list *plugins,
 		  int plugin_type,
 		  const char *arg,
+#ifdef WIN32
+		  DWORD adapter_index,
+#endif
 		  const char *dev_type,
 		  int tun_mtu,
 		  int link_mtu,
-- 
1.9.1


