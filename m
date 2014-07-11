From: Arne Schwabe <arne@...1227...>
Date: Fri, 11 Jul 2014 12:47:39 +0200
Message-Id: <1405075659-7881-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix server routes not working in topology
	subnet with --server
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

---
 doc/openvpn.8        | 5 ++++-
 src/openvpn/helper.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 6d4f3cf..d5eeed5 100644
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
+   if redirect-gateway unset:
+     redirect-gateway 10.8.0.1
+      
 .in -4
 .ft
 .fi
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index d9eef03..fb22815 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -232,6 +232,7 @@ helper_client_server (struct options *o)
    *   if !nopool: 
    *     ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
    *   push "route-gateway 10.8.0.1"
+   *   route-gateway 10.8.0.1
    */
 
   if (o->server_defined)
@@ -311,8 +312,10 @@ helper_client_server (struct options *o)
 		  ifconfig_pool_verify_range (M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
 		}
 	      o->ifconfig_pool_netmask = o->server_netmask;
-		  
+
 	      push_option (o, print_opt_route_gateway (o->server_network + 1, &o->gc), M_USAGE);
+	      if (!o->route_default_gateway)
+		o->route_default_gateway = o->ifconfig_local;
 	    }
 	  else
 	    ASSERT (0);
-- 
1.8.5.2 (Apple Git-48)


