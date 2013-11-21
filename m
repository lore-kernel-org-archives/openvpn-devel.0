From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:10 +0100
Message-Id: <1385064495-25877-9-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 09/14] change the type of remote to addrinfo.
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
 src/openvpn/init.c   |    5 +--
 src/openvpn/socket.c |   59 ++++++++++++++++++++++-------------
 src/openvpn/socket.h |   85 +++++++++++++++++++++++++++++++++++++++++++-------
 src/openvpn/tun.c    |   16 ++++++----
 src/openvpn/tun.h    |    2 +-
 5 files changed, 124 insertions(+), 43 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2076aad..7a376ab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1356,7 +1356,7 @@ do_init_tun (struct context *c)
 			   c->options.ifconfig_ipv6_netbits,
 			   c->options.ifconfig_ipv6_remote,
 			   addr_host (&c->c1.link_socket_addr.local),
-			   addr_host (&c->c1.link_socket_addr.remote),
+			   addr_host (&c->c1.link_socket_addr.remote_list),
 			   !c->options.ifconfig_nowarn,
 			   c->c2.es);
 
@@ -2867,7 +2867,8 @@ do_close_link_socket (struct context *c)
 
   if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_remote_ip))
     {
-      CLEAR (c->c1.link_socket_addr.remote);
+      if (c->c1.link_socket_addr.remote_list)
+        freeaddrinfo(c->c1.link_socket_addr.remote_list);
       CLEAR (c->c1.link_socket_addr.actual);
     }
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 1286295..82482d5 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1207,22 +1207,8 @@ resolve_remote (struct link_socket *sock,
   if (!sock->did_resolve_remote)
     {
       /* resolve remote address if undefined */
-      if (!addr_defined (&sock->info.lsa->remote))
+      if (!sock->info.lsa->remote_list)
 	{
-          af = addr_guess_family(sock->info.af, sock->remote_host);
-          switch(af)
-            {
-              case AF_INET:
-                sock->info.lsa->remote.addr.in4.sin_family = AF_INET;
-                sock->info.lsa->remote.addr.in4.sin_addr.s_addr = 0;
-                break;
-              case AF_INET6:
-                CLEAR(sock->info.lsa->remote.addr.in6);
-                sock->info.lsa->remote.addr.in6.sin6_family = AF_INET6;
-                sock->info.lsa->remote.addr.in6.sin6_addr = in6addr_any;
-                break;
-            }
-
 	  if (sock->remote_host)
 	    {
 	      unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
@@ -1269,8 +1255,7 @@ resolve_remote (struct link_socket *sock,
 		  status = openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_port,
                                                retry, signal_received, af, &ai);
 		  if(status == 0) {
-			  sock->info.lsa->remote.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
-			  freeaddrinfo(ai);
+                          sock->info.lsa->remote_list = ai;
 
 			  dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
 					flags,
@@ -1304,7 +1289,17 @@ resolve_remote (struct link_socket *sock,
       else
 	{
 	  CLEAR (sock->info.lsa->actual);
-	  sock->info.lsa->actual.dest = sock->info.lsa->remote;
+	  /* TODO(schwabe) will only use first address als dest address */
+      if(sock->info.lsa->remote_list) {
+          if (sock->info.lsa->remote_list->ai_family == AF_INET)
+              sock->info.lsa->actual.dest.addr.in4 =
+              *((struct sockaddr_in*) sock->info.lsa->remote_list->ai_addr);
+          else if (sock->info.lsa->remote_list->ai_family == AF_INET6)
+              sock->info.lsa->actual.dest.addr.in6 =
+              *((struct sockaddr_in6*) sock->info.lsa->remote_list->ai_addr);
+          else
+              ASSERT(0);
+      }
 	}
 
       /* remember that we finished */
@@ -1723,8 +1718,14 @@ phase2_socks_client (struct link_socket *sock, bool *remote_changed,
     sock->did_resolve_remote = false;
 
     addr_zero_host(&sock->info.lsa->actual.dest);
+<<<<<<< HEAD
     addr_zero_host(&sock->info.lsa->remote);
 
+=======
+    if (sock->info.lsa->remote_list)
+        freeaddrinfo(sock->info.lsa->remote_list);
+    
+>>>>>>> 966ca53... change the type of remote to addrinfo.
     resolve_remote (sock, 1, NULL, signal_received);
 }
 #endif
@@ -1795,10 +1796,19 @@ link_socket_init_phase2 (struct link_socket *sock,
 	goto done;
 
       if (remote_changed)
+<<<<<<< HEAD
 	{
 	  msg (M_INFO, "TCP/UDP: Dynamic remote address changed during TCP connection establishment");
 	  addr_copy_host(&sock->info.lsa->remote, &sock->info.lsa->actual.dest);
 	}
+=======
+        {
+          msg (M_INFO, "TCP/UDP: Dynamic remote address changed during TCP connection establishment");
+          /* TODO(schwabe) handle multiple addresses */
+          ASSERT(0);
+          addr_copy_host(&sock->info.lsa->remote_list->ai_addr, &sock->info.lsa->actual.dest);
+        }
+>>>>>>> 966ca53... change the type of remote to addrinfo.
     }
 
   phase2_set_socket_flags(sock);
@@ -1941,6 +1951,10 @@ link_socket_bad_incoming_addr (struct buffer *buf,
 			       const struct link_socket_actual *from_addr)
 {
   struct gc_arena gc = gc_new ();
+  struct openvpn_sockaddr firstremoteaddr;
+
+  /* TODO(schwabe) Fix this and print all remote addresses */
+  firstremoteaddr.addr.in6 = *(struct sockaddr_in6*)info->lsa->remote_list->ai_addr;
 
   switch(from_addr->dest.addr.sa.sa_family)
     {
@@ -1950,7 +1964,7 @@ link_socket_bad_incoming_addr (struct buffer *buf,
 	   "TCP/UDP: Incoming packet rejected from %s[%d], expected peer address: %s (allow this incoming source address/port by removing --remote or adding --float)",
 	   print_link_socket_actual (from_addr, &gc),
 	   (int)from_addr->dest.addr.sa.sa_family,
-	   print_sockaddr (&info->lsa->remote, &gc));
+	   print_sockaddr (&firstremoteaddr, &gc));
       break;
     }
   buf->len = 0;
@@ -1976,13 +1990,14 @@ link_socket_current_remote (const struct link_socket_info *info)
  * by now just ignore it
  *
  */
+/* TODO(schwabe) what to do for a remote with multiple IPs? */
   if (lsa->actual.dest.addr.sa.sa_family != AF_INET)
     return IPV4_INVALID_ADDR;
 
   if (link_socket_actual_defined (&lsa->actual))
     return ntohl (lsa->actual.dest.addr.in4.sin_addr.s_addr);
-  else if (addr_defined (&lsa->remote))
-    return ntohl (lsa->remote.addr.in4.sin_addr.s_addr);
+  else if (lsa->remote_list)
+    return ntohl (((struct sockaddr_in*)lsa->remote_list->ai_addr)->sin_addr.s_addr);
   else
     return 0;
 }
@@ -2817,7 +2832,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
   iov.iov_len = BLEN (buf);
   mesg.msg_iov = &iov;
   mesg.msg_iovlen = 1;
-  switch (sock->info.lsa->remote.addr.sa.sa_family)
+  switch (sock->info.lsa->remote_list->ai_family)
     {
     case AF_INET:
       {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 4b944b0..e40ca6d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -98,7 +98,7 @@ struct link_socket_actual
 struct link_socket_addr
 {
   struct openvpn_sockaddr local;
-  struct openvpn_sockaddr remote;   /* initial remote */
+  struct addrinfo* remote_list;   /* initial remote */
   struct link_socket_actual actual; /* reply to this address */
 };
 
@@ -610,13 +610,35 @@ link_socket_actual_defined (const struct link_socket_actual *act)
 static inline bool
 addr_match (const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
 {
-  switch(a1->addr.sa.sa_family) {
+    switch(a1->addr.sa.sa_family) {
+        case AF_INET:
+            return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr;
+        case AF_INET6:
+            return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin6_addr);
+    }
+    ASSERT(0);
+    return false;
+}
+
+static inline bool
+addrlist_match (const struct openvpn_sockaddr *a1, const struct addrinfo *addrlist)
+{
+  const struct addrinfo *curele;
+  for (curele = addrlist; curele; curele=curele->ai_next) {
+
+    switch(a1->addr.sa.sa_family) {
     case AF_INET:
-      return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr;
+      if (a1->addr.in4.sin_addr.s_addr == ((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr)
+        return true;
+      break;
     case AF_INET6:
-      return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin6_addr);
+      if (IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &((struct sockaddr_in6*) curele->ai_addr)->sin6_addr))
+        return true;
+      break;
+    default:
+      ASSERT(0);
+    }
   }
-  ASSERT(0);
   return false;
 }
 
@@ -633,6 +655,34 @@ addr_host (const struct openvpn_sockaddr *addr)
   return ntohl (addr->addr.in4.sin_addr.s_addr);
 }
 
+
+static inline bool
+addrlist_port_match (const struct openvpn_sockaddr *a1, const struct addrinfo *a2)
+{
+    const struct addrinfo *curele;
+    for(curele=a2;curele;curele = curele->ai_next) {
+        switch(a1->addr.sa.sa_family) {
+            case AF_INET:
+            if (curele->ai_family == AF_INET
+                && a1->addr.in4.sin_addr.s_addr == ((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr
+                && a1->addr.in4.sin_port == ((struct sockaddr_in*)curele->ai_addr)->sin_port)
+                return true;
+                break;
+            case AF_INET6:
+                if (curele->ai_family == AF_INET6
+                && IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &((struct sockaddr_in6*) curele->ai_addr)->sin6_addr)
+                && a1->addr.in6.sin6_port == ((struct sockaddr_in6*) curele->ai_addr)->sin6_port)
+                    return true;
+                break;
+            default:
+                ASSERT(0);
+        }
+    }
+    return false;
+}
+
+
+
 static inline bool
 addr_port_match (const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
 {
@@ -650,14 +700,25 @@ addr_port_match (const struct openvpn_sockaddr *a1, const struct openvpn_sockadd
 
 static inline bool
 addr_match_proto (const struct openvpn_sockaddr *a1,
-		  const struct openvpn_sockaddr *a2,
-		  const int proto)
+                      const struct openvpn_sockaddr *a2,
+                      const int proto)
 {
-  return link_socket_proto_connection_oriented (proto)
+    return link_socket_proto_connection_oriented (proto)
     ? addr_match (a1, a2)
     : addr_port_match (a1, a2);
 }
 
+
+static inline bool
+addrlist_match_proto (const struct openvpn_sockaddr *a1,
+		  struct addrinfo *addr_list,
+		  const int proto)
+{
+  return link_socket_proto_connection_oriented (proto)
+    ? addrlist_match (a1, addr_list)
+    : addrlist_port_match (a1, addr_list);
+}
+
 static inline void
 addr_zero_host(struct openvpn_sockaddr *addr)
 {
@@ -774,9 +835,9 @@ link_socket_verify_incoming_addr (struct buffer *buf,
 	case AF_INET:
 	  if (!link_socket_actual_defined (from_addr))
 	    return false;
-	  if (info->remote_float || !addr_defined (&info->lsa->remote))
+	  if (info->remote_float || !info->lsa->remote_list)
 	    return true;
-	  if (addr_match_proto (&from_addr->dest, &info->lsa->remote, info->proto))
+	  if (addrlist_match_proto (&from_addr->dest, info->lsa->remote_list, info->proto))
 	    return true;
       }
     }
@@ -818,8 +879,8 @@ link_socket_set_outgoing_addr (const struct buffer *buf,
 	   || !addr_match_proto (&act->dest, &lsa->actual.dest, info->proto))
 	  /* address undef or address == remote or --float */
 	  && (info->remote_float
-	      || !addr_defined (&lsa->remote)
-	      || addr_match_proto (&act->dest, &lsa->remote, info->proto))
+	      || !lsa->remote_list)
+	      || addrlist_match_proto (&act->dest, lsa->remote_list, info->proto)
 	  )
 	{
 	  link_socket_connection_initiated (buf, info, act, common_name, es);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9f53b23..0f30e2f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -412,7 +412,7 @@ init_tun (const char *dev,       /* --dev option */
 	  int         ifconfig_ipv6_netbits_parm,
 	  const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
 	  in_addr_t local_public,
-	  in_addr_t remote_public,
+	  struct addrinfo *remote_public,
 	  const bool strict_warn,
 	  struct env_set *es)
 {
@@ -466,6 +466,7 @@ init_tun (const char *dev,       /* --dev option */
        */
       if (strict_warn)
 	{
+	  struct addrinfo *curele;
 	  ifconfig_sanity_check (tt->type == DEV_TYPE_TUN, tt->remote_netmask, tt->topology);
 
 	  /*
@@ -479,11 +480,14 @@ init_tun (const char *dev,       /* --dev option */
 			    tt->local,
 			    tt->remote_netmask);
 
-	  check_addr_clash ("remote",
-			    tt->type,
-			    remote_public,
-			    tt->local,
-			    tt->remote_netmask);
+	  for (curele=remote_public;curele;curele=curele->ai_next) {
+	    if (curele->ai_family == AF_INET)
+	      check_addr_clash ("remote",
+				tt->type,
+				((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr,
+				tt->local,
+				tt->remote_netmask);
+         }
 
 	  if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
 	    check_subnet_conflict (tt->local, tt->remote_netmask, "TUN/TAP adapter");
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 2c97ffe..ea2290c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -233,7 +233,7 @@ struct tuntap *init_tun (const char *dev,       /* --dev option */
 			 int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits */
 			 const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
 			 in_addr_t local_public,
-			 in_addr_t remote_public,
+			 struct addrinfo *remote_public,
 			 const bool strict_warn,
 			 struct env_set *es);
 
-- 
1.7.9.5


