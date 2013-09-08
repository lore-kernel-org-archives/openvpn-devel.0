From: Arne Schwabe <arne@...1227...>
Date: Sun,  8 Sep 2013 11:59:04 +0200
Message-Id: <1378634344-27822-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Implement custom HTTP header for http-proxy
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
 doc/openvpn.8         |    7 +++++++
 src/openvpn/options.c |   29 +++++++++++++++++++++++++++++
 src/openvpn/proxy.c   |   16 ++++++++++++++++
 src/openvpn/proxy.h   |    7 +++++++
 4 files changed, 59 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 573d6a8..72a85a9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -551,6 +551,13 @@ Set HTTP version number to
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
index e551c30..01960f2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4979,6 +4979,35 @@ add_option (struct options *options,
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
index 533e747..a2721cd 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -519,6 +519,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
     }
   else
     {
+      int i=0;
       /* format HTTP CONNECT message */
       openvpn_snprintf (buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
 			host,
@@ -543,6 +544,21 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	  if (!send_line_crlf (sd, buf))
 	    goto error;
 	}
+      /* Send custom headers if provided */
+      while (p->options.custom_headers[i].name)
+	{
+	  if (p->options.custom_headers[i].content)
+	    openvpn_snprintf (buf, sizeof(buf), "%s: %s",
+			      p->options.custom_headers[i].name,
+			      p->options.custom_headers[i].content);
+	  else
+	    openvpn_snprintf (buf, sizeof(buf), "%s",
+			      p->options.custom_headers[i].name);
+	 
+	  if (!send_line_crlf (sd, buf))
+	    goto error;
+	  i++;
+	}
 
       /* auth specified? */
       switch (p->auth_method)
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 9d75e06..0e7a6df 100644
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
   const char *port;
@@ -53,6 +59,7 @@ struct http_proxy_options {
   const char *auth_file;
   const char *http_version;
   const char *user_agent;
+  struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
 };
 
 struct http_proxy_options_simple {
-- 
1.7.9.5


