From: Qingfang Deng <dqfext@...277...>
Date: Sat,  1 Feb 2025 14:24:37 +0800
Message-ID: <20250201062437.4059652-1-dqfext@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco: fix source IP selection
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

When multihome option is enabled, OpenVPN passes ipi_addr to DCO, which
is always 0.0.0.0. It should use ipi_spec_dst instead.
When local option is present, OpenVPN does not pass it to DCO.
As a result, Linux may pick a different IP as the source IP, breaking
the connection.

Signed-off-by: Qingfang Deng <dqfext@...277...>
---
v2: fix code style reported by CI
Discussions: https://github.com/OpenVPN/openvpn/pull/668

 src/openvpn/dco.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b5a21369..eef49ade 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -493,6 +493,7 @@ dco_p2p_add_new_peer(struct context *c)
     ASSERT(sock->info.connection_established);
 
     struct sockaddr *remoteaddr = &sock->info.lsa->actual.dest.addr.sa;
+    struct sockaddr *localaddr = NULL;
     struct tls_multi *multi = c->c2.tls_multi;
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P mode the kernel automatically removes an existing peer
@@ -503,8 +504,12 @@ dco_p2p_add_new_peer(struct context *c)
         c->c2.tls_multi->dco_peer_id = -1;
     }
 #endif
+    if (sock->bind_local && sock->info.lsa->bind_local) {
+        localaddr = sock->info.lsa->bind_local->ai_addr;
+    }
+
     int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_sockets[0]->sd, NULL, remoteaddr, NULL, NULL);
+                           c->c2.link_sockets[0]->sd, localaddr, remoteaddr, NULL, NULL);
     if (ret < 0)
     {
         return ret;
@@ -550,7 +555,7 @@ dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
         {
             struct sockaddr_in *sock_in4 = (struct sockaddr_in *)local;
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            sock_in4->sin_addr = actual->pi.in4.ipi_addr;
+            sock_in4->sin_addr = actual->pi.in4.ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR)
             sock_in4->sin_addr = actual->pi.in4;
 #else
@@ -616,10 +621,15 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
         vpn_addr6 = &c->c2.push_ifconfig_ipv6_local;
     }
 
+    struct link_socket *ls = c->c2.link_sockets[0];
     if (dco_multi_get_localaddr(m, mi, &local))
     {
         localaddr = (struct sockaddr *)&local;
     }
+    else if (ls->bind_local && ls->info.lsa->bind_local)
+    {
+        localaddr = ls->info.lsa->bind_local->ai_addr;
+    }
 
     int ret = dco_new_peer(&c->c1.tuntap->dco, peer_id, sd, localaddr,
                            remoteaddr, vpn_addr4, vpn_addr6);
-- 
2.43.0


