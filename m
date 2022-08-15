From: Antonio Quartulli <a@...2181...>
Date: Tue, 16 Aug 2022 00:39:41 +0200
Message-Id: <20220815223941.26839-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: don't pass VPN IPs to NEW_PEER API in
 P2P mode
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
Cc: Antonio Quartulli <a@...2181...>

When adding a peer to a P2P interface, the VPN IPs are not really used by DCO as
there is no routing happening in this mode.

For this reason don't pass any VPN IP when adding a new peer in p2p mode.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c | 51 ++---------------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6933a50f..61cf4dd5 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -401,61 +401,14 @@ dco_p2p_add_new_peer(struct context *c)
         return 0;
     }
 
-    struct tls_multi *multi = c->c2.tls_multi;
     struct link_socket *ls = c->c2.link_socket;
 
-    struct in6_addr remote_ip6 = { 0 };
-    struct in_addr remote_ip4 = { 0 };
-
-    struct in6_addr *remote_addr6 = NULL;
-    struct in_addr *remote_addr4 = NULL;
-
-    const char *gw = NULL;
-
     ASSERT(ls->info.connection_established);
 
-    /* In client mode if a P2P style topology is used we assume the
-     * remote-gateway is the IP of the peer */
-    if (c->options.topology == TOP_NET30 || c->options.topology == TOP_P2P)
-    {
-        gw = c->options.ifconfig_remote_netmask;
-    }
-    if (c->options.route_default_gateway)
-    {
-        gw = c->options.route_default_gateway;
-    }
-
-    /* These inet_pton conversion are fatal since options.c already implements
-     * checks to have only valid addresses when setting the options */
-    if (c->options.ifconfig_ipv6_remote)
-    {
-        if (inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote, &remote_ip6) != 1)
-        {
-            msg(M_FATAL,
-                "DCO peer init: problem converting IPv6 ifconfig remote address %s to binary",
-                c->options.ifconfig_ipv6_remote);
-        }
-        remote_addr6 = &remote_ip6;
-    }
-
-    if (gw)
-    {
-        if (inet_pton(AF_INET, gw, &remote_ip4) != 1)
-        {
-            msg(M_FATAL, "DCO peer init: problem converting IPv4 ifconfig gateway address %s to binary", gw);
-        }
-        remote_addr4 = &remote_ip4;
-    }
-    else if (c->options.ifconfig_local)
-    {
-        msg(M_INFO, "DCO peer init: Need a peer VPN addresss to setup IPv4 (set --route-gateway)");
-    }
-
     struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
-
+    struct tls_multi *multi = c->c2.tls_multi;
     int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_socket->sd, NULL, remoteaddr,
-                           remote_addr4, remote_addr6);
+                           c->c2.link_socket->sd, NULL, remoteaddr, NULL, NULL);
     if (ret < 0)
     {
         return ret;
-- 
2.30.2


