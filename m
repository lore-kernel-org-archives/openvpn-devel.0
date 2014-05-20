Date: Tue, 20 May 2014 22:58:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140520205823.GF1405@...1296...>
References: <20140113185822.GV226@...1296...>
	<1389706398-26922-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRtLtq+kfJNLc57H"
Content-Disposition: inline
In-Reply-To: <1389706398-26922-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 3/2] Merge get_default_gateway()
	implementation for all 4+1 BSD variants.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--QRtLtq+kfJNLc57H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

bringing this one back into people's memory.  I just rediscovered this
today while going through my own list of not-yet-merged patches - and
since this is

 - less code
 - less duplicate code
 - more functionality (due to "duplicated code was missing more recent bits=
")
 - tested on all the affected platforms

I'm going to apply lazy-ack rules "soon".  Unless someone else finds time
to review and ACK :-)

gert


On Tue, Jan 14, 2014 at 02:33:18PM +0100, Gert Doering wrote:
> This was 3 times mostly the same code, with the 4 traditional BSDs
> only differing in a single line, while MacOS X had more refined code
> to do not only gateway determination, but also netmask, interface name
> and MAC address.
>=20
> The MacOS X code works perfectly well on the other BSDs *if* one macro
> is #ifdef'ed to use "(uint32_t)" on MacOS X and "(long)" on all other
> BSDs, 32 and 64 bit variants.  API change by OSX when going to 64bit.
>=20
> Tested on FreeBSD 8.3/i386, FreeBSD 9.1/amd64, NetbSD 5.1/amd64,
> OpenBSD 4.9/i386, OpenBSD 5.4/amd64 (=3D all affected platforms except
> DragonFly BSD).
>=20
> See also trac#42 and trac#340.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 246 +++++-----------------------------------------=
------
>  1 file changed, 21 insertions(+), 225 deletions(-)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index d397f11..25c81b9 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2606,118 +2606,9 @@ get_default_gateway (struct route_gateway_info *r=
gi)
>    gc_free (&gc);
>  }
>=20=20
> -#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
> -
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <netinet/in.h>
> -#include <net/route.h>
> -
> -struct {
> -  struct rt_msghdr m_rtm;
> -  char       m_space[512];
> -} m_rtmsg;
> -
> -#define ROUNDUP(a) \
> -        ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
> -
> -/*
> - * FIXME -- add support for netmask, hwaddr, and iface
> - */
> -void
> -get_default_gateway (struct route_gateway_info *rgi)
> -{
> -  struct gc_arena gc =3D gc_new ();
> -  int s, seq, l, pid, rtm_addrs, i;
> -  struct sockaddr so_dst, so_mask;
> -  char *cp =3D m_rtmsg.m_space;=20
> -  struct sockaddr *gate =3D NULL, *sa;
> -  struct  rt_msghdr *rtm_aux;
> -
> -#define NEXTADDR(w, u) \
> -        if (rtm_addrs & (w)) {\
> -            l =3D ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp +=3D l;\
> -        }
> -
> -#define ADVANCE(x, n) (x +=3D ROUNDUP((n)->sa_len))
> -
> -#define rtm m_rtmsg.m_rtm
> -
> -  CLEAR(*rgi);
> -
> -  pid =3D getpid();
> -  seq =3D 0;
> -  rtm_addrs =3D RTA_DST | RTA_NETMASK;
> -
> -  bzero(&so_dst, sizeof(so_dst));
> -  bzero(&so_mask, sizeof(so_mask));
> -  bzero(&rtm, sizeof(struct rt_msghdr));
> -
> -  rtm.rtm_type =3D RTM_GET;
> -  rtm.rtm_flags =3D RTF_UP | RTF_GATEWAY;
> -  rtm.rtm_version =3D RTM_VERSION;
> -  rtm.rtm_seq =3D ++seq;
> -  rtm.rtm_addrs =3D rtm_addrs;=20
> -
> -  so_dst.sa_family =3D AF_INET;
> -  so_dst.sa_len =3D sizeof(struct sockaddr_in);
> -  so_mask.sa_family =3D AF_INET;
> -  so_mask.sa_len =3D sizeof(struct sockaddr_in);
> -
> -  NEXTADDR(RTA_DST, so_dst);
> -  NEXTADDR(RTA_NETMASK, so_mask);
> -
> -  rtm.rtm_msglen =3D l =3D cp - (char *)&m_rtmsg;
> -
> -  s =3D socket(PF_ROUTE, SOCK_RAW, 0);
> -
> -  if (write(s, (char *)&m_rtmsg, l) < 0)
> -    {
> -      msg(M_WARN|M_ERRNO, "Could not retrieve default gateway from route=
 socket:");
> -      gc_free (&gc);
> -      close(s);
> -      return;
> -    }
> -
> -  do {
> -    l =3D read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
> -  } while (l > 0 && (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));
> -=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> -  close(s);
> -
> -  rtm_aux =3D &rtm;
> -
> -  cp =3D ((char *)(rtm_aux + 1));
> -  if (rtm_aux->rtm_addrs) {
> -    for (i =3D 1; i; i <<=3D 1)
> -      if (i & rtm_aux->rtm_addrs) {
> -	sa =3D (struct sockaddr *)cp;
> -	if (i =3D=3D RTA_GATEWAY )
> -	  gate =3D sa;
> -	ADVANCE(cp, sa);
> -      }
> -  }
> -  else
> -    {
> -      gc_free (&gc);
> -      return;
> -    }
> -
> -
> -  if (gate !=3D NULL )
> -    {
> -      rgi->gateway.addr =3D ntohl(((struct sockaddr_in *)gate)->sin_addr=
.s_addr);
> -      rgi->flags |=3D RGI_ADDR_DEFINED;
> -
> -      gc_free (&gc);
> -    }
> -  else
> -    {
> -      gc_free (&gc);
> -    }
> -}
> -
> -#elif defined(TARGET_DARWIN)
> +#elif defined(TARGET_DARWIN) || \
> +	defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || \
> +	defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
>=20=20
>  #include <sys/types.h>
>  #include <sys/socket.h>
> @@ -2730,8 +2621,25 @@ struct rtmsg {
>    char       m_space[512];
>  };
>=20=20
> -#define ROUNDUP(a) \
> +/* the route socket code is identical for all 4 supported BSDs and for
> + * MacOS X (Darwin), with one crucial difference: when going from
> + * 32 bit to 64 bit, the BSDs increased the structure size but kept
> + * source code compatibility by keeping the use of "long", while
> + * MacOS X decided to keep binary compatibility by *changing* the API
> + * to use "uint32_t", thus 32 bit on all OS X variants
> + *
> + * We used to have a large amount of duplicate code here which really
> + * differed only in this (long) vs. (uint32_t) - IMHO, worse than
> + * having a combined block for all BSDs with this single #ifdef inside
> + */
> +
> +#if defined(TARGET_DARWIN)
> +# define ROUNDUP(a) \
>          ((a) > 0 ? (1 + (((a) - 1) | (sizeof(uint32_t) - 1))) : sizeof(u=
int32_t))
> +#else
> +# define ROUNDUP(a) \
> +        ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
> +#endif
>=20=20
>  #define NEXTADDR(w, u) \
>          if (rtm_addrs & (w)) {\
> @@ -2925,118 +2833,6 @@ get_default_gateway (struct route_gateway_info *r=
gi)
>=20=20
>  #undef max
>=20=20
> -#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
> -
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <netinet/in.h>
> -#include <net/route.h>
> -
> -struct {
> -  struct rt_msghdr m_rtm;
> -  char       m_space[512];
> -} m_rtmsg;
> -
> -#define ROUNDUP(a) \
> -        ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
> -
> -/*
> - * FIXME -- add support for netmask, hwaddr, and iface
> - */
> -void
> -get_default_gateway (struct route_gateway_info *rgi)
> -{
> -  struct gc_arena gc =3D gc_new ();
> -  int s, seq, l, rtm_addrs, i;
> -  pid_t pid;
> -  struct sockaddr so_dst, so_mask;
> -  char *cp =3D m_rtmsg.m_space;=20
> -  struct sockaddr *gate =3D NULL, *sa;
> -  struct  rt_msghdr *rtm_aux;
> -
> -#define NEXTADDR(w, u) \
> -        if (rtm_addrs & (w)) {\
> -            l =3D ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp +=3D l;\
> -        }
> -
> -#define ADVANCE(x, n) (x +=3D ROUNDUP((n)->sa_len))
> -
> -#define rtm m_rtmsg.m_rtm
> -
> -  CLEAR(*rgi);
> -
> -  pid =3D getpid();
> -  seq =3D 0;
> -  rtm_addrs =3D RTA_DST | RTA_NETMASK;
> -
> -  bzero(&so_dst, sizeof(so_dst));
> -  bzero(&so_mask, sizeof(so_mask));
> -  bzero(&rtm, sizeof(struct rt_msghdr));
> -
> -  rtm.rtm_type =3D RTM_GET;
> -  rtm.rtm_flags =3D RTF_UP | RTF_GATEWAY;
> -  rtm.rtm_version =3D RTM_VERSION;
> -  rtm.rtm_seq =3D ++seq;
> -  rtm.rtm_addrs =3D rtm_addrs;=20
> -
> -  so_dst.sa_family =3D AF_INET;
> -  so_dst.sa_len =3D sizeof(struct sockaddr_in);
> -  so_mask.sa_family =3D AF_INET;
> -  so_mask.sa_len =3D sizeof(struct sockaddr_in);
> -
> -  NEXTADDR(RTA_DST, so_dst);
> -  NEXTADDR(RTA_NETMASK, so_mask);
> -
> -  rtm.rtm_msglen =3D l =3D cp - (char *)&m_rtmsg;
> -
> -  s =3D socket(PF_ROUTE, SOCK_RAW, 0);
> -
> -  if (write(s, (char *)&m_rtmsg, l) < 0)
> -    {
> -      msg(M_WARN|M_ERRNO, "Could not retrieve default gateway from route=
 socket:");
> -      gc_free (&gc);
> -      close(s);
> -      return;
> -    }
> -
> -  do {
> -    l =3D read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
> -  } while (l > 0 && (rtm.rtm_seq !=3D seq || rtm.rtm_pid !=3D pid));
> -=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> -  close(s);
> -
> -  rtm_aux =3D &rtm;
> -
> -  cp =3D ((char *)(rtm_aux + 1));
> -  if (rtm_aux->rtm_addrs) {
> -    for (i =3D 1; i; i <<=3D 1)
> -      if (i & rtm_aux->rtm_addrs) {
> -	sa =3D (struct sockaddr *)cp;
> -	if (i =3D=3D RTA_GATEWAY )
> -	  gate =3D sa;
> -	ADVANCE(cp, sa);
> -      }
> -  }
> -  else
> -    {
> -      gc_free (&gc);
> -      return;
> -    }
> -
> -
> -  if (gate !=3D NULL )
> -    {
> -      rgi->gateway.addr =3D ntohl(((struct sockaddr_in *)gate)->sin_addr=
.s_addr);
> -      rgi->flags |=3D RGI_ADDR_DEFINED;
> -
> -      gc_free (&gc);
> -    }
> -  else
> -    {
> -      gc_free (&gc);
> -    }
> -}
> -
>  #else
>=20=20
>  /*
> --=20
> 1.8.3.2
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QRtLtq+kfJNLc57H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU3vB76kuBuNlUUl1AQK5tQP+L/fQC6PmkYrX4ctzK5XWQ1kfDqxl68aE
eluyI6cHb8NVHrWMuEugrQY+BK/tCACQhtZniIQ+EnL4N/GrYiFrjRs7t+wQOQfe
T7UUZtrU/5b7Lj10bWrTkYgWvizdU4HsxRjMB0b4l3k/BVjG6NSFxLpfsGAxwp44
Q1M0UUVJ05U=
=HD+r
-----END PGP SIGNATURE-----

--QRtLtq+kfJNLc57H--

