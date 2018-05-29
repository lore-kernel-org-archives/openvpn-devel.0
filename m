From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 29 May 2018 12:55:07 +0300
Message-Id: <1527587707-21417-1-git-send-email-lev@...515...>
Subject: [Openvpn-devel] [PATCH] Improve "recursive routing" warning
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
Cc: Lev Stipakov <lev@...515...>

- print protocol, source/dest addresses and ports
- mention "--allow-recursive-routing"
- add possible usecase to manpage

Trac #843

Signed-off-by: Lev Stipakov <lev@...515...>
---
 doc/openvpn.8         |  4 ++-
 src/openvpn/forward.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 4114f40..262d4ea 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4072,7 +4072,9 @@ notifications unless this option is enabled.
 .TP
 .B \-\-allow\-recursive\-routing
 When this option is set, OpenVPN will not drop incoming tun packets
-with same destination as host.
+with same destination as host. Could be useful when packets sent by openvpn
+itself are not subject to the routing tables that would move packets
+into the tunnel.
 .\"*********************************************************
 .SS Data Channel Encryption Options:
 These options are meaningful for both Static & TLS\-negotiated key modes
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7d9a338..77a9084 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1068,7 +1068,7 @@ read_incoming_tun(struct context *c)
 /**
  * Drops UDP packets which OS decided to route via tun.
  *
- * On Windows and OS X when netwotk adapter is disabled or
+ * On Windows and OS X when network adapter is disabled or
  * disconnected, platform starts to use tun as external interface.
  * When packet is sent to tun, it comes to openvpn, encapsulated
  * and sent to routing table, which sends it again to tun.
@@ -1080,6 +1080,11 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
     struct openvpn_sockaddr tun_sa;
     int ip_hdr_offset = 0;
 
+    uint32_t saddr, daddr;
+    struct in6_addr saddr6, daddr6;
+    uint16_t sport, dport;
+    uint8_t protocol;
+
     if (c->c2.to_link_addr == NULL) /* no remote addr known */
     {
         return;
@@ -1105,12 +1110,38 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
             return;
         }
 
-        pip = (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
+        pip = (const struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
 
-        /* drop packets with same dest addr as gateway */
+        /* drop packets with the same dest addr as gateway */
         if (tun_sa.addr.in4.sin_addr.s_addr == pip->daddr)
         {
             drop = true;
+
+            /* collect information for warning message */
+            sport = 0;
+            dport = 0;
+
+            saddr = ntohl(pip->saddr);
+            daddr = ntohl(pip->daddr);
+            protocol = pip->protocol;
+
+            /* whole packet? */
+            if (BLEN(buf) == (ip_hdr_offset + (int) (ntohs(pip->tot_len))))
+            {
+              const uint8_t *payload = BPTR(buf) + ip_hdr_offset + sizeof(struct openvpn_iphdr);
+
+              if (protocol == OPENVPN_IPPROTO_UDP)
+              {
+                const struct openvpn_udphdr *udp = (const struct openvpn_udphdr *) payload;
+                sport = ntohs(udp->source);
+                dport = ntohs(udp->dest);
+              } else if (protocol == OPENVPN_IPPROTO_TCP)
+              {
+                const struct openvpn_tcphdr *tcp = (const struct openvpn_tcphdr *) payload;
+                sport = ntohs(tcp->source);
+                dport = ntohs(tcp->dest);
+              }
+            }
         }
     }
     else if (proto_ver == 6)
@@ -1129,22 +1160,68 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
             return;
         }
 
-        /* drop packets with same dest addr as gateway */
+        /* drop packets with the same dest addr as gateway */
         pip6 = (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);
         if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
         {
             drop = true;
+
+            /* collect information for warning message */
+            sport = 0;
+            dport = 0;
+
+            saddr6 = pip6->saddr;
+            daddr6 = pip6->daddr;
+            protocol = pip6->nexthdr;
+
+            /* whole packet? */
+            if (BLEN(buf) == ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset + (int) ntohs(pip6->payload_len)))
+            {
+              const uint8_t *payload = BPTR(buf) + ip_hdr_offset + sizeof(struct openvpn_ipv6hdr);
+
+              if (protocol == OPENVPN_IPPROTO_UDP)
+              {
+                const struct openvpn_udphdr *udp = (const struct openvpn_udphdr *) payload;
+                sport = ntohs(udp->source);
+                dport = ntohs(udp->dest);
+              } else if (protocol == OPENVPN_IPPROTO_TCP)
+              {
+                const struct openvpn_tcphdr *tcp = (const struct openvpn_tcphdr *) payload;
+                sport = ntohs(tcp->source);
+                dport = ntohs(tcp->dest);
+              }
+            }
         }
     }
 
     if (drop)
     {
         struct gc_arena gc = gc_new();
+        struct buffer addrs_buf = alloc_buf_gc(128, &gc);
 
+        /* drop packet */
         c->c2.buf.len = 0;
 
-        msg(D_LOW, "Recursive routing detected, drop tun packet to %s",
-            print_link_socket_actual(c->c2.to_link_addr, &gc));
+        if (protocol == OPENVPN_IPPROTO_UDP)
+          buf_printf(&addrs_buf, "%s", "UDP");
+        else if (protocol == OPENVPN_IPPROTO_TCP)
+          buf_printf(&addrs_buf, "%s", "TCP");
+        else
+          buf_printf(&addrs_buf, "%d", protocol);
+
+        if (proto_ver == 4)
+        {
+          buf_printf(&addrs_buf, " %s:%d -> %s:%d",
+                     print_in_addr_t(saddr, 0, &gc), sport,
+                     print_in_addr_t(daddr, 0, &gc), dport);
+        } else if (proto_ver == 6)
+        {
+           buf_printf(&addrs_buf, " %s:%d -> %s:%d",
+                     print_in6_addr(saddr6, 0, &gc), sport,
+                     print_in6_addr(daddr6, 0, &gc), dport);
+        }
+
+        msg(D_LOW, "Recursive routing detected, drop packet %s. Fix your routing or consider using --allow-recursive-routing option.", BSTR(&addrs_buf));
         gc_free(&gc);
     }
 }
-- 
2.7.4


