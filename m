From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:44 +0200
Message-Id: <1441985627-14822-8-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 07/10] Implement '--redirect-gateway ipv6'
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

Add "ipv6" and "!ipv4" sub-options to "--redirect-gateway" option.

This is done in the same way as in the OpenVPN 3 code base, so
"--redirect-gateway ipv6" will redirect both IPv4 and IPv6 - if you
want v6-only, use "--redirect-gateway ipv6 !ipv4".

The actual implementation is much simpler than for IPv4 - we just
add a few extra routes to the route_ipv6_option_list and leave it to
init_route_ipv6_list() to figure out whether there is an overlap with
IPv6 transport, and if yes, insert a host route to the VPN server
via the current IPv6 default gateway.

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         | 11 +++++++++++
 src/openvpn/init.c    | 15 +++++++++++++++
 src/openvpn/options.c |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 0692a80..98378aa 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1240,6 +1240,17 @@ on non-Windows clients).
 Block access to local LAN when the tunnel is active, except for
 the LAN gateway itself.  This is accomplished by routing the local
 LAN (except for the LAN gateway address) into the tunnel.
+
+.B ipv6 --
+Redirect IPv6 routing into the tunnel.  This works similar to the
+.B def1
+flag, that is, more specific IPv6 routes are added (2000::/4, 3000::/4),
+covering the whole IPv6 unicast space.
+
+.B !ipv4 --
+Do not redirect IPv4 traffic - typically used in the flag pair
+.B "ipv6 !ipv4"
+to redirect IPv6-only.
 .\"*********************************************************
 .TP
 .B \-\-link\-mtu n
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0416e35..c47f4a8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1195,6 +1195,21 @@ do_init_route_ipv6_list (const struct options *options,
   if (options->route_default_metric)
     metric = options->route_default_metric;
 
+  /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
+   */
+  if ( options->routes_ipv6->flags & RG_REROUTE_GW )
+    {
+      char *opt_list[] = { "::/3", "2000::/4", "3000::/4", "fc00::/7", NULL };
+      int i;
+
+      for (i=0; opt_list[i]; i++)
+	{
+	  add_route_ipv6_to_option_list( options->routes_ipv6,
+		      string_alloc (opt_list[i], options->routes_ipv6->gc),
+		      NULL, NULL );
+	}
+    }
+
   if (!init_route_ipv6_list (route_ipv6_list,
 			options->routes_ipv6,
 			gw,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 93ea415..dc8985b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5380,6 +5380,13 @@ add_option (struct options *options,
 	    options->routes->flags |= RG_BYPASS_DNS;
 	  else if (streq (p[j], "block-local"))
 	    options->routes->flags |= RG_BLOCK_LOCAL;
+	  else if (streq (p[j], "ipv6"))
+	    {
+	      rol6_check_alloc (options);
+	      options->routes_ipv6->flags |= RG_REROUTE_GW;
+	    }
+	  else if (streq (p[j], "!ipv4"))
+	    options->routes->flags &= ~RG_REROUTE_GW;
 	  else
 	    {
 	      msg (msglevel, "unknown --%s flag: %s", p[0], p[j]);
-- 
2.3.6


