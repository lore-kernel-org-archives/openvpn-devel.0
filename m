From: Gert Doering <gert@...1296...>
Date: Sat, 11 Oct 2025 13:44:42 +0200
Message-ID: <20251011114448.14501-1-gert@...1296...>
In-Reply-To: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
References: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Make recursive routing check more
 fine-grained
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

From: Lev Stipakov <lev@...515...>

The existing recursive routing check drops TUN packets
if their address matches the remote. While this works in
most cases, a more fine-grained check is preferable for
complex routing rules.

Since we only need to drop traffic originating from OpenVPN,
all of the following values must match between the packet
and the link:

 - IP protocol
 - Transport protocol (TCP/UDP)
 - Destination address
 - Destination port

GitHub: #699

Change-Id: I6841e2f2a85275254a04e2d8ae3defe4420db8f6
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/903
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/903
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f342958..79a6fc7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1391,73 +1391,99 @@
 static void
 drop_if_recursive_routing(struct context *c, struct buffer *buf)
 {
-    bool drop = false;
-    struct openvpn_sockaddr tun_sa;
-    int ip_hdr_offset = 0;
-
     if (c->c2.to_link_addr == NULL) /* no remote addr known */
     {
         return;
     }
 
-    tun_sa = c->c2.to_link_addr->dest;
+    struct openvpn_sockaddr *link_addr = &c->c2.to_link_addr->dest;
+    struct link_socket_info *lsi = get_link_socket_info(c);
+    uint16_t link_port = atoi(c->c2.link_sockets[0]->remote_port);
 
-    int proto_ver = get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.buf, &ip_hdr_offset);
+    int ip_hdr_offset = 0;
+    int tun_ip_ver = get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.buf, &ip_hdr_offset);
 
-    if (proto_ver == 4)
+    if (tun_ip_ver == 4)
     {
-        /* make sure we got whole IP header */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset))
+        /* make sure we got whole IP header and TCP/UDP src/dst ports */
+        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset + sizeof(uint16_t) * 2))
         {
             return;
         }
 
         /* skip ipv4 packets for ipv6 tun */
-        if (tun_sa.addr.sa.sa_family != AF_INET)
+        if (link_addr->addr.sa.sa_family != AF_INET)
         {
             return;
         }
 
         struct openvpn_iphdr *pip = (struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);
 
-        /* drop packets with same dest addr as gateway */
-        if (memcmp(&tun_sa.addr.in4.sin_addr.s_addr, &pip->daddr, sizeof(pip->daddr)) == 0)
+        /* skip if tun protocol doesn't match link protocol */
+        if ((lsi->proto == PROTO_TCP && pip->protocol != OPENVPN_IPPROTO_TCP)
+            || (lsi->proto == PROTO_UDP && pip->protocol != OPENVPN_IPPROTO_UDP))
         {
-            drop = true;
+            return;
+        }
+
+
+        /* drop packets with same dest addr and port as remote */
+        uint8_t *l4_hdr = (uint8_t *)pip + sizeof(struct openvpn_iphdr);
+
+        /* TCP and UDP ports are at the same place in the header, and other protocols
+         * can not happen here due to the lsi->proto check above */
+        uint16_t src_port = ntohs(*(uint16_t *)l4_hdr);
+        uint16_t dst_port = ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));
+        if ((memcmp(&link_addr->addr.in4.sin_addr.s_addr, &pip->daddr, sizeof(pip->daddr)) == 0) && (link_port == dst_port))
+        {
+            c->c2.buf.len = 0;
+
+            struct gc_arena gc = gc_new();
+            msg(D_LOW, "Recursive routing detected, packet dropped %s:%" PRIu16 " -> %s",
+                print_in_addr_t(pip->saddr, IA_NET_ORDER, &gc),
+                src_port,
+                print_link_socket_actual(c->c2.to_link_addr, &gc));
+            gc_free(&gc);
         }
     }
-    else if (proto_ver == 6)
+    else if (tun_ip_ver == 6)
     {
-        /* make sure we got whole IPv6 header */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset))
+        /* make sure we got whole IPv6 header and TCP/UDP src/dst ports */
+        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset + sizeof(uint16_t) * 2))
         {
             return;
         }
 
         /* skip ipv6 packets for ipv4 tun */
-        if (tun_sa.addr.sa.sa_family != AF_INET6)
+        if (link_addr->addr.sa.sa_family != AF_INET6)
         {
             return;
         }
 
         struct openvpn_ipv6hdr *pip6 = (struct openvpn_ipv6hdr *)(BPTR(buf) + ip_hdr_offset);
 
-        /* drop packets with same dest addr as gateway */
-        if (OPENVPN_IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
+        /* skip if tun protocol doesn't match link protocol */
+        if ((lsi->proto == PROTO_TCP && pip6->nexthdr != OPENVPN_IPPROTO_TCP)
+            || (lsi->proto == PROTO_UDP && pip6->nexthdr != OPENVPN_IPPROTO_UDP))
         {
-            drop = true;
+            return;
         }
-    }
 
-    if (drop)
-    {
-        struct gc_arena gc = gc_new();
+        /* drop packets with same dest addr and port as remote */
+        uint8_t *l4_hdr = (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);
+        uint16_t src_port = ntohs(*(uint16_t *)l4_hdr);
+        uint16_t dst_port = ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));
+        if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr.in6.sin6_addr, &pip6->daddr)) && (link_port == dst_port))
+        {
+            c->c2.buf.len = 0;
 
-        c->c2.buf.len = 0;
-
-        msg(D_LOW, "Recursive routing detected, drop tun packet to %s",
-            print_link_socket_actual(c->c2.to_link_addr, &gc));
-        gc_free(&gc);
+            struct gc_arena gc = gc_new();
+            msg(D_LOW, "Recursive routing detected, packet dropped %s:%" PRIu16 " -> %s",
+                print_in6_addr(pip6->saddr, IA_NET_ORDER, &gc),
+                src_port,
+                print_link_socket_actual(c->c2.to_link_addr, &gc));
+            gc_free(&gc);
+        }
     }
 }
 

