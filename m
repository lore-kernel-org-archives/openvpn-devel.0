From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:43 +0100
Message-Id: <1395407925-25518-11-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 10/12] Clean up of socket code.
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

Let socket_create take struct addrinfo as argument and use the entries of addrinfo to create the socket.
---
 src/openvpn/manage.c |   6 +-
 src/openvpn/socket.c | 187 +++++++++++++++++++++++++--------------------------
 src/openvpn/socket.h |   6 +-
 3 files changed, 95 insertions(+), 104 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0cc185b..f5b3ad5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1568,9 +1568,9 @@ man_listen (struct management *man)
       else
 #endif
 	{
-	  man->connection.sd_top = create_socket_tcp (man->settings.local->ai_family);
+	  man->connection.sd_top = create_socket_tcp (man->settings.local);
 	  socket_bind (man->connection.sd_top, man->settings.local,
-                       man->settings.local->ai_family, "MANAGEMENT", false);
+		       man->settings.local->ai_family, "MANAGEMENT", false);
 	}
 
       /*
@@ -1635,7 +1635,7 @@ man_connect (struct management *man)
   else
 #endif
     {
-      man->connection.sd_cli = create_socket_tcp (AF_INET);
+      man->connection.sd_cli = create_socket_tcp (man->settings.local);
       status = openvpn_connect (man->connection.sd_cli,
 				man->settings.local->ai_addr,
 				5,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 97f6756..f024c0a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -766,11 +766,15 @@ link_socket_update_buffer_sizes (struct link_socket *ls, int rcvbuf, int sndbuf)
  */
 
 socket_descriptor_t
-create_socket_tcp (int af)
+create_socket_tcp (struct addrinfo* addrinfo)
 {
   socket_descriptor_t sd;
 
-  if ((sd = socket (af, SOCK_STREAM, IPPROTO_TCP)) < 0)
+  ASSERT (addrinfo);
+  ASSERT (addrinfo->ai_socktype == SOCK_STREAM);
+  ASSERT (addrinfo->ai_protocol == IPPROTO_TCP);
+
+  if ((sd = socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol)) < 0)
     msg (M_ERR, "Cannot create TCP socket");
 
 #ifndef WIN32 /* using SO_REUSEADDR on Windows will cause bind to succeed on port conflicts! */
@@ -787,17 +791,21 @@ create_socket_tcp (int af)
 }
 
 static socket_descriptor_t
-create_socket_udp (const int af, const unsigned int flags)
+create_socket_udp (struct addrinfo* addrinfo, const unsigned int flags)
 {
   socket_descriptor_t sd;
 
-  if ((sd = socket (af, SOCK_DGRAM, IPPROTO_UDP)) < 0)
+  ASSERT (addrinfo);
+  ASSERT (addrinfo->ai_socktype == SOCK_DGRAM);
+  ASSERT (addrinfo->ai_protocol == IPPROTO_UDP);
+
+  if ((sd = socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol)) < 0)
     msg (M_ERR, "UDP: Cannot create UDP/UDP6 socket");
 #if ENABLE_IP_PKTINFO
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad = 1;
-      if(af == AF_INET)
+      if(addrinfo->ai_family == AF_INET)
         {
 #ifdef IP_PKTINFO
           if (setsockopt (sd, SOL_IP, IP_PKTINFO,
@@ -811,7 +819,7 @@ create_socket_udp (const int af, const unsigned int flags)
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
         }
-      else if (af == AF_INET6 )
+      else if (addrinfo->ai_family == AF_INET6 )
         {
 #ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms require this */
           if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
@@ -827,28 +835,48 @@ create_socket_udp (const int af, const unsigned int flags)
   return sd;
 }
 
-static void
-create_socket (struct link_socket *sock)
+static void bind_local (struct link_socket *sock, const sa_family_t ai_family)
 {
-  /* create socket, use information carried over from getaddrinfo */
-  const int ai_proto = sock->info.lsa->actual.ai_protocol;
-  int ai_family = sock->info.lsa->actual.ai_family;
-
-  ASSERT (sock->info.af == AF_UNSPEC  || sock->info.af == ai_family);
+    /* bind to local address/port */
+    if (sock->bind_local)
+      {
+#ifdef ENABLE_SOCKS
+        if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
+            socket_bind (sock->ctrl_sd, sock->info.lsa->bind_local,
+			 ai_family, "SOCKS", false);
+        else
+#endif
+            socket_bind (sock->sd, sock->info.lsa->bind_local,
+			 ai_family,
+                         "TCP/UDP", sock->info.bind_ipv6_only);
+      }
+}
 
-  if (ai_proto == IPPROTO_UDP)
+static void
+create_socket (struct link_socket* sock, struct addrinfo* addr)
+{
+  if (addr->ai_protocol == IPPROTO_UDP)
     {
-      sock->sd = create_socket_udp (ai_family, sock->sockflags);
+      sock->sd = create_socket_udp (addr, sock->sockflags);
       sock->sockflags |= SF_GETADDRINFO_DGRAM;
 
 #ifdef ENABLE_SOCKS
+      /* Assume that control socket and data socket to the socks proxy
+       * are using the same IP family */
       if (sock->socks_proxy)
-	sock->ctrl_sd = create_socket_tcp (ai_family);
+	{
+	  /* Construct a temporary addrinfo to create the socket,
+	   * currently resolve two remote addresses is not supported,
+	   * TODO: Rewrite the whole resolve_remote */
+	  struct addrinfo addrinfo_tmp = *addr;
+	  addr->ai_protocol = IPPROTO_TCP;
+	  sock->ctrl_sd = create_socket_tcp (&addrinfo_tmp);
+	}
 #endif
     }
-  else if (ai_proto == IPPROTO_TCP)
+  else if (addr->ai_protocol == IPPROTO_TCP)
     {
-      sock->sd = create_socket_tcp (ai_family);
+      sock->sd = create_socket_tcp (addr);
     }
   else
     {
@@ -859,6 +887,8 @@ create_socket (struct link_socket *sock)
 
     /* set socket to --mark packets with given value */
     socket_set_mark (sock->sd, sock->mark);
+
+    bind_local (sock, addr->ai_family);
 }
 
 #ifdef TARGET_ANDROID
@@ -1204,21 +1234,15 @@ void set_actual_address (struct link_socket_actual* actual, struct addrinfo* ai)
     else
         ASSERT(0);
 
-    /* Copy addrinfo sock parameters for socket creating */
-    actual->ai_family = ai->ai_family;
-    actual->ai_protocol = ai->ai_protocol;
-    actual->ai_socktype = ai->ai_socktype;
 }
 
 void
-socket_connect (socket_descriptor_t *sd,
-                struct link_socket_addr *lsa,
+socket_connect (socket_descriptor_t* sd,
+                const struct sockaddr* dest,
                 const int connect_timeout,
                 struct signal_info* sig_info)
 {
   struct gc_arena gc = gc_new ();
-  const struct sockaddr *dest = &lsa->actual.dest.addr.sa;
-
   int status;
 
 #ifdef CONNECT_NONBLOCK
@@ -1346,23 +1370,6 @@ resolve_bind_local (struct link_socket *sock, const sa_family_t af)
   gc_free (&gc);
 }
 
-static void bind_local (struct link_socket *sock)
-{
-    /* bind to local address/port */
-    if (sock->bind_local)
-      {
-#ifdef ENABLE_SOCKS
-        if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
-            socket_bind (sock->ctrl_sd, sock->info.lsa->bind_local,
-                         sock->info.lsa->actual.ai_family, "SOCKS", false);
-        else
-#endif
-            socket_bind (sock->sd, sock->info.lsa->bind_local,
-                         sock->info.lsa->actual.ai_family,
-                         "TCP/UDP", sock->info.bind_ipv6_only);
-      }
-}
-
 static void
 resolve_remote (struct link_socket *sock,
 		int phase,
@@ -1491,30 +1498,6 @@ link_socket_new (void)
 }
 
 void
-create_new_socket (struct link_socket* sock)
-{
-   if (sock->bind_local) {
-      resolve_bind_local (sock, sock->info.af);
-  }
-  resolve_remote (sock, 1, NULL, NULL);
-
-  /*
-   * In P2P or server mode we must create the socket even when resolving
-   * the remote site fails/is not specified. */
-
-  if (sock->info.lsa->actual.ai_family==0 && sock->bind_local)
-    {
-      /* Copy sock parameters from bind addr */
-      set_actual_address (&sock->info.lsa->actual, sock->info.lsa->bind_local);
-      /* clear destination set by set_actual_address */
-      CLEAR(sock->info.lsa->actual.dest);
-    }
-}
-
-
-
-/* bind socket if necessary */
-void
 link_socket_init_phase1 (struct link_socket *sock,
 			 const char *local_host,
 			 const char *local_port,
@@ -1655,7 +1638,10 @@ link_socket_init_phase1 (struct link_socket *sock,
     }
   else if (mode != LS_MODE_TCP_ACCEPT_FROM)
     {
-      create_new_socket (sock);
+      if (sock->bind_local) {
+	  resolve_bind_local (sock, sock->info.af);
+      }
+      resolve_remote (sock, 1, NULL, NULL);
     }
 }
 
@@ -1739,11 +1725,14 @@ linksock_print_addr (struct link_socket *sock)
     msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, sock->info.af, true));
   else if (sock->bind_local)
     {
-      /* Socket is always bound on the first matching address */
+      sa_family_t ai_family = sock->info.lsa->actual.dest.addr.sa.sa_family;
+      /* Socket is always bound on the first matching address,
+       * For bound sockets with no remote addr this is the element of
+       * the list */
       struct addrinfo *cur;
       for (cur = sock->info.lsa->bind_local; cur; cur=cur->ai_next)
 	{
-	  if(cur->ai_family == sock->info.lsa->actual.ai_family)
+	  if(!ai_family || ai_family == cur->ai_family)
 	    break;
 	}
       ASSERT (cur);
@@ -1812,8 +1801,9 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
   const bool proxy_retry = false;
 #endif
   do {
+    ASSERT (sock->info.lsa->current_remote->ai_protocol == IPPROTO_TCP);
     socket_connect (&sock->sd,
-                   sock->info.lsa,
+                   sock->info.lsa->current_remote->ai_addr,
                    sock->connect_timeout,
                    sig_info);
 
@@ -1845,10 +1835,8 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 #endif
     if (proxy_retry)
       {
-	/* TODO (schwabe): This code assumes AF_INET for the proxy socket
-         * when retrying a connection */
 	openvpn_close_socket (sock->sd);
-	sock->sd = create_socket_tcp (AF_INET);
+	sock->sd = create_socket_tcp (sock->info.lsa->current_remote);
       }
 
   } while (proxy_retry);
@@ -1860,7 +1848,7 @@ static void
 phase2_socks_client (struct link_socket *sock, struct signal_info *sig_info)
 {
     socket_connect (&sock->ctrl_sd,
-		    sock->info.lsa,
+		    sock->info.lsa->current_remote->ai_addr,
 		    sock->connect_timeout,
 		    sig_info);
 
@@ -1932,33 +1920,34 @@ link_socket_init_phase2 (struct link_socket *sock,
       /* Second chance to resolv/create socket */
       resolve_remote (sock, 2, &remote_dynamic,  &sig_info->signal_received);
 
+      /* If a valid remote has been found, create the socket with its addrinfo */
+      if (sock->info.lsa->current_remote)
+	  create_socket (sock, sock->info.lsa->current_remote);
+
       /* If socket has not already been created create it now */
       if (sock->sd == SOCKET_UNDEFINED)
 	{
-          /* If we have no --remote and have still not figured out the
-           * protocol family to use we will use the first of the bind */
-          if (sock->bind_local && sock->info.lsa->bind_local
-              && !sock->info.lsa->actual.ai_family && !sock->remote_host)
-          {
-            msg (M_WARN, "Could not determine IPv4/IPv6 protocol. Using %s",
-                 addr_family_name(sock->info.lsa->bind_local->ai_family));
-            set_actual_address(&sock->info.lsa->actual, sock->info.lsa->bind_local);
-
-          }
+	  /* If we have no --remote and have still not figured out the
+	   * protocol family to use we will use the first of the bind */
 
-	  if (sock->info.lsa->actual.ai_family)
-	    {
-	      create_socket (sock);
-	    }
-	  else
+	  if (sock->bind_local  && !sock->remote_host && sock->info.lsa->bind_local)
 	    {
-	      msg (M_WARN, "Could not determine IPv4/IPv6 protocol");
-	      sig_info->signal_received = SIGUSR1;
-	      goto done;
+	      /* Warn if this is because neither v4 or v6 was specified
+	       * and we should not connect a remote */
+	      if (sock->info.af == AF_UNSPEC)
+		msg (M_WARN, "Could not determine IPv4/IPv6 protocol. Using %s",
+		     addr_family_name(sock->info.lsa->bind_local->ai_family));
+
+	      create_socket (sock, sock->info.lsa->bind_local);
 	    }
+	}
 
-	  if (sock->bind_local)
-	    bind_local(sock);
+      /* Socket still undefined, give a warning and abort connection */
+      if (sock->sd == SOCKET_UNDEFINED)
+	{
+	  msg (M_WARN, "Could not determine IPv4/IPv6 protocol");
+	  sig_info->signal_received = SIGUSR1;
+	  goto done;
 	}
 
       if (sig_info && sig_info->signal_received)
@@ -2798,6 +2787,7 @@ proto_remote (int proto, bool remote)
 	return "TCPv4_CLIENT";
 
   ASSERT (0);
+  return ""; /* Make the compiler happy */
 }
 
 /*
@@ -2933,7 +2923,12 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 	  from->pi.in6.ipi6_ifindex = pkti6->ipi6_ifindex;
 	  from->pi.in6.ipi6_addr = pkti6->ipi6_addr;
 	}
+      else if (cmsg != NULL)
+	{
+	  msg(M_WARN, "CMSG received that cannot be parsed");
+	}
     }
+
   return fromlen;
 }
 #endif
@@ -3000,7 +2995,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
   iov.iov_len = BLEN (buf);
   mesg.msg_iov = &iov;
   mesg.msg_iovlen = 1;
-  switch (to->ai_family)
+  switch (to->dest.addr.sa.sa_family)
     {
     case AF_INET:
       {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8d4316b..5132953 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -91,10 +91,6 @@ struct cached_dns_entry {
 struct link_socket_actual
 {
   /*int dummy;*/ /* add offset to force a bug if dest not explicitly dereferenced */
- int ai_family;	/* PF_xxx */
- int ai_socktype;	/* SOCK_xxx */
- int ai_protocol;	/* 0 or IPPROTO_xxx for IPv4 and IPv6 */
-
 
   struct openvpn_sockaddr dest;
 #if ENABLE_IP_PKTINFO
@@ -473,7 +469,7 @@ bool ip_or_dns_addr_safe (const char *addr, const bool allow_fqdn);
 bool mac_addr_safe (const char *mac_addr);
 bool ipv6_addr_safe (const char *ipv6_text_addr);
 
-socket_descriptor_t create_socket_tcp (int af);
+socket_descriptor_t create_socket_tcp (struct addrinfo*);
 
 socket_descriptor_t socket_do_accept (socket_descriptor_t sd,
 				      struct link_socket_actual *act,
-- 
1.8.5.2 (Apple Git-48)


