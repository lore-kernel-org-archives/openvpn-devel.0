From: Heiko Hund <heiko.hund@...1489...>
Date: Sun, 5 Feb 2012 13:47:09 +0100
Message-ID: <1328446029-30523-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove the --auto-proxy option from openvpn
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

During discussion on FOSDEM 2012 it was decided that proxy auto detection
is best done in the GUI as it's highly platform specific and shouldn't be
handled in openvpn itself for every supported platform in openvpn itself.

This removes --auto-proxy from openvpn.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 init.c    |   10 +--
 openvpn.8 |   12 ---
 options.c |   40 +----------
 options.h |    4 -
 proxy.c   |  242 +------------------------------------------------------------
 proxy.h   |   27 +-------
 socks.c   |   15 +----
 socks.h   |    3 +-
 8 files changed, 11 insertions(+), 342 deletions(-)

diff --git a/init.c b/init.c
index 525f441..c60a2e9 100644
--- a/init.c
+++ b/init.c
@@ -492,11 +492,10 @@ init_proxy_dowork (struct context *c)
   uninit_proxy_dowork (c);
 
 #ifdef ENABLE_HTTP_PROXY
-  if (c->options.ce.http_proxy_options || c->options.auto_proxy_info)
+  if (c->options.ce.http_proxy_options)
     {
       /* Possible HTTP proxy user/pass input */
-      c->c1.http_proxy = http_proxy_new (c->options.ce.http_proxy_options,
-					 c->options.auto_proxy_info);
+      c->c1.http_proxy = http_proxy_new (c->options.ce.http_proxy_options);
       if (c->c1.http_proxy)
 	{
 	  did_http = true;
@@ -506,13 +505,12 @@ init_proxy_dowork (struct context *c)
 #endif
 
 #ifdef ENABLE_SOCKS
-  if (!did_http && (c->options.ce.socks_proxy_server || c->options.auto_proxy_info))
+  if (!did_http && c->options.ce.socks_proxy_server)
     {
       c->c1.socks_proxy = socks_proxy_new (c->options.ce.socks_proxy_server,
 					   c->options.ce.socks_proxy_port,
 					   c->options.ce.socks_proxy_authfile,
-					   c->options.ce.socks_proxy_retry,
-					   c->options.auto_proxy_info);
+					   c->options.ce.socks_proxy_retry);
       if (c->c1.socks_proxy)
 	{
 	  c->c1.socks_proxy_owned = true;
diff --git a/openvpn.8 b/openvpn.8
index 00acd01..26a15e2 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -482,18 +482,6 @@ as the
 number of retries of connection attempt (default=infinite).
 .\"*********************************************************
 .TP
-.B \-\-auto-proxy
-Try to sense HTTP or SOCKS proxy settings automatically.
-If no settings are present, a direct connection will be attempted.
-If both HTTP and SOCKS settings are present, HTTP will be preferred.
-If the HTTP proxy server requires a password, it will be queried from
-stdin or the management interface.  If the underlying OS doesn't support an API for
-returning proxy settings, a direct connection will be attempted.
-Currently, only Windows clients support this option via the
-InternetQueryOption API.
-This option exists in OpenVPN 2.1 or higher.
-.\"*********************************************************
-.TP
 .B \-\-show-proxy-settings
 Show sensed HTTP or SOCKS proxy settings. Currently, only Windows clients
 support this option.
diff --git a/options.c b/options.c
index 6b8ae22..6f4b3df 100644
--- a/options.c
+++ b/options.c
@@ -124,10 +124,6 @@ static const char usage_message[] =
   "                    between connection retries (default=%d).\n"
   "--connect-timeout n : For --proto tcp-client, connection timeout (in seconds).\n"
   "--connect-retry-max n : Maximum connection attempt retries, default infinite.\n"
-#ifdef GENERAL_PROXY_SUPPORT
-  "--auto-proxy    : Try to sense proxy settings (or lack thereof) automatically.\n"
-  "--show-proxy-settings : Show sensed proxy settings.\n"
-#endif
 #ifdef ENABLE_HTTP_PROXY
   "--http-proxy s p [up] [auth] : Connect to remote host\n"
   "                  through an HTTP proxy at address s and port p.\n"
@@ -2053,8 +2049,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     msg (M_USAGE, "--remote MUST be used in TCP Client mode");
 
 #ifdef ENABLE_HTTP_PROXY
-  if ((ce->http_proxy_options || options->auto_proxy_info) && ce->proto != PROTO_TCPv4_CLIENT)
-    msg (M_USAGE, "--http-proxy or --auto-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
+  if ((ce->http_proxy_options) && ce->proto != PROTO_TCPv4_CLIENT)
+    msg (M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
 #endif
 
 #if defined(ENABLE_HTTP_PROXY) && defined(ENABLE_SOCKS)
@@ -4890,38 +4886,6 @@ add_option (struct options *options,
       options->proto_force = proto_force;
       options->force_connection_list = true;
     }
-#ifdef GENERAL_PROXY_SUPPORT
-  else if (streq (p[0], "auto-proxy"))
-    {
-      char *error = NULL;
-
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->auto_proxy_info = get_proxy_settings (&error, &options->gc);
-      if (error)
-	msg (M_WARN, "PROXY: %s", error);
-    }
-  else if (streq (p[0], "show-proxy-settings"))
-    {
-      struct auto_proxy_info *pi;
-      char *error = NULL;
-
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      pi = get_proxy_settings (&error, &options->gc);
-      if (pi)
-	{
-	  msg (M_INFO|M_NOPREFIX, "HTTP Server: %s", np(pi->http.server));
-	  msg (M_INFO|M_NOPREFIX, "HTTP Port: %d", pi->http.port);
-	  msg (M_INFO|M_NOPREFIX, "SOCKS Server: %s", np(pi->socks.server));
-	  msg (M_INFO|M_NOPREFIX, "SOCKS Port: %d", pi->socks.port);
-	}
-      if (error)
-	msg (msglevel, "Proxy error: %s", error);
-#ifdef WIN32
-      show_win_proxy_settings (M_INFO|M_NOPREFIX);
-#endif
-      openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
-    }
-#endif /* GENERAL_PROXY_SUPPORT */
 #ifdef ENABLE_HTTP_PROXY
   else if (streq (p[0], "http-proxy") && p[1])
     {
diff --git a/options.h b/options.h
index 831d4f6..8f22afd 100644
--- a/options.h
+++ b/options.h
@@ -214,10 +214,6 @@ struct options
   bool force_connection_list;
 #endif
 
-#ifdef GENERAL_PROXY_SUPPORT
-  struct auto_proxy_info *auto_proxy_info;
-#endif
-
 #if HTTP_PROXY_FALLBACK
   bool http_proxy_fallback;
   struct http_proxy_options *http_proxy_override;
diff --git a/proxy.c b/proxy.c
index 5e74af2..4bb936f 100644
--- a/proxy.c
+++ b/proxy.c
@@ -415,47 +415,11 @@ get_pa_var (const char *key, const char *pa, struct gc_arena *gc)
 }
 
 struct http_proxy_info *
-http_proxy_new (const struct http_proxy_options *o,
-		struct auto_proxy_info *auto_proxy_info)
+http_proxy_new (const struct http_proxy_options *o)
 {
   struct http_proxy_info *p;
   struct http_proxy_options opt;
 
-  if (auto_proxy_info)
-    {
-      if (o && o->server)
-	{
-	  /* if --http-proxy explicitly given, disable auto-proxy */
-	  auto_proxy_info = NULL;
-	}
-      else
-	{
-	  /* if no --http-proxy explicitly given and no auto settings, fail */
-	  if (!auto_proxy_info->http.server)
-	    return NULL;
-
-	  if (o)
-	    {
-	      opt = *o;
-	    }
-	  else
-	    {
-	      CLEAR (opt);
-	  
-	      /* These settings are only used for --auto-proxy */
-	      opt.timeout = 5;
-	      opt.http_version = "1.0";
-	    }
-
-	  opt.server = auto_proxy_info->http.server;
-	  opt.port = auto_proxy_info->http.port;
-	  if (!opt.auth_retry)
-	    opt.auth_retry = PAR_ALL;
-
-	  o = &opt;
-	}
-    }
-
   if (!o || !o->server)
     msg (M_FATAL, "HTTP_PROXY: server not specified");
 
@@ -521,7 +485,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
   bool ret = false;
   bool processed = false;
 
-  /* get user/pass if not previously given or if --auto-proxy is being used */
+  /* get user/pass if not previously given */
   if (p->auth_method == HTTP_AUTH_BASIC
       || p->auth_method == HTTP_AUTH_DIGEST
       || p->auth_method == HTTP_AUTH_NTLM)
@@ -920,205 +884,3 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 static void dummy(void) {}
 #endif /* ENABLE_HTTP_PROXY */
 
-#ifdef GENERAL_PROXY_SUPPORT
-
-#ifdef WIN32
-
-#if 0
-char *
-get_windows_internet_string (const DWORD dwOption, struct gc_arena *gc)
-{
-  DWORD size = 0;
-  char *ret = NULL;
-
-  /* Initially, get size of return buffer */
-  InternetQueryOption (NULL, dwOption, NULL, &size);
-  if (size)
-    {
-      /* Now get actual info */
-      ret = (INTERNET_PROXY_INFO *) gc_malloc (size, false, gc);
-      if (!InternetQueryOption (NULL, dwOption, (LPVOID) ret, &size))
-	ret = NULL;
-    }
-  return ret;
-}
-#endif
-
-static INTERNET_PROXY_INFO *
-get_windows_proxy_settings (struct gc_arena *gc)
-{
-  DWORD size = 0;
-  INTERNET_PROXY_INFO *ret = NULL;
-
-  /* Initially, get size of return buffer */
-  InternetQueryOption (NULL, INTERNET_OPTION_PROXY, NULL, &size);
-  if (size)
-    {
-      /* Now get actual info */
-      ret = (INTERNET_PROXY_INFO *) gc_malloc (size, false, gc);
-      if (!InternetQueryOption (NULL, INTERNET_OPTION_PROXY, (LPVOID) ret, &size))
-	ret = NULL;
-    }
-  return ret;
-}
-
-static const char *
-parse_windows_proxy_setting (const char *str, struct auto_proxy_info_entry *e, struct gc_arena *gc)
-{
-  char buf[128];
-  const char *ret = NULL;
-  struct buffer in;
-
-  CLEAR (*e);
-
-  buf_set_read (&in, (const uint8_t *)str, strlen (str));
-
-  if (strchr (str, '=') != NULL)
-    {
-      if (buf_parse (&in, '=', buf, sizeof (buf)))
-	ret = string_alloc (buf, gc);
-    }
-	
-  if (buf_parse (&in, ':', buf, sizeof (buf)))
-    e->server = string_alloc (buf, gc);
-
-  if (e->server && buf_parse (&in, '\0', buf, sizeof (buf)))
-    e->port = atoi (buf);
-
-  return ret;
-}
-
-static void
-parse_windows_proxy_setting_list (const char *str, const char *type, struct auto_proxy_info_entry *e, struct gc_arena *gc)
-{
-  struct gc_arena gc_local = gc_new ();
-  struct auto_proxy_info_entry el;
-
-  CLEAR (*e);
-  if (type)
-    {
-      char buf[128];
-      struct buffer in;
-
-      buf_set_read (&in, (const uint8_t *)str, strlen (str));
-      if (strchr (str, '=') != NULL)
-	{
-	  while (buf_parse (&in, ' ', buf, sizeof (buf)))
-	    {
-	      const char *t = parse_windows_proxy_setting (buf, &el, &gc_local);
-	      if (t && !strcmp (t, type))
-		goto found;
-	    }
-	}
-    }
-  else
-    {
-      if (!parse_windows_proxy_setting (str, &el, &gc_local))
-	goto found;
-    }
-  goto done;
-
- found:
-  if (el.server && el.port > 0)
-    {
-      e->server = string_alloc (el.server, gc);
-      e->port = el.port;
-    }
-
- done:
-  gc_free (&gc_local);
-}
-
-static const char *
-win_proxy_access_type (const DWORD dwAccessType)
-{
-  switch (dwAccessType)
-    {
-    case INTERNET_OPEN_TYPE_DIRECT:
-      return "INTERNET_OPEN_TYPE_DIRECT";
-    case INTERNET_OPEN_TYPE_PROXY:
-      return "INTERNET_OPEN_TYPE_PROXY";
-    default:
-      return "[UNKNOWN]";
-    }
-}
-
-void
-show_win_proxy_settings (const int msglevel)
-{
-  INTERNET_PROXY_INFO *info;
-  struct gc_arena gc = gc_new ();
-
-  info = get_windows_proxy_settings (&gc);
-  msg (msglevel, "PROXY INFO: %s %s",
-       win_proxy_access_type (info->dwAccessType),
-       info->lpszProxy ? info->lpszProxy : "[NULL]");
-
-  gc_free (&gc);
-}
-
-struct auto_proxy_info *
-get_proxy_settings (char **err, struct gc_arena *gc)
-{
-  struct gc_arena gc_local = gc_new ();
-  INTERNET_PROXY_INFO *info;
-  struct auto_proxy_info *pi;
-
-  ALLOC_OBJ_CLEAR_GC (pi, struct auto_proxy_info, gc);
-
-  if (err)
-    *err = NULL;
-
-  info = get_windows_proxy_settings (&gc_local);
-
-  if (!info)
-    {
-      if (err)
-	*err = "PROXY: failed to obtain windows proxy info";
-      goto done;
-    }
-
-  switch (info->dwAccessType)
-    {
-    case INTERNET_OPEN_TYPE_DIRECT:
-      break;
-    case INTERNET_OPEN_TYPE_PROXY:
-      if (!info->lpszProxy)
-	break;
-      parse_windows_proxy_setting_list (info->lpszProxy, NULL, &pi->http, gc);
-      if (!pi->http.server)
-	parse_windows_proxy_setting_list (info->lpszProxy, "http", &pi->http, gc);
-      parse_windows_proxy_setting_list (info->lpszProxy, "socks", &pi->socks, gc);
-      break;
-    default:
-      if (err)
-	*err = "PROXY: unknown proxy type";
-      break;
-    }
-
- done:
-  gc_free (&gc_local);
-  return pi;
-}
-
-#else
-
-struct auto_proxy_info *
-get_proxy_settings (char **err, struct gc_arena *gc)
-{
-#if 1
-  if (err)
-    *err = string_alloc ("PROXY: automatic detection not supported on this OS", gc);
-  return NULL;
-#else /* test --auto-proxy feature */
-  struct auto_proxy_info *pi;
-  ALLOC_OBJ_CLEAR_GC (pi, struct auto_proxy_info, gc);
-  pi->http.server = "10.10.0.2";
-  pi->http.port = 4000;
-  return pi;
-#endif
-}
-
-#endif
-
-#endif /* GENERAL_PROXY_SUPPORT */
diff --git a/proxy.h b/proxy.h
index d89aa4a..355a4c3 100644
--- a/proxy.h
+++ b/proxy.h
@@ -28,30 +28,6 @@
 #include "buffer.h"
 #include "misc.h"
 
-#ifdef GENERAL_PROXY_SUPPORT
-
-/*
- * Return value for get_proxy_settings to automatically
- * determine proxy information.
- */
-struct auto_proxy_info_entry {
-  char *server;
-  int port;
-};
-
-struct auto_proxy_info {
-  struct auto_proxy_info_entry http;
-  struct auto_proxy_info_entry socks;
-};
-
-struct auto_proxy_info *get_proxy_settings (char **err, struct gc_arena *gc);
-
-#ifdef WIN32
-void show_win_proxy_settings (const int msglevel);
-#endif /* WIN32 */
-
-#endif /* GENERAL_PROXY_SUPPORT */
-
 #ifdef ENABLE_HTTP_PROXY
 
 /* HTTP CONNECT authentication methods */
@@ -94,8 +70,7 @@ struct http_proxy_info {
   bool queried_creds;
 };
 
-struct http_proxy_info *http_proxy_new (const struct http_proxy_options *o,
-					struct auto_proxy_info *auto_proxy_info);
+struct http_proxy_info *http_proxy_new (const struct http_proxy_options *o);
 
 void http_proxy_close (struct http_proxy_info *hp);
 
diff --git a/socks.c b/socks.c
index 949d256..ac5bd58 100644
--- a/socks.c
+++ b/socks.c
@@ -57,23 +57,10 @@ struct socks_proxy_info *
 socks_proxy_new (const char *server,
 		 int port,
 		 const char *authfile,
-		 bool retry,
-		 struct auto_proxy_info *auto_proxy_info)
+		 bool retry)
 {
   struct socks_proxy_info *p;
 
-  if (auto_proxy_info)
-    {
-      if (!server)
-	{
-	  if (!auto_proxy_info->socks.server)
-	    return NULL;
-
-	  server = auto_proxy_info->socks.server;
-	  port = auto_proxy_info->socks.port;
-	}
-    }
-
   ALLOC_OBJ_CLEAR (p, struct socks_proxy_info);
 
   ASSERT (server);
diff --git a/socks.h b/socks.h
index b748bb3..b55ff6f 100644
--- a/socks.h
+++ b/socks.h
@@ -51,8 +51,7 @@ void socks_adjust_frame_parameters (struct frame *frame, int proto);
 struct socks_proxy_info *socks_proxy_new (const char *server,
 					  int port,
 					  const char *authfile,
-					  bool retry,
-					  struct auto_proxy_info *auto_proxy_info);
+					  bool retry);
 
 void socks_proxy_close (struct socks_proxy_info *sp);
 
-- 
1.7.5.4


