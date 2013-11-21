From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:02 +0100
Message-Id: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 01/14] Change the type of all ports in
	openvpn to const char* and let getaddrinfo resolve the port
	together with the hostname.
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

This delays error reporting from config parsing to resolving of host addresses. But it allows statements like

remote openvpn.example.org openvpn
port https
management localhost ntp

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8         |    8 +--
 src/openvpn/init.c    |   20 +++-----
 src/openvpn/manage.c  |   19 ++++---
 src/openvpn/manage.h  |    2 +-
 src/openvpn/options.c |  128 +++++++++++------------------------------------
 src/openvpn/options.h |   14 +++---
 src/openvpn/proxy.c   |   12 ++---
 src/openvpn/proxy.h   |    6 +--
 src/openvpn/ps.c      |   29 ++++++-----
 src/openvpn/ps.h      |    2 +-
 src/openvpn/route.c   |    4 +-
 src/openvpn/socket.c  |  131 ++++++++++++++++++++++---------------------------
 src/openvpn/socket.h  |   20 +++-----
 src/openvpn/socks.c   |   30 +++++++++--
 src/openvpn/socks.h   |    6 +--
 15 files changed, 183 insertions(+), 248 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b53d383..99b4d22 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -668,18 +668,18 @@ peer on its new IP address.
 .\"*********************************************************
 .TP
 .B \-\-port port
-TCP/UDP port number for both local and remote.  The current
+TCP/UDP port number or port name for both local and remote.  The current
 default of 1194 represents the official IANA port number
 assignment for OpenVPN and has been used since version 2.0-beta17.
 Previous versions used port 5000 as the default.
 .\"*********************************************************
 .TP
 .B \-\-lport port
-TCP/UDP port number for bind.
+TCP/UDP port number or name for bind.
 .\"*********************************************************
 .TP
 .B \-\-rport port
-TCP/UDP port number for remote.
+TCP/UDP port number or name for remote.
 .\"*********************************************************
 .TP
 .B \-\-bind
@@ -5859,7 +5859,7 @@ Set on program initiation and reset on SIGHUP.
 .\"*********************************************************
 .TP
 .B local_port
-The local port number, specified by
+The local port number or name, specified by
 .B \-\-port
 or
 .B \-\-lport.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ba15fe3..41ff038 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -125,13 +125,6 @@ management_callback_proxy_cmd (void *arg, const char **p)
     ret = true;
   else if (p[2] && p[3])
     {
-      const int port = atoi(p[3]);
-      if (!legal_ipv4_port (port))
-        {
-          msg (M_WARN, "Bad proxy port number: %s", p[3]);
-          return false;
-        }
-
       if (streq (p[1], "HTTP"))
         {
 #ifndef ENABLE_HTTP_PROXY
@@ -146,7 +139,7 @@ management_callback_proxy_cmd (void *arg, const char **p)
             }
           ho = init_http_proxy_options_once (&ce->http_proxy_options, gc);
           ho->server = string_alloc (p[2], gc);
-          ho->port = port;
+          ho->port = string_alloc (p[3], gc);
           ho->retry = true;
           ho->auth_retry = (p[4] && streq (p[4], "nct") ? PAR_NCT : PAR_ALL);
           ret = true;
@@ -158,7 +151,7 @@ management_callback_proxy_cmd (void *arg, const char **p)
           msg (M_WARN, "SOCKS proxy support is not available");
 #else
           ce->socks_proxy_server = string_alloc (p[2], gc);
-          ce->socks_proxy_port = port;
+          ce->socks_proxy_port = p[3];
           ret = true;
 #endif
         }
@@ -227,8 +220,7 @@ management_callback_remote_cmd (void *arg, const char **p)
 	}
       else if (!strcmp(p[1], "MOD") && p[2] && p[3])
 	{
-	  const int port = atoi(p[3]);
-	  if (strlen(p[2]) < RH_HOST_LEN && legal_ipv4_port(port))
+	  if (strlen(p[2]) < RH_HOST_LEN && strlen(p[3]) < RH_PORT_LEN)
 	    {
 	      struct remote_host_store *rhs = c->options.rh_store;
 	      if (!rhs)
@@ -237,8 +229,10 @@ management_callback_remote_cmd (void *arg, const char **p)
 		  c->options.rh_store = rhs;
 		}
 	      strncpynt(rhs->host, p[2], RH_HOST_LEN);
+              strncpynt(rhs->port, p[3], RH_PORT_LEN);
+
 	      ce->remote = rhs->host;
-	      ce->remote_port = port;
+	      ce->remote_port = rhs->port;
 	      flags = CE_MAN_QUERY_REMOTE_MOD;
 	      ret = true;
 	    }
@@ -262,7 +256,7 @@ ce_management_query_remote (struct context *c, const char *remote_ip_hint)
   if (management)
     {
       struct buffer out = alloc_buf_gc (256, &gc);
-      buf_printf (&out, ">REMOTE:%s,%d,%s", np(ce->remote), ce->remote_port, proto2ascii(ce->proto, false));
+      buf_printf (&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port, proto2ascii(ce->proto, false));
       management_notify_generic(management, BSTR (&out));
       ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK<<CE_MAN_QUERY_REMOTE_SHIFT);
       ce->flags |= (CE_MAN_QUERY_REMOTE_QUERY<<CE_MAN_QUERY_REMOTE_SHIFT);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 74de1e1..3816740 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2058,7 +2058,7 @@ man_persist_close (struct man_persist *mp)
 static void
 man_settings_init (struct man_settings *ms,
 		   const char *addr,
-		   const int port,
+		   const char *port,
 		   const char *pass_file,
 		   const char *client_user,
 		   const char *client_group,
@@ -2111,12 +2111,6 @@ man_settings_init (struct man_settings *ms,
       else
 #endif
 	{
-	  /*
-	   * Initialize socket address
-	   */
-	  ms->local.addr.in4.sin_family = AF_INET;
-	  ms->local.addr.in4.sin_addr.s_addr = 0;
-	  ms->local.addr.in4.sin_port = htons (port);
 
 	  /*
 	   * Run management over tunnel, or
@@ -2128,8 +2122,13 @@ man_settings_init (struct man_settings *ms,
 	    }
 	  else
 	    {
-	      ms->local.addr.in4.sin_addr.s_addr = getaddr
-		(GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL, addr, 0, NULL, NULL);
+              struct addrinfo* ai;
+              int status = openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL,
+                                               addr, port, 0, NULL, AF_INET, &ai);
+              ASSERT(status==0);
+              ms->local.addr.in4 = *((struct sockaddr_in*)ai->ai_addr);
+              freeaddrinfo(ai);
+
 	    }
 	}
       
@@ -2248,7 +2247,7 @@ management_init (void)
 bool
 management_open (struct management *man,
 		 const char *addr,
-		 const int port,
+		 const char *port,
 		 const char *pass_file,
 		 const char *client_user,
 		 const char *client_group,
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index b08bb78..a54d0b6 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -341,7 +341,7 @@ struct management *management_init (void);
 
 bool management_open (struct management *man,
 		      const char *addr,
-		      const int port,
+		      const char *port,
 		      const char *pass_file,
 		      const char *client_user,
 		      const char *client_group,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e925397..3d711fa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -169,8 +169,8 @@ static const char usage_message[] =
   "--ipchange cmd  : Run command cmd on remote ip address initial\n"
   "                  setting or change -- execute as: cmd ip-address port#\n"
   "--port port     : TCP/UDP port # for both local and remote.\n"
-  "--lport port    : TCP/UDP port # for local (default=%d). Implies --bind.\n"
-  "--rport port    : TCP/UDP port # for remote (default=%d).\n"
+  "--lport port    : TCP/UDP port # for local (default=%s). Implies --bind.\n"
+  "--rport port    : TCP/UDP port # for remote (default=%s).\n"
   "--bind          : Bind to local address and port. (This is the default unless\n"
   "                  --proto tcp-client"
 #ifdef ENABLE_HTTP_PROXY
@@ -909,22 +909,22 @@ setenv_connection_entry (struct env_set *es,
 {
   setenv_str_i (es, "proto", proto2ascii (e->proto, false), i);
   setenv_str_i (es, "local", e->local, i);
-  setenv_int_i (es, "local_port", e->local_port, i);
+  setenv_str_i (es, "local_port", e->local_port, i);
   setenv_str_i (es, "remote", e->remote, i);
-  setenv_int_i (es, "remote_port", e->remote_port, i);
+  setenv_str_i (es, "remote_port", e->remote_port, i);
 
 #ifdef ENABLE_HTTP_PROXY
   if (e->http_proxy_options)
     {
       setenv_str_i (es, "http_proxy_server", e->http_proxy_options->server, i);
-      setenv_int_i (es, "http_proxy_port", e->http_proxy_options->port, i);
+      setenv_str_i (es, "http_proxy_port", e->http_proxy_options->port, i);
     }
 #endif
 #ifdef ENABLE_SOCKS
   if (e->socks_proxy_server)
     {
       setenv_str_i (es, "socks_proxy_server", e->socks_proxy_server, i);
-      setenv_int_i (es, "socks_proxy_port", e->socks_proxy_port, i);
+      setenv_str_i (es, "socks_proxy_port", e->socks_proxy_port, i);
     }
 #endif
 }
@@ -1226,7 +1226,7 @@ show_p2mp_parms (const struct options *o)
   SHOW_BOOL (auth_user_pass_verify_script_via_file);
 #if PORT_SHARE
   SHOW_STR (port_share_host);
-  SHOW_INT (port_share_port);
+  SHOW_STR (port_share_port);
 #endif
 #endif /* P2MP_SERVER */
 
@@ -1298,7 +1298,7 @@ show_http_proxy_options (const struct http_proxy_options *o)
   int i;
   msg (D_SHOW_PARMS, "BEGIN http_proxy");
   SHOW_STR (server);
-  SHOW_INT (port);
+  SHOW_STR (port);
   SHOW_STR (auth_method_string);
   SHOW_STR (auth_file);
   SHOW_BOOL (retry);
@@ -1360,9 +1360,9 @@ show_connection_entry (const struct connection_entry *o)
 {
   msg (D_SHOW_PARMS, "  proto = %s", proto2ascii (o->proto, false));
   SHOW_STR (local);
-  SHOW_INT (local_port);
+  SHOW_STR (local_port);
   SHOW_STR (remote);
-  SHOW_INT (remote_port);
+  SHOW_STR (remote_port);
   SHOW_BOOL (remote_float);
   SHOW_BOOL (bind_defined);
   SHOW_BOOL (bind_local);
@@ -1376,7 +1376,7 @@ show_connection_entry (const struct connection_entry *o)
 #endif
 #ifdef ENABLE_SOCKS
   SHOW_STR (socks_proxy_server);
-  SHOW_INT (socks_proxy_port);
+  SHOW_STR (socks_proxy_port);
   SHOW_BOOL (socks_proxy_retry);
 #endif
   SHOW_INT (tun_mtu);
@@ -1557,7 +1557,7 @@ show_settings (const struct options *o)
 
 #ifdef ENABLE_MANAGEMENT
   SHOW_STR (management_addr);
-  SHOW_INT (management_port);
+  SHOW_STR (management_port);
   SHOW_STR (management_user_pass);
   SHOW_INT (management_log_history_cache);
   SHOW_INT (management_echo_buffer_size);
@@ -1705,17 +1705,9 @@ parse_http_proxy_override (const char *server,
   if (server && port)
     {
       struct http_proxy_options *ho;
-      const int int_port = atoi(port);
-
-      if (!legal_ipv4_port (int_port))
-	{
-	  msg (msglevel, "Bad http-proxy port number: %s", port);
-	  return NULL;
-	}
-
       ALLOC_OBJ_CLEAR_GC (ho, struct http_proxy_options, gc);
       ho->server = string_alloc(server, gc);
-      ho->port = int_port;
+      ho->port = port;
       ho->retry = true;
       ho->timeout = 5;
       if (flags && !strcmp(flags, "nct"))
@@ -1818,7 +1810,7 @@ connection_entry_load_re (struct connection_entry *ce, const struct remote_entry
 {
   if (re->remote)
     ce->remote = re->remote;
-  if (re->remote_port >= 0)
+  if (re->remote_port)
     ce->remote_port = re->remote_port;
   if (re->proto >= 0)
     ce->proto = re->proto;
@@ -1922,7 +1914,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
   if (proto_is_net(ce->proto)
       && string_defined_equal (ce->local, ce->remote)
-      && ce->local_port == ce->remote_port)
+      && string_defined_equal (ce->local_port, ce->remote_port))
     msg (M_USAGE, "--remote and --local addresses are the same");
   
   if (string_defined_equal (ce->remote, options->ifconfig_local)
@@ -2400,7 +2392,7 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 #endif
 
   if (!ce->bind_local)
-    ce->local_port = 0;
+    ce->local_port = NULL;
 
   /* if protocol forcing is enabled, disable all protocols except for the forced one */
   if (o->proto_force >= 0 && proto_is_tcp(o->proto_force) != proto_is_tcp(ce->proto))
@@ -4144,8 +4136,6 @@ add_option (struct options *options,
 #ifdef ENABLE_MANAGEMENT
   else if (streq (p[0], "management") && p[1] && p[2])
     {
-      int port = 0;
-
       VERIFY_PERMISSION (OPT_P_GENERAL);
       if (streq (p[2], "unix"))
 	{
@@ -4156,18 +4146,9 @@ add_option (struct options *options,
 	  goto err;
 #endif
 	}
-      else
-	{
-	  port = atoi (p[2]);
-	  if (!legal_ipv4_port (port))
-	    {
-	      msg (msglevel, "port number associated with --management directive is out of range");
-	      goto err;
-	    }
-	}
 
       options->management_addr = p[1];
-      options->management_port = port;
+      options->management_port = p[2];
       if (p[3])
 	{
 	  options->management_user_pass = p[3];
@@ -4481,20 +4462,14 @@ add_option (struct options *options,
   else if (streq (p[0], "remote") && p[1])
     {
       struct remote_entry re;
-      re.remote = NULL;
-      re.remote_port = re.proto = -1;
+      re.remote = re.remote_port= NULL;
+      re.proto = -1;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       re.remote = p[1];
       if (p[2])
 	{
-	  const int port = atoi (p[2]);
-	  if (!legal_ipv4_port (port))
-	    {
-	      msg (msglevel, "remote: port number associated with host %s is out of range", p[1]);
-	      goto err;
-	    }
-	  re.remote_port = port;
+	  re.remote_port = p[2];
 	  if (p[3])
 	    {
 	      const int proto = ascii2proto (p[3]);
@@ -4902,43 +4877,19 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "port") && p[1])
     {
-      int port;
-
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      port = atoi (p[1]);
-      if (!legal_ipv4_port (port))
-	{
-	  msg (msglevel, "Bad port number: %s", p[1]);
-	  goto err;
-	}
-      options->ce.local_port = options->ce.remote_port = port;
+      options->ce.local_port = options->ce.remote_port = p[1];
     }
   else if (streq (p[0], "lport") && p[1])
     {
-      int port;
-
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      port = atoi (p[1]);
-      if ((port != 0) && !legal_ipv4_port (port))
-	{
-	  msg (msglevel, "Bad local port number: %s", p[1]);
-	  goto err;
-	}
       options->ce.local_port_defined = true;
-      options->ce.local_port = port;
+      options->ce.local_port = p[1];
     }
   else if (streq (p[0], "rport") && p[1])
     {
-      int port;
-
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      port = atoi (p[1]);
-      if (!legal_ipv4_port (port))
-	{
-	  msg (msglevel, "Bad remote port number: %s", p[1]);
-	  goto err;
-	}
-      options->ce.remote_port = port;
+      options->ce.remote_port = p[1];
     }
   else if (streq (p[0], "bind"))
     {
@@ -4997,23 +4948,16 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
 
       {
-	int port;
 	if (!p[2])
 	  {
 	    msg (msglevel, "http-proxy port number not defined");
 	    goto err;
 	  }
-	port = atoi (p[2]);
-	if (!legal_ipv4_port (port))
-	  {
-	    msg (msglevel, "Bad http-proxy port number: %s", p[2]);
-	    goto err;
-	  }
 	
 	ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
 	
 	ho->server = p[1];
-	ho->port = port;
+	ho->port = p[2];
       }
 
       if (p[3])
@@ -5110,19 +5054,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
 
       if (p[2])
-	{
-	  int port;
-          port = atoi (p[2]);
-          if (!legal_ipv4_port (port))
-	    {
-	      msg (msglevel, "Bad socks-proxy port number: %s", p[2]);
-	      goto err;
-	    }
-          options->ce.socks_proxy_port = port;
+        {
+          options->ce.socks_proxy_port = p[2];
 	}
       else
 	{
-	  options->ce.socks_proxy_port = 1080;
+	  options->ce.socks_proxy_port = "1080";
 	}
       options->ce.socks_proxy_server = p[1];
       options->ce.socks_proxy_authfile = p[3]; /* might be NULL */
@@ -5755,18 +5692,9 @@ add_option (struct options *options,
 #if PORT_SHARE
   else if (streq (p[0], "port-share") && p[1] && p[2])
     {
-      int port;
-
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      port = atoi (p[2]);
-      if (!legal_ipv4_port (port))
-	{
-	  msg (msglevel, "port number associated with --port-share directive is out of range");
-	  goto err;
-	}
-
       options->port_share_host = p[1];
-      options->port_share_port = port;
+      options->port_share_port = p[2];
       options->port_share_journal_dir = p[3];
     }
 #endif
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 8e0e367..84a5910 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -87,9 +87,9 @@ struct options_pre_pull
 struct connection_entry
 {
   int proto;
-  int local_port;
+  const char* local_port;
   bool local_port_defined;
-  int remote_port;
+  const char* remote_port;
   const char *local;
   const char *remote;
   bool remote_float;
@@ -105,7 +105,7 @@ struct connection_entry
 #endif  
 #ifdef ENABLE_SOCKS
   const char *socks_proxy_server;
-  int socks_proxy_port;
+  const char *socks_proxy_port;
   const char *socks_proxy_authfile;
   bool socks_proxy_retry;
 #endif
@@ -143,7 +143,7 @@ struct connection_entry
 struct remote_entry
 {
   const char *remote;
-  int remote_port;
+  const char *remote_port;
   int proto;
 };
 
@@ -168,6 +168,8 @@ struct remote_host_store
 {
 # define RH_HOST_LEN 80
   char host[RH_HOST_LEN];
+#define RH_PORT_LEN 20
+  char port[RH_PORT_LEN];
 };
 
 /* Command line options */
@@ -356,7 +358,7 @@ struct options
 
 #ifdef ENABLE_MANAGEMENT
   const char *management_addr;
-  int management_port;
+  const char *management_port;
   const char *management_user_pass;
   int management_log_history_cache;
   int management_echo_buffer_size;
@@ -451,7 +453,7 @@ struct options
   bool auth_user_pass_verify_script_via_file;
 #if PORT_SHARE
   char *port_share_host;
-  int port_share_port;
+  char *port_share_port;
   const char *port_share_journal_dir;
 #endif
 #endif
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c3496e2..f7f0648 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -443,7 +443,7 @@ http_proxy_new (const struct http_proxy_options *o)
   if (!o || !o->server)
     msg (M_FATAL, "HTTP_PROXY: server not specified");
 
-  ASSERT (legal_ipv4_port (o->port));
+  ASSERT ( o->port);
 
   ALLOC_OBJ_CLEAR (p, struct http_proxy_info);
   p->options = *o;
@@ -492,7 +492,7 @@ bool
 add_proxy_headers (struct http_proxy_info *p,
 		  socket_descriptor_t sd, /* already open to proxy */
 		  const char *host,	  /* openvpn server remote */
-		  const int port	  /* openvpn server port */
+		  const char* port	  /* openvpn server port */
 		  )
 {
   char buf[512];
@@ -553,7 +553,7 @@ bool
 establish_http_proxy_passthru (struct http_proxy_info *p,
 			       socket_descriptor_t sd, /* already open to proxy */
 			       const char *host,       /* openvpn server remote */
-			       const int port,         /* openvpn server port */
+			       const char *port,         /* openvpn server port */
 			       struct buffer *lookahead,
 			       volatile int *signal_received)
 {
@@ -581,7 +581,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
   else
     {
       /* format HTTP CONNECT message */
-      openvpn_snprintf (buf, sizeof(buf), "CONNECT %s:%d HTTP/%s",
+      openvpn_snprintf (buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
 			host,
 			port,
 			p->options.http_version);
@@ -692,7 +692,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
           /* now send the phase 3 reply */
 
           /* format HTTP CONNECT message */
-          openvpn_snprintf (buf, sizeof(buf), "CONNECT %s:%d HTTP/%s",
+          openvpn_snprintf (buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
 			    host,
 			    port,
 			    p->options.http_version);
@@ -777,7 +777,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 
 
 	      /* build the digest response */
-	      openvpn_snprintf (uri, sizeof(uri), "%s:%d",
+	      openvpn_snprintf (uri, sizeof(uri), "%s:%s",
 				host,
 				port);
 
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index b72748f..0e7a6df 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -46,7 +46,7 @@ struct http_custom_header {
 #define MAX_CUSTOM_HTTP_HEADER 10
 struct http_proxy_options {
   const char *server;
-  int port;
+  const char *port;
   bool retry;
   int timeout;
 
@@ -64,7 +64,7 @@ struct http_proxy_options {
 
 struct http_proxy_options_simple {
   const char *server;
-  int port;
+  const char *port;
   int auth_retry;
 };
 
@@ -87,7 +87,7 @@ void http_proxy_close (struct http_proxy_info *hp);
 bool establish_http_proxy_passthru (struct http_proxy_info *p,
 				    socket_descriptor_t sd, /* already open to proxy */
 				    const char *host,       /* openvpn server remote */
-				    const int port,         /* openvpn server port */
+				    const char *port,         /* openvpn server port */
 				    struct buffer *lookahead,
 				    volatile int *signal_received);
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 6495dc7..44eda89 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -403,8 +403,7 @@ proxy_connection_io_requeue (struct proxy_connection *pc, const int rwflags_new,
 static bool
 proxy_entry_new (struct proxy_connection **list,
 		 struct event_set *es,
-		 const in_addr_t server_addr,
-		 const int server_port,
+		 const struct sockaddr_in server_addr,
 		 const socket_descriptor_t sd_client,
 		 struct buffer *initial_data,
 		 const char *journal_dir)
@@ -416,7 +415,7 @@ proxy_entry_new (struct proxy_connection **list,
   struct proxy_connection *cp;
 
   /* connect to port share server */
-  sock_addr_set (&osaddr, server_addr, server_port);
+  osaddr.addr.in4 = server_addr;
   if ((sd_server = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
     {
       msg (M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
@@ -482,8 +481,7 @@ static bool
 control_message_from_parent (const socket_descriptor_t sd_control,
 			     struct proxy_connection **list,
 			     struct event_set *es,
-			     const in_addr_t server_addr,
-			     const int server_port,
+			     const struct sockaddr_in server_addr,
 			     const int max_initial_buf,
 			     const char *journal_dir)
 {
@@ -539,7 +537,6 @@ control_message_from_parent (const socket_descriptor_t sd_control,
 	      if (proxy_entry_new (list,
 				   es,
 				   server_addr,
-				   server_port,
 				   received_fd,
 				   &buf,
 				   journal_dir))
@@ -716,8 +713,7 @@ proxy_connection_io_dispatch (struct proxy_connection *pc,
  * This is the main function for the port share proxy background process.
  */
 static void
-port_share_proxy (const in_addr_t hostaddr,
-		  const int port,
+port_share_proxy (const struct sockaddr_in hostaddr,
 		  const socket_descriptor_t sd_control,
 		  const int max_initial_buf,
 		  const char *journal_dir)
@@ -754,7 +750,7 @@ port_share_proxy (const in_addr_t hostaddr,
 		  const struct event_set_return *e = &esr[i];
 		  if (e->arg == sd_control_marker)
 		    {
-		      if (!control_message_from_parent (sd_control, &list, es, hostaddr, port, max_initial_buf, journal_dir))
+		      if (!control_message_from_parent (sd_control, &list, es, hostaddr, max_initial_buf, journal_dir))
 			goto done;
 		    }
 		  else
@@ -789,14 +785,16 @@ port_share_proxy (const in_addr_t hostaddr,
  */
 struct port_share *
 port_share_open (const char *host,
-		 const int port,
+		 const char *port,
 		 const int max_initial_buf,
 		 const char *journal_dir)
 {
   pid_t pid;
   socket_descriptor_t fd[2];
-  in_addr_t hostaddr;
+  struct sockaddr_in hostaddr;
   struct port_share *ps;
+  int status;
+  struct addrinfo* ai;
 
   ALLOC_OBJ_CLEAR (ps, struct port_share);
   ps->foreground_fd = -1;
@@ -805,7 +803,12 @@ port_share_open (const char *host,
   /*
    * Get host's IP address
    */
-  hostaddr = getaddr (GETADDR_RESOLVE|GETADDR_HOST_ORDER|GETADDR_FATAL, host, 0, NULL, NULL);
+  
+  status = openvpn_getaddrinfo (GETADDR_RESOLVE|GETADDR_HOST_ORDER|GETADDR_FATAL,
+                                 host, port,  0, NULL, AF_INET, &ai);
+  ASSERT (status==0);
+  hostaddr = *((struct sockaddr_in*) ai->ai_addr);
+  freeaddrinfo(ai);
 
   /*
    * Make a socket for foreground and background processes
@@ -881,7 +884,7 @@ port_share_open (const char *host,
       prng_init (NULL, 0);
 
       /* execute the event loop */
-      port_share_proxy (hostaddr, port, fd[1], max_initial_buf, journal_dir);
+      port_share_proxy (hostaddr, fd[1], max_initial_buf, journal_dir);
 
       openvpn_close_socket (fd[1]);
 
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 4280635..e8919d4 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -44,7 +44,7 @@ struct port_share {
 extern struct port_share *port_share;
 
 struct port_share *port_share_open (const char *host,
-				    const int port,
+				    const char *port,
 				    const int max_initial_buf,
 				    const char *journal_dir);
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 19b4bfe..f051dd3 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -294,12 +294,12 @@ init_route (struct route *r,
   if(get_special_addr (rl, ro->network, &special.s_addr, &status))
     {
       special.s_addr = htonl(special.s_addr);
-      ret = openvpn_getaddrinfo(0, inet_ntoa(special), 0, NULL,
+      ret = openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL,
                                 AF_INET, network_list);
     }
   else
     ret = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL,
-                              ro->network, 0, NULL, AF_INET, network_list);
+                              ro->network, NULL, 0, NULL, AF_INET, network_list);
 
   status = (ret == 0);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 3c0a379..33ef3f4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -101,8 +101,8 @@ getaddr (unsigned int flags,
 {
   struct addrinfo *ai;
   int status;
-  status = openvpn_getaddrinfo(flags, hostname, resolve_retry_seconds,
-							   signal_received, AF_INET, &ai);
+  status = openvpn_getaddrinfo (flags & ~GETADDR_HOST_ORDER, hostname, NULL,
+                                resolve_retry_seconds, signal_received, AF_INET, &ai);
   if(status==0) {
     struct in_addr ia;
     if(succeeded)
@@ -125,6 +125,7 @@ getaddr (unsigned int flags,
 int
 openvpn_getaddrinfo (unsigned int flags,
                      const char *hostname,
+                     const char *servname,
                      int resolve_retry_seconds,
                      volatile int *signal_received,
                      int ai_family,
@@ -135,6 +136,8 @@ openvpn_getaddrinfo (unsigned int flags,
   int sigrec = 0;
   int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
   struct gc_arena gc = gc_new ();
+  const char *print_hostname;
+  const char *print_servname;
 
   ASSERT(res);
 
@@ -142,8 +145,19 @@ openvpn_getaddrinfo (unsigned int flags,
   res_init ();
 #endif
 
-  if (!hostname)
-    hostname = "::";
+  ASSERT (hostname || servname);
+  ASSERT (!(flags & GETADDR_HOST_ORDER));
+
+  if(hostname)
+    print_hostname = hostname;
+  else
+    print_hostname = "undefined";
+    
+  if(servname)
+    print_servname = servname;
+  else
+    print_servname = "";
+
 
   if (flags & GETADDR_RANDOMIZE)
     hostname = hostname_randomize(hostname, &gc);
@@ -160,8 +174,11 @@ openvpn_getaddrinfo (unsigned int flags,
   hints.ai_family = ai_family;
   hints.ai_flags = AI_NUMERICHOST;
   hints.ai_socktype = SOCK_STREAM;
+  
+  if(flags & GETADDR_PASSIVE)
+      hints.ai_flags |= AI_PASSIVE;
 
-  status = getaddrinfo(hostname, NULL, &hints, res);
+  status = getaddrinfo(hostname, servname, &hints, res);
 
   if (status != 0) /* parse as numeric address failed? */
     {
@@ -169,7 +186,7 @@ openvpn_getaddrinfo (unsigned int flags,
       int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 : (resolve_retry_seconds / fail_wait_interval);
       const char *fmt;
       int level = 0;
-
+      
       fmt = "RESOLVE: Cannot resolve host address: %s: %s";
       if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
           && !resolve_retry_seconds)
@@ -177,7 +194,8 @@ openvpn_getaddrinfo (unsigned int flags,
 
       if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
         {
-          msg (msglevel, "RESOLVE: Cannot parse IP address: %s", hostname);
+          msg (msglevel, "RESOLVE: Cannot parse IP address: %s:%s",
+               print_hostname,print_servname);
           goto done;
         }
 
@@ -199,10 +217,10 @@ openvpn_getaddrinfo (unsigned int flags,
       while (true)
         {
           /* try hostname lookup */
-          hints.ai_flags = 0;
+          hints.ai_flags &= ~AI_NUMERICHOST;
           dmsg (D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
                 flags, hints.ai_family, hints.ai_socktype);
-          status = getaddrinfo(hostname, NULL, &hints, res);
+          status = getaddrinfo(hostname, servname, &hints, res);
 
           if (signal_received)
             {
@@ -236,7 +254,8 @@ openvpn_getaddrinfo (unsigned int flags,
 
           msg (level,
                fmt,
-               hostname,
+               print_hostname,
+               print_servname,
                gai_strerror(status));
 
           if (--resolve_retries <= 0)
@@ -449,7 +468,8 @@ update_remote (const char* host,
           int status;
           struct addrinfo* ai;
 
-		  status = openvpn_getaddrinfo(sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockflags), host, 1, NULL, AF_INET6, &ai);
+          status = openvpn_getaddrinfo(sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockflags), 
+                                       host, NULL, 1, NULL, AF_INET6, &ai);
 
           if ( status ==0 )
             {
@@ -1141,53 +1161,30 @@ resolve_bind_local (struct link_socket *sock)
   /* resolve local address if undefined */
   if (!addr_defined (&sock->info.lsa->local))
     {
+      int status;
+      struct addrinfo *ai;
+ 
       /* may return AF_{INET|INET6} guessed from local_host */
-      switch(addr_guess_family(sock->info.proto, sock->local_host))
-	{
-	case AF_INET:
-	  sock->info.lsa->local.addr.in4.sin_family = AF_INET;
-	  sock->info.lsa->local.addr.in4.sin_addr.s_addr =
-	    (sock->local_host ? getaddr (GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL,
-					 sock->local_host,
-					 0,
-					 NULL,
-					 NULL)
-	     : htonl (INADDR_ANY));
-	  sock->info.lsa->local.addr.in4.sin_port = htons (sock->local_port);
-	  break;
-	case AF_INET6:
-	    {
-	      int status;
-	      CLEAR(sock->info.lsa->local.addr.in6);
-	      if (sock->local_host)
-		{
-		  struct addrinfo *ai;
-
-		  status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL,
-									   sock->local_host, 0, NULL, AF_INET6, &ai);
-		  if(status ==0) {
-			  sock->info.lsa->local.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
-			  freeaddrinfo(ai);
-		  }
-		}
-	      else
-		{
-		  sock->info.lsa->local.addr.in6.sin6_family = AF_INET6;
-		  sock->info.lsa->local.addr.in6.sin6_addr = in6addr_any;
-		  status = 0;
-		}
-	      if (!status == 0)
-		{
-		  msg (M_FATAL, "getaddr6() failed for local \"%s\": %s",
-		       sock->local_host,
-		       gai_strerror(status));
-		}
-	      sock->info.lsa->local.addr.in6.sin6_port = htons (sock->local_port);
-	    }
-	  break;
-	}
+      const int af = addr_guess_family(sock->info.proto, sock->local_host);
+      status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE,
+                                   sock->local_host, sock->local_port, 0, NULL, af, &ai);
+      if(status ==0) {
+        switch(af) {
+        case AF_INET:
+          sock->info.lsa->local.addr.in4 =  *((struct sockaddr_in*)(ai->ai_addr));
+
+        case AF_INET6:
+          sock->info.lsa->local.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
+          break;
+          freeaddrinfo(ai);
+        }
+      } else {
+        msg (M_FATAL, "getaddrinfo() failed for local \"%s:%s\": %s",
+             sock->local_host, sock->local_port,
+             gai_strerror(status));
+      }
     }
-  
+
   /* bind to local address/port */
   if (sock->bind_local)
     {
@@ -1272,8 +1269,8 @@ resolve_remote (struct link_socket *sock,
 		}
 
 		  /* Temporary fix, this need to be changed for dual stack */
-		  status = openvpn_getaddrinfo(flags, sock->remote_host, retry,
-											  signal_received, af, &ai);
+		  status = openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_port,
+                                               retry, signal_received, af, &ai);
 		  if(status == 0) {
 			  sock->info.lsa->remote.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
 			  freeaddrinfo(ai);
@@ -1297,15 +1294,6 @@ resolve_remote (struct link_socket *sock,
 		  goto done;
 		}
 	    }
-          switch(af)
-            {
-              case AF_INET:
-                sock->info.lsa->remote.addr.in4.sin_port = htons (sock->remote_port);
-                break;
-              case AF_INET6:
-                sock->info.lsa->remote.addr.in6.sin6_port = htons (sock->remote_port);
-                break;
-            }
 	}
   
       /* should we re-use previous active remote address? */
@@ -1348,9 +1336,9 @@ void
 link_socket_init_phase1 (struct link_socket *sock,
 			 const bool connection_profiles_defined,
 			 const char *local_host,
-			 int local_port,
+			 const char *local_port,
 			 const char *remote_host,
-			 int remote_port,
+			 const char *remote_port,
 			 int proto,
 			 int mode,
 			 const struct link_socket *accept_from,
@@ -1496,8 +1484,9 @@ link_socket_init_phase1 (struct link_socket *sock,
 
       /* set socket to --mark packets with given value */
       socket_set_mark (sock->sd, mark);
-
-      resolve_bind_local (sock);
+      
+      if(sock->bind_local)
+          resolve_bind_local (sock);
       resolve_remote (sock, 1, NULL, NULL);
     }
 }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 793cd9f..549946e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -39,7 +39,7 @@
 /*
  * OpenVPN's default port number as assigned by IANA.
  */
-#define OPENVPN_PORT 1194
+#define OPENVPN_PORT "1194"
 
 /*
  * Maximum size passed passed to setsockopt SNDBUF/RCVBUF
@@ -179,9 +179,9 @@ struct link_socket
   bool connection_profiles_defined;
 
   const char *remote_host;
-  int remote_port;
+  const char *remote_port;
   const char *local_host;
-  int local_port;
+  const char *local_port;
   bool bind_local;
 
 # define INETD_NONE   0
@@ -232,7 +232,7 @@ struct link_socket
 #if defined(ENABLE_HTTP_PROXY) || defined(ENABLE_SOCKS)
   /* The OpenVPN server we will use the proxy to connect to */
   const char *proxy_dest_host;
-  int proxy_dest_port;
+  const char *proxy_dest_port;
 #endif
 
 #if PASSTOS_CAPABILITY
@@ -299,9 +299,9 @@ void
 link_socket_init_phase1 (struct link_socket *sock,
 			 const bool connection_profiles_defined,
 			 const char *local_host,
-			 int local_port,
+			 const char *local_port,
 			 const char *remote_host,
-			 int remote_port,
+			 const char *remote_port,
 			 int proto,
 			 int mode,
 			 const struct link_socket *accept_from,
@@ -481,6 +481,7 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
 #define GETADDR_TRY_ONCE              (1<<7)
 #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
 #define GETADDR_RANDOMIZE             (1<<9)
+#define GETADDR_PASSIVE               (1<<10)
 
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
@@ -490,6 +491,7 @@ in_addr_t getaddr (unsigned int flags,
 
 int openvpn_getaddrinfo (unsigned int flags,
                          const char *hostname,
+                         const char *servname,
                          int resolve_retry_seconds,
                          volatile int *signal_received,
                          int ai_family,
@@ -544,12 +546,6 @@ datagram_overhead (int proto)
  */
 
 static inline bool
-legal_ipv4_port (int port)
-{
-  return port > 0 && port < 65536;
-}
-
-static inline bool
 link_socket_proto_connection_oriented (int proto)
 {
   return !proto_is_dgram(proto);
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 235982e..c2203c2 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -61,7 +61,7 @@ socks_adjust_frame_parameters (struct frame *frame, int proto)
 
 struct socks_proxy_info *
 socks_proxy_new (const char *server,
-		 int port,
+		 const char *port,
 		 const char *authfile,
 		 bool retry)
 {
@@ -70,7 +70,7 @@ socks_proxy_new (const char *server,
   ALLOC_OBJ_CLEAR (p, struct socks_proxy_info);
 
   ASSERT (server);
-  ASSERT (legal_ipv4_port (port));
+  ASSERT (port);
 
   strncpynt (p->server, server, sizeof (p->server));
   p->port = port;
@@ -389,11 +389,27 @@ recv_socks_reply (socket_descriptor_t sd,
   return true;
 }
 
+static int
+port_from_servname(const char* servname)
+{
+    int port =0;
+    port = atoi(servname);
+    if(port >0 && port < 65536)
+        return port;
+    
+    struct  servent* service;
+    service = getservbyname(servname, NULL);
+    if(service)
+        return service->s_port;
+
+    return 0;
+}
+
 void
 establish_socks_proxy_passthru (struct socks_proxy_info *p,
 			        socket_descriptor_t sd, /* already open to proxy */
 			        const char *host,       /* openvpn server remote */
-			        const int port,         /* openvpn server port */
+			        const char *servname,   /* openvpn server port */
 			        volatile int *signal_received)
 {
   char buf[128];
@@ -414,6 +430,13 @@ establish_socks_proxy_passthru (struct socks_proxy_info *p,
   buf[4] = (char) len;
   memcpy(buf + 5, host, len);
 
+  int port = port_from_servname (servname);
+  if (port ==0)
+    {
+      msg (D_LINK_ERRORS, "establish_socks_proxy_passthrough: Cannot convert %s to port number", servname);
+      goto error;
+    }
+    
   buf[5 + len] = (char) (port >> 8);
   buf[5 + len + 1] = (char) (port & 0xff);
 
@@ -425,6 +448,7 @@ establish_socks_proxy_passthru (struct socks_proxy_info *p,
 	goto error;
       }
   }
+    
 
   /* receive reply from Socks proxy and discard */
   if (!recv_socks_reply (sd, NULL, signal_received))
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index b55ff6f..30b957d 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -42,14 +42,14 @@ struct socks_proxy_info {
   bool retry;
 
   char server[128];
-  int port;
+  const char *port;
   char authfile[256];
 };
 
 void socks_adjust_frame_parameters (struct frame *frame, int proto);
 
 struct socks_proxy_info *socks_proxy_new (const char *server,
-					  int port,
+					  const char *port,
 					  const char *authfile,
 					  bool retry);
 
@@ -58,7 +58,7 @@ void socks_proxy_close (struct socks_proxy_info *sp);
 void establish_socks_proxy_passthru (struct socks_proxy_info *p,
 				     socket_descriptor_t sd, /* already open to proxy */
 				     const char *host,       /* openvpn server remote */
-				     const int port,         /* openvpn server port */
+				     const char *servname,         /* openvpn server port */
 				     volatile int *signal_received);
 
 void establish_socks_proxy_udpassoc (struct socks_proxy_info *p,
-- 
1.7.9.5


