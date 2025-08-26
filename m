From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:40:38 +0200
Message-ID: <20250826184046.21434-1-gert@...1296...>
In-Reply-To: <gerrit.1755980171000.I1e623b4a836f7216750867243299c7e4d0bd32d0@...2715...>
References: <gerrit.1755980171000.I1e623b4a836f7216750867243299c7e4d0bd32d0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Introduce env variables to communicate
 desired gateway redirection to NM.
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

When run under Network Manager control, OpenVPN is not allowed to
control routing.  Instead, NM uses the OpenVPN-set environment variables
("route_network_1" etc) to set up routes as requested.  This method never
worked properly for "redirect-gateway", as the information was not made
available in environment variables.

Introduce new env vars:

 route_redirect_gateway_ipv4
 route_redirect_gateway_ipv6

to communicate desired state:

 <not set> = no gateway redirection desired
 1 = "redirect-gateway for that protocol in question"
 2 = "include block-local to redirect the local LAN as well"

We intentionally do not expose all the IPv4 flags ("local", "def1", ...)
as this is really internal OpenVPN historical cruft.

Change-Id: I1e623b4a836f7216750867243299c7e4d0bd32d0
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1156
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index bd5ecd4..670cd33 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -874,6 +874,14 @@
     translations will be recorded rather than their names as denoted on the
     command line or configuration file.
 
+:code:`route_redirect_gateway_ipv4`
+
+:code:`route_redirect_gateway_ipv6`
+    Set to `1` if the corresponding default gateway should be redirected
+    into the tunnel, and to `2` if also the local LAN segment should be
+    blocked (`block-local`).  Not set otherwise.  Set prior to **--up** script
+    execution.
+
 :code:`script_context`
     Set to "init" or "restart" prior to up/down script execution. For more
     information, see documentation for ``--up``.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0b16c5a..648d526 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5720,6 +5720,8 @@
         {
             options->routes_ipv6->flags = 0;
         }
+        env_set_del(es, "route_redirect_gateway_ipv4");
+        env_set_del(es, "route_redirect_gateway_ipv6");
     }
     else if (streq(p[0], "dns") && !p[1])
     {
@@ -6039,6 +6041,8 @@
             {
                 options->routes_ipv6->flags = 0;
             }
+            env_set_del(es, "route_redirect_gateway_ipv4");
+            env_set_del(es, "route_redirect_gateway_ipv6");
             *update_options_found |= OPT_P_U_REDIR_GATEWAY;
         }
     }
@@ -7661,6 +7665,16 @@
                 goto err;
             }
         }
+        if (options->routes->flags & RG_REROUTE_GW)
+        {
+            setenv_int(es, "route_redirect_gateway_ipv4",
+                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+        }
+        if (options->routes_ipv6 && (options->routes_ipv6->flags & RG_REROUTE_GW))
+        {
+            setenv_int(es, "route_redirect_gateway_ipv6",
+                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+        }
 #ifdef _WIN32
         /* we need this here to handle pushed --redirect-gateway */
         remap_redirect_gateway_flags(options);

