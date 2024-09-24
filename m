From: Gert Doering <gert@...1296...>
Date: Tue, 24 Sep 2024 15:14:37 +0200
Message-ID: <20240924131437.22294-1-gert@...1296...>
In-Reply-To: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
References: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Automatically enable
 ifconfig-exec/route-exec behaviour for afunix tun/tap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Arne Schwabe <arne@...1227...>

Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/750
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd9203a..876edad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1679,6 +1679,18 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
 
+/**
+ * Determine if external route commands should be executed based on
+ * configured options and backend driver
+ */
+static bool
+route_noexec_enabled(const struct options *o, const struct tuntap *tt)
+{
+    return o->route_noexec
+           || (tt && tt->backend_driver == DRIVER_AFUNIX)
+           || (tt && tt->backend_driver == DRIVER_NULL);
+}
+
 /*
  * Possibly add routes and/or call route-up script
  * based on options.
@@ -1693,7 +1705,7 @@
          openvpn_net_ctx_t *ctx)
 {
     bool ret = true;
-    if (!options->route_noexec && ( route_list || route_ipv6_list ) )
+    if (!route_noexec_enabled(options, tt) && ( route_list || route_ipv6_list ) )
     {
         ret = add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(options),
                          es, ctx);
@@ -1858,6 +1870,19 @@
 #endif
 }
 
+/**
+ * Determines if ifconfig execution should be disabled because of a
+ * @param c
+ * @return
+ */
+static bool
+ifconfig_noexec_enabled(const struct context *c)
+{
+    return c->options.ifconfig_noexec
+           || (c->c1.tuntap && c->c1.tuntap->backend_driver == DRIVER_AFUNIX)
+           || (c->c1.tuntap && c->c1.tuntap->backend_driver == DRIVER_NULL);
+}
+
 static void
 open_tun_backend(struct context *c)
 {
@@ -1937,7 +1962,7 @@
         }
 
         /* do ifconfig */
-        if (!c->options.ifconfig_noexec
+        if (!ifconfig_noexec_enabled(c)
             && ifconfig_order(c->c1.tuntap) == IFCONFIG_BEFORE_TUN_OPEN)
         {
             /* guess actual tun/tap unit number that will be returned
@@ -1978,7 +2003,7 @@
         }
 
         /* do ifconfig */
-        if (!c->options.ifconfig_noexec
+        if (!ifconfig_noexec_enabled(c)
             && ifconfig_order(c->c1.tuntap) == IFCONFIG_AFTER_TUN_OPEN)
         {
             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
@@ -2061,7 +2086,7 @@
 
     if (c->c1.tuntap)
     {
-        if (!c->options.ifconfig_noexec)
+        if (!ifconfig_noexec_enabled(c))
         {
             undo_ifconfig(c->c1.tuntap, &c->net_ctx);
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 206ddc0..85fe01a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1744,7 +1744,7 @@
 void
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    if (tt->backend_driver != DRIVER_NULL)
+    if (tt->backend_driver != DRIVER_NULL && tt->backend_driver != DRIVER_AFUNIX)
     {
         if (tt->did_ifconfig_setup)
         {

