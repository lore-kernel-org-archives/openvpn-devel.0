Resent-Message-Id: <201407131310.s6DDAGAu013541@...1295...>
From: Gert Doering <gert@...1296...>
Date: Sun, 13 Jul 2014 14:28:47 +0200
Message-Id: <1405254527-23833-1-git-send-email-gert@...1296...>
In-Reply-To: <1405075659-7881-1-git-send-email-arne@...1227...>
References: <1405075659-7881-1-git-send-email-arne@...1227...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH] Fix server routes not working in topology
	subnet with --server [v3]
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

From: Arne Schwabe <arne@...1227...>

The IPv4 routing code needs an IPv4 address to point a route to, and
in --topology subnet mode, the *server* did not have one set by default.

So we now just default --route-gateway to the next address right after
the server address - the specific address doesn't matter, as the correct
next-hop will not be resolved by the host OS but by the OpenVPN daemon.
All that is needed is "it's in the subnet routed to the tun interface".

Using the server address itself would work on unix, but doesn't work with
the Windows TAP driver (as it does not spoof ARP responses for itself).

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8        | 5 ++++-
 src/openvpn/helper.c | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 6d4f3cf..90d6eb0 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2704,7 +2704,7 @@ on sufficiently fast hardware.  SSL/TLS authentication must
 be used in this mode.
 .\"*********************************************************
 .TP
-.B \-\-server network netmask
+.B \-\-server network netmask ['nopool']
 A helper directive designed to simplify the configuration
 of OpenVPN's server mode.  This directive will set up an
 OpenVPN server which will allocate addresses to clients
@@ -2739,6 +2739,9 @@ expands as follows:
    if !nopool:
      ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
    push "route-gateway 10.8.0.1"
+   if route-gateway unset:
+     route-gateway 10.8.0.2
+      
 .in -4
 .ft
 .fi
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index d9eef03..0ed0b2b 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -232,6 +232,8 @@ helper_client_server (struct options *o)
    *   if !nopool: 
    *     ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
    *   push "route-gateway 10.8.0.1"
+   *   if route-gateway unset:
+   *     route-gateway 10.8.0.2
    */
 
   if (o->server_defined)
@@ -311,8 +313,10 @@ helper_client_server (struct options *o)
 		  ifconfig_pool_verify_range (M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
 		}
 	      o->ifconfig_pool_netmask = o->server_netmask;
-		  
+
 	      push_option (o, print_opt_route_gateway (o->server_network + 1, &o->gc), M_USAGE);
+	      if (!o->route_default_gateway)
+		o->route_default_gateway = print_in_addr_t (o->server_network + 2, 0, &o->gc);
 	    }
 	  else
 	    ASSERT (0);
-- 
1.8.3.2


