From: Arne Schwabe <arne@...1227...>
Date: Thu,  2 Aug 2012 15:36:59 +0200
Message-Id: <1343914619-10576-1-git-send-email-arne@...1227...>
In-Reply-To: <20120801203832.GK2535@...1296...>
References: <20120801203832.GK2535@...1296...>
Subject: [Openvpn-devel] [PATCH 3/4] Merge almost identical
	create_socket_tcp and create_socket_tcp6
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
 src/openvpn/manage.c |    4 ++--
 src/openvpn/socket.c |   53 +++++++-------------------------------------------
 src/openvpn/socket.h |    2 +-
 3 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 3ef14e5..d0bb416 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1567,7 +1567,7 @@ man_listen (struct management *man)
       else
 #endif
 	{
-	  man->connection.sd_top = create_socket_tcp ();
+	  man->connection.sd_top = create_socket_tcp (AF_INET);
 	  socket_bind (man->connection.sd_top, &man->settings.local, "MANAGEMENT");
 	}
 
@@ -1633,7 +1633,7 @@ man_connect (struct management *man)
   else
 #endif
     {
-      man->connection.sd_cli = create_socket_tcp ();
+      man->connection.sd_cli = create_socket_tcp (AF_INET);
       status = openvpn_connect (man->connection.sd_cli,
 				&man->settings.local,
 				5,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a926db0..e4feefe 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -624,11 +624,11 @@ link_socket_update_buffer_sizes (struct link_socket *ls, int rcvbuf, int sndbuf)
  */
 
 socket_descriptor_t
-create_socket_tcp (void)
+create_socket_tcp (int af)
 {
   socket_descriptor_t sd;
 
-  if ((sd = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
+  if ((sd = socket (af, SOCK_STREAM, IPPROTO_TCP)) < 0)
     msg (M_ERR, "Cannot create TCP socket");
 
 #ifndef WIN32 /* using SO_REUSEADDR on Windows will cause bind to succeed on port conflicts! */
@@ -641,18 +641,6 @@ create_socket_tcp (void)
   }
 #endif
 
-#if 0
-  /* set socket linger options */
-  {
-    struct linger linger;
-    linger.l_onoff = 1;
-    linger.l_linger = 2;
-    if (setsockopt (sd, SOL_SOCKET, SO_LINGER,
-		    (void *) &linger, sizeof (linger)) < 0)
-      msg (M_ERR, "TCP: Cannot setsockopt SO_LINGER on TCP socket");
-  }
-#endif
-
   return sd;
 }
 
@@ -707,25 +695,6 @@ create_socket_udp6 (const unsigned int flags)
   return sd;
 }
 
-static socket_descriptor_t
-create_socket_tcp6 (void)
-{
-  socket_descriptor_t sd;
-
-  if ((sd = socket (PF_INET6, SOCK_STREAM, IPPROTO_TCP)) < 0)
-    msg (M_ERR, "Cannot create TCP6 socket");
-
-  /* set SO_REUSEADDR on socket */
-  {
-    int on = 1;
-    if (setsockopt (sd, SOL_SOCKET, SO_REUSEADDR,
-		    (void *) &on, sizeof (on)) < 0)
-      msg (M_ERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP6 socket");
-  }
-
-  return sd;
-}
-
 static void
 create_socket (struct link_socket *sock)
 {
@@ -737,18 +706,18 @@ create_socket (struct link_socket *sock)
 
 #ifdef ENABLE_SOCKS
       if (sock->socks_proxy)
-	sock->ctrl_sd = create_socket_tcp ();
+	sock->ctrl_sd = create_socket_tcp (AF_INET);
 #endif
     }
   else if (sock->info.proto == PROTO_TCPv4_SERVER
 	   || sock->info.proto == PROTO_TCPv4_CLIENT)
     {
-      sock->sd = create_socket_tcp ();
+      sock->sd = create_socket_tcp (AF_INET);
     }
   else if (sock->info.proto == PROTO_TCPv6_SERVER
 	   || sock->info.proto == PROTO_TCPv6_CLIENT)
     {
-      sock->sd = create_socket_tcp6 ();
+      sock->sd = create_socket_tcp (AF_INET6);
     }
   else if (sock->info.proto == PROTO_UDPv6)
     {
@@ -1099,15 +1068,7 @@ socket_connect (socket_descriptor_t *sd,
       if (*signal_received)
 	goto done;
 
-      switch(local->addr.sa.sa_family)
-	{
-	case PF_INET6:
-	  *sd = create_socket_tcp6 ();
-	  break;
-	case PF_INET:
-	  *sd = create_socket_tcp ();
-	  break;
-	}
+	*sd = create_socket_tcp (local->addr.sa.sa_family);
 
       if (bind_local)
         socket_bind (*sd, local, "TCP Client");
@@ -1700,7 +1661,7 @@ link_socket_init_phase2 (struct link_socket *sock,
 	    if (proxy_retry)
 	      {
 		openvpn_close_socket (sock->sd);
-		sock->sd = create_socket_tcp ();
+		sock->sd = create_socket_tcp (AF_INET);
 	      }
 	  } while (proxy_retry);
 	}
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 76d9a79..2060bc8 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -425,7 +425,7 @@ bool ip_or_dns_addr_safe (const char *addr, const bool allow_fqdn);
 bool mac_addr_safe (const char *mac_addr);
 bool ipv6_addr_safe (const char *ipv6_text_addr);
 
-socket_descriptor_t create_socket_tcp (void);
+socket_descriptor_t create_socket_tcp (int af);
 
 socket_descriptor_t socket_do_accept (socket_descriptor_t sd,
 				      struct link_socket_actual *act,
-- 
1.7.9.6 (Apple Git-31.1)


