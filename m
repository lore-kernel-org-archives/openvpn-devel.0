From: David Sommerseth <davids@...515...>
Date: Fri, 26 Aug 2016 21:40:33 +0200
Message-Id: <1472240433-18269-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Get rid of proto_is_dgram() and
	link_socket_proto_connection_oriented()
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

Both of these where just wrapping proto_is_udp(), which is unnecessarily
complicating the code.  Kick them out and reduce the amount of wrapping.

Signed-off-by: David Sommerseth <davids@...515...>
Cc: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    | 14 +++++++-------
 src/openvpn/multi.c   |  6 +++---
 src/openvpn/occ.c     |  4 ++--
 src/openvpn/options.c |  4 ++--
 src/openvpn/socket.c  | 15 +++++----------
 src/openvpn/socket.h  | 23 ++++++++---------------
 6 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5b6d246..7fde708 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -105,7 +105,7 @@ update_options_ce_post (struct options *options)
    */
   if (options->pull
       && options->ping_rec_timeout_action == PING_UNDEF
-      && proto_is_dgram(options->ce.proto))
+      && proto_is_udp(options->ce.proto))
     {
       options->ping_rec_timeout = PRE_PULL_INITIAL_PING_RESTART;
       options->ping_rec_timeout_action = PING_RESTART;
@@ -2140,7 +2140,7 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
   if (options->replay)
     {
       packet_id_init (&c->c2.crypto_options.packet_id,
-		      link_socket_proto_connection_oriented (options->ce.proto),
+		      !proto_is_udp (options->ce.proto),  /* TCP mode? */
 		      options->replay_window,
 		      options->replay_time,
 		      "STATIC", 0);
@@ -2359,7 +2359,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.replay = options->replay;
   to.replay_window = options->replay_window;
   to.replay_time = options->replay_time;
-  to.tcp_mode = link_socket_proto_connection_oriented (options->ce.proto);
+  to.tcp_mode = !proto_is_udp (options->ce.proto);
   to.config_ciphername = c->c1.ciphername;
   to.config_authname = c->c1.authname;
   to.ncp_enabled = options->ncp_enabled;
@@ -3828,8 +3828,8 @@ inherit_context_child (struct context *dest,
 {
   CLEAR (*dest);
 
-  /* proto_is_dgram will ASSERT(0) if proto is invalid */
-  dest->mode = proto_is_dgram(src->options.ce.proto)? CM_CHILD_UDP : CM_CHILD_TCP;
+  /* proto_is_udp() will ASSERT(0) if proto is invalid */
+  dest->mode = proto_is_udp(src->options.ce.proto)? CM_CHILD_UDP : CM_CHILD_TCP;
 
   dest->gc = gc_new ();
 
@@ -3934,7 +3934,7 @@ inherit_context_top (struct context *dest,
   dest->c2.es_owned = false;
 
   dest->c2.event_set = NULL;
-  if (proto_is_dgram(src->options.ce.proto))
+  if (proto_is_udp(src->options.ce.proto))
     do_event_set_init (dest, false);
 
 #ifdef USE_COMP
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ba7f2c0..dd7940b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -2929,7 +2929,7 @@ multi_process_signal (struct multi_context *m)
       m->top.sig->signal_received = 0;
       return false;
     }
-  else if (proto_is_dgram(m->top.options.ce.proto) &&
+  else if (proto_is_udp(m->top.options.ce.proto) &&
       is_exit_restart(m->top.sig->signal_received) &&
       (m->deferred_shutdown_signal.signal_received == 0) &&
       m->top.options.ce.explicit_exit_notification != 0)
@@ -3202,7 +3202,7 @@ tunnel_server (struct context *top)
 {
   ASSERT (top->options.mode == MODE_SERVER);
 
-  if (proto_is_dgram(top->options.ce.proto))
+  if (proto_is_udp(top->options.ce.proto))
     tunnel_server_udp(top);
   else
     tunnel_server_tcp(top);
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index ff48706..9c5962c 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -375,7 +375,7 @@ process_received_occ_msg (struct context *c)
 	       c->c2.max_send_size_remote,
 	       c->c2.max_recv_size_local);
 	  if (!c->options.ce.fragment
-	      && (proto_is_dgram(c->options.ce.proto))
+	      && (proto_is_udp(c->options.ce.proto))
 	      && c->c2.max_send_size_local > TUN_MTU_MIN
 	      && (c->c2.max_recv_size_remote < c->c2.max_send_size_local
 		  || c->c2.max_recv_size_local < c->c2.max_send_size_remote))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e052042..058f7db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2013 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -2109,7 +2109,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--inetd cannot be used with --mode server");
       if (options->ipchange)
 	msg (M_USAGE, "--ipchange cannot be used with --mode server (use --client-connect instead)");
-      if (!(proto_is_dgram(ce->proto) || ce->proto == PROTO_TCP_SERVER))
+      if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
 	msg (M_USAGE, "--mode server currently only supports "
 	     "--proto udp or --proto tcp-server or --proto tcp6-server");
       if (!proto_is_udp(ce->proto) && (options->cf_max || options->cf_per))
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0ea4a3d..f29f595 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -215,7 +215,7 @@ do_preresolve (struct context *c)
 
       struct connection_entry* ce = c->options.connection_list->array[i];
 
-      if (proto_is_dgram(ce->proto))
+      if (proto_is_udp(ce->proto))
 	  flags |= GETADDR_DATAGRAM;
 
       if (c->options.sockflags & SF_HOST_RANDOMIZE)
@@ -1346,7 +1346,7 @@ resolve_bind_local (struct link_socket *sock, const sa_family_t af)
 	GETADDR_FATAL | GETADDR_PASSIVE;
       int status;
 
-      if(proto_is_dgram(sock->info.proto))
+      if(proto_is_udp(sock->info.proto))
 	flags |= GETADDR_DATAGRAM;
 
       /* will return AF_{INET|INET6}from local_host */
@@ -1388,7 +1388,7 @@ resolve_remote (struct link_socket *sock,
 	  int retry = 0;
 	  int status = -1;
 	  struct addrinfo* ai;
-	  if (proto_is_dgram(sock->info.proto))
+	  if (proto_is_udp(sock->info.proto))
 	    flags |= GETADDR_DATAGRAM;
 
 	  if (sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
@@ -2007,7 +2007,7 @@ link_socket_close (struct link_socket *sock)
 void
 socket_adjust_frame_parameters (struct frame *frame, int proto)
 {
-  if (link_socket_proto_connection_oriented (proto))
+  if (!proto_is_udp (proto))
     frame_add_to_extra_frame (frame, sizeof (packet_size_type));
 }
 
@@ -2694,11 +2694,6 @@ proto_is_net(int proto)
     ASSERT(0);
     return proto != PROTO_NONE;
 }
-bool
-proto_is_dgram(int proto)
-{
-    return proto_is_udp(proto);
-}
 
 bool
 proto_is_udp(int proto)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 66824c7..8113201 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -471,7 +471,6 @@ socket_descriptor_t socket_do_accept (socket_descriptor_t sd,
  * proto related
  */
 bool proto_is_net(int proto);
-bool proto_is_dgram(int proto);
 bool proto_is_udp(int proto);
 bool proto_is_tcp(int proto);
 
@@ -579,16 +578,10 @@ datagram_overhead (int proto)
  */
 
 static inline bool
-link_socket_proto_connection_oriented (int proto)
-{
-  return !proto_is_dgram(proto);
-}
-
-static inline bool
 link_socket_connection_oriented (const struct link_socket *sock)
 {
   if (sock)
-    return link_socket_proto_connection_oriented (sock->info.proto);
+    return !proto_is_udp (sock->info.proto);  /* TCP mode? */
   else
     return false;
 }
@@ -745,9 +738,9 @@ addr_match_proto (const struct openvpn_sockaddr *a1,
 		  const struct openvpn_sockaddr *a2,
 		  const int proto)
 {
-  return link_socket_proto_connection_oriented (proto)
-    ? addr_match (a1, a2)
-    : addr_port_match (a1, a2);
+  return proto_is_udp (proto)
+    ? addr_port_match (a1, a2)
+    : addr_match (a1, a2);
 }
 
 
@@ -756,9 +749,9 @@ addrlist_match_proto (const struct openvpn_sockaddr *a1,
 		      struct addrinfo *addr_list,
 		      const int proto)
 {
-  return link_socket_proto_connection_oriented (proto)
-    ? addrlist_match (a1, addr_list)
-    : addrlist_port_match (a1, addr_list);
+  return proto_is_udp (proto)
+    ? addrlist_port_match (a1, addr_list)
+    : addrlist_match (a1, addr_list);
 }
 
 static inline void
-- 
1.8.3.1


