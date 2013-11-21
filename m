From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:03 +0100
Message-Id: <1385064495-25877-2-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 02/14] Simplify print_sockaddr_ex function,
	merge duplicate ipv4/ipv6 logic.
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
 src/openvpn/ps.c     |    4 +-
 src/openvpn/socket.c |  110 ++++++++++++++++++++++----------------------------
 src/openvpn/socket.h |   16 +++++++-
 3 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 44eda89..98d6580 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -330,8 +330,8 @@ journal_add (const char *journal_dir, struct proxy_connection *pc, struct proxy_
   if (!getpeername (pc->sd, (struct sockaddr *) &from.addr.sa, &slen)
       && !getsockname (cp->sd, (struct sockaddr *) &to.addr.sa, &dlen))
     {
-      const char *f = print_sockaddr_ex (&from, ":", PS_SHOW_PORT, &gc);
-      const char *t = print_sockaddr_ex (&to, ":", PS_SHOW_PORT, &gc);
+      const char *f = print_sockaddr (&from, &gc);
+      const char *t = print_sockaddr (&to, &gc);
       fnlen =  strlen(journal_dir) + strlen(t) + 2;
       jfn = (char *) malloc(fnlen);
       check_malloc_return (jfn);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 33ef3f4..5f59168 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1746,7 +1746,7 @@ link_socket_init_phase2 (struct link_socket *sock,
       msg (msglevel, "%s link local%s: %s",
 	   proto2ascii (sock->info.proto, true),
 	   (sock->bind_local ? " (bound)" : ""),
-	   print_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
+	   print_openvpn_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
 
     /* print active remote address */
     msg (msglevel, "%s link remote: %s",
@@ -1831,17 +1831,14 @@ setenv_trusted (struct env_set *es, const struct link_socket_info *info)
 static void
 ipchange_fmt (const bool include_cmd, struct argv *argv, const struct link_socket_info *info, struct gc_arena *gc)
 {
-  const char *ip = print_sockaddr_ex (&info->lsa->actual.dest, NULL, 0, gc);
-  const char *port = print_sockaddr_ex (&info->lsa->actual.dest, NULL, PS_DONT_SHOW_ADDR|PS_SHOW_PORT, gc);
+  const char *host = print_sockaddr_ex (&info->lsa->actual.dest.addr.sa, " ", PS_SHOW_PORT , gc);
   if (include_cmd)
-    argv_printf (argv, "%sc %s %s",
+    argv_printf (argv, "%sc %s",
 		 info->ipchange_command,
-		 ip,
-		 port);
+		 host);
   else
-    argv_printf (argv, "%s %s",
-		 ip,
-		 port);
+    argv_printf (argv, "%s", host);
+
 }
 
 void
@@ -2155,67 +2152,58 @@ socket_listen_event_handle (struct link_socket *s)
  */
 
 const char *
-print_sockaddr (const struct openvpn_sockaddr *addr, struct gc_arena *gc)
-{
-  return print_sockaddr_ex (addr, ":", PS_SHOW_PORT, gc);
-}
-
-const char *
-print_sockaddr_ex (const struct openvpn_sockaddr *addr,
-		   const char* separator,
-		   const unsigned int flags,
-		   struct gc_arena *gc)
+print_sockaddr_ex (const struct sockaddr *sa,
+				   const char* separator,
+				   const unsigned int flags,
+				   struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (128, gc);
   bool addr_is_defined;
-  addr_is_defined = addr_defined (addr);
-  if (!addr_is_defined) {
-    return "[undef]";
-  }
-  switch(addr->addr.sa.sa_family)
+  char hostaddr[NI_MAXHOST] = "";
+  char servname[NI_MAXSERV] = "";
+  int status;
+
+  socklen_t salen;
+  switch(sa->sa_family)
     {
     case AF_INET:
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
+      buf_puts (&out, "[AF_INET]");
+      salen = sizeof (struct sockaddr_in);
+      addr_is_defined = ((struct sockaddr_in*) sa)->sin_addr.s_addr != 0;
       break;
     case AF_INET6:
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
-	}
+      buf_puts (&out, "[AF_INET6]");
+      salen = sizeof (struct sockaddr_in6);
+      addr_is_defined = IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
       break;
     default:
       ASSERT(0);
     }
+	
+  status = getnameinfo(sa, salen, hostaddr, sizeof (hostaddr),
+              servname, sizeof(servname), NI_NUMERICHOST | NI_NUMERICSERV);
+
+  if(status!=0) {
+      buf_printf(&out,"[nameinfo() err: %s]",gai_strerror(status));
+      return BSTR(&out);
+  }
+
+  if (!(flags & PS_DONT_SHOW_ADDR))
+    {
+      if (addr_is_defined)
+        buf_puts (&out, hostaddr);
+      else
+        buf_puts (&out, "[undef]");
+    }
+
+  if ((flags & PS_SHOW_PORT) || (flags & PS_SHOW_PORT_IF_DEFINED))
+    {
+      if (separator)
+        buf_puts (&out, separator);
+		
+      buf_puts (&out, servname);
+    }
+	
   return BSTR (&out);
 }
 
@@ -2239,7 +2227,7 @@ print_link_socket_actual_ex (const struct link_socket_actual *act,
     {
       char ifname[IF_NAMESIZE] = "[undef]";
       struct buffer out = alloc_buf_gc (128, gc);
-      buf_printf (&out, "%s", print_sockaddr_ex (&act->dest, separator, flags, gc));
+      buf_printf (&out, "%s", print_sockaddr_ex (&act->dest.addr.sa, separator, flags, gc));
 #if ENABLE_IP_PKTINFO
       if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
 	{
@@ -2260,7 +2248,7 @@ print_link_socket_actual_ex (const struct link_socket_actual *act,
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
 		  buf_printf (&out, " (via %s%%%s)",
-			      print_sockaddr_ex (&sa, separator, 0, gc),
+			      print_sockaddr_ex (&sa.addr.sa, separator, 0, gc),
 			      ifname);
 		}
 	      break;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 549946e..1a8ec0f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -347,14 +347,26 @@ void sd_close (socket_descriptor_t *sd);
 #define PS_SHOW_PKTINFO         (1<<2)
 #define PS_DONT_SHOW_ADDR       (1<<3)
 
-const char *print_sockaddr_ex (const struct openvpn_sockaddr *addr,
+const char *print_sockaddr_ex (const struct sockaddr *addr,
 			       const char* separator,
 			       const unsigned int flags,
 			       struct gc_arena *gc);
 
+static inline
+const char *print_openvpn_sockaddr_ex (const struct openvpn_sockaddr *addr,
+			       const char* separator,
+			       const unsigned int flags,
+			       struct gc_arena *gc)
+{
+    return print_sockaddr_ex(&addr->addr.sa, separator, flags, gc);
+}
 
+static inline
 const char *print_sockaddr (const struct openvpn_sockaddr *addr,
-			    struct gc_arena *gc);
+			    struct gc_arena *gc)
+{
+    return print_sockaddr_ex (&addr->addr.sa, ":", PS_SHOW_PORT, gc);
+}
 
 const char *print_link_socket_actual_ex (const struct link_socket_actual *act,
 					 const char* separator,
-- 
1.7.9.5


