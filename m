From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:06 +0100
Message-Id: <1385064495-25877-5-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 05/14] Split link_socket_init_phase2 into
	smaller more managable/readable functions. No functional changes
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c |  470 ++++++++++++++++++++++++++++----------------------
 1 file changed, 262 insertions(+), 208 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 54e52d6..843bcc3 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1328,6 +1328,23 @@ link_socket_new (void)
   return sock;
 }
 
+void
+create_new_socket (struct link_socket* sock, int mark)
+{
+  create_socket (sock);
+    
+  /* set socket buffers based on --sndbuf and --rcvbuf options */
+  socket_set_buffers (sock->sd, &sock->socket_buffer_sizes);
+    
+  /* set socket to --mark packets with given value */
+  socket_set_mark (sock->sd, mark);
+    
+  if(sock->bind_local)
+      resolve_bind_local (sock);
+  resolve_remote (sock, 1, NULL, NULL);
+}
+
+
 /* bind socket if necessary */
 void
 link_socket_init_phase1 (struct link_socket *sock,
@@ -1473,27 +1490,252 @@ link_socket_init_phase1 (struct link_socket *sock,
     }
   else if (mode != LS_MODE_TCP_ACCEPT_FROM)
     {
-      create_socket (sock);
+      create_new_socket (sock, mark);
+    }
+}
 
-      /* set socket buffers based on --sndbuf and --rcvbuf options */
-      socket_set_buffers (sock->sd, &sock->socket_buffer_sizes);
+static
+void phase2_inetd (struct link_socket* sock, const struct frame *frame,
+		   const char *remote_dynamic, volatile int *signal_received)
+{
+  bool remote_changed = false;
 
-      /* set socket to --mark packets with given value */
-      socket_set_mark (sock->sd, mark);
-      
-      if(sock->bind_local)
-          resolve_bind_local (sock);
-      resolve_remote (sock, 1, NULL, NULL);
+  if (sock->info.proto == PROTO_TCP_SERVER) {
+    /* AF_INET as default (and fallback) for inetd */
+    sock->info.lsa->actual.dest.addr.sa.sa_family = AF_INET;
+#ifdef HAVE_GETSOCKNAME
+    {
+      /* inetd: hint family type for dest = local's */
+      struct openvpn_sockaddr local_addr;
+      socklen_t addrlen = sizeof(local_addr);
+      if (getsockname (sock->sd, (struct sockaddr *)&local_addr, &addrlen) == 0) {
+	sock->info.lsa->actual.dest.addr.sa.sa_family = local_addr.addr.sa.sa_family;
+	dmsg (D_SOCKET_DEBUG, "inetd(%s): using sa_family=%d from getsockname(%d)",
+	      proto2ascii(sock->info.proto, sock->info.af, false), local_addr.addr.sa.sa_family,
+	      sock->sd);
+      } else
+	msg (M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
+	     proto2ascii(sock->info.proto, sock->info.af, false), sock->sd);
     }
+#else
+    msg (M_WARN, "inetd(%s): this OS does not provide the getsockname() "
+	 "function, using AF_INET",
+	 proto2ascii(sock->info.proto, false));
+#endif
+    sock->sd =
+      socket_listen_accept (sock->sd,
+			    &sock->info.lsa->actual,
+			    remote_dynamic,
+			    &remote_changed,
+			    &sock->info.lsa->local,
+			    false,
+			    sock->inetd == INETD_NOWAIT,
+			    signal_received);
+  }
+  ASSERT (!remote_changed);
+}
+
+static void
+phase2_set_socket_flags (struct link_socket* sock)
+{
+  /* set misc socket parameters */
+  socket_set_flags (sock->sd, sock->sockflags);
+
+  /* set socket to non-blocking mode */
+  set_nonblock (sock->sd);
+
+  /* set socket file descriptor to not pass across execs, so that
+     scripts don't have access to it */
+  set_cloexec (sock->sd);
+
+#ifdef ENABLE_SOCKS
+  if (socket_defined (sock->ctrl_sd))
+    set_cloexec (sock->ctrl_sd);
+#endif
+
+  /* set Path MTU discovery options on the socket */
+  set_mtu_discover_type (sock->sd, sock->mtu_discover_type);
+
+#if EXTENDED_SOCKET_ERROR_CAPABILITY
+  /* if the OS supports it, enable extended error passing on the socket */
+  set_sock_extended_error_passing (sock->sd);
+#endif
 }
 
+
+static void
+linksock_print_addr (struct link_socket *sock)
+{
+  struct gc_arena gc = gc_new ();
+
+  /* print local address */
+  {
+    const int msglevel = (sock->mode == LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
+
+    if (sock->inetd)
+      msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, sock->info.af, true));
+    else
+      msg (msglevel, "%s link local%s: %s",
+	   proto2ascii (sock->info.proto, sock->info.af, true),
+	   (sock->bind_local ? " (bound)" : ""),
+	   print_openvpn_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
+
+    /* print active remote address */
+    msg (msglevel, "%s link remote: %s",
+	 proto2ascii (sock->info.proto, sock->info.af, true),
+	 print_link_socket_actual_ex (&sock->info.lsa->actual,
+				      ":",
+				      PS_SHOW_PORT_IF_DEFINED,
+				      &gc));
+  }
+  gc_free(&gc);
+}
+
+static void
+phase2_tcp_server (struct link_socket *sock, bool *remote_changed,
+		   const char *remote_dynamic, volatile int *signal_received)
+{
+  switch (sock->mode)
+    {
+    case LS_MODE_DEFAULT:
+      sock->sd = socket_listen_accept (sock->sd,
+				       &sock->info.lsa->actual,
+				       remote_dynamic,
+				       remote_changed,
+				       &sock->info.lsa->local,
+				       true,
+				       false,
+				       signal_received);
+      break;
+    case LS_MODE_TCP_LISTEN:
+      socket_do_listen (sock->sd,
+			&sock->info.lsa->local,
+			true,
+			false);
+      break;
+    case LS_MODE_TCP_ACCEPT_FROM:
+      sock->sd = socket_do_accept (sock->sd,
+				   &sock->info.lsa->actual,
+				   false);
+      if (!socket_defined (sock->sd))
+	{
+	  *signal_received = SIGTERM;
+	  return;
+	}
+      tcp_connection_established (&sock->info.lsa->actual);
+      break;
+    default:
+      ASSERT (0);
+    }
+
+}
+
+
+static void
+phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
+		   const char *remote_dynamic, volatile int *signal_received)
+{
+#ifdef GENERAL_PROXY_SUPPORT
+    bool proxy_retry = false;
+#else
+    const bool proxy_retry = false;
+#endif
+    do {
+	socket_connect (&sock->sd,
+			&sock->info.lsa->local,
+			sock->bind_local,
+			&sock->info.lsa->actual.dest,
+			sock->connection_profiles_defined,
+			remote_dynamic,
+			remote_changed,
+			sock->connect_retry_seconds,
+			sock->connect_timeout,
+			sock->connect_retry_max,
+			sock->sockflags,
+			signal_received);
+	
+	if (*signal_received)
+	    return;
+	
+	if (false)
+	    ;
+#ifdef ENABLE_HTTP_PROXY
+	else if (sock->http_proxy)
+	    {
+		proxy_retry = establish_http_proxy_passthru (sock->http_proxy,
+							     sock->sd,
+							     sock->proxy_dest_host,
+							     sock->proxy_dest_port,
+							     &sock->stream_buf.residual,
+							     signal_received);
+	    }
+#endif
+#ifdef ENABLE_SOCKS
+	else if (sock->socks_proxy)
+	    {
+		establish_socks_proxy_passthru (sock->socks_proxy,
+						sock->sd,
+						sock->proxy_dest_host,
+						sock->proxy_dest_port,
+						signal_received);
+	    }
+#endif
+	if (proxy_retry)
+	    {
+		openvpn_close_socket (sock->sd);
+		sock->sd = create_socket_tcp (AF_INET);
+	    }
+    } while (proxy_retry);
+
+}
+
+#ifdef ENABLE_SOCKS
+static void
+phase2_socks_client (struct link_socket *sock, bool *remote_changed,
+		      const char *remote_dynamic, volatile int *signal_received)
+{
+    socket_connect (&sock->ctrl_sd,
+		    &sock->info.lsa->local,
+		    sock->bind_local,
+		    &sock->info.lsa->actual.dest,
+		    sock->connection_profiles_defined,
+		    remote_dynamic,
+		    remote_changed,
+		    sock->connect_retry_seconds,
+		    sock->connect_timeout,
+		    sock->connect_retry_max,
+		    sock->sockflags,
+		    signal_received);
+
+    if (*signal_received)
+	return;
+
+    establish_socks_proxy_udpassoc (sock->socks_proxy,
+				    sock->ctrl_sd,
+				    sock->sd,
+				    &sock->socks_relay.dest,
+				    signal_received);
+
+    if (*signal_received)
+	return;
+
+    sock->remote_host = sock->proxy_dest_host;
+    sock->remote_port = sock->proxy_dest_port;
+    sock->did_resolve_remote = false;
+
+    addr_zero_host(&sock->info.lsa->actual.dest);
+    addr_zero_host(&sock->info.lsa->remote);
+
+    resolve_remote (sock, 1, NULL, signal_received);
+}
+#endif
+
 /* finalize socket initialization */
 void
 link_socket_init_phase2 (struct link_socket *sock,
 			 const struct frame *frame,
 			 volatile int *signal_received)
 {
-  struct gc_arena gc = gc_new ();
   const char *remote_dynamic = NULL;
   bool remote_changed = false;
   int sig_save = 0;
@@ -1520,41 +1762,10 @@ link_socket_init_phase2 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      if (sock->info.proto == PROTO_TCP_SERVER) {
-	/* AF_INET as default (and fallback) for inetd */
-	sock->info.lsa->actual.dest.addr.sa.sa_family = AF_INET;
-#ifdef HAVE_GETSOCKNAME
-	  {
-	    /* inetd: hint family type for dest = local's */
-	    struct openvpn_sockaddr local_addr;
-	    socklen_t addrlen = sizeof(local_addr);
-	    if (getsockname (sock->sd, (struct sockaddr *)&local_addr, &addrlen) == 0) {
-	      sock->info.lsa->actual.dest.addr.sa.sa_family = local_addr.addr.sa.sa_family;
-	      dmsg (D_SOCKET_DEBUG, "inetd(%s): using sa_family=%d from getsockname(%d)",
-		    proto2ascii(sock->info.proto, sock->info.af, false), local_addr.addr.sa.sa_family,
-		    sock->sd);
-	    } else
-	      msg (M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
-		   proto2ascii(sock->info.proto, sock->info.af, false), sock->sd);
-	  }
-#else
-	msg (M_WARN, "inetd(%s): this OS does not provide the getsockname() "
-	     "function, using AF_INET",
-	     proto2ascii(sock->info.proto, false));
-#endif
-	sock->sd =
-	  socket_listen_accept (sock->sd,
-				&sock->info.lsa->actual,
-				remote_dynamic,
-				&remote_changed,
-				&sock->info.lsa->local,
-				false,
-				sock->inetd == INETD_NOWAIT,
-				signal_received);
-      }
-      ASSERT (!remote_changed);
+      phase2_inetd (sock, frame, remote_dynamic, signal_received);
       if (*signal_received)
 	goto done;
+
     }
   else
     {
@@ -1563,139 +1774,24 @@ link_socket_init_phase2 (struct link_socket *sock,
       if (*signal_received)
 	goto done;
 
-      /* TCP client/server */
       if (sock->info.proto == PROTO_TCP_SERVER)
 	{
-	  switch (sock->mode)
-	    {
-	    case LS_MODE_DEFAULT:
-	      sock->sd = socket_listen_accept (sock->sd,
-					       &sock->info.lsa->actual,
-					       remote_dynamic,
-					       &remote_changed,
-					       &sock->info.lsa->local,
-					       true,
-					       false,
-					       signal_received);
-	      break;
-	    case LS_MODE_TCP_LISTEN:
-	      socket_do_listen (sock->sd,
-				&sock->info.lsa->local,
-				true,
-				false);
-	      break;
-	    case LS_MODE_TCP_ACCEPT_FROM:
-	      sock->sd = socket_do_accept (sock->sd,
-					   &sock->info.lsa->actual,
-					   false);
-	      if (!socket_defined (sock->sd))
-		{
-		  *signal_received = SIGTERM;
-		  goto done;
-		}
-	      tcp_connection_established (&sock->info.lsa->actual);
-	      break;
-	    default:
-	      ASSERT (0);
-	    }
+	  phase2_tcp_server(sock, &remote_changed, remote_dynamic,
+			    signal_received);
 	}
       else if (sock->info.proto == PROTO_TCP_CLIENT)
 	{
-
-#ifdef GENERAL_PROXY_SUPPORT
-	  bool proxy_retry = false;
-#else
-	  const bool proxy_retry = false;
-#endif
-	  do {
-	    socket_connect (&sock->sd,
-			    &sock->info.lsa->local,
-			    sock->bind_local,
-			    &sock->info.lsa->actual.dest,
-			    sock->connection_profiles_defined,
-			    remote_dynamic,
-			    &remote_changed,
-			    sock->connect_retry_seconds,
-			    sock->connect_timeout,
-			    sock->connect_retry_max,
-			    sock->sockflags,
+	  phase2_tcp_client(sock, &remote_changed, remote_dynamic,
 			    signal_received);
 
-	    if (*signal_received)
-	      goto done;
-
-	    if (false)
-	      ;
-#ifdef ENABLE_HTTP_PROXY
-	    else if (sock->http_proxy)
-	      {
-		proxy_retry = establish_http_proxy_passthru (sock->http_proxy,
-							     sock->sd,
-							     sock->proxy_dest_host,
-							     sock->proxy_dest_port,
-							     &sock->stream_buf.residual,
-							     signal_received);
-	      }
-#endif
-#ifdef ENABLE_SOCKS
-	    else if (sock->socks_proxy)
-	      {
-		establish_socks_proxy_passthru (sock->socks_proxy,
-						sock->sd,
-						sock->proxy_dest_host,
-						sock->proxy_dest_port,
-						signal_received);
-	      }
-#endif
-	    if (proxy_retry)
-	      {
-		openvpn_close_socket (sock->sd);
-		sock->sd = create_socket_tcp (AF_INET);
-	      }
-	  } while (proxy_retry);
 	}
 #ifdef ENABLE_SOCKS
       else if (sock->info.proto == PROTO_UDP && sock->socks_proxy && sock->info.af == AF_INET)
 	{
-	  socket_connect (&sock->ctrl_sd,
-                          &sock->info.lsa->local,
-                          sock->bind_local,
-			  &sock->info.lsa->actual.dest,
-			  sock->connection_profiles_defined,
-			  remote_dynamic,
-			  &remote_changed,
-			  sock->connect_retry_seconds,
-			  sock->connect_timeout,
-			  sock->connect_retry_max,
-			  sock->sockflags,
-			  signal_received);
-
-	  if (*signal_received)
-	    goto done;
-
-	  establish_socks_proxy_udpassoc (sock->socks_proxy,
-					  sock->ctrl_sd,
-					  sock->sd,
-					  &sock->socks_relay.dest,
-					  signal_received);
-
-	  if (*signal_received)
-	    goto done;
-
-	  sock->remote_host = sock->proxy_dest_host;
-	  sock->remote_port = sock->proxy_dest_port;
-	  sock->did_resolve_remote = false;
-
-	  addr_zero_host(&sock->info.lsa->actual.dest);
-	  addr_zero_host(&sock->info.lsa->remote);
-
-	  resolve_remote (sock, 1, NULL, signal_received);
-
-	  if (*signal_received)
-	    goto done;
-	}
+	  phase2_socks_client(sock, &remote_changed, remote_dynamic,
+			      signal_received);
 #endif
-
+	}
       if (*signal_received)
 	goto done;
 
@@ -1706,49 +1802,8 @@ link_socket_init_phase2 (struct link_socket *sock,
 	}
     }
 
-  /* set misc socket parameters */
-  socket_set_flags (sock->sd, sock->sockflags);
-
-  /* set socket to non-blocking mode */
-  set_nonblock (sock->sd);
-
-  /* set socket file descriptor to not pass across execs, so that
-     scripts don't have access to it */
-  set_cloexec (sock->sd);
-
-#ifdef ENABLE_SOCKS
-  if (socket_defined (sock->ctrl_sd))
-    set_cloexec (sock->ctrl_sd);
-#endif
-
-  /* set Path MTU discovery options on the socket */
-  set_mtu_discover_type (sock->sd, sock->mtu_discover_type);
-
-#if EXTENDED_SOCKET_ERROR_CAPABILITY
-  /* if the OS supports it, enable extended error passing on the socket */
-  set_sock_extended_error_passing (sock->sd);
-#endif
-
-  /* print local address */
-  {
-    const int msglevel = (sock->mode == LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
-
-    if (sock->inetd)
-      msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, sock->info.af, true));
-    else
-      msg (msglevel, "%s link local%s: %s",
-	   proto2ascii (sock->info.proto, sock->info.af, true),
-	   (sock->bind_local ? " (bound)" : ""),
-	   print_openvpn_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
-
-    /* print active remote address */
-    msg (msglevel, "%s link remote: %s",
-	 proto2ascii (sock->info.proto, sock->info.af, true),
-	 print_link_socket_actual_ex (&sock->info.lsa->actual,
-				      ":",
-				      PS_SHOW_PORT_IF_DEFINED,
-				      &gc));
-  }
+  phase2_set_socket_flags(sock);
+  linksock_print_addr(sock);
 
  done:
   if (sig_save && signal_received)
@@ -1756,7 +1811,6 @@ link_socket_init_phase2 (struct link_socket *sock,
       if (!*signal_received)
 	*signal_received = sig_save;
     }
-  gc_free (&gc);
 }
 
 void
-- 
1.7.9.5


