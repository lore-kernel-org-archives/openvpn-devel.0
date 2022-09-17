From: Antonio Quartulli <a@...2181...>
Date: Sat, 17 Sep 2022 23:47:56 +0200
Message-Id: <20220917214756.23630-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Implement the --passtos option for IPv6
 packets and sockets
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
Cc: "Vittorio Gambaletta (VittGam)" <github@...2696...>

From: "Vittorio Gambaletta (VittGam)" <github@...2696...>

Signed-off-by: "Vittorio Gambaletta (VittGam)" <github@...2696...>
---
 src/openvpn/forward.c | 18 ++++++++++++-----
 src/openvpn/forward.h |  2 +-
 src/openvpn/multi.c   |  2 +-
 src/openvpn/options.c |  2 +-
 src/openvpn/socket.h  | 45 +++++++++++++++++++++++++++++++++++--------
 src/openvpn/syshead.h |  2 +-
 6 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b8950e37..3526dbf6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1346,7 +1346,7 @@ process_incoming_tun(struct context *c)
          * The --passtos and --mssfix options require
          * us to examine the IP header (IPv4 or IPv6).
          */
-        unsigned int flags = PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT
+        unsigned int flags = PIP_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT
                              | PIPV6_IMCP_NOHOST_CLIENT;
         process_ip_header(c, flags, &c->c2.buf);
 
@@ -1518,7 +1518,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
 #if PASSTOS_CAPABILITY
     if (!c->options.passtos)
     {
-        flags &= ~PIPV4_PASSTOS;
+        flags &= ~PIP_PASSTOS;
     }
 #endif
     if (!c->options.client_nat)
@@ -1543,7 +1543,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
 
         if (flags & (PIP_MSSFIX
 #if PASSTOS_CAPABILITY
-                     | PIPV4_PASSTOS
+                     | PIP_PASSTOS
 #endif
                      | PIPV4_CLIENT_NAT
                      ))
@@ -1553,9 +1553,9 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
             {
 #if PASSTOS_CAPABILITY
                 /* extract TOS from IP header */
-                if (flags & PIPV4_PASSTOS)
+                if (flags & PIP_PASSTOS)
                 {
-                    link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+                    link_socket_extract_tos_v4(c->c2.link_socket, &ipbuf);
                 }
 #endif
 
@@ -1583,6 +1583,14 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
             }
             else if (is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
             {
+#if PASSTOS_CAPABILITY
+                /* extract TOS from IPiv6 header */
+                if (flags & PIP_PASSTOS)
+                {
+                    link_socket_extract_tos_v6(c->c2.link_socket, &ipbuf);
+                }
+#endif
+
                 /* possibly alter the TCP MSS */
                 if (flags & PIP_MSSFIX)
                 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index bd2d9601..e3bb7945 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -291,7 +291,7 @@ send_control_channel_string_dowork(struct tls_multi *multi,
  */
 void reschedule_multi_process(struct context *c);
 
-#define PIPV4_PASSTOS                   (1<<0)
+#define PIP_PASSTOS                     (1<<0)
 #define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
 #define PIP_OUTGOING                    (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1bbeab7d..3f3d79bb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3573,7 +3573,7 @@ multi_get_queue(struct mbuf_set *ms)
 
     if (mbuf_extract_item(ms, &item)) /* cleartext IP packet */
     {
-        unsigned int pip_flags = PIPV4_PASSTOS | PIPV6_IMCP_NOHOST_SERVER;
+        unsigned int pip_flags = PIP_PASSTOS | PIPV6_IMCP_NOHOST_SERVER;
 
         set_prefix(item.instance);
         item.instance->context.c2.buf = item.buffer->buf;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2786c28b..3d48c2d9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -276,7 +276,7 @@ static const char usage_message[] =
     "--persist-local-ip  : Keep local IP address across SIGUSR1 or --ping-restart.\n"
     "--persist-key   : Don't re-read key files across SIGUSR1 or --ping-restart.\n"
 #if PASSTOS_CAPABILITY
-    "--passtos       : TOS passthrough (applies to IPv4 only).\n"
+    "--passtos       : TOS passthrough.\n"
 #endif
     "--tun-mtu n     : Take the tun/tap device MTU to be n and derive the\n"
     "                  TCP/UDP MTU from it (default=%d).\n"
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 462afa31..ca4b3381 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1209,17 +1209,35 @@ link_socket_write(struct link_socket *sock,
 #if PASSTOS_CAPABILITY
 
 /*
- * Extract TOS bits.  Assumes that ipbuf is a valid IPv4 packet.
+ * Extract TOS bits. Assumes that ipbuf is a valid IPv4 packet.
  */
 static inline void
-link_socket_extract_tos(struct link_socket *ls, const struct buffer *ipbuf)
+link_socket_extract_tos_v4(struct link_socket *ls, const struct buffer *ipbuf)
 {
-    if (ls && ipbuf)
+    if (!ls || !ipbuf)
     {
-        struct openvpn_iphdr *iph = (struct openvpn_iphdr *) BPTR(ipbuf);
-        ls->ptos = iph->tos;
-        ls->ptos_defined = true;
+        return;
     }
+
+    struct openvpn_iphdr *iph = (struct openvpn_iphdr *) BPTR(ipbuf);
+    ls->ptos = iph->tos;
+    ls->ptos_defined = true;
+}
+
+/*
+ * Extract TOS bits. Assumes that ipbuf is a valid IPv6 packet.
+ */
+static inline void
+link_socket_extract_tos_v6(struct link_socket *ls, const struct buffer *ipbuf)
+{
+    if (!ls || !ipbuf)
+    {
+        return;
+    }
+
+    struct openvpn_ipv6hdr *ip6h = (struct openvpn_ipv6hdr *)BPTR(ipbuf);
+    ls->ptos = ((ip6h->version_prio & 0x0F) << 4) | (ip6h->flow_lbl[0] >> 4);
+    ls->ptos_defined = true;
 }
 
 /*
@@ -1229,9 +1247,20 @@ link_socket_extract_tos(struct link_socket *ls, const struct buffer *ipbuf)
 static inline void
 link_socket_set_tos(struct link_socket *ls)
 {
-    if (ls && ls->ptos_defined)
+    if (!ls || !ls->ptos_defined)
+    {
+        return;
+    }
+
+    if (ls->info.af == AF_INET6)
+    {
+        setsockopt(ls->sd, IPPROTO_IPV6, IPV6_TCLASS, (const void *)&ls->ptos,
+                   sizeof(ls->ptos));
+    }
+    else
     {
-        setsockopt(ls->sd, IPPROTO_IP, IP_TOS, (const void *)&ls->ptos, sizeof(ls->ptos));
+        setsockopt(ls->sd, IPPROTO_IP, IP_TOS, (const void *)&ls->ptos,
+                   sizeof(ls->ptos));
     }
 }
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 5a673a7b..e04f454f 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -362,7 +362,7 @@ typedef int MIB_TCP_STATE;
 /*
  * Do we have the capability to support the --passtos option?
  */
-#if defined(IPPROTO_IP) && defined(IP_TOS)
+#if defined(IPPROTO_IP) && defined(IP_TOS) && defined(IPPROTO_IPV6) && defined(IPV6_TCLASS)
 #define PASSTOS_CAPABILITY 1
 #else
 #define PASSTOS_CAPABILITY 0
-- 
2.35.1


