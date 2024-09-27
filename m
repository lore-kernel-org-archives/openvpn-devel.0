From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 27 Sep 2024 11:30:45 +0200
Message-Id: <20240927093045.22753-1-frank@...2641...>
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] dco: better naming for function
 parameters
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
Cc: Lev Stipakov <lev@...515...>, Antonio Quartulli <a@...2181...>

From: Lev Stipakov <lev@...515...>

Current naming (remote_in4/6) is confusing, since
those are in fact VPN IPv4/v6 addresses and not
related to remote at all.

Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/769
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 9a90f5c..c92e42a 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -75,7 +75,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl;
@@ -95,15 +95,15 @@
         nvlist_add_nvlist(nvl, "remote", sockaddr_to_nvlist(remoteaddr));
     }
 
-    if (remote_in4)
+    if (vpn_ipv4)
     {
-        nvlist_add_binary(nvl, "vpn_ipv4", &remote_in4->s_addr,
-                          sizeof(remote_in4->s_addr));
+        nvlist_add_binary(nvl, "vpn_ipv4", &vpn_ipv4->s_addr,
+                          sizeof(vpn_ipv4->s_addr));
     }
 
-    if (remote_in6)
+    if (vpn_ipv6)
     {
-        nvlist_add_binary(nvl, "vpn_ipv6", remote_in6, sizeof(*remote_in6));
+        nvlist_add_binary(nvl, "vpn_ipv6", vpn_ipv6, sizeof(*vpn_ipv6));
     }
 
     nvlist_add_number(nvl, "fd", sd);
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 624c110..4bbcc82 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -62,7 +62,7 @@
 
 int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
                  struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-                 struct in_addr *remote_in4, struct in6_addr *remote_in6);
+                 struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 277cd64..b038382 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -220,7 +220,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     struct gc_arena gc = gc_new();
     const char *remotestr = "[undefined]";
@@ -263,14 +263,14 @@
     }
 
     /* Set the primary VPN IP addresses of the peer */
-    if (remote_in4)
+    if (vpn_ipv4)
     {
-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vpn_ipv4->s_addr);
     }
-    if (remote_in6)
+    if (vpn_ipv6)
     {
         NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
-                remote_in6);
+                vpn_ipv6);
     }
     nla_nest_end(nl_msg, attr);
 
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 892c616..9224bca 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -247,7 +247,7 @@
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+             struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
     return 0;

