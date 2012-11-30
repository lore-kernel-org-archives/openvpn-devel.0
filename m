From: Arne Schwabe <arne@...1227...>
Date: Fri, 30 Nov 2012 20:17:54 +0100
Message-Id: <1354303076-13606-8-git-send-email-arne@...1227...>
In-Reply-To: <1354303076-13606-1-git-send-email-arne@...1227...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 08/10] Fix print_sockaddr part 2
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
 src/openvpn/ps.c     |    4 +--
 src/openvpn/socket.c |   66 ++++++++++++++++++++++++--------------------------
 src/openvpn/socket.h |   16 ++++++++++--
 3 files changed, 47 insertions(+), 39 deletions(-)

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
index 73b3dc5..b4d7ea7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1562,7 +1562,7 @@ linksock_print_addr (struct link_socket *sock)
       msg (msglevel, "%s link local%s: %s",
            proto2ascii (sock->info.proto, sock->info.af, true),
            (sock->bind_local ? " (bound)" : ""),
-           print_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
+           print_sockaddr_ex (&sock->info.lsa->local.addr.sa, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
     
     /* print active remote address */
     msg (msglevel, "%s link remote: %s",
@@ -1866,17 +1866,14 @@ setenv_trusted (struct env_set *es, const struct link_socket_info *info)
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
@@ -2195,57 +2192,56 @@ socket_listen_event_handle (struct link_socket *s)
  */
 
 const char *
-print_sockaddr (const struct openvpn_sockaddr *addr, struct gc_arena *gc)
-{
-  return print_sockaddr_ex (addr, ":", PS_SHOW_PORT, gc);
-}
-
-const char *
-print_sockaddr_ex (const struct openvpn_sockaddr *addr,
+print_sockaddr_ex (const struct sockaddr *sa,
 				   const char* separator,
 				   const unsigned int flags,
 				   struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (128, gc);
   bool addr_is_defined;
-  char buf[NI_MAXHOST] = "";
-
-  addr_is_defined = addr_defined (addr);
-  if (!addr_is_defined) {
-    return "[undef]";
-  }
+  char hostaddr[NI_MAXHOST] = "";
+  char servname[NI_MAXSERV] = "";
+  int status;
 
-  int port;
-  int salen;
-  switch(addr->addr.sa.sa_family)
+  socklen_t salen;
+  switch(sa->sa_family)
     {
     case AF_INET:
-      port= ntohs (addr->addr.in4.sin_port);
       buf_puts (&out, "[AF_INET]");
       salen = sizeof (struct sockaddr_in);
+      addr_is_defined = ((struct sockaddr_in*) sa)->sin_addr.s_addr != 0;
       break;
     case AF_INET6:
-      port= ntohs (addr->addr.in6.sin6_port);
       buf_puts (&out, "[AF_INET6]");
       salen = sizeof (struct sockaddr_in6);
+      addr_is_defined = IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
       break;
     default:
       ASSERT(0);
     }
 	
+  status = getnameinfo(sa, salen, hostaddr, sizeof (hostaddr),
+              servname, sizeof(servname), NI_NUMERICHOST | NI_NUMERICSERV);
+
+  if(status!=0) {
+      buf_printf(&out,"[nameinfo() err: %s]",gai_strerror(status));
+      return BSTR(&out);
+  }
+
   if (!(flags & PS_DONT_SHOW_ADDR))
     {
-      getnameinfo(&addr->addr.sa, salen,
-                  buf, sizeof (buf), NULL, 0, NI_NUMERICHOST);
-      buf_puts (&out, buf);
+      if (addr_is_defined)
+        buf_puts (&out, hostaddr);
+      else
+        buf_puts (&out, "[undef]");
     }
-  if (((flags & PS_SHOW_PORT) || (addr_is_defined && (flags & PS_SHOW_PORT_IF_DEFINED)))
-      && port)
+
+  if ((flags & PS_SHOW_PORT) || (flags & PS_SHOW_PORT_IF_DEFINED))
     {
       if (separator)
         buf_puts (&out, separator);
 		
-      buf_printf (&out, "%d", port);
+      buf_puts (&out, servname);
     }
 	
   return BSTR (&out);
@@ -2271,7 +2267,7 @@ print_link_socket_actual_ex (const struct link_socket_actual *act,
     {
       char ifname[IF_NAMESIZE] = "[undef]";
       struct buffer out = alloc_buf_gc (128, gc);
-      buf_printf (&out, "%s", print_sockaddr_ex (&act->dest, separator, flags, gc));
+      buf_printf (&out, "%s", print_sockaddr_ex (&act->dest.addr.sa, separator, flags, gc));
 #if ENABLE_IP_PKTINFO
       if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
 	{
@@ -2292,7 +2288,7 @@ print_link_socket_actual_ex (const struct link_socket_actual *act,
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
 		  buf_printf (&out, " (via %s%%%s)",
-			      print_sockaddr_ex (&sa, separator, 0, gc),
+			      print_sockaddr_ex (&sa.addr.sa, separator, 0, gc),
 			      ifname);
 		}
 	      break;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 85307a7..d341c0a 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -345,14 +345,26 @@ void sd_close (socket_descriptor_t *sd);
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


