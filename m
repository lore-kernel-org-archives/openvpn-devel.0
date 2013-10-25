From: Arne Schwabe <arne@...1227...>
Date: Fri, 25 Oct 2013 10:02:23 +0200
Message-Id: <1382688143-17247-1-git-send-email-arne@...1227...>
In-Reply-To: <1379770778-21238-1-git-send-email-arne@...1227...>
References: <1379770778-21238-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v4] Implement custom HTTP header for
	http-proxy, always send user-agent
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

There are some patched OpenVPN versions out there without source code (e.g. NDMVPN) that support adding custom http header.

This patch adds custom header to OpenVPN and supports the syntax that the "in the wild" variants use.

Patch v3 also prints all custom headers with other http options in --verb 5
Patch v4 does clean up the add_proxy_header function
---
 doc/openvpn.8         |    7 ++++
 src/openvpn/options.c |   37 ++++++++++++++++++++
 src/openvpn/proxy.c   |   90 +++++++++++++++++++++++++++++++++++++------------
 src/openvpn/proxy.h   |    7 ++++
 4 files changed, 120 insertions(+), 21 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index c0b209c..25576ed 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -552,6 +552,13 @@ Set HTTP version number to
 .B AGENT user-agent \-\-
 Set HTTP "User-Agent" string to
 .B user-agent.
+
+.B CUSTOM\-HEADER name content \-\-
+Adds the custom Header with 
+.B name
+as name and 
+.B content
+as the content of the custom HTTP header.
 .\"*********************************************************
 .TP
 .B \-\-socks-proxy server [port]
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d0271f..7eb3da2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1295,6 +1295,7 @@ option_iroute_ipv6 (struct options *o,
 static void
 show_http_proxy_options (const struct http_proxy_options *o)
 {
+  int i;
   msg (D_SHOW_PARMS, "BEGIN http_proxy");
   SHOW_STR (server);
   SHOW_INT (port);
@@ -1304,6 +1305,15 @@ show_http_proxy_options (const struct http_proxy_options *o)
   SHOW_INT (timeout);
   SHOW_STR (http_version);
   SHOW_STR (user_agent);
+  for  (i=0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name;i++)
+    {
+      if (o->custom_headers[i].content)
+	msg (D_SHOW_PARMS, "  custom_header[%d] = %s: %s", i,
+	       o->custom_headers[i].name, o->custom_headers[i].content);
+      else
+	msg (D_SHOW_PARMS, "  custom_header[%d] = %s", i,
+	     o->custom_headers[i].name);
+    }
   msg (D_SHOW_PARMS, "END http_proxy");
 }
 #endif
@@ -5061,6 +5071,33 @@ add_option (struct options *options,
 	{
 	  ho->user_agent = p[2];
 	}
+      else if ((streq (p[1], "EXT1") || streq(p[1], "EXT2") || streq(p[1], "CUSTOM-HEADER"))
+	       && p[2])
+	{
+	  /* In the wild patched versions use both EXT1/2 and CUSTOM-HEADER with either two
+	   * argument or one */
+
+	  struct http_custom_header *custom_header =NULL;
+	  int i;
+	  /* Find the first free header */
+	  for (i=0; i < MAX_CUSTOM_HTTP_HEADER; i++) {
+	    if (!ho->custom_headers[i].name) {
+	      custom_header = &ho->custom_headers[i];
+	      break;
+	    }
+	  }
+	  if (!custom_header)
+	    {
+	      msg (msglevel, "Cannot use more than %d http-proxy-option CUSTOM-HEAER : '%s'", MAX_CUSTOM_HTTP_HEADER, p[1]);
+	    }
+	  else
+	    {
+	      /* We will save p[2] and p[3], the proxy code will detect if 
+	       * p[3] is NULL */
+	      custom_header->name = p[2];
+	      custom_header->content = p[3];
+	    }
+	}
       else
 	{
 	  msg (msglevel, "Bad http-proxy-option or missing parameter: '%s'", p[1]);
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 04ed421..79cede8 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -489,6 +489,68 @@ http_proxy_close (struct http_proxy_info *hp)
 }
 
 bool
+add_proxy_headers (struct http_proxy_info *p,
+		  socket_descriptor_t sd, /* already open to proxy */
+		  const char *host,	  /* openvpn server remote */
+		  const char *port	  /* openvpn server port */
+		  )
+{
+  char buf[512];
+  int i;
+  bool host_header_sent=false;
+  
+  /*
+   * Send custom headers if provided
+   * If content is NULL the whole header is in name
+   * Also remember if we already sent a Host: header
+   */
+  for  (i=0; i < MAX_CUSTOM_HTTP_HEADER && p->options.custom_headers[i].name;i++)
+    {
+      if (p->options.custom_headers[i].content)
+	{
+	  openvpn_snprintf (buf, sizeof(buf), "%s: %s",
+			    p->options.custom_headers[i].name,
+			    p->options.custom_headers[i].content);
+	  if (!strcasecmp(p->options.custom_headers[i].name, "Host"))
+	      host_header_sent=true;
+	}
+      else
+	{
+	  openvpn_snprintf (buf, sizeof(buf), "%s",
+			    p->options.custom_headers[i].name);
+	  if (!strncasecmp(p->options.custom_headers[i].name, "Host:", 5))
+	      host_header_sent=true;
+	}
+
+      msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+      if (!send_line_crlf (sd, buf))
+	return false;
+    }
+
+  if (!host_header_sent)
+    {
+    openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
+    msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+    if (!send_line_crlf(sd, buf))
+      return false;
+    }
+
+  /* send User-Agent string if provided */
+  if (p->options.user_agent)
+    {
+      openvpn_snprintf (buf, sizeof(buf), "User-Agent: %s",
+			p->options.user_agent);
+      msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+      if (!send_line_crlf (sd, buf))
+	return false;
+    }
+
+
+  return true;
+}
+
+
+bool
 establish_http_proxy_passthru (struct http_proxy_info *p,
 			       socket_descriptor_t sd, /* already open to proxy */
 			       const char *host,       /* openvpn server remote */
@@ -530,19 +592,9 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
       /* send HTTP CONNECT message to proxy */
       if (!send_line_crlf (sd, buf))
 	goto error;
-
-      openvpn_snprintf(buf, sizeof(buf), "Host: %s", host);
-      if (!send_line_crlf(sd, buf))
-        goto error;
-
-      /* send User-Agent string if provided */
-      if (p->options.user_agent)
-	{
-	  openvpn_snprintf (buf, sizeof(buf), "User-Agent: %s",
-			    p->options.user_agent);
-	  if (!send_line_crlf (sd, buf))
-	    goto error;
-	}
+      
+      if(!add_proxy_headers (p, sd, host, port))
+	goto error;
 
       /* auth specified? */
       switch (p->auth_method)
@@ -659,12 +711,10 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 
           
           /* send HOST etc, */
-          openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
-          msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
-          if (!send_line_crlf (sd, buf))
-            goto error;
+	  if(!add_proxy_headers (p, sd, host, port))
+	    goto error;
 
-          msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 3");
+	  msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 3");
 	  {
 	    const char *np3 = ntlm_phase_3 (p, buf2, &gc);
 	    if (!np3)
@@ -770,9 +820,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 		goto error;
 
 	      /* send HOST etc, */
-	      openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
-	      msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
-	      if (!send_line_crlf (sd, buf))
+	      if(!add_proxy_headers (p, sd, host, port))
 		goto error;
 
 	      /* send digest response */
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 5e476f1..b72748f 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -38,6 +38,12 @@
 #define HTTP_AUTH_NTLM2  4
 #define HTTP_AUTH_N      5 /* number of HTTP_AUTH methods */
 
+struct http_custom_header {
+  const char *name;
+  const char *content;
+};
+
+#define MAX_CUSTOM_HTTP_HEADER 10
 struct http_proxy_options {
   const char *server;
   int port;
@@ -53,6 +59,7 @@ struct http_proxy_options {
   const char *auth_file;
   const char *http_version;
   const char *user_agent;
+  struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
 };
 
 struct http_proxy_options_simple {
-- 
1.7.9.5


