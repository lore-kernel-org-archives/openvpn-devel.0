Date: Sun, 6 Apr 2014 10:35:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140406083549.GG16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yWfuuwpgu8lqpjFb"
Content-Disposition: inline
Subject: [Openvpn-devel] getaddrinfo() confusion / way forward?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--yWfuuwpgu8lqpjFb
Content-Type: multipart/mixed; boundary="fKV0vrqxS8TTaB1u"
Content-Disposition: inline

--fKV0vrqxS8TTaB1u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

I'm wondering if one of you can share insight here - I've been debugging
OpenVPN (-master) on OpenSolaris, which failed in building sockets,
due to getaddrinfo() returning "ai_protocol =3D 0" for everything - while
the OpenVPN socket code relies on ai_protocol being IPPROTO_UDP or
IPPROTO_TCP (and ASSERT()s out in create_socket() if it's neither).


To understand the issue, I've made a test program, which is appended
below - it basically calls getaddrinfo() to resolve two different
dual-stack servers, one for SOCK_DGRAM and the other for SOCK_STREAM.

On Linux and NetBSD, the result looks like this:

getaddrinfo('www.google.de', '80', family=3D24, socktype=3D1) -> status=3D0
ai_: flags=3D8, family=3D24, socktype=3D1, protocol=3D6
     addrlen=3D28, addr=3D'2a00:1450:4016:801::1018'

getaddrinfo('conn-test-server.openvpn.org', '51194', family=3D24, socktype=
=3D2) -> status=3D0
ai_: flags=3D8, family=3D24, socktype=3D2, protocol=3D17
     addrlen=3D28, addr=3D'2607:fc50:1001:5200::4'

(only the ipv6-only case show, "protocol=3D6" is TCP, "protocol=3D17" is UD=
P)
- which is the expected case.


Same code on Solaris:

getaddrinfo('www.google.de', '80', family=3D26, socktype=3D2) -> status=3D0
ai_: flags=3D64, family=3D26, socktype=3D2, protocol=3D0
     addrlen=3D32, addr=3D'2a00:1450:4016:802::101f'

getaddrinfo('conn-test-server.openvpn.org', '51194', family=3D26, socktype=
=3D1) -> status=3D0
ai_: flags=3D64, family=3D26, socktype=3D1, protocol=3D0
     addrlen=3D32, addr=3D'2607:fc50:1001:5200::4'

-> ai_protocol is "0", which is basically "undefined", but on *Solaris*,
this seems to be "use what is appropriate", from "man socket":

     The protocol parameter is a  protocol-family-specific  value
     which  specifies  a  particular protocol to be used with the
     socket.  Normally this value is zero,  as  commonly  only  a
     single  protocol  exists to support a particular socket type
     within a given protocol family. However, multiple  protocols
     may exist, in which case a particular protocol may be speci-
     fied in this manner.


so now I wonder how to tackle this in OpenVPN.

One possible approach would be to add this hack to the end of=20
openvpn_getaddrinfo():

#ifdef TARGET_SOLARIS
  /* fixup Solaris' getaddrinfo() returning ai_protocol=3D0 */
  if (status=3D=3D0 && (*res)->ai_protocol =3D=3D 0 )
    {
      struct addrinfo *ai =3D *res;
      msg( M_WARN, "invoking Solaris ai_protocol=3D=3D0 fixup" );
      while( ai )
        {
          if(flags & GETADDR_DATAGRAM)
              ai->ai_protocol =3D IPPROTO_UDP;
          else
              ai->ai_protocol =3D IPPROTO_TCP;
          ai =3D ai->ai_next;
        }
    }
#endif

... that is, depending on the type of socket we've asked for, fix
the return values to always set ai_protocol to the values that=20
create_socket() wants to see.


The other approach would be to change create_socket() to decide upon
ai_socktype (SOCK_DGRAM/SOCK_STREAM) whether to call create_socket_udp()
or create_socket_tcp(), and change *those* to ignore ai_protocol and
always use IPPROTO_UDP / IPPROTO_TCP instead for their socket() calls.

These are the code bits in question:



create_socket()
{
  if (addr->ai_protocol =3D=3D IPPROTO_UDP)
    {
      sock->sd =3D create_socket_udp (addr, sock->sockflags);
...
    }
  else if (addr->ai_protocol =3D=3D IPPROTO_TCP)
    {
      sock->sd =3D create_socket_tcp (addr);
    }
  else
    {
      ASSERT (0);		<<< this is where solaris bombs out
    }
}


create_socket_tcp()
{
...
  ASSERT (addrinfo);
  ASSERT (addrinfo->ai_socktype =3D=3D SOCK_STREAM);
  ASSERT (addrinfo->ai_protocol =3D=3D IPPROTO_TCP);

  if ((sd =3D socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo-=
>ai_protocol)) < 0)


create_socket_udp()
{
...
  ASSERT (addrinfo);
  ASSERT (addrinfo->ai_socktype =3D=3D SOCK_DGRAM);
  ASSERT (addrinfo->ai_protocol =3D=3D IPPROTO_UDP);

  if ((sd =3D socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo-=
>ai_protocol)) < 0)



Arne, what do you think?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fKV0vrqxS8TTaB1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gai.c"
Content-Transfer-Encoding: quoted-printable

/* getaddrinfo() sanity test */

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <string.h>

void gai( char * host, char * service, int ai_family, int ai_socktype )
{
    struct addrinfo hints, *ai, *ap;
    int status;
    char print_host[200];

    memset( &hints, 0, sizeof(hints) );
    hints.ai_family =3D ai_family;
    hints.ai_socktype =3D ai_socktype;
    /* hints.ai_protocol =3D IPPROTO_TCP; */  /* test, no effect */
    hints.ai_flags =3D AI_NUMERICSERV;

    status =3D getaddrinfo( host, service, &hints, &ai );

    printf( "\ngetaddrinfo('%s', '%s', family=3D%d, socktype=3D%d) -> statu=
s=3D%d\n",=20
            host, service, ai_family, ai_socktype, status );

    if ( status !=3D 0 ) return;

    for( ap =3D ai; ap !=3D NULL; ap=3Dap->ai_next )
    {
	printf( "ai_: flags=3D%d, family=3D%d, socktype=3D%d, protocol=3D%d\n",
		ap->ai_flags, ap->ai_family, ap->ai_socktype, ap->ai_protocol );
	getnameinfo( ap->ai_addr, ap->ai_addrlen,=20
			print_host, sizeof(print_host)-1,=20
			NULL, 0, NI_NUMERICHOST );
        printf( "     addrlen=3D%d, addr=3D'%s'\n",
		ap->ai_addrlen, print_host );
    }
    freeaddrinfo(ai);
}


int main( int argc, char ** argv )
{
    gai( "www.google.de", "80", AF_UNSPEC, SOCK_STREAM );
    gai( "www.google.de", "80", AF_INET6, SOCK_STREAM );
    gai( "conn-test-server.openvpn.org", "51194", AF_UNSPEC, SOCK_DGRAM );
    gai( "conn-test-server.openvpn.org", "51194", AF_INET6, SOCK_DGRAM );
    return 0;
}

--fKV0vrqxS8TTaB1u--

--yWfuuwpgu8lqpjFb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0ER5akuBuNlUUl1AQIQcgQApiGM27r0B+MsWFi6y02tK0xtvDSo1PSF
d/G47Vb9iGhR29Eb3OxY4N0wVyZ/Wb/DEBqLHwh8RD+Me6asfXA5BKqaLmrxRFYm
gQXcgN1zfYMuBZPJnd9Wcos+kR/YNf+fCevzSDYDU0CFQgJzvoTz/o4c+4itV503
bmzc8YC26oo=
=4Gv5
-----END PGP SIGNATURE-----

--yWfuuwpgu8lqpjFb--

