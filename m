From: "James Yonan" <jim@...41...>
Message-ID: <twig.1090916738.94261@...41...>
In-Reply-To: <16645.47710.99350.917175@...253...>
Subject: [Openvpn-devel] Re: [PATCH - 1 of 4]  Set source address for UDP packets from multihomed server
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
Date: Tue Jul 27 01:26:11 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Brown <neilb@...253...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Neil,

Thanks for the patches... here are some comments:

* You've obviously put a lot of effort into understanding the code to write
this patch.  But did you consider any alternative approaches, such as starting
multiple OpenVPN instances and binding each to a separate local interface?

* A lot of function prototypes get changed so that both from and to
sockaddr_in pointers must be passed.  Do you think it might make more sense to
make a new struct that represents a bidirectional socketaddr_in and embed from
and to inside of it?  I'm mostly thinking about this from the angle of easing
future maintenance.  As much as is possible, I would like to see this patch
live in it's own location (probably a separate source file) and require a
minimal amount of modification of existing code.

* It would be nice to see the #ifdef IP_PKTINFO code (which appears to be
non-portable) isolated somewhere and bracketed inside of an internal API which
would make it easy for different cases to be implemented for different OSes.

* The change to link_socket_set_outgoing_addr is probably okay, though
remember that this is in the main line event loop, so efficiency is important
here.  Most of link_socket_set_outgoing_addr is structured around the fact
that a bunch of special things need to happen if the remote address changes,
but what similar kinds of things need to happen when the local address changes?

James

Neil Brown <neilb@...253...> said:

> 
> Hi.
>  This is the first of 4 patches that I would like to offer for
>  openvpn.
>  They are against 2.0_beta7.
> 
> This first one is a refinement of a patch I posted earlier which, at
> that time, didn't work.
> The purpose of the patch is to use the IP_PKTINFO socket option to get
> and set the local address for UDP packets being sent or received.
> This means that if you have a multihomed server, then packets sent to
> it will always come from the address that they corresponding packets
> were sent to.  This is needed to pass cleanly through a NAT.
> 
> In replaces "struct sockaddr_in from" in "struct context_2" with
>  struct sockaddr_in incoming_from, incoming_to
> and records the address provided by IP_PKTINFO in incoming_to.
> 
> It adds "struct sockaddr_in actuallocal" alongside "struct sockaddr_in
> actual" in  "struct lock_socket_addr", for storing the local enpoint
> if a udp "connection" in this structure.
> 
> It adds "struct sockaddr_in local_addr"  alongside "remote_addr" in 
> "struct key_state" for a similar purpose.
> 
> And it makes sure these fields are set and used appropriately.
> 
> The main reason that it didn't work before was that in
> multi_process_incoming_link, when the packet and address are
> transferred from the "mt" structure into the per-session context
> structure, I wasn't copying the incoming_to address as well.  I do now.
> 
> One part of the change that I am not completely happy with is
> +      /* alway set localaddr address */
> +      info->lsa->actuallocal = *localaddr;
> in link_socket_set_outgoing_addr.
> The current code only changes the outgoing address if it has changed,
> and it does that inside link_socket_connection_initiated.  However it
> is possible for the localaddress to change without the remote address
> changing.
> e.g. If I stop and restart my openvpn instance on my notebook, and it
> gets a different IP address via DNS lookup.  In this case it will
> appear to be a continuation of the same session, but will need to use
> a different local address.  I think it is OK to change the
> localaddress on every packet, but I am open to be convinced otherwise,
> or that the code could be cleaner.
> 
> Anyway, here is the patch.  I hope it can be included in an upcoming
> beta of openvpn.
> 
> Thanks,
> NeilBrown
> 
>  
> ============================================
> 
> ### Diffstat output
>  ./forward.c |   23 ++++++++++++--------
>  ./multi.c   |   10 +++++---
>  ./openvpn.h |    5 +++-
>  ./socket.c  |   46 ++++++++++++++++++++++++++++++++++++++++-
>  ./socket.h  |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
>  ./ssl.c     |   25 +++++++++++++++++-----
>  ./ssl.h     |    4 +++
>  7 files changed, 148 insertions(+), 32 deletions(-)
> 
> diff ./forward.c~current~ ./forward.c
> --- ./forward.c~current~	2004-07-09 19:56:34.000000000 +1000
> +++ ./forward.c	2004-07-26 14:02:07.000000000 +1000
> @@ -87,6 +87,7 @@ check_tls_dowork (struct context *c)
>      {
>        if (tls_multi_process
>  	  (c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
> +	   &c->c2.from_link_addr,
>  	   get_link_socket_info (c), &wakeup))
>  	{
>  	  update_time ();
> @@ -342,7 +343,7 @@ encrypt_sign (struct context *c, bool co
>     * Get the address we will be sending the packet to.
>     */
>    link_socket_get_outgoing_addr (&c->c2.buf, get_link_socket_info (c),
> -				 &c->c2.to_link_addr);
> +				 &c->c2.to_link_addr, &c->c2.from_link_addr);
>  #ifdef USE_CRYPTO
>  #ifdef USE_SSL
>    /*
> @@ -463,7 +464,7 @@ static inline void
>  socks_postprocess_incoming_link (struct context *c)
>  {
>    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto ==
PROTO_UDPv4)
> -    socks_process_incoming_udp (&c->c2.buf, &c->c2.from);
> +    socks_process_incoming_udp (&c->c2.buf, &c->c2.incoming_from);
>  }
>  
>  static inline void
> @@ -505,7 +506,8 @@ read_incoming_link (struct context *c)
>  
>    c->c2.buf = c->c2.buffers->read_link_buf;
>    ASSERT (buf_init (&c->c2.buf, FRAME_HEADROOM (&c->c2.frame)));
> -  status = link_socket_read (c->c2.link_socket, &c->c2.buf,
MAX_RW_SIZE_LINK (&c->c2.frame), &c->c2.from);
> +  status = link_socket_read (c->c2.link_socket, &c->c2.buf,
MAX_RW_SIZE_LINK (&c->c2.frame),
> +			     &c->c2.incoming_from, &c->c2.incoming_to);
>  
>    if (socket_connection_reset (c->c2.link_socket, status))
>      {
> @@ -561,7 +563,7 @@ process_incoming_link (struct context *c
>    msg (D_LINK_RW, "%s READ [%d] from %s: %s",
>         proto2ascii (lsi->proto, true),
>         BLEN (&c->c2.buf),
> -       print_sockaddr (&c->c2.from, &gc),
> +       print_sockaddr (&c->c2.incoming_from, &gc),
>         PROTO_DUMP (&c->c2.buf, &gc));
>  
>    /*
> @@ -573,8 +575,8 @@ process_incoming_link (struct context *c
>     */
>    if (c->c2.buf.len > 0)
>      {
> -      if (!link_socket_verify_incoming_addr (&c->c2.buf, lsi, &c->c2.from))
> -	link_socket_bad_incoming_addr (&c->c2.buf, lsi, &c->c2.from);
> +      if (!link_socket_verify_incoming_addr (&c->c2.buf, lsi,
&c->c2.incoming_from))
> +	link_socket_bad_incoming_addr (&c->c2.buf, lsi, &c->c2.incoming_from);
>  
>  #ifdef USE_CRYPTO
>  #ifdef USE_SSL
> @@ -591,7 +593,9 @@ process_incoming_link (struct context *c
>  	   * and return false.
>  	   */
>  	  //tls_mutex_lock (c->c2.tls_multi);
> -	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf,
&c->c2.crypto_options))
> +	  if (tls_pre_decrypt (c->c2.tls_multi,
> +			       &c->c2.incoming_from, &c->c2.incoming_to,
> +			       &c->c2.buf, &c->c2.crypto_options))
>  	    {
>  	      interval_action (&c->c2.tmp_int);
>  
> @@ -641,7 +645,7 @@ process_incoming_link (struct context *c
>         * Also, update the persisted version of our packet-id.
>         */
>        if (!TLS_MODE)
> -	link_socket_set_outgoing_addr (&c->c2.buf, lsi, &c->c2.from, NULL);
> +	link_socket_set_outgoing_addr (&c->c2.buf, lsi, &c->c2.incoming_from,
&c->c2.incoming_to, NULL);
>  
>        /* reset packet received timer */
>        if (c->options.ping_rec_timeout && c->c2.buf.len > 0)
> @@ -826,7 +830,8 @@ process_outgoing_link (struct context *c
>  	    socks_preprocess_outgoing_link (c, &to_addr, &size_delta);
>  
>  	    /* Send packet */
> -	    size = link_socket_write (c->c2.link_socket, &c->c2.to_link, to_addr);
> +	    size = link_socket_write (c->c2.link_socket, &c->c2.to_link, to_addr,
> +				      &c->c2.from_link_addr);
>  
>  	    /* Undo effect of prepend */
>  	    link_socket_write_post_size_adjust (&size, size_delta, &c->c2.to_link);
> 
> diff ./multi.c~current~ ./multi.c
> --- ./multi.c~current~	2004-07-26 14:36:28.000000000 +1000
> +++ ./multi.c	2004-07-26 14:36:35.000000000 +1000
> @@ -544,7 +544,7 @@ multi_get_create_instance (struct multi_
>    struct multi_instance *mi = NULL;
>    struct hash *hash = mt->multi->hash;
>  
> -  if (mroute_extract_sockaddr_in (&real, &mt->top.c2.from, true))
> +  if (mroute_extract_sockaddr_in (&real, &mt->top.c2.incoming_from, true))
>      {
>        struct hash_element *he;
>        const uint32_t hv = hash_value (hash, &real);
> @@ -560,7 +560,8 @@ multi_get_create_instance (struct multi_
>        else
>  	{
>  	  if (!mt->top.c2.tls_auth_standalone
> -	      || tls_pre_decrypt_lite (mt->top.c2.tls_auth_standalone,
&mt->top.c2.from, &mt->top.c2.buf))
> +	      || tls_pre_decrypt_lite (mt->top.c2.tls_auth_standalone,
> +				       &mt->top.c2.incoming_from, &mt->top.c2.incoming_to,
&mt->top.c2.buf))
>  	    {
>  	      if (frequency_limit_event_allowed (mt->multi->new_connection_limiter))
>  		{
> @@ -1330,8 +1331,9 @@ multi_process_incoming_link (struct mult
>        /* transfer packet pointer from top-level context buffer to instance */
>        c->c2.buf = mt->top.c2.buf;
>  
> -      /* transfer from-addr from top-level context buffer to instance */
> -      c->c2.from = mt->top.c2.from;
> +      /* transfer from-addr and to-addr from top-level context buffer to
instance */
> +      c->c2.incoming_from = mt->top.c2.incoming_from;
> +      c->c2.incoming_to = mt->top.c2.incoming_to;
>  
>        /* decrypt in instance context */
>        process_incoming_link (c);
> 
> diff ./openvpn.h~current~ ./openvpn.h
> --- ./openvpn.h~current~	2004-07-09 19:56:34.000000000 +1000
> +++ ./openvpn.h	2004-07-26 13:00:39.000000000 +1000
> @@ -167,7 +167,10 @@ struct context_2
>    const struct link_socket *accept_from; /* possibly do accept() on a
parent link_socket */
>  
>    struct sockaddr_in to_link_addr;	 /* IP address of remote */
> -  struct sockaddr_in from;               /* address of incoming datagram */
> +  struct sockaddr_in from_link_addr;	 /* Address to send messages from */
> +
> +  struct sockaddr_in incoming_from;      /* address of incoming datagram */
> +  struct sockaddr_in incoming_to;	 /* address incoming datagram was to */
>  
>    /* MTU frame parameters */
>    struct frame frame;
> 
> diff ./socket.c~current~ ./socket.c
> --- ./socket.c~current~	2004-07-09 19:56:34.000000000 +1000
> +++ ./socket.c	2004-07-27 11:41:34.000000000 +1000
> @@ -392,6 +392,12 @@ create_socket_udp (void)
>  
>    if ((sd = socket (PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
>      msg (M_SOCKERR, "UDP: Cannot create UDP socket");
> +#ifdef IP_PKTINFO
> +  else {
> +	  int pad = 1;
> +	  setsockopt(sd, SOL_IP, IP_PKTINFO, (void*)&pad, sizeof(pad));
> +  }
> +#endif
>    return sd;
>  }
>  
> @@ -1135,6 +1141,7 @@ void
>  link_socket_connection_initiated (const struct buffer *buf,
>  				  struct link_socket_info *info,
>  				  const struct sockaddr_in *addr,
> +				  const struct sockaddr_in *localaddr,
>  				  const char *common_name)
>  {
>    struct gc_arena gc = gc_new ();
> @@ -1143,6 +1150,7 @@ link_socket_connection_initiated (const 
>    mutex_lock_static (L_SCRIPT);
>  
>    info->lsa->actual = *addr; /* Note: skip this line for --force-dest */
> +  info->lsa->actuallocal = *localaddr;
>    setenv_trusted (info);
>    info->connection_established = true;
>  
> @@ -1582,13 +1590,49 @@ int
>  link_socket_read_udp_posix (struct link_socket *sock,
>  			    struct buffer *buf,
>  			    int maxsize,
> -			    struct sockaddr_in *from)
> +			    struct sockaddr_in *from,
> +			    struct sockaddr_in *to)
>  {
>    socklen_t fromlen = sizeof (*from);
>    CLEAR (*from);
> +  CLEAR (*to);
>    ASSERT (buf_safe (buf, maxsize));
> +#ifdef IP_PKTINFO
> +  {
> +    struct iovec iov;
> +    char b[sizeof(struct cmsghdr)+sizeof(struct in_pktinfo)];
> +    struct msghdr mesg;
> +    iov.iov_base = BPTR (buf);
> +    iov.iov_len = maxsize;
> +    mesg.msg_iov = &iov;
> +    mesg.msg_iovlen = 1;
> +    mesg.msg_name = from;
> +    mesg.msg_namelen = fromlen;
> +    mesg.msg_control = b;
> +    mesg.msg_controllen = sizeof(b);
> +    CLEAR(*to);
> +    buf->len = recvmsg (sock->sd, &mesg, 0);
> +    if (buf->len >= 0) 
> +     {
> +       struct cmsghdr *cmsg;
> +       fromlen = mesg.msg_namelen;
> +       cmsg = CMSG_FIRSTHDR (&mesg);
> +       if (cmsg != NULL
> +	   && CMSG_NXTHDR (&mesg, cmsg) == NULL
> +	   && cmsg->cmsg_level == SOL_IP 
> +	   && cmsg->cmsg_type == IP_PKTINFO
> +	   && cmsg->cmsg_len >= (sizeof (struct cmsghdr)
> +				 + sizeof (struct in_pktinfo))) 
> +        {
> +	       struct in_pktinfo *pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
> +	       to->sin_addr = pkti->ipi_addr;
> +        }
> +      }
> +  }
> +#else
>    buf->len = recvfrom (sock->sd, BPTR (buf), maxsize, 0,
>  		       (struct sockaddr *) from, &fromlen);
> +#endif
>    if (fromlen != sizeof (*from))
>      bad_address_length (fromlen, sizeof (*from));
>    return buf->len;
> 
> diff ./socket.h~current~ ./socket.h
> --- ./socket.h~current~	2004-07-09 19:56:34.000000000 +1000
> +++ ./socket.h	2004-07-27 11:40:04.000000000 +1000
> @@ -70,6 +70,7 @@ struct link_socket_addr
>    struct sockaddr_in local;
>    struct sockaddr_in remote; /* initial remote */
>    struct sockaddr_in actual; /* remote may change due to --float */
> +  struct sockaddr_in actuallocal; /* make sure we reply from  right address */
>  };
>  
>  struct link_socket_info
> @@ -273,6 +274,7 @@ in_addr_t link_socket_current_remote (co
>  void link_socket_connection_initiated (const struct buffer *buf,
>  				       struct link_socket_info *info,
>  				       const struct sockaddr_in *addr,
> +				       const struct sockaddr_in *localaddr,
>  				       const char *common_name);
>  
>  void link_socket_bad_incoming_addr (struct buffer *buf,
> @@ -443,7 +445,8 @@ link_socket_verify_incoming_addr (struct
>  static inline void
>  link_socket_get_outgoing_addr (struct buffer *buf,
>  			      const struct link_socket_info *info,
> -			      struct sockaddr_in *addr)
> +			      struct sockaddr_in *addr,
> +			      struct sockaddr_in *fromaddr)
>  {
>    if (buf->len > 0)
>      {
> @@ -453,6 +456,10 @@ link_socket_get_outgoing_addr (struct bu
>  	  addr->sin_family = lsa->actual.sin_family;
>  	  addr->sin_addr.s_addr = lsa->actual.sin_addr.s_addr;
>  	  addr->sin_port = lsa->actual.sin_port;
> +
> +	  fromaddr->sin_family = lsa->actuallocal.sin_family;
> +	  fromaddr->sin_addr.s_addr = lsa->actuallocal.sin_addr.s_addr;
> +	  fromaddr->sin_port = lsa->actuallocal.sin_port;
>  	}
>        else
>  	{
> @@ -466,6 +473,7 @@ static inline void
>  link_socket_set_outgoing_addr (const struct buffer *buf,
>  			       struct link_socket_info *info,
>  			       const struct sockaddr_in *addr,
> +			       const struct sockaddr_in *localaddr,
>  			       const char *common_name)
>  {
>    if (!buf || buf->len > 0)
> @@ -481,8 +489,10 @@ link_socket_set_outgoing_addr (const str
>  	      || addr_match_proto (addr, &lsa->remote, info->proto))
>  	  )
>  	{
> -	  link_socket_connection_initiated (buf, info, addr, common_name);
> +	  link_socket_connection_initiated (buf, info, addr, localaddr, common_name);
>  	}
> +      /* alway set localaddr address */
> +      info->lsa->actuallocal = *localaddr;
>      }
>  }
>  
> @@ -528,7 +538,8 @@ link_socket_read_udp_win32 (struct link_
>  int link_socket_read_udp_posix (struct link_socket *sock,
>  				struct buffer *buf,
>  				int maxsize,
> -				struct sockaddr_in *from);
> +				struct sockaddr_in *from,
> +				struct sockaddr_in *to);
>  
>  #endif
>  
> @@ -537,16 +548,17 @@ static inline int
>  link_socket_read (struct link_socket *sock,
>  		  struct buffer *buf,
>  		  int maxsize,
> -		  struct sockaddr_in *from)
> +		  struct sockaddr_in *from,
> +		  struct sockaddr_in *to)
>  {
>    if (sock->info.proto == PROTO_UDPv4)
>      {
>        int res;
> -
> +      CLEAR (*to);
>  #ifdef WIN32
>        res = link_socket_read_udp_win32 (sock, buf, from);
>  #else
> -      res = link_socket_read_udp_posix (sock, buf, maxsize, from);
> +      res = link_socket_read_udp_posix (sock, buf, maxsize, from, to);
>  #endif
>        return res;
>      }
> @@ -601,8 +613,39 @@ link_socket_write_win32 (struct link_soc
>  static inline int
>  link_socket_write_udp_posix (struct link_socket *sock,
>  			     struct buffer *buf,
> -			     struct sockaddr_in *to)
> +			     struct sockaddr_in *to,
> +			     struct sockaddr_in *from)
>  {
> +#ifdef IP_PKTINFO
> + if (addr_defined(from)) 
> +   {
> +     struct iovec iov;
> +     struct msghdr mesg;
> +     struct cmsghdr *cmsg;
> +     struct in_pktinfo *pkti;
> +
> +     char b[sizeof(struct cmsghdr)+sizeof(struct in_pktinfo)];
> +     iov.iov_base = BPTR (buf);
> +     iov.iov_len = BLEN (buf);
> +     mesg.msg_iov = &iov;
> +     mesg.msg_iovlen = 1;
> +     mesg.msg_name = to;
> +     mesg.msg_namelen = sizeof(*to);
> +     mesg.msg_control = b;
> +     mesg.msg_controllen = sizeof(b);
> +     mesg.msg_flags = 0;
> +     cmsg = CMSG_FIRSTHDR(&mesg);
> +     cmsg->cmsg_len = sizeof(b);
> +     cmsg->cmsg_level = SOL_IP;
> +     cmsg->cmsg_type = IP_PKTINFO;
> +     pkti = (struct in_pktinfo *)CMSG_DATA(cmsg);
> +     pkti->ipi_ifindex = 0;
> +     pkti->ipi_spec_dst = from->sin_addr;
> +     pkti->ipi_addr = from->sin_addr;
> +
> +     return sendmsg (sock->sd, &mesg, 0);
> +   }
> +#endif
>    return sendto (sock->sd, BPTR (buf), BLEN (buf), 0,
>  		 (struct sockaddr *) to,
>  		 (socklen_t) sizeof (*to));
> @@ -621,12 +664,13 @@ link_socket_write_tcp_posix (struct link
>  static inline int
>  link_socket_write_udp (struct link_socket *sock,
>  		       struct buffer *buf,
> -		       struct sockaddr_in *to)
> +		       struct sockaddr_in *to,
> +		       struct sockaddr_in *from)
>  {
>  #ifdef WIN32
>    return link_socket_write_win32 (sock, buf, to);
>  #else
> -  return link_socket_write_udp_posix (sock, buf, to);
> +  return link_socket_write_udp_posix (sock, buf, to, from);
>  #endif
>  }
>  
> @@ -634,11 +678,12 @@ link_socket_write_udp (struct link_socke
>  static inline int
>  link_socket_write (struct link_socket *sock,
>  		   struct buffer *buf,
> -		   struct sockaddr_in *to)
> +		   struct sockaddr_in *to,
> +		   struct sockaddr_in *from)
>  {
>    if (sock->info.proto == PROTO_UDPv4)
>      {
> -      return link_socket_write_udp (sock, buf, to);
> +      return link_socket_write_udp (sock, buf, to, from);
>      }
>    else if (sock->info.proto == PROTO_TCPv4_SERVER || sock->info.proto ==
PROTO_TCPv4_CLIENT)
>      {
> 
> diff ./ssl.c~current~ ./ssl.c
> --- ./ssl.c~current~	2004-07-09 19:56:34.000000000 +1000
> +++ ./ssl.c	2004-07-09 19:58:00.000000000 +1000
> @@ -1494,6 +1494,7 @@ write_control_auth (struct tls_session *
>  		    struct key_state *ks,
>  		    struct buffer *buf,
>  		    struct sockaddr_in *to_link_addr,
> +		    struct sockaddr_in *from_link_addr,
>  		    int opcode,
>  		    int max_ack,
>  		    bool prepend_ack)
> @@ -1514,6 +1515,7 @@ write_control_auth (struct tls_session *
>        ASSERT (swap_hmac (buf, &session->tls_auth, false));
>      }
>    *to_link_addr = ks->remote_addr;
> +  *from_link_addr = ks->local_addr;
>  }
>  
>  /*
> @@ -1916,6 +1918,7 @@ key_state_soft_reset (struct tls_session
>    key_state_init (session, ks);
>    ks->session_id_remote = ks_lame->session_id_remote;
>    ks->remote_addr = ks_lame->remote_addr;
> +  ks->local_addr = ks_lame->local_addr;
>  }
>  
>  /*
> @@ -1932,6 +1935,7 @@ tls_process (struct tls_multi *multi,
>  	     struct tls_session *session,
>  	     struct buffer *to_link,
>  	     struct sockaddr_in *to_link_addr,
> +	     struct sockaddr_in *from_link_addr,
>  	     struct link_socket_info *to_link_socket_info,
>  	     interval_t *wakeup)
>  {
> @@ -2052,7 +2056,8 @@ tls_process (struct tls_multi *multi,
>  		  INCR_SUCCESS;
>  
>  		  /* Set outgoing address for data channel packets */
> -		  link_socket_set_outgoing_addr (NULL, to_link_socket_info,
&ks->remote_addr, session->common_name);
> +		  link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->remote_addr,
> +						 &ks->local_addr, session->common_name);
>  
>  #ifdef MEASURE_TLS_HANDSHAKE_STATS
>  		  show_tls_performance_stats();
> @@ -2072,7 +2077,8 @@ tls_process (struct tls_multi *multi,
>  	      b = *buf;
>  	      INCR_SENT;
>  
> -	      write_control_auth (session, ks, &b, to_link_addr, opcode,
> +	      write_control_auth (session, ks, &b, to_link_addr, 
> +				  from_link_addr, opcode,
>  				  CONTROL_SEND_ACK_MAX, true);
>  	      *to_link = b;
>  	      active = true;
> @@ -2087,7 +2093,8 @@ tls_process (struct tls_multi *multi,
>  	    {
>  	      buf = &ks->ack_write_buf;
>  	      ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
> -	      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
> +	      write_control_auth (session, ks, buf, to_link_addr, from_link_addr,
> +				  P_ACK_V1,
>  				  RELIABLE_ACK_SIZE, false);
>  	      *to_link = *buf;
>  	      active = true;
> @@ -2391,7 +2398,7 @@ tls_process (struct tls_multi *multi,
>      {
>        buf = &ks->ack_write_buf;
>        ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
> -      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
> +      write_control_auth (session, ks, buf, to_link_addr, from_link_addr,
P_ACK_V1,
>  			  RELIABLE_ACK_SIZE, false);
>        *to_link = *buf;
>        active = true;
> @@ -2453,6 +2460,7 @@ bool
>  tls_multi_process (struct tls_multi *multi,
>  		   struct buffer *to_link,
>  		   struct sockaddr_in *to_link_addr,
> +		   struct sockaddr_in *from_link_addr,
>  		   struct link_socket_info *to_link_socket_info,
>  		   interval_t *wakeup)
>  {
> @@ -2473,8 +2481,10 @@ tls_multi_process (struct tls_multi *mul
>  
>        /* set initial remote address */
>        if (i == TM_ACTIVE && ks->state == S_INITIAL &&
> -	  addr_defined (&to_link_socket_info->lsa->actual))
> +	  addr_defined (&to_link_socket_info->lsa->actual)) {
>  	ks->remote_addr = to_link_socket_info->lsa->actual;
> +	ks->local_addr = to_link_socket_info->lsa->actuallocal;
> +      }
>  
>        msg (D_TLS_DEBUG,
>  	   "TLS: tls_multi_process: i=%d state=%s, mysid=%s, stored-sid=%s,
stored-ip=%s",
> @@ -2488,7 +2498,7 @@ tls_multi_process (struct tls_multi *mul
>  	{
>  	  update_time ();
>  
> -	  if (tls_process (multi, session, to_link, to_link_addr,
> +	  if (tls_process (multi, session, to_link, to_link_addr, from_link_addr,
>  			   to_link_socket_info, wakeup))
>  	    active = true;
>  
> @@ -2617,6 +2627,7 @@ tls_rec_payload (struct tls_multi *multi
>  bool
>  tls_pre_decrypt (struct tls_multi *multi,
>  		 struct sockaddr_in *from,
> +		 struct sockaddr_in *to,
>  		 struct buffer *buf,
>  		 struct crypto_options *opt)
>  {
> @@ -2919,6 +2930,7 @@ tls_pre_decrypt (struct tls_multi *multi
>  	      {
>  		ks->session_id_remote = sid;
>  		ks->remote_addr = *from;
> +		ks->local_addr = *to;
>  		++multi->n_sessions;
>  	      }
>  	    else if (!addr_port_match (&ks->remote_addr, from))
> @@ -3023,6 +3035,7 @@ tls_pre_decrypt (struct tls_multi *multi
>  bool
>  tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
>  		      const struct sockaddr_in *from,
> +		      const struct sockaddr_in *to,
>  		      const struct buffer *buf)
>  {
>    struct gc_arena gc = gc_new ();
> 
> diff ./ssl.h~current~ ./ssl.h
> --- ./ssl.h~current~	2004-07-09 19:56:34.000000000 +1000
> +++ ./ssl.h	2004-07-09 19:58:18.000000000 +1000
> @@ -236,6 +236,7 @@ struct key_state
>    int initial_opcode;		/* our initial P_ opcode */
>    struct session_id session_id_remote; /* peer's random session ID */
>    struct sockaddr_in remote_addr;      /* peer's IP addr */
> +  struct sockaddr_in local_addr;       /* address peer expects reply from */
>    struct packet_id packet_id;	       /* for data channel, to prevent replay
attacks */
>  
>    struct key_ctx_bi key;	       /* data channel keys for
encrypt/decrypt/hmac */
> @@ -456,6 +457,7 @@ void tls_multi_init_set_options(struct t
>  bool tls_multi_process (struct tls_multi *multi,
>  			struct buffer *to_link,
>  			struct sockaddr_in *to_link_addr,
> +			struct sockaddr_in *from_link_addr,
>  			struct link_socket_info *to_link_socket_info,
>  			interval_t *wakeup);
>  
> @@ -463,11 +465,13 @@ void tls_multi_free (struct tls_multi *m
>  
>  bool tls_pre_decrypt (struct tls_multi *multi,
>  		      struct sockaddr_in *from,
> +		      struct sockaddr_in *to,
>  		      struct buffer *buf,
>  		      struct crypto_options *opt);
>  
>  bool tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
>  			   const struct sockaddr_in *from,
> +			   const struct sockaddr_in *to,
>  			   const struct buffer *buf);
>  
>  void tls_pre_encrypt (struct tls_multi *multi,
> 
> 



-- 




