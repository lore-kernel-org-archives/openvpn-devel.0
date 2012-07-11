From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 11 Jul 2012 14:16:50 +0200
Message-ID: <1342009010-9735-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add option --management-query-proxy
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

Make openvpn query for proxy information through the
management interface. This allows GUIs to provide (automatically
detected) proxy information on a per connection basis.

This new option supersedes the undocumented --http-proxy-fallback
option and puts the responsibilty for HTTP proxy fallback handling
to the GUI caring for such.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 doc/management-notes.txt |   31 ++++++++
 doc/openvpn.8            |    6 ++
 src/openvpn/init.c       |  185 +++++++++++++++++++++-------------------------
 src/openvpn/manage.c     |   52 +++----------
 src/openvpn/manage.h     |   17 ++---
 src/openvpn/options.c    |  112 ++++------------------------
 src/openvpn/options.h    |   28 +------
 src/openvpn/proxy.c      |   15 ++++
 src/openvpn/proxy.h      |    3 +
 src/openvpn/syshead.h    |    6 +-
 10 files changed, 178 insertions(+), 277 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 785eb88..a07a514 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -719,6 +719,37 @@ use this command:
 
   remote SKIP
 
+COMMAND -- proxy  (OpenVPN 2.3 or higher)
+--------------------------------------------
+
+Provide proxy server host/port and flags in response to a >PROXY
+notification (client only).  Requires that the --management-query-proxy
+directive is used.
+
+  proxy TYPE HOST PORT ["nct"]
+
+The "proxy" command must only be given in response to a >PROXY
+notification.  Use the "nct" flag if you only want to allow
+non-cleartext auth with the proxy server.  The following >PROXY
+notification indicates that the client config file would ordinarily
+connect to the first --remote configured, vpn.example.com using TCP:
+
+  >PROXY:1,TCP,vpn.example.com
+
+Now, suppose we want to connect to the remote host using the proxy server
+proxy.intranet port 8080 with secure authentication only, if required.
+After receiving the above notification, use this command:
+
+  proxy HTTP proxy.intranet 8080 nct
+
+You can also use the SOCKS keyword to pass a SOCKS server address, like:
+
+  proxy SOCKS fe00::1 1080
+
+To accept connecting to the host and port directly, use this command:
+
+  proxy NONE
+
 OUTPUT FORMAT
 -------------
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a821b5e..56be29e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2446,6 +2446,12 @@ for inputs which ordinarily would have been queried from the
 console.
 .\"*********************************************************
 .TP
+.B \-\-management-query-proxy
+Query management channel for proxy server information for a specific
+.B \-\-remote
+(client-only).
+.\"*********************************************************
+.TP
 .B \-\-management-query-remote
 Allow management interface to override
 .B \-\-remote
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f86fc38..614d081 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -111,102 +111,100 @@ update_options_ce_post (struct options *options)
 #endif
 }
 
-#if HTTP_PROXY_FALLBACK
-
+#ifdef ENABLE_MANAGEMENT
 static bool
-ce_http_proxy_fallback_defined(const struct context *c)
+management_callback_proxy_cmd (void *arg, const char **p)
 {
-  const struct connection_list *l = c->options.connection_list;
-  if (l && l->current == 0)
-    {
-      int i;
-      for (i = 0; i < l->len; ++i)
-	{
-	  const struct connection_entry *ce = l->array[i];
-	  if (ce->flags & CE_HTTP_PROXY_FALLBACK)
-	    return true;
-	}
-    }
-  return false;
-}
+  struct context *c = arg;
+  struct connection_entry *ce = &c->options.ce;
+  struct gc_arena *gc = &c->c2.gc;
+  bool ret = false;
 
-static void
-ce_http_proxy_fallback_start(struct context *c, const char *remote_ip_hint)
-{
-  const struct connection_list *l = c->options.connection_list;
-  if (l)
-    {
-      int i;
-      for (i = 0; i < l->len; ++i)
-	{
-	  struct connection_entry *ce = l->array[i];
-	  if (ce->flags & CE_HTTP_PROXY_FALLBACK)
-	    {
-	      ce->http_proxy_options = NULL;
-	      ce->ce_http_proxy_fallback_timestamp = 0;
-	      if (!remote_ip_hint)
-		remote_ip_hint = ce->remote;
-	    }
-	}
+  update_time();
+  if (streq (p[1], "NONE"))
+    ret = true;
+  else if (p[2] && p[3])
+    {
+      const int port = atoi(p[3]);
+      if (!legal_ipv4_port (port))
+        {
+          msg (M_WARN, "Bad proxy port number: %s", p[3]);
+          return false;
+        }
+
+      if (streq (p[1], "HTTP"))
+        {
+#ifndef ENABLE_HTTP_PROXY
+          msg (M_WARN, "HTTP proxy support is not available");
+#else
+          struct http_proxy_options *ho;
+          if (ce->proto != PROTO_TCPv4 && ce->proto != PROTO_TCPv4_CLIENT &&
+              ce->proto != PROTO_TCPv6 && ce->proto != PROTO_TCPv6_CLIENT)
+            {
+              msg (M_WARN, "HTTP proxy support only works for TCP based connections");
+              return false;
+            }
+          ho = init_http_proxy_options_once (ce->http_proxy_options, gc);
+          ho->server = string_alloc (p[2], gc);
+          ho->port = port;
+          ho->retry = true;
+          ho->auth_retry = (p[4] && streq (p[4], "nct") ? PAR_NCT : PAR_ALL);
+          ce->http_proxy_options = ho;
+          ret = true;
+#endif
+        }
+      else if (streq (p[1], "SOCKS"))
+        {
+#ifndef ENABLE_SOCKS
+          msg (M_WARN, "SOCKS proxy support is not available");
+#else
+          ce->socks_proxy_server = string_alloc (p[2], gc);
+          ce->socks_proxy_port = port;
+          ret = true;
+#endif
+        }
     }
+  else
+    msg (M_WARN, "Bad proxy command");
 
-  if (management)
-    management_http_proxy_fallback_notify(management, "NEED_LATER", remote_ip_hint);
-}
-
-static bool
-ce_http_proxy_fallback (struct context *c, volatile const struct connection_entry *ce)
-{
-  const int proxy_info_expire = 120; /* seconds before proxy info expires */
+  ce->flags &= ~CE_MAN_QUERY_PROXY;
 
-  update_time();
-  if (management)
-    {
-      if (!ce->ce_http_proxy_fallback_timestamp)
-	{
-	  management_http_proxy_fallback_notify(management, "NEED_NOW", NULL);
-	  while (!ce->ce_http_proxy_fallback_timestamp)
-	    {
-	      management_event_loop_n_seconds (management, 1);
-	      if (IS_SIG (c))
-		return false;
-	    }
-	}
-      return (now < ce->ce_http_proxy_fallback_timestamp + proxy_info_expire && ce->http_proxy_options);
-    }
-  return false;
+  return ret;
 }
 
 static bool
-management_callback_http_proxy_fallback_cmd (void *arg, const char *server, const char *port, const char *flags)
+ce_management_query_proxy (struct context *c)
 {
-  struct context *c = (struct context *) arg;
   const struct connection_list *l = c->options.connection_list;
-  int ret = false;
-  struct http_proxy_options *ho = parse_http_proxy_fallback (c, server, port, flags, M_WARN);
+  struct connection_entry *ce = &c->options.ce;
+  struct gc_arena gc;
+  bool ret = true;
 
   update_time();
-  if (l)
+  if (management)
     {
-      int i;
-      for (i = 0; i < l->len; ++i)
-	{
-	  struct connection_entry *ce = l->array[i];
-	  if (ce->flags & CE_HTTP_PROXY_FALLBACK)
-	    {
-	      ce->http_proxy_options = ho;
-	      ce->ce_http_proxy_fallback_timestamp = now;
-	      ret = true;
-	    }
-	}
+      gc = gc_new ();
+      struct buffer out = alloc_buf_gc (256, &gc);
+      buf_printf (&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
+                  (proto_is_udp (ce->proto) ? "UDP" : "TCP"), np (ce->remote));
+      management_notify_generic (management, BSTR (&out));
+      ce->flags |= CE_MAN_QUERY_PROXY;
+      while (ce->flags & CE_MAN_QUERY_PROXY)
+        {
+          management_event_loop_n_seconds (management, 1);
+          if (IS_SIG (c))
+            {
+              ret = false;
+              break;
+            }
+        }
+      gc_free (&gc);
     }
-  
+
   return ret;
 }
 
-#endif
 
-#ifdef ENABLE_MANAGEMENT
 static bool
 management_callback_remote_cmd (void *arg, const char **p)
 {
@@ -382,18 +380,6 @@ next_connection_entry (struct context *c)
 	if (c->options.remote_ip_hint && !l->n_cycles)
 	  remote_ip_hint = c->options.remote_ip_hint;
 
-#if HTTP_PROXY_FALLBACK
-	if (newcycle && ce_http_proxy_fallback_defined(c))
-	  ce_http_proxy_fallback_start(c, remote_ip_hint);
-
-	if (ce->flags & CE_HTTP_PROXY_FALLBACK)
-	  {
-	    ce_defined = ce_http_proxy_fallback(c, ce);
-	    if (IS_SIG (c))
-	      break;
-	  }
-#endif
-
 	if (ce->flags & CE_DISABLED)
 	  ce_defined = false;
 
@@ -405,16 +391,19 @@ next_connection_entry (struct context *c)
 	    ce_defined = ce_management_query_remote(c, remote_ip_hint);
 	    if (IS_SIG (c))
 	      break;
-	  } else
+	  }
+        else
 #endif
 	if (remote_ip_hint)
 	  c->options.ce.remote = remote_ip_hint;
 
-#if 0 /* fixme -- disable for production, this code simulates a network where proxy fallback is the only method to reach the OpenVPN server */
-	if (!(c->options.ce.flags & CE_HTTP_PROXY_FALLBACK))
-	  {
-	    c->options.ce.remote = "10.10.0.1"; /* use an unreachable address here */
-	  }
+#ifdef ENABLE_MANAGEMENT
+        if (ce_defined && management && management_query_proxy_enabled (management))
+          {
+            ce_defined = ce_management_query_proxy (c);
+            if (IS_SIG (c))
+              break;
+          }
 #endif
       } while (!ce_defined);
     }
@@ -3168,12 +3157,8 @@ init_management_callback_p2p (struct context *c)
       cb.arg = c;
       cb.status = management_callback_status_p2p;
       cb.show_net = management_show_net_callback;
-#if HTTP_PROXY_FALLBACK
-      cb.http_proxy_fallback_cmd = management_callback_http_proxy_fallback_cmd;
-#endif
-#ifdef ENABLE_MANAGEMENT
+      cb.proxy_cmd = management_callback_proxy_cmd;
       cb.remote_cmd = management_callback_remote_cmd;
-#endif
       management_set_callback (management, &cb);
     }
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ef5d32c..33d8be4 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -93,6 +93,7 @@ man_help ()
   msg (M_CLIENT, "net                    : (Windows only) Show network info and routing table.");
   msg (M_CLIENT, "password type p        : Enter password p for a queried OpenVPN password.");
   msg (M_CLIENT, "remote type [host port] : Override remote directive, type=ACCEPT|MOD|SKIP.");
+  msg (M_CLIENT, "proxy type [host port flags] : Enter dynamic proxy server info.");
   msg (M_CLIENT, "pid                    : Show process ID of the current OpenVPN process.");
 #ifdef ENABLE_PKCS11
   msg (M_CLIENT, "pkcs11-id-count        : Get number of available PKCS#11 identities.");
@@ -121,10 +122,6 @@ man_help ()
   msg (M_CLIENT, "username type u        : Enter username u for a queried OpenVPN username.");
   msg (M_CLIENT, "verb [n]               : Set log verbosity level to n, or show if n is absent.");
   msg (M_CLIENT, "version                : Show current version number.");
-#if HTTP_PROXY_FALLBACK
-  msg (M_CLIENT, "http-proxy-fallback <server> <port> [flags] : Enter dynamic HTTP proxy fallback info.");
-  msg (M_CLIENT, "http-proxy-fallback-disable : Disable HTTP proxy fallback.");
-#endif
   msg (M_CLIENT, "END");
 }
 
@@ -1071,31 +1068,21 @@ man_need (struct management *man, const char **p, const int n, unsigned int flag
   return true;
 }
 
-#if HTTP_PROXY_FALLBACK
-
 static void
-man_http_proxy_fallback (struct management *man, const char *server, const char *port, const char *flags)
+man_proxy (struct management *man, const char **p)
 {
-  if (man->persist.callback.http_proxy_fallback_cmd)
+  if (man->persist.callback.proxy_cmd)
     {
-      const bool status = (*man->persist.callback.http_proxy_fallback_cmd)(man->persist.callback.arg, server, port, flags);
+      const bool status = (*man->persist.callback.proxy_cmd)(man->persist.callback.arg, p);
       if (status)
-	{
-	  msg (M_CLIENT, "SUCCESS: proxy-fallback command succeeded");
-	}
+        msg (M_CLIENT, "SUCCESS: proxy command succeeded");
       else
-	{
-	  msg (M_CLIENT, "ERROR: proxy-fallback command failed");
-	}
+        msg (M_CLIENT, "ERROR: proxy command failed");
     }
   else
-    {
-      msg (M_CLIENT, "ERROR: The proxy-fallback command is not supported by the current daemon mode");
-    }
+    msg (M_CLIENT, "ERROR: The proxy command is not supported by the current daemon mode");
 }
 
-#endif
-
 static void
 man_remote (struct management *man, const char **p)
 {
@@ -1335,17 +1322,11 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
 	man_pkcs11_id_get (man, atoi(p[1]));
     }
 #endif
-#if HTTP_PROXY_FALLBACK
-  else if (streq (p[0], "http-proxy-fallback"))
+  else if (streq (p[0], "proxy"))
     {
-      if (man_need (man, p, 2, MN_AT_LEAST))
-	man_http_proxy_fallback (man, p[1], p[2], p[3]);
-    }
-  else if (streq (p[0], "http-proxy-fallback-disable"))
-    {
-      man_http_proxy_fallback (man, NULL, NULL, NULL);
+      if (man_need (man, p, 1, MN_AT_LEAST))
+        man_proxy (man, p);
     }
-#endif
   else if (streq (p[0], "remote"))
     {
       if (man_need (man, p, 1, MN_AT_LEAST))
@@ -3345,19 +3326,6 @@ log_history_ref (const struct log_history *h, const int index)
     return NULL;
 }
 
-#if HTTP_PROXY_FALLBACK
-
-void
-management_http_proxy_fallback_notify (struct management *man, const char *type, const char *remote_ip_hint)
-{
-  if (remote_ip_hint)
-    msg (M_CLIENT, ">PROXY:%s,%s", type, remote_ip_hint);
-  else
-    msg (M_CLIENT, ">PROXY:%s", type);
-}
-
-#endif /* HTTP_PROXY_FALLBACK */
-
 #else
 static void dummy(void) {}
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f387c74..28da69f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -171,9 +171,7 @@ struct management_callback
 		     const unsigned long cid,
 		     struct buffer_list *pf_config);   /* ownership transferred */
 #endif
-#if HTTP_PROXY_FALLBACK
-  bool (*http_proxy_fallback_cmd) (void *arg, const char *server, const char *port, const char *flags);
-#endif
+  bool (*proxy_cmd) (void *arg, const char **p);
   bool (*remote_cmd) (void *arg, const char **p);
 };
 
@@ -335,6 +333,7 @@ struct management *management_init (void);
 #endif
 #define MF_UP_DOWN          (1<<10)
 #define MF_QUERY_REMOTE     (1<<11)
+#define MF_QUERY_PROXY      (1<<12)
 
 bool management_open (struct management *man,
 		      const char *addr,
@@ -429,6 +428,12 @@ management_query_remote_enabled (const struct management *man)
   return BOOL_CAST(man->settings.flags & MF_QUERY_REMOTE);
 }
 
+static inline bool
+management_query_proxy_enabled (const struct management *man)
+{
+  return BOOL_CAST(man->settings.flags & MF_QUERY_PROXY);
+}
+
 #ifdef MANAGEMENT_PF
 static inline bool
 management_enable_pf (const struct management *man)
@@ -554,11 +559,5 @@ management_bytes_server (struct management *man,
 
 #endif /* MANAGEMENT_DEF_AUTH */
 
-#if HTTP_PROXY_FALLBACK
-
-void management_http_proxy_fallback_notify (struct management *man, const char *type, const char *remote_ip_hint);
-
-#endif /* HTTP_PROXY_FALLBACK */
-
 #endif
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bccdf0c..cd1cb1c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -381,6 +381,7 @@ static const char usage_message[] =
   "                      ip/port rather than listen as a TCP server.\n"
   "--management-query-passwords : Query management channel for private key\n"
   "                  and auth-user-pass passwords.\n"
+  "--management-query-proxy : Query management channel for proxy information.\n"
   "--management-query-remote : Query management channel for --remote directive.\n"
   "--management-hold : Start " PACKAGE_NAME " in a hibernating state, until a client\n"
   "                    of the management interface explicitly starts it.\n"
@@ -1663,24 +1664,7 @@ show_settings (const struct options *o)
 #undef SHOW_INT
 #undef SHOW_BOOL
 
-#ifdef ENABLE_HTTP_PROXY
-
-struct http_proxy_options *
-init_http_options_if_undefined (struct options *o)
-{
-  if (!o->ce.http_proxy_options)
-    {
-      ALLOC_OBJ_CLEAR_GC (o->ce.http_proxy_options, struct http_proxy_options, &o->gc);
-      /* http proxy defaults */
-      o->ce.http_proxy_options->timeout = 5;
-      o->ce.http_proxy_options->http_version = "1.0";
-    }
-  return o->ce.http_proxy_options;
-}
-
-#endif
-
-#if HTTP_PROXY_FALLBACK
+#if HTTP_PROXY_OVERRIDE
 
 static struct http_proxy_options *
 parse_http_proxy_override (const char *server,
@@ -1717,68 +1701,6 @@ parse_http_proxy_override (const char *server,
     return NULL;
 }
 
-struct http_proxy_options *
-parse_http_proxy_fallback (struct context *c,
-			   const char *server,
-			   const char *port,
-			   const char *flags,
-			   const int msglevel)
-{
-  struct gc_arena gc = gc_new ();
-  struct http_proxy_options *ret = NULL;
-  struct http_proxy_options *hp = parse_http_proxy_override(server, port, flags, msglevel, &gc);
-  if (hp)
-    {
-      struct hpo_store *hpos = c->options.hpo_store;
-      if (!hpos)
-	{
-	  ALLOC_OBJ_CLEAR_GC (hpos, struct hpo_store, &c->options.gc);
-	  c->options.hpo_store = hpos;
-	}
-      hpos->hpo = *hp;
-      hpos->hpo.server = hpos->server;
-      strncpynt(hpos->server, hp->server, sizeof(hpos->server));
-      ret = &hpos->hpo;
-    }
-  gc_free (&gc);
-  return ret;
-}
-
-static void
-http_proxy_warn(const char *name)
-{
-  msg (M_WARN, "Note: option %s ignored because no TCP-based connection profiles are defined", name);
-}
-
-void
-options_postprocess_http_proxy_fallback (struct options *o)
-{
-  struct connection_list *l = o->connection_list;
-  if (l)
-    {
-      int i;
-      for (i = 0; i < l->len; ++i)
-	{
-	  struct connection_entry *ce = l->array[i];
-	  if (ce->proto == PROTO_TCPv4_CLIENT || ce->proto == PROTO_TCPv4)
-	    {
-	      if (l->len < CONNECTION_LIST_SIZE)
-		{
-		  struct connection_entry *newce;
-		  ALLOC_OBJ_GC (newce, struct connection_entry, &o->gc);
-		  *newce = *ce;
-		  newce->flags |= CE_HTTP_PROXY_FALLBACK;
-		  newce->http_proxy_options = NULL;
-		  newce->ce_http_proxy_fallback_timestamp = 0;
-		  l->array[l->len++] = newce;
-		}
-	      return;
-	    }
-	}
-    }
-  http_proxy_warn("http-proxy-fallback");
-}
-
 void
 options_postprocess_http_proxy_override (struct options *o)
 {
@@ -1808,9 +1730,7 @@ options_postprocess_http_proxy_override (struct options *o)
 	    }
 	}
       else
-	{
-	  http_proxy_warn("http-proxy-override");
-	}
+        msg (M_WARN, "Note: option http-proxy-override ignored because no TCP-based connection profiles are defined");
     }
 }
 
@@ -2565,11 +2485,9 @@ options_postprocess_mutate (struct options *o)
       for (i = 0; i < o->connection_list->len; ++i)
 	options_postprocess_mutate_ce (o, o->connection_list->array[i]);
 
-#if HTTP_PROXY_FALLBACK
+#if HTTP_PROXY_OVERRIDE
       if (o->http_proxy_override)
 	options_postprocess_http_proxy_override(o);
-      else if (o->http_proxy_fallback)
-	options_postprocess_http_proxy_fallback(o);
 #endif
     }
   else
@@ -4186,6 +4104,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_QUERY_REMOTE;
     }
+  else if (streq (p[0], "management-query-proxy"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->management_flags |= MF_QUERY_PROXY;
+      options->force_connection_list = true;
+    }
   else if (streq (p[0], "management-hold"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -4419,13 +4343,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->remote_ip_hint = p[1];
     }
-#if HTTP_PROXY_FALLBACK
-  else if (streq (p[0], "http-proxy-fallback"))
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->http_proxy_fallback = true;
-      options->force_connection_list = true;
-    }
+#if HTTP_PROXY_OVERRIDE
   else if (streq (p[0], "http-proxy-override") && p[1] && p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -4961,7 +4879,7 @@ add_option (struct options *options,
 	    goto err;
 	  }
 	
-	ho = init_http_options_if_undefined (options);
+	ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
 	
 	ho->server = p[1];
 	ho->port = port;
@@ -4996,7 +4914,7 @@ add_option (struct options *options,
     {
       struct http_proxy_options *ho;
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_options_if_undefined (options);
+      ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
       ho->retry = true;
     }
   else if (streq (p[0], "http-proxy-timeout") && p[1])
@@ -5004,7 +4922,7 @@ add_option (struct options *options,
       struct http_proxy_options *ho;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_options_if_undefined (options);
+      ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
       ho->timeout = positive_atoi (p[1]);
     }
   else if (streq (p[0], "http-proxy-option") && p[1])
@@ -5012,7 +4930,7 @@ add_option (struct options *options,
       struct http_proxy_options *ho;
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      ho = init_http_options_if_undefined (options);
+      ho = init_http_proxy_options_once (options->ce.http_proxy_options, &options->gc);
 
       if (streq (p[1], "VERSION") && p[2])
 	{
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 65ecf7f..306520b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -129,10 +129,7 @@ struct connection_entry
 #endif
 
 # define CE_DISABLED (1<<0)
-#if HTTP_PROXY_FALLBACK
-# define CE_HTTP_PROXY_FALLBACK (1<<1)
-  time_t ce_http_proxy_fallback_timestamp; /* time when fallback http_proxy_options was last updated */
-#endif
+# define CE_MAN_QUERY_PROXY (1<<1)
 # define CE_MAN_QUERY_REMOTE_UNDEF  0
 # define CE_MAN_QUERY_REMOTE_QUERY  1
 # define CE_MAN_QUERY_REMOTE_ACCEPT 2
@@ -167,14 +164,6 @@ struct remote_list
   struct remote_entry *array[CONNECTION_LIST_SIZE];
 };
 
-#if HTTP_PROXY_FALLBACK
-struct hpo_store
-{
-  struct http_proxy_options hpo;
-  char server[80];
-};
-#endif
-
 struct remote_host_store
 {
 # define RH_HOST_LEN 80
@@ -220,10 +209,8 @@ struct options
   struct remote_list *remote_list;
   bool force_connection_list;
 
-#if HTTP_PROXY_FALLBACK
-  bool http_proxy_fallback;
+#if HTTP_PROXY_OVERRIDE
   struct http_proxy_options *http_proxy_override;
-  struct hpo_store *hpo_store; /* used to store dynamic proxy info given by management interface */
 #endif
 
   struct remote_host_store *rh_store;
@@ -798,15 +785,4 @@ connection_list_set_no_advance (struct options *o)
     o->connection_list->no_advance = true;
 }
 
-#if HTTP_PROXY_FALLBACK
-
-struct http_proxy_options *
-parse_http_proxy_fallback (struct context *c,
-			   const char *server,
-			   const char *port,
-			   const char *flags,
-			   const int msglevel);
-
-#endif /* HTTP_PROXY_FALLBACK */
-
 #endif
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index d33f88f..202e55e 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -46,6 +46,21 @@
 
 #define UP_TYPE_PROXY        "HTTP Proxy"
 
+struct http_proxy_options *
+init_http_proxy_options_once (struct http_proxy_options *hpo,
+                              struct gc_arena *gc)
+{
+  if (!hpo)
+    {
+      ALLOC_OBJ_CLEAR_GC (hpo, struct http_proxy_options, gc);
+      /* http proxy defaults */
+      hpo->timeout = 5;
+      hpo->http_version = "1.0";
+    }
+  return hpo;
+}
+
+
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;
 
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 355a4c3..dc62261 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -70,6 +70,9 @@ struct http_proxy_info {
   bool queried_creds;
 };
 
+struct http_proxy_options *init_http_proxy_options_once (struct http_proxy_options *hpo,
+                                                         struct gc_arena *gc);
+
 struct http_proxy_info *http_proxy_new (const struct http_proxy_options *o);
 
 void http_proxy_close (struct http_proxy_info *hp);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index cecc91e..c81f08a 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -650,12 +650,12 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Should we include http proxy fallback functionality
+ * Should we include http proxy override functionality
  */
 #if defined(ENABLE_MANAGEMENT) && defined(ENABLE_HTTP_PROXY)
-#define HTTP_PROXY_FALLBACK 1
+#define HTTP_PROXY_OVERRIDE 1
 #else
-#define HTTP_PROXY_FALLBACK 0
+#define HTTP_PROXY_OVERRIDE 0
 #endif
 
 /*
-- 
1.7.9.5


