Date: Sun, 19 Jan 2014 16:53:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140119155320.GQ226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <20140119140416.GP226@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lqd80pEYgtNQwEzr"
Content-Disposition: inline
In-Reply-To: <20140119140416.GP226@...1296...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--Lqd80pEYgtNQwEzr
Content-Type: multipart/mixed; boundary="FCaxfLZdDTBfImim"
Content-Disposition: inline

--FCaxfLZdDTBfImim
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 19, 2014 at 03:04:17PM +0100, Gert Doering wrote:
> In case you want to test yourself, the code is appended.

... it was not.  As always when people say "I have attached..." :-/

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FCaxfLZdDTBfImim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mhome.c"
Content-Transfer-Encoding: quoted-printable

/*
 *  mhome.c - test program for multihoming server tests
 *
 *  open UDP socket on port specified on command line, bind IPv4 or IPv6
 *  to it, log all incoming packets and reply, hopefully with the right
 *  source address
 *
 *  largely based on OpenVPN sources to test those modules
 */

#define ENABLE_IP_PKTINFO 1

#ifdef linux
/* needed for netinet/in.h */
#define _GNU_SOURCE 1	=09
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <net/if.h>

#include <stdbool.h>
#include <assert.h>
#define ASSERT(x) assert(x)

#define CLEAR(x) memset(&(x), 0, sizeof(x))

/* IP_PKTINFO or IP_RECVDSTADDR are defined in <netinet/in.h> on BSDs
 * and Linux just fine, but our configure/ifdef logic is weird */
#ifdef IP_PKTINFO
# define HAVE_IN_PKTINFO 1
#endif

#define msg(a,b) fprintf(stderr,b "\n")

/* glue definitions, copied from syshead.h or socket.h */
typedef int socket_descriptor_t;
# define SF_USE_IP_PKTINFO (1<<0)

#define PS_SHOW_PORT_IF_DEFINED (1<<0)
#define PS_SHOW_PORT            (1<<1)
#define PS_SHOW_PKTINFO         (1<<2)
#define PS_DONT_SHOW_ADDR       (1<<3)

/* OpenVPN sockaddr struct */
struct openvpn_sockaddr
{
  union {
    struct sockaddr sa;
    struct sockaddr_in in4;
    struct sockaddr_in6 in6;
  } addr;
};

struct link_socket_actual
{
 int ai_family; /* PF_xxx */
 int ai_socktype;       /* SOCK_xxx */
 int ai_protocol;       /* 0 or IPPROTO_xxx for IPv4 and IPv6 */

  struct openvpn_sockaddr dest;
#if ENABLE_IP_PKTINFO
  union {
#ifdef HAVE_IN_PKTINFO
    struct in_pktinfo in4;
#elif defined(IP_RECVDSTADDR)
    struct in_addr in4;
#endif
    struct in6_pktinfo in6;
  } pi;
#endif
};

/*
 * Format IP addresses in ascii
 *
 * (hacked-together non-safe version of the version in openvpn)
 */
const char *
print_sockaddr_ex (const struct sockaddr *sa,
				   const char* separator,
				   const unsigned int flags )
{
  static char out[1000];
  bool addr_is_defined;
  char hostaddr[NI_MAXHOST] =3D "";
  char servname[NI_MAXSERV] =3D "";
  int status;

  socklen_t salen;
  switch(sa->sa_family)
    {
    case AF_INET:
      strcpy(out, "[AF_INET]");
      salen =3D sizeof (struct sockaddr_in);
      addr_is_defined =3D ((struct sockaddr_in*) sa)->sin_addr.s_addr !=3D =
0;
      break;
    case AF_INET6:
      strcpy(out, "[AF_INET6]");
      salen =3D sizeof (struct sockaddr_in6);
      addr_is_defined =3D !IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*)=
 sa)->sin6_addr);
      break;
    case AF_UNSPEC:
      return "[AF_UNSPEC]";
    default:
      ASSERT(0);
    }

  status =3D getnameinfo(sa, salen, hostaddr, sizeof (hostaddr),
              servname, sizeof(servname), NI_NUMERICHOST | NI_NUMERICSERV);

  if(status!=3D0) {
      sprintf(&out[strlen(out)],"[nameinfo() err: %s]",gai_strerror(status)=
);
      return out;
  }

  if (!(flags & PS_DONT_SHOW_ADDR))
    {
      if (addr_is_defined)
        strcat (out, hostaddr);
      else
        strcat (out, "[undef]");
    }

  if ((flags & PS_SHOW_PORT) || (flags & PS_SHOW_PORT_IF_DEFINED))
    {
      if (separator)
        strcat (out, separator);

      strcat (out, servname);
    }

  return out;
}

/* ------- mostly unchanged code from socket.c below this line ----- */

static socket_descriptor_t
create_socket_udp (const int af, const unsigned int flags)
{
  socket_descriptor_t sd;

  if ((sd =3D socket (af, SOCK_DGRAM, IPPROTO_UDP)) < 0)
    msg (M_ERR, "UDP: Cannot create UDP/UDP6 socket");
#if ENABLE_IP_PKTINFO
  else if (flags & SF_USE_IP_PKTINFO)
    {
      int pad =3D 1;
      if(af =3D=3D AF_INET)
        {
#ifdef IP_PKTINFO
	  fprintf( stderr, "AF_INET/IP_PKTINFO enabled\n");
          if (setsockopt (sd, SOL_IP, IP_PKTINFO,
                          (void*)&pad, sizeof(pad)) < 0)
            msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
#elif defined(IP_RECVDSTADDR)
	  fprintf( stderr, "AF_INET/IP_RECVDSTADDR enabled\n");
          if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
                          (void*)&pad, sizeof(pad)) < 0)
            msg(M_ERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix =
syshead.h)
#endif
        }
      else if (af =3D=3D AF_INET6 )
        {
#ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms require this */
	  fprintf( stderr, "AF_INET6/IPV6_PKTINFO enabled\n");
          if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
                          (void*)&pad, sizeof(pad)) < 0)
#else
	  fprintf( stderr, "AF_INET6/IPV6_RECVPKTINFO enabled\n");
          if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
                          (void*)&pad, sizeof(pad)) < 0)
#endif
            msg(M_ERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
        }
    }
#endif
  return sd;
}


void
socket_bind (socket_descriptor_t sd,
             char* port, int ai_family)
{
  struct addrinfo hints;
  struct addrinfo* cur;

  CLEAR(hints);
  hints.ai_family =3D ai_family;
  hints.ai_socktype =3D SOCK_DGRAM;
  hints.ai_protocol =3D IPPROTO_UDP;
  hints.ai_flags =3D AI_PASSIVE | AI_NUMERICSERV;

  int s =3D getaddrinfo( NULL, port, &hints, &cur );

  if ( s !=3D 0 )
  	{ fprintf( stderr, "getaddrinfo failed: %s (%d)\n",
			gai_strerror(s), s ); exit(1); }

  if (ai_family =3D=3D AF_INET6)
    {
      int v6only =3D 0;

      fprintf (stderr, "setsockopt(IPV6_V6ONLY=3D%d)\n", v6only);
      if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, &v6only, sizeof(v6only)=
))
	{
	  fprintf (stderr, "Setting IPV6_V6ONLY=3D%d failed\n", v6only);
	}
    }
  if (bind (sd, cur->ai_addr, cur->ai_addrlen))
    {
      const int err =3D errno;
      fprintf (stderr, "Socket bind failed on local address %s: %s\n",
           print_sockaddr_ex (cur->ai_addr, ":", PS_SHOW_PORT),
           strerror(err));
      exit(1);
    }
  fprintf (stderr, "Socket bound to local address %s\n",
       print_sockaddr_ex (cur->ai_addr, ":", PS_SHOW_PORT) );
}

const char *
print_link_socket_actual_ex (const struct link_socket_actual *act,
			     const char *separator,
			     const unsigned int flags)
{
  static char out[1000];

  if (act)
    {
      char ifname[IF_NAMESIZE] =3D "[undef]";
      strcpy (out, print_sockaddr_ex (&act->dest.addr.sa, separator, flags)=
);
#if ENABLE_IP_PKTINFO
      if ((flags & PS_SHOW_PKTINFO)) /* && addr_defined_ipi(act))*/
	{
	  switch(act->dest.addr.sa.sa_family)
	    {
	    case AF_INET:
		{
		  struct openvpn_sockaddr sa;
		  CLEAR (sa);
		  sa.addr.in4.sin_family =3D AF_INET;
#ifdef IP_PKTINFO
		  sa.addr.in4.sin_addr =3D act->pi.in4.ipi_spec_dst;
		  if_indextoname(act->pi.in4.ipi_ifindex, ifname);
#elif defined(IP_RECVDSTADDR)
		  sa.addr.in4.sin_addr =3D act->pi.in4;
		  ifname[0]=3D0;
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix =
syshead.h)
#endif
		  sprintf (&out[strlen(out)], " (via %s%%%s)",
			      print_sockaddr_ex (&sa.addr.sa, separator, 0),
			      ifname);
		}
	      break;
	    case AF_INET6:
		{
		  struct sockaddr_in6 sin6;
		  char buf[INET6_ADDRSTRLEN] =3D "[undef]";
		  CLEAR(sin6);
		  sin6.sin6_family =3D AF_INET6;
		  sin6.sin6_addr =3D act->pi.in6.ipi6_addr;
		  if_indextoname(act->pi.in6.ipi6_ifindex, ifname);
		  if (getnameinfo((struct sockaddr *)&sin6, sizeof (struct sockaddr_in6),
				  buf, sizeof (buf), NULL, 0, NI_NUMERICHOST) =3D=3D 0)
		    sprintf (&out[strlen(out)], " (via %s%%%s)", buf, ifname);
		  else
		    sprintf (&out[strlen(out)], " (via [getnameinfo() err]%%%s)", ifname);
		}
	      break;
	    }
	}
#endif
      return out;
    }
  else
    return "[NULL]";
}

#pragma pack(1) /* needed to keep structure size consistent for 32 vs. 64-b=
it architectures */
struct openvpn_in4_pktinfo
{
  struct cmsghdr cmsghdr;
#ifdef HAVE_IN_PKTINFO
  struct in_pktinfo pi4;
#elif defined(IP_RECVDSTADDR)
  struct in_addr pi4;
#endif
};
struct openvpn_in6_pktinfo
{
  struct cmsghdr cmsghdr;=20
  struct in6_pktinfo pi6;
};

union openvpn_pktinfo {
	struct openvpn_in4_pktinfo msgpi4;
	struct openvpn_in6_pktinfo msgpi6;
};
#pragma pack()


static socklen_t
link_socket_read_udp_posix_recvmsg (socket_descriptor_t sd,
				    char *buf,
				    int maxsize,
				    struct link_socket_actual *from,
				    int *r_len)
{
  struct iovec iov;
  union openvpn_pktinfo opi;
  struct msghdr mesg;

  socklen_t fromlen =3D sizeof (from->dest.addr);

  iov.iov_base =3D buf;
  iov.iov_len =3D maxsize;
  mesg.msg_iov =3D &iov;
  mesg.msg_iovlen =3D 1;
  mesg.msg_name =3D &from->dest.addr;
  mesg.msg_namelen =3D fromlen;
  mesg.msg_control =3D &opi;
  mesg.msg_controllen =3D sizeof opi;

  *r_len =3D recvmsg (sd, &mesg, 0);
  if (*r_len >=3D 0)
    {
      struct cmsghdr *cmsg;
      fromlen =3D mesg.msg_namelen;
      cmsg =3D CMSG_FIRSTHDR (&mesg);
      if (cmsg =3D=3D NULL)
	fprintf( stderr, "CMSG_FIRSTHDR()=3DNULL, no packet info available\n");
      else
	fprintf( stderr, "CMSG_NXTHDR=3D%p, level=3D%d, type=3D%d\n",
		 CMSG_NXTHDR (&mesg, cmsg), cmsg->cmsg_level, cmsg->cmsg_type );
      if (cmsg !=3D NULL
	  && CMSG_NXTHDR (&mesg, cmsg) =3D=3D NULL
#ifdef IP_PKTINFO
	  && cmsg->cmsg_level =3D=3D SOL_IP=20
	  && cmsg->cmsg_type =3D=3D IP_PKTINFO
#elif defined(IP_RECVDSTADDR)
	  && cmsg->cmsg_level =3D=3D IPPROTO_IP
	  && cmsg->cmsg_type =3D=3D IP_RECVDSTADDR
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix =
syshead.h)
#endif
	  && cmsg->cmsg_len >=3D sizeof (struct openvpn_in4_pktinfo))
	{
#ifdef IP_PKTINFO
	  struct in_pktinfo *pkti =3D (struct in_pktinfo *) CMSG_DATA (cmsg);
	  from->pi.in4.ipi_ifindex =3D pkti->ipi_ifindex;
	  from->pi.in4.ipi_spec_dst =3D pkti->ipi_spec_dst;
	  fprintf( stderr, "IP_PKTINFO\n" );
#elif defined(IP_RECVDSTADDR)
	  from->pi.in4 =3D *(struct in_addr*) CMSG_DATA (cmsg);
	  fprintf( stderr, "IP_RECVDSTADDR\n" );
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix =
syshead.h)
#endif
	}
      else if (cmsg !=3D NULL
	  && CMSG_NXTHDR (&mesg, cmsg) =3D=3D NULL
	  && cmsg->cmsg_level =3D=3D IPPROTO_IPV6=20
	  && cmsg->cmsg_type =3D=3D IPV6_PKTINFO
	  && cmsg->cmsg_len >=3D sizeof (struct openvpn_in6_pktinfo))
	{
	  struct in6_pktinfo *pkti6 =3D (struct in6_pktinfo *) CMSG_DATA (cmsg);
	  from->pi.in6.ipi6_ifindex =3D pkti6->ipi6_ifindex;
	  from->pi.in6.ipi6_addr =3D pkti6->ipi6_addr;
	  fprintf( stderr, "IPV6_PKTINFO\n" );
	}
    }
  return fromlen;
}


size_t
link_socket_write_udp_posix_sendmsg (socket_descriptor_t sd,
				     char *buf, int len,
				     struct link_socket_actual *to)
{
  struct iovec iov;
  struct msghdr mesg;
  struct cmsghdr *cmsg;
  union openvpn_pktinfo opi;

  iov.iov_base =3D buf;
  iov.iov_len =3D len;
  mesg.msg_iov =3D &iov;
  mesg.msg_iovlen =3D 1;
  switch (to->ai_family)
    {
    case AF_INET:
      {
        mesg.msg_name =3D &to->dest.addr.sa;
        mesg.msg_namelen =3D sizeof (struct sockaddr_in);
        mesg.msg_control =3D &opi;
        mesg.msg_controllen =3D sizeof (struct openvpn_in4_pktinfo);
        mesg.msg_flags =3D 0;
        cmsg =3D CMSG_FIRSTHDR (&mesg);
        cmsg->cmsg_len =3D sizeof (struct openvpn_in4_pktinfo);
#ifdef HAVE_IN_PKTINFO
        cmsg->cmsg_level =3D SOL_IP;
        cmsg->cmsg_type =3D IP_PKTINFO;
	{
        struct in_pktinfo *pkti;
        pkti =3D (struct in_pktinfo *) CMSG_DATA (cmsg);
        pkti->ipi_ifindex =3D to->pi.in4.ipi_ifindex;
        pkti->ipi_spec_dst =3D to->pi.in4.ipi_spec_dst;
        pkti->ipi_addr.s_addr =3D 0;
	}
#elif defined(IP_RECVDSTADDR)
        cmsg->cmsg_level =3D IPPROTO_IP;
        cmsg->cmsg_type =3D IP_RECVDSTADDR;
        *(struct in_addr *) CMSG_DATA (cmsg) =3D to->pi.in4;
#else
#error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix =
syshead.h)
#endif
        break;
      }
    case AF_INET6:
      {
        struct in6_pktinfo *pkti6;
        mesg.msg_name =3D &to->dest.addr.sa;
        mesg.msg_namelen =3D sizeof (struct sockaddr_in6);
        mesg.msg_control =3D &opi;
        mesg.msg_controllen =3D sizeof (struct openvpn_in6_pktinfo);
        mesg.msg_flags =3D 0;
        cmsg =3D CMSG_FIRSTHDR (&mesg);
        cmsg->cmsg_len =3D sizeof (struct openvpn_in6_pktinfo);
        cmsg->cmsg_level =3D IPPROTO_IPV6;
        cmsg->cmsg_type =3D IPV6_PKTINFO;
        pkti6 =3D (struct in6_pktinfo *) CMSG_DATA (cmsg);
        pkti6->ipi6_ifindex =3D to->pi.in6.ipi6_ifindex;
        pkti6->ipi6_addr =3D to->pi.in6.ipi6_addr;
        break;
      }
    default: ASSERT(0);
    }
  return sendmsg (sd, &mesg, 0);
}


void loop(int sd)
{
    int r_len, fromlen, r;
    char buf[10000];
    struct link_socket_actual from;

    while(1)
    {
        CLEAR(from);
	fprintf( stderr, "--\n" );
	fromlen =3D link_socket_read_udp_posix_recvmsg (sd, buf, sizeof(buf), &fro=
m, &r_len);
	fprintf( stderr, "read: fromlen=3D%d, r_len=3D%d\n", fromlen, r_len );
	fprintf( stderr, "  from=3D%s\n",
	   print_link_socket_actual_ex(&from, ":", PS_SHOW_PORT|PS_SHOW_PKTINFO) );

#if 0
	/* send back response (just mirror packet) */
	r =3D link_socket_write_udp_posix_sendmsg(sd, buf, r_len, &from);
	fprintf( stderr, "sendmsg() returns r=3D%d\n", r );
#endif
    }
}

int main(int argc, char **argv)
{
    int s;
    int af =3D AF_INET6;
    char* port =3D "50001";

   =20
    if ( argc > 1 && argv[1][0] =3D=3D '4' ) { af =3D AF_INET; }
    if ( argc > 2 )                      { port =3D argv[2]; }

    s =3D create_socket_udp( af, SF_USE_IP_PKTINFO );
    socket_bind( s, port, af );

    loop(s);
    exit(0);
}

--FCaxfLZdDTBfImim--

--Lqd80pEYgtNQwEzr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtv08KkuBuNlUUl1AQJsNAP9G+NJm39D2gVSB/PxeEFP4TisMwwPvbNd
5CZQpTzPIfpXh1CSIs8MrajA8+uxN5nkPD6outivTVagFM0uOms4A7EwoL0z7jtb
VljdN4a5BUaA8gL61W0mrFVODdiuPLt4eeMrZ5/E/QsXS3GsMUYqrEl0yUBkGtTh
GZMFiBiynNg=
=zbO7
-----END PGP SIGNATURE-----

--Lqd80pEYgtNQwEzr--

