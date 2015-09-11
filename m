From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:40 +0200
Message-Id: <1441985627-14822-4-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 03/10] Add route_ipv6_gateway* data
	structures for rgi6 support.
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

route_gateway_address -> route_ipv6_gateway_address
route_gateway_info    -> route_ipv6_gateway_info

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 7e96a2f..5ab5f98 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -177,6 +177,34 @@ struct route_gateway_info {
   struct route_gateway_address addrs[RGI_N_ADDRESSES]; /* local addresses attached to iface */
 };
 
+struct route_ipv6_gateway_address {
+  struct in6_addr addr_ipv6;
+  int netbits_ipv6;
+};
+
+struct route_ipv6_gateway_info {
+/* RGI_ flags used as in route_gateway_info */
+  unsigned int flags;
+
+  /* gateway interface */
+# ifdef WIN32
+  DWORD adapter_index;  /* interface or ~0 if undefined */
+#else
+  char iface[16]; /* interface name (null terminated), may be empty */
+#endif
+
+  /* gateway interface hardware address */
+  uint8_t hwaddr[6];
+
+  /* gateway/router address */
+  struct route_ipv6_gateway_address gateway;
+
+  /* address/netmask pairs bound to interface */
+# define RGI_N_ADDRESSES 8
+  int n_addrs; /* len of addrs, may be 0 */
+  struct route_ipv6_gateway_address addrs[RGI_N_ADDRESSES]; /* local addresses attached to iface */
+};
+
 struct route_list {
 # define RL_DID_REDIRECT_DEFAULT_GATEWAY (1<<0)
 # define RL_DID_LOCAL                    (1<<1)
-- 
2.3.6


