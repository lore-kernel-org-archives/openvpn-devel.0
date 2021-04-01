From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:37 +0200
Message-Id: <20210401131337.3684-15-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 14/14] Remove do_init_socket_2 and
 do_init_socket_1 wrapper function
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

These two function basically just pass a number of fields of context to
the linit_socket_init1/2 functions. This wrapper add little to no value
in understanding the code, especially since the linit_socket_init1 will
just copy them to yet another structure.

Remove these wrapper functions and pass context directly to the called
function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c   |  60 +-----------------------
 src/openvpn/socket.c | 109 +++++++++++++++++++------------------------
 src/openvpn/socket.h |  40 ++--------------
 3 files changed, 52 insertions(+), 157 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 98cc1ebe9..d6dd8675c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3339,62 +3339,6 @@ do_link_socket_new(struct context *c)
     c->c2.link_socket_owned = true;
 }
 
-/*
- * bind the TCP/UDP socket
- */
-static void
-do_init_socket_1(struct context *c, const int mode)
-{
-    unsigned int sockflags = c->options.sockflags;
-
-#if PORT_SHARE
-    if (c->options.port_share_host && c->options.port_share_port)
-    {
-        sockflags |= SF_PORT_SHARE;
-    }
-#endif
-
-    link_socket_init_phase1(c->c2.link_socket,
-                            c->options.ce.local,
-                            c->options.ce.local_port,
-                            c->options.ce.remote,
-                            c->options.ce.remote_port,
-                            c->c1.dns_cache,
-                            c->options.ce.proto,
-                            c->options.ce.af,
-                            c->options.ce.bind_ipv6_only,
-                            mode,
-                            c->c2.accept_from,
-                            c->c1.http_proxy,
-                            c->c1.socks_proxy,
-#ifdef ENABLE_DEBUG
-                            c->options.gremlin,
-#endif
-                            c->options.ce.bind_local,
-                            c->options.ce.remote_float,
-                            &c->c1.link_socket_addr,
-                            c->options.ipchange,
-                            c->plugins,
-                            c->options.resolve_retry_seconds,
-                            c->options.ce.mtu_discover_type,
-                            c->options.rcvbuf,
-                            c->options.sndbuf,
-                            c->options.mark,
-                            c->options.bind_dev,
-                            &c->c2.server_poll_interval,
-                            sockflags);
-}
-
-/*
- * finalize the TCP/UDP socket
- */
-static void
-do_init_socket_2(struct context *c)
-{
-    link_socket_init_phase2(c->c2.link_socket, &c->c2.frame,
-                            c->sig);
-}
-
 /*
  * Print MTU INFO
  */
@@ -4255,7 +4199,7 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     /* bind the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     {
-        do_init_socket_1(c, link_socket_mode);
+        link_socket_init_phase1(c, link_socket_mode);
     }
 
     /* initialize tun/tap device object,
@@ -4299,7 +4243,7 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     /* finalize the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     {
-        do_init_socket_2(c);
+        link_socket_init_phase2(c);
     }
 
     /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6fed4b660..6bb107de6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1876,77 +1876,60 @@ link_socket_new(void)
 }
 
 void
-link_socket_init_phase1(struct link_socket *sock,
-                        const char *local_host,
-                        const char *local_port,
-                        const char *remote_host,
-                        const char *remote_port,
-                        struct cached_dns_entry *dns_cache,
-                        int proto,
-                        sa_family_t af,
-                        bool bind_ipv6_only,
-                        int mode,
-                        const struct link_socket *accept_from,
-                        struct http_proxy_info *http_proxy,
-                        struct socks_proxy_info *socks_proxy,
-#ifdef ENABLE_DEBUG
-                        int gremlin,
-#endif
-                        bool bind_local,
-                        bool remote_float,
-                        struct link_socket_addr *lsa,
-                        const char *ipchange_command,
-                        const struct plugin_list *plugins,
-                        int resolve_retry_seconds,
-                        int mtu_discover_type,
-                        int rcvbuf,
-                        int sndbuf,
-                        int mark,
-                        const char *bind_dev,
-                        struct event_timeout *server_poll_timeout,
-                        unsigned int sockflags)
+link_socket_init_phase1(struct context *c, int mode)
 {
+    struct link_socket *sock = c->c2.link_socket;
+    struct options *o = &c->options;
     ASSERT(sock);
 
-    sock->local_host = local_host;
-    sock->local_port = local_port;
+    const char *remote_host = o->ce.remote;
+    const char *remote_port = o->ce.remote_port;
+
+    sock->local_host = o->ce.local;
+    sock->local_port = o->ce.local_port;
     sock->remote_host = remote_host;
     sock->remote_port = remote_port;
-    sock->dns_cache = dns_cache;
-    sock->http_proxy = http_proxy;
-    sock->socks_proxy = socks_proxy;
-    sock->bind_local = bind_local;
-    sock->resolve_retry_seconds = resolve_retry_seconds;
-    sock->mtu_discover_type = mtu_discover_type;
+    sock->dns_cache = c->c1.dns_cache;
+    sock->http_proxy = c->c1.http_proxy;
+    sock->socks_proxy = c->c1.socks_proxy;
+    sock->bind_local = o->ce.bind_local;
+    sock->resolve_retry_seconds = o->resolve_retry_seconds;
+    sock->mtu_discover_type = o->ce.mtu_discover_type;
 
 #ifdef ENABLE_DEBUG
-    sock->gremlin = gremlin;
+    sock->gremlin = o->gremlin;
 #endif
 
-    sock->socket_buffer_sizes.rcvbuf = rcvbuf;
-    sock->socket_buffer_sizes.sndbuf = sndbuf;
+    sock->socket_buffer_sizes.rcvbuf = o->rcvbuf;
+    sock->socket_buffer_sizes.sndbuf = o->sndbuf;
 
-    sock->sockflags = sockflags;
-    sock->mark = mark;
-    sock->bind_dev = bind_dev;
-
-    sock->info.proto = proto;
-    sock->info.af = af;
-    sock->info.remote_float = remote_float;
-    sock->info.lsa = lsa;
-    sock->info.bind_ipv6_only = bind_ipv6_only;
-    sock->info.ipchange_command = ipchange_command;
-    sock->info.plugins = plugins;
-    sock->server_poll_timeout = server_poll_timeout;
+    sock->sockflags = o->sockflags;
+#if PORT_SHARE
+    if (o->port_share_host && o->port_share_port)
+    {
+        sock->sockflags |= SF_PORT_SHARE;
+    }
+#endif
+    sock->mark = o->mark;
+    sock->bind_dev = o->bind_dev;
+
+    sock->info.proto = o->ce.proto;
+    sock->info.af = o->ce.af;
+    sock->info.remote_float = o->ce.remote_float;
+    sock->info.lsa = &c->c1.link_socket_addr;
+    sock->info.bind_ipv6_only = o->ce.bind_ipv6_only;
+    sock->info.ipchange_command = o->ipchange;
+    sock->info.plugins = c->plugins;
+    sock->server_poll_timeout = &c->c2.server_poll_interval;
 
     sock->mode = mode;
     if (mode == LS_MODE_TCP_ACCEPT_FROM)
     {
-        ASSERT(accept_from);
+        ASSERT(c->c2.accept_from);
         ASSERT(sock->info.proto == PROTO_TCP_SERVER);
-        sock->sd = accept_from->sd;
+        sock->sd = c->c2.accept_from->sd;
         /* inherit (possibly guessed) info AF from parent context */
-        sock->info.af = accept_from->info.af;
+        sock->info.af = c->c2.accept_from->info.af;
     }
 
     /* are we running in HTTP proxy mode? */
@@ -1955,8 +1938,8 @@ link_socket_init_phase1(struct link_socket *sock,
         ASSERT(sock->info.proto == PROTO_TCP_CLIENT);
 
         /* the proxy server */
-        sock->remote_host = http_proxy->options.server;
-        sock->remote_port = http_proxy->options.port;
+        sock->remote_host = c->c1.http_proxy->options.server;
+        sock->remote_port = c->c1.http_proxy->options.port;
 
         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host = remote_host;
@@ -1966,8 +1949,8 @@ link_socket_init_phase1(struct link_socket *sock,
     else if (sock->socks_proxy)
     {
         /* the proxy server */
-        sock->remote_host = socks_proxy->server;
-        sock->remote_port = socks_proxy->port;
+        sock->remote_host = c->c1.socks_proxy->server;
+        sock->remote_port = c->c1.socks_proxy->port;
 
         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host = remote_host;
@@ -2188,10 +2171,12 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
 
 /* finalize socket initialization */
 void
-link_socket_init_phase2(struct link_socket *sock,
-                        const struct frame *frame,
-                        struct signal_info *sig_info)
+link_socket_init_phase2(struct context *c)
 {
+    struct link_socket *sock = c->c2.link_socket;
+    const struct frame *frame = &c->c2.frame;
+    struct signal_info *sig_info = c->sig;
+
     const char *remote_dynamic = NULL;
     int sig_save = 0;
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index d58fda4d3..6a86ee054 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -292,43 +292,9 @@ int openvpn_connect(socket_descriptor_t sd,
 /*
  * Initialize link_socket object.
  */
-/* *INDENT-OFF* uncrustify misparses this function declarion because of
- * embedded #if/#endif tell it to skip this section */
-void
-link_socket_init_phase1(struct link_socket *sock,
-                        const char *local_host,
-                        const char *local_port,
-                        const char *remote_host,
-                        const char *remote_port,
-                        struct cached_dns_entry *dns_cache,
-                        int proto,
-                        sa_family_t af,
-                        bool bind_ipv6_only,
-                        int mode,
-                        const struct link_socket *accept_from,
-                        struct http_proxy_info *http_proxy,
-                        struct socks_proxy_info *socks_proxy,
-#ifdef ENABLE_DEBUG
-                        int gremlin,
-#endif
-                        bool bind_local,
-                        bool remote_float,
-                        struct link_socket_addr *lsa,
-                        const char *ipchange_command,
-                        const struct plugin_list *plugins,
-                        int resolve_retry_seconds,
-                        int mtu_discover_type,
-                        int rcvbuf,
-                        int sndbuf,
-                        int mark,
-                        const char *bind_dev,
-                        struct event_timeout *server_poll_timeout,
-                        unsigned int sockflags);
-/* Reenable uncrustify *INDENT-ON* */
-
-void link_socket_init_phase2(struct link_socket *sock,
-                             const struct frame *frame,
-                             struct signal_info *sig_info);
+void link_socket_init_phase1(struct context *c, int mode);
+
+void link_socket_init_phase2(struct context *c);
 
 void do_preresolve(struct context *c);
 
-- 
2.30.1


