From: Antonio Quartulli <a@...2181...>
Date: Sun, 30 Dec 2018 21:28:59 +1000
Message-Id: <20181230112901.29241-3-a@...2181...>
In-Reply-To: <20181230112901.29241-1-a@...2181...>
References: <20181230112901.29241-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] socket: introduce INDIRECT transport
 protocol abstraction
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
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>

From: Robin Tarsiger <rtt@...2484...>

This new transport protocol is used to tell the core code that traffic
should not be directly processed, but should rather be rerouted to a
transport plugin. It is basically an abstraction as it does not say tell
the code how to process the data, but simply forces its redirection to
the external code.

Signed-off-by: Robin Tarsiger <rtt@...2484...>
[antonio@...515...: refactored commits, restyled code]
---
 src/openvpn/forward.c   |   5 ++
 src/openvpn/socket.c    | 146 ++++++++++++++++++++++++++++++++++++++--
 src/openvpn/socket.h    |  70 +++++++++++++++++++
 src/openvpn/transport.h |   5 ++
 4 files changed, 222 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0a90fff0..a7092c7e 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2150,6 +2150,11 @@ io_wait_dowork(struct context *c, const unsigned int flags)
             {
                 int i;
                 c->c2.event_set_status = 0;
+#ifdef ENABLE_PLUGIN
+                c->c2.event_set_status |=
+                    (socket_indirect_pump(c->c2.link_socket, esr, &status) & 3)
+                        << socket_shift;
+#endif
                 for (i = 0; i < status; ++i)
                 {
                     const struct event_set_return *e = &esr[i];
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index db944245..b548ab7a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "forward.h"
+#include "transport.h"
 
 #include "memdbg.h"
 
@@ -49,6 +50,9 @@ const int proto_overhead[] = { /* indexed by PROTO_x */
     IPv4_UDP_HEADER_SIZE, /* IPv4 */
     IPv4_TCP_HEADER_SIZE,
     IPv4_TCP_HEADER_SIZE,
+#ifdef ENABLE_PLUGIN
+    INDIRECT_HEADER_SIZE,
+#endif
     IPv6_UDP_HEADER_SIZE, /* IPv6 */
     IPv6_TCP_HEADER_SIZE,
     IPv6_TCP_HEADER_SIZE,
@@ -1103,9 +1107,46 @@ bind_local(struct link_socket *sock, const sa_family_t ai_family)
     }
 }
 
+#ifdef ENABLE_PLUGIN
+
+static void
+create_socket_indirect(struct link_socket *sock, sa_family_t ai_family)
+{
+    struct addrinfo *bind_addresses = NULL;
+    if (sock->bind_local)
+    {
+        bind_addresses = sock->info.lsa->bind_local;
+    }
+
+    sock->indirect = transport_bind(sock->info.plugins,
+                                    sock->info.transport_plugin_argv,
+                                    ai_family,
+                                    bind_addresses);
+}
+
+bool
+proto_is_indirect(int proto)
+{
+    return proto == PROTO_INDIRECT;
+}
+
+#else  /* ifdef ENABLE_PLUGIN */
+
+static void
+create_socket_indirect(struct link_socket *sock, sa_family_t ai_family)
+{
+}
+
+#endif  /* ENABLE_PLUGIN */
+
 static void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
+    if (proto_is_indirect(sock->info.proto))
+    {
+        create_socket_indirect(sock, addr->ai_family);
+    }
+
     if (addr->ai_protocol == IPPROTO_UDP || addr->ai_socktype == SOCK_DGRAM)
     {
         sock->sd = create_socket_udp(addr, sock->sockflags);
@@ -2279,7 +2320,11 @@ link_socket_init_phase2(struct link_socket *sock,
         }
 
         /* If socket has not already been created create it now */
-        if (sock->sd == SOCKET_UNDEFINED)
+        if (sock->sd == SOCKET_UNDEFINED
+#ifdef ENABLE_PLUGIN
+            && !sock->indirect
+#endif
+            )
         {
             /* If we have no --remote and have still not figured out the
              * protocol family to use we will use the first of the bind */
@@ -2300,7 +2345,11 @@ link_socket_init_phase2(struct link_socket *sock,
         }
 
         /* Socket still undefined, give a warning and abort connection */
-        if (sock->sd == SOCKET_UNDEFINED)
+        if (sock->sd == SOCKET_UNDEFINED
+#ifdef ENABLE_PLUGIN
+            && !sock->indirect
+#endif
+            )
         {
             msg(M_WARN, "Could not determine IPv4/IPv6 protocol");
             sig_info->signal_received = SIGUSR1;
@@ -2338,7 +2387,10 @@ link_socket_init_phase2(struct link_socket *sock,
         }
     }
 
-    phase2_set_socket_flags(sock);
+    if (sock->sd != SOCKET_UNDEFINED)
+    {
+        phase2_set_socket_flags(sock);
+    }
     linksock_print_addr(sock);
 
 done:
@@ -2362,6 +2414,14 @@ link_socket_close(struct link_socket *sock)
         const int gremlin = 0;
 #endif
 
+#ifdef ENABLE_PLUGIN
+        if (sock->indirect)
+        {
+            sock->indirect->vtab->close(sock->indirect);
+            sock->indirect = NULL;
+        }
+#endif
+
         if (socket_defined(sock->sd))
         {
 #ifdef _WIN32
@@ -3143,16 +3203,25 @@ static const struct proto_names proto_names[] = {
     {"tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER},
     {"tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT},
     {"tcp",        "TCP", AF_UNSPEC, PROTO_TCP},
+#ifdef ENABLE_PLUGIN
+    {"indirect", "INDIRECT", AF_UNSPEC, PROTO_INDIRECT},
+#endif
     /* force IPv4 */
     {"udp4",       "UDPv4", AF_INET, PROTO_UDP},
     {"tcp4-server","TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
     {"tcp4-client","TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
     {"tcp4",       "TCPv4", AF_INET, PROTO_TCP},
+#ifdef ENABLE_PLUGIN
+    {"indirect4", "INDIRECT_IPv4", AF_INET, PROTO_INDIRECT},
+#endif
     /* force IPv6 */
     {"udp6","UDPv6", AF_INET6, PROTO_UDP},
     {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
     {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
     {"tcp6","TCPv6", AF_INET6, PROTO_TCP},
+#ifdef ENABLE_PLUGIN
+    {"indirect6", "INDIRECT_IPv6", AF_INET6, PROTO_INDIRECT},
+#endif
 };
 
 bool
@@ -3167,6 +3236,10 @@ proto_is_net(int proto)
 bool
 proto_is_dgram(int proto)
 {
+    if (proto_is_indirect(proto))
+    {
+        return true;
+    }
     return proto_is_udp(proto);
 }
 
@@ -3301,6 +3374,18 @@ proto_remote(int proto, bool remote)
         return "TCPv4_CLIENT";
     }
 
+#ifdef ENABLE_PLUGIN
+    if (proto == PROTO_INDIRECT)
+    {
+        /* FIXME: the string reported here should match the actual transport
+         * protocol being used, however in this function we have no knowledge of
+         * what protocol is exactly being used by the transport-plugin.
+         * Therefore we simply return INDIRECT for now.
+         */
+        return "INDIRECT";
+    }
+#endif
+
     ASSERT(0);
     return ""; /* Make the compiler happy */
 }
@@ -3360,6 +3445,29 @@ link_socket_read_tcp(struct link_socket *sock,
     }
 }
 
+#ifdef ENABLE_PLUGIN
+
+int
+link_socket_read_indirect(struct link_socket *sock,
+                          struct buffer *buf,
+                          struct link_socket_actual *from)
+{
+    ASSERT(sock->indirect);
+    socklen_t fromlen = sizeof(from->dest.addr);
+    socklen_t expectedlen = af_addr_size(sock->info.af);
+    addr_zero_host(&from->dest);
+    int len = transport_read(sock->indirect, buf,
+                             &from->dest.addr.sa, &fromlen);
+    if (len >= 0 && expectedlen && fromlen != expectedlen)
+    {
+        bad_address_length(fromlen, expectedlen);
+    }
+
+    return buf->len = len;
+}
+
+#endif  /* ENABLE_PLUGIN */
+
 #ifndef _WIN32
 
 #if ENABLE_IP_PKTINFO
@@ -3492,6 +3600,21 @@ link_socket_write_tcp(struct link_socket *sock,
 #endif
 }
 
+#ifdef ENABLE_PLUGIN
+
+int
+link_socket_write_indirect(struct link_socket *sock,
+                           struct buffer *buf,
+                           struct link_socket_actual *to)
+{
+    ASSERT(sock->indirect);
+    struct sockaddr *addr = (struct sockaddr *) &to->dest.addr.sa;
+    socklen_t addrlen = (socklen_t) af_addr_size(to->dest.addr.sa.sa_family);
+    return transport_write(sock->indirect, buf, addr, addrlen);
+}
+
+#endif  /* ENABLE_PLUGIN */
+
 #if ENABLE_IP_PKTINFO
 
 size_t
@@ -3580,6 +3703,12 @@ link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
 int
 socket_recv_queue(struct link_socket *sock, int maxsize)
 {
+    if (proto_is_indirect(sock->info.proto))
+    {
+        /* Indirect handler will take care of this, so do nothing. */
+        return IOSTATE_QUEUED;
+    }
+
     if (sock->reads.iostate == IOSTATE_INITIAL)
     {
         WSABUF wsabuf[1];
@@ -3952,7 +4081,16 @@ socket_set(struct link_socket *s,
         /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
         if (!persistent || *persistent != rwflags)
         {
-            event_ctl(es, socket_event_handle(s), rwflags, arg);
+#ifdef ENABLE_PLUGIN
+            if (s->indirect)
+            {
+                transport_request_events(s->indirect, es, rwflags);
+            }
+            else
+#endif
+            {
+                event_ctl(es, socket_event_handle(s), rwflags, arg);
+            }
             if (persistent)
             {
                 *persistent = rwflags;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index f49e6315..73a4ab6f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -34,6 +34,7 @@
 #include "proxy.h"
 #include "socks.h"
 #include "misc.h"
+#include "transport.h"
 
 /*
  * OpenVPN's default port number as assigned by IANA.
@@ -115,6 +116,7 @@ struct link_socket_info
     bool connection_established;
     const char *ipchange_command;
     const struct plugin_list *plugins;
+    const char **transport_plugin_argv;
     bool remote_float;
     int proto;                  /* Protocol (PROTO_x defined below) */
     sa_family_t af;                     /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
@@ -175,6 +177,11 @@ struct link_socket
     struct rw_handle listen_handle; /* For listening on TCP socket in server mode */
 #endif
 
+#ifdef ENABLE_PLUGIN
+    /* only valid when info.proto == PROTO_INDIRECT */
+    openvpn_transport_socket_t indirect;
+#endif
+
     /* used for printing status info only */
     unsigned int rwflags_debug;
 
@@ -1049,12 +1056,53 @@ int link_socket_read_udp_posix(struct link_socket *sock,
 
 #endif
 
+#ifdef ENABLE_PLUGIN
+
+int link_socket_read_indirect(struct link_socket *sock,
+                              struct buffer *buf,
+                              struct link_socket_actual *from);
+
+int link_socket_write_indirect(struct link_socket *sock,
+                               struct buffer *buf,
+                               struct link_socket_actual *from);
+
+bool proto_is_indirect(int proto);
+
+#else  /* ifdef ENABLE_PLUGIN */
+
+static int
+link_socket_read_indirect(struct link_socket *sock,
+                          struct buffer *buf, struct link_socket_actual *from)
+{
+    return -1;
+}
+
+static int
+link_socket_write_indirect(struct link_socket *sock,
+                           struct buffer *buf, struct link_socket_actual *from)
+{
+    return -1;
+}
+
+static bool
+proto_is_indirect(int proto)
+{
+    return false;
+}
+
+#endif  /* ENABLE_PLUGIN */
+
 /* read a TCP or UDP packet from link */
 static inline int
 link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
+    if (proto_is_indirect(sock->info.proto))
+    {
+        return link_socket_read_indirect(sock, buf, from);
+    }
+
     if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
     {
         int res;
@@ -1169,6 +1217,11 @@ link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
 {
+    if (proto_is_indirect(sock->info.proto))
+    {
+        return link_socket_write_indirect(sock, buf, to);
+    }
+
     if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
     {
         return link_socket_write_udp(sock, buf, to);
@@ -1264,6 +1317,23 @@ socket_reset_listen_persistent(struct link_socket *s)
 #endif
 }
 
+#ifdef ENABLE_PLUGIN
+
+static inline unsigned
+socket_indirect_pump(struct link_socket *s, struct event_set_return *esr, int *esrlen)
+{
+    if (s->indirect)
+    {
+        return transport_pump(s->indirect, esr, esrlen);
+    }
+    else
+    {
+        return 0;
+    }
+}
+
+#endif  /* ENABLE_PLUGIN */
+
 const char *socket_stat(const struct link_socket *s, unsigned int rwflags, struct gc_arena *gc);
 
 #endif /* SOCKET_H */
diff --git a/src/openvpn/transport.h b/src/openvpn/transport.h
index 344ce44b..37050eaf 100644
--- a/src/openvpn/transport.h
+++ b/src/openvpn/transport.h
@@ -27,6 +27,11 @@
 #include "plugin.h"
 #include "openvpn-transport.h"
 
+/* INDIRECT does not have any overhead per se, but it depends on what is
+ * implemented by the transport plugin
+ */
+#define INDIRECT_HEADER_SIZE    0
+
 /* Given a list of plugins and an argument list for a desired
  * transport plugin instance, prepare to bind new link sockets using
  * that transport plugin and args. If all succeeds, return true, and:
-- 
2.19.2


