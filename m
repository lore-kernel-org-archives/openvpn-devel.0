From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:42 +0100
Message-Id: <1395407925-25518-10-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_09/12=5D_Don=E2=80=99t_redirec?=
	=?utf-8?q?t_the_gateway_on_Android_even_if_requested?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Routing loops are avoided using the VPNService API
---
 src/openvpn/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 13eed5f..eb5fb46 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -530,8 +530,10 @@ add_block_local (struct route_list *rl)
     {
       size_t i;
 
+#ifndef TARGET_ANDROID
       /* add bypass for gateway addr */
       add_bypass_address (&rl->spec.bypass, rl->rgi.gateway.addr);
+#endif
 
       /* block access to local subnet */
       add_block_local_item (rl, &rl->rgi.gateway, rl->spec.remote_endpoint);
@@ -822,6 +824,7 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 	}
       else
 	{
+#ifndef TARGET_ANDROID
 	  bool local = BOOL_CAST(rl->flags & RG_LOCAL);
 	  if (rl->flags & RG_AUTO_LOCAL) {
 	    const int tla = rl->spec.remote_host_local;
@@ -854,6 +857,7 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 		dmsg (D_ROUTE, "ROUTE remote_host protocol differs from tunneled");
 	      }
 	    }
+#endif
 
 	  /* route DHCP/DNS server traffic through original default gateway */
 	  add_bypass_routes (&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags, &rl->rgi, es);
-- 
1.8.5.2 (Apple Git-48)


