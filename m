From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Aug 2012 18:11:10 +0200
Message-Id: <1343837470-3923-5-git-send-email-arne@...1227...>
In-Reply-To: <1343837470-3923-1-git-send-email-arne@...1227...>
References: <1343837470-3923-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/4] Simplify print_sockaddr_ex function,
	merge duplicate ipv4/ipv6 logic
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

---
 src/openvpn/socket.c |   89 ++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index acc4f2b..8ab5872 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2173,57 +2173,46 @@ print_sockaddr_ex (const struct openvpn_sockaddr *addr,
 		   const unsigned int flags,
 		   struct gc_arena *gc)
 {
-  struct buffer out = alloc_buf_gc (128, gc);
-  bool addr_is_defined;
-  addr_is_defined = addr_defined (addr);
-  if (!addr_is_defined) {
-    return "[undef]";
-  }
-  switch(addr->addr.sa.sa_family)
-    {
-    case AF_INET:
-	{
-	  const int port= ntohs (addr->addr.in4.sin_port);
-	  buf_puts (&out, "[AF_INET]");
-
-	  if (!(flags & PS_DONT_SHOW_ADDR))
-	    buf_printf (&out, "%s", (addr_defined (addr) ? inet_ntoa (addr->addr.in4.sin_addr) : "[undef]"));
-
-	  if (((flags & PS_SHOW_PORT) || (addr_defined (addr) && (flags & PS_SHOW_PORT_IF_DEFINED)))
-	      && port)
-	    {
-	      if (separator)
-		buf_printf (&out, "%s", separator);
-
-	      buf_printf (&out, "%d", port);
-	    }
-	}
-      break;
-    case AF_INET6:
-	{
-	  const int port= ntohs (addr->addr.in6.sin6_port);
-	  char buf[INET6_ADDRSTRLEN] = "";
-	  buf_puts (&out, "[AF_INET6]");
-	  if (addr_is_defined)
-	    {
-	      getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
-			  buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);
-	      buf_puts (&out, buf);
-	    }
-	  if (((flags & PS_SHOW_PORT) || (addr_is_defined && (flags & PS_SHOW_PORT_IF_DEFINED)))
-	      && port)
-	    {
-	      if (separator)
-		buf_puts (&out, separator);
-
-	      buf_printf (&out, "%d", port);
-	    }
+	struct buffer out = alloc_buf_gc (128, gc);
+	bool addr_is_defined;
+	char buf[NI_MAXHOST] = "";
+	
+	addr_is_defined = addr_defined (addr);
+	if (!addr_is_defined) {
+		return "[undef]";
 	}
-      break;
-    default:
-      ASSERT(0);
-    }
-  return BSTR (&out);
+	
+	int port;
+	switch(addr->addr.sa.sa_family)
+  {
+	  case AF_INET:
+		port= ntohs (addr->addr.in4.sin_port);
+		buf_puts (&out, "[AF_INET]");
+		break;
+	  case AF_INET6:
+		port= ntohs (addr->addr.in6.sin6_port);
+		buf_puts (&out, "[AF_INET6]");
+		break;
+	  default:
+		ASSERT(0);
+  }
+	
+	if (!(flags & PS_DONT_SHOW_ADDR))
+	  {
+		getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
+					buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);
+		buf_puts (&out, buf);
+	  }
+	if (((flags & PS_SHOW_PORT) || (addr_is_defined && (flags & PS_SHOW_PORT_IF_DEFINED)))
+		&& port)
+	  {
+		if (separator)
+			buf_puts (&out, separator);
+		
+		buf_printf (&out, "%d", port);
+	  }
+	
+	return BSTR (&out);
 }
 
 const char *
-- 
1.7.9.6 (Apple Git-31.1)


