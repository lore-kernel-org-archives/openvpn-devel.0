From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 13:42:49 +0000
Message-Id: <1313588569-18927-4-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 3/3] query auto-proxy information when
	connecting
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

Delaying automatic proxy detection from the time options are parsed
to connection initialization makes sense as proxy information may have
changed since the tunnel was established. Especially if the network
connection or PAC script changed since then. Now, if openvpn receives
an SIGUSR1 it requeries the settings and uses them.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 init.c    |   23 +++++++++++++++++++----
 options.c |    8 ++------
 options.h |    2 +-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/init.c b/init.c
index 4a16fba..8219a11 100644
--- a/init.c
+++ b/init.c
@@ -388,15 +388,30 @@ init_proxy_dowork (struct context *c)
 #else
   const bool did_http = false;
 #endif
+  struct auto_proxy_info *auto_proxy_info = NULL;
 
   uninit_proxy_dowork (c);
 
+  if (c->options.auto_proxy)
+    {
+      char *error;
+      char url[128];
+
+      openvpn_snprintf (url, sizeof (url), "%s://%s:%d/",
+			(proto_is_udp (c->options.ce.proto) ? "socks" : "https"),
+			c->options.ce.remote, c->options.ce.remote_port);
+
+      auto_proxy_info = get_proxy_settings (url, &error, &c->c2.gc);
+      if (error)
+	msg (M_WARN, "PROXY: %s", error);
+    }
+
 #ifdef ENABLE_HTTP_PROXY
-  if (c->options.ce.http_proxy_options || c->options.auto_proxy_info)
+  if (c->options.ce.http_proxy_options || auto_proxy_info)
     {
       /* Possible HTTP proxy user/pass input */
       c->c1.http_proxy = http_proxy_new (c->options.ce.http_proxy_options,
-					 c->options.auto_proxy_info);
+					 auto_proxy_info);
       if (c->c1.http_proxy)
 	{
 	  did_http = true;
@@ -406,13 +421,13 @@ init_proxy_dowork (struct context *c)
 #endif
 
 #ifdef ENABLE_SOCKS
-  if (!did_http && (c->options.ce.socks_proxy_server || c->options.auto_proxy_info))
+  if (!did_http && (c->options.ce.socks_proxy_server || auto_proxy_info))
     {
       c->c1.socks_proxy = socks_proxy_new (c->options.ce.socks_proxy_server,
 					   c->options.ce.socks_proxy_port,
 					   c->options.ce.socks_proxy_authfile,
 					   c->options.ce.socks_proxy_retry,
-					   c->options.auto_proxy_info);
+					   auto_proxy_info);
       if (c->c1.socks_proxy)
 	{
 	  c->c1.socks_proxy_owned = true;
diff --git a/options.c b/options.c
index 62c2ac8..c6243cd 100644
--- a/options.c
+++ b/options.c
@@ -2025,7 +2025,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     msg (M_USAGE, "--remote MUST be used in TCP Client mode");
 
 #ifdef ENABLE_HTTP_PROXY
-  if ((ce->http_proxy_options || options->auto_proxy_info) && ce->proto != PROTO_TCPv4_CLIENT)
+  if ((ce->http_proxy_options || options->auto_proxy) && ce->proto != PROTO_TCPv4_CLIENT)
     msg (M_USAGE, "--http-proxy or --auto-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
 #endif
 
@@ -4674,12 +4674,8 @@ add_option (struct options *options,
 #ifdef GENERAL_PROXY_SUPPORT
   else if (streq (p[0], "auto-proxy"))
     {
-      char *error = NULL;
-
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->auto_proxy_info = get_proxy_settings ("https://openvpn.net", &error, &options->gc);
-      if (error)
-	msg (M_WARN, "PROXY: %s", error);
+      options->auto_proxy = true;
     }
   else if (streq (p[0], "show-proxy-settings"))
     {
diff --git a/options.h b/options.h
index 8a51502..47b7ddb 100644
--- a/options.h
+++ b/options.h
@@ -193,7 +193,7 @@ struct options
 #endif
 
 #ifdef GENERAL_PROXY_SUPPORT
-  struct auto_proxy_info *auto_proxy_info;
+  bool auto_proxy;
 #endif
 
 #if HTTP_PROXY_FALLBACK
-- 
1.7.5.4


