From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <16622.28948.53644.813410@...253...>
Subject: [Openvpn-devel] Setting source address for UDP replies on multihomed server
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
Date: Fri Jul  9 03:20:13 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

My server that I hope to use as an OPENVPN server is multi-homed.
i.e. it has multiple network interfaces and multiple addresses on
multiple subnets.

When my openvpn client (on my notebook) tries to talk to it, it
sometimes gets a reply from a different IP address than it sent the
request to, and it doesn't like that.
This can be alleviated by using the --float option.  However that
isn't a complete solution.

When I try using openvpn from home, behind a NAT (masquerading) firewall,
the reply from a different IP address doesn't get back to me, as the
firewall doesn't know where to route those UDP packets.

The "correct" solution would be to have openvpn get the destination
address that was used for each incoming packet, record that, and set
is as the source address when sending a reply.

This is relatively easy to do (at least in Linux, possibly other POSIX
os's).  The code link_socket_read_udp_posix in the patch below
successfully gets the destination address, and the code added to 
link_socket_write_udp_posix sets the source address properly.
I have checked this by removing the "if (0)" in the latter function,
so the address is passed around in a global variable.

Where I am having trouble is in tracing the path that an address takes
when it is extract from an incoming packets, and then used to direct
an outgoing reply.  As you can see from the patch below, I have tried
to carry the extra address around various places, but I still haven't
got it to work.

I admit that the code as it is (apart from not working) is rather
ugly.  It would probably be best to define a new structure that
contains both the Local and Remote addresses, and pass that around as
necessary.  But first I would like to get it to work.

So my request is:
  What am I missing?  Where else to I need to pass around the
  local-endpoint address?

NeilBrown


### Diffstat output
 ./forward.c |   12 ++++++-----
 ./openvpn.h |    1 
 ./socket.c  |   45 +++++++++++++++++++++++++++++++++++++++++-
 ./socket.h  |   63 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 ./ssl.c     |   25 ++++++++++++++++++-----
 ./ssl.h     |    4 +++
 6 files changed, 127 insertions(+), 23 deletions(-)

diff ./forward.c~current~ ./forward.c
--- ./forward.c~current~	2004-07-09 19:56:34.000000000 +1000
+++ ./forward.c	2004-07-09 19:57:23.000000000 +1000
@@ -87,6 +87,7 @@ check_tls_dowork (struct context *c)
     {
       if (tls_multi_process
 	  (c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
+	   &c->c2.to,
 	   get_link_socket_info (c), &wakeup))
 	{
 	  update_time ();
@@ -342,7 +343,7 @@ encrypt_sign (struct context *c, bool co
    * Get the address we will be sending the packet to.
    */
   link_socket_get_outgoing_addr (&c->c2.buf, get_link_socket_info (c),
-				 &c->c2.to_link_addr);
+				 &c->c2.to_link_addr, &c->c2.to);
 #ifdef USE_CRYPTO
 #ifdef USE_SSL
   /*
@@ -505,7 +506,7 @@ read_incoming_link (struct context *c)
 
   c->c2.buf = c->c2.buffers->read_link_buf;
   ASSERT (buf_init (&c->c2.buf, FRAME_HEADROOM (&c->c2.frame)));
-  status = link_socket_read (c->c2.link_socket, &c->c2.buf, MAX_RW_SIZE_LINK (&c->c2.frame), &c->c2.from);
+  status = link_socket_read (c->c2.link_socket, &c->c2.buf, MAX_RW_SIZE_LINK (&c->c2.frame), &c->c2.from, &c->c2.to);
 
   if (socket_connection_reset (c->c2.link_socket, status))
     {
@@ -591,7 +592,7 @@ process_incoming_link (struct context *c
 	   * and return false.
 	   */
 	  //tls_mutex_lock (c->c2.tls_multi);
-	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &c->c2.crypto_options))
+	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.to, &c->c2.buf, &c->c2.crypto_options))
 	    {
 	      interval_action (&c->c2.tmp_int);
 
@@ -641,7 +642,7 @@ process_incoming_link (struct context *c
        * Also, update the persisted version of our packet-id.
        */
       if (!TLS_MODE)
-	link_socket_set_outgoing_addr (&c->c2.buf, lsi, &c->c2.from, NULL);
+	link_socket_set_outgoing_addr (&c->c2.buf, lsi, &c->c2.from, &c->c2.to, NULL);
 
       /* reset packet received timer */
       if (c->options.ping_rec_timeout && c->c2.buf.len > 0)
@@ -826,7 +827,8 @@ process_outgoing_link (struct context *c
 	    socks_preprocess_outgoing_link (c, &to_addr, &size_delta);
 
 	    /* Send packet */
-	    size = link_socket_write (c->c2.link_socket, &c->c2.to_link, to_addr);
+	    size = link_socket_write (c->c2.link_socket, &c->c2.to_link, to_addr,
+				      &c->c2.to);
 
 	    /* Undo effect of prepend */
 	    link_socket_write_post_size_adjust (&size, size_delta, &c->c2.to_link);

diff ./openvpn.h~current~ ./openvpn.h
--- ./openvpn.h~current~	2004-07-09 19:56:34.000000000 +1000
+++ ./openvpn.h	2004-07-09 19:56:34.000000000 +1000
@@ -168,6 +168,7 @@ struct context_2
 
   struct sockaddr_in to_link_addr;	 /* IP address of remote */
   struct sockaddr_in from;               /* address of incoming datagram */
+  struct sockaddr_in to;		 /* address incoming datagram was to */
 
   /* MTU frame parameters */
   struct frame frame;

diff ./socket.c~current~ ./socket.c
--- ./socket.c~current~	2004-07-09 19:56:34.000000000 +1000
+++ ./socket.c	2004-07-09 19:56:54.000000000 +1000
@@ -392,6 +392,12 @@ create_socket_udp (void)
 
   if ((sd = socket (PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
     msg (M_SOCKERR, "UDP: Cannot create UDP socket");
+#ifdef IP_PKTINFO
+  else {
+	  int pad = 1;
+	  setsockopt(sd, SOL_IP, IP_PKTINFO, (void*)&pad, sizeof(pad));
+  }
+#endif
   return sd;
 }
 
@@ -1135,6 +1141,7 @@ void
 link_socket_connection_initiated (const struct buffer *buf,
 				  struct link_socket_info *info,
 				  const struct sockaddr_in *addr,
+				  const struct sockaddr_in *localaddr,
 				  const char *common_name)
 {
   struct gc_arena gc = gc_new ();
@@ -1143,6 +1150,7 @@ link_socket_connection_initiated (const 
   mutex_lock_static (L_SCRIPT);
 
   info->lsa->actual = *addr; /* Note: skip this line for --force-dest */
+  info->lsa->actuallocal = *localaddr;
   setenv_trusted (info);
   info->connection_established = true;
 
@@ -1577,18 +1585,53 @@ link_socket_read_tcp (struct link_socket
 }
 
 #ifndef WIN32
+struct in_addr theaddr;
 
 int
 link_socket_read_udp_posix (struct link_socket *sock,
 			    struct buffer *buf,
 			    int maxsize,
-			    struct sockaddr_in *from)
+			    struct sockaddr_in *from,
+			    struct sockaddr_in *to)
 {
   socklen_t fromlen = sizeof (*from);
   CLEAR (*from);
+  CLEAR (*to);
   ASSERT (buf_safe (buf, maxsize));
+#ifdef IP_PKTINFO
+ {
+	 struct iovec iov;
+	 char b[sizeof(struct cmsghdr)+sizeof(struct in_pktinfo)];
+	 struct msghdr mesg;
+	 iov.iov_base = BPTR (buf);
+	 iov.iov_len = maxsize;
+	 mesg.msg_iov = &iov;
+	 mesg.msg_iovlen = 1;
+	 mesg.msg_name = from;
+	 mesg.msg_namelen = fromlen;
+	 mesg.msg_control = b;
+	 mesg.msg_controllen = sizeof(b);
+	 buf->len = recvmsg (sock->sd, &mesg, 0);
+	 if (buf->len >= 0) {
+		 struct cmsghdr *cmsg;
+		 fromlen = mesg.msg_namelen;
+		 cmsg = CMSG_FIRSTHDR (&mesg);
+		 if (cmsg != NULL
+		     && CMSG_NXTHDR (&mesg, cmsg) == NULL
+		     && cmsg->cmsg_level == SOL_IP 
+		     && cmsg->cmsg_type == IP_PKTINFO
+		     && cmsg->cmsg_len >= (sizeof (struct cmsghdr)
+					  + sizeof (struct in_pktinfo))) {
+			 struct in_pktinfo *pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
+			 to->sin_addr = pkti->ipi_addr;
+			 theaddr = pkti->ipi_addr;
+		 }
+	 }
+ }
+#else
   buf->len = recvfrom (sock->sd, BPTR (buf), maxsize, 0,
 		       (struct sockaddr *) from, &fromlen);
+#endif
   if (fromlen != sizeof (*from))
     bad_address_length (fromlen, sizeof (*from));
   return buf->len;

diff ./socket.h~current~ ./socket.h
--- ./socket.h~current~	2004-07-09 19:56:34.000000000 +1000
+++ ./socket.h	2004-07-09 19:56:58.000000000 +1000
@@ -70,6 +70,7 @@ struct link_socket_addr
   struct sockaddr_in local;
   struct sockaddr_in remote; /* initial remote */
   struct sockaddr_in actual; /* remote may change due to --float */
+  struct sockaddr_in actuallocal; /* make sure we reply from  right address */
 };
 
 struct link_socket_info
@@ -273,6 +274,7 @@ in_addr_t link_socket_current_remote (co
 void link_socket_connection_initiated (const struct buffer *buf,
 				       struct link_socket_info *info,
 				       const struct sockaddr_in *addr,
+				       const struct sockaddr_in *localaddr,
 				       const char *common_name);
 
 void link_socket_bad_incoming_addr (struct buffer *buf,
@@ -443,7 +445,8 @@ link_socket_verify_incoming_addr (struct
 static inline void
 link_socket_get_outgoing_addr (struct buffer *buf,
 			      const struct link_socket_info *info,
-			      struct sockaddr_in *addr)
+			      struct sockaddr_in *addr,
+			      struct sockaddr_in *fromaddr)
 {
   if (buf->len > 0)
     {
@@ -453,6 +456,7 @@ link_socket_get_outgoing_addr (struct bu
 	  addr->sin_family = lsa->actual.sin_family;
 	  addr->sin_addr.s_addr = lsa->actual.sin_addr.s_addr;
 	  addr->sin_port = lsa->actual.sin_port;
+	  *fromaddr = lsa->actuallocal;
 	}
       else
 	{
@@ -466,6 +470,7 @@ static inline void
 link_socket_set_outgoing_addr (const struct buffer *buf,
 			       struct link_socket_info *info,
 			       const struct sockaddr_in *addr,
+			       const struct sockaddr_in *localaddr,
 			       const char *common_name)
 {
   if (!buf || buf->len > 0)
@@ -481,7 +486,7 @@ link_socket_set_outgoing_addr (const str
 	      || addr_match_proto (addr, &lsa->remote, info->proto))
 	  )
 	{
-	  link_socket_connection_initiated (buf, info, addr, common_name);
+	  link_socket_connection_initiated (buf, info, addr, localaddr, common_name);
 	}
     }
 }
@@ -528,7 +533,8 @@ link_socket_read_udp_win32 (struct link_
 int link_socket_read_udp_posix (struct link_socket *sock,
 				struct buffer *buf,
 				int maxsize,
-				struct sockaddr_in *from);
+				struct sockaddr_in *from,
+				struct sockaddr_in *to);
 
 #endif
 
@@ -537,16 +543,17 @@ static inline int
 link_socket_read (struct link_socket *sock,
 		  struct buffer *buf,
 		  int maxsize,
-		  struct sockaddr_in *from)
+		  struct sockaddr_in *from,
+		  struct sockaddr_in *to)
 {
   if (sock->info.proto == PROTO_UDPv4)
     {
       int res;
-
+      CLEAR (*to);
 #ifdef WIN32
       res = link_socket_read_udp_win32 (sock, buf, from);
 #else
-      res = link_socket_read_udp_posix (sock, buf, maxsize, from);
+      res = link_socket_read_udp_posix (sock, buf, maxsize, from, to);
 #endif
       return res;
     }
@@ -601,11 +608,43 @@ link_socket_write_win32 (struct link_soc
 static inline int
 link_socket_write_udp_posix (struct link_socket *sock,
 			     struct buffer *buf,
-			     struct sockaddr_in *to)
+			     struct sockaddr_in *to,
+			     struct sockaddr_in *from)
 {
+#ifdef IP_PKTINFO
+	struct iovec iov;
+	struct msghdr mesg;
+	struct cmsghdr *cmsg;
+	struct in_pktinfo *pkti;
+
+	char b[sizeof(struct cmsghdr)+sizeof(struct in_pktinfo)];
+	iov.iov_base = BPTR (buf);
+	iov.iov_len = BLEN (buf);
+	mesg.msg_iov = &iov;
+	mesg.msg_iovlen = 1;
+	mesg.msg_name = to;
+	mesg.msg_namelen = sizeof(*to);
+	mesg.msg_control = b;
+	mesg.msg_controllen = sizeof(b);
+	mesg.msg_flags = 0;
+	cmsg = CMSG_FIRSTHDR(&mesg);
+	cmsg->cmsg_len = sizeof(b);
+	cmsg->cmsg_level = SOL_IP;
+	cmsg->cmsg_type = IP_PKTINFO;
+	pkti = (struct in_pktinfo *)CMSG_DATA(cmsg);
+	pkti->ipi_ifindex = 0;
+	pkti->ipi_spec_dst = from->sin_addr;
+	pkti->ipi_addr = from->sin_addr;
+if (0)	{ extern struct in_addr theaddr;
+	pkti->ipi_spec_dst = theaddr;
+	pkti->ipi_addr = theaddr;
+	}	
+	return sendmsg (sock->sd, &mesg, 0);
+#else
   return sendto (sock->sd, BPTR (buf), BLEN (buf), 0,
 		 (struct sockaddr *) to,
 		 (socklen_t) sizeof (*to));
+#endif
 }
 
 static inline int
@@ -621,12 +660,13 @@ link_socket_write_tcp_posix (struct link
 static inline int
 link_socket_write_udp (struct link_socket *sock,
 		       struct buffer *buf,
-		       struct sockaddr_in *to)
+		       struct sockaddr_in *to,
+		       struct sockaddr_in *from)
 {
 #ifdef WIN32
   return link_socket_write_win32 (sock, buf, to);
 #else
-  return link_socket_write_udp_posix (sock, buf, to);
+  return link_socket_write_udp_posix (sock, buf, to, from);
 #endif
 }
 
@@ -634,11 +674,12 @@ link_socket_write_udp (struct link_socke
 static inline int
 link_socket_write (struct link_socket *sock,
 		   struct buffer *buf,
-		   struct sockaddr_in *to)
+		   struct sockaddr_in *to,
+		   struct sockaddr_in *from)
 {
   if (sock->info.proto == PROTO_UDPv4)
     {
-      return link_socket_write_udp (sock, buf, to);
+      return link_socket_write_udp (sock, buf, to, from);
     }
   else if (sock->info.proto == PROTO_TCPv4_SERVER || sock->info.proto == PROTO_TCPv4_CLIENT)
     {

diff ./ssl.c~current~ ./ssl.c
--- ./ssl.c~current~	2004-07-09 19:56:34.000000000 +1000
+++ ./ssl.c	2004-07-09 19:58:00.000000000 +1000
@@ -1494,6 +1494,7 @@ write_control_auth (struct tls_session *
 		    struct key_state *ks,
 		    struct buffer *buf,
 		    struct sockaddr_in *to_link_addr,
+		    struct sockaddr_in *from_link_addr,
 		    int opcode,
 		    int max_ack,
 		    bool prepend_ack)
@@ -1514,6 +1515,7 @@ write_control_auth (struct tls_session *
       ASSERT (swap_hmac (buf, &session->tls_auth, false));
     }
   *to_link_addr = ks->remote_addr;
+  *from_link_addr = ks->local_addr;
 }
 
 /*
@@ -1916,6 +1918,7 @@ key_state_soft_reset (struct tls_session
   key_state_init (session, ks);
   ks->session_id_remote = ks_lame->session_id_remote;
   ks->remote_addr = ks_lame->remote_addr;
+  ks->local_addr = ks_lame->local_addr;
 }
 
 /*
@@ -1932,6 +1935,7 @@ tls_process (struct tls_multi *multi,
 	     struct tls_session *session,
 	     struct buffer *to_link,
 	     struct sockaddr_in *to_link_addr,
+	     struct sockaddr_in *from_link_addr,
 	     struct link_socket_info *to_link_socket_info,
 	     interval_t *wakeup)
 {
@@ -2052,7 +2056,8 @@ tls_process (struct tls_multi *multi,
 		  INCR_SUCCESS;
 
 		  /* Set outgoing address for data channel packets */
-		  link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->remote_addr, session->common_name);
+		  link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->remote_addr,
+						 &ks->local_addr, session->common_name);
 
 #ifdef MEASURE_TLS_HANDSHAKE_STATS
 		  show_tls_performance_stats();
@@ -2072,7 +2077,8 @@ tls_process (struct tls_multi *multi,
 	      b = *buf;
 	      INCR_SENT;
 
-	      write_control_auth (session, ks, &b, to_link_addr, opcode,
+	      write_control_auth (session, ks, &b, to_link_addr, 
+				  from_link_addr, opcode,
 				  CONTROL_SEND_ACK_MAX, true);
 	      *to_link = b;
 	      active = true;
@@ -2087,7 +2093,8 @@ tls_process (struct tls_multi *multi,
 	    {
 	      buf = &ks->ack_write_buf;
 	      ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
-	      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
+	      write_control_auth (session, ks, buf, to_link_addr, from_link_addr,
+				  P_ACK_V1,
 				  RELIABLE_ACK_SIZE, false);
 	      *to_link = *buf;
 	      active = true;
@@ -2391,7 +2398,7 @@ tls_process (struct tls_multi *multi,
     {
       buf = &ks->ack_write_buf;
       ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
-      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
+      write_control_auth (session, ks, buf, to_link_addr, from_link_addr, P_ACK_V1,
 			  RELIABLE_ACK_SIZE, false);
       *to_link = *buf;
       active = true;
@@ -2453,6 +2460,7 @@ bool
 tls_multi_process (struct tls_multi *multi,
 		   struct buffer *to_link,
 		   struct sockaddr_in *to_link_addr,
+		   struct sockaddr_in *from_link_addr,
 		   struct link_socket_info *to_link_socket_info,
 		   interval_t *wakeup)
 {
@@ -2473,8 +2481,10 @@ tls_multi_process (struct tls_multi *mul
 
       /* set initial remote address */
       if (i == TM_ACTIVE && ks->state == S_INITIAL &&
-	  addr_defined (&to_link_socket_info->lsa->actual))
+	  addr_defined (&to_link_socket_info->lsa->actual)) {
 	ks->remote_addr = to_link_socket_info->lsa->actual;
+	ks->local_addr = to_link_socket_info->lsa->actuallocal;
+      }
 
       msg (D_TLS_DEBUG,
 	   "TLS: tls_multi_process: i=%d state=%s, mysid=%s, stored-sid=%s, stored-ip=%s",
@@ -2488,7 +2498,7 @@ tls_multi_process (struct tls_multi *mul
 	{
 	  update_time ();
 
-	  if (tls_process (multi, session, to_link, to_link_addr,
+	  if (tls_process (multi, session, to_link, to_link_addr, from_link_addr,
 			   to_link_socket_info, wakeup))
 	    active = true;
 
@@ -2617,6 +2627,7 @@ tls_rec_payload (struct tls_multi *multi
 bool
 tls_pre_decrypt (struct tls_multi *multi,
 		 struct sockaddr_in *from,
+		 struct sockaddr_in *to,
 		 struct buffer *buf,
 		 struct crypto_options *opt)
 {
@@ -2919,6 +2930,7 @@ tls_pre_decrypt (struct tls_multi *multi
 	      {
 		ks->session_id_remote = sid;
 		ks->remote_addr = *from;
+		ks->local_addr = *to;
 		++multi->n_sessions;
 	      }
 	    else if (!addr_port_match (&ks->remote_addr, from))
@@ -3023,6 +3035,7 @@ tls_pre_decrypt (struct tls_multi *multi
 bool
 tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
 		      const struct sockaddr_in *from,
+		      const struct sockaddr_in *to,
 		      const struct buffer *buf)
 {
   struct gc_arena gc = gc_new ();

diff ./ssl.h~current~ ./ssl.h
--- ./ssl.h~current~	2004-07-09 19:56:34.000000000 +1000
+++ ./ssl.h	2004-07-09 19:58:18.000000000 +1000
@@ -236,6 +236,7 @@ struct key_state
   int initial_opcode;		/* our initial P_ opcode */
   struct session_id session_id_remote; /* peer's random session ID */
   struct sockaddr_in remote_addr;      /* peer's IP addr */
+  struct sockaddr_in local_addr;       /* address peer expects reply from */
   struct packet_id packet_id;	       /* for data channel, to prevent replay attacks */
 
   struct key_ctx_bi key;	       /* data channel keys for encrypt/decrypt/hmac */
@@ -456,6 +457,7 @@ void tls_multi_init_set_options(struct t
 bool tls_multi_process (struct tls_multi *multi,
 			struct buffer *to_link,
 			struct sockaddr_in *to_link_addr,
+			struct sockaddr_in *from_link_addr,
 			struct link_socket_info *to_link_socket_info,
 			interval_t *wakeup);
 
@@ -463,11 +465,13 @@ void tls_multi_free (struct tls_multi *m
 
 bool tls_pre_decrypt (struct tls_multi *multi,
 		      struct sockaddr_in *from,
+		      struct sockaddr_in *to,
 		      struct buffer *buf,
 		      struct crypto_options *opt);
 
 bool tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
 			   const struct sockaddr_in *from,
+			   const struct sockaddr_in *to,
 			   const struct buffer *buf);
 
 void tls_pre_encrypt (struct tls_multi *multi,

