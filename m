Date: Sun, 19 Jun 2016 22:21:39 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20160619202139.GS2563@...2120...>
References: <20160619194538.GR2563@...2120...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20160619194538.GR2563@...2120...>
Subject: Re: [Openvpn-devel] Adding "protocol static" to Linux routes?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Samuel Thibault, on Sun 19 Jun 2016 21:45:38 +0200, wrote:
> So we need the attached change, which just adds "protocol static", to
> express that the routes created by openvpn are to override other
> dynamic routing.

Of course, v6 needs it too.

Samuel

--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=proto_static

--- a/route.c
+++ b/route.c
@@ -1113,7 +1113,7 @@ add_route (struct route *r, const struct
 
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s route add %s/%d via %s",
+  argv_printf (&argv, "%s route add %s/%d via %s protocol static",
   	      iproute_path,
 	      network,
 	      count_netmask_bits(netmask),
@@ -1328,7 +1328,7 @@ add_route_ipv6 (struct route_ipv6 *r6, c
 
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s -6 route add %s/%d dev %s",
+  argv_printf (&argv, "%s -6 route add %s/%d dev %s protocol static",
   	      iproute_path,
 	      network,
 	      r6->netbits,

--ncSAzJYg3Aa9+CRW--

