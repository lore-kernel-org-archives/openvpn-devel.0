Message-ID: <2CE3100C50DF6A43ADF9CDD0DFC1403C50D5E5@...433...>
From: Ewan Bhamrah Harley <ewan@...432...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Local binding patch for TCP clients
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jul 13 03:07:37 2005
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
To: "'openvpn-devel@lists.sourceforge.net'" <openvpn-devel@lists.sourceforge.net>

Below is a patch against 2.0 that adds support for the local and lport
options on tcp-client connections (also udp connections via a socks proxy).

I'm not sure what the default should be if none of local, lport or nobind
are given. As posted, the patch assumes nobind in this case (consistent with
typical TCP client behaviour) but dropping the patch to options.c will cause
local binding to INADDR_ANY and the default port - nobind must specifically
be given to get nobind behaviour (consistent with current udp connection
behaviour).

I've tested this on linux and windows but it's all pretty generic so I
wouldn't expect any problems on other platforms.

Rgds
Ewan Bhamrah Harley

diff -Naur openvpn-2.0/options.c openvpn-2.0-ebh/options.c
--- openvpn-2.0/options.c	2005-04-16 23:03:15.000000000 +0100
+++ openvpn-2.0-ebh/options.c	2005-07-11 17:29:15.000000000 +0100
@@ -1330,6 +1330,14 @@
   if (!options->remote_list && !options->bind_local)
     msg (M_USAGE, "--nobind doesn't make sense unless used with --remote");
 
+  if (options->proto == PROTO_TCPv4_CLIENT && !options->local &&
!options->local_port_defined)
+    options->bind_local = false;
+
+#ifdef ENABLE_SOCKS
+  if (options->proto == PROTO_UDPv4 && options->socks_proxy_server &&
!options->local && !options->local_port_defined)
+    options->bind_local = false;
+#endif
+
   /*
    * Check for consistency of management options
    */
diff -Naur openvpn-2.0/socket.c openvpn-2.0-ebh/socket.c
--- openvpn-2.0/socket.c	2005-04-11 04:43:58.000000000 +0100
+++ openvpn-2.0-ebh/socket.c	2005-07-11 17:29:15.000000000 +0100
@@ -619,7 +619,26 @@
 }
 
 static void
+socket_bind (socket_descriptor_t sd,
+             struct sockaddr_in *local)
+{
+  struct gc_arena gc = gc_new ();
+
+  if (bind (sd, (struct sockaddr *) local,
+		 sizeof (struct sockaddr_in)))
+    {
+      const int errnum = openvpn_errno_socket ();
+      msg (M_FATAL, "TCP/UDP: Socket bind failed on local address %s: %s",
+           print_sockaddr (local, &gc),
+           strerror_ts (errnum, &gc));
+    }
+  gc_free (&gc);
+}
+
+static void
 socket_connect (socket_descriptor_t *sd,
+		struct sockaddr_in *local,
+		bool bind_local,
 		struct sockaddr_in *remote,
 		struct remote_list *remote_list,
 		const char *remote_dynamic,
@@ -660,6 +679,8 @@
 	}
 
       *sd = create_socket_tcp ();
+      if (bind_local)
+        socket_bind (*sd, local);
       update_remote (remote_dynamic, remote, remote_changed);
     }
 
@@ -729,14 +750,12 @@
   /* bind to local address/port */
   if (sock->bind_local)
     {
-      if (bind (sock->sd, (struct sockaddr *) &sock->info.lsa->local,
-		sizeof (sock->info.lsa->local)))
-	{
-	  const int errnum = openvpn_errno_socket ();
-	  msg (M_FATAL, "TCP/UDP: Socket bind failed on local address %s:
%s",
-	       print_sockaddr (&sock->info.lsa->local, &gc),
-	       strerror_ts (errnum, &gc));
-	}
+#ifdef ENABLE_SOCKS
+      if (sock->socks_proxy && sock->info.proto == PROTO_UDPv4)
+          socket_bind (sock->ctrl_sd, &sock->info.lsa->local);
+      else
+#endif
+          socket_bind (sock->sd, &sock->info.lsa->local);
     }
   gc_free (&gc);
 }
@@ -990,10 +1009,12 @@
       else
 	sock->bind_local = true;
     }
+#if 0
   else if (sock->info.proto == PROTO_TCPv4_CLIENT)
     {
       sock->bind_local = false;
     }
+#endif
 
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
@@ -1096,6 +1117,8 @@
       else if (sock->info.proto == PROTO_TCPv4_CLIENT)
 	{
 	  socket_connect (&sock->sd,
+			  &sock->info.lsa->local,
+			  sock->bind_local,
 			  &sock->info.lsa->actual,
 			  sock->remote_list,
 			  remote_dynamic,
@@ -1134,6 +1157,8 @@
       else if (sock->info.proto == PROTO_UDPv4 && sock->socks_proxy)
 	{
 	  socket_connect (&sock->ctrl_sd,
+			  &sock->info.lsa->local,
+			  sock->bind_local,
 			  &sock->info.lsa->actual,
 			  NULL,
 			  remote_dynamic,

