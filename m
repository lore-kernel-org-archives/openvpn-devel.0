From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2016 19:39:32 -0500
Message-Id: <1480466372-2396-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Force 'def1' method when --redirect-gateway
	is done through service
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

The service deletes all added routes when the client process (openvpn)
exits, causing the re-instated default route to disappear.
Fix by rewriting "--redirect-gateway" to "--redirect-gateway def1" when
routes are set using interactive service.

Only the behaviour on Windows with intereactive service is affected.

Resolves Trac 778

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 63dcc24..c540e05 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2526,6 +2526,22 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 
 }
 
+#ifdef _WIN32
+/* If iservice is in use, we need def1 method for redirect-gateway */
+static void
+remap_redirect_gateway_flags (struct options *opt)
+{
+  if (opt->routes
+      && opt->route_method == ROUTE_METHOD_SERVICE
+      && opt->routes->flags & RG_REROUTE_GW
+      && !(opt->routes->flags & RG_DEF1))
+    {
+      msg (M_INFO, "Flag 'def1' added to --redirect-gateway (iservice is in use)");
+      opt->routes->flags |= RG_DEF1;
+    }
+}
+#endif
+
 static void
 options_postprocess_mutate_invariant (struct options *options)
 {
@@ -2555,6 +2571,8 @@ options_postprocess_mutate_invariant (struct options *options)
       options->tuntap_options.ip_win32_type = IPW32_SET_MANUAL;
       options->ifconfig_noexec = false;
     }
+
+  remap_redirect_gateway_flags (options);
 #endif
 
 #if P2MP_SERVER
@@ -5705,6 +5723,10 @@ add_option (struct options *options,
 	      goto err;
 	    }
 	}
+#ifdef _WIN32
+      /* we need this here to handle pushed --redirect-gateway */
+      remap_redirect_gateway_flags (options);
+#endif
       options->routes->flags |= RG_ENABLE;
     }
   else if (streq (p[0], "remote-random-hostname") && !p[1])
-- 
2.1.4


