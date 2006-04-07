From: Roy Marples <uberlord@...594...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V8rNE1tBCf4o8AM"
Message-Id: <200604072035.49898.uberlord@...594...>
Subject: [Openvpn-devel] [PATCH] Default route metric
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Apr  7 12:36:10 2006
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--Boundary-00=_V8rNE1tBCf4o8AM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Using route metrics is a great way to get around default route issues whilst 
preserving the original routes. Attached are patches to 2.0 and 2.1_beta12 
that allow a default metric to be applied to all routes.

IMO, this is a better option than redirecting the local route.

Thanks

-- 
Roy Marples <uberlord@...594...>
Gentoo Linux Developer

--Boundary-00=_V8rNE1tBCf4o8AM
Content-Type: text/x-diff;
  charset="utf-8";
  name="openvpn-2.0.6-metric.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.0.6-metric.patch"

--- openvpn-2.0.6/init.c	2006-04-05 07:42:32.000000000 +0100
+++ openvpn-2.0.6/init.c	2006-04-05 13:13:07.746574282 +0100
@@ -552,15 +552,19 @@
 {
   const char *gw = NULL;
   int dev = dev_type_enum (options->dev, options->dev_type);
+  int metric = 0;
 
   if (dev == DEV_TYPE_TUN)
     gw = options->ifconfig_remote_netmask;
   if (options->route_default_gateway)
     gw = options->route_default_gateway;
+  if (options->route_default_metric)
+    metric = options->route_default_metric;
 
   if (!init_route_list (route_list,
 			options->routes,
 			gw,
+			metric,
 			link_socket_current_remote (link_socket_info),
 			es))
     {
--- openvpn-2.0.6/openvpn.8	2005-11-03 01:16:43.000000000 +0000
+++ openvpn-2.0.6/openvpn.8	2006-04-05 13:25:29.477614144 +0100
@@ -223,6 +223,7 @@
 [\ \fB\-\-route\-delay\fR\ \fI[n]\ [w]\fR\ ]
 [\ \fB\-\-route\-gateway\fR\ \fIgw\fR\ ]
 [\ \fB\-\-route\-method\fR\ \fIm\fR\ ]
+[\ \fB\-\-route\-metric\fR\ \fIm\fR\ ]
 [\ \fB\-\-route\-noexec\fR\ ]
 [\ \fB\-\-route\-up\fR\ \fIcmd\fR\ ]
 [\ \fB\-\-route\fR\ \fInetwork\ [netmask]\ [gateway]\ [metric]\fR\ ]
@@ -918,6 +919,11 @@
 .B --dev tun
 is specified.
 
+.B metric
+default -- taken from
+.B --route-metric
+otherwise 0.
+
 The default can be specified by leaving an option blank or setting
 it to "default".
 
@@ -954,6 +960,12 @@
 .B gw
 for use with
 .B --route.
+.TP
+.B --route-metric m
+Specify a default metric
+.B m
+for use with
+.B --route.
 .\"*********************************************************
 .TP
 .B --route-delay [n] [w]
--- openvpn-2.0.6/options.c	2005-12-12 23:50:43.000000000 +0000
+++ openvpn-2.0.6/options.c	2006-04-05 13:13:07.846584407 +0100
@@ -147,6 +147,7 @@
   "                  gateway default: taken from --route-gateway or --ifconfig\n"
   "                  Specify default by leaving blank or setting to \"nil\".\n"
   "--route-gateway gw : Specify a default gateway for use with --route.\n"
+  "--route-metric m : Specify a default metric for use with --route.\n"
   "--route-delay n [w] : Delay n seconds after connection initiation before\n"
   "                  adding routes (may be 0).  If not specified, routes will\n"
   "                  be added immediately after tun/tap open.  On Windows, wait\n"
@@ -1062,6 +1063,7 @@
 
   SHOW_STR (route_script);
   SHOW_STR (route_default_gateway);
+  SHOW_INT (route_default_metric);
   SHOW_BOOL (route_noexec);
   SHOW_INT (route_delay);
   SHOW_INT (route_delay_window);
@@ -3505,6 +3507,12 @@
       VERIFY_PERMISSION (OPT_P_ROUTE);
       options->route_default_gateway = p[1];      
     }
+  else if (streq (p[0], "route-metric") && p[1])
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_ROUTE);
+      options->route_default_metric = positive_atoi (p[1]);
+    }
   else if (streq (p[0], "route-delay"))
     {
       VERIFY_PERMISSION (OPT_P_ROUTE);
--- openvpn-2.0.6/options.h	2005-11-01 11:06:11.000000000 +0000
+++ openvpn-2.0.6/options.h	2006-04-05 13:13:07.846584407 +0100
@@ -234,6 +234,7 @@
   /* route management */
   const char *route_script;
   const char *route_default_gateway;
+  int route_default_metric;
   bool route_noexec;
   int route_delay;
   int route_delay_window;
--- openvpn-2.0.6/route.c	2006-04-05 07:13:55.000000000 +0100
+++ openvpn-2.0.6/route.c	2006-04-05 13:13:07.890588862 +0100
@@ -238,10 +238,10 @@
 	}
       r->metric_defined = true;
     }
-  else
+  else if (spec->default_metric_defined)
     {
-      r->metric = 0;
-      r->metric_defined = false;
+      r->metric = spec->default_metric;
+      r->metric_defined = true;
     }
 
   r->defined = true;
@@ -284,6 +284,7 @@
 init_route_list (struct route_list *rl,
 		 const struct route_option_list *opt,
 		 const char *remote_endpoint,
+		 int default_metric,
 		 in_addr_t remote_host,
 		 struct env_set *es)
 {
@@ -298,6 +299,12 @@
       rl->spec.remote_host_defined = true;
     }
 
+  if (default_metric)
+    {
+      rl->spec.default_metric = default_metric;
+      rl->spec.default_metric_defined = true;
+    }
+
   rl->spec.net_gateway_defined = get_default_gateway (&rl->spec.net_gateway);
   if (rl->spec.net_gateway_defined)
     {
--- openvpn-2.0.6/route.h	2005-11-01 11:06:11.000000000 +0000
+++ openvpn-2.0.6/route.h	2006-04-05 13:13:07.890588862 +0100
@@ -56,6 +56,8 @@
   bool net_gateway_defined;
   in_addr_t remote_host;
   bool remote_host_defined;
+  int default_metric;
+  bool default_metric_defined;
 };
 
 struct route_option {
@@ -119,6 +121,7 @@
 bool init_route_list (struct route_list *rl,
 		      const struct route_option_list *opt,
 		      const char *remote_endpoint,
+		      int default_metric,
 		      in_addr_t remote_host,
 		      struct env_set *es);
 

--Boundary-00=_V8rNE1tBCf4o8AM
Content-Type: text/x-diff;
  charset="utf-8";
  name="openvpn-2.1_beta12-metric.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.1_beta12-metric.patch"

--- openvpn-2.1_beta12/init.c	2006-04-05 08:02:52.000000000 +0100
+++ openvpn-2.1_beta12/init.c	2006-04-07 19:20:09.496598250 +0100
@@ -629,15 +629,19 @@
 {
   const char *gw = NULL;
   int dev = dev_type_enum (options->dev, options->dev_type);
+  int metric = 0;
 
   if (dev == DEV_TYPE_TUN && (options->topology == TOP_NET30 || options->topology == TOP_P2P))
     gw = options->ifconfig_remote_netmask;
   if (options->route_default_gateway)
     gw = options->route_default_gateway;
+  if (options->route_default_metric)
+    metric = options->route_default_metric;
 
   if (!init_route_list (route_list,
 			options->routes,
 			gw,
+			metric,
 			link_socket_current_remote (link_socket_info),
 			es))
     {
--- openvpn-2.1_beta12/openvpn.8	2006-04-05 08:02:54.000000000 +0100
+++ openvpn-2.1_beta12/openvpn.8	2006-04-07 19:06:39.725990750 +0100
@@ -240,6 +240,7 @@
 [\ \fB\-\-route\-delay\fR\ \fI[n]\ [w]\fR\ ]
 [\ \fB\-\-route\-gateway\fR\ \fIgw\fR\ ]
 [\ \fB\-\-route\-method\fR\ \fIm\fR\ ]
+[\ \fB\-\-route\-metric\fR\ \fIm\fR\ ]
 [\ \fB\-\-route\-noexec\fR\ ]
 [\ \fB\-\-route\-nopull\fR\ ]
 [\ \fB\-\-route\-up\fR\ \fIcmd\fR\ ]
@@ -1037,6 +1038,11 @@
 .B --dev tun
 is specified.
 
+.B metric
+default -- taken from
+.B --route-metric
+otherwise 0.
+
 The default can be specified by leaving an option blank or setting
 it to "default".
 
@@ -1073,6 +1079,12 @@
 .B gw
 for use with
 .B --route.
+.TP
+.B --route-metric m
+Specify a default metric
+.B m
+for use with
+.B --route.
 .\"*********************************************************
 .TP
 .B --route-delay [n] [w]
Only in openvpn-2.1_beta12: openvpn.8.orig
diff -u openvpn-2.1_beta12/options.c openvpn-2.1_beta12/options.c
--- openvpn-2.1_beta12/options.c	2006-04-05 08:02:55.000000000 +0100
+++ openvpn-2.1_beta12/options.c	2006-04-07 19:06:39.733991250 +0100
@@ -166,6 +166,7 @@
   "                  gateway default: taken from --route-gateway or --ifconfig\n"
   "                  Specify default by leaving blank or setting to \"nil\".\n"
   "--route-gateway gw : Specify a default gateway for use with --route.\n"
+  "--route-metric m : Specify a default metric for use with --route.\n"
   "--route-delay n [w] : Delay n seconds after connection initiation before\n"
   "                  adding routes (may be 0).  If not specified, routes will\n"
   "                  be added immediately after tun/tap open.  On Windows, wait\n"
@@ -1175,6 +1176,7 @@
 
   SHOW_STR (route_script);
   SHOW_STR (route_default_gateway);
+  SHOW_INT (route_default_metric);
   SHOW_BOOL (route_noexec);
   SHOW_INT (route_delay);
   SHOW_INT (route_delay_window);
@@ -3938,6 +3940,11 @@
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
       options->route_default_gateway = p[1];      
     }
+  else if (streq (p[0], "route-metric") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_ROUTE);
+      options->route_default_metric = positive_atoi (p[1]);
+    }
   else if (streq (p[0], "route-delay"))
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
--- openvpn-2.1_beta12/options.h	2006-04-05 08:02:56.000000000 +0100
+++ openvpn-2.1_beta12/options.h	2006-04-07 19:06:39.733991250 +0100
@@ -243,6 +243,7 @@
   /* route management */
   const char *route_script;
   const char *route_default_gateway;
+  int route_default_metric;
   bool route_noexec;
   int route_delay;
   int route_delay_window;
--- openvpn-2.1_beta12/route.c	2006-04-05 08:29:29.000000000 +0100
+++ openvpn-2.1_beta12/route.c	2006-04-07 19:06:39.741991750 +0100
@@ -276,10 +276,10 @@
 	}
       r->metric_defined = true;
     }
-  else
+  else if (spec->default_metric_defined)
     {
-      r->metric = 0;
-      r->metric_defined = false;
+      r->metric = spec->default_metric;
+      r->metric_defined = true;
     }
 
   r->defined = true;
@@ -322,6 +322,7 @@
 init_route_list (struct route_list *rl,
 		 const struct route_option_list *opt,
 		 const char *remote_endpoint,
+		 int default_metric,
 		 in_addr_t remote_host,
 		 struct env_set *es)
 {
@@ -338,6 +339,12 @@
       rl->spec.remote_host_defined = true;
     }
 
+  if (default_metric)
+    {
+      rl->spec.default_metric = default_metric;
+      rl->spec.default_metric_defined = true;
+    }
+
   rl->spec.net_gateway_defined = get_default_gateway (&rl->spec.net_gateway);
   if (rl->spec.net_gateway_defined)
     {
--- openvpn-2.1_beta12/route.h	2005-12-22 18:30:10.000000000 +0000
+++ openvpn-2.1_beta12/route.h	2006-04-07 19:10:41.141078250 +0100
@@ -65,6 +65,8 @@
   in_addr_t remote_host;
   bool remote_host_defined;
   struct route_bypass bypass;
+  int default_metric;
+  bool default_metric_defined;
 };
 
 struct route_option {
@@ -132,6 +134,7 @@
 bool init_route_list (struct route_list *rl,
 		      const struct route_option_list *opt,
 		      const char *remote_endpoint,
+		      int default_metric,
 		      in_addr_t remote_host,
 		      struct env_set *es);
 

--Boundary-00=_V8rNE1tBCf4o8AM--

