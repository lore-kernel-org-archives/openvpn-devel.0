From: Arne Schwabe <arne@...1227...>
Date: Sat, 23 Nov 2013 20:57:04 +0100
Message-Id: <1385236624-3776-1-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-3-git-send-email-arne@...1227...>
References: <1385064495-25877-3-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Split the PROTO_UDP_xx options into
	AF_INET/AF_INET6 and PROTO_TCP/PROTO_UDP part.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Splitting will make the code a little bit cleaner and prepares for dual stack

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/error.c   |   6 +-
 src/openvpn/forward.c |   8 +--
 src/openvpn/init.c    |  21 +++---
 src/openvpn/options.c |  73 ++++++++++----------
 src/openvpn/options.h |   2 +
 src/openvpn/socket.c  | 180 +++++++++++++++++++++++---------------------------
 src/openvpn/socket.h  |  21 +++---
 src/openvpn/socks.c   |   2 +-
 8 files changed, 145 insertions(+), 168 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6848425..4a0418a 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -602,7 +602,7 @@ x_check_status (int status,
   const char *extended_msg = NULL;
 
   msg (x_cs_verbose_level, "%s %s returned %d",
-       sock ? proto2ascii (sock->info.proto, true) : "",
+       sock ? proto2ascii (sock->info.proto, sock->info.af, true) : "",
        description,
        status);
 
@@ -630,14 +630,14 @@ x_check_status (int status,
 	  if (extended_msg)
 	    msg (x_cs_info_level, "%s %s [%s]: %s (code=%d)",
 		 description,
-		 sock ? proto2ascii (sock->info.proto, true) : "",
+		 sock ? proto2ascii (sock->info.proto, sock->info.af, true) : "",
 		 extended_msg,
 		 strerror_ts (my_errno, &gc),
 		 my_errno);
 	  else
 	    msg (x_cs_info_level, "%s %s: %s (code=%d)",
 		 description,
-		 sock ? proto2ascii (sock->info.proto, true) : "",
+		 sock ? proto2ascii (sock->info.proto, sock->info.af, true) : "",
 		 strerror_ts (my_errno, &gc),
 		 my_errno);
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 447b86d..9fcae11 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -620,7 +620,7 @@ check_timeout_random_component (struct context *c)
 static inline void
 socks_postprocess_incoming_link (struct context *c)
 {
-  if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDPv4)
+  if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDP)
     socks_process_incoming_udp (&c->c2.buf, &c->c2.from);
 }
 
@@ -629,7 +629,7 @@ socks_preprocess_outgoing_link (struct context *c,
 				struct link_socket_actual **to_addr,
 				int *size_delta)
 {
-  if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDPv4)
+  if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDP)
     {
       *size_delta += socks_process_outgoing_udp (&c->c2.to_link, c->c2.to_link_addr);
       *to_addr = &c->c2.link_socket->socks_relay;
@@ -778,7 +778,7 @@ process_incoming_link (struct context *c)
     fprintf (stderr, "R");
 #endif
   msg (D_LINK_RW, "%s READ [%d] from %s: %s",
-       proto2ascii (lsi->proto, true),
+       proto2ascii (lsi->proto, lsi->af, true),
        BLEN (&c->c2.buf),
        print_link_socket_actual (&c->c2.from, &gc),
        PROTO_DUMP (&c->c2.buf, &gc));
@@ -1122,7 +1122,7 @@ process_outgoing_link (struct context *c)
 	    fprintf (stderr, "W");
 #endif
 	  msg (D_LINK_RW, "%s WRITE [%d] to %s: %s",
-	       proto2ascii (c->c2.link_socket->info.proto, true),
+	       proto2ascii (c->c2.link_socket->info.proto, c->c2.link_socket->info.proto, true),
 	       BLEN (&c->c2.to_link),
 	       print_link_socket_actual (c->c2.to_link_addr, &gc),
 	       PROTO_DUMP (&c->c2.to_link, &gc));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 41ff038..676a7fe 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -131,9 +131,7 @@ management_callback_proxy_cmd (void *arg, const char **p)
           msg (M_WARN, "HTTP proxy support is not available");
 #else
           struct http_proxy_options *ho;
-          if (ce->proto != PROTO_TCPv4 && ce->proto != PROTO_TCPv4_CLIENT &&
-              ce->proto != PROTO_TCPv6 && ce->proto != PROTO_TCPv6_CLIENT)
-            {
+          if (ce->proto != PROTO_TCP && ce->proto != PROTO_TCP_CLIENT )            {
               msg (M_WARN, "HTTP proxy support only works for TCP based connections");
               return false;
             }
@@ -256,7 +254,7 @@ ce_management_query_remote (struct context *c, const char *remote_ip_hint)
   if (management)
     {
       struct buffer out = alloc_buf_gc (256, &gc);
-      buf_printf (&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port, proto2ascii(ce->proto, false));
+      buf_printf (&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port, proto2ascii(ce->proto, ce->af, false));
       management_notify_generic(management, BSTR (&out));
       ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK<<CE_MAN_QUERY_REMOTE_SHIFT);
       ce->flags |= (CE_MAN_QUERY_REMOTE_QUERY<<CE_MAN_QUERY_REMOTE_SHIFT);
@@ -1847,17 +1845,14 @@ socket_restart_pause (struct context *c)
 
   switch (c->options.ce.proto)
     {
-    case PROTO_UDPv4:
-    case PROTO_UDPv6:
+    case PROTO_UDP:
       if (proxy)
 	sec = c->options.ce.connect_retry_seconds;
       break;
-    case PROTO_TCPv4_SERVER:
-    case PROTO_TCPv6_SERVER:
+    case PROTO_TCP_SERVER:
       sec = 1;
       break;
-    case PROTO_TCPv4_CLIENT:
-    case PROTO_TCPv6_CLIENT:
+    case PROTO_TCP_CLIENT:
       sec = c->options.ce.connect_retry_seconds;
       break;
     }
@@ -2218,7 +2213,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 
   /* should we not xmit any packets until we get an initial
      response from client? */
-  if (to.server && options->ce.proto == PROTO_TCPv4_SERVER)
+  if (to.server && options->ce.proto == PROTO_TCP_SERVER)
     to.xmit_hold = true;
 
 #ifdef ENABLE_OCC
@@ -2675,6 +2670,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ce.remote,
 			   c->options.ce.remote_port,
 			   c->options.ce.proto,
+			   c->options.ce.af,
 			   mode,
 			   c->c2.accept_from,
 #ifdef ENABLE_HTTP_PROXY
@@ -3331,8 +3327,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
   /* link_socket_mode allows CM_CHILD_TCP
      instances to inherit acceptable fds
      from a top-level parent */
-  if (c->options.ce.proto == PROTO_TCPv4_SERVER
-      || c->options.ce.proto == PROTO_TCPv6_SERVER)
+  if (c->options.ce.proto == PROTO_TCP_SERVER)
     {
       if (c->mode == CM_TOP)
 	link_socket_mode = LS_MODE_TCP_LISTEN;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3d711fa..a42bf58 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -777,7 +777,8 @@ init_options (struct options *o, const bool init_gc)
     }
   o->mode = MODE_POINT_TO_POINT;
   o->topology = TOP_NET30;
-  o->ce.proto = PROTO_UDPv4;
+  o->ce.proto = PROTO_UDP;
+  o->ce.af = AF_INET;
   o->ce.connect_retry_seconds = 5;
   o->ce.connect_timeout = 10;
   o->ce.connect_retry_max = 0;
@@ -907,7 +908,7 @@ setenv_connection_entry (struct env_set *es,
 			 const struct connection_entry *e,
 			 const int i)
 {
-  setenv_str_i (es, "proto", proto2ascii (e->proto, false), i);
+  setenv_str_i (es, "proto", proto2ascii (e->proto, e->af, false), i);
   setenv_str_i (es, "local", e->local, i);
   setenv_str_i (es, "local_port", e->local_port, i);
   setenv_str_i (es, "remote", e->remote, i);
@@ -1358,7 +1359,7 @@ cnol_check_alloc (struct options *options)
 static void
 show_connection_entry (const struct connection_entry *o)
 {
-  msg (D_SHOW_PARMS, "  proto = %s", proto2ascii (o->proto, false));
+  msg (D_SHOW_PARMS, "  proto = %s", proto2ascii (o->proto, o->af, false));
   SHOW_STR (local);
   SHOW_STR (local_port);
   SHOW_STR (remote);
@@ -1733,7 +1734,7 @@ options_postprocess_http_proxy_override (struct options *o)
       for (i = 0; i < l->len; ++i)
 	{
 	  struct connection_entry *ce = l->array[i];
-	  if (ce->proto == PROTO_TCPv4_CLIENT || ce->proto == PROTO_TCPv4)
+	  if (ce->proto == PROTO_TCP_CLIENT || ce->proto == PROTO_TCP)
 	    {
 	      ce->http_proxy_options = o->http_proxy_override;
 	      succeed = true;
@@ -1744,7 +1745,7 @@ options_postprocess_http_proxy_override (struct options *o)
 	  for (i = 0; i < l->len; ++i)
 	    {
 	      struct connection_entry *ce = l->array[i];
-	      if (ce->proto == PROTO_UDPv4)
+	      if (ce->proto == PROTO_UDP)
 		{
 		  ce->flags |= CE_DISABLED;
 		}
@@ -1814,6 +1815,8 @@ connection_entry_load_re (struct connection_entry *ce, const struct remote_entry
     ce->remote_port = re->remote_port;
   if (re->proto >= 0)
     ce->proto = re->proto;
+  if (re->af > 0)
+    ce->af = re->af;
 }
 
 static void
@@ -1843,10 +1846,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
    * If "proto tcp" is specified, make sure we know whether it is
    * tcp-client or tcp-server.
    */
-  if (ce->proto == PROTO_TCPv4)
+  if (ce->proto == PROTO_TCP)
     msg (M_USAGE, "--proto tcp is ambiguous in this context.  Please specify --proto tcp-server or --proto tcp-client");
-  if (ce->proto == PROTO_TCPv6)
-    msg (M_USAGE, "--proto tcp6 is ambiguous in this context.  Please specify --proto tcp6-server or --proto tcp6-client");
 
   /*
    * Sanity check on daemon/inetd modes
@@ -1858,10 +1859,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
   if (options->inetd && (ce->local || ce->remote))
     msg (M_USAGE, "--local or --remote cannot be used with --inetd");
 
-  if (options->inetd && ce->proto == PROTO_TCPv4_CLIENT)
+  if (options->inetd && ce->proto == PROTO_TCP_CLIENT)
     msg (M_USAGE, "--proto tcp-client cannot be used with --inetd");
 
-  if (options->inetd == INETD_NOWAIT && ce->proto != PROTO_TCPv4_SERVER)
+  if (options->inetd == INETD_NOWAIT && ce->proto != PROTO_TCP_SERVER)
     msg (M_USAGE, "--inetd nowait can only be used with --proto tcp-server");
 
   if (options->inetd == INETD_NOWAIT
@@ -1882,13 +1883,11 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
    * Sanity check on TCP mode options
    */
 
-  if (ce->connect_retry_defined && ce->proto != PROTO_TCPv4_CLIENT
-      && ce->proto != PROTO_TCPv6_CLIENT)
+  if (ce->connect_retry_defined && ce->proto != PROTO_TCP_CLIENT)
     msg (M_USAGE, "--connect-retry doesn't make sense unless also used with "
 	 "--proto tcp-client or tcp6-client");
 
-  if (ce->connect_timeout_defined && ce->proto != PROTO_TCPv4_CLIENT
-      && ce->proto != PROTO_TCPv6_CLIENT)
+  if (ce->connect_timeout_defined && ce->proto != PROTO_TCP_CLIENT)
     msg (M_USAGE, "--connect-timeout doesn't make sense unless also used with "
 	 "--proto tcp-client or tcp6-client");
 
@@ -1987,12 +1986,11 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     msg (M_USAGE, "--explicit-exit-notify can only be used with --proto udp");
 #endif
 
-  if (!ce->remote && (ce->proto == PROTO_TCPv4_CLIENT 
-		      || ce->proto == PROTO_TCPv6_CLIENT))
+  if (!ce->remote && ce->proto == PROTO_TCP_CLIENT)
     msg (M_USAGE, "--remote MUST be used in TCP Client mode");
 
 #ifdef ENABLE_HTTP_PROXY
-  if ((ce->http_proxy_options) && ce->proto != PROTO_TCPv4_CLIENT)
+  if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
     msg (M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
 #endif
 
@@ -2002,12 +2000,11 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #endif
 
 #ifdef ENABLE_SOCKS
-  if (ce->socks_proxy_server && ce->proto == PROTO_TCPv4_SERVER)
+  if (ce->socks_proxy_server && ce->proto == PROTO_TCP_SERVER)
     msg (M_USAGE, "--socks-proxy can not be used in TCP Server mode");
 #endif
 
-  if ((ce->proto == PROTO_TCPv4_SERVER || ce->proto == PROTO_TCPv6_SERVER)
-      && connection_list_defined (options))
+  if (ce->proto == PROTO_TCP_SERVER && connection_list_defined (options))
     msg (M_USAGE, "TCP server mode allows at most one --remote address");
 
 #if P2MP_SERVER
@@ -2021,13 +2018,12 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--mode server only works with --dev tun or --dev tap");
       if (options->pull)
 	msg (M_USAGE, "--pull cannot be used with --mode server");
-      if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCPv4_SERVER
-	    || ce->proto == PROTO_TCPv6_SERVER))
+      if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
 	msg (M_USAGE, "--mode server currently only supports "
 	     "--proto udp or --proto tcp-server or proto tcp6-server");
 #if PORT_SHARE
       if ((options->port_share_host || options->port_share_port) && 
-	  (ce->proto != PROTO_TCPv4_SERVER && ce->proto != PROTO_TCPv6_SERVER))
+	  (ce->proto != PROTO_TCP_SERVER))
 	msg (M_USAGE, "--port-share only works in TCP server mode "
 	     "(--proto tcp-server or tcp6-server)");
 #endif
@@ -2057,8 +2053,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--inetd cannot be used with --mode server");
       if (options->ipchange)
 	msg (M_USAGE, "--ipchange cannot be used with --mode server (use --client-connect instead)");
-      if (!(proto_is_dgram(ce->proto) || ce->proto == PROTO_TCPv4_SERVER
-	    || ce->proto == PROTO_TCPv6_SERVER))
+      if (!(proto_is_dgram(ce->proto) || ce->proto == PROTO_TCP_SERVER))
 	msg (M_USAGE, "--mode server currently only supports "
 	     "--proto udp or --proto tcp-server or --proto tcp6-server");
       if (!proto_is_udp(ce->proto) && (options->cf_max || options->cf_per))
@@ -2367,27 +2362,23 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 #if P2MP_SERVER
   if (o->server_defined || o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
-      if (ce->proto == PROTO_TCPv4)
-	ce->proto = PROTO_TCPv4_SERVER;
-      else if (ce->proto == PROTO_TCPv6)
-	ce->proto = PROTO_TCPv6_SERVER;
+      if (ce->proto == PROTO_TCP)
+	ce->proto = PROTO_TCP_SERVER;
     }
 #endif
 #if P2MP
   if (o->client)
     {
-      if (ce->proto == PROTO_TCPv4)
-	ce->proto = PROTO_TCPv4_CLIENT;
-      else if (ce->proto == PROTO_TCPv6)
-	ce->proto = PROTO_TCPv6_CLIENT;
+      if (ce->proto == PROTO_TCP)
+	ce->proto = PROTO_TCP_CLIENT;
     }
 #endif
 
-  if (ce->proto == PROTO_TCPv4_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+  if (ce->proto == PROTO_TCP_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
     ce->bind_local = false;
 
 #ifdef ENABLE_SOCKS
-  if (ce->proto == PROTO_UDPv4 && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
+  if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
     ce->bind_local = false;
 #endif
 
@@ -2395,9 +2386,9 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
     ce->local_port = NULL;
 
   /* if protocol forcing is enabled, disable all protocols except for the forced one */
-  if (o->proto_force >= 0 && proto_is_tcp(o->proto_force) != proto_is_tcp(ce->proto))
+  if (o->proto_force >= 0 && o->proto_force != ce->proto)
     ce->flags |= CE_DISABLED;
-
+    
   /*
    * If --mssfix is supplied without a parameter, default
    * it to --fragment value, if --fragment is specified.
@@ -2914,7 +2905,7 @@ options_string (const struct options *o,
   buf_printf (&out, ",dev-type %s", dev_type_string (o->dev, o->dev_type));
   buf_printf (&out, ",link-mtu %d", EXPANDED_SIZE (frame));
   buf_printf (&out, ",tun-mtu %d", PAYLOAD_SIZE (frame));
-  buf_printf (&out, ",proto %s", proto2ascii (proto_remote (o->ce.proto, remote), true));
+  buf_printf (&out, ",proto %s", proto2ascii (proto_remote (o->ce.proto, remote),o->ce.af, true));
 
   /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
    * is usually pushed by the server, triggering a non-helpful warning
@@ -4464,6 +4455,7 @@ add_option (struct options *options,
       struct remote_entry re;
       re.remote = re.remote_port= NULL;
       re.proto = -1;
+      re.af=0;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       re.remote = p[1];
@@ -4473,12 +4465,14 @@ add_option (struct options *options,
 	  if (p[3])
 	    {
 	      const int proto = ascii2proto (p[3]);
+	      const sa_family_t af = ascii2af (p[3]);
 	      if (proto < 0)
 		{
 		  msg (msglevel, "remote: bad protocol associated with host %s: '%s'", p[1], p[3]);
 		  goto err;
 		}
 	      re.proto = proto;
+	      re.af = af;
 	    }
 	}
       if (permission_mask & OPT_P_GENERAL)
@@ -4916,8 +4910,10 @@ add_option (struct options *options,
   else if (streq (p[0], "proto") && p[1])
     {
       int proto;
+      sa_family_t af;
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       proto = ascii2proto (p[1]);
+      af = ascii2af(p[1]);
       if (proto < 0)
 	{
 	  msg (msglevel, "Bad protocol: '%s'.  Allowed protocols with --proto option: %s",
@@ -4926,6 +4922,7 @@ add_option (struct options *options,
 	  goto err;
 	}
       options->ce.proto = proto;
+      options->ce.af = af;
     }
   else if (streq (p[0], "proto-force") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 84a5910..659d05b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -87,6 +87,7 @@ struct options_pre_pull
 struct connection_entry
 {
   int proto;
+  sa_family_t af;
   const char* local_port;
   bool local_port_defined;
   const char* remote_port;
@@ -145,6 +146,7 @@ struct remote_entry
   const char *remote;
   const char *remote_port;
   int proto;
+  sa_family_t af;
 };
 
 #define CONNECTION_LIST_SIZE 64
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e4a964b..dddabca 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -717,7 +717,7 @@ static void
 create_socket (struct link_socket *sock)
 {
   /* create socket */
-  if (sock->info.proto == PROTO_UDPv4)
+  if (sock->info.proto == PROTO_UDP && sock->info.af == AF_INET)
     {
       sock->sd = create_socket_udp (sock->sockflags);
       sock->sockflags |= SF_GETADDRINFO_DGRAM;
@@ -727,17 +727,12 @@ create_socket (struct link_socket *sock)
 	sock->ctrl_sd = create_socket_tcp (AF_INET);
 #endif
     }
-  else if (sock->info.proto == PROTO_TCPv4_SERVER
-	   || sock->info.proto == PROTO_TCPv4_CLIENT)
+  else if (sock->info.proto == PROTO_TCP_SERVER
+	   || sock->info.proto == PROTO_TCP_CLIENT)
     {
-      sock->sd = create_socket_tcp (AF_INET);
+      sock->sd = create_socket_tcp (sock->info.af);
     }
-  else if (sock->info.proto == PROTO_TCPv6_SERVER
-	   || sock->info.proto == PROTO_TCPv6_CLIENT)
-    {
-      sock->sd = create_socket_tcp (AF_INET6);
-    }
-  else if (sock->info.proto == PROTO_UDPv6)
+  else if (sock->info.proto == PROTO_UDP && sock->info.af == AF_INET6)
     {
       sock->sd = create_socket_udp6 (sock->sockflags);
       sock->sockflags |= SF_GETADDRINFO_DGRAM;
@@ -1165,7 +1160,7 @@ resolve_bind_local (struct link_socket *sock)
       struct addrinfo *ai;
 
       /* may return AF_{INET|INET6} guessed from local_host */
-      const int af = addr_guess_family(sock->info.proto, sock->local_host);
+      const int af = addr_guess_family(sock->info.af, sock->local_host);
       status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE,
                                    sock->local_host, sock->local_port, 0, NULL, af, &ai);
       if(status ==0) {
@@ -1189,7 +1184,7 @@ resolve_bind_local (struct link_socket *sock)
   if (sock->bind_local)
     {
 #ifdef ENABLE_SOCKS
-      if (sock->socks_proxy && sock->info.proto == PROTO_UDPv4)
+      if (sock->socks_proxy && sock->info.proto == PROTO_UDP && sock->info.af == AF_INET)
           socket_bind (sock->ctrl_sd, &sock->info.lsa->local, "SOCKS");
       else
 #endif
@@ -1212,7 +1207,7 @@ resolve_remote (struct link_socket *sock,
       /* resolve remote address if undefined */
       if (!addr_defined (&sock->info.lsa->remote))
 	{
-          af = addr_guess_family(sock->info.proto, sock->remote_host);
+          af = addr_guess_family(sock->info.af, sock->remote_host);
           switch(af)
             {
               case AF_INET:
@@ -1340,6 +1335,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *remote_host,
 			 const char *remote_port,
 			 int proto,
+       sa_family_t af,
 			 int mode,
 			 const struct link_socket *accept_from,
 #ifdef ENABLE_HTTP_PROXY
@@ -1402,6 +1398,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->sockflags = sockflags;
 
   sock->info.proto = proto;
+  sock->info.af = af;
   sock->info.remote_float = remote_float;
   sock->info.lsa = lsa;
   sock->info.ipchange_command = ipchange_command;
@@ -1411,9 +1408,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   if (mode == LS_MODE_TCP_ACCEPT_FROM)
     {
       ASSERT (accept_from);
-      ASSERT (sock->info.proto == PROTO_TCPv4_SERVER
-	      || sock->info.proto == PROTO_TCPv6_SERVER
-	     );
+      ASSERT (sock->info.proto == PROTO_TCP_SERVER);
       ASSERT (!sock->inetd);
       sock->sd = accept_from->sd;
     }
@@ -1424,7 +1419,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   /* are we running in HTTP proxy mode? */
   else if (sock->http_proxy)
     {
-      ASSERT (sock->info.proto == PROTO_TCPv4_CLIENT);
+      ASSERT (sock->info.proto == PROTO_TCP_CLIENT && sock->info.af == AF_INET);
       ASSERT (!sock->inetd);
 
       /* the proxy server */
@@ -1440,7 +1435,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   /* or in Socks proxy mode? */
   else if (sock->socks_proxy)
     {
-      ASSERT (sock->info.proto == PROTO_TCPv4_CLIENT || sock->info.proto == PROTO_UDPv4);
+      ASSERT (sock->info.af == AF_INET);
       ASSERT (!sock->inetd);
 
       /* the proxy server */
@@ -1459,7 +1454,7 @@ link_socket_init_phase1 (struct link_socket *sock,
     }
 
   /* bind behavior for TCP server vs. client */
-  if (sock->info.proto == PROTO_TCPv4_SERVER)
+  if (sock->info.proto == PROTO_TCP_SERVER && sock->info.af==AF_INET)
     {
       if (sock->mode == LS_MODE_TCP_ACCEPT_FROM)
 	sock->bind_local = false;
@@ -1470,8 +1465,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      ASSERT (sock->info.proto != PROTO_TCPv4_CLIENT
-	      && sock->info.proto != PROTO_TCPv6_CLIENT);
+      ASSERT (sock->info.proto != PROTO_TCP_CLIENT);
       ASSERT (socket_defined (inetd_socket_descriptor));
       sock->sd = inetd_socket_descriptor;
     }
@@ -1524,8 +1518,7 @@ link_socket_init_phase2 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      if (sock->info.proto == PROTO_TCPv4_SERVER
-	  || sock->info.proto == PROTO_TCPv6_SERVER) {
+      if (sock->info.proto == PROTO_TCP_SERVER) {
 	/* AF_INET as default (and fallback) for inetd */
 	sock->info.lsa->actual.dest.addr.sa.sa_family = AF_INET;
 #ifdef HAVE_GETSOCKNAME
@@ -1536,11 +1529,11 @@ link_socket_init_phase2 (struct link_socket *sock,
 	    if (getsockname (sock->sd, (struct sockaddr *)&local_addr, &addrlen) == 0) {
 	      sock->info.lsa->actual.dest.addr.sa.sa_family = local_addr.addr.sa.sa_family;
 	      dmsg (D_SOCKET_DEBUG, "inetd(%s): using sa_family=%d from getsockname(%d)",
-		    proto2ascii(sock->info.proto, false), local_addr.addr.sa.sa_family,
+		    proto2ascii(sock->info.proto, sock->info.af, false), local_addr.addr.sa.sa_family,
 		    sock->sd);
 	    } else
 	      msg (M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
-		   proto2ascii(sock->info.proto, false), sock->sd);
+		   proto2ascii(sock->info.proto, sock->info.af, false), sock->sd);
 	  }
 #else
 	msg (M_WARN, "inetd(%s): this OS does not provide the getsockname() "
@@ -1569,8 +1562,7 @@ link_socket_init_phase2 (struct link_socket *sock,
 	goto done;
 
       /* TCP client/server */
-      if (sock->info.proto == PROTO_TCPv4_SERVER
-	  ||sock->info.proto == PROTO_TCPv6_SERVER)
+      if (sock->info.proto == PROTO_TCP_SERVER)
 	{
 	  switch (sock->mode)
 	    {
@@ -1605,8 +1597,7 @@ link_socket_init_phase2 (struct link_socket *sock,
 	      ASSERT (0);
 	    }
 	}
-      else if (sock->info.proto == PROTO_TCPv4_CLIENT
-	       ||sock->info.proto == PROTO_TCPv6_CLIENT)
+      else if (sock->info.proto == PROTO_TCP_CLIENT)
 	{
 
 #ifdef GENERAL_PROXY_SUPPORT
@@ -1662,7 +1653,7 @@ link_socket_init_phase2 (struct link_socket *sock,
 	  } while (proxy_retry);
 	}
 #ifdef ENABLE_SOCKS
-      else if (sock->info.proto == PROTO_UDPv4 && sock->socks_proxy)
+      else if (sock->info.proto == PROTO_UDP && sock->socks_proxy && sock->info.af == AF_INET)
 	{
 	  socket_connect (&sock->ctrl_sd,
                           &sock->info.lsa->local,
@@ -1741,16 +1732,16 @@ link_socket_init_phase2 (struct link_socket *sock,
     const int msglevel = (sock->mode == LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
 
     if (sock->inetd)
-      msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, true));
+      msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, sock->info.af, true));
     else
       msg (msglevel, "%s link local%s: %s",
-	   proto2ascii (sock->info.proto, true),
+	   proto2ascii (sock->info.proto, sock->info.af, true),
 	   (sock->bind_local ? " (bound)" : ""),
 	   print_openvpn_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
 
     /* print active remote address */
     msg (msglevel, "%s link remote: %s",
-	 proto2ascii (sock->info.proto, true),
+	 proto2ascii (sock->info.proto, sock->info.af, true),
 	 print_link_socket_actual_ex (&sock->info.lsa->actual,
 				      ":",
 				      PS_SHOW_PORT_IF_DEFINED,
@@ -2003,7 +1994,7 @@ stream_buf_init (struct stream_buf *sb,
   sb->residual = alloc_buf (sb->maxlen);
   sb->error = false;
 #if PORT_SHARE
-  sb->port_share_state = ((sockflags & SF_PORT_SHARE) && (proto == PROTO_TCPv4_SERVER))
+  sb->port_share_state = ((sockflags & SF_PORT_SHARE) && (proto == PROTO_TCP_SERVER))
     ? PS_ENABLED
     : PS_DISABLED;
 #endif
@@ -2412,22 +2403,21 @@ setenv_link_socket_actual (struct env_set *es,
 struct proto_names {
   const char *short_form;
   const char *display_form;
-  bool	is_dgram;
-  bool	is_net;
-  unsigned short proto_af;
+  sa_family_t proto_af;
+  int proto;
 };
 
 /* Indexed by PROTO_x */
-static const struct proto_names proto_names[PROTO_N] = {
-  {"proto-uninitialized",        "proto-NONE",0,0, AF_UNSPEC},
-  {"udp",        "UDPv4",1,1, AF_INET},
-  {"tcp-server", "TCPv4_SERVER",0,1, AF_INET},
-  {"tcp-client", "TCPv4_CLIENT",0,1, AF_INET},
-  {"tcp",        "TCPv4",0,1, AF_INET},
-  {"udp6"       ,"UDPv6",1,1, AF_INET6},
-  {"tcp6-server","TCPv6_SERVER",0,1, AF_INET6},
-  {"tcp6-client","TCPv6_CLIENT",0,1, AF_INET6},
-  {"tcp6"       ,"TCPv6",0,1, AF_INET6},
+static const struct proto_names proto_names[] = {
+  {"proto-uninitialized",        "proto-NONE", AF_UNSPEC, PROTO_NONE},
+  {"udp",        "UDPv4", AF_INET, PROTO_UDP},
+  {"tcp-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
+  {"tcp-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
+  {"tcp",        "TCPv4", AF_INET, PROTO_TCP},
+  {"udp6"       ,"UDPv6", AF_INET6, PROTO_UDP},
+  {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
+  {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
+  {"tcp6"       ,"TCPv6", AF_INET6, PROTO_TCP},
 };
 
 bool
@@ -2435,59 +2425,66 @@ proto_is_net(int proto)
 {
   if (proto < 0 || proto >= PROTO_N)
     ASSERT(0);
-  return proto_names[proto].is_net;
+    return proto != PROTO_NONE;
 }
 bool
 proto_is_dgram(int proto)
 {
-  if (proto < 0 || proto >= PROTO_N)
-    ASSERT(0);
-  return proto_names[proto].is_dgram;
+    return proto_is_udp(proto);
 }
+
 bool
 proto_is_udp(int proto)
 {
   if (proto < 0 || proto >= PROTO_N)
     ASSERT(0);
-  return proto_names[proto].is_dgram&&proto_names[proto].is_net;
+  return proto == PROTO_UDP;
 }
+
 bool
 proto_is_tcp(int proto)
 {
   if (proto < 0 || proto >= PROTO_N)
     ASSERT(0);
-  return (!proto_names[proto].is_dgram)&&proto_names[proto].is_net;
-}
-
-unsigned short 
-proto_sa_family(int proto)
-{
-  if (proto < 0 || proto >= PROTO_N)
-    ASSERT(0);
-  return proto_names[proto].proto_af;
+  return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER || proto == PROTO_TCP_CLIENT;
 }
 
 int
 ascii2proto (const char* proto_name)
 {
   int i;
-  ASSERT (PROTO_N == SIZE (proto_names));
-  for (i = 0; i < PROTO_N; ++i)
+  for (i = 0; i < SIZE (proto_names); ++i)
     if (!strcmp (proto_name, proto_names[i].short_form))
-      return i;
+      return proto_names[i].proto;
   return -1;
 }
 
+sa_family_t
+ascii2af (const char* proto_name)
+{
+    int i;
+    for (i = 0; i < SIZE (proto_names); ++i)
+        if (!strcmp (proto_name, proto_names[i].short_form))
+            return proto_names[i].proto_af;
+    return 0;
+}
+
 const char *
-proto2ascii (int proto, bool display_form)
+proto2ascii (int proto, sa_family_t af, bool display_form)
 {
-  ASSERT (PROTO_N == SIZE (proto_names));
-  if (proto < 0 || proto >= PROTO_N)
-    return "[unknown protocol]";
-  else if (display_form)
-    return proto_names[proto].display_form;
-  else
-    return proto_names[proto].short_form;
+  unsigned int i;
+  for (i = 0; i < SIZE (proto_names); ++i)
+    {
+      if(proto_names[i].proto_af == af && proto_names[i].proto == proto) 
+        {
+          if(display_form)
+              return proto_names[i].display_form;
+          else
+              return proto_names[i].short_form;
+        }
+    }
+
+  return "[unknown protocol]";
 }
 
 const char *
@@ -2496,23 +2493,22 @@ proto2ascii_all (struct gc_arena *gc)
   struct buffer out = alloc_buf_gc (256, gc);
   int i;
 
-  ASSERT (PROTO_N == SIZE (proto_names));
-  for (i = 0; i < PROTO_N; ++i)
+  for (i = 0; i < SIZE (proto_names); ++i)
     {
       if (i)
 	buf_printf(&out, " ");
-      buf_printf(&out, "[%s]", proto2ascii(i, false));
+      buf_printf(&out, "[%s]", proto_names[i].short_form);
     }
   return BSTR (&out);
 }
 
 int
-addr_guess_family(int proto, const char *name) 
+addr_guess_family(sa_family_t af, const char *name) 
 {
   unsigned short ret;
-  if (proto)
+  if (af)
     {
-      return proto_sa_family(proto);	/* already stamped */
+      return af;	/* already stamped */
     } 
   else
     {
@@ -2561,20 +2557,8 @@ proto_remote (int proto, bool remote)
     {
       switch (proto)
       {
-      case PROTO_TCPv4_SERVER: return PROTO_TCPv4_CLIENT;
-      case PROTO_TCPv4_CLIENT: return PROTO_TCPv4_SERVER;
-      case PROTO_TCPv6_SERVER: return PROTO_TCPv4_CLIENT;
-      case PROTO_TCPv6_CLIENT: return PROTO_TCPv4_SERVER;
-      case PROTO_UDPv6: return PROTO_UDPv4;
-      }
-    }
-  else
-    {
-      switch (proto)
-      {
-      case PROTO_TCPv6_SERVER: return PROTO_TCPv4_SERVER;
-      case PROTO_TCPv6_CLIENT: return PROTO_TCPv4_CLIENT;
-      case PROTO_UDPv6: return PROTO_UDPv4;
+	case PROTO_TCP_SERVER: return PROTO_TCP_CLIENT;
+	case PROTO_TCP_CLIENT: return PROTO_TCP_SERVER;
       }
     }
   return proto;
@@ -2725,12 +2709,12 @@ link_socket_read_udp_posix (struct link_socket *sock,
 			    struct link_socket_actual *from)
 {
   socklen_t fromlen = sizeof (from->dest.addr);
-  socklen_t expectedlen = af_addr_size(proto_sa_family(sock->info.proto));
+  socklen_t expectedlen = af_addr_size(sock->info.af);
   addr_zero_host(&from->dest);
   ASSERT (buf_safe (buf, maxsize));
 #if ENABLE_IP_PKTINFO
   /* Both PROTO_UDPv4 and PROTO_UDPv6 */
-  if (proto_is_udp(sock->info.proto) && sock->sockflags & SF_USE_IP_PKTINFO)
+  if (sock->info.proto == PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
     fromlen = link_socket_read_udp_posix_recvmsg (sock, buf, maxsize, from);
   else
 #endif
@@ -2876,10 +2860,10 @@ socket_recv_queue (struct link_socket *sock, int maxsize)
       if (proto_is_udp(sock->info.proto))
 	{
 	  sock->reads.addr_defined = true;
-	  if (sock->info.proto == PROTO_UDPv6)
-	    sock->reads.addrlen = sizeof (sock->reads.addr6);
-	  else
+	  if (sock->info.af == AF_INET)
 	    sock->reads.addrlen = sizeof (sock->reads.addr);
+	  else
+	    sock->reads.addrlen = sizeof (sock->reads.addr6);
 	  status = WSARecvFrom(
 			       sock->sd,
 			       wsabuf,
@@ -2975,7 +2959,7 @@ socket_send_queue (struct link_socket *sock, struct buffer *buf, const struct li
 	{
 	  /* set destination address for UDP writes */
 	  sock->writes.addr_defined = true;
-	  if (sock->info.proto == PROTO_UDPv6)
+	  if (sock->info.af == AF_INET6)
 	    {
 	      sock->writes.addr6 = to->dest.addr.in6;
 	      sock->writes.addrlen = sizeof (sock->writes.addr6);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 1a8ec0f..2ccd4db 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -110,6 +110,7 @@ struct link_socket_info
   const struct plugin_list *plugins;
   bool remote_float;  
   int proto;                    /* Protocol (PROTO_x defined below) */
+  sa_family_t af;                       /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
   int mtu_changed;              /* Set to true when mtu value is changed */
 };
 
@@ -303,6 +304,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *remote_host,
 			 const char *remote_port,
 			 int proto,
+       sa_family_t af,
 			 int mode,
 			 const struct link_socket *accept_from,
 #ifdef ENABLE_HTTP_PROXY
@@ -519,19 +521,16 @@ int openvpn_getaddrinfo (unsigned int flags,
  */
 enum proto_num {
 	PROTO_NONE, /* catch for uninitialized */
-	PROTO_UDPv4,
-	PROTO_TCPv4_SERVER,
-	PROTO_TCPv4_CLIENT,
-	PROTO_TCPv4,
-	PROTO_UDPv6,
-	PROTO_TCPv6_SERVER,
-	PROTO_TCPv6_CLIENT,
-	PROTO_TCPv6,
+	PROTO_UDP,
+	PROTO_TCP,
+	PROTO_TCP_SERVER,
+	PROTO_TCP_CLIENT,
 	PROTO_N
 };
 
 int ascii2proto (const char* proto_name);
-const char *proto2ascii (int proto, bool display_form);
+sa_family_t ascii2af (const char* proto_name);
+const char *proto2ascii (int proto, sa_family_t af, bool display_form);
 const char *proto2ascii_all (struct gc_arena *gc);
 int proto_remote (int proto, bool remote);
 const char *addr_family_name(int af);
@@ -697,9 +696,9 @@ addr_inet4or6(struct sockaddr *addr)
 	return addr->sa_family == AF_INET || addr->sa_family == AF_INET6;
 }
 
-int addr_guess_family(int proto, const char *name);
+int addr_guess_family(sa_family_t af,const char *name);
 static inline int
-af_addr_size(unsigned short af)
+af_addr_size(sa_family_t af)
 {
    switch(af) {
      case AF_INET: return sizeof (struct sockaddr_in);
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index a20f139..1551da8 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -55,7 +55,7 @@
 void
 socks_adjust_frame_parameters (struct frame *frame, int proto)
 {
-  if (proto == PROTO_UDPv4)
+  if (proto == PROTO_UDP)
     frame_add_to_extra_link (frame, 10);
 }
 
-- 
1.8.3.4 (Apple Git-47)


