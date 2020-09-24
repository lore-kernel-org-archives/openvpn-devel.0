From: Vladislav Grishenko <themiron@...2010...>
Date: Thu, 24 Sep 2020 14:10:04 +0500
Message-Id: <20200924091004.29065-1-themiron@...2010...>
In-Reply-To: <0175aef6-8f4c-c482-12d7-189c677085ab@...2181...>
References: <0175aef6-8f4c-c482-12d7-189c677085ab@...2181...>
Subject: [Openvpn-devel] [PATCH v7] Selectively reformat too long lines
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

Per https://community.openvpn.net/openvpn/wiki/CodeStyle the maximum line
length is 80 characters. This patch allows to split upcoming changes into
CodeStyle-conformant (w/o real code change) and more feature-specific.
Upcoming changes adds new PROTO_AUTO, so existing proto_names array is
reformatted as well.

v7: prefer line breaks before long string parameters
    reformat proto_names array

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/init.c    |  3 +-
 src/openvpn/options.c | 80 +++++++++++++++++++++++++++++--------------
 src/openvpn/socket.c  | 52 +++++++++++++++++-----------
 3 files changed, 89 insertions(+), 46 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d1ad5c8f..31ecadcc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3646,7 +3646,8 @@ do_close_link_socket(struct context *c)
           && ( (c->options.persist_remote_ip)
                ||
                ( c->sig->source != SIG_SOURCE_HARD
-                 && ((c->c1.link_socket_addr.current_remote && c->c1.link_socket_addr.current_remote->ai_next)
+                 && ((c->c1.link_socket_addr.current_remote
+                      && c->c1.link_socket_addr.current_remote->ai_next)
                      || c->options.no_advance))
                )))
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4b22d3d9..92f446e7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1983,7 +1983,8 @@ connection_entry_load_re(struct connection_entry *ce, const struct remote_entry
 }
 
 static void
-options_postprocess_verify_ce(const struct options *options, const struct connection_entry *ce)
+options_postprocess_verify_ce(const struct options *options,
+                              const struct connection_entry *ce)
 {
     struct options defaults;
     int dev = DEV_TYPE_UNDEF;
@@ -2011,7 +2012,9 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
      */
     if (ce->proto == PROTO_TCP)
     {
-        msg(M_USAGE, "--proto tcp is ambiguous in this context.  Please specify --proto tcp-server or --proto tcp-client");
+        msg(M_USAGE,
+            "--proto tcp is ambiguous in this context. Please specify "
+            "--proto tcp-server or --proto tcp-client");
     }
 
     /*
@@ -2051,8 +2054,9 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
     if (options->inetd)
     {
-        msg(M_WARN, "DEPRECATED OPTION: --inetd mode is deprecated "
-            "and will be removed in OpenVPN 2.6");
+        msg(M_WARN,
+            "DEPRECATED OPTION: --inetd mode is deprecated and will be removed "
+            "in OpenVPN 2.6");
     }
 
     if (options->lladdr && dev != DEV_TYPE_TAP)
@@ -2065,7 +2069,9 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
      */
     if (options->ce.tun_mtu_defined && options->ce.link_mtu_defined)
     {
-        msg(M_USAGE, "only one of --tun-mtu or --link-mtu may be defined (note that --ifconfig implies --link-mtu %d)", LINK_MTU_DEFAULT);
+        msg(M_USAGE,
+            "only one of --tun-mtu or --link-mtu may be defined (note that "
+            "--ifconfig implies --link-mtu %d)", LINK_MTU_DEFAULT);
     }
 
     if (!proto_is_udp(ce->proto) && options->mtu_test)
@@ -2092,18 +2098,23 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     if (string_defined_equal(ce->remote, options->ifconfig_local)
         || string_defined_equal(ce->remote, options->ifconfig_remote_netmask))
     {
-        msg(M_USAGE, "--local and --remote addresses must be distinct from --ifconfig addresses");
+        msg(M_USAGE,
+            "--local and --remote addresses must be distinct from --ifconfig "
+            "addresses");
     }
 
     if (string_defined_equal(ce->local, options->ifconfig_local)
         || string_defined_equal(ce->local, options->ifconfig_remote_netmask))
     {
-        msg(M_USAGE, "--local addresses must be distinct from --ifconfig addresses");
+        msg(M_USAGE,
+            "--local addresses must be distinct from --ifconfig addresses");
     }
 
-    if (string_defined_equal(options->ifconfig_local, options->ifconfig_remote_netmask))
+    if (string_defined_equal(options->ifconfig_local,
+                             options->ifconfig_remote_netmask))
     {
-        msg(M_USAGE, "local and remote/netmask --ifconfig addresses must be different");
+        msg(M_USAGE,
+            "local and remote/netmask --ifconfig addresses must be different");
     }
 
     if (ce->bind_defined && !ce->bind_local)
@@ -2113,12 +2124,14 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
     if (ce->local && !ce->bind_local)
     {
-        msg(M_USAGE, "--local and --nobind don't make sense when used together");
+        msg(M_USAGE,
+            "--local and --nobind don't make sense when used together");
     }
 
     if (ce->local_port_defined && !ce->bind_local)
     {
-        msg(M_USAGE, "--lport and --nobind don't make sense when used together");
+        msg(M_USAGE,
+            "--lport and --nobind don't make sense when used together");
     }
 
     if (!ce->remote && !ce->bind_local)
@@ -2207,7 +2220,8 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
     if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
     {
-        msg(M_USAGE, "--explicit-exit-notify can only be used with --proto udp");
+        msg(M_USAGE,
+            "--explicit-exit-notify can only be used with --proto udp");
     }
 
     if (!ce->remote && ce->proto == PROTO_TCP_CLIENT)
@@ -2217,16 +2231,21 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
     if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
     {
-        msg(M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
+        msg(M_USAGE,
+            "--http-proxy MUST be used in TCP Client mode (i.e. --proto "
+            "tcp-client)");
     }
+
     if ((ce->http_proxy_options) && !ce->http_proxy_options->server)
     {
-        msg(M_USAGE, "--http-proxy not specified but other http proxy options present");
+        msg(M_USAGE,
+            "--http-proxy not specified but other http proxy options present");
     }
 
     if (ce->http_proxy_options && ce->socks_proxy_server)
     {
-        msg(M_USAGE, "--http-proxy can not be used together with --socks-proxy");
+        msg(M_USAGE,
+            "--http-proxy can not be used together with --socks-proxy");
     }
 
     if (ce->socks_proxy_server && ce->proto == PROTO_TCP_SERVER)
@@ -2292,8 +2311,9 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--socks-proxy cannot be used with --mode server");
         }
-        /* <connection> blocks force to have a remote embedded, so we check for the
-         * --remote and bail out if it  is present */
+        /* <connection> blocks force to have a remote embedded, so we check
+         * for the --remote and bail out if it is present
+         */
         if (options->connection_list->len >1
             || options->connection_list->array[0]->remote)
         {
@@ -2310,12 +2330,15 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         }
         if (options->ipchange)
         {
-            msg(M_USAGE, "--ipchange cannot be used with --mode server (use --client-connect instead)");
+            msg(M_USAGE,
+                "--ipchange cannot be used with --mode server (use "
+                "--client-connect instead)");
         }
         if (!(proto_is_dgram(ce->proto) || ce->proto == PROTO_TCP_SERVER))
         {
-            msg(M_USAGE, "--mode server currently only supports "
-                "--proto udp or --proto tcp-server or --proto tcp6-server");
+            msg(M_USAGE,
+                "--mode server currently only supports --proto udp or --proto "
+                "tcp-server or --proto tcp6-server");
         }
         if (!proto_is_udp(ce->proto) && (options->cf_max || options->cf_per))
         {
@@ -2817,12 +2840,14 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     }
 #endif
 
-    if (ce->proto == PROTO_TCP_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+    if (ce->proto == PROTO_TCP_CLIENT && !ce->local
+        && !ce->local_port_defined && !ce->bind_defined)
     {
         ce->bind_local = false;
     }
 
-    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local
+        && !ce->local_port_defined && !ce->bind_defined)
     {
         ce->bind_local = false;
     }
@@ -2832,7 +2857,9 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         ce->local_port = NULL;
     }
 
-    /* if protocol forcing is enabled, disable all protocols except for the forced one */
+    /* if protocol forcing is enabled, disable all protocols
+     * except for the forced one
+     */
     if (o->proto_force >= 0 && o->proto_force != ce->proto)
     {
         ce->flags |= CE_DISABLED;
@@ -5690,7 +5717,9 @@ add_option(struct options *options,
                 const sa_family_t af = ascii2af(p[3]);
                 if (proto < 0)
                 {
-                    msg(msglevel, "remote: bad protocol associated with host %s: '%s'", p[1], p[3]);
+                    msg(msglevel,
+                        "remote: bad protocol associated with host %s: '%s'",
+                        p[1], p[3]);
                     goto err;
                 }
                 re.proto = proto;
@@ -6210,7 +6239,8 @@ add_option(struct options *options,
         af = ascii2af(p[1]);
         if (proto < 0)
         {
-            msg(msglevel, "Bad protocol: '%s'.  Allowed protocols with --proto option: %s",
+            msg(msglevel,
+                "Bad protocol: '%s'. Allowed protocols with --proto option: %s",
                 p[1],
                 proto2ascii_all(&gc));
             goto err;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 76bdbfc5..679b8485 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -378,7 +378,8 @@ do_preresolve(struct context *c)
         /* HTTP remote hostname does not need to be resolved */
         if (!ce->http_proxy_options)
         {
-            status = do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
+            status = do_preresolve_host(c, remote, ce->remote_port,
+                                        ce->af, flags);
             if (status != 0)
             {
                 goto err;
@@ -417,7 +418,8 @@ do_preresolve(struct context *c)
         {
             flags |= GETADDR_PASSIVE;
             flags &= ~GETADDR_RANDOMIZE;
-            status = do_preresolve_host(c, ce->local, ce->local_port, ce->af, flags);
+            status = do_preresolve_host(c, ce->local, ce->local_port,
+                                        ce->af, flags);
             if (status != 0)
             {
                 goto err;
@@ -526,7 +528,9 @@ openvpn_getaddrinfo(unsigned int flags,
         if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
             && !resolve_retry_seconds)
         {
-            fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s) (I would have retried this name query if you had specified the --resolv-retry option.)";
+            fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s) "
+                  "(I would have retried this name query if you had "
+                  "specified the --resolv-retry option.)";
         }
 
         if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
@@ -558,11 +562,13 @@ openvpn_getaddrinfo(unsigned int flags,
         while (true)
         {
 #ifndef _WIN32
+            /* force resolv.conf reload */
             res_init();
 #endif
             /* try hostname lookup */
             hints.ai_flags &= ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
+            dmsg(D_SOCKET_DEBUG,
+                 "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
                  flags, hints.ai_family, hints.ai_socktype);
             status = getaddrinfo(hostname, servname, &hints, res);
 
@@ -573,7 +579,9 @@ openvpn_getaddrinfo(unsigned int flags,
                 {
                     if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
                     {
-                        msg(level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
+                        msg(level,
+                            "RESOLVE: Ignored SIGUSR1 signal received during "
+                            "DNS resolution attempt");
                         *signal_received = 0;
                     }
                     else
@@ -634,7 +642,9 @@ openvpn_getaddrinfo(unsigned int flags,
         /* IP address parse succeeded */
         if (flags & GETADDR_RANDOMIZE)
         {
-            msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the hostname is an IP address");
+            msg(M_WARN,
+                "WARNING: ignoring --remote-random-hostname because the "
+                "hostname is an IP address");
         }
     }
 
@@ -1802,7 +1812,8 @@ resolve_remote(struct link_socket *sock,
                 sock->info.lsa->remote_list = ai;
                 sock->info.lsa->current_remote = ai;
 
-                dmsg(D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
+                dmsg(D_SOCKET_DEBUG,
+                     "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
                      flags,
                      phase,
                      retry,
@@ -3155,22 +3166,22 @@ struct proto_names {
 
 /* Indexed by PROTO_x */
 static const struct proto_names proto_names[] = {
-    {"proto-uninitialized",        "proto-NONE", AF_UNSPEC, PROTO_NONE},
+    {"proto-uninitialized", "proto-NONE", AF_UNSPEC, PROTO_NONE},
     /* try IPv4 and IPv6 (client), bind dual-stack (server) */
-    {"udp",        "UDP", AF_UNSPEC, PROTO_UDP},
-    {"tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER},
-    {"tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT},
-    {"tcp",        "TCP", AF_UNSPEC, PROTO_TCP},
+    {"udp",         "UDP", AF_UNSPEC, PROTO_UDP},
+    {"tcp-server",  "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER},
+    {"tcp-client",  "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT},
+    {"tcp",         "TCP", AF_UNSPEC, PROTO_TCP},
     /* force IPv4 */
-    {"udp4",       "UDPv4", AF_INET, PROTO_UDP},
-    {"tcp4-server","TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
-    {"tcp4-client","TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
-    {"tcp4",       "TCPv4", AF_INET, PROTO_TCP},
+    {"udp4",        "UDPv4", AF_INET, PROTO_UDP},
+    {"tcp4-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
+    {"tcp4-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
+    {"tcp4",        "TCPv4", AF_INET, PROTO_TCP},
     /* force IPv6 */
-    {"udp6","UDPv6", AF_INET6, PROTO_UDP},
-    {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
-    {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
-    {"tcp6","TCPv6", AF_INET6, PROTO_TCP},
+    {"udp6",        "UDPv6", AF_INET6, PROTO_UDP},
+    {"tcp6-server", "TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
+    {"tcp6-client", "TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
+    {"tcp6",        "TCPv6", AF_INET6, PROTO_TCP},
 };
 
 bool
@@ -3182,6 +3193,7 @@ proto_is_net(int proto)
     }
     return proto != PROTO_NONE;
 }
+
 bool
 proto_is_dgram(int proto)
 {
-- 
2.17.1


