MIME-Version: 1.0
References: <20221012133457.1927871-1-arne@...1227...>
In-Reply-To: <20221012133457.1927871-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 18 Oct 2022 14:32:41 +0300
Message-ID: <CAGyAFMWFyOa7J8X9a7iLe89MzUb0qEO6AHcC=4YzsjZaQ3sxzQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Move dco_installed from sock->info
 to sock->info.lsa.actual
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

NAK.

static inline int
link_socket_read_udp_win32(struct link_socket *sock,
                           struct buffer *buf,
                           struct link_socket_actual *from)
{
    sockethandle_t sh = { .s = sock->sd };
    if (sock->info.dco_installed)

2>C:\Users\lev\Projects\openvpn\src\openvpn\socket.h(1053,20): error
C2039: 'dco_installed': is not a member of 'link_socket_info'
2>C:\Users\lev\Projects\openvpn\src\openvpn\socket.h(114): message :
see declaration of 'link_socket_info'


ke 12. lokak. 2022 klo 16.35 Arne Schwabe (arne@...1227...) kirjoitti:
>
> For tcp this makes no difference as the remote address of the
> socket never changes. For udp this allows OpenVPN to differentiate
> if a reconnecting client is using the same address as before or
> from a different one. This allow sending via the normal userspace
> socket in that case.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/dco.c       | 7 ++++---
>  src/openvpn/dco_linux.c | 2 +-
>  src/openvpn/forward.c   | 8 ++++----
>  src/openvpn/init.c      | 2 +-
>  src/openvpn/mtcp.c      | 6 +++---
>  src/openvpn/socket.h    | 6 +++---
>  6 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index a76cdd0cd..1f402bfc2 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -448,7 +448,7 @@ dco_p2p_add_new_peer(struct context *c)
>      }
>
>      c->c2.tls_multi->dco_peer_added = true;
> -    c->c2.link_socket->info.dco_installed = true;
> +    c->c2.link_socket->info.lsa->actual.dco_installed = true;
>
>      return 0;
>  }
> @@ -522,7 +522,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
>  {
>      struct context *c = &mi->context;
>
> -    int peer_id = mi->context.c2.tls_multi->peer_id;
> +    int peer_id = c->c2.tls_multi->peer_id;
>      struct sockaddr *remoteaddr, *localaddr = NULL;
>      struct sockaddr_storage local = { 0 };
>      int sd = c->c2.link_socket->sd;
> @@ -531,6 +531,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
>      {
>          /* the remote address will be inferred from the TCP socket endpoint */
>          remoteaddr = NULL;
> +        c->c2.link_socket->info.lsa->actual.dco_installed = true;
>      }
>      else
>      {
> @@ -575,7 +576,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
>          {
>              msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
>          }
> -        c->c2.link_socket->info.dco_installed = true;
> +        c->c2.link_socket->info.lsa->actual.dco_installed = true;
>          c->c2.link_socket->sd = SOCKET_UNDEFINED;
>      }
>
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> index 98e10507b..109358205 100644
> --- a/src/openvpn/dco_linux.c
> +++ b/src/openvpn/dco_linux.c
> @@ -285,7 +285,7 @@ ovpn_nl_cb_finish(struct nl_msg (*msg) __attribute__ ((unused)), void *arg)
>   *
>   * We pass the error code to the user by means of a variable pointed by *arg
>   * (supplied by the user when setting this callback) and we parse the kernel
> - * reply to see if it contains a human readable error. If found, it is printed.
> + * reply to see if it contains a human-readable error. If found, it is printed.
>   */
>  static int
>  ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)),
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index bee24f0d4..18308c2c5 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1636,13 +1636,13 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
>   * standard Overlapped I/O.
>   *
>   * Hide that complexity (...especially if more platforms show up
> - * in future...) in a small inline function.
> + * in the future...) in a small inline function.
>   */
>  static inline bool
> -should_use_dco_socket(struct link_socket *sock)
> +should_use_dco_socket(struct link_socket_actual *actual)
>  {
>  #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
> -    return sock->info.dco_installed;
> +    return actual->dco_installed;
>  #else
>      return false;
>  #endif
> @@ -1721,7 +1721,7 @@ process_outgoing_link(struct context *c)
>                  socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
>
>                  /* Send packet */
> -                if (should_use_dco_socket(c->c2.link_socket))
> +                if (should_use_dco_socket(c->c2.to_link_addr))
>                  {
>                      size = dco_do_write(&c->c1.tuntap->dco,
>                                          c->c2.tls_multi->peer_id,
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 5141a35c2..351515aa2 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3625,7 +3625,7 @@ do_close_link_socket(struct context *c)
>       * closed in do_close_tun(). Set it to UNDEFINED so
>       * we won't use WinSock API to close it. */
>      if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket
> -        && c->c2.link_socket->info.dco_installed)
> +        && c->c2.link_socket->info.lsa->actual.dco_installed)
>      {
>          c->c2.link_socket->sd = SOCKET_UNDEFINED;
>      }
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index 1abb903f2..07da15a6d 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -402,7 +402,7 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
>
>      tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
>
> -    if (mi && mi->context.c2.link_socket->info.dco_installed)
> +    if (mi && mi->context.c2.link_socket->info.lsa->actual.dco_installed)
>      {
>          /* If we got a socket that has been handed over to the kernel
>           * we must not call the normal socket function to figure out
> @@ -537,7 +537,7 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
>
>          case TA_INITIAL:
>              ASSERT(mi);
> -            if (!mi->context.c2.link_socket->info.dco_installed)
> +            if (!mi->context.c2.link_socket->info.lsa->actual.dco_installed)
>              {
>                  multi_tcp_set_global_rw_flags(m, mi);
>              }
> @@ -590,7 +590,7 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
>              }
>              else
>              {
> -                if (!c->c2.link_socket->info.dco_installed)
> +                if (!c->c2.link_socket->info.lsa->actual.dco_installed)
>                  {
>                      multi_tcp_set_global_rw_flags(m, mi);
>                  }
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 462afa31b..11b37d005 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -88,6 +88,7 @@ struct link_socket_actual
>      /*int dummy;*/ /* add offset to force a bug if dest not explicitly dereferenced */
>
>      struct openvpn_sockaddr dest;
> +    bool dco_installed;
>  #if ENABLE_IP_PKTINFO
>      union {
>  #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
> @@ -121,7 +122,6 @@ struct link_socket_info
>      sa_family_t af;                     /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
>      bool bind_ipv6_only;
>      int mtu_changed;            /* Set to true when mtu value is changed */
> -    bool dco_installed;
>  };
>
>  /*
> @@ -1073,7 +1073,7 @@ link_socket_read(struct link_socket *sock,
>                   struct link_socket_actual *from)
>  {
>      if (proto_is_udp(sock->info.proto)
> -        || sock->info.dco_installed)
> +        || sock->info.lsa->actual.dco_installed)
>      /* unified UDPv4 and UDPv6, for DCO the kernel
>       * will strip the length header */
>      {
> @@ -1190,7 +1190,7 @@ link_socket_write(struct link_socket *sock,
>                    struct buffer *buf,
>                    struct link_socket_actual *to)
>  {
> -    if (proto_is_udp(sock->info.proto) || sock->info.dco_installed)
> +    if (proto_is_udp(sock->info.proto) || to->dco_installed)
>      {
>          /* unified UDPv4 and UDPv6 and DCO (kernel adds size header) */
>          return link_socket_write_udp(sock, buf, to);
> --
> 2.37.0 (Apple Git-136)
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

