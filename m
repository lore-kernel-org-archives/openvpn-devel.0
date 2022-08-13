From: Antonio Quartulli <a@...2181...>
Date: Sat, 13 Aug 2022 22:42:24 +0200
Message-Id: <20220813204224.22576-7-a@...2181...>
In-Reply-To: <20220813204224.22576-1-a@...2181...>
References: <20220813204224.22576-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v101 7/7] dco: properly name variables
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

renamed remote_addrX variables to vpn_addrX to make it clear that they
refer to the address over the VPN/tunnel

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcb570f9..0b56eec4 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -561,19 +561,20 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
         remoteaddr = &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
     }
 
-    struct in_addr remote_ip4 = { 0 };
-    struct in6_addr *remote_addr6 = NULL;
-    struct in_addr *remote_addr4 = NULL;
-
     /* In server mode we need to fetch the remote addresses from the push config */
+
+    struct in_addr vpn_ip4 = { 0 };
+    struct in_addr *vpn_addr4 = NULL;
     if (c->c2.push_ifconfig_defined)
     {
-        remote_ip4.s_addr =  htonl(c->c2.push_ifconfig_local);
-        remote_addr4 = &remote_ip4;
+        vpn_ip4.s_addr =  htonl(c->c2.push_ifconfig_local);
+        vpn_addr4 = &vpn_ip4;
     }
+
+    struct in6_addr *vpn_addr6 = NULL;
     if (c->c2.push_ifconfig_ipv6_defined)
     {
-        remote_addr6 = &c->c2.push_ifconfig_ipv6_local;
+        vpn_addr6 = &c->c2.push_ifconfig_ipv6_local;
     }
 
     if (dco_multi_get_localaddr(m, mi, &local))
@@ -582,7 +583,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
     }
 
     int ret = dco_new_peer(&c->c1.tuntap->dco, peer_id, sd, localaddr,
-                           remoteaddr, remote_addr4, remote_addr6);
+                           remoteaddr, vpn_addr4, vpn_addr6);
     if (ret < 0)
     {
         return ret;
-- 
2.35.1


