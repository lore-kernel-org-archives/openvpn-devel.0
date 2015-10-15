From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Oct 2015 16:38:32 +0200
Message-Id: <1444919912-4432-1-git-send-email-arne@...1227...>
References: <1442309019-7586-9-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH V2] Remove http-proxy-timeout,
	socks timeout and set default of server-poll-timeout to 120s
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

With this change all timeouts before the first packet from the OpenVPN server are unified into the server-poll-timeout option.

The default of 120s has been chosen to be a safe value is larger as it is larger the sums of the old small timeouts.

Patch V2: Fix a regression with --static
---
 android-config/config.h      |  2 +-
 doc/openvpn.8                | 33 ++++++++-------------------------
 src/openvpn/forward-inline.h |  2 +-
 src/openvpn/forward.c        | 22 ++++++++++++++++------
 src/openvpn/forward.h        |  2 +-
 src/openvpn/init.c           | 33 +++++++++++++++++----------------
 src/openvpn/interval.h       |  9 +++++++++
 src/openvpn/openvpn.h        |  6 ++++--
 src/openvpn/options.c        | 38 +++++++-------------------------------
 src/openvpn/options.h        |  3 ---
 src/openvpn/proxy.c          | 22 ++++++++++++++--------
 src/openvpn/proxy.h          |  2 +-
 src/openvpn/socket.c         | 10 ++++++----
 src/openvpn/socket.h         |  7 +++++--
 14 files changed, 90 insertions(+), 101 deletions(-)

diff --git a/android-config/config.h b/android-config/config.h
index 7ba9be6..e0f857d 100644
--- a/android-config/config.h
+++ b/android-config/config.h
@@ -348,7 +348,7 @@
 #define HAVE_STROPTS_H 1
 
 /* Define to 1 if you have the `syslog' function. */
- #define HAVE_SYSLOG 1
+#define HAVE_SYSLOG 1
 
 /* Define to 1 if you have the <syslog.h> header file. */
 #define HAVE_SYSLOG_H 1
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a86409..b8fb2e5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -354,11 +354,10 @@ block:
 .B explicit\-exit\-notify,
 .B float,
 .B fragment,
-.B http\-proxy,
-.B http\-proxy\-option,
-.B http\-proxy\-retry,
-.B http\-proxy\-timeout,
-.B link\-mtu,
+.B http-proxy,
+.B http-proxy-option,
+.B http-proxy-retry,
+.B link-mtu,
 .B local,
 .B lport,
 .B mssfix,
@@ -473,14 +472,6 @@ Wait
 seconds  between connection attempts (default=5).
 .\"*********************************************************
 .TP
-.B \-\-connect\-timeout n
-For
-.B \-\-proto tcp\-client,
-set connection timeout to
-.B n
-seconds (default=10).
-.\"*********************************************************
-.TP
 .B \-\-connect\-retry\-max n
 .B n
 specifies the number of times all
@@ -538,12 +529,6 @@ Retry indefinitely on HTTP proxy errors.  If an HTTP proxy error
 occurs, simulate a SIGUSR1 reset.
 .\"*********************************************************
 .TP
-.B \-\-http\-proxy\-timeout n
-Set proxy timeout to
-.B n
-seconds, default=5.
-.\"*********************************************************
-.TP
 .B \-\-http\-proxy\-option type [parm]
 Set extended HTTP proxy options.
 Repeat to set multiple options.
@@ -3823,14 +3808,12 @@ description of the OpenVPN challenge/response protocol.
 .\"*********************************************************
 .TP
 .B \-\-server\-poll\-timeout n
-when polling possible remote servers to connect to
-in a round-robin fashion, spend no more than
+.B \-\-connect\-timeout n
+when connecting to a remote server do not wait for more than
 .B n
 seconds waiting for a response before trying the next server.
-As this only makes sense in client-to-server setups, it cannot
-be used in point-to-point setups using
-.B \-\-secret
-symmetrical key mode.
+The default value is 120s. This timeout includes proxy and TCP
+connect timeouts.
 .\"*********************************************************
 .TP
 .B \-\-explicit\-exit\-notify [n]
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index 0ca6692..5d4e308 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -125,7 +125,7 @@ check_server_poll_timeout (struct context *c)
 {
   void check_server_poll_timeout_dowork (struct context *c);
 
-  if (c->options.server_poll_timeout
+  if (c->options.ce.connect_timeout
       && event_timeout_trigger (&c->c2.server_poll_interval, &c->c2.timeval, ETT_DEFAULT))
     check_server_poll_timeout_dowork (c);
 }
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 62eb6fc..eb94ca6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -322,6 +322,13 @@ check_inactivity_timeout_dowork (struct context *c)
   register_signal (c, SIGTERM, "inactive");
 }
 
+int
+get_server_poll_remaining_time (struct event_timeout* server_poll_timeout)
+{
+    update_time();
+    int remaining = event_timeout_remaining(server_poll_timeout);
+    return max_int (0, remaining);
+}
 #if P2MP
 
 void
@@ -533,13 +540,16 @@ process_coarse_timers (struct context *c)
     return;
 
 #if P2MP
-  check_server_poll_timeout (c);
-  if (c->sig->signal_received)
-    return;
+  if (c->c2.tls_multi)
+    {
+      check_server_poll_timeout (c);
+      if (c->sig->signal_received)
+	return;
 
-  check_scheduled_exit (c);
-  if (c->sig->signal_received)
-    return;
+      check_scheduled_exit (c);
+      if (c->sig->signal_received)
+	return;
+    }
 #endif
 
 #ifdef ENABLE_OCC
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index af3b0a6..0856aa7 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -103,7 +103,7 @@ void show_wait_status (struct context *c);
  *     once for each remaining fragment with this parameter set to false.
  */
 void encrypt_sign (struct context *c, bool comp_frag);
-
+int get_server_poll_remaining_time (struct event_timeout* server_poll_timeout);
 
 /**********************************************************************/
 /**
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5dd8781..6045f68 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1052,6 +1052,19 @@ reset_coarse_timers (struct context *c)
 }
 
 /*
+ * Initialize the server poll timeout timer
+ * Thie timer is used in the http/socks proxy setup so it needs to be setup
+ * before
+ */
+static void
+do_init_server_poll_timer (struct context *c)
+{
+    update_time ();
+    if (c->options.ce.connect_timeout)
+	event_timeout_init (&c->c2.server_poll_interval, c->options.ce.connect_timeout, now);
+}
+
+/*
  * Initialize timers
  */
 static void
@@ -1072,11 +1085,6 @@ do_init_timers (struct context *c, bool deferred)
   if (c->options.ping_rec_timeout)
     event_timeout_init (&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
 
-#if P2MP
-  if (c->options.server_poll_timeout)
-    event_timeout_init (&c->c2.server_poll_interval, c->options.server_poll_timeout, now);
-#endif
-
   if (!deferred)
     {
       /* initialize connection establishment timer */
@@ -1878,11 +1886,6 @@ socket_restart_pause (struct context *c)
 #if P2MP
   if (auth_retry_get () == AR_NOINTERACT)
     sec = 10;
-
-#if 0 /* not really needed because of c->persist.restart_sleep_seconds */
-  if (c->options.server_poll_timeout && sec > 1)
-    sec = 1;
-#endif
 #endif
 
   if (c->persist.restart_sleep_seconds > 0 && c->persist.restart_sleep_seconds > sec)
@@ -2554,11 +2557,6 @@ do_option_warnings (struct context *c)
     msg (M_WARN, "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
 #endif
 
-#ifndef CONNECT_NONBLOCK
-  if (o->ce.connect_timeout_defined)
-    msg (M_WARN, "NOTE: --connect-timeout option is not supported on this OS");
-#endif
-
   /* If a script is used, print appropiate warnings */
   if (o->user_script_used)
    {
@@ -2713,11 +2711,11 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ipchange,
 			   c->plugins,
 			   c->options.resolve_retry_seconds,
-			   c->options.ce.connect_timeout,
 			   c->options.ce.mtu_discover_type,
 			   c->options.rcvbuf,
 			   c->options.sndbuf,
 			   c->options.mark,
+			   &c->c2.server_poll_interval,
 			   sockflags);
 }
 
@@ -3545,6 +3543,9 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
    */
   do_uid_gid_chroot (c, c->c2.did_open_tun);
 
+  /* initialse connect timeout timer */
+  do_init_server_poll_timer(c);
+
   /* finalize the TCP/UDP socket */
   if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     do_init_socket_2 (c);
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 4814ec9..59eb1f6 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -186,6 +186,15 @@ event_timeout_modify_wakeup (struct event_timeout* et, interval_t n)
 }
 
 /*
+ * Will return the time left for a timeout, this function does not check
+ * if the timeout is actually valid
+ */
+static inline interval_t event_timeout_remaining (struct event_timeout* et)
+{
+   return (int) et->last + et->n - now;
+}
+
+/*
  * This is the principal function for testing and triggering recurring
  * timers and will return true on a timer signal event.
  * If et_const_retry == ETT_DEFAULT and a signal occurs,
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4fab00b..33aaf93 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -416,6 +416,10 @@ struct context_2
   time_t update_timeout_random_component;
   struct timeval timeout_random_component;
 
+  /* Timer for everything up to the first packet from the *OpenVPN* server
+   * socks, http proxy, and tcp packets do not count */
+  struct event_timeout server_poll_interval;
+
   /* indicates that the do_up_delay function has run */
   bool do_up_ran;
 
@@ -471,8 +475,6 @@ struct context_2
   md_ctx_t pulled_options_state;
   struct md5_digest pulled_options_digest;
 
-  struct event_timeout server_poll_interval;
-
   struct event_timeout scheduled_exit;
   int scheduled_exit_signal;
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6823167..55db81a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -125,7 +125,6 @@ static const char usage_message[] =
   "                  p = udp6, tcp6-server, or tcp6-client (ipv6)\n"
   "--connect-retry n : For --proto tcp-client, number of seconds to wait\n"
   "                    between connection retries (default=%d).\n"
-  "--connect-timeout n : For --proto tcp-client, connection timeout (in seconds).\n"
   "--connect-retry-max n : Maximum connection attempt retries, default infinite.\n"
   "--http-proxy s p [up] [auth] : Connect to remote host\n"
   "                  through an HTTP proxy at address s and port p.\n"
@@ -137,7 +136,6 @@ static const char usage_message[] =
   "                  determine auth method and query for username/password\n"
   "                  if needed.  auto-nct disables weak proxy auth methods.\n"
   "--http-proxy-retry     : Retry indefinitely on HTTP proxy errors.\n"
-  "--http-proxy-timeout n : Proxy timeout in seconds, default=5.\n"
   "--http-proxy-option type [parm] : Set extended HTTP proxy options.\n"
   "                                  Repeat to set multiple options.\n"
   "                  VERSION version (default=1.0)\n"
@@ -485,7 +483,7 @@ static const char usage_message[] =
   "                  none (default), interact, or nointeract.\n"
   "--static-challenge t e : Enable static challenge/response protocol using\n"
   "                  challenge text t, with e indicating echo flag (0|1)\n"
-  "--server-poll-timeout n : when polling possible remote servers to connect to\n"
+  "--connect-timeout n : when polling possible remote servers to connect to\n"
   "                  in a round-robin fashion, spend no more than n seconds\n"
   "                  waiting for a response before trying the next server.\n"
 #endif
@@ -759,7 +757,7 @@ init_options (struct options *o, const bool init_gc)
   o->ce.af = AF_UNSPEC;
   o->ce.bind_ipv6_only = false;
   o->ce.connect_retry_seconds = 5;
-  o->ce.connect_timeout = 10;
+  o->ce.connect_timeout = 120;
   o->connect_retry_max = 0;
   o->ce.local_port = o->ce.remote_port = OPENVPN_PORT;
   o->verbosity = 1;
@@ -814,7 +812,6 @@ init_options (struct options *o, const bool init_gc)
 #endif
 #if P2MP
   o->scheduled_exit_interval = 5;
-  o->server_poll_timeout = 0;
 #endif
 #ifdef ENABLE_CRYPTO
   o->ciphername = "BF-CBC";
@@ -1277,7 +1274,6 @@ show_http_proxy_options (const struct http_proxy_options *o)
   SHOW_STR (auth_method_string);
   SHOW_STR (auth_file);
   SHOW_BOOL (retry);
-  SHOW_INT (timeout);
   SHOW_STR (http_version);
   SHOW_STR (user_agent);
   for  (i=0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name;i++)
@@ -1681,7 +1677,6 @@ parse_http_proxy_override (const char *server,
       ho->server = string_alloc(server, gc);
       ho->port = port;
       ho->retry = true;
-      ho->timeout = 5;
       if (flags && !strcmp(flags, "nct"))
 	ho->auth_retry = PAR_NCT;
       else
@@ -1850,13 +1845,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     msg (M_USAGE, "--lladdr can only be used in --dev tap mode");
  
   /*
-   * Sanity check on TCP mode options
-   */
-  if (ce->connect_timeout_defined && ce->proto != PROTO_TCP_CLIENT)
-    msg (M_USAGE, "--connect-timeout doesn't make sense unless also used with "
-	 "--proto tcp-client or tcp6-client");
-
-  /*
    * Sanity check on MTU parameters
    */
   if (options->ce.tun_mtu_defined && options->ce.link_mtu_defined)
@@ -2304,9 +2292,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (pkcs11_id);
       MUST_BE_UNDEF (pkcs11_id_management);
 #endif
-#if P2MP
-      MUST_BE_UNDEF (server_poll_timeout);
-#endif
 
       if (pull)
 	msg (M_USAGE, err, "--pull");
@@ -4586,11 +4571,11 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       options->ce.connect_retry_seconds = positive_atoi (p[1]);
     }
-  else if (streq (p[0], "connect-timeout") && p[1] && !p[2])
+  else if ((streq (p[0], "connect-timeout") || streq (p[0], "server-poll-timeout"))
+	    && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       options->ce.connect_timeout = positive_atoi (p[1]);
-      options->ce.connect_timeout_defined = true;
     }
   else if (streq (p[0], "connect-retry-max") && p[1] && !p[2])
     {
@@ -5083,11 +5068,9 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "http-proxy-timeout") && p[1] && !p[2])
     {
-      struct http_proxy_options *ho;
-
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
-      ho->timeout = positive_atoi (p[1]);
+      msg (M_WARN, "DEPRECATED OPTION: http-proxy-timeout: In OpenVPN 2.4 the timeout until a connection to a "
+	   "server is established is managed with a single timeout set by connect-timeout");
     }
   else if (streq (p[0], "http-proxy-option") && p[1] && !p[4])
     {
@@ -5408,12 +5391,10 @@ add_option (struct options *options,
 	  options->push_peer_info = true;
 	}
 #endif
-#if P2MP
       else if (streq (p[1], "SERVER_POLL_TIMEOUT") && p[2])
 	{
-	  options->server_poll_timeout = positive_atoi(p[2]);
+	  options->ce.connect_timeout = positive_atoi(p[2]);
 	}
-#endif
       else
 	{
 	  if (streq (p[1], "FORWARD_COMPATIBLE") && p[2] && streq (p[2], "1"))
@@ -5927,11 +5908,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_PULL_MODE);
       options->push_continuation = atoi(p[1]);
     }
-  else if (streq (p[0], "server-poll-timeout") && p[1] && !p[2])
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->server_poll_timeout = positive_atoi(p[1]);
-    }
   else if (streq (p[0], "auth-user-pass") && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c642aa0..dd08a46 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -97,7 +97,6 @@ struct connection_entry
   bool bind_local;
   int connect_retry_seconds;
   int connect_timeout;
-  bool connect_timeout_defined;
   struct http_proxy_options *http_proxy_options;
   const char *socks_proxy_server;
   const char *socks_proxy_port;
@@ -459,8 +458,6 @@ struct options
   const char *auth_user_pass_file;
   struct options_pre_pull *pre_pull;
 
-  int server_poll_timeout;
-
   int scheduled_exit_interval;
 
 #ifdef ENABLE_CLIENT_CR
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 2568e19..706e642 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -41,6 +41,7 @@
 #include "httpdigest.h"
 #include "ntlm.h"
 #include "memdbg.h"
+#include "forward.h"
 
 #define UP_TYPE_PROXY        "HTTP Proxy"
 
@@ -52,7 +53,6 @@ init_http_proxy_options_once (struct http_proxy_options **hpo,
     {
       ALLOC_OBJ_CLEAR_GC (*hpo, struct http_proxy_options, gc);
       /* http proxy defaults */
-      (*hpo)->timeout = 5;
       (*hpo)->http_version = "1.0";
     }
   return *hpo;
@@ -93,6 +93,7 @@ recv_line (socket_descriptor_t sd,
 
       FD_ZERO (&reads);
       FD_SET (sd, &reads);
+
       tv.tv_sec = timeout_sec;
       tv.tv_usec = 0;
 
@@ -255,6 +256,8 @@ clear_user_pass_http (void)
   purge_user_pass (&static_proxy_user_pass, true);
 }
 
+#if 0
+/* function only used in #if 0 debug statement */
 static void
 dump_residual (socket_descriptor_t sd,
 	       int timeout,
@@ -269,6 +272,7 @@ dump_residual (socket_descriptor_t sd,
       msg (D_PROXY, "PROXY HEADER: '%s'", buf);
     }
 }
+#endif
 
 /*
  * Extract the Proxy-Authenticate header from the stream.
@@ -552,6 +556,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 			       socket_descriptor_t sd, /* already open to proxy */
 			       const char *host,       /* openvpn server remote */
 			       const char *port,         /* openvpn server port */
+			       struct event_timeout* server_poll_timeout,
 			       struct buffer *lookahead,
 			       volatile int *signal_received)
 {
@@ -633,8 +638,9 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
       if (!send_crlf (sd))
 	goto error;
 
+
       /* receive reply from proxy */
-      if (!recv_line (sd, buf, sizeof(buf), p->options.timeout, true, NULL, signal_received))
+      if (!recv_line (sd, buf, sizeof(buf), get_server_poll_remaining_time (server_poll_timeout), true, NULL, signal_received))
 	goto error;
 
       /* remove trailing CR, LF */
@@ -663,7 +669,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 
           while (true)
             {
-              if (!recv_line (sd, buf, sizeof(buf), p->options.timeout, true, NULL, signal_received))
+              if (!recv_line (sd, buf, sizeof(buf), get_server_poll_remaining_time (server_poll_timeout), true, NULL, signal_received))
                 goto error;
               chomp (buf);
               msg (D_PROXY, "HTTP proxy returned: '%s'", buf);
@@ -730,7 +736,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
             goto error;
 
           /* receive reply from proxy */
-          if (!recv_line (sd, buf, sizeof(buf), p->options.timeout, true, NULL, signal_received))
+          if (!recv_line (sd, buf, sizeof(buf), get_server_poll_remaining_time (server_poll_timeout), true, NULL, signal_received))
             goto error;
 
           /* remove trailing CR, LF */
@@ -838,7 +844,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 		goto error;
 
 	      /* receive reply from proxy */
-	      if (!recv_line (sd, buf, sizeof(buf), p->options.timeout, true, NULL, signal_received))
+	      if (!recv_line (sd, buf, sizeof(buf), get_server_poll_remaining_time (server_poll_timeout), true, NULL, signal_received))
 		goto error;
 
 	      /* remove trailing CR, LF */
@@ -862,7 +868,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	  /* figure out what kind of authentication the proxy needs */
 	  char *pa = NULL;
 	  const int method = get_proxy_authenticate(sd,
-						    p->options.timeout,
+						    get_server_poll_remaining_time (server_poll_timeout),
 						    &pa,
 						    NULL,
 						    signal_received);
@@ -906,7 +912,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
       msg (D_LINK_ERRORS, "HTTP proxy returned bad status");
 #if 0
       /* DEBUGGING -- show a multi-line HTTP error response */
-      dump_residual(sd, p->options.timeout, signal_received);
+      dump_residual(sd, get_server_poll_remaining_time (server_poll_timeout), signal_received);
 #endif
       goto error;
     }
@@ -914,7 +920,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
   /* SUCCESS */
 
   /* receive line from proxy and discard */
-  if (!recv_line (sd, NULL, 0, p->options.timeout, true, NULL, signal_received))
+  if (!recv_line (sd, NULL, 0, get_server_poll_remaining_time (server_poll_timeout), true, NULL, signal_received))
     goto error;
 
   /*
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 4715940..f5b4519 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -46,7 +46,6 @@ struct http_proxy_options {
   const char *server;
   const char *port;
   bool retry;
-  int timeout;
 
 # define PAR_NO  0  /* don't support any auth retries */
 # define PAR_ALL 1  /* allow all proxy auth protocols */
@@ -86,6 +85,7 @@ bool establish_http_proxy_passthru (struct http_proxy_info *p,
 				    socket_descriptor_t sd, /* already open to proxy */
 				    const char *host,       /* openvpn server remote */
 				    const char *port,         /* openvpn server port */
+				    struct event_timeout* server_poll_timeout,
 				    struct buffer *lookahead,
 				    volatile int *signal_received);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 925665c..b4032b8 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -40,6 +40,7 @@
 #include "misc.h"
 #include "manage.h"
 #include "openvpn.h"
+#include "forward.h"
 
 #include "memdbg.h"
 
@@ -1511,11 +1512,11 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *ipchange_command,
 			 const struct plugin_list *plugins,
 			 int resolve_retry_seconds,
-			 int connect_timeout,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
 			 int mark,
+			 struct event_timeout* server_poll_timeout,
 			 unsigned int sockflags)
 {
   ASSERT (sock);
@@ -1530,7 +1531,6 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->bind_local = bind_local;
   sock->inetd = inetd;
   sock->resolve_retry_seconds = resolve_retry_seconds;
-  sock->connect_timeout = connect_timeout;
   sock->mtu_discover_type = mtu_discover_type;
 
 #ifdef ENABLE_DEBUG
@@ -1550,6 +1550,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->info.bind_ipv6_only = bind_ipv6_only;
   sock->info.ipchange_command = ipchange_command;
   sock->info.plugins = plugins;
+  sock->server_poll_timeout = server_poll_timeout;
 
   sock->mode = mode;
   if (mode == LS_MODE_TCP_ACCEPT_FROM)
@@ -1770,7 +1771,7 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
   do {
     socket_connect (&sock->sd,
                    sock->info.lsa->current_remote->ai_addr,
-                   sock->connect_timeout,
+                   get_server_poll_remaining_time (sock->server_poll_timeout),
                    sig_info);
 
     if (sig_info->signal_received)
@@ -1782,6 +1783,7 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 						     sock->sd,
 						     sock->proxy_dest_host,
 						     sock->proxy_dest_port,
+						     sock->server_poll_timeout,
 						     &sock->stream_buf.residual,
 						     &sig_info->signal_received);
       }
@@ -1808,7 +1810,7 @@ phase2_socks_client (struct link_socket *sock, struct signal_info *sig_info)
 {
     socket_connect (&sock->ctrl_sd,
 		    sock->info.lsa->current_remote->ai_addr,
-		    sock->connect_timeout,
+		    get_server_poll_remaining_time (sock->server_poll_timeout),
 		    sig_info);
 
     if (sig_info->signal_received)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 49cfab6..30b6ace 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -205,7 +205,6 @@ struct link_socket
   int mode;
 
   int resolve_retry_seconds;
-  int connect_timeout;
   int mtu_discover_type;
 
   struct socket_buffer_size socket_buffer_sizes;
@@ -236,6 +235,10 @@ struct link_socket
   const char *proxy_dest_host;
   const char *proxy_dest_port;
 
+ /* Pointer to the server-poll to trigger the timeout in function which have
+  * their own loop instead of using the main oop */
+  struct event_timeout* server_poll_timeout;
+
 #if PASSTOS_CAPABILITY
   /* used to get/set TOS. */
 #if defined(TARGET_LINUX)
@@ -324,11 +327,11 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *ipchange_command,
 			 const struct plugin_list *plugins,
 			 int resolve_retry_seconds,
-			 int connect_timeout,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
 			 int mark,
+			 struct event_timeout* server_poll_timeout,
 			 unsigned int sockflags);
 
 void link_socket_init_phase2 (struct link_socket *sock,
-- 
2.3.8 (Apple Git-58)


