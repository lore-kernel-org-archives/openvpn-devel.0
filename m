From: Arne Schwabe <arne@...1227...>
Date: Mon, 16 Sep 2013 12:51:28 +0200
Message-Id: <1379328688-2282-1-git-send-email-arne@...1227...>
In-Reply-To: <1378634344-27822-1-git-send-email-arne@...1227...>
References: <1378634344-27822-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v2] Implement custom HTTP header for
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
---
 doc/openvpn.8         |    7 ++++
 src/openvpn/options.c |   29 +++++++++++++++
 src/openvpn/proxy.c   |   97 ++++++++++++++++++++++++++++++++++++++-----------
 src/openvpn/proxy.h   |    7 ++++
 4 files changed, 119 insertions(+), 21 deletions(-)

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
index 4d0271f..1ad06f3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5061,6 +5061,35 @@ add_option (struct options *options,
 	{
 	  ho->user_agent = p[2];
 	}
+      else if ((streq (p[1], "EXT1") || streq(p[1], "EXT2") || streq(p[1], "CUSTOM-HEADER"))
+	       && p[2])
+	{
+	  /* In the wild patched versions use both EXT1/2 and CUSTOM-HEADER with either two
+	   * argument or one */
+	  struct http_custom_header *custom_header =NULL;
+	  int i;
+	  
+	  
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
+	  
+	}
       else
 	{
 	  msg (msglevel, "Bad http-proxy-option or missing parameter: '%s'", p[1]);
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 04ed421..eab00fe 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -489,6 +489,75 @@ http_proxy_close (struct http_proxy_info *hp)
 }
 
 bool
+add_proxy_header (struct http_proxy_info *p,
+		  socket_descriptor_t sd, /* already open to proxy */
+		  const char *host,	  /* openvpn server remote */
+		  const char *port	  /* openvpn server port */
+		  )
+{
+  char buf[512];
+  int i;
+  bool hostheadercustom=false;
+  
+  /* Check if any of the custom headers already provides Host: */
+  i=0;
+  while (p->options.custom_headers[i].name)
+    {
+      if(
+	 ((!strcasecmp(p->options.custom_headers[i].name, "Host")) && 
+	  (p->options.custom_headers[i].content))
+	 ||
+	 ((!strncasecmp(p->options.custom_headers[i].name, "Host:", 5)) && 
+	  p->options.custom_headers[i].content == NULL)
+	 )
+	hostheadercustom=true;
+      i++;
+    }
+
+  if (!hostheadercustom) 
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
+  /* 
+   * Send custom headers if provided
+   * If content is NULL whole header is in name
+   */
+  i=0;
+  while (p->options.custom_headers[i].name)
+    {
+      if (p->options.custom_headers[i].content)
+	openvpn_snprintf (buf, sizeof(buf), "%s: %s",
+			  p->options.custom_headers[i].name,
+			  p->options.custom_headers[i].content);
+      else
+	openvpn_snprintf (buf, sizeof(buf), "%s",
+			  p->options.custom_headers[i].name);
+
+      msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
+      if (!send_line_crlf (sd, buf))
+	return false;
+      i++;
+    }
+
+  return true;
+}
+
+
+bool
 establish_http_proxy_passthru (struct http_proxy_info *p,
 			       socket_descriptor_t sd, /* already open to proxy */
 			       const char *host,       /* openvpn server remote */
@@ -530,20 +599,10 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
       /* send HTTP CONNECT message to proxy */
       if (!send_line_crlf (sd, buf))
 	goto error;
-
-      openvpn_snprintf(buf, sizeof(buf), "Host: %s", host);
-      if (!send_line_crlf(sd, buf))
+      
+      if(!add_proxy_header (p, sd, host, port))
         goto error;
 
-      /* send User-Agent string if provided */
-      if (p->options.user_agent)
-	{
-	  openvpn_snprintf (buf, sizeof(buf), "User-Agent: %s",
-			    p->options.user_agent);
-	  if (!send_line_crlf (sd, buf))
-	    goto error;
-	}
-
       /* auth specified? */
       switch (p->auth_method)
 	{
@@ -659,12 +718,10 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 
           
           /* send HOST etc, */
-          openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
-          msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
-          if (!send_line_crlf (sd, buf))
-            goto error;
+	  if(!add_proxy_header (p, sd, host, port))
+	    goto error;
 
-          msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 3");
+	  msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 3");
 	  {
 	    const char *np3 = ntlm_phase_3 (p, buf2, &gc);
 	    if (!np3)
@@ -770,10 +827,8 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 		goto error;
 
 	      /* send HOST etc, */
-	      openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
-	      msg (D_PROXY, "Send to HTTP proxy: '%s'", buf);
-	      if (!send_line_crlf (sd, buf))
-		goto error;
+              if(!add_proxy_header (p, sd, host, port))
+                goto error;
 
 	      /* send digest response */
 	      openvpn_snprintf (buf, sizeof(buf), "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
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


