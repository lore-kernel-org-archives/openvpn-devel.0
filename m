Date: Mon, 26 Mar 2012 18:19:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326161943.GW1359@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSzmLLrdioqyxIBH"
Content-Disposition: inline
Subject: [Openvpn-devel] build failure on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--vSzmLLrdioqyxIBH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

we currently fail on OpenBSD (4.9) with this error message:

if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include  -I../../src/compat =
     -I/usr/include -I/usr/include     -g -O2 -MT tun.o -MD -MP -MF ".deps/=
tun.Tpo" -c -o tun.o tun.c;  then mv -f ".deps/tun.Tpo" ".deps/tun.Po"; els=
e rm -f ".deps/tun.Tpo"; exit 1; fi
tun.c: In function 'write_tun':
tun.c:2070: error: dereferencing pointer to incomplete type
*** Error code 1

which looks like

------------------------------------------
      struct ip *iph;

      iph =3D (struct ip *) buf;

      if (tt->ipv6 && iph->ip_v =3D=3D 6)   <<< here
------------------------------------------

"struct ip" is defined in <netinet/ip.h>, which "syshead.h" includes
in weird ways - "syshead.h" has 5 different

#ifdef HAVE_NETINET_IP_H
#include <netinet/ip.h>
#endif

stanzas, always inside #ifdef TARGET_SOMETHING blocks.  It does have such
a block for TARGET_OPENBSD, but configure doesn't find it:

checking for net/if.h... yes
checking for netinet/ip.h... no
checking for netinet/if_ether.h... no

The relevant section from config.log is here:

---------------------------- snip ---------------------------------
configure:21681: checking for netinet/ip.h
configure:21681: gcc -c -g -O2  conftest.c >&5
In file included from conftest.c:170:
/usr//include/netinet/ip.h:178: error: expected specifier-qualifier-list be=
fore
'n_time'
configure:21681: $? =3D 1
configure: failed program was:
---------------------------- snip ---------------------------------

which is defined in <netinet/in_systm.h> - which syshead.h already includes.

the full config log can be found on=20
  http://public.greenie.net/gert/openvpn/config-obsd49-20120326.log


I'd promise instead of trying to fix configure here, and since these
are inside well-understood #ifdef TARGET_<foo> things already, just=20
assume that "if it's *BSD, it will always have <netinet/ip.h>" and=20
don't bother running fragile tests from configure.

So that would turn syshead.h

#ifdef TARGET_OPENBSD

#ifdef HAVE_SYS_UIO_H
#include <sys/uio.h>
#endif

#ifdef HAVE_NETINET_IN_SYSTM_H
#include <netinet/in_systm.h>
#endif

#ifdef HAVE_NETINET_IP_H
#include <netinet/ip.h>
#endif

#ifdef HAVE_NET_IF_TUN_H
#include <net/if_tun.h>
#endif

#endif /* TARGET_OPENBSD */


into

#ifdef TARGET_OPENBSD

#include <sys/uio.h>
#include <netinet/in_systm.h>
#include <netinet/ip.h>
#include <net/if_tun.h>

#endif /* TARGET_OPENBSD */

... which is to the point, and works.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vSzmLLrdioqyxIBH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3CXH6kuBuNlUUl1AQJPgQP/flendn/K1T1p3Q4WOK74Duy/xer+lJSv
DTVU+Onf08SbCGuVDVpjt+Z1J2rgZgtKgWNTBus2njjQC6QSWKhHn6Pd6eyvcJcY
2pZ7z0W6COU0ZqXwxsbFw/9PQclMKy3CXLwczRHyqynOI6i7wvIspvS64qBppbqG
WWru7zTvpCM=
=HcNZ
-----END PGP SIGNATURE-----

--vSzmLLrdioqyxIBH--

