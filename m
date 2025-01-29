From: Gert Doering <gert@...1296...>
Date: Wed, 29 Jan 2025 18:30:07 +0100
Message-ID: <20250129173007.3280-1-gert@...1296...>
In-Reply-To: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
References: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] options: add IPv4 support to
 '--show-gateway <arg>'
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

This is an old debug option, which used to print "the default routes found"
for IPv4 and IPv6, and optionally "a route to a particular IPv6 target"
if passed an argument.

With the work started in commit 0fcfc8381f60d we want this to handle
IPv4 as well, mostly to be able to easily test per-platform
get_default_gateway() implementations.

The implementation is simplistic - if <arg> can be parsed as an IPv4 or
IPv6 address, that particular protocol lookup will do "the host route"
and the other one will stick to "the default route".

NOTE: as of this commit, there is no backend functionality for IPv4, so
it will not actually print anything interesting.  This will be added in
further platform dependent commits.

v2: amend --help output
v3: uncrustify (#ifdef block too long, comments at #endif required now)

Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/881
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index d5a6b4f..e1115e4 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -9,13 +9,17 @@
   ::
 
      --show-gateway
+     --show-gateway IPv4-target
      --show-gateway IPv6-target
 
+  For IPv4 it looks for a 0.0.0.0/0 route, or the specified IPv4 address
+  if the target can be parsed as an IPv4 address.
   For IPv6 this queries the route towards ::/128, or the specified IPv6
-  target address if passed as argument.
-  For IPv4 on Linux, Windows, MacOS and BSD it looks for a 0.0.0.0/0 route.
-  If there are more specific routes, the result will not always be matching
-  the route of the IPv4 packets to the VPN gateway.
+  target address if the argument is an IPv6 address.
+
+  Adding a target is helpful for diagnostics to see if OpenVPN will do
+  the right thing if there are more specific IPv4/IPv6 routes to a
+  VPN server.
 
 
 Advanced Expert Options
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5a80e6b..218d8a6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -788,7 +788,7 @@
     "\n"
     "General Standalone Options:\n"
 #ifdef ENABLE_DEBUG
-    "--show-gateway : Show info about default gateway.\n"
+    "--show-gateway [address]: Show info about gateway [to v4/v6 address].\n"
 #endif
 ;
 
@@ -5858,20 +5858,26 @@
     {
         struct route_gateway_info rgi;
         struct route_ipv6_gateway_info rgi6;
-        struct in6_addr remote = IN6ADDR_ANY_INIT;
+        in_addr_t remote_ipv4 = 0;
+        struct in6_addr remote_ipv6 = IN6ADDR_ANY_INIT;
         openvpn_net_ctx_t net_ctx;
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (p[1])
         {
-            get_ipv6_addr(p[1], &remote, NULL, M_WARN);
+            /* try parsing the argument as a v4 or v6 address - if
+             * possible, the output will show the exact route there, and
+             * "the default route" for the other protocol
+             */
+            remote_ipv4 = get_ip_addr(p[1], M_WARN, NULL);
+            get_ipv6_addr(p[1], &remote_ipv6, NULL, M_WARN);
         }
         net_ctx_init(NULL, &net_ctx);
-        get_default_gateway(&rgi, 0, &net_ctx);
-        get_default_gateway_ipv6(&rgi6, &remote, &net_ctx);
+        get_default_gateway(&rgi, remote_ipv4, &net_ctx);
+        get_default_gateway_ipv6(&rgi6, &remote_ipv6, &net_ctx);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
-#endif
+#endif /* if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL) */
     else if (streq(p[0], "echo") || streq(p[0], "parameter"))
     {
         struct buffer string = alloc_buf_gc(OPTION_PARM_SIZE, &gc);

