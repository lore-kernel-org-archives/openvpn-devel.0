From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 24 Sep 2025 17:10:44 +0200
Message-Id: <20250924151044.50567-1-frank@...2641...>
In-Reply-To: <gerrit.1758038466000.I28f856c1c156b54089d95b2e2539ecdb374cdd37@...2715...>
References: <gerrit.1758038466000.I28f856c1c156b54089d95b2e2539ecdb374cdd37@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] dco: Change sd argument to dco_new_peer
 from int to socket_descriptor_t
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
Cc: Antonio Quartulli <antonio@...2726...>

Doesn't change anything for non-Win32 platforms.

Change-Id: I28f856c1c156b54089d95b2e2539ecdb374cdd37
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1195
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1195
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2cf90af..6afc680 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -491,11 +491,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 dco_p2p_add_new_peer(struct context *c)
 {
@@ -604,7 +599,7 @@
     int peer_id = c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr = NULL;
     struct sockaddr_storage local = { 0 };
-    int sd = c->c2.link_sockets[0]->sd;
+    const socket_descriptor_t sd = c->c2.link_sockets[0]->sd;
 
 
     if (c->mode == CM_CHILD_TCP)
@@ -650,10 +645,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *addr)
 {
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 83013ef..86af003 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -59,7 +59,7 @@
  * They are implemented by dco_linux.c
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
                  struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9e52859..fc9551d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -415,10 +415,10 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
+dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
              struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, __func__, peerid, sd);
 
     if (dco->ifmode == DCO_MODE_P2P)
     {

