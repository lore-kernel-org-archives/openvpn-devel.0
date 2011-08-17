From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 13:42:48 +0000
Message-Id: <1313588569-18927-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 2/3] do automatic proxy detection on Windows
	right
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

Automatic proxy detection is now done using WinHTTP and its built
in support for WPAD and PAC. This also means that settings for the
currently active network connection are queried, instead of using
the default one all the time.

If WPAD or a PAC script are not configured or fail, the static Internet
Options proxy settings from the Control Panel are taken into account.
If those are unavailable as well, the default proxy configuration, set
with proxycfg.exe, is used.

Closes ticket #24.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 openvpn.8 |    9 ++--
 options.c |    9 ++--
 proxy.c   |  173 ++++++++++++++++++++++++++++++++++--------------------------
 proxy.h   |    4 +-
 4 files changed, 110 insertions(+), 85 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 7118737..3855e86 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -490,13 +490,14 @@ If the HTTP proxy server requires a password, it will be queried from
 stdin or the management interface.  If the underlying OS doesn't support an API for
 returning proxy settings, a direct connection will be attempted.
 Currently, only Windows clients support this option via the
-InternetQueryOption API.
+WinHTTP API.
 This option exists in OpenVPN 2.1 or higher.
 .\"*********************************************************
 .TP
-.B \-\-show-proxy-settings
-Show sensed HTTP or SOCKS proxy settings. Currently, only Windows clients
-support this option.
+.B \-\-show-proxy-settings [url]
+Show sensed HTTP or SOCKS proxy settings. The optional URL parameter is used
+with the PAC script, if there is one detected or configured. Currently, only
+Windows clients support this option.
 .\"*********************************************************
 .TP
 .B \-\-http-proxy server port [authfile|'auto'|'auto-nct'] [auth-method]
diff --git a/options.c b/options.c
index 77e7c7f..62c2ac8 100644
--- a/options.c
+++ b/options.c
@@ -118,7 +118,7 @@ static const char usage_message[] =
   "--connect-retry-max n : Maximum connection attempt retries, default infinite.\n"
 #ifdef GENERAL_PROXY_SUPPORT
   "--auto-proxy    : Try to sense proxy settings (or lack thereof) automatically.\n"
-  "--show-proxy-settings : Show sensed proxy settings.\n"
+  "--show-proxy-settings [url] : Show sensed proxy settings for url.\n"
 #endif
 #ifdef ENABLE_HTTP_PROXY
   "--http-proxy s p [up] [auth] : Connect to remote host\n"
@@ -4677,17 +4677,18 @@ add_option (struct options *options,
       char *error = NULL;
 
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->auto_proxy_info = get_proxy_settings (&error, &options->gc);
+      options->auto_proxy_info = get_proxy_settings ("https://openvpn.net", &error, &options->gc);
       if (error)
 	msg (M_WARN, "PROXY: %s", error);
     }
   else if (streq (p[0], "show-proxy-settings"))
     {
       struct auto_proxy_info *pi;
+      const char *url = p[1] ? p[1] : "https://openvpn.net";
       char *error = NULL;
 
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      pi = get_proxy_settings (&error, &options->gc);
+      pi = get_proxy_settings (url, &error, &options->gc);
       if (pi)
 	{
 	  msg (M_INFO|M_NOPREFIX, "HTTP Server: %s", np(pi->http.server));
@@ -4698,7 +4699,7 @@ add_option (struct options *options,
       if (error)
 	msg (msglevel, "Proxy error: %s", error);
 #ifdef WIN32
-      show_win_proxy_settings (M_INFO|M_NOPREFIX);
+      show_win_proxy_settings (url, M_INFO|M_NOPREFIX);
 #endif
       openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
diff --git a/proxy.c b/proxy.c
index b00532c..3403c1a 100644
--- a/proxy.c
+++ b/proxy.c
@@ -924,42 +924,99 @@ static void dummy(void) {}
 
 #ifdef WIN32
 
-#if 0
-char *
-get_windows_internet_string (const DWORD dwOption, struct gc_arena *gc)
+static char *
+get_windows_proxy_settings (const char *url, struct gc_arena *gc)
 {
-  DWORD size = 0;
-  char *ret = NULL;
+  char *retval = NULL;
+  LPWSTR proxy = NULL;
+  LPWSTR auto_config_url = NULL;
+  BOOL auto_detect = FALSE;
+  WINHTTP_PROXY_INFO proxy_info;
+  WINHTTP_CURRENT_USER_IE_PROXY_CONFIG proxy_config;
+
+  if (WinHttpGetIEProxyConfigForCurrentUser (&proxy_config))
+    {
+      auto_detect = proxy_config.fAutoDetect;
+      auto_config_url = proxy_config.lpszAutoConfigUrl;
+      proxy = proxy_config.lpszProxy;
+      GlobalFree (proxy_config.lpszProxyBypass);
+    }
+  else if (GetLastError () == ERROR_FILE_NOT_FOUND &&
+           WinHttpGetDefaultProxyConfiguration (&proxy_info))
+    {
+      if (proxy_info.dwAccessType == WINHTTP_ACCESS_TYPE_NAMED_PROXY)
+      {
+	proxy = proxy_info.lpszProxy;
+	GlobalFree (proxy_info.lpszProxyBypass);
+      }
+    }
+  else /* failed to get proxy info, try to auto detect it */
+    {
+      auto_detect = TRUE;
+    }
 
-  /* Initially, get size of return buffer */
-  InternetQueryOption (NULL, dwOption, NULL, &size);
-  if (size)
+  if (auto_detect)
     {
-      /* Now get actual info */
-      ret = (INTERNET_PROXY_INFO *) gc_malloc (size, false, gc);
-      if (!InternetQueryOption (NULL, dwOption, (LPVOID) ret, &size))
-	ret = NULL;
+      LPWSTR old_url = auto_config_url;
+      DWORD flags = WINHTTP_AUTO_DETECT_TYPE_DHCP | WINHTTP_AUTO_DETECT_TYPE_DNS_A;
+
+      if (WinHttpDetectAutoProxyConfigUrl (flags, &auto_config_url))
+	GlobalFree (old_url);
     }
-  return ret;
-}
-#endif
 
-static INTERNET_PROXY_INFO *
-get_windows_proxy_settings (struct gc_arena *gc)
-{
-  DWORD size = 0;
-  INTERNET_PROXY_INFO *ret = NULL;
+  if (auto_config_url && url)
+    {
+      HINTERNET session;
+      WINHTTP_AUTOPROXY_OPTIONS options = {
+	.dwFlags = WINHTTP_AUTOPROXY_CONFIG_URL,
+	.dwAutoDetectFlags = 0,
+	.lpszAutoConfigUrl = auto_config_url,
+	.lpvReserved = NULL,
+	.dwReserved = 0,
+	.fAutoLogonIfChallenged = FALSE
+      };
+
+      session = WinHttpOpen (NULL, WINHTTP_ACCESS_TYPE_NO_PROXY,
+                             WINHTTP_NO_PROXY_NAME, WINHTTP_NO_PROXY_BYPASS, 0);
+      if (session)
+	{
+	  LPWSTR old_proxy = proxy;
+	  LPWSTR url_w;
+	  int size;
 
-  /* Initially, get size of return buffer */
-  InternetQueryOption (NULL, INTERNET_OPTION_PROXY, NULL, &size);
-  if (size)
+	  size = MultiByteToWideChar (CP_ACP, 0, url, -1, NULL, 0);
+	  url_w = gc_malloc (size * sizeof (WCHAR), 0, gc);
+	  MultiByteToWideChar (CP_ACP, 0, url, -1, url_w, size);
+
+	  if (WinHttpGetProxyForUrl (session, url_w, &options, &proxy_info))
+	    {
+	      GlobalFree (old_proxy);
+	      GlobalFree (proxy_info.lpszProxyBypass);
+	      proxy = proxy_info.lpszProxy;
+	    }
+
+	  WinHttpCloseHandle (session);
+	}
+
+      GlobalFree (auto_config_url);
+    }
+
+  if (proxy)
     {
-      /* Now get actual info */
-      ret = (INTERNET_PROXY_INFO *) gc_malloc (size, false, gc);
-      if (!InternetQueryOption (NULL, INTERNET_OPTION_PROXY, (LPVOID) ret, &size))
-	ret = NULL;
+      int size;
+      BOOL invalid_chars;
+      size = WideCharToMultiByte (CP_ACP, WC_NO_BEST_FIT_CHARS, proxy, -1,
+                                  NULL, 0, "_", &invalid_chars);
+      if (!invalid_chars)
+	{
+	  retval = gc_malloc (size, 0, gc);
+	  WideCharToMultiByte (CP_ACP, 0, proxy, -1, retval, size, NULL, NULL);
+	}
+
+      GlobalFree (proxy);
     }
-  return ret;
+
+  return retval;
 }
 
 static const char *
@@ -1003,7 +1060,7 @@ parse_windows_proxy_setting_list (const char *str, const char *type, struct auto
       buf_set_read (&in, (const uint8_t *)str, strlen (str));
       if (strchr (str, '=') != NULL)
 	{
-	  while (buf_parse (&in, ' ', buf, sizeof (buf)))
+	  while (buf_parse (&in, ';', buf, sizeof (buf)))
 	    {
 	      const char *t = parse_windows_proxy_setting (buf, &el, &gc_local);
 	      if (t && !strcmp (t, type))
@@ -1029,74 +1086,40 @@ parse_windows_proxy_setting_list (const char *str, const char *type, struct auto
   gc_free (&gc_local);
 }
 
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
 void
-show_win_proxy_settings (const int msglevel)
+show_win_proxy_settings (const char *url, const int msglevel)
 {
-  INTERNET_PROXY_INFO *info;
+  char *settings;
   struct gc_arena gc = gc_new ();
 
-  info = get_windows_proxy_settings (&gc);
-  msg (msglevel, "PROXY INFO: %s %s",
-       win_proxy_access_type (info->dwAccessType),
-       info->lpszProxy ? info->lpszProxy : "[NULL]");
+  settings = get_windows_proxy_settings (url, &gc);
+  msg (msglevel, "PROXY INFO: proxy: %s", settings ? settings : "[NULL]");
 
   gc_free (&gc);
 }
 
 struct auto_proxy_info *
-get_proxy_settings (char **err, struct gc_arena *gc)
+get_proxy_settings (const char *url, char **err, struct gc_arena *gc)
 {
   struct gc_arena gc_local = gc_new ();
-  INTERNET_PROXY_INFO *info;
   struct auto_proxy_info *pi;
+  char *settings;
 
   ALLOC_OBJ_CLEAR_GC (pi, struct auto_proxy_info, gc);
 
   if (err)
     *err = NULL;
 
-  info = get_windows_proxy_settings (&gc_local);
+  settings = get_windows_proxy_settings (url, &gc_local);
 
-  if (!info)
+  if (settings)
     {
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
+      parse_windows_proxy_setting_list (settings, NULL, &pi->http, gc);
       if (!pi->http.server)
-	parse_windows_proxy_setting_list (info->lpszProxy, "http", &pi->http, gc);
-      parse_windows_proxy_setting_list (info->lpszProxy, "socks", &pi->socks, gc);
-      break;
-    default:
-      if (err)
-	*err = "PROXY: unknown proxy type";
-      break;
+	parse_windows_proxy_setting_list (settings, "http", &pi->http, gc);
+      parse_windows_proxy_setting_list (settings, "socks", &pi->socks, gc);
     }
 
- done:
   gc_free (&gc_local);
   return pi;
 }
@@ -1104,7 +1127,7 @@ get_proxy_settings (char **err, struct gc_arena *gc)
 #else
 
 struct auto_proxy_info *
-get_proxy_settings (char **err, struct gc_arena *gc)
+get_proxy_settings (const char *url, char **err, struct gc_arena *gc)
 {
 #if 1
   if (err)
diff --git a/proxy.h b/proxy.h
index d89aa4a..daa4907 100644
--- a/proxy.h
+++ b/proxy.h
@@ -44,10 +44,10 @@ struct auto_proxy_info {
   struct auto_proxy_info_entry socks;
 };
 
-struct auto_proxy_info *get_proxy_settings (char **err, struct gc_arena *gc);
+struct auto_proxy_info *get_proxy_settings (const char *url, char **err, struct gc_arena *gc);
 
 #ifdef WIN32
-void show_win_proxy_settings (const int msglevel);
+void show_win_proxy_settings (const char *url, const int msglevel);
 #endif /* WIN32 */
 
 #endif /* GENERAL_PROXY_SUPPORT */
-- 
1.7.5.4


