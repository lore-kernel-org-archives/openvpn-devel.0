Message-Id: <200810271301.m9RD1BKT006709@...1141...>
From: "Frank Behrens" <frank@...1140...>
Date: Mon, 27 Oct 2008 14:01:11 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [patch] enhance compatibility with HTTP/1.1 proxies
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
To: openvpn-devel@lists.sourceforge.net

May I propose the following patch to enhance openvpn's compatibility 
with HTTP/1.1 proxies?
See
http://tools.ietf.org/html/rfc2616#section-14.23
and
http://tools.ietf.org/html/rfc2817#section-5.2

--- proxy.c.orig	2008-10-06 09:22:20.000000000 +0200
+++ proxy.c	2008-10-27 13:30:48.000000000 +0100
@@ -348,6 +348,12 @@
   if (!send_line_crlf (sd, buf))
     goto error;
 
+  /* send Host: header */
+  openvpn_snprintf (buf, sizeof(buf), "Host: %s:%d",
+		    host, port);
+  if (!send_line_crlf (sd, buf))
+    goto error;
+
   /* send User-Agent string if provided */
   if (p->options.user_agent)
     {


Regards,
   Frank

-- 
Frank Behrens, Osterwieck, Germany
PGP-key 0x5B7C47ED on public servers available.


