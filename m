From: Gert Doering <gert@...1296...>
Date: Fri, 14 Nov 2025 12:50:22 +0100
Message-ID: <20251114115029.17432-1-gert@...1296...>
In-Reply-To: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
References: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] recursive routing: fixes and clean-ups
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

 - get rid of atoi() for getting the remote transport port.
 It doesn't change, so no point to do in on every packet.
 In addition, atoi() breaks when we use service names as ports.

 - ensure we correctly handle IPv4 headers with options

 - directly use buf parameter in place of c->c2.buf

GitHub: #902

Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1377
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1377
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index aa1f858..90e52d2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1382,15 +1382,24 @@
 
     struct openvpn_sockaddr *link_addr = &c->c2.to_link_addr->dest;
     struct link_socket_info *lsi = get_link_socket_info(c);
-    uint16_t link_port = atoi(c->c2.link_sockets[0]->remote_port);
 
     int ip_hdr_offset = 0;
-    int tun_ip_ver = get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.buf, &ip_hdr_offset);
+    int tun_ip_ver = get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), buf, &ip_hdr_offset);
 
     if (tun_ip_ver == 4)
     {
-        /* make sure we got whole IP header and TCP/UDP src/dst ports */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset + sizeof(uint16_t) * 2))
+        /* Ensure we can safely read the IPv4 header */
+        const int min_ip_header = ip_hdr_offset + sizeof(struct openvpn_iphdr);
+        if (BLEN(buf) < min_ip_header)
+        {
+            return;
+        }
+
+        struct openvpn_iphdr *pip = (struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);
+        const int ip_hlen = OPENVPN_IPH_GET_LEN(pip->version_len);
+        /* Reject malformed or truncated headers */
+        if (ip_hlen < sizeof(struct openvpn_iphdr)
+            || BLEN(buf) < (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t) * 2))
         {
             return;
         }
@@ -1401,8 +1410,6 @@
             return;
         }
 
-        struct openvpn_iphdr *pip = (struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);
-
         /* skip if tun protocol doesn't match link protocol */
         if ((lsi->proto == PROTO_TCP && pip->protocol != OPENVPN_IPPROTO_TCP)
             || (lsi->proto == PROTO_UDP && pip->protocol != OPENVPN_IPPROTO_UDP))
@@ -1410,9 +1417,10 @@
             return;
         }
 
-
         /* drop packets with same dest addr and port as remote */
-        uint8_t *l4_hdr = (uint8_t *)pip + sizeof(struct openvpn_iphdr);
+        uint8_t *l4_hdr = (uint8_t *)pip + ip_hlen;
+
+        uint16_t link_port = ntohs(link_addr->addr.in4.sin_port);
 
         /* TCP and UDP ports are at the same place in the header, and other protocols
          * can not happen here due to the lsi->proto check above */
@@ -1420,7 +1428,7 @@
         uint16_t dst_port = ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));
         if ((memcmp(&link_addr->addr.in4.sin_addr.s_addr, &pip->daddr, sizeof(pip->daddr)) == 0) && (link_port == dst_port))
         {
-            c->c2.buf.len = 0;
+            buf->len = 0;
 
             struct gc_arena gc = gc_new();
             msg(D_LOW, "Recursive routing detected, packet dropped %s:%" PRIu16 " -> %s",
@@ -1433,7 +1441,8 @@
     else if (tun_ip_ver == 6)
     {
         /* make sure we got whole IPv6 header and TCP/UDP src/dst ports */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset + sizeof(uint16_t) * 2))
+        const int min_ipv6 = ip_hdr_offset + sizeof(struct openvpn_ipv6hdr) + sizeof(uint16_t) * 2;
+        if (BLEN(buf) < min_ipv6)
         {
             return;
         }
@@ -1453,13 +1462,15 @@
             return;
         }
 
+        uint16_t link_port = ntohs(link_addr->addr.in6.sin6_port);
+
         /* drop packets with same dest addr and port as remote */
         uint8_t *l4_hdr = (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);
         uint16_t src_port = ntohs(*(uint16_t *)l4_hdr);
         uint16_t dst_port = ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));
         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr.in6.sin6_addr, &pip6->daddr)) && (link_port == dst_port))
         {
-            c->c2.buf.len = 0;
+            buf->len = 0;
 
             struct gc_arena gc = gc_new();
             msg(D_LOW, "Recursive routing detected, packet dropped %s:%" PRIu16 " -> %s",

