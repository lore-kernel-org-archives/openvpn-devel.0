From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Jul 2014 22:15:41 +0200
Message-Id: <1404764141-18229-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Always enable http-proxy and socks-proxy
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

---
 configure.ac          | 16 ----------------
 src/openvpn/base64.c  |  6 ------
 src/openvpn/base64.h  |  4 ----
 src/openvpn/forward.c | 12 +-----------
 src/openvpn/init.c    | 44 +-------------------------------------------
 src/openvpn/openvpn.h |  4 ----
 src/openvpn/options.c | 40 ++++------------------------------------
 src/openvpn/options.h |  6 +-----
 src/openvpn/proxy.c   |  7 -------
 src/openvpn/proxy.h   |  4 ----
 src/openvpn/push.c    |  2 ++
 src/openvpn/socket.c  | 37 -------------------------------------
 src/openvpn/socket.h  | 13 -------------
 src/openvpn/socks.c   |  6 ------
 src/openvpn/socks.h   |  3 ---
 src/openvpn/syshead.h | 20 ++------------------
 16 files changed, 11 insertions(+), 213 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5a807cb..3a87dc2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -121,20 +121,6 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
-	[socks],
-	[AS_HELP_STRING([--disable-socks], [disable Socks support @<:@default=yes@:>@])],
-	,
-	[enable_socks="yes"]
-)
-
-AC_ARG_ENABLE(
-	[http-proxy],
-	[AS_HELP_STRING([--disable-http-proxy], [disable HTTP proxy support @<:@default=yes@:>@])],
-	,
-	[enable_http_proxy="yes"]
-)
-
-AC_ARG_ENABLE(
 	[fragment],
 	[AS_HELP_STRING([--disable-fragment], [disable internal fragmentation support (--fragment) @<:@default=yes@:>@])],
 	,
@@ -1051,8 +1037,6 @@ test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct
 test "${enable_multi}" = "yes" && AC_DEFINE([ENABLE_CLIENT_SERVER], [1], [Enable client/server capability])
 test "${enable_server}" = "no" && AC_DEFINE([ENABLE_CLIENT_ONLY], [1], [Enable client capability only])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
-test "${enable_socks}" = "yes" && AC_DEFINE([ENABLE_SOCKS], [1], [Enable Socks proxy support])
-test "${enable_http_proxy}" = "yes" && AC_DEFINE([ENABLE_HTTP_PROXY], [1], [Enable HTTP proxy support])
 test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
 test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index bb89aae..6dc8479 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -39,8 +39,6 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_HTTP_PROXY) || defined(ENABLE_PKCS11) || defined(ENABLE_CLIENT_CR) || defined(MANAGMENT_EXTERNAL_KEY)
-
 #include "base64.h"
 
 #include "memdbg.h"
@@ -163,7 +161,3 @@ openvpn_base64_decode(const char *str, void *data, int size)
     }
     return q - (unsigned char *) data;
 }
-
-#else
-static void dummy(void) {}
-#endif /* ENABLE_HTTP_PROXY, ENABLE_PKCS11, ENABLE_CLIENT_CR */
diff --git a/src/openvpn/base64.h b/src/openvpn/base64.h
index 28a9677..92a195a 100644
--- a/src/openvpn/base64.h
+++ b/src/openvpn/base64.h
@@ -34,11 +34,7 @@
 #ifndef _BASE64_H_
 #define _BASE64_H_
 
-#if defined(ENABLE_HTTP_PROXY) || defined(ENABLE_PKCS11) || defined(ENABLE_CLIENT_CR) || defined(MANAGMENT_EXTERNAL_KEY)
-
 int openvpn_base64_encode(const void *data, int size, char **str);
 int openvpn_base64_decode(const char *str, void *data, int size);
 
 #endif
-
-#endif
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e607859..a43361b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -611,8 +611,6 @@ check_timeout_random_component (struct context *c)
     tv_add (&c->c2.timeval, &c->c2.timeout_random_component);
 }
 
-#ifdef ENABLE_SOCKS
-
 /*
  * Handle addition and removal of the 10-byte Socks5 header
  * in UDP packets.
@@ -650,7 +648,6 @@ link_socket_write_post_size_adjust (int *size,
 	*size = 0;
     }
 }
-#endif
 
 /*
  * Output: c->c2.buf
@@ -719,10 +716,8 @@ read_incoming_link (struct context *c)
   /* check recvfrom status */
   check_status (status, "read", c->c2.link_socket, NULL);
 
-#ifdef ENABLE_SOCKS
   /* Remove socks header if applicable */
   socks_postprocess_incoming_link (c);
-#endif
 
   perf_pop ();
 }
@@ -1133,23 +1128,18 @@ process_outgoing_link (struct context *c)
 	  /* Packet send complexified by possible Socks5 usage */
 	  {
 	    struct link_socket_actual *to_addr = c->c2.to_link_addr;
-#ifdef ENABLE_SOCKS
 	    int size_delta = 0;
-#endif
 
-#ifdef ENABLE_SOCKS
 	    /* If Socks5 over UDP, prepend header */
 	    socks_preprocess_outgoing_link (c, &to_addr, &size_delta);
-#endif
+
 	    /* Send packet */
 	    size = link_socket_write (c->c2.link_socket,
 				      &c->c2.to_link,
 				      to_addr);
 
-#ifdef ENABLE_SOCKS
 	    /* Undo effect of prepend */
 	    link_socket_write_post_size_adjust (&size, size_delta, &c->c2.to_link);
-#endif
 	  }
 
 	  if (size > 0)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9530590..7dd61a2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -128,9 +128,6 @@ management_callback_proxy_cmd (void *arg, const char **p)
     {
       if (streq (p[1], "HTTP"))
         {
-#ifndef ENABLE_HTTP_PROXY
-          msg (M_WARN, "HTTP proxy support is not available");
-#else
           struct http_proxy_options *ho;
           if (ce->proto != PROTO_TCP && ce->proto != PROTO_TCP_CLIENT )
             {
@@ -143,17 +140,12 @@ management_callback_proxy_cmd (void *arg, const char **p)
           ho->retry = true;
           ho->auth_retry = (p[4] && streq (p[4], "nct") ? PAR_NCT : PAR_ALL);
           ret = true;
-#endif
         }
       else if (streq (p[1], "SOCKS"))
         {
-#ifndef ENABLE_SOCKS
-          msg (M_WARN, "SOCKS proxy support is not available");
-#else
           ce->socks_proxy_server = string_alloc (p[2], gc);
           ce->socks_proxy_port = p[3];
           ret = true;
-#endif
         }
     }
   else
@@ -441,41 +433,30 @@ init_query_passwords (struct context *c)
  * Initialize/Uninitialize HTTP or SOCKS proxy
  */
 
-#ifdef GENERAL_PROXY_SUPPORT
-
 static void
 uninit_proxy_dowork (struct context *c)
 {
-#ifdef ENABLE_HTTP_PROXY
   if (c->c1.http_proxy_owned && c->c1.http_proxy)
     {
       http_proxy_close (c->c1.http_proxy);
       c->c1.http_proxy = NULL;
       c->c1.http_proxy_owned = false;
     }
-#endif
-#ifdef ENABLE_SOCKS
   if (c->c1.socks_proxy_owned && c->c1.socks_proxy)
     {
       socks_proxy_close (c->c1.socks_proxy);
       c->c1.socks_proxy = NULL;
       c->c1.socks_proxy_owned = false;
     }
-#endif
 }
 
 static void
 init_proxy_dowork (struct context *c)
 {
-#ifdef ENABLE_HTTP_PROXY
   bool did_http = false;
-#else
-  const bool did_http = false;
-#endif
 
   uninit_proxy_dowork (c);
 
-#ifdef ENABLE_HTTP_PROXY
   if (c->options.ce.http_proxy_options)
     {
       /* Possible HTTP proxy user/pass input */
@@ -486,10 +467,8 @@ init_proxy_dowork (struct context *c)
 	  c->c1.http_proxy_owned = true;
 	}
     }
-#endif
 
-#ifdef ENABLE_SOCKS
-  if (!did_http && c->options.ce.socks_proxy_server)
+    if (!did_http && c->options.ce.socks_proxy_server)
     {
       c->c1.socks_proxy = socks_proxy_new (c->options.ce.socks_proxy_server,
 					   c->options.ce.socks_proxy_port,
@@ -500,7 +479,6 @@ init_proxy_dowork (struct context *c)
 	  c->c1.socks_proxy_owned = true;
 	}
     }
-#endif
 }
 
 static void
@@ -515,20 +493,6 @@ uninit_proxy (struct context *c)
    uninit_proxy_dowork (c);
 }
 
-#else
-
-static inline void
-init_proxy (struct context *c, const int scope)
-{
-}
-
-static inline void
-uninit_proxy (struct context *c)
-{
-}
-
-#endif
-
 void
 context_init_1 (struct context *c)
 {
@@ -2412,13 +2376,11 @@ do_init_frame (struct context *c)
     }
 #endif /* USE_COMP */
 
-#ifdef ENABLE_SOCKS
   /*
    * Adjust frame size for UDP Socks support.
    */
   if (c->options.ce.socks_proxy_server)
     socks_adjust_frame_parameters (&c->c2.frame, c->options.ce.proto);
-#endif
 
   /*
    * Adjust frame size based on the --tun-mtu-extra parameter.
@@ -2690,12 +2652,8 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ce.bind_ipv6_only,
 			   mode,
 			   c->c2.accept_from,
-#ifdef ENABLE_HTTP_PROXY
 			   c->c1.http_proxy,
-#endif
-#ifdef ENABLE_SOCKS
 			   c->c1.socks_proxy,
-#endif
 #ifdef ENABLE_DEBUG
 			   c->options.gremlin,
 #endif
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4f9c4d1..eab8cd5 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -188,17 +188,13 @@ struct context_1
   struct status_output *status_output;
   bool status_output_owned;
 
-#ifdef ENABLE_HTTP_PROXY
   /* HTTP proxy object */
   struct http_proxy_info *http_proxy;
   bool http_proxy_owned;
-#endif
 
-#ifdef ENABLE_SOCKS
   /* SOCKS proxy object */
   struct socks_proxy_info *socks_proxy;
   bool socks_proxy_owned;
-#endif
 
 #if P2MP
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a8cebb..fc76461 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -140,7 +140,6 @@ static const char usage_message[] =
   "                    between connection retries (default=%d).\n"
   "--connect-timeout n : For --proto tcp-client, connection timeout (in seconds).\n"
   "--connect-retry-max n : Maximum connection attempt retries, default infinite.\n"
-#ifdef ENABLE_HTTP_PROXY
   "--http-proxy s p [up] [auth] : Connect to remote host\n"
   "                  through an HTTP proxy at address s and port p.\n"
   "                  If proxy authentication is required,\n"
@@ -156,15 +155,12 @@ static const char usage_message[] =
   "                                  Repeat to set multiple options.\n"
   "                  VERSION version (default=1.0)\n"
   "                  AGENT user-agent\n"
-#endif
-#ifdef ENABLE_SOCKS
   "--socks-proxy s [p] [up] : Connect to remote host through a Socks5 proxy at\n"
   "                  address s and port p (default port = 1080).\n"
   "                  If proxy authentication is required,\n"
   "                  up is a file containing username/password on 2 lines, or\n"
   "                  'stdin' to prompt for console.\n"
   "--socks-proxy-retry : Retry indefinitely on Socks proxy errors.\n"
-#endif
   "--resolv-retry n: If hostname resolve fails for --remote, retry\n"
   "                  resolve for n seconds before failing (disabled by default).\n"
   "                  Set n=\"infinite\" to retry indefinitely.\n"
@@ -177,12 +173,8 @@ static const char usage_message[] =
   "--rport port    : TCP/UDP port # for remote (default=%s).\n"
   "--bind          : Bind to local address and port. (This is the default unless\n"
   "                  --proto tcp-client"
-#ifdef ENABLE_HTTP_PROXY
                    " or --http-proxy"
-#endif
-#ifdef ENABLE_SOCKS
                    " or --socks-proxy"
-#endif
                    " is used).\n"
   "--nobind        : Do not bind to local address and port.\n"
   "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device.\n"
@@ -910,20 +902,16 @@ setenv_connection_entry (struct env_set *es,
   setenv_str_i (es, "remote", e->remote, i);
   setenv_str_i (es, "remote_port", e->remote_port, i);
 
-#ifdef ENABLE_HTTP_PROXY
   if (e->http_proxy_options)
     {
       setenv_str_i (es, "http_proxy_server", e->http_proxy_options->server, i);
       setenv_str_i (es, "http_proxy_port", e->http_proxy_options->port, i);
     }
-#endif
-#ifdef ENABLE_SOCKS
   if (e->socks_proxy_server)
     {
       setenv_str_i (es, "socks_proxy_server", e->socks_proxy_server, i);
       setenv_str_i (es, "socks_proxy_port", e->socks_proxy_port, i);
     }
-#endif
 }
 
 void
@@ -1288,7 +1276,7 @@ option_iroute_ipv6 (struct options *o,
 #endif /* P2MP_SERVER */
 #endif /* P2MP */
 
-#if defined(ENABLE_HTTP_PROXY) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
 static void
 show_http_proxy_options (const struct http_proxy_options *o)
 {
@@ -1363,15 +1351,11 @@ show_connection_entry (const struct connection_entry *o)
   SHOW_INT (connect_retry_seconds);
   SHOW_INT (connect_timeout);
 
-#ifdef ENABLE_HTTP_PROXY
   if (o->http_proxy_options)
     show_http_proxy_options (o->http_proxy_options);
-#endif
-#ifdef ENABLE_SOCKS
   SHOW_STR (socks_proxy_server);
   SHOW_STR (socks_proxy_port);
   SHOW_BOOL (socks_proxy_retry);
-#endif
   SHOW_INT (tun_mtu);
   SHOW_BOOL (tun_mtu_defined);
   SHOW_INT (link_mtu);
@@ -1689,7 +1673,7 @@ show_settings (const struct options *o)
 #undef SHOW_INT
 #undef SHOW_BOOL
 
-#if HTTP_PROXY_OVERRIDE
+#ifdef ENABLE_MANAGEMENT
 
 static struct http_proxy_options *
 parse_http_proxy_override (const char *server,
@@ -1978,22 +1962,16 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
   if (!ce->remote && ce->proto == PROTO_TCP_CLIENT)
     msg (M_USAGE, "--remote MUST be used in TCP Client mode");
 
-#ifdef ENABLE_HTTP_PROXY
   if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
     msg (M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
   if ((ce->http_proxy_options) && !ce->http_proxy_options->server)
     msg (M_USAGE, "--http-proxy not specified but other http proxy options present");
-#endif
 
-#if defined(ENABLE_HTTP_PROXY) && defined(ENABLE_SOCKS)
   if (ce->http_proxy_options && ce->socks_proxy_server)
     msg (M_USAGE, "--http-proxy can not be used together with --socks-proxy");
-#endif
 
-#ifdef ENABLE_SOCKS
   if (ce->socks_proxy_server && ce->proto == PROTO_TCP_SERVER)
     msg (M_USAGE, "--socks-proxy can not be used in TCP Server mode");
-#endif
 
   if (ce->proto == PROTO_TCP_SERVER && (options->connection_list->len > 1))
     msg (M_USAGE, "TCP server mode allows at most one --remote address");
@@ -2027,14 +2005,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--remote cannot be used with --mode server");
       if (!ce->bind_local)
 	msg (M_USAGE, "--nobind cannot be used with --mode server");
-#ifdef ENABLE_HTTP_PROXY
       if (ce->http_proxy_options)
 	msg (M_USAGE, "--http-proxy cannot be used with --mode server");
-#endif
-#ifdef ENABLE_SOCKS
       if (ce->socks_proxy_server)
 	msg (M_USAGE, "--socks-proxy cannot be used with --mode server");
-#endif
       /* <connection> blocks force to have a remote embedded, so we check for the
        * --remote and bail out if it  is present */
        if (options->connection_list->len >1 ||
@@ -2376,10 +2350,8 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
   if (ce->proto == PROTO_TCP_CLIENT && !ce->local && !ce->local_port_defined && !ce->bind_defined)
     ce->bind_local = false;
 
-#ifdef ENABLE_SOCKS
   if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local && !ce->local_port_defined && !ce->bind_defined)
     ce->bind_local = false;
-#endif
 
   if (!ce->bind_local)
     ce->local_port = NULL;
@@ -2528,7 +2500,7 @@ options_postprocess_mutate (struct options *o)
   for (i = 0; i < o->connection_list->len; ++i)
 	options_postprocess_mutate_ce (o, o->connection_list->array[i]);
 
-#if HTTP_PROXY_OVERRIDE
+#if ENABLE_MANAGEMENT
   if (o->http_proxy_override)
 	options_postprocess_http_proxy_override(o);
 #endif
@@ -4500,7 +4472,7 @@ add_option (struct options *options,
 
       options->ignore_unknown_option[i] = NULL;
     }
-#if HTTP_PROXY_OVERRIDE
+#if ENABLE_MANAGEMENT
   else if (streq (p[0], "http-proxy-override") && p[1] && p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -5012,7 +4984,6 @@ add_option (struct options *options,
 	}
       options->proto_force = proto_force;
     }
-#ifdef ENABLE_HTTP_PROXY
   else if (streq (p[0], "http-proxy") && p[1])
     {
       struct http_proxy_options *ho;
@@ -5119,8 +5090,6 @@ add_option (struct options *options,
 	  msg (msglevel, "Bad http-proxy-option or missing parameter: '%s'", p[1]);
 	}
     }
-#endif
-#ifdef ENABLE_SOCKS
   else if (streq (p[0], "socks-proxy") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
@@ -5141,7 +5110,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       options->ce.socks_proxy_retry = true;
     }
-#endif
   else if (streq (p[0], "keepalive") && p[1] && p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 30f09da..21c210e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -98,15 +98,11 @@ struct connection_entry
   int connect_retry_seconds;
   int connect_timeout;
   bool connect_timeout_defined;
-#ifdef ENABLE_HTTP_PROXY
   struct http_proxy_options *http_proxy_options;
-#endif  
-#ifdef ENABLE_SOCKS
   const char *socks_proxy_server;
   const char *socks_proxy_port;
   const char *socks_proxy_authfile;
   bool socks_proxy_retry;
-#endif
 
   int tun_mtu;           /* MTU of tun device */
   bool tun_mtu_defined;  /* true if user overriding parm with command line option */
@@ -215,7 +211,7 @@ struct options
   /* Counts the number of unsuccessful connection attempts */
   unsigned int unsuccessful_attempts;
 
-#if HTTP_PROXY_OVERRIDE
+#if ENABLE_MANAGEMENT
   struct http_proxy_options *http_proxy_override;
 #endif
 
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index f7f0648..2568e19 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -42,8 +42,6 @@
 #include "ntlm.h"
 #include "memdbg.h"
 
-#ifdef ENABLE_HTTP_PROXY
-
 #define UP_TYPE_PROXY        "HTTP Proxy"
 
 struct http_proxy_options *
@@ -945,8 +943,3 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
   gc_free (&gc);
   return ret;
 }
-
-#else
-static void dummy(void) {}
-#endif /* ENABLE_HTTP_PROXY */
-
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 0e7a6df..4715940 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -28,8 +28,6 @@
 #include "buffer.h"
 #include "misc.h"
 
-#ifdef ENABLE_HTTP_PROXY
-
 /* HTTP CONNECT authentication methods */
 #define HTTP_AUTH_NONE   0
 #define HTTP_AUTH_BASIC  1
@@ -94,6 +92,4 @@ bool establish_http_proxy_passthru (struct http_proxy_info *p,
 uint8_t *make_base64_string2 (const uint8_t *str, int str_len, struct gc_arena *gc);
 uint8_t *make_base64_string (const uint8_t *str, struct gc_arena *gc);
 
-#endif /* ENABLE_HTTP_PROXY */
-
 #endif /* PROXY_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ea788b0..24d12c7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -68,6 +68,7 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	  ASSERT (0);
 	}
       c->sig->signal_text = "auth-failure";
+#ifdef ENABLE_MANAGEMENT
       if (management)
 	{
 	  const char *reason = NULL;
@@ -76,6 +77,7 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	    reason = BSTR (&buf);
 	  management_auth_failure (management, UP_TYPE_AUTH, reason);
 	} else
+#endif
 	{
 #ifdef ENABLE_CLIENT_CR
 	  struct buffer buf = *buffer;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0b3d7ad..9e6bd10 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -841,12 +841,10 @@ static void bind_local (struct link_socket *sock, const sa_family_t ai_family)
     /* bind to local address/port */
     if (sock->bind_local)
       {
-#ifdef ENABLE_SOCKS
         if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
             socket_bind (sock->ctrl_sd, sock->info.lsa->bind_local,
 			 ai_family, "SOCKS", false);
         else
-#endif
             socket_bind (sock->sd, sock->info.lsa->bind_local,
 			 ai_family,
                          "TCP/UDP", sock->info.bind_ipv6_only);
@@ -861,7 +859,6 @@ create_socket (struct link_socket* sock, struct addrinfo* addr)
       sock->sd = create_socket_udp (addr, sock->sockflags);
       sock->sockflags |= SF_GETADDRINFO_DGRAM;
 
-#ifdef ENABLE_SOCKS
       /* Assume that control socket and data socket to the socks proxy
        * are using the same IP family */
       if (sock->socks_proxy)
@@ -874,7 +871,6 @@ create_socket (struct link_socket* sock, struct addrinfo* addr)
 	  addrinfo_tmp.ai_protocol = IPPROTO_TCP;
 	  sock->ctrl_sd = create_socket_tcp (&addrinfo_tmp);
 	}
-#endif
     }
   else if (addr->ai_protocol == IPPROTO_TCP || addr->ai_socktype == SOCK_STREAM)
     {
@@ -1494,9 +1490,7 @@ link_socket_new (void)
 
   ALLOC_OBJ_CLEAR (sock, struct link_socket);
   sock->sd = SOCKET_UNDEFINED;
-#ifdef ENABLE_SOCKS
   sock->ctrl_sd = SOCKET_UNDEFINED;
-#endif
   return sock;
 }
 
@@ -1512,12 +1506,8 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 bool bind_ipv6_only,
 			 int mode,
 			 const struct link_socket *accept_from,
-#ifdef ENABLE_HTTP_PROXY
 			 struct http_proxy_info *http_proxy,
-#endif
-#ifdef ENABLE_SOCKS
 			 struct socks_proxy_info *socks_proxy,
-#endif
 #ifdef ENABLE_DEBUG
 			 int gremlin,
 #endif
@@ -1542,15 +1532,8 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->remote_host = remote_host;
   sock->remote_port = remote_port;
   sock->dns_cache = dns_cache;
-
-#ifdef ENABLE_HTTP_PROXY
   sock->http_proxy = http_proxy;
-#endif
-
-#ifdef ENABLE_SOCKS
   sock->socks_proxy = socks_proxy;
-#endif
-
   sock->bind_local = bind_local;
   sock->inetd = inetd;
   sock->resolve_retry_seconds = resolve_retry_seconds;
@@ -1586,7 +1569,6 @@ link_socket_init_phase1 (struct link_socket *sock,
 
   if (false)
     ;
-#ifdef ENABLE_HTTP_PROXY
   /* are we running in HTTP proxy mode? */
   else if (sock->http_proxy)
     {
@@ -1601,8 +1583,6 @@ link_socket_init_phase1 (struct link_socket *sock,
       sock->proxy_dest_host = remote_host;
       sock->proxy_dest_port = remote_port;
     }
-#endif
-#ifdef ENABLE_SOCKS
   /* or in Socks proxy mode? */
   else if (sock->socks_proxy)
     {
@@ -1616,7 +1596,6 @@ link_socket_init_phase1 (struct link_socket *sock,
       sock->proxy_dest_host = remote_host;
       sock->proxy_dest_port = remote_port;
     }
-#endif
   else
     {
       sock->remote_host = remote_host;
@@ -1702,10 +1681,8 @@ phase2_set_socket_flags (struct link_socket* sock)
      scripts don't have access to it */
   set_cloexec (sock->sd);
 
-#ifdef ENABLE_SOCKS
   if (socket_defined (sock->ctrl_sd))
     set_cloexec (sock->ctrl_sd);
-#endif
 
   /* set Path MTU discovery options on the socket */
   set_mtu_discover_type (sock->sd, sock->mtu_discover_type);
@@ -1798,11 +1775,7 @@ phase2_tcp_server (struct link_socket *sock, const char *remote_dynamic,
 static void
 phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 {
-#ifdef GENERAL_PROXY_SUPPORT
   bool proxy_retry = false;
-#else
-  const bool proxy_retry = false;
-#endif
   do {
     socket_connect (&sock->sd,
                    sock->info.lsa->current_remote->ai_addr,
@@ -1814,7 +1787,6 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 
     if (false)
       ;
-#ifdef ENABLE_HTTP_PROXY
     else if (sock->http_proxy)
       {
 	proxy_retry = establish_http_proxy_passthru (sock->http_proxy,
@@ -1824,8 +1796,6 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 						     &sock->stream_buf.residual,
 						     &sig_info->signal_received);
       }
-#endif
-#ifdef ENABLE_SOCKS
     else if (sock->socks_proxy)
       {
 	establish_socks_proxy_passthru (sock->socks_proxy,
@@ -1834,7 +1804,6 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 					sock->proxy_dest_port,
 					&sig_info->signal_received);
       }
-#endif
     if (proxy_retry)
       {
 	openvpn_close_socket (sock->sd);
@@ -1845,7 +1814,6 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 
 }
 
-#ifdef ENABLE_SOCKS
 static void
 phase2_socks_client (struct link_socket *sock, struct signal_info *sig_info)
 {
@@ -1879,7 +1847,6 @@ phase2_socks_client (struct link_socket *sock, struct signal_info *sig_info)
 
     resolve_remote (sock, 1, NULL, &sig_info->signal_received);
 }
-#endif
 
 /* finalize socket initialization */
 void
@@ -1965,11 +1932,9 @@ link_socket_init_phase2 (struct link_socket *sock,
 	  phase2_tcp_client (sock, sig_info);
 
 	}
-#ifdef ENABLE_SOCKS
       else if (sock->info.proto == PROTO_UDP && sock->socks_proxy)
 	{
 	  phase2_socks_client (sock, sig_info);
-#endif
 	}
 #ifdef TARGET_ANDROID
       if (sock->sd != -1)
@@ -2022,14 +1987,12 @@ link_socket_close (struct link_socket *sock)
 #endif
 	}
 
-#ifdef ENABLE_SOCKS
       if (socket_defined (sock->ctrl_sd))
 	{
 	  if (openvpn_close_socket (sock->ctrl_sd))
 	    msg (M_WARN | M_ERRNO, "TCP/UDP: Close Socket (ctrl_sd) failed");
 	  sock->ctrl_sd = SOCKET_UNDEFINED;
 	}
-#endif
 
       stream_buf_close (&sock->stream_buf);
       free_buf (&sock->stream_buf_data);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bffa039..8e157c6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -172,10 +172,7 @@ struct link_socket
   struct link_socket_info info;
 
   socket_descriptor_t sd;
-
-#ifdef ENABLE_SOCKS
   socket_descriptor_t ctrl_sd;  /* only used for UDP over Socks */
-#endif
 
 #ifdef WIN32
   struct overlapped_io reads;
@@ -228,22 +225,16 @@ struct link_socket
   struct buffer stream_buf_data;
   bool stream_reset;
 
-#ifdef ENABLE_HTTP_PROXY
   /* HTTP proxy */
   struct http_proxy_info *http_proxy;
-#endif
 
-#ifdef ENABLE_SOCKS
   /* Socks proxy */
   struct socks_proxy_info *socks_proxy;
   struct link_socket_actual socks_relay; /* Socks UDP relay address */
-#endif
 
-#if defined(ENABLE_HTTP_PROXY) || defined(ENABLE_SOCKS)
   /* The OpenVPN server we will use the proxy to connect to */
   const char *proxy_dest_host;
   const char *proxy_dest_port;
-#endif
 
 #if PASSTOS_CAPABILITY
   /* used to get/set TOS. */
@@ -321,12 +312,8 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 bool bind_ipv6_only,
 			 int mode,
 			 const struct link_socket *accept_from,
-#ifdef ENABLE_HTTP_PROXY
 			 struct http_proxy_info *http_proxy,
-#endif
-#ifdef ENABLE_SOCKS
 			 struct socks_proxy_info *socks_proxy,
-#endif
 #ifdef ENABLE_DEBUG
 			 int gremlin,
 #endif
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 6e29e7a..72bdf55 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -38,8 +38,6 @@
 
 #include "syshead.h"
 
-#ifdef ENABLE_SOCKS
-
 #include "common.h"
 #include "misc.h"
 #include "win32.h"
@@ -574,7 +572,3 @@ socks_process_outgoing_udp (struct buffer *buf,
 
   return 10;
 }
-
-#else
-static void dummy(void) {}
-#endif /* ENABLE_SOCKS */
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 30b957d..2475261 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -30,8 +30,6 @@
 #ifndef SOCKS_H
 #define SOCKS_H
 
-#ifdef ENABLE_SOCKS
-
 #include "buffer.h"
 
 struct openvpn_sockaddr;
@@ -74,4 +72,3 @@ int socks_process_outgoing_udp (struct buffer *buf,
 				const struct link_socket_actual *to);
 
 #endif
-#endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3a789bc..fb07160 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -608,7 +608,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Should we include NTLM proxy functionality
  */
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_HTTP_PROXY)
+#if defined(ENABLE_CRYPTO)
 #define NTLM 1
 #else
 #define NTLM 0
@@ -617,20 +617,13 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Should we include proxy digest auth functionality
  */
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_HTTP_PROXY)
+#if defined(ENABLE_CRYPTO)
 #define PROXY_DIGEST_AUTH 1
 #else
 #define PROXY_DIGEST_AUTH 0
 #endif
 
 /*
- * Should we include code common to all proxy methods?
- */
-#if defined(ENABLE_HTTP_PROXY) || defined(ENABLE_SOCKS)
-#define GENERAL_PROXY_SUPPORT
-#endif
-
-/*
  * Do we have CryptoAPI capability?
  */
 #if defined(WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
@@ -669,15 +662,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Should we include http proxy override functionality
- */
-#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_HTTP_PROXY)
-#define HTTP_PROXY_OVERRIDE 1
-#else
-#define HTTP_PROXY_OVERRIDE 0
-#endif
-
-/*
  * Reduce sensitivity to system clock instability
  * and backtracks.
  */
-- 
1.8.5.2 (Apple Git-48)


