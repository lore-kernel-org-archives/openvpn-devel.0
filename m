From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:13 +0100
Message-Id: <1385064495-25877-12-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 12/14] Implement listing on IPv4/IPv6 dual
	socket on all platform
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

With this patch OpenVPN will listen on Ipv4 as well as IPv6 when an IPv6 socket is used. Using bind ipv6only will disable this behavior
---
 doc/openvpn.8         |    8 +++++++-
 src/openvpn/init.c    |    1 +
 src/openvpn/manage.c  |    2 +-
 src/openvpn/options.c |    4 ++++
 src/openvpn/options.h |    1 +
 src/openvpn/socket.c  |   36 +++++++++++++++++++++++++-----------
 src/openvpn/socket.h  |    5 ++++-
 7 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 412006a..7a87d90 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -684,7 +684,7 @@ TCP/UDP port number or name for bind.
 TCP/UDP port number or name for remote.
 .\"*********************************************************
 .TP
-.B \-\-bind
+.B \-\-bind [ipv6only]
 Bind to local address and port. This is the default unless any of 
 .B \-\-proto tcp-client
 ,
@@ -692,6 +692,12 @@ Bind to local address and port. This is the default unless any of
 or
 .B \-\-socks-proxy
 are used.
+
+If the 
+.B \-\-ipv6only
+keyword is present OpenVPN will bind only to IPv6 (as oposed
+to IPv6 and IPv4) when a IPv6 socket is opened.
+
 .\"*********************************************************
 .TP
 .B \-\-nobind
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5eb213b..c54907c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2690,6 +2690,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ce.remote_port,
 			   c->options.ce.proto,
 			   c->options.ce.af,
+			   c->options.ce.bind_ipv6_only,
 			   mode,
 			   c->c2.accept_from,
 #ifdef ENABLE_HTTP_PROXY
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 23e7652..169c8a2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1570,7 +1570,7 @@ man_listen (struct management *man)
 	{
 	  man->connection.sd_top = create_socket_tcp (AF_INET);
 	  socket_bind (man->connection.sd_top, man->settings.local,
-                       AF_INET, "MANAGEMENT");
+                       AF_INET, "MANAGEMENT", true);
 	}
 
       /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a74c7d4..ed3b17f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -779,6 +779,7 @@ init_options (struct options *o, const bool init_gc)
   o->topology = TOP_NET30;
   o->ce.proto = PROTO_UDP;
   o->ce.af = AF_UNSPEC;
+  o->ce.bind_local=false;
   o->ce.connect_retry_seconds = 5;
   o->ce.connect_timeout = 10;
   o->connect_retry_max = 0;
@@ -4871,6 +4872,9 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       options->ce.bind_defined = true;
+      if (p[1] && streq (p[1], "ipv6only"))
+          options->ce.bind_ipv6_only=true;
+
     }
   else if (streq (p[0], "nobind"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 86760bb..95e67df 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -95,6 +95,7 @@ struct connection_entry
   const char *remote;
   bool remote_float;
   bool bind_defined;
+  bool bind_ipv6_only;
   bool bind_local;
   int connect_retry_seconds;
   int connect_timeout;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8958c88..4fd00db 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -663,10 +663,9 @@ create_socket (struct link_socket *sock)
 {
   /* create socket, use information carried over from getaddrinfo */
   const int ai_proto = sock->info.lsa->actual.ai_protocol;
-  const int ai_family = sock->info.lsa->actual.ai_family;
-    
-  ASSERT (sock->info.af == AF_UNSPEC  || sock->info.af == ai_family);
+  int ai_family = sock->info.lsa->actual.ai_family;
 
+  ASSERT (sock->info.af == AF_UNSPEC  || sock->info.af == ai_family);
     
   if (ai_proto == IPPROTO_UDP)
     {
@@ -881,7 +880,8 @@ void
 socket_bind (socket_descriptor_t sd,
              struct addrinfo *local,
              int ai_family,
-	     const char *prefix)
+	     const char *prefix,
+             bool ipv6only)
 {
   struct gc_arena gc = gc_new ();
 
@@ -892,8 +892,11 @@ socket_bind (socket_descriptor_t sd,
    * What is the correct way to deal with it?
    */
   
-  ASSERT(local);
   struct addrinfo* cur;
+  int v6only= ipv6only ? 0: 1;
+  
+  ASSERT(local);
+ 
     
   /* find the first addrinfo with correct ai_family */
   for (cur = local; cur; cur=cur->ai_next)
@@ -904,7 +907,14 @@ socket_bind (socket_descriptor_t sd,
   if (!cur)
       msg (M_FATAL, "%s: Socket bind failed: Addr to bind has no %s record",
            prefix, addr_family_name(ai_family));
-    
+
+  if (ai_family == AF_INET6)
+    {
+      if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, &v6only, sizeof(v6only)))
+	{
+	  msg (M_NONFATAL|M_ERRNO, "Setting IPV6_V6ONLY failed");
+	}
+    }
   if (bind (sd, cur->ai_addr, cur->ai_addrlen))
     {
       const int errnum = openvpn_errno ();
@@ -1154,11 +1164,12 @@ static void bind_local (struct link_socket *sock)
 #ifdef ENABLE_SOCKS
         if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
             socket_bind (sock->ctrl_sd, sock->info.lsa->bind_local,
-                         sock->info.lsa->actual.ai_family, "SOCKS");
+                         sock->info.lsa->actual.ai_family, "SOCKS", false);
         else
 #endif
             socket_bind (sock->sd, sock->info.lsa->bind_local,
-                         sock->info.lsa->actual.ai_family,  "TCP/UDP");
+                         sock->info.lsa->actual.ai_family,
+                         "TCP/UDP", sock->info.bind_ipv6_only);
       }
 }
 
@@ -1295,11 +1306,12 @@ create_new_socket (struct link_socket* sock)
       resolve_bind_local (sock, sock->info.af);
   }
   resolve_remote (sock, 1, NULL, NULL);
+  
   /*
    * In P2P or server mode we must create the socket even when resolving
    * the remote site fails/is not specified. */
     
-  if (sock->info.af && sock->info.lsa->actual.ai_family==0 && sock->bind_local)
+  if (sock->info.lsa->actual.ai_family==0 && sock->bind_local)
     {
       /* Copy sock parameters from bind addr */
       set_actual_address (&sock->info.lsa->actual, sock->info.lsa->bind_local);
@@ -1310,7 +1322,7 @@ create_new_socket (struct link_socket* sock)
   /* 
    * Create the socket early if socket should be bound
    */
-  if (sock->bind_local && sock->info.lsa->actual.ai_family)
+  if (sock->bind_local)
     {
       create_socket (sock);
 
@@ -1328,7 +1340,8 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *remote_host,
 			 const char *remote_port,
 			 int proto,
-       sa_family_t af,
+			 sa_family_t af,
+			 bool bind_ipv6_only,
 			 int mode,
 			 const struct link_socket *accept_from,
 #ifdef ENABLE_HTTP_PROXY
@@ -1389,6 +1402,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->info.af = af;
   sock->info.remote_float = remote_float;
   sock->info.lsa = lsa;
+  sock->info.bind_ipv6_only = bind_ipv6_only;
   sock->info.ipchange_command = ipchange_command;
   sock->info.plugins = plugins;
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 528bdbd..75f2fa5 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -118,6 +118,7 @@ struct link_socket_info
   bool remote_float;  
   int proto;                    /* Protocol (PROTO_x defined below) */
   sa_family_t af;                       /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
+  bool bind_ipv6_only;
   int mtu_changed;              /* Set to true when mtu value is changed */
 };
 
@@ -289,7 +290,8 @@ struct link_socket *link_socket_new (void);
 void socket_bind (socket_descriptor_t sd,
 		  struct addrinfo *local,
                   int af_family,
-		  const char *prefix);
+		  const char *prefix,
+                  bool ipv6only);
 
 int openvpn_connect (socket_descriptor_t sd,
 		     const struct sockaddr *remote,
@@ -308,6 +310,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *remote_port,
 			 int proto,
        sa_family_t af,
+                         bool bind_ipv6_only,
 			 int mode,
 			 const struct link_socket *accept_from,
 #ifdef ENABLE_HTTP_PROXY
-- 
1.7.9.5


