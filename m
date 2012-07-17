From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 17 Jul 2012 18:25:16 +0200
Message-ID: <1342542316-32563-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
References: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 2/2] don't treat socket related errors
	special anymore
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

WSAGetLastError() is just a wrapper for GetLastError(). So, there's
no need to differentiate between socket related and other errors.

This patch removes all special handling of socket errors in favor
of simplifying the codebase somewhat.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/error.c  |    9 ++-----
 src/openvpn/error.h  |    4 ---
 src/openvpn/fdmisc.c |    2 +-
 src/openvpn/manage.c |    4 +-
 src/openvpn/proxy.c  |   10 ++++----
 src/openvpn/ps.c     |    6 ++--
 src/openvpn/socket.c |   56 +++++++++++++++++++++++++-------------------------
 src/openvpn/socket.h |    2 +-
 src/openvpn/socks.c  |   26 +++++++++++-----------
 src/openvpn/win32.c  |    6 ++--
 10 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index d6ad639..8396fe0 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -221,10 +221,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
     return;
 #endif
 
-  if (flags & M_ERRNO_SOCK)
-    e = openvpn_errno_socket ();
-  else
-    e = openvpn_errno ();
+  e = openvpn_errno ();
 
   /*
    * Apply muting filter.
@@ -245,7 +242,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
   va_end (arglist);
   m1[ERR_BUF_SIZE - 1] = 0; /* windows vsnprintf needs this */
 
-  if ((flags & (M_ERRNO|M_ERRNO_SOCK)) && e)
+  if ((flags & M_ERRNO) && e)
     {
       openvpn_snprintf (m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
 			m1, strerror_ts (e, &gc), e);
@@ -596,7 +593,7 @@ x_check_status (int status,
 		struct link_socket *sock,
 		struct tuntap *tt)
 {
-  const int my_errno = (sock ? openvpn_errno_socket () : (int)openvpn_errno ());
+  const int my_errno = openvpn_errno ();
   const char *extended_msg = NULL;
 
   msg (x_cs_verbose_level, "%s %s returned %d",
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ed8f903..aedb7c3 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -68,12 +68,10 @@ struct gc_arena;
 
 #ifdef WIN32
 # define openvpn_errno()             GetLastError()
-# define openvpn_errno_socket()      WSAGetLastError()
 # define openvpn_strerror(e, gc)     strerror_win32(e, gc)
   const char *strerror_win32 (DWORD errnum, struct gc_arena *gc);
 #else
 # define openvpn_errno()             errno
-# define openvpn_errno_socket()      errno
 # define openvpn_strerror(x, gc)     strerror(x)
 #endif
 
@@ -94,7 +92,6 @@ extern int x_msg_line_num;
 #define M_DEBUG           (1<<7)
 
 #define M_ERRNO           (1<<8)	 /* show errno description */
-#define M_ERRNO_SOCK      (1<<9)	 /* show socket errno description */
 
 #ifdef ENABLE_CRYPTO_OPENSSL
 #  define M_SSL             (1<<10)	 /* show SSL error */
@@ -110,7 +107,6 @@ extern int x_msg_line_num;
 
 /* flag combinations which are frequently used */
 #define M_ERR     (M_FATAL | M_ERRNO)
-#define M_SOCKERR (M_FATAL | M_ERRNO_SOCK)
 #define M_SSLERR  (M_FATAL | M_SSL)
 #define M_USAGE   (M_USAGE_SMALL | M_NOPREFIX | M_OPTERR)
 #define M_CLIENT  (M_MSG_VIRT_OUT | M_NOMUTE | M_NOIPREFIX)
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 8dc11b1..7fe449c 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -66,7 +66,7 @@ void
 set_nonblock (int fd)
 {
   if (!set_nonblock_action (fd))
-    msg (M_SOCKERR, "Set socket to non-blocking mode failed");
+    msg (M_ERR, "Set socket to non-blocking mode failed");
 }
 
 /* Set a file descriptor to not be passed across execs */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 33d8be4..3ef14e5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1575,7 +1575,7 @@ man_listen (struct management *man)
        * Listen for connection
        */
       if (listen (man->connection.sd_top, 1))
-	msg (M_SOCKERR, "MANAGEMENT: listen() failed");
+	msg (M_ERR, "MANAGEMENT: listen() failed");
 
       /*
        * Set misc socket properties
@@ -1763,7 +1763,7 @@ man_process_command (struct management *man, const char *line)
 static bool
 man_io_error (struct management *man, const char *prefix)
 {
-  const int err = openvpn_errno_socket ();
+  const int err = openvpn_errno ();
 
   if (!ignore_sys_error (err))
     {
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 202e55e..28ce019 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -108,7 +108,7 @@ recv_line (socket_descriptor_t sd,
       if (status == 0)
 	{
 	  if (verbose)
-	    msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_line: TCP port read timeout expired");
+	    msg (D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read timeout expired");
 	  goto error;
 	}
 
@@ -116,7 +116,7 @@ recv_line (socket_descriptor_t sd,
       if (status < 0)
 	{
 	  if (verbose)
-	    msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_line: TCP port read failed on select()");
+	    msg (D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read failed on select()");
 	  goto error;
 	}
 
@@ -127,7 +127,7 @@ recv_line (socket_descriptor_t sd,
       if (size != 1)
 	{
 	  if (verbose)
-	    msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_line: TCP port read failed on recv()");
+	    msg (D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read failed on recv()");
 	  goto error;
 	}
 
@@ -152,7 +152,7 @@ recv_line (socket_descriptor_t sd,
 	  if (!isprint(c) && !isspace(c)) /* not ascii? */
 	    {
 	      if (verbose)
-		msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_line: Non-ASCII character (%d) read on recv()", (int)c);
+		msg (D_LINK_ERRORS | M_ERRNO, "recv_line: Non-ASCII character (%d) read on recv()", (int)c);
 	      *lookahead = la;
 	      return false;
 	    }
@@ -182,7 +182,7 @@ send_line (socket_descriptor_t sd,
   const ssize_t size = send (sd, buf, strlen (buf), MSG_NOSIGNAL);
   if (size != (ssize_t) strlen (buf))
     {
-      msg (D_LINK_ERRORS | M_ERRNO_SOCK, "send_line: TCP port write failed on send()");
+      msg (D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on send()");
       return false;
     }
   return true;
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 5d056ee..6495dc7 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -233,7 +233,7 @@ port_share_sendmsg (const socket_descriptor_t sd,
 
       status = sendmsg (sd, &mesg, MSG_NOSIGNAL);
       if (status == -1)
-	msg (M_WARN|M_ERRNO_SOCK, "PORT SHARE: sendmsg failed -- unable to communicate with background process (%d,%d,%d,%d)",
+	msg (M_WARN|M_ERRNO, "PORT SHARE: sendmsg failed -- unable to communicate with background process (%d,%d,%d,%d)",
 	     sd, sd_send, sd_null[0], sd_null[1]
 	     );
 
@@ -419,7 +419,7 @@ proxy_entry_new (struct proxy_connection **list,
   sock_addr_set (&osaddr, server_addr, server_port);
   if ((sd_server = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
     {
-      msg (M_WARN|M_ERRNO_SOCK, "PORT SHARE PROXY: cannot create socket");
+      msg (M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
       return false;
     }
   status = openvpn_connect (sd_server, &osaddr, 5, NULL);
@@ -851,7 +851,7 @@ port_share_open (const char *host,
 	}
       else
 	{
-	  msg (M_SOCKERR, "PORT SHARE: unexpected init recv_control status=%d", status);
+	  msg (M_ERR, "PORT SHARE: unexpected init recv_control status=%d", status);
 	}
     }
   else
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 02e2768..eb5e180 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -834,7 +834,7 @@ create_socket_tcp (void)
   socket_descriptor_t sd;
 
   if ((sd = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
-    msg (M_SOCKERR, "Cannot create TCP socket");
+    msg (M_ERR, "Cannot create TCP socket");
 
 #ifndef WIN32 /* using SO_REUSEADDR on Windows will cause bind to succeed on port conflicts! */
   /* set SO_REUSEADDR on socket */
@@ -842,7 +842,7 @@ create_socket_tcp (void)
     int on = 1;
     if (setsockopt (sd, SOL_SOCKET, SO_REUSEADDR,
 		    (void *) &on, sizeof (on)) < 0)
-      msg (M_SOCKERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP socket");
+      msg (M_ERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP socket");
   }
 #endif
 
@@ -854,7 +854,7 @@ create_socket_tcp (void)
     linger.l_linger = 2;
     if (setsockopt (sd, SOL_SOCKET, SO_LINGER,
 		    (void *) &linger, sizeof (linger)) < 0)
-      msg (M_SOCKERR, "TCP: Cannot setsockopt SO_LINGER on TCP socket");
+      msg (M_ERR, "TCP: Cannot setsockopt SO_LINGER on TCP socket");
   }
 #endif
 
@@ -867,7 +867,7 @@ create_socket_udp (const unsigned int flags)
   socket_descriptor_t sd;
 
   if ((sd = socket (PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
-    msg (M_SOCKERR, "UDP: Cannot create UDP socket");
+    msg (M_ERR, "UDP: Cannot create UDP socket");
 #if ENABLE_IP_PKTINFO
   else if (flags & SF_USE_IP_PKTINFO)
     {
@@ -875,11 +875,11 @@ create_socket_udp (const unsigned int flags)
 #ifdef IP_PKTINFO
       if (setsockopt (sd, SOL_IP, IP_PKTINFO,
 		      (void*)&pad, sizeof(pad)) < 0)
-        msg(M_SOCKERR, "UDP: failed setsockopt for IP_PKTINFO");
+        msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
 #elif defined(IP_RECVDSTADDR)
       if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
 		      (void*)&pad, sizeof(pad)) < 0)
-        msg(M_SOCKERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
+        msg(M_ERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
 #else
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
@@ -894,7 +894,7 @@ create_socket_udp6 (const unsigned int flags)
   socket_descriptor_t sd;
 
   if ((sd = socket (PF_INET6, SOCK_DGRAM, IPPROTO_UDP)) < 0)
-    msg (M_SOCKERR, "UDP: Cannot create UDP6 socket");
+    msg (M_ERR, "UDP: Cannot create UDP6 socket");
 #if ENABLE_IP_PKTINFO
   else if (flags & SF_USE_IP_PKTINFO)
     {
@@ -906,7 +906,7 @@ create_socket_udp6 (const unsigned int flags)
       if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
 		      (void*)&pad, sizeof(pad)) < 0)
 #endif
-	msg(M_SOCKERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
+	msg(M_ERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
     }
 #endif
   return sd;
@@ -918,14 +918,14 @@ create_socket_tcp6 (void)
   socket_descriptor_t sd;
 
   if ((sd = socket (PF_INET6, SOCK_STREAM, IPPROTO_TCP)) < 0)
-    msg (M_SOCKERR, "Cannot create TCP6 socket");
+    msg (M_ERR, "Cannot create TCP6 socket");
 
   /* set SO_REUSEADDR on socket */
   {
     int on = 1;
     if (setsockopt (sd, SOL_SOCKET, SO_REUSEADDR,
 		    (void *) &on, sizeof (on)) < 0)
-      msg (M_SOCKERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP6 socket");
+      msg (M_ERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP6 socket");
   }
 
   return sd;
@@ -982,7 +982,7 @@ socket_do_listen (socket_descriptor_t sd,
       msg (M_INFO, "Listening for incoming TCP connection on %s", 
 	   print_sockaddr (local, &gc));
       if (listen (sd, 1))
-	msg (M_SOCKERR, "TCP: listen() failed");
+	msg (M_ERR, "TCP: listen() failed");
     }
 
   /* set socket to non-blocking mode */
@@ -1013,7 +1013,7 @@ socket_do_accept (socket_descriptor_t sd,
       new_sd = getpeername (sd, &act->dest.addr.sa, &remote_len);
 
       if (!socket_defined (new_sd))
-	msg (D_LINK_ERRORS | M_ERRNO_SOCK, "TCP: getpeername() failed");
+	msg (D_LINK_ERRORS | M_ERRNO, "TCP: getpeername() failed");
       else
 	new_sd = sd;
     }
@@ -1037,7 +1037,7 @@ socket_do_accept (socket_descriptor_t sd,
 
   if (!socket_defined (new_sd))
     {
-      msg (D_LINK_ERRORS | M_ERRNO_SOCK, "TCP: accept(%d) failed", sd);
+      msg (D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", sd);
     }
   /* only valid if we have remote_len_af!=0 */
   else if (remote_len_af && remote_len != remote_len_af)
@@ -1097,7 +1097,7 @@ socket_listen_accept (socket_descriptor_t sd,
 	}
 
       if (status < 0)
-	msg (D_LINK_ERRORS | M_ERRNO_SOCK, "TCP: select() failed");
+	msg (D_LINK_ERRORS | M_ERRNO, "TCP: select() failed");
 
       if (status <= 0)
 	{
@@ -1117,7 +1117,7 @@ socket_listen_accept (socket_descriptor_t sd,
 		   "TCP NOTE: Rejected connection attempt from %s due to --remote setting",
 		   print_link_socket_actual (act, &gc));
 	      if (openvpn_close_socket (new_sd))
-		msg (M_SOCKERR, "TCP: close socket failed (new_sd)");
+		msg (M_ERR, "TCP: close socket failed (new_sd)");
 	    }
 	  else
 	    break;
@@ -1126,7 +1126,7 @@ socket_listen_accept (socket_descriptor_t sd,
     }
 
   if (!nowait && openvpn_close_socket (sd))
-    msg (M_SOCKERR, "TCP: close socket failed (sd)");
+    msg (M_ERR, "TCP: close socket failed (sd)");
 
   tcp_connection_established (act);
 
@@ -1143,7 +1143,7 @@ socket_bind (socket_descriptor_t sd,
 
   if (bind (sd, &local->addr.sa, af_addr_size(local->addr.sa.sa_family)))
     {
-      const int errnum = openvpn_errno_socket ();
+      const int errnum = openvpn_errno ();
       msg (M_FATAL, "%s: Socket bind failed on local address %s: %s",
 	   prefix,
            print_sockaddr (local, &gc),
@@ -1164,7 +1164,7 @@ openvpn_connect (socket_descriptor_t sd,
   set_nonblock (sd);
   status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
   if (status)
-    status = openvpn_errno_socket ();
+    status = openvpn_errno ();
   if (
 #ifdef WIN32
     status == WSAEWOULDBLOCK
@@ -1196,7 +1196,7 @@ openvpn_connect (socket_descriptor_t sd,
 	    }
 	  if (status < 0)
 	    {
-	      status = openvpn_errno_socket ();
+	      status = openvpn_errno ();
 	      break;
 	    }
 	  if (status <= 0)
@@ -1220,7 +1220,7 @@ openvpn_connect (socket_descriptor_t sd,
 		&& len == sizeof (val))
 	      status = val;
 	    else
-	      status = openvpn_errno_socket ();
+	      status = openvpn_errno ();
 	    break;
 	  }
 	}
@@ -1228,7 +1228,7 @@ openvpn_connect (socket_descriptor_t sd,
 #else
   status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
   if (status)
-    status = openvpn_errno_socket ();
+    status = openvpn_errno ();
 #endif
 
   return status;
@@ -2046,7 +2046,7 @@ link_socket_close (struct link_socket *sock)
 	    {
 	      msg (D_LOW, "TCP/UDP: Closing socket");
 	      if (openvpn_close_socket (sock->sd))
-		msg (M_WARN | M_ERRNO_SOCK, "TCP/UDP: Close Socket failed");
+		msg (M_WARN | M_ERRNO, "TCP/UDP: Close Socket failed");
 	    }
 	  sock->sd = SOCKET_UNDEFINED;
 #ifdef WIN32
@@ -2062,7 +2062,7 @@ link_socket_close (struct link_socket *sock)
       if (socket_defined (sock->ctrl_sd))
 	{
 	  if (openvpn_close_socket (sock->ctrl_sd))
-	    msg (M_WARN | M_ERRNO_SOCK, "TCP/UDP: Close Socket (ctrl_sd) failed");
+	    msg (M_WARN | M_ERRNO, "TCP/UDP: Close Socket (ctrl_sd) failed");
 	  sock->ctrl_sd = SOCKET_UNDEFINED;
 	}
 #endif
@@ -3354,7 +3354,7 @@ socket_finalize (SOCKET s,
 	      /* if no error (i.e. just not finished yet), then DON'T execute this code */
 	      io->iostate = IOSTATE_INITIAL;
 	      ASSERT (ResetEvent (io->overlapped.hEvent));
-	      msg (D_WIN32_IO | M_ERRNO_SOCK, "WIN32 I/O: Socket Completion error");
+	      msg (D_WIN32_IO | M_ERRNO, "WIN32 I/O: Socket Completion error");
 	    }
 	}
       break;
@@ -3367,7 +3367,7 @@ socket_finalize (SOCKET s,
 	  /* error return for a non-queued operation */
 	  WSASetLastError (io->status);
 	  ret = -1;
-	  msg (D_WIN32_IO | M_ERRNO_SOCK, "WIN32 I/O: Socket Completion non-queued error");
+	  msg (D_WIN32_IO | M_ERRNO, "WIN32 I/O: Socket Completion non-queued error");
 	}
       else
 	{
@@ -3501,7 +3501,7 @@ create_socket_unix (void)
   socket_descriptor_t sd;
 
   if ((sd = socket (PF_UNIX, SOCK_STREAM, 0)) < 0)
-    msg (M_SOCKERR, "Cannot create unix domain socket");
+    msg (M_ERR, "Cannot create unix domain socket");
   return sd;
 }
 
@@ -3518,7 +3518,7 @@ socket_bind_unix (socket_descriptor_t sd,
 
   if (bind (sd, (struct sockaddr *) local, sizeof (struct sockaddr_un)))
     {
-      const int errnum = openvpn_errno_socket ();
+      const int errnum = openvpn_errno ();
       msg (M_FATAL, "%s: Socket bind[%d] failed on unix domain socket %s: %s",
 	   prefix,
 	   (int)sd,
@@ -3551,7 +3551,7 @@ socket_connect_unix (socket_descriptor_t sd,
 {
   int status = connect (sd, (struct sockaddr *) remote, sizeof (struct sockaddr_un));
   if (status)
-    status = openvpn_errno_socket ();
+    status = openvpn_errno ();
   return status;
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index ef21cb6..47c6e8e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -750,7 +750,7 @@ socket_connection_reset (const struct link_socket *sock, int status)
 	return true;
       else if (status < 0)
 	{
-	  const int err = openvpn_errno_socket ();
+	  const int err = openvpn_errno ();
 #ifdef WIN32
 	  return err == WSAECONNRESET || err == WSAECONNABORTED;
 #else
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index dd54c8d..235982e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -120,7 +120,7 @@ socks_username_password_auth (struct socks_proxy_info *p,
 
   if (size != strlen (to_send))
     {
-      msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port write failed on send()");
+      msg (D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port write failed on send()");
       return false;
     }
 
@@ -146,14 +146,14 @@ socks_username_password_auth (struct socks_proxy_info *p,
       /* timeout? */
       if (status == 0)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port read timeout expired");
+	  msg (D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read timeout expired");
 	  return false;
 	}
 
       /* error */
       if (status < 0)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port read failed on select()");
+	  msg (D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read failed on select()");
 	  return false;
 	}
 
@@ -163,7 +163,7 @@ socks_username_password_auth (struct socks_proxy_info *p,
       /* error? */
       if (size != 1)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_username_password_auth: TCP port read failed on recv()");
+	  msg (D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read failed on recv()");
 	  return false;
 	}
 
@@ -194,7 +194,7 @@ socks_handshake (struct socks_proxy_info *p,
   const ssize_t size = send (sd, "\x05\x02\x00\x02", 4, MSG_NOSIGNAL);
   if (size != 4)
     {
-      msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_handshake: TCP port write failed on send()");
+      msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write failed on send()");
       return false;
     }
 
@@ -220,14 +220,14 @@ socks_handshake (struct socks_proxy_info *p,
       /* timeout? */
       if (status == 0)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_handshake: TCP port read timeout expired");
+	  msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read timeout expired");
 	  return false;
 	}
 
       /* error */
       if (status < 0)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_handshake: TCP port read failed on select()");
+	  msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read failed on select()");
 	  return false;
 	}
 
@@ -237,7 +237,7 @@ socks_handshake (struct socks_proxy_info *p,
       /* error? */
       if (size != 1)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "socks_handshake: TCP port read failed on recv()");
+	  msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read failed on recv()");
 	  return false;
 	}
 
@@ -319,14 +319,14 @@ recv_socks_reply (socket_descriptor_t sd,
       /* timeout? */
       if (status == 0)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_socks_reply: TCP port read timeout expired");
+	  msg (D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read timeout expired");
 	  return false;
 	}
 
       /* error */
       if (status < 0)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_socks_reply: TCP port read failed on select()");
+	  msg (D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on select()");
 	  return false;
 	}
 
@@ -336,7 +336,7 @@ recv_socks_reply (socket_descriptor_t sd,
       /* error? */
       if (size != 1)
 	{
-	  msg (D_LINK_ERRORS | M_ERRNO_SOCK, "recv_socks_reply: TCP port read failed on recv()");
+	  msg (D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on recv()");
 	  return false;
 	}
 
@@ -421,7 +421,7 @@ establish_socks_proxy_passthru (struct socks_proxy_info *p,
     const ssize_t size = send (sd, buf, 5 + len + 2, MSG_NOSIGNAL);
     if ((int)size != 5 + (int)len + 2)
       {
-	msg (D_LINK_ERRORS | M_ERRNO_SOCK, "establish_socks_proxy_passthru: TCP port write failed on send()");
+	msg (D_LINK_ERRORS | M_ERRNO, "establish_socks_proxy_passthru: TCP port write failed on send()");
 	goto error;
       }
   }
@@ -458,7 +458,7 @@ establish_socks_proxy_udpassoc (struct socks_proxy_info *p,
 			       10, MSG_NOSIGNAL);
     if (size != 10)
       {
-	msg (D_LINK_ERRORS | M_ERRNO_SOCK, "establish_socks_proxy_passthru: TCP port write failed on send()");
+	msg (D_LINK_ERRORS | M_ERRNO, "establish_socks_proxy_passthru: TCP port write failed on send()");
 	goto error;
       }
   }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e8e69dc..d00088e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -257,7 +257,7 @@ init_net_event_win32 (struct rw_handle *event, long network_events, socket_descr
   
   /* setup network events to change read event state */
   if (WSAEventSelect (sd, event->read, network_events) != 0)
-    msg (M_FATAL | M_ERRNO_SOCK, "Error: init_net_event_win32: WSAEventSelect call failed");
+    msg (M_FATAL | M_ERRNO, "Error: init_net_event_win32: WSAEventSelect call failed");
 }
 
 long
@@ -266,7 +266,7 @@ reset_net_event_win32 (struct rw_handle *event, socket_descriptor_t sd)
   WSANETWORKEVENTS wne;  
   if (WSAEnumNetworkEvents (sd, event->read, &wne) != 0)
     {
-      msg (M_FATAL | M_ERRNO_SOCK, "Error: reset_net_event_win32: WSAEnumNetworkEvents call failed");
+      msg (M_FATAL | M_ERRNO, "Error: reset_net_event_win32: WSAEnumNetworkEvents call failed");
       return 0; /* NOTREACHED */
     }
   else
@@ -281,7 +281,7 @@ close_net_event_win32 (struct rw_handle *event, socket_descriptor_t sd, unsigned
       if (socket_defined (sd))
 	{
 	  if (WSAEventSelect (sd, event->read, 0) != 0)
-	    msg (M_WARN | M_ERRNO_SOCK, "Warning: close_net_event_win32: WSAEventSelect call failed");
+	    msg (M_WARN | M_ERRNO, "Warning: close_net_event_win32: WSAEventSelect call failed");
 	}
       if (!ResetEvent (event->read))
 	msg (M_WARN | M_ERRNO, "Warning: ResetEvent (read) failed in close_net_event_win32");
-- 
1.7.9


