Message-Id: <200811121224.mACCOmfd077621@...1141...>
From: "Frank Behrens" <frank@...1140...>
Date: Wed, 12 Nov 2008 13:24:48 +0100
MIME-Version: 1.0
In-reply-to: <49109F75.8000804@...41...>
References: <200810271301.m9RD1BKT006709@...1141...>
Subject: Re: [Openvpn-devel] [patch] enhance compatibility with HTTP/1.1
	proxies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-description: Mail message body
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan <jim@...41...> wrote on 4 Nov 2008 12:16:
> Shouldn't you check p->options.http_version and make sure it's >= 1.1 
> before sending the Host header?

Here is a revised patch, that works for me and implements your 
suggestion:

--- proxy.c.orig	2008-10-06 09:22:20.000000000 +0200
+++ proxy.c	2008-11-06 20:49:55.000000000 +0100
@@ -348,6 +348,14 @@ establish_http_proxy_passthru (struct ht
   if (!send_line_crlf (sd, buf))
     goto error;
 
+  /* send Host: header for HTTP version above 1.0 */
+  if (strcmp(p->options.http_version, "1.0") != 0) {
+    openvpn_snprintf (buf, sizeof(buf), "Host: %s:%d",
+		      host, port);
+    if (!send_line_crlf (sd, buf))
+      goto error;
+  }
+
   /* send User-Agent string if provided */
   if (p->options.user_agent)
     {



