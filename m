From: David Sommerseth <davids@...1347...>
Date: Tue, 24 Jan 2012 12:38:50 +0100
Message-Id: <1327405130-22393-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Add
	--route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook
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

This patchs adds a script/plug-in hook which is called right before the
network routes are taken down.  This is give external processes a
possibility to tear down communication over the VPN before the VPN
disappears.

One use case can be to mount a networked file system over the VPN via
--route-up.  And then to unmount this file system via --route-pre-down

Signed-off-by: David Sommerseth <davids@...1347...>
---
 init.c           |   21 +++++++++++++++++++--
 openvpn-plugin.h |    3 ++-
 openvpn.8        |    4 ++++
 options.c        |   11 +++++++++++
 options.h        |    1 +
 5 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/init.c b/init.c
index 00e93c9..b8cb84f 100644
--- a/init.c
+++ b/init.c
@@ -1583,8 +1583,25 @@ do_close_tun (struct context *c, bool force)
 
 	  /* delete any routes we added */
 	  if (c->c1.route_list || c->c1.route_ipv6_list )
-	    delete_routes (c->c1.route_list, c->c1.route_ipv6_list,
-			   c->c1.tuntap, ROUTE_OPTION_FLAGS (&c->options), c->c2.es);
+            {
+              run_up_down (c->options.route_predown_script,
+                           c->plugins,
+                           OPENVPN_PLUGIN_ROUTE_PREDOWN,
+                           tuntap_actual,
+                           NULL,
+                           TUN_MTU_SIZE (&c->c2.frame),
+                           EXPANDED_SIZE (&c->c2.frame),
+                           print_in_addr_t (local, IA_EMPTY_IF_UNDEF, &gc),
+                           print_in_addr_t (remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
+                           "init",
+                           signal_description (c->sig->signal_received,
+                                               c->sig->signal_text),
+                           "route-pre-down",
+                           c->c2.es);
+
+              delete_routes (c->c1.route_list, c->c1.route_ipv6_list,
+                             c->c1.tuntap, ROUTE_OPTION_FLAGS (&c->options), c->c2.es);
+            }
 
 	  /* actually close tun/tap device based on --down-pre flag */
 	  if (!c->options.down_pre)
diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 474c910..de54a5a 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -108,7 +108,8 @@
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_V2     9
 #define OPENVPN_PLUGIN_TLS_FINAL             10
 #define OPENVPN_PLUGIN_ENABLE_PF             11
-#define OPENVPN_PLUGIN_N                     12
+#define OPENVPN_PLUGIN_ROUTE_PREDOWN         12
+#define OPENVPN_PLUGIN_N                     13
 
 /*
  * Build a mask out of a set of plug-in types.
diff --git a/openvpn.8 b/openvpn.8
index 4a86ce7..a6d7567 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -5194,6 +5194,10 @@ as defined by the
 option.
 .\"*********************************************************
 .TP
+.B \-\-route-pre-down
+Executed right before the routes are removed.
+.\"*********************************************************
+.TP
 .B \-\-client-disconnect
 Executed in
 .B \-\-mode server
diff --git a/options.c b/options.c
index e7e6565..0fbe368 100644
--- a/options.c
+++ b/options.c
@@ -216,6 +216,7 @@ static const char usage_message[] =
   "                  be added immediately after tun/tap open.  On Windows, wait\n"
   "                  up to w seconds for TUN/TAP adapter to come up.\n"
   "--route-up cmd  : Execute shell cmd after routes are added.\n"
+  "--route-pre-down cmd  : Execute shell cmd before routes are removed.\n"
   "--route-noexec  : Don't add routes automatically.  Instead pass routes to\n"
   "                  --route-up script using environmental variables.\n"
   "--route-nopull  : When used with --client or --pull, accept options pushed\n"
@@ -2739,6 +2740,8 @@ options_postprocess_filechecks (struct options *options)
                              R_OK|X_OK, "--ipchange script");
   errs |= check_file_access (CHKACC_FILE, options->route_script,
                              R_OK|X_OK, "--route-up script");
+  errs |= check_file_access (CHKACC_FILE, options->route_predown_script,
+                             R_OK|X_OK, "--route-pre-down script");
   errs |= check_file_access (CHKACC_FILE, options->learn_address_script,
                              R_OK|X_OK, "--learn-address script");
 #endif /* P2MP_SERVER */
@@ -5217,6 +5220,14 @@ add_option (struct options *options,
       warn_multiple_script (options->route_script, "route-up");
       options->route_script = p[1];
     }
+  else if (streq (p[0], "route-pre-down") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_SCRIPT);
+      if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
+	goto err;
+      warn_multiple_script (options->route_predown_script, "route-pre-down");
+      options->route_predown_script = p[1];
+    }
   else if (streq (p[0], "route-noexec"))
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
diff --git a/options.h b/options.h
index 03fd197..831d4f6 100644
--- a/options.h
+++ b/options.h
@@ -360,6 +360,7 @@ struct options
 
   /* route management */
   const char *route_script;
+  const char *route_predown_script;
   const char *route_default_gateway;
   int route_default_metric;
   bool route_noexec;
-- 
1.7.4.4


