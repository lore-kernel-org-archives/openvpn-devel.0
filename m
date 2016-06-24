From: Arne Schwabe <arne@...1227...>
Date: Fri, 24 Jun 2016 14:27:10 +0200
Message-Id: <1466771230-5266-1-git-send-email-arne@...1227...>
In-Reply-To: <1466167642-13603-1-git-send-email-arne@...1227...>
References: <1466167642-13603-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Remove http-proxy-retry and
	socks-proxy-retry.
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

These options were probably introduced long before we had multiple
remote/connection entries. For all other connection entries, OpenVPN will
go on with the next connection if it fails. For proxies, if it fails in
some ways it works the same, for other failures it completely stops.

Removing the *-proxy-retry and defaulting to retry makes the behavior more
predictiable. Stopping after one try (regardless of reason) can be achieved
with --max-connect-retry 1

V2: Add reason for removing, remove from manpage, give a hint at
   --max-connet-retry
V3: Collapse the two ifs in options.c to one block
---
 Changes.rst           |  2 ++
 doc/openvpn.8         | 14 --------------
 src/openvpn/init.c    |  4 +---
 src/openvpn/options.c | 17 ++++-------------
 src/openvpn/options.h |  1 -
 src/openvpn/proxy.c   |  3 +--
 src/openvpn/proxy.h   |  1 -
 src/openvpn/socks.c   | 10 +++-------
 src/openvpn/socks.h   |  4 +---
 9 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index f945ad7..d12cdad 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -117,6 +117,8 @@ User-visible Changes
   proxies graciously.  The old "fail TCP fast" behaviour can be achieved by
   adding "--connect-timeout 10" to the client config.
 
+- --http-proxy-retry and --sock-proxy-retry have been removed. Proxy connections
+    will now behave like regular connection entries and generate a USR1 on failure.
 
 Maintainer-visible changes
 --------------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ac8036f..64cc934 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -317,13 +317,11 @@ remote 198.19.34.56 443 tcp
 <connection>
 remote 198.19.34.56 443 tcp
 http\-proxy 192.168.0.8 8080
-http\-proxy\-retry
 </connection>
 
 <connection>
 remote 198.19.36.99 443 tcp
 http\-proxy 192.168.0.8 8080
-http\-proxy\-retry
 </connection>
 
 persist\-key
@@ -356,7 +354,6 @@ block:
 .B fragment,
 .B http\-proxy,
 .B http\-proxy\-option,
-.B http\-proxy\-retry,
 .B link\-mtu,
 .B local,
 .B lport,
@@ -368,7 +365,6 @@ block:
 .B remote,
 .B rport,
 .B socks\-proxy,
-.B socks\-proxy\-retry,
 .B tun\-mtu and
 .B tun\-mtu\-extra.
 
@@ -527,11 +523,6 @@ determine the authentication method, but to reject weak
 authentication protocols such as HTTP Basic Authentication.
 .\"*********************************************************
 .TP
-.B \-\-http\-proxy\-retry
-Retry indefinitely on HTTP proxy errors.  If an HTTP proxy error
-occurs, simulate a SIGUSR1 reset.
-.\"*********************************************************
-.TP
 .B \-\-http\-proxy\-option type [parm]
 Set extended HTTP proxy options.
 Repeat to set multiple options.
@@ -564,11 +555,6 @@ and port
 "stdin" to prompt from console.
 .\"*********************************************************
 .TP
-.B \-\-socks\-proxy\-retry
-Retry indefinitely on Socks proxy errors.  If a Socks proxy error
-occurs, simulate a SIGUSR1 reset.
-.\"*********************************************************
-.TP
 .B \-\-resolv\-retry n
 If hostname resolve fails for
 .B \-\-remote,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 58b95aa..498d36f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -138,7 +138,6 @@ management_callback_proxy_cmd (void *arg, const char **p)
           ho = init_http_proxy_options_once (&ce->http_proxy_options, gc);
           ho->server = string_alloc (p[2], gc);
           ho->port = string_alloc (p[3], gc);
-          ho->retry = true;
           ho->auth_retry = (p[4] && streq (p[4], "nct") ? PAR_NCT : PAR_ALL);
           ret = true;
         }
@@ -473,8 +472,7 @@ init_proxy_dowork (struct context *c)
     {
       c->c1.socks_proxy = socks_proxy_new (c->options.ce.socks_proxy_server,
 					   c->options.ce.socks_proxy_port,
-					   c->options.ce.socks_proxy_authfile,
-					   c->options.ce.socks_proxy_retry);
+					   c->options.ce.socks_proxy_authfile);
       if (c->c1.socks_proxy)
 	{
 	  c->c1.socks_proxy_owned = true;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3adeb15..cf971a6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -135,7 +135,6 @@ static const char usage_message[] =
   "--http-proxy s p 'auto[-nct]' : Like the above directive, but automatically\n"
   "                  determine auth method and query for username/password\n"
   "                  if needed.  auto-nct disables weak proxy auth methods.\n"
-  "--http-proxy-retry     : Retry indefinitely on HTTP proxy errors.\n"
   "--http-proxy-option type [parm] : Set extended HTTP proxy options.\n"
   "                                  Repeat to set multiple options.\n"
   "                  VERSION version (default=1.0)\n"
@@ -1329,7 +1328,6 @@ show_http_proxy_options (const struct http_proxy_options *o)
   SHOW_STR (port);
   SHOW_STR (auth_method_string);
   SHOW_STR (auth_file);
-  SHOW_BOOL (retry);
   SHOW_STR (http_version);
   SHOW_STR (user_agent);
   for  (i=0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name;i++)
@@ -1397,7 +1395,6 @@ show_connection_entry (const struct connection_entry *o)
     show_http_proxy_options (o->http_proxy_options);
   SHOW_STR (socks_proxy_server);
   SHOW_STR (socks_proxy_port);
-  SHOW_BOOL (socks_proxy_retry);
   SHOW_INT (tun_mtu);
   SHOW_BOOL (tun_mtu_defined);
   SHOW_INT (link_mtu);
@@ -1749,7 +1746,6 @@ parse_http_proxy_override (const char *server,
       ALLOC_OBJ_CLEAR_GC (ho, struct http_proxy_options, gc);
       ho->server = string_alloc(server, gc);
       ho->port = port;
-      ho->retry = true;
       if (flags && !strcmp(flags, "nct"))
 	ho->auth_retry = PAR_NCT;
       else
@@ -5234,12 +5230,12 @@ add_option (struct options *options,
       else
 	ho->auth_file = p[1];
     }
-  else if (streq (p[0], "http-proxy-retry") && !p[1])
+  else if (streq (p[0], "http-proxy-retry") || streq (p[0], "socks-proxy-retry"))
     {
-      struct http_proxy_options *ho;
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_proxy_options_once (&options->ce.http_proxy_options, &options->gc);
-      ho->retry = true;
+      msg (M_WARN, "DEPRECATED OPTION: http-proxy-retry and socks-proxy-retry: "
+           "In OpenVPN 2.4 proxy connection retries are handled like regular connections. "
+           "Use connect-retry-max 1 to get a similar behavior as before.");
     }
   else if (streq (p[0], "http-proxy-timeout") && p[1] && !p[2])
     {
@@ -5309,11 +5305,6 @@ add_option (struct options *options,
       options->ce.socks_proxy_server = p[1];
       options->ce.socks_proxy_authfile = p[3]; /* might be NULL */
     }
-  else if (streq (p[0], "socks-proxy-retry") && !p[1])
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      options->ce.socks_proxy_retry = true;
-    }
   else if (streq (p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 78e4fe0..7bb36c9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -101,7 +101,6 @@ struct connection_entry
   const char *socks_proxy_server;
   const char *socks_proxy_port;
   const char *socks_proxy_authfile;
-  bool socks_proxy_retry;
 
   int tun_mtu;           /* MTU of tun device */
   bool tun_mtu_defined;  /* true if user overriding parm with command line option */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 4853193..0f78020 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -943,9 +943,8 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
   return ret;
 
  error:
-  /* on error, should we exit or restart? */
   if (!*signal_received)
-    *signal_received = (p->options.retry ? SIGUSR1 : SIGTERM); /* SOFT-SIGUSR1 -- HTTP proxy error */
+    *signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- HTTP proxy error */
   gc_free (&gc);
   return ret;
 }
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 9a52e7e..7d2581c 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -45,7 +45,6 @@ struct http_custom_header {
 struct http_proxy_options {
   const char *server;
   const char *port;
-  bool retry;
 
 # define PAR_NO  0  /* don't support any auth retries */
 # define PAR_ALL 1  /* allow all proxy auth protocols */
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index a9d04ae..5a9ea6c 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -60,8 +60,7 @@ socks_adjust_frame_parameters (struct frame *frame, int proto)
 struct socks_proxy_info *
 socks_proxy_new (const char *server,
 		 const char *port,
-		 const char *authfile,
-		 bool retry)
+		 const char *authfile)
 {
   struct socks_proxy_info *p;
 
@@ -78,7 +77,6 @@ socks_proxy_new (const char *server,
   else
     p->authfile[0] = 0;
 
-  p->retry = retry;
   p->defined = true;
 
   return p;
@@ -470,9 +468,8 @@ establish_socks_proxy_passthru (struct socks_proxy_info *p,
   return;
 
  error:
-  /* on error, should we exit or restart? */
   if (!*signal_received)
-    *signal_received = (p->retry ? SIGUSR1 : SIGTERM); /* SOFT-SIGUSR1 -- socks error */
+    *signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- socks error */
   return;
 }
 
@@ -508,9 +505,8 @@ establish_socks_proxy_udpassoc (struct socks_proxy_info *p,
   return;
 
  error:
-  /* on error, should we exit or restart? */
   if (!*signal_received)
-    *signal_received = (p->retry ? SIGUSR1 : SIGTERM); /* SOFT-SIGUSR1 -- socks error */
+    *signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- socks error */
   return;
 }
 
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 2475261..a2843b9 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -37,7 +37,6 @@ struct link_socket_actual;
 
 struct socks_proxy_info {
   bool defined;
-  bool retry;
 
   char server[128];
   const char *port;
@@ -48,8 +47,7 @@ void socks_adjust_frame_parameters (struct frame *frame, int proto);
 
 struct socks_proxy_info *socks_proxy_new (const char *server,
 					  const char *port,
-					  const char *authfile,
-					  bool retry);
+					  const char *authfile);
 
 void socks_proxy_close (struct socks_proxy_info *sp);
 
-- 
2.7.4 (Apple Git-66)


