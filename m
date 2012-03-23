Message-ID: <4F6C68AE.60003@...1702...>
Date: Fri, 23 Mar 2012 13:12:30 +0100
From: Samuel CUELLA <samuel.cuella@...1702...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [openvpn-devel] OpenVPN 2.1.4/Linux: route-gatewy
	not working
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

I've been struggling with OpenVPN bridge mode an entire day before going
down to the source code:

The documentation (man page) says that the server-bridge configuration
directive expands to more directives, including a "route-gateway" push.
The push is actually done and is received on client side, but does
nothing, i.e no default route is added on the client.

I've tracked down the issue in the source code and it seems that this
option as no effect when no route list have been created:
do_open_tun() only calls do_init_route_list if c->options.routes has
been initialized. This seems to be done by rol_check_alloc() in
add_option during option parsing. This is done only for the
"redirect-gateway" gateway option and never for "route-gateway",
resulting in this option being a no-op.

I've also tried (client-side and server-side) to use dummy routes(the
route that would be automatically added upon tap creation) to make
OpenVPN to create a route list without more success.

I don't know if this is the desired behavior or if I'm missing something
here, but at least the documentation should be more clear on this feature.

Below is a patch that fix what I find broken.
----
Author: Samuel CUELLA <samuel.cuella@...1702...>

Fix the route-gateway option behavior.

Signed-off-by: Samuel CUELLA <samuel.cuella@...1702...>
----
diff -Nur openvpn-2.1.4-orig//options.c openvpn-2.1.4/options.c
--- openvpn-2.1.4-orig//options.c   2010-11-04 20:29:02.000000000 +0100
+++ openvpn-2.1.4/options.c 2012-03-23 13:20:08.000000000 +0100
@@ -4561,6 +4561,8 @@
   else if (streq (p[0], "route-gateway") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
+      rol_check_alloc (options);
+
       if (streq (p[1], "dhcp"))
    {
      options->route_gateway_via_dhcp = true;
@@ -4570,6 +4572,7 @@
      if (ip_or_dns_addr_safe (p[1], options->allow_pull_fqdn) ||
is_special_addr (p[1])) /* FQDN -- may be DNS name */
        {
          options->route_default_gateway = p[1];
+             options->routes->flags |= (RG_ENABLE|RG_REROUTE_GW);
        }
      else
        {



