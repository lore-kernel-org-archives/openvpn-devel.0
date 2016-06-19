Date: Sun, 19 Jun 2016 21:45:38 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20160619194538.GR2563@...2120...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
Subject: [Openvpn-devel] Adding "protocol static" to Linux routes?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here we used two openvpn servers for resiliency, and we use the bird
bgp daemon to make the two boxes exchange routes. Bird however does not
pick up openvpn's routes because they are considered as "protocol boot"
in Linux' "ip route" terms, i.e. they are assumed to be an automatic
configuration, and not an administratively-configured route (see the
protocol RTPROTO part of man ip-route for the details).

So we need the attached change, which just adds "protocol static", to
express that the routes created by openvpn are to override other
dynamic routing.

What do you think?

Samuel

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=proto_static

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a90195f..62ea633 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1418,7 +1418,7 @@ add_route (struct route_ipv4 *r,
 
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
-  argv_printf (&argv, "%s route add %s/%d",
+  argv_printf (&argv, "%s route add %s/%d protocol static",
   	      iproute_path,
 	      network,
               netmask_to_netbits2(r->netmask));

--v9Ux+11Zm5mwPlX6--

