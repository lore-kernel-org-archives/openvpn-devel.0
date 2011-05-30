Date: Mon, 30 May 2011 18:20:44 +0200
From: JuanJo <jjo+ml@...410...>
Message-ID: <20110530162036.GA11197@...1462...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] USE_PF_INET6 by default for v2.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...384...>

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

- put all #ifdef'd code in place, kill the cpp symbol,
- thus in v2.3 it's not actually possible to --disable-ipv6 :)

RATIONALE:
 #1 some wacky compilers choke on #ifdef'd constructions for
    concatenated strings, and given that:
 #2 v2.3 has already transport ipv6 by default
=3D> doesn't justify putting effort on #1 to keep USE_PF_INET6
   ifdef wraps.

Signed-off-by: JuanJo Ciarlante <jjo+ml@...410...>
---
 configure.ac |   14 ++------
 init.c       |   11 +-----
 mroute.c     |    2 -
 mtcp.c       |    2 -
 multi.c      |   14 -------
 options.c    |   80 +++++++++--------------------------------
 route.c      |    4 --
 socket.c     |  112 +++---------------------------------------------------=
---
 socket.h     |   35 ------------------
 syshead.h    |    4 +-
 10 files changed, 30 insertions(+), 248 deletions(-)

diff --git a/configure.ac b/configure.ac
index a3789d9..5024d6a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,12 +152,6 @@ AC_ARG_ENABLE(multihome,
    [MULTIHOME=3D"yes"]
 )
=20
-AC_ARG_ENABLE(ipv6,
-   [  --disable-ipv6          Disable UDP/IPv6 support],
-   [PF_INET6=3D"$enableval"],
-   [PF_INET6=3D"yes"]
-)
-
 AC_ARG_ENABLE(port-share,
    [  --disable-port-share    Disable TCP server port-share support (--por=
t-share)],
    [PORT_SHARE=3D"$enableval"],
@@ -579,14 +573,12 @@ AC_CHECK_FUNC(epoll_create, AC_DEFINE(HAVE_EPOLL_CREA=
TE, 1, [epoll_create functi
 LDFLAGS=3D"$OLDLDFLAGS"
=20
 dnl ipv6 support
-if test "$PF_INET6" =3D "yes"; then
-  AC_CHECKING([for struct sockaddr_in6 for IPv6 support])
-  AC_CHECK_TYPE(
+AC_CHECKING([for struct sockaddr_in6 for IPv6 support])
+AC_CHECK_TYPE(
       [struct sockaddr_in6],
-      [AC_DEFINE(USE_PF_INET6, 1, [struct sockaddr_in6 is needed for IPv6 =
peer support])],
       [],
+      [AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transp=
ort support.])],
       [#include "syshead.h"])
-fi
=20
 dnl
 dnl check for valgrind tool
diff --git a/init.c b/init.c
index 4a16fba..f1ec0d2 100644
--- a/init.c
+++ b/init.c
@@ -1745,22 +1745,16 @@ socket_restart_pause (struct context *c)
   switch (c->options.ce.proto)
     {
     case PROTO_UDPv4:
-#ifdef USE_PF_INET6
     case PROTO_UDPv6:
-#endif
       if (proxy)
 	sec =3D c->options.ce.connect_retry_seconds;
       break;
     case PROTO_TCPv4_SERVER:
-#ifdef USE_PF_INET6
     case PROTO_TCPv6_SERVER:
-#endif
       sec =3D 1;
       break;
     case PROTO_TCPv4_CLIENT:
-#ifdef USE_PF_INET6
     case PROTO_TCPv6_CLIENT:
-#endif
       sec =3D c->options.ce.connect_retry_seconds;
       break;
     }
@@ -3188,10 +3182,7 @@ init_instance (struct context *c, const struct env_s=
et *env, const unsigned int
      instances to inherit acceptable fds
      from a top-level parent */
   if (c->options.ce.proto =3D=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
-      || c->options.ce.proto =3D=3D PROTO_TCPv6_SERVER
-#endif
-     )
+      || c->options.ce.proto =3D=3D PROTO_TCPv6_SERVER)
     {
       if (c->mode =3D=3D CM_TOP)
 	link_socket_mode =3D LS_MODE_TCP_LISTEN;
diff --git a/mroute.c b/mroute.c
index c8e979a..285b151 100644
--- a/mroute.c
+++ b/mroute.c
@@ -287,7 +287,6 @@ bool mroute_extract_openvpn_sockaddr (struct mroute_add=
r *addr,
 	}
       return true;
     }
-#ifdef USE_PF_INET6
     case AF_INET6:
       if (use_port)
 	{
@@ -305,7 +304,6 @@ bool mroute_extract_openvpn_sockaddr (struct mroute_add=
r *addr,
 	  memcpy (addr->addr, &osaddr->addr.in6.sin6_addr, 16);
 	}
       return true;
-#endif
   }
   return false;
 }
diff --git a/mtcp.c b/mtcp.c
index ade2cfb..662cb9a 100644
--- a/mtcp.c
+++ b/mtcp.c
@@ -151,9 +151,7 @@ multi_tcp_instance_specific_init (struct multi_context =
*m, struct multi_instance
   ASSERT (mi->context.c2.link_socket->info.lsa);
   ASSERT (mi->context.c2.link_socket->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);
   ASSERT (mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_fam=
ily =3D=3D AF_INET
-#ifdef USE_PF_INET6
 	  || mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_family =
=3D=3D AF_INET6
-#endif
 	  );
   if (!mroute_extract_openvpn_sockaddr (&mi->real, &mi->context.c2.link_so=
cket->info.lsa->actual.dest, true))
     {
diff --git a/multi.c b/multi.c
index 15bea22..d8af530 100644
--- a/multi.c
+++ b/multi.c
@@ -2788,24 +2788,10 @@ tunnel_server (struct context *top)
 {
   ASSERT (top->options.mode =3D=3D MODE_SERVER);
=20
-#ifdef USE_PF_INET6
   if (proto_is_dgram(top->options.ce.proto))
     tunnel_server_udp(top);
   else
     tunnel_server_tcp(top);
-#else
-  switch (top->options.ce.proto)
-    {
-    case PROTO_UDPv4:
-      tunnel_server_udp (top);
-      break;
-    case PROTO_TCPv4_SERVER:
-      tunnel_server_tcp (top);
-      break;
-    default:
-      ASSERT (0);
-    }
-#endif
 }
=20
 #else
diff --git a/options.c b/options.c
index 169a8e8..cb66c55 100644
--- a/options.c
+++ b/options.c
@@ -83,9 +83,7 @@ const char title_string[] =3D
 #if ENABLE_IP_PKTINFO
   " [MH]"
 #endif
-#ifdef USE_PF_INET6
   " [PF_INET6]"
-#endif
   " [IPv6 payload 20110522-1 (2.2.0)]"
   " built on " __DATE__
 ;
@@ -109,9 +107,7 @@ static const char usage_message[] =3D
   "--proto p       : Use protocol p for communicating with peer.\n"
   "                  p =3D udp (default), tcp-server, or tcp-client\n"
   "--proto-force p : only consider protocol p in list of connection profil=
es.\n"
-#ifdef USE_PF_INET6
   "                  p =3D udp6, tcp6-server, or tcp6-client (ipv6)\n"
-#endif
   "--connect-retry n : For --proto tcp-client, number of seconds to wait\n"
   "                    between connection retries (default=3D%d).\n"
   "--connect-timeout n : For --proto tcp-client, connection timeout (in se=
conds).\n"
@@ -1900,26 +1896,14 @@ options_postprocess_verify_ce (const struct options=
 *options, const struct conne
    */
=20
   if (ce->connect_retry_defined && ce->proto !=3D PROTO_TCPv4_CLIENT
-#ifdef USE_PF_INET6
-      && ce->proto !=3D PROTO_TCPv6_CLIENT
-#endif
-      )
-    msg (M_USAGE, "--connect-retry doesn't make sense unless also used wit=
h --proto tcp-client"
-#ifdef USE_PF_INET6
-	 " or tcp6-client"
-#endif
-	 );
+      && ce->proto !=3D PROTO_TCPv6_CLIENT)
+    msg (M_USAGE, "--connect-retry doesn't make sense unless also used wit=
h "
+	 "--proto tcp-client or tcp6-client");
=20
   if (ce->connect_timeout_defined && ce->proto !=3D PROTO_TCPv4_CLIENT
-#ifdef USE_PF_INET6
-      && ce->proto !=3D PROTO_TCPv6_CLIENT
-#endif
-      )
-    msg (M_USAGE, "--connect-timeout doesn't make sense unless also used w=
ith --proto tcp-client"
-#ifdef USE_PF_INET6
-	 " or tcp6-client"
-#endif
-	 );
+      && ce->proto !=3D PROTO_TCPv6_CLIENT)
+    msg (M_USAGE, "--connect-timeout doesn't make sense unless also used w=
ith "
+	 "--proto tcp-client or tcp6-client");
=20
   /*
    * Sanity check on MTU parameters
@@ -2017,10 +2001,7 @@ options_postprocess_verify_ce (const struct options =
*options, const struct conne
 #endif
=20
   if (!ce->remote && (ce->proto =3D=3D PROTO_TCPv4_CLIENT=20
-#ifdef USE_PF_INET6
-		      || ce->proto =3D=3D PROTO_TCPv6_CLIENT
-#endif
-		      ))
+		      || ce->proto =3D=3D PROTO_TCPv6_CLIENT))
     msg (M_USAGE, "--remote MUST be used in TCP Client mode");
=20
 #ifdef ENABLE_HTTP_PROXY
@@ -2038,12 +2019,8 @@ options_postprocess_verify_ce (const struct options =
*options, const struct conne
     msg (M_USAGE, "--socks-proxy can not be used in TCP Server mode");
 #endif
=20
-  if ((ce->proto =3D=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
-       || ce->proto =3D=3D PROTO_TCPv6_SERVER
-#endif
-       )
-       && connection_list_defined (options))
+  if ((ce->proto =3D=3D PROTO_TCPv4_SERVER || ce->proto =3D=3D PROTO_TCPv6=
_SERVER)
+      && connection_list_defined (options))
     msg (M_USAGE, "TCP server mode allows at most one --remote address");
=20
 #if P2MP_SERVER
@@ -2058,27 +2035,14 @@ options_postprocess_verify_ce (const struct options=
 *options, const struct conne
       if (options->pull)
 	msg (M_USAGE, "--pull cannot be used with --mode server");
       if (!(proto_is_udp(ce->proto) || ce->proto =3D=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
-	    || ce->proto =3D=3D PROTO_TCPv6_SERVER
-#endif
-	    ))
-	msg (M_USAGE, "--mode server currently only supports --proto udp or --pro=
to tcp-server"
-#ifdef USE_PF_INET6
-	    " or proto tcp6-server"
-#endif
-	     );
+	    || ce->proto =3D=3D PROTO_TCPv6_SERVER))
+	msg (M_USAGE, "--mode server currently only supports "
+	     "--proto udp or --proto tcp-server or proto tcp6-server");
 #if PORT_SHARE
       if ((options->port_share_host || options->port_share_port) &&=20
-            (ce->proto !=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
-	     && ce->proto !=3D PROTO_TCPv6_SERVER
-#endif
-	     ))
-	msg (M_USAGE, "--port-share only works in TCP server mode (--proto tcp-se=
rver"
-#ifdef USE_PF_INET6
-	     " or tcp6-server"
-#endif
-	  ")");
+	  (ce->proto !=3D PROTO_TCPv4_SERVER && ce->proto !=3D PROTO_TCPv6_SERVER=
))
+	msg (M_USAGE, "--port-share only works in TCP server mode "
+	     "(--proto tcp-server or tcp6-server)");
 #endif
       if (!options->tls_server)
 	msg (M_USAGE, "--mode server requires --tls-server");
@@ -2109,15 +2073,9 @@ options_postprocess_verify_ce (const struct options =
*options, const struct conne
       if (options->ipchange)
 	msg (M_USAGE, "--ipchange cannot be used with --mode server (use --client=
-connect instead)");
       if (!(proto_is_dgram(ce->proto) || ce->proto =3D=3D PROTO_TCPv4_SERV=
ER
-#ifdef USE_PF_INET6
-	    || ce->proto =3D=3D PROTO_TCPv6_SERVER
-#endif
-	    ))
-	msg (M_USAGE, "--mode server currently only supports --proto udp or --pro=
to tcp-server"
-#ifdef USE_PF_INET6
-	    " or --proto tcp6-server"
-#endif
-	     );
+	    || ce->proto =3D=3D PROTO_TCPv6_SERVER))
+	msg (M_USAGE, "--mode server currently only supports "
+	     "--proto udp or --proto tcp-server or --proto tcp6-server");
       if (!proto_is_udp(ce->proto) && (options->cf_max || options->cf_per))
 	msg (M_USAGE, "--connect-freq only works with --mode server --proto udp. =
 Try --max-clients instead.");
       if (!(dev =3D=3D DEV_TYPE_TAP || (dev =3D=3D DEV_TYPE_TUN && options=
->topology =3D=3D TOP_SUBNET)) && options->ifconfig_pool_netmask)
@@ -2389,10 +2347,8 @@ options_postprocess_mutate_ce (struct options *o, st=
ruct connection_entry *ce)
     {
       if (ce->proto =3D=3D PROTO_TCPv4)
 	ce->proto =3D PROTO_TCPv4_CLIENT;
-#ifdef USE_PF_INET6
       else if (ce->proto =3D=3D PROTO_TCPv6)
 	ce->proto =3D PROTO_TCPv6_CLIENT;
-#endif
     }
 #endif
=20
diff --git a/route.c b/route.c
index 96596cd..ba879b5 100644
--- a/route.c
+++ b/route.c
@@ -754,11 +754,9 @@ redirect_default_route_to_vpn (struct route_list *rl, =
const struct tuntap *tt, u
 	  if (!local)
 	    {
 	      /* route remote host to original default gateway */
-#ifdef USE_PF_INET6
 	      /* if remote_host is not ipv4 (ie: ipv6), just skip
 	       * adding this special /32 route */
 	      if (rl->spec.remote_host !=3D IPV4_INVALID_ADDR) {
-#endif
 		add_route3 (rl->spec.remote_host,
 			    ~0,
 			    rl->spec.net_gateway,
@@ -766,11 +764,9 @@ redirect_default_route_to_vpn (struct route_list *rl, =
const struct tuntap *tt, u
 			    flags,
 			    es);
 		rl->did_local =3D true;
-#ifdef USE_PF_INET6
 	      } else {
 		dmsg (D_ROUTE, "ROUTE remote_host protocol differs from tunneled");
 	      }
-#endif
 	    }
=20
 	  /* route DHCP/DNS server traffic through original default gateway */
diff --git a/socket.c b/socket.c
index 6b855c0..c8ccac6 100644
--- a/socket.c
+++ b/socket.c
@@ -40,12 +40,10 @@ const int proto_overhead[] =3D { /* indexed by PROTO_x =
*/
   IPv4_UDP_HEADER_SIZE, /* IPv4 */
   IPv4_TCP_HEADER_SIZE,
   IPv4_TCP_HEADER_SIZE,
-#ifdef USE_PF_INET6
   IPv6_UDP_HEADER_SIZE, /* IPv6 */
   IPv6_TCP_HEADER_SIZE,
   IPv6_TCP_HEADER_SIZE,
   IPv6_TCP_HEADER_SIZE,
-#endif
 };
=20
 /*
@@ -282,7 +280,6 @@ getaddr_multi (unsigned int flags,
   return (flags & GETADDR_HOST_ORDER) ? ntohl (ia.s_addr) : ia.s_addr;
 }
=20
-#ifdef USE_PF_INET6
 /*
  * Translate IPv6 addr or hostname into struct addrinfo
  * If resolve error, try again for
@@ -475,7 +472,6 @@ getaddr6 (unsigned int flags,
   gc_free (&gc);
   return success;
 }
-#endif /* USE_PF_INET6 */
=20
 /*
  * We do our own inet_aton because the glibc function
@@ -647,7 +643,6 @@ update_remote (const char* host,
 	    }
 	}
       break;
-#ifdef USE_PF_INET6
     case AF_INET6:
       if (host && addr)
         {
@@ -672,7 +667,6 @@ update_remote (const char* host,
             }
         }
       break;
-#endif
     default:
         ASSERT(0);
   }
@@ -878,7 +872,6 @@ create_socket_udp (const unsigned int flags)
   return sd;
 }
=20
-#ifdef USE_PF_INET6
 static socket_descriptor_t
 create_socket_udp6 (const unsigned int flags)
 {
@@ -917,7 +910,6 @@ create_socket_tcp6 (void)
   return sd;
 }
=20
-#endif
 static void
 create_socket (struct link_socket *sock)
 {
@@ -937,7 +929,6 @@ create_socket (struct link_socket *sock)
     {
       sock->sd =3D create_socket_tcp ();
     }
-#ifdef USE_PF_INET6
   else if (sock->info.proto =3D=3D PROTO_TCPv6_SERVER
 	   || sock->info.proto =3D=3D PROTO_TCPv6_CLIENT)
     {
@@ -948,7 +939,6 @@ create_socket (struct link_socket *sock)
       sock->sd =3D create_socket_udp6 (sock->sockflags);
       sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
     }
-#endif
   else
     {
       ASSERT (0);
@@ -1287,19 +1277,15 @@ socket_connect (socket_descriptor_t *sd,
       if (*signal_received)
 	goto done;
=20
-#ifdef USE_PF_INET6
       switch(local->addr.sa.sa_family)
 	{
 	case PF_INET6:
 	  *sd =3D create_socket_tcp6 ();
 	  break;
 	case PF_INET:
-#endif
 	  *sd =3D create_socket_tcp ();
-#ifdef USE_PF_INET6
 	  break;
 	}
-#endif
=20
       if (bind_local)
         socket_bind (*sd, local, "TCP Client");
@@ -1365,12 +1351,10 @@ resolve_bind_local (struct link_socket *sock)
   /* resolve local address if undefined */
   if (!addr_defined (&sock->info.lsa->local))
     {
-#ifdef USE_PF_INET6
       /* may return AF_{INET|INET6} guessed from local_host */
       switch(addr_guess_family(sock->info.proto, sock->local_host))
 	{
 	case AF_INET:
-#endif
 	  sock->info.lsa->local.addr.in4.sin_family =3D AF_INET;
 	  sock->info.lsa->local.addr.in4.sin_addr.s_addr =3D
 	    (sock->local_host ? getaddr (GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL=
 | GETADDR_FATAL,
@@ -1380,7 +1364,6 @@ resolve_bind_local (struct link_socket *sock)
 					 NULL)
 	     : htonl (INADDR_ANY));
 	  sock->info.lsa->local.addr.in4.sin_port =3D htons (sock->local_port);
-#ifdef USE_PF_INET6
 	  break;
 	case AF_INET6:
 	    {
@@ -1412,7 +1395,6 @@ resolve_bind_local (struct link_socket *sock)
 	    }
 	  break;
 	}
-#endif /* USE_PF_INET6 */
     }
=20=20=20
   /* bind to local address/port */
@@ -1435,24 +1417,19 @@ resolve_remote (struct link_socket *sock,
 		volatile int *signal_received)
 {
   struct gc_arena gc =3D gc_new ();
-#ifdef USE_PF_INET6
   int af;
-#endif
=20
   if (!sock->did_resolve_remote)
     {
       /* resolve remote address if undefined */
       if (!addr_defined (&sock->info.lsa->remote))
 	{
-#ifdef USE_PF_INET6
           af =3D addr_guess_family(sock->info.proto, sock->remote_host);
           switch(af)
             {
               case AF_INET:
-#endif
                 sock->info.lsa->remote.addr.in4.sin_family =3D AF_INET;
                 sock->info.lsa->remote.addr.in4.sin_addr.s_addr =3D 0;
-#ifdef USE_PF_INET6
                 break;
               case AF_INET6:
                 CLEAR(sock->info.lsa->remote.addr.in6);
@@ -1460,7 +1437,6 @@ resolve_remote (struct link_socket *sock,
                 sock->info.lsa->remote.addr.in6.sin6_addr =3D in6addr_any;
                 break;
             }
-#endif
=20
 	  if (sock->remote_host)
 	    {
@@ -1503,18 +1479,15 @@ resolve_remote (struct link_socket *sock,
 		  ASSERT (0);
 		}
=20
-#ifdef USE_PF_INET6
               switch(af)
                 {
                   case AF_INET:
-#endif
                     sock->info.lsa->remote.addr.in4.sin_addr.s_addr =3D ge=
taddr (
                           flags,
                           sock->remote_host,
                           retry,
                           &status,
                           signal_received);
-#ifdef USE_PF_INET6
                     break;
                   case AF_INET6:
                     status =3D getaddr6 (
@@ -1526,7 +1499,6 @@ resolve_remote (struct link_socket *sock,
                         &sock->info.lsa->remote.addr.in6);
                     break;
                 }
-#endif
=20
 	      dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=3D0x%04x phase=3D%d rrs=
=3D%d sig=3D%d status=3D%d",
 		   flags,
@@ -1547,19 +1519,15 @@ resolve_remote (struct link_socket *sock,
 		  goto done;
 		}
 	    }
-#ifdef USE_PF_INET6
           switch(af)
             {
               case AF_INET:
-#endif
                 sock->info.lsa->remote.addr.in4.sin_port =3D htons (sock->=
remote_port);
-#ifdef USE_PF_INET6
                 break;
               case AF_INET6:
                 sock->info.lsa->remote.addr.in6.sin6_port =3D htons (sock-=
>remote_port);
                 break;
             }
-#endif
 	}
=20=20=20
       /* should we re-use previous active remote address? */
@@ -1677,9 +1645,7 @@ link_socket_init_phase1 (struct link_socket *sock,
     {
       ASSERT (accept_from);
       ASSERT (sock->info.proto =3D=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
 	      || sock->info.proto =3D=3D PROTO_TCPv6_SERVER
-#endif
 	     );
       ASSERT (!sock->inetd);
       sock->sd =3D accept_from->sd;
@@ -1738,10 +1704,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   if (sock->inetd)
     {
       ASSERT (sock->info.proto !=3D PROTO_TCPv4_CLIENT
-#ifdef USE_PF_INET6
-	      && sock->info.proto !=3D PROTO_TCPv6_CLIENT
-#endif
-      );
+	      && sock->info.proto !=3D PROTO_TCPv6_CLIENT);
       ASSERT (socket_defined (inetd_socket_descriptor));
       sock->sd =3D inetd_socket_descriptor;
     }
@@ -1791,13 +1754,9 @@ link_socket_init_phase2 (struct link_socket *sock,
   if (sock->inetd)
     {
       if (sock->info.proto =3D=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
-	  || sock->info.proto =3D=3D PROTO_TCPv6_SERVER
-#endif
-      ) {
+	  || sock->info.proto =3D=3D PROTO_TCPv6_SERVER) {
 	/* AF_INET as default (and fallback) for inetd */
 	sock->info.lsa->actual.dest.addr.sa.sa_family =3D AF_INET;
-#ifdef USE_PF_INET6
 #ifdef HAVE_GETSOCKNAME
 	  {
 	    /* inetd: hint family type for dest =3D local's */
@@ -1817,7 +1776,6 @@ link_socket_init_phase2 (struct link_socket *sock,
 	     "function, using AF_INET",
 	     proto2ascii(sock->info.proto, false));
 #endif
-#endif
 	sock->sd =3D
 	  socket_listen_accept (sock->sd,
 				&sock->info.lsa->actual,
@@ -1841,10 +1799,7 @@ link_socket_init_phase2 (struct link_socket *sock,
=20
       /* TCP client/server */
       if (sock->info.proto =3D=3D PROTO_TCPv4_SERVER
-#ifdef USE_PF_INET6
-	  ||sock->info.proto =3D=3D PROTO_TCPv6_SERVER
-#endif
-	)
+	  ||sock->info.proto =3D=3D PROTO_TCPv6_SERVER)
 	{
 	  switch (sock->mode)
 	    {
@@ -1880,10 +1835,7 @@ link_socket_init_phase2 (struct link_socket *sock,
 	    }
 	}
       else if (sock->info.proto =3D=3D PROTO_TCPv4_CLIENT
-#ifdef USE_PF_INET6
-               ||sock->info.proto =3D=3D PROTO_TCPv6_CLIENT
-#endif
-              )
+	       ||sock->info.proto =3D=3D PROTO_TCPv6_CLIENT)
 	{
=20
 #ifdef GENERAL_PROXY_SUPPORT
@@ -2179,9 +2131,7 @@ link_socket_bad_incoming_addr (struct buffer *buf,
   switch(from_addr->dest.addr.sa.sa_family)
     {
     case AF_INET:
-#ifdef USE_PF_INET6
     case AF_INET6:
-#endif
       msg (D_LINK_ERRORS,
 	   "TCP/UDP: Incoming packet rejected from %s[%d], expected peer address:=
 %s (allow this incoming source address/port by removing --remote or adding=
 --float)",
 	   print_link_socket_actual (from_addr, &gc),
@@ -2212,12 +2162,8 @@ link_socket_current_remote (const struct link_socket=
_info *info)
  * by now just ignore it
  *
  */
-#ifdef USE_PF_INET6
   if (lsa->actual.dest.addr.sa.sa_family !=3D AF_INET)
     return IPV4_INVALID_ADDR;
-#else
-  ASSERT (lsa->actual.dest.addr.sa.sa_family =3D=3D AF_INET);
-#endif
=20
   if (link_socket_actual_defined (&lsa->actual))
     return ntohl (lsa->actual.dest.addr.in4.sin_addr.s_addr);
@@ -2455,11 +2401,9 @@ print_sockaddr_ex (const struct openvpn_sockaddr *ad=
dr,
   if (!addr_is_defined) {
     return "[undef]";
   }
-#ifdef USE_PF_INET6
   switch(addr->addr.sa.sa_family)
     {
     case AF_INET:
-#endif
 	{
 	  const int port=3D ntohs (addr->addr.in4.sin_port);
 	  buf_puts (&out, "[AF_INET]");
@@ -2476,7 +2420,6 @@ print_sockaddr_ex (const struct openvpn_sockaddr *add=
r,
 	      buf_printf (&out, "%d", port);
 	    }
 	}
-#ifdef USE_PF_INET6
       break;
     case AF_INET6:
 	{
@@ -2502,7 +2445,6 @@ print_sockaddr_ex (const struct openvpn_sockaddr *add=
r,
     default:
       ASSERT(0);
     }
-#endif
   return BSTR (&out);
 }
=20
@@ -2530,11 +2472,9 @@ print_link_socket_actual_ex (const struct link_socke=
t_actual *act,
 #if ENABLE_IP_PKTINFO
       if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
 	{
-#ifdef USE_PF_INET6
 	  switch(act->dest.addr.sa.sa_family)
 	    {
 	    case AF_INET:
-#endif
 		{
 		  struct openvpn_sockaddr sa;
 		  CLEAR (sa);
@@ -2552,7 +2492,6 @@ print_link_socket_actual_ex (const struct link_socket=
_actual *act,
 			      print_sockaddr_ex (&sa, separator, 0, gc),
 			      ifname);
 		}
-#ifdef USE_PF_INET6
 	      break;
 	    case AF_INET6:
 		{
@@ -2570,8 +2509,6 @@ print_link_socket_actual_ex (const struct link_socket=
_actual *act,
 		}
 	      break;
 	    }
-#endif /* USE_PF_INET6 */
-
 	}
 #endif
       return BSTR (&out);
@@ -2655,12 +2592,10 @@ setenv_sockaddr (struct env_set *es, const char *na=
me_prefix, const struct openv
 {
   char name_buf[256];
=20
-#ifdef USE_PF_INET6
   char buf[128];
   switch(addr->addr.sa.sa_family)
     {
     case AF_INET:
-#endif
       if (flags & SA_IP_PORT)
 	openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip", name_prefix);
       else
@@ -2673,7 +2608,6 @@ setenv_sockaddr (struct env_set *es, const char *name=
_prefix, const struct openv
 	  openvpn_snprintf (name_buf, sizeof (name_buf), "%s_port", name_prefix);
 	  setenv_int (es, name_buf, ntohs (addr->addr.in4.sin_port));
 	}
-#ifdef USE_PF_INET6
       break;
     case AF_INET6:
       openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix=
);
@@ -2688,7 +2622,6 @@ setenv_sockaddr (struct env_set *es, const char *name=
_prefix, const struct openv
 	}
       break;
     }
-#endif
 }
=20
 void
@@ -2732,12 +2665,10 @@ static const struct proto_names proto_names[PROTO_N=
] =3D {
   {"tcp-server", "TCPv4_SERVER",0,1, AF_INET},
   {"tcp-client", "TCPv4_CLIENT",0,1, AF_INET},
   {"tcp",        "TCPv4",0,1, AF_INET},
-#ifdef USE_PF_INET6
   {"udp6"       ,"UDPv6",1,1, AF_INET6},
   {"tcp6-server","TCPv6_SERVER",0,1, AF_INET6},
   {"tcp6-client","TCPv6_CLIENT",0,1, AF_INET6},
   {"tcp6"       ,"TCPv6",0,1, AF_INET6},
-#endif
 };
=20
 bool
@@ -2819,14 +2750,11 @@ proto2ascii_all (struct gc_arena *gc)
 int
 addr_guess_family(int proto, const char *name)=20
 {
-#ifdef USE_PF_INET6
   unsigned short ret;
-#endif
   if (proto)
     {
       return proto_sa_family(proto);	/* already stamped */
     }=20
-#ifdef USE_PF_INET6
   else
     {
       struct addrinfo hints , *ai;
@@ -2841,7 +2769,6 @@ addr_guess_family(int proto, const char *name)
 	  return ret;
 	}
     }
-#endif
   return AF_INET;	/* default */
 }
 const char *
@@ -2873,10 +2800,8 @@ proto_remote (int proto, bool remote)
       {
 	case PROTO_TCPv4_SERVER: return PROTO_TCPv4_CLIENT;
 	case PROTO_TCPv4_CLIENT: return PROTO_TCPv4_SERVER;
-#ifdef USE_PF_INET6
 	case PROTO_TCPv6_SERVER: return PROTO_TCPv6_CLIENT;
 	case PROTO_TCPv6_CLIENT: return PROTO_TCPv6_SERVER;
-#endif
       }
     }
   return proto;
@@ -2946,19 +2871,15 @@ struct openvpn_in4_pktinfo
   struct in_addr pi4;
 #endif
 };
-#ifdef USE_PF_INET6
 struct openvpn_in6_pktinfo
 {
   struct cmsghdr cmsghdr;
   struct in6_pktinfo pi6;
 };
-#endif
=20
 union openvpn_pktinfo {
 	struct openvpn_in4_pktinfo msgpi4;
-#ifdef USE_PF_INET6
 	struct openvpn_in6_pktinfo msgpi6;
-#endif
 };
 #pragma pack()
=20
@@ -3010,7 +2931,6 @@ link_socket_read_udp_posix_recvmsg (struct link_socke=
t *sock,
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
 #endif
 	}
-#ifdef USE_PF_INET6
       else if (cmsg !=3D NULL
 	  && CMSG_NXTHDR (&mesg, cmsg) =3D=3D NULL
 	  && cmsg->cmsg_level =3D=3D IPPROTO_IPV6=20
@@ -3021,7 +2941,6 @@ link_socket_read_udp_posix_recvmsg (struct link_socke=
t *sock,
 	  from->pi.in6.ipi6_ifindex =3D pkti6->ipi6_ifindex;
 	  from->pi.in6.ipi6_addr =3D pkti6->ipi6_addr;
 	}
-#endif
     }
   return fromlen;
 }
@@ -3119,7 +3038,6 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
 #endif
         break;
       }
-#ifdef USE_PF_INET6
     case AF_INET6:
       {
         struct openvpn_in6_pktinfo msgpi6;
@@ -3138,7 +3056,6 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
         pkti6->ipi6_addr =3D to->pi.in6.ipi6_addr;
         break;
       }
-#endif
     default: ASSERT(0);
     }
   return sendmsg (sock->sd, &mesg, 0);
@@ -3240,11 +3157,9 @@ socket_recv_queue (struct link_socket *sock, int max=
size)
       if (proto_is_udp(sock->info.proto))
 	{
 	  sock->reads.addr_defined =3D true;
-#ifdef USE_PF_INET6
 	  if (sock->info.proto =3D=3D PROTO_UDPv6)
 	    sock->reads.addrlen =3D sizeof (sock->reads.addr6);
 	  else
-#endif
 	    sock->reads.addrlen =3D sizeof (sock->reads.addr);
 	  status =3D WSARecvFrom(
 			       sock->sd,
@@ -3277,15 +3192,9 @@ socket_recv_queue (struct link_socket *sock, int max=
size)
=20
       if (!status) /* operation completed immediately? */
 	{
-#ifdef USE_PF_INET6
 	  int addrlen =3D af_addr_size(sock->info.lsa->local.addr.sa.sa_family);
 	  if (sock->reads.addr_defined && sock->reads.addrlen !=3D addrlen)
 	    bad_address_length (sock->reads.addrlen, addrlen);
-#else
-	  if (sock->reads.addr_defined && sock->reads.addrlen !=3D sizeof (sock->=
reads.addr))
-	    bad_address_length (sock->reads.addrlen, sizeof (sock->reads.addr));
-#endif
-
 	  sock->reads.iostate =3D IOSTATE_IMMEDIATE_RETURN;
=20
 	  /* since we got an immediate return, we must signal the event object ou=
rselves */
@@ -3347,14 +3256,12 @@ socket_send_queue (struct link_socket *sock, struct=
 buffer *buf, const struct li
 	{
 	  /* set destination address for UDP writes */
 	  sock->writes.addr_defined =3D true;
-#ifdef USE_PF_INET6
 	  if (sock->info.proto =3D=3D PROTO_UDPv6)
 	    {
 	      sock->writes.addr6 =3D to->dest.addr.in6;
 	      sock->writes.addrlen =3D sizeof (sock->writes.addr6);
 	    }
 	  else
-#endif
 	    {
 	      sock->writes.addr =3D to->dest.addr.in4;
 	      sock->writes.addrlen =3D sizeof (sock->writes.addr);
@@ -3510,7 +3417,6 @@ socket_finalize (SOCKET s,
   if (from)
     {
       if (ret >=3D 0 && io->addr_defined)
-#ifdef USE_PF_INET6
 	{
 	  /* TODO(jjo): streamline this mess */
 	  /* in this func we dont have relevant info about the PF_ of this
@@ -3522,7 +3428,8 @@ socket_finalize (SOCKET s,
 	    {
 	    case sizeof(struct sockaddr_in):
 	    case sizeof(struct sockaddr_in6):
-	    /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INET6 */=20
+	    /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INET6
+	     * under WIN32*/=20
 	    case sizeof(struct sockaddr_in6)-4:
 	      break;
 	    default:
@@ -3539,13 +3446,6 @@ socket_finalize (SOCKET s,
 	      break;
 	    }
 	}
-#else
-	{
-	  if (io->addrlen !=3D sizeof (io->addr))
-	    bad_address_length (io->addrlen, sizeof (io->addr));
-	  from->dest.addr.in4 =3D io->addr;
-	}
-#endif
       else
 	CLEAR (from->dest.addr);
     }
diff --git a/socket.h b/socket.h
index 33da53c..ea06f2d 100644
--- a/socket.h
+++ b/socket.h
@@ -73,9 +73,7 @@ struct openvpn_sockaddr
   union {
     struct sockaddr sa;
     struct sockaddr_in in4;
-#ifdef USE_PF_INET6
     struct sockaddr_in6 in6;
-#endif
   } addr;
 };
=20
@@ -92,9 +90,7 @@ struct link_socket_actual
 #ifdef IP_RECVDSTADDR
     struct in_addr in4;
 #endif
-#ifdef USE_PF_INET6
     struct in6_pktinfo in6;
-#endif
   } pi;
 #endif
 };
@@ -390,12 +386,10 @@ void setenv_link_socket_actual (struct env_set *es,
=20
 void bad_address_length (int actual, int expected);
=20
-#ifdef USE_PF_INET6
 /* IPV4_INVALID_ADDR: returned by link_socket_current_remote()
  * to ease redirect-gateway logic for ipv4 tunnels on ipv6 endpoints
  */
 #define IPV4_INVALID_ADDR 0xffffffff
-#endif
 in_addr_t link_socket_current_remote (const struct link_socket_info *info);
=20
 void link_socket_connection_initiated (const struct buffer *buf,
@@ -521,12 +515,10 @@ enum proto_num {
 	PROTO_TCPv4_SERVER,
 	PROTO_TCPv4_CLIENT,
 	PROTO_TCPv4,
-#ifdef USE_PF_INET6
 	PROTO_UDPv6,
 	PROTO_TCPv6_SERVER,
 	PROTO_TCPv6_CLIENT,
 	PROTO_TCPv6,
-#endif
 	PROTO_N
 };
=20
@@ -590,9 +582,7 @@ addr_defined (const struct openvpn_sockaddr *addr)
   if (!addr) return 0;
   switch (addr->addr.sa.sa_family) {
     case AF_INET: return addr->addr.in4.sin_addr.s_addr !=3D 0;
-#ifdef USE_PF_INET6
     case AF_INET6: return !IN6_IS_ADDR_UNSPECIFIED(&addr->addr.in6.sin6_ad=
dr);
-#endif
     default: return 0;
   }
 }
@@ -608,9 +598,7 @@ addr_defined_ipi (const struct link_socket_actual *lsa)
 #ifdef IP_RECVDSTADDR
     case AF_INET: return lsa->pi.in4.s_addr !=3D 0;
 #endif
-#ifdef USE_PF_INET6
     case AF_INET6: return !IN6_IS_ADDR_UNSPECIFIED(&lsa->pi.in6.ipi6_addr);
-#endif
     default: return 0;
   }
 #else
@@ -631,10 +619,8 @@ addr_match (const struct openvpn_sockaddr *a1, const s=
truct openvpn_sockaddr *a2
   switch(a1->addr.sa.sa_family) {
     case AF_INET:
       return a1->addr.in4.sin_addr.s_addr =3D=3D a2->addr.in4.sin_addr.s_a=
ddr;
-#ifdef USE_PF_INET6
     case AF_INET6:
       return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin=
6_addr);
-#endif
   }
   ASSERT(0);
   return false;
@@ -648,12 +634,8 @@ addr_host (const struct openvpn_sockaddr *addr)
    * possible clash: non sense for now given
    * that we do ifconfig only IPv4
    */
-#if defined(USE_PF_INET6)=20
   if(addr->addr.sa.sa_family !=3D AF_INET)
     return 0;
-#else=20
-  ASSERT(addr->addr.sa.sa_family =3D=3D AF_INET);
-#endif
   return ntohl (addr->addr.in4.sin_addr.s_addr);
 }
=20
@@ -664,11 +646,9 @@ addr_port_match (const struct openvpn_sockaddr *a1, co=
nst struct openvpn_sockadd
     case AF_INET:
       return a1->addr.in4.sin_addr.s_addr =3D=3D a2->addr.in4.sin_addr.s_a=
ddr
 	&& a1->addr.in4.sin_port =3D=3D a2->addr.in4.sin_port;
-#ifdef USE_PF_INET6
     case AF_INET6:
       return IN6_ARE_ADDR_EQUAL(&a1->addr.in6.sin6_addr, &a2->addr.in6.sin=
6_addr)=20
 	&& a1->addr.in6.sin6_port =3D=3D a2->addr.in6.sin6_port;
-#endif
   }
   ASSERT(0);
   return false;
@@ -691,11 +671,9 @@ addr_zero_host(struct openvpn_sockaddr *addr)
      case AF_INET:
        addr->addr.in4.sin_addr.s_addr =3D 0;
        break;
-#ifdef USE_PF_INET6
      case AF_INET6:=20
        memset(&addr->addr.in6.sin6_addr, 0, sizeof (struct in6_addr));
        break;
-#endif
    }
 }
=20
@@ -712,11 +690,9 @@ addr_copy_host(struct openvpn_sockaddr *dst, const str=
uct openvpn_sockaddr *src)
      case AF_INET:
        dst->addr.in4.sin_addr.s_addr =3D src->addr.in4.sin_addr.s_addr;
        break;
-#ifdef USE_PF_INET6
      case AF_INET6:=20
        dst->addr.in6.sin6_addr =3D src->addr.in6.sin6_addr;
        break;
-#endif
    }
 }
=20
@@ -730,15 +706,9 @@ int addr_guess_family(int proto, const char *name);
 static inline int
 af_addr_size(unsigned short af)
 {
-#if defined(USE_PF_INET6) || defined (USE_PF_UNIX)
    switch(af) {
      case AF_INET: return sizeof (struct sockaddr_in);
-#ifdef USE_PF_UNIX
-     case AF_UNIX: return sizeof (struct sockaddr_un);
-#endif
-#ifdef USE_PF_INET6
      case AF_INET6: return sizeof (struct sockaddr_in6);
-#endif
      default:=20
 #if 0
       /* could be called from socket_do_accept() with empty addr */
@@ -747,9 +717,6 @@ af_addr_size(unsigned short af)
 #endif
      	return 0;
    }
-#else /* only AF_INET */
-   return sizeof(struct sockaddr_in);
-#endif
 }
=20
 static inline bool
@@ -809,9 +776,7 @@ link_socket_verify_incoming_addr (struct buffer *buf,
   if (buf->len > 0)
     {
       switch (from_addr->dest.addr.sa.sa_family) {
-#ifdef USE_PF_INET6
 	case AF_INET6:
-#endif
 	case AF_INET:
 	  if (!link_socket_actual_defined (from_addr))
 	    return false;
diff --git a/syshead.h b/syshead.h
index 5b86cad..cb98567 100644
--- a/syshead.h
+++ b/syshead.h
@@ -29,7 +29,7 @@
  * Only include if not during configure
  */
 #ifdef WIN32
-/* USE_PF_INET6: win32 ipv6 exists only after 0x0501 (XP) */
+/* PF_INET6: win32 ipv6 exists only after 0x0501 (XP) */
 #define WINVER 0x0501
 #endif
 #ifndef PACKAGE_NAME
@@ -343,7 +343,7 @@
 #ifdef WIN32
 #include <iphlpapi.h>
 #include <wininet.h>
-/* The following two headers are needed of USE_PF_INET6 */
+/* The following two headers are needed of PF_INET6 */
 #include <winsock2.h>
 #include <ws2tcpip.h>
 #endif
--=20
1.7.3.1


--=20
--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'
  gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3jw9QACgkQo/fiSWZycXcDHACfX5GXikyt24QEzP3DpIcXuWor
bRsAoK0/ivJxNIn7iDOLha5Vh4yKqKdf
=czxu
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

