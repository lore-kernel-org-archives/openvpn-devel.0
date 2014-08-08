References: <mailman.289845.1407485493.2207.openvpn-devel@lists.sourceforge.net>
Message-ID: <1407524277.37295.YahooMailNeo@...1930...>
Date: Fri, 8 Aug 2014 11:57:57 -0700
From: randy bercheni <mom47303@...109...>
In-Reply-To: <mailman.289845.1407485493.2207.openvpn-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-1100835386-1270169471-1407524277=:37295"
Subject: Re: [Openvpn-devel] Openvpn-devel Digest, Vol 99, Issue 3
Reply-To: randy bercheni <mom47303@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

---1100835386-1270169471-1407524277=:37295
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

my vpn does not stay connected. I have to do it myself, sometimes that does=
 not work.



On Friday, August 8, 2014 4:12 AM, "openvpn-devel-request@...282...=
.net" <openvpn-devel-request@lists.sourceforge.net> wrote:
=20


Send Openvpn-devel mailing list submissions to
=A0=A0=A0 openvpn-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
=A0=A0=A0 https://lists.sourceforge.net/lists/listinfo/openvpn-devel
or, via email, send a message with subject or body 'help' to
=A0=A0=A0 openvpn-devel-request@lists.sourceforge.net

You can reach the person managing the list at
=A0=A0=A0 openvpn-devel-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Openvpn-devel digest..."


Today's Topics:

=A0  1. new OpenSSL Security Advisories (Mike Tancsa)
=A0  2. Re: new OpenSSL Security Advisories (Steffan Karger)
=A0  3. [PATCH] Tease apart ipv6 and ipv4 ifconfig code. (Gavin Shrubbery)
=A0  4. Impact of latest OpenSSL vulnerabilities to OpenVPN
=A0 =A0 =A0 (Samuli Sepp?nen)
=A0  5. Re: Impact of latest OpenSSL vulnerabilities to=A0=A0=A0 OpenVPN
=A0 =A0 =A0 (Samuli Sepp?nen)


----------------------------------------------------------------------

Message: 1
Date: Thu, 07 Aug 2014 17:11:47 -0400
From: Mike Tancsa <mike@...1800...>
Subject: [Openvpn-devel] new OpenSSL Security Advisories
To: "openvpn-devel@lists.sourceforge.net"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>
Message-ID: <53E3EB93.5090108@...1800...>
Content-Type: text/plain; charset=3Dutf-8; format=3Dflowed

Has anyone had a chance to evaluate the latest security issues and how=20
they might impact OpenVPN ?

https://www.openssl.org/news/secadv_20140806.txt


--=20
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada=A0 http://www.tancsa.com/



------------------------------

Message: 2
Date: Thu, 07 Aug 2014 23:33:02 +0200
From: Steffan Karger <steffan@...1856...>
Subject: Re: [Openvpn-devel] new OpenSSL Security Advisories
To: openvpn-devel@lists.sourceforge.net
Message-ID: <53E3F08E.40309@...1856...>
Content-Type: text/plain; charset=3Dwindows-1252

Hi,

On 07-08-14 23:11, Mike Tancsa wrote:
> Has anyone had a chance to evaluate the latest security issues and how=20
> they might impact OpenVPN ?
>=20
> https://www.openssl.org/news/secadv_20140806.txt

Yes, announcement on the wiki:
https://community.openvpn.net/openvpn/wiki/VulnerabilitiesFixedInOpenSSL1.0=
.1i

tl;dr: You're probably not affected.

-Steffan



------------------------------

Message: 3
Date: Fri,=A0 8 Aug 2014 11:10:32 +1200
From: Gavin Shrubbery <gavin.shrubbery@...277...>
Subject: [Openvpn-devel] [PATCH] Tease apart ipv6 and ipv4 ifconfig
=A0=A0=A0 code.
To: openvpn-devel@lists.sourceforge.net
Message-ID:
=A0=A0=A0 <1407453032-588-1-git-send-email-gavin.shrubbery@...277...>

This change makes it possible to configure an IPv6 address on a
tunnel without also having an IPv4 address.

Signed-off-by: Gavin Shrubbery <gavin.shrubbery@...277...>
---
src/openvpn/tun.c | 367 +++++++++++++++++++++++++++------------------------=
---
1 file changed, 183 insertions(+), 184 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ba4b15e..d1a8a03 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -634,16 +634,10 @@ do_ifconfig (struct tuntap *tt,
=A0 =A0 =A0  const char *ifconfig_local =3D NULL;
=A0 =A0 =A0  const char *ifconfig_remote_netmask =3D NULL;
=A0 =A0 =A0  const char *ifconfig_broadcast =3D NULL;
-=A0 =A0 =A0 const char *ifconfig_ipv6_local =3D NULL;
-=A0 =A0 =A0 const char *ifconfig_ipv6_remote =3D NULL;
-=A0 =A0 =A0 bool do_ipv6 =3D false;
=A0 =A0 =A0  struct argv argv;

=A0 =A0 =A0  argv_init (&argv);

-=A0 =A0 =A0 msg( M_INFO, "do_ifconfig, tt->ipv6=3D%d, tt->did_ifconfig_ipv=
6_setup=3D%d",
-=A0=A0=A0 =A0 =A0 =A0 =A0 =A0  tt->ipv6, tt->did_ifconfig_ipv6_setup );
-
=A0 =A0 =A0  /*
=A0 =A0 =A0 =A0 * We only handle TUN/TAP devices here, not --dev null devic=
es.
=A0 =A0 =A0 =A0 */
@@ -655,13 +649,6 @@ do_ifconfig (struct tuntap *tt,
=A0 =A0 =A0  ifconfig_local =3D print_in_addr_t (tt->local, 0, &gc);
=A0 =A0 =A0  ifconfig_remote_netmask =3D print_in_addr_t (tt->remote_netmas=
k, 0, &gc);

-=A0 =A0 =A0 if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
-=A0 =A0 =A0 =A0 {
-=A0=A0=A0 =A0 ifconfig_ipv6_local =3D print_in6_addr (tt->local_ipv6, 0, &=
gc);
-=A0=A0=A0 =A0 ifconfig_ipv6_remote =3D print_in6_addr (tt->remote_ipv6, 0,=
 &gc);
-=A0=A0=A0 =A0 do_ipv6 =3D true;
-=A0=A0=A0 }
-
=A0 =A0 =A0  /*
=A0 =A0 =A0 =A0 * If TAP-style device, generate broadcast address.
=A0 =A0 =A0 =A0 */
@@ -679,7 +666,6 @@ do_ifconfig (struct tuntap *tt,
=A0 =A0  }
#endif

-
#if defined(TARGET_LINUX)
#ifdef ENABLE_IPROUTE
=A0=A0=A0 /*
@@ -720,19 +706,6 @@ do_ifconfig (struct tuntap *tt,
=A0=A0=A0 =A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
=A0=A0=A0 =A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "Linux ip=
 addr add failed");
=A0=A0=A0 }
-=A0 =A0 =A0 if ( do_ipv6 )
-=A0=A0=A0 {
-=A0=A0=A0 =A0 argv_printf( &argv,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 "%s -6 addr add %s/%d dev %s",
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 iproute_path,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 ifconfig_ipv6_local,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 tt->netbits_ipv6,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 actual
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr =
add failed");
-=A0=A0=A0 }
-=A0 =A0 =A0 tt->did_ifconfig =3D true;
#else
=A0 =A0 =A0  if (tun)
=A0=A0=A0 argv_printf (&argv,
@@ -755,21 +728,8 @@ do_ifconfig (struct tuntap *tt,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 );
=A0 =A0 =A0  argv_msg (M_INFO, &argv);
=A0 =A0 =A0  openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig fail=
ed");
-=A0 =A0 =A0 if ( do_ipv6 )
-=A0=A0=A0 {
-=A0=A0=A0 =A0 argv_printf (&argv,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 "%s %s add %s/%d",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 actual,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig in=
et6 failed");
-=A0=A0=A0 }
-=A0 =A0 =A0 tt->did_ifconfig =3D true;
-
#endif /*ENABLE_IPROUTE*/
+=A0 =A0 =A0 tt->did_ifconfig =3D true;
#elif defined(TARGET_SOLARIS)

=A0 =A0 =A0  /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -824,52 +784,6 @@ do_ifconfig (struct tuntap *tt,
=A0 =A0 =A0  if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig pha=
se-2 failed"))
=A0=A0=A0 solaris_error_close (tt, es, actual, false);

-=A0 =A0 =A0 if ( do_ipv6 )
-=A0 =A0 =A0 =A0 {
- =A0=A0=A0 =A0 argv_printf (&argv, "%s %s inet6 unplumb",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 IFCONFIG_PATH, actual );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, 0, NULL);
-
-=A0=A0=A0 =A0 if ( tt->type =3D=3D DEV_TYPE_TUN )
-=A0=A0=A0 =A0  {
-=A0=A0=A0 =A0 =A0 =A0 argv_printf (&argv,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 "%s %s inet6 plumb %s/%d %s up",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 IFCONFIG_PATH,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 actual,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 ifconfig_ipv6_local,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 tt->netbits_ipv6,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 ifconfig_ipv6_remote
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 );
-=A0=A0=A0 =A0 =A0 }
-=A0=A0=A0 =A0 else=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 /* tap mode */
-=A0=A0=A0 =A0 =A0 {
-=A0=A0=A0 =A0 =A0 =A0 /* base IPv6 tap interface needs to be brought up fi=
rst
-=A0=A0=A0 =A0 =A0 =A0  */
-=A0=A0=A0 =A0 =A0 =A0 argv_printf (&argv, "%s %s inet6 plumb up",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 IFCONFIG_PATH, actual );
-=A0=A0=A0 =A0 =A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 =A0 =A0 if (!openvpn_execve_check (&argv, es, 0, "Solaris if=
config IPv6 (prepare) failed"))
-=A0=A0=A0 =A0=A0=A0 solaris_error_close (tt, es, actual, true);
-
-=A0=A0=A0 =A0 =A0 =A0 /* we might need to do "ifconfig %s inet6 auto-dhcp =
drop"
-=A0=A0=A0 =A0 =A0 =A0  * after the system has noticed the interface and fi=
red up
-=A0=A0=A0 =A0 =A0 =A0  * the DHCPv6 client - but this takes quite a while,=
 and the=20
-=A0=A0=A0 =A0 =A0 =A0  * server will ignore the DHCPv6 packets anyway.=A0 =
So we don't.
-=A0=A0=A0 =A0 =A0 =A0  */
-
-=A0=A0=A0 =A0 =A0 =A0 /* static IPv6 addresses need to go to a subinterfac=
e (tap0:1)
-=A0=A0=A0 =A0 =A0 =A0  */
-=A0=A0=A0 =A0 =A0 =A0 argv_printf (&argv,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 "%s %s inet6 addif %s/%d up",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 IFCONFIG_PATH, actual,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 ifconfig_ipv6_local, tt->netbits_ipv=
6 );
-=A0=A0=A0 =A0 =A0 }
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig I=
Pv6 failed"))
-=A0=A0=A0 =A0 =A0 solaris_error_close (tt, es, actual, true);
-=A0 =A0 =A0 =A0 }
-
=A0 =A0 =A0  if (!tun && tt->topology =3D=3D TOP_SUBNET)
=A0=A0=A0 {
=A0=A0=A0 =A0 /* Add a network route for the local tun interface */
@@ -928,32 +842,9 @@ do_ifconfig (struct tuntap *tt,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 );
=A0 =A0 =A0  argv_msg (M_INFO, &argv);
=A0 =A0 =A0  openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig fa=
iled");
-=A0 =A0 =A0 if ( do_ipv6 )
-=A0=A0=A0 {
-=A0=A0=A0 =A0 argv_printf (&argv,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 "%s %s inet6 %s/%d",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 actual,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig =
inet6 failed");

-=A0=A0=A0 =A0 /* and, hooray, we explicitely need to add a route... */
-=A0=A0=A0 =A0 add_route_connected_v6_net(tt, es);
-=A0=A0=A0 }
=A0 =A0 =A0  tt->did_ifconfig =3D true;
-
#elif defined(TARGET_NETBSD)
-
-/* whether or not NetBSD can do IPv6 can be seen by the availability of
- * the TUNSIFHEAD ioctl() - see next TARGET_NETBSD block for more details
- */
-#ifdef TUNSIFHEAD
-# define NETBSD_MULTI_AF
-#endif
-
=A0 =A0 =A0  if (tun)
=A0=A0=A0 argv_printf (&argv,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 "%s %s %s %s mtu %d netmask 255.255.255.2=
55 up",
@@ -994,26 +885,6 @@ do_ifconfig (struct tuntap *tt,
=A0 =A0 =A0  argv_msg (M_INFO, &argv);
=A0 =A0 =A0  openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig fai=
led");

-=A0 =A0 =A0 if ( do_ipv6 )
-=A0=A0=A0 {
-#ifdef NETBSD_MULTI_AF
-=A0=A0=A0 =A0 argv_printf (&argv,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 "%s %s inet6 %s/%d",
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 actual,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig i=
net6 failed");
-
-=A0=A0=A0 =A0 /* and, hooray, we explicitely need to add a route... */
-=A0=A0=A0 =A0 add_route_connected_v6_net(tt, es);
-#else
-=A0=A0=A0 =A0 msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD b=
efore 4.0 (if your system is newer, recompile openvpn)" );
-=A0=A0=A0 =A0 tt->ipv6 =3D false;
-#endif
-=A0=A0=A0 }
=A0 =A0 =A0  tt->did_ifconfig =3D true;

#elif defined(TARGET_DARWIN)
@@ -1079,22 +950,6 @@ do_ifconfig (struct tuntap *tt,
=A0=A0=A0 =A0 add_route (&r, tt, 0, NULL, es);
=A0=A0=A0 }

-=A0 =A0 =A0 if ( do_ipv6 )
-=A0=A0=A0 {
-=A0 =A0 =A0 =A0 =A0 argv_printf (&argv,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s %s inet6 %=
s/%d",
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IFCONFIG_PATH,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 actual,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ifconfig_ipv6_=
local,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tt->netbits_ip=
v6
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "MacOS X ifconfig =
inet6 failed");
-
-=A0=A0=A0 =A0 /* and, hooray, we explicitely need to add a route... */
-=A0=A0=A0 =A0 add_route_connected_v6_net(tt, es);
-=A0=A0=A0 }
-
#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)

=A0 =A0 =A0  /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 2=
55.255.255.255 up */
@@ -1145,19 +1000,6 @@ do_ifconfig (struct tuntap *tt,
=A0 =A0 =A0 =A0 =A0  add_route (&r, tt, 0, NULL, es);
=A0 =A0 =A0 =A0  }

-=A0 =A0 =A0 if ( do_ipv6 )
-=A0=A0=A0 {
-=A0 =A0 =A0 =A0 =A0 argv_printf (&argv,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s %s inet6 %=
s/%d",
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IFCONFIG_PATH,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 actual,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ifconfig_ipv6_=
local,
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tt->netbits_ip=
v6
-=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
-=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
-=A0=A0=A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig =
inet6 failed");
-=A0=A0=A0 }
-
#elif defined (WIN32)
=A0 =A0 =A0  {
=A0=A0=A0 /*
@@ -1196,35 +1038,192 @@ do_ifconfig (struct tuntap *tt,
=A0=A0=A0 =A0 }
=A0=A0=A0 tt->did_ifconfig =3D true;
=A0 =A0 =A0  }
+#else
+=A0 =A0 =A0 msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' co=
mmands on this operating system.=A0 You should ifconfig your TUN/TAP device=
 manually or use an --up script.");
+#endif
+=A0 =A0 =A0 argv_reset (&argv);
+=A0 }

-=A0 =A0 /* IPv6 always uses "netsh" interface */
-=A0 =A0 if ( do_ipv6 )
-=A0 =A0 =A0 {
-=A0=A0=A0 char * saved_actual;
+=A0 if (tt->ipv6 && tt->did_ifconfig_ipv6_setup)
+=A0 =A0 {
+=A0 =A0 =A0 const char *ifconfig_ipv6_local =3D NULL;
+=A0 =A0 =A0 const char *ifconfig_ipv6_remote =3D NULL;

-=A0=A0=A0 if (!strcmp (actual, "NULL"))
-=A0=A0=A0 =A0 msg (M_FATAL, "Error: When using --tun-ipv6, if you have mor=
e than one TAP-Windows adapter, you must also specify --dev-node");
+=A0 =A0 =A0 struct argv argv;

-=A0=A0=A0 /* example: netsh interface ipv6 set address MyTap 2001:608:8003=
::d store=3Dactive */
-=A0=A0=A0 argv_printf (&argv,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0 "%s%sc interface ipv6 set address %s %s store=
=3Dactive",
-=A0=A0=A0 =A0=A0=A0 =A0 =A0  get_win_sys_path(),
-=A0=A0=A0 =A0=A0=A0 =A0 =A0  NETSH_PATH_SUFFIX,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0  actual,
-=A0=A0=A0 =A0=A0=A0 =A0 =A0  ifconfig_ipv6_local );
+=A0 =A0 =A0 argv_init (&argv);

-=A0=A0=A0 netsh_command (&argv, 4);
+=A0 =A0 =A0 msg( M_INFO, "do_ifconfig, tt->ipv6=3D%d, tt->did_ifconfig_ipv=
6_setup=3D%d",
+=A0=A0=A0 =A0 =A0 =A0 =A0 =A0  tt->ipv6, tt->did_ifconfig_ipv6_setup );

-=A0=A0=A0 /* explicit route needed */
-=A0=A0=A0 /* on windows, OpenVPN does ifconfig first, open_tun later, so
-=A0=A0=A0  * tt->actual_name might not yet be initialized, but routing code
-=A0=A0=A0  * needs to know interface name - point to "actual", restore lat=
er
-=A0=A0=A0  */
-=A0=A0=A0 saved_actual =3D tt->actual_name;
-=A0=A0=A0 tt->actual_name =3D (char*) actual;
-=A0=A0=A0 add_route_connected_v6_net(tt, es);
-=A0=A0=A0 tt->actual_name =3D saved_actual;
-=A0 =A0 =A0 }
+=A0 =A0 =A0 ifconfig_ipv6_local =3D print_in6_addr (tt->local_ipv6, 0, &gc=
);
+=A0 =A0 =A0 ifconfig_ipv6_remote =3D print_in6_addr (tt->remote_ipv6, 0, &=
gc);
+
+#if defined(TARGET_LINUX)
+#ifdef ENABLE_IPROUTE
+=A0 =A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 "%s -6 addr add %s/%d dev %s",
+=A0=A0=A0 =A0=A0=A0 =A0 iproute_path,
+=A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
+=A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6,
+=A0=A0=A0 =A0=A0=A0 =A0 actual
+=A0=A0=A0 =A0=A0=A0 =A0 );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr ad=
d failed");
+#else
+=A0 =A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 "%s %s add %s/%d",
+=A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH,
+=A0=A0=A0 =A0=A0=A0 =A0 actual,
+=A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
+=A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6
+=A0=A0=A0 =A0=A0=A0 =A0 );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "Linux ifconfig inet=
6 failed");
+#endif /*ENABLE_IPROUTE*/
+#elif defined(TARGET_SOLARIS)
+
+=A0 =A0 =A0 argv_printf (&argv, "%s %s inet6 unplumb",
+=A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH, actual );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, 0, NULL);
+
+=A0 =A0 =A0 if ( tt->type =3D=3D DEV_TYPE_TUN )
+=A0=A0=A0 {
+=A0=A0=A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 "%s %s inet6 plumb %s/%d %s up",
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 IFCONFIG_PATH,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 actual,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 ifconfig_ipv6_local,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 tt->netbits_ipv6,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 ifconfig_ipv6_remote
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 );
+=A0=A0=A0 }
+=A0 =A0 =A0 else=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 /* tap mode */
+=A0=A0=A0 {
+=A0=A0=A0 =A0 /* base IPv6 tap interface needs to be brought up first
+=A0=A0=A0 =A0  */
+=A0=A0=A0 =A0 argv_printf (&argv, "%s %s inet6 plumb up",
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 IFCONFIG_PATH, actual );
+=A0=A0=A0 =A0 argv_msg (M_INFO, &argv);
+=A0=A0=A0 =A0 if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig I=
Pv6 (prepare) failed"))
+=A0=A0=A0 =A0 =A0 solaris_error_close (tt, es, actual, true);
+
+=A0=A0=A0 =A0 /* we might need to do "ifconfig %s inet6 auto-dhcp drop"
+=A0=A0=A0 =A0  * after the system has noticed the interface and fired up
+=A0=A0=A0 =A0  * the DHCPv6 client - but this takes quite a while, and the=
=20
+=A0=A0=A0 =A0  * server will ignore the DHCPv6 packets anyway.=A0 So we do=
n't.
+=A0=A0=A0 =A0  */
+
+=A0=A0=A0 =A0 /* static IPv6 addresses need to go to a subinterface (tap0:=
1)
+=A0=A0=A0 =A0  */
+=A0=A0=A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 "%s %s inet6 addif %s/%d up",
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 IFCONFIG_PATH, actual,
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 ifconfig_ipv6_local, tt->netbits_ipv6 );
+=A0=A0=A0 }
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig IPv=
6 failed"))
+=A0=A0=A0 solaris_error_close (tt, es, actual, true);
+
+#elif defined(TARGET_OPENBSD)
+
+=A0 =A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 "%s %s inet6 %s/%d",
+=A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH,
+=A0=A0=A0 =A0=A0=A0 =A0 actual,
+=A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
+=A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6
+=A0=A0=A0 =A0=A0=A0 =A0 );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "OpenBSD ifconfig in=
et6 failed");
+
+=A0 =A0 =A0 /* and, hooray, we explicitely need to add a route... */
+=A0 =A0 =A0 add_route_connected_v6_net(tt, es);
+
+#elif defined(TARGET_NETBSD)
+
+/* whether or not NetBSD can do IPv6 can be seen by the availability of
+ * the TUNSIFHEAD ioctl() - see next TARGET_NETBSD block for more details
+ */
+#ifdef TUNSIFHEAD
+# define NETBSD_MULTI_AF
+#endif
+
+#ifdef NETBSD_MULTI_AF
+=A0 =A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 "%s %s inet6 %s/%d",
+=A0=A0=A0 =A0=A0=A0 =A0 IFCONFIG_PATH,
+=A0=A0=A0 =A0=A0=A0 =A0 actual,
+=A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local,
+=A0=A0=A0 =A0=A0=A0 =A0 tt->netbits_ipv6
+=A0=A0=A0 =A0=A0=A0 =A0 );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig ine=
t6 failed");
+
+=A0 =A0 =A0 /* and, hooray, we explicitely need to add a route... */
+=A0 =A0 =A0 add_route_connected_v6_net(tt, es);
+#else
+=A0 =A0 =A0 msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD bef=
ore 4.0 (if your system is newer, recompile openvpn)" );
+=A0 =A0 =A0 tt->ipv6 =3D false;
+#endif
+
+#elif defined(TARGET_DARWIN)
+=A0 =A0 =A0 /*
+=A0 =A0 =A0  * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour t=
o OpenBSD...
+=A0 =A0 =A0  */
+=A0 =A0 =A0 argv_printf (&argv,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s %s inet6 %s/%d",
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IFCONFIG_PATH,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 actual,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ifconfig_ipv6_local,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tt->netbits_ipv6
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "MacOS X ifconfig in=
et6 failed");
+
+=A0 =A0 =A0 /* and, hooray, we explicitely need to add a route... */
+=A0 =A0 =A0 add_route_connected_v6_net(tt, es);
+
+
+#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+
+=A0 =A0 =A0 argv_printf (&argv,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s %s inet6 %s/%d",
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IFCONFIG_PATH,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 actual,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ifconfig_ipv6_local,
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tt->netbits_ipv6
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
+=A0 =A0 =A0 argv_msg (M_INFO, &argv);
+=A0 =A0 =A0 openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig in=
et6 failed");
+
+#elif defined (WIN32)
+=A0 =A0 =A0 /* IPv6 always uses "netsh" interface */
+=A0 =A0 =A0 char * saved_actual;
+
+=A0 =A0 =A0 if (!strcmp (actual, "NULL"))
+=A0 =A0 =A0 =A0 msg (M_FATAL, "Error: When using --tun-ipv6, if you have m=
ore than one TAP-Windows adapter, you must also specify --dev-node");
+
+=A0 =A0 =A0 /* example: netsh interface ipv6 set address MyTap 2001:608:80=
03::d store=3Dactive */
+=A0 =A0 =A0 argv_printf (&argv,
+=A0=A0=A0 =A0=A0=A0 =A0 "%s%sc interface ipv6 set address %s %s store=3Dac=
tive",
+=A0=A0=A0 =A0=A0=A0 =A0 get_win_sys_path(),
+=A0=A0=A0 =A0=A0=A0 =A0 NETSH_PATH_SUFFIX,
+=A0=A0=A0 =A0=A0=A0 =A0 actual,
+=A0=A0=A0 =A0=A0=A0 =A0 ifconfig_ipv6_local );
+
+=A0 =A0 =A0 netsh_command (&argv, 4);
+
+=A0 =A0 =A0 /* explicit route needed */
+=A0 =A0 =A0 /* on windows, OpenVPN does ifconfig first, open_tun later, so
+=A0 =A0 =A0  * tt->actual_name might not yet be initialized, but routing c=
ode
+=A0 =A0 =A0  * needs to know interface name - point to "actual", restore l=
ater
+=A0 =A0 =A0  */
+=A0 =A0 =A0 saved_actual =3D tt->actual_name;
+=A0 =A0 =A0 tt->actual_name =3D (char*) actual;
+=A0 =A0 =A0 add_route_connected_v6_net(tt, es);
+=A0 =A0 =A0 tt->actual_name =3D saved_actual;
#else
=A0 =A0 =A0  msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' co=
mmands on this operating system.=A0 You should ifconfig your TUN/TAP device=
 manually or use an --up script.");
#endif
@@ -4932,7 +4931,7 @@ open_tun (const char *dev, const char *dev_type, cons=
t char *dev_node, struct tu

=A0  if (tt->type =3D=3D DEV_TYPE_TUN)
=A0 =A0  {
-=A0 =A0 =A0 if (!tt->did_ifconfig_setup)
+=A0 =A0 =A0 if (!(tt->did_ifconfig_setup || tt->did_ifconfig_ipv6_setup))
=A0=A0=A0 {
=A0=A0=A0 =A0 msg (M_FATAL, "ERROR: --dev tun also requires --ifconfig");
=A0=A0=A0 }
--=20
2.0.2




------------------------------

Message: 4
Date: Fri, 08 Aug 2014 10:10:42 +0300
From: Samuli Sepp?nen <samuli@...515...>
Subject: [Openvpn-devel] Impact of latest OpenSSL vulnerabilities to
=A0=A0=A0 OpenVPN
To: "openvpn-devel@lists.sourceforge.net"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>,
=A0=A0=A0 "openvpn-users@lists.sourceforge.net"
=A0=A0=A0 <openvpn-users@lists.sourceforge.net>,
=A0=A0=A0 "openvpn-announce@lists.sourceforge.net"
=A0=A0=A0 <openvpn-announce@lists.sourceforge.net>
Message-ID: <53E477F2.8080003@...515...>
Content-Type: text/plain; charset=3Diso-8859-15


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

Information on how the latest OpenSSL vulnerabilities affect OpenVPN is
available here:

<https://community.openvpn.net/openvpn/wiki/VulnerabilitiesFixedInOpenSSL1.=
0.1i>

Yesterday's Windows installer releases bundle OpenSSL 1.0.0i, which is
immune to the two issues which may[1] affect OpenVPN. Updated installers
are available here:

<http://openvpn.net/index.php/download/community-downloads.html>

Best regards,

- --=20
Samuli Sepp?nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] Depending on it's configuration
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPkd/IACgkQwp2X7RmNIqOoWwCeLR13x//Vxm4LRXilRlwkxhtP
XcoAoMwIn+y3iYkofgL9TFiIK4YGMOK8
=3DmsAA
-----END PGP SIGNATURE-----




------------------------------

Message: 5
Date: Fri, 08 Aug 2014 11:11:23 +0300
From: Samuli Sepp?nen <samuli@...515...>
Subject: Re: [Openvpn-devel] Impact of latest OpenSSL vulnerabilities
=A0=A0=A0 to=A0=A0=A0 OpenVPN
To: "openvpn-devel@lists.sourceforge.net"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>,
=A0=A0=A0 "openvpn-users@lists.sourceforge.net"
=A0=A0=A0 <openvpn-users@lists.sourceforge.net>,
=A0=A0=A0 "openvpn-announce@lists.sourceforge.net"
=A0=A0=A0 <openvpn-announce@lists.sourceforge.net>
Message-ID: <53E4862B.1080709@...515...>
Content-Type: text/plain; charset=3Diso-8859-15


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



> Hi all,
>
> Information on how the latest OpenSSL vulnerabilities affect OpenVPN is
> available here:
>
>
<https://community.openvpn.net/openvpn/wiki/VulnerabilitiesFixedInOpenSSL1.=
0.1i>
>
> Yesterday's Windows installer releases bundle OpenSSL 1.0.0i, which is
> immune to the two issues which may[1] affect OpenVPN. Updated installers
> are available here:
>
Responding to myself before somebody else corrects me. The Windows
installers bundle 1.0.1i (not 1.0.0i).

Sorry for the noise.
- --=20
Samuli Sepp?nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPkhisACgkQwp2X7RmNIqPKIgCeNsM6/3Z1Y9IDMMOYKQztHeWQ
76cAn1t8clBRaBWhhEAY2pYI8LHbzjSC
=3DXS4x
-----END PGP SIGNATURE-----




------------------------------

---------------------------------------------------------------------------=
---
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds

------------------------------

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


End of Openvpn-devel Digest, Vol 99, Issue 3
********************************************=

---1100835386-1270169471-1407524277=:37295
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;fo=
nt-size:12pt"><div><span>my vpn does not stay connected. I have to do it my=
self, sometimes that does not work.<br></span></div> <div class=3D"qtdSepar=
ateBR"><br><br></div><div style=3D"display: block;" class=3D"yahoo_quoted">=
 <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial=
, Lucida Grande, sans-serif; font-size: 12pt;"> <div style=3D"font-family: =
HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;=
 font-size: 12pt;"> <div dir=3D"ltr"> <font face=3D"Arial" size=3D"2"> On F=
riday, August 8, 2014 4:12 AM, "openvpn-devel-request@lists.sourceforge.net=
" &lt;openvpn-devel-request@lists.sourceforge.net&gt; wrote:<br> </font> </=
div>  <br><br> <div class=3D"y_msg_container">Send Openvpn-devel mailing li=
st submissions to<br>&nbsp;&nbsp;&nbsp; <a
 ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net" href=3D"mailto:open=
vpn-devel@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</a><br=
><br>To subscribe or unsubscribe via the World Wide Web, visit<br>&nbsp;&nb=
sp;&nbsp; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-d=
evel" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvp=
n-devel</a><br>or, via email, send a message with subject or body 'help' to=
<br>&nbsp;&nbsp;&nbsp; <a ymailto=3D"mailto:openvpn-devel-request@...1885...=
rceforge.net" href=3D"mailto:openvpn-devel-request@lists.sourceforge.net">o=
penvpn-devel-request@lists.sourceforge.net</a><br><br>You can reach the per=
son managing the list at<br>&nbsp;&nbsp;&nbsp; <a ymailto=3D"mailto:openvpn=
-devel-owner@lists.sourceforge.net" href=3D"mailto:openvpn-devel-owner@...1514...=
s.sourceforge.net">openvpn-devel-owner@lists.sourceforge.net</a><br><br>Whe=
n replying, please edit your Subject line so it is more specific<br>than "R=
e:
 Contents of Openvpn-devel digest..."<br><br><br>Today's Topics:<br><br>&nb=
sp;  1. new OpenSSL Security Advisories (Mike Tancsa)<br>&nbsp;  2. Re: new=
 OpenSSL Security Advisories (Steffan Karger)<br>&nbsp;  3. [PATCH] Tease a=
part ipv6 and ipv4 ifconfig code. (Gavin Shrubbery)<br>&nbsp;  4. Impact of=
 latest OpenSSL vulnerabilities to OpenVPN<br>&nbsp; &nbsp; &nbsp; (Samuli =
Sepp?nen)<br>&nbsp;  5. Re: Impact of latest OpenSSL vulnerabilities to&nbs=
p;&nbsp;&nbsp; OpenVPN<br>&nbsp; &nbsp; &nbsp; (Samuli Sepp?nen)<br><br><br=
>----------------------------------------------------------------------<br>=
<br>Message: 1<br>Date: Thu, 07 Aug 2014 17:11:47 -0400<br>From: Mike Tancs=
a &lt;<a ymailto=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1800..."=
>mike@...1800...</a>&gt;<br>Subject: [Openvpn-devel] new OpenSSL Security A=
dvisories<br>To: "<a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net"
 href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1466...=
urceforge.net</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-d=
evel@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...290...=
net">openvpn-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a ymai=
lto=3D"mailto:53E3EB93.5090108@...1800..." href=3D"mailto:53E3EB93.5090108@=
...1800...">53E3EB93.5090108@...1800...</a>&gt;<br>Content-Type: text/plain=
; charset=3Dutf-8; format=3Dflowed<br><br>Has anyone had a chance to evalua=
te the latest security issues and how <br>they might impact OpenVPN ?<br><b=
r><a href=3D"https://www.openssl.org/news/secadv_20140806.txt" target=3D"_b=
lank">https://www.openssl.org/news/secadv_20140806.txt</a><br><br><br>-- <b=
r>-------------------<br>Mike Tancsa, tel +1 519 651 3400<br>Sentex Communi=
cations, <a ymailto=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1931...=
..">mike@...1800...</a><br>Providing Internet services since 1994
 www.sentex.net<br>Cambridge, Ontario Canada&nbsp;  <a href=3D"http://www.t=
ancsa.com/" target=3D"_blank">http://www.tancsa.com/</a><br><br><br><br>---=
---------------------------<br><br>Message: 2<br>Date: Thu, 07 Aug 2014 23:=
33:02 +0200<br>From: Steffan Karger &lt;<a ymailto=3D"mailto:steffan@...1852...=
6..." href=3D"mailto:steffan@...1856...">steffan@...1856...</a>&gt;<br>Subj=
ect: Re: [Openvpn-devel] new OpenSSL Security Advisories<br>To: <a ymailto=
=3D"mailto:openvpn-devel@lists.sourceforge.net" href=3D"mailto:openvpn-deve=
l@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</a><br>Message=
-ID: &lt;<a ymailto=3D"mailto:53E3F08E.40309@...1856..." href=3D"mailto:53E=
3F08E.40309@...1856...">53E3F08E.40309@...1856...</a>&gt;<br>Content-Type: =
text/plain; charset=3Dwindows-1252<br><br>Hi,<br><br>On 07-08-14 23:11, Mik=
e Tancsa wrote:<br>&gt; Has anyone had a chance to evaluate the latest secu=
rity issues and how <br>&gt; they might impact OpenVPN ?<br>&gt; <br>&gt; <a
 href=3D"https://www.openssl.org/news/secadv_20140806.txt" target=3D"_blank=
">https://www.openssl.org/news/secadv_20140806.txt</a><br><br>Yes, announce=
ment on the wiki:<br><a href=3D"https://community.openvpn.net/openvpn/wiki/=
VulnerabilitiesFixedInOpenSSL1.0.1i" target=3D"_blank">https://community.op=
envpn.net/openvpn/wiki/VulnerabilitiesFixedInOpenSSL1.0.1i</a><br><br>tl;dr=
: You're probably not affected.<br><br>-Steffan<br><br><br><br>------------=
------------------<br><br>Message: 3<br>Date: Fri,&nbsp; 8 Aug 2014 11:10:3=
2 +1200<br>From: Gavin Shrubbery &lt;<a ymailto=3D"mailto:gavin.shrubbery@...220...=
..277..." href=3D"mailto:gavin.shrubbery@...277...">gavin.shrubbery@...1354...=
..</a>&gt;<br>Subject: [Openvpn-devel] [PATCH] Tease apart ipv6 and ipv4 if=
config<br>&nbsp;&nbsp;&nbsp; code.<br>To: <a ymailto=3D"mailto:openvpn-deve=
l@lists.sourceforge.net" href=3D"mailto:openvpn-devel@lists.sourceforge.net=
">openvpn-devel@lists.sourceforge.net</a><br>Message-ID:<br>&nbsp;&nbsp;&nb=
sp;
 &lt;<a ymailto=3D"mailto:1407453032-588-1-git-send-email-gavin.shrubbery@...220...=
..277..." href=3D"mailto:1407453032-588-1-git-send-email-gavin.shrubbery@...1186...=
.277...">1407453032-588-1-git-send-email-gavin.shrubbery@...277...</a>&gt;<=
br><br>This change makes it possible to configure an IPv6 address on a<br>t=
unnel without also having an IPv4 address.<br><br>Signed-off-by: Gavin Shru=
bbery &lt;<a ymailto=3D"mailto:gavin.shrubbery@...277..." href=3D"mailto:ga=
vin.shrubbery@...277...">gavin.shrubbery@...277...</a>&gt;<br>---<br> src/o=
penvpn/tun.c | 367 +++++++++++++++++++++++++++---------------------------<b=
r> 1 file changed, 183 insertions(+), 184 deletions(-)<br><br>diff --git a/=
src/openvpn/tun.c b/src/openvpn/tun.c<br>index ba4b15e..d1a8a03 100644<br>-=
-- a/src/openvpn/tun.c<br>+++ b/src/openvpn/tun.c<br>@@ -634,16 +634,10 @@ =
do_ifconfig (struct tuntap *tt,<br>&nbsp; &nbsp; &nbsp;  const char *ifconf=
ig_local =3D NULL;<br>&nbsp; &nbsp; &nbsp;  const char
 *ifconfig_remote_netmask =3D NULL;<br>&nbsp; &nbsp; &nbsp;  const char *if=
config_broadcast =3D NULL;<br>-&nbsp; &nbsp; &nbsp; const char *ifconfig_ip=
v6_local =3D NULL;<br>-&nbsp; &nbsp; &nbsp; const char *ifconfig_ipv6_remot=
e =3D NULL;<br>-&nbsp; &nbsp; &nbsp; bool do_ipv6 =3D false;<br>&nbsp; &nbs=
p; &nbsp;  struct argv argv;<br> <br>&nbsp; &nbsp; &nbsp;  argv_init (&amp;=
argv);<br> <br>-&nbsp; &nbsp; &nbsp; msg( M_INFO, "do_ifconfig, tt-&gt;ipv6=
=3D%d, tt-&gt;did_ifconfig_ipv6_setup=3D%d",<br>-&nbsp;&nbsp;&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;  tt-&gt;ipv6, tt-&gt;did_ifconfig_ipv6_setup );=
<br>-<br>&nbsp; &nbsp; &nbsp;  /*<br>&nbsp; &nbsp; &nbsp; &nbsp; * We only =
handle TUN/TAP devices here, not --dev null devices.<br>&nbsp; &nbsp; &nbsp=
; &nbsp; */<br>@@ -655,13 +649,6 @@ do_ifconfig (struct tuntap *tt,<br>&nbs=
p; &nbsp; &nbsp;  ifconfig_local =3D print_in_addr_t (tt-&gt;local, 0, &amp=
;gc);<br>&nbsp; &nbsp; &nbsp;  ifconfig_remote_netmask =3D print_in_addr_t
 (tt-&gt;remote_netmask, 0, &amp;gc);<br> <br>-&nbsp; &nbsp; &nbsp; if ( tt=
-&gt;ipv6 &amp;&amp; tt-&gt;did_ifconfig_ipv6_setup )<br>-&nbsp; &nbsp; &nb=
sp; &nbsp; {<br>-&nbsp;&nbsp;&nbsp; &nbsp; ifconfig_ipv6_local =3D print_in=
6_addr (tt-&gt;local_ipv6, 0, &amp;gc);<br>-&nbsp;&nbsp;&nbsp; &nbsp; ifcon=
fig_ipv6_remote =3D print_in6_addr (tt-&gt;remote_ipv6, 0, &amp;gc);<br>-&n=
bsp;&nbsp;&nbsp; &nbsp; do_ipv6 =3D true;<br>-&nbsp;&nbsp;&nbsp; }<br>-<br>=
&nbsp; &nbsp; &nbsp;  /*<br>&nbsp; &nbsp; &nbsp; &nbsp; * If TAP-style devi=
ce, generate broadcast address.<br>&nbsp; &nbsp; &nbsp; &nbsp; */<br>@@ -67=
9,7 +666,6 @@ do_ifconfig (struct tuntap *tt,<br>&nbsp; &nbsp;  }<br> #endi=
f<br> <br>-<br> #if defined(TARGET_LINUX)<br> #ifdef ENABLE_IPROUTE<br> &nb=
sp;&nbsp;&nbsp; /*<br>@@ -720,19 +706,6 @@ do_ifconfig (struct tuntap *tt,<=
br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; argv_msg (M_INFO, &amp;arg=
v);<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve_check
 (&amp;argv, es, S_FATAL, "Linux ip addr add failed");<br> &nbsp;&nbsp;&nbs=
p; }<br>-&nbsp; &nbsp; &nbsp; if ( do_ipv6 )<br>-&nbsp;&nbsp;&nbsp; {<br>-&=
nbsp;&nbsp;&nbsp; &nbsp; argv_printf( &amp;argv,<br>-&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; "%s -6 addr add %s/%d dev %s",<br>-&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; iproute_path,<br>-&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; ifconfig_ipv6_loc=
al,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; tt-&gt;n=
etbits_ipv6,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;=
 actual<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; );<b=
r>-&nbsp;&nbsp;&nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>-&nbsp;&nbsp;=
&nbsp; &nbsp; openvpn_execve_check (&amp;argv, es, S_FATAL, "Linux ip -6 ad=
dr add failed");<br>-&nbsp;&nbsp;&nbsp; }<br>-&nbsp; &nbsp; &nbsp; tt-&gt;d=
id_ifconfig =3D true;<br> #else<br>&nbsp; &nbsp; &nbsp;  if (tun)<br>
 &nbsp;&nbsp;&nbsp; argv_printf (&amp;argv,<br>@@ -755,21 +728,8 @@ do_ifco=
nfig (struct tuntap *tt,<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp; );<br>&nbsp; &nbsp; &nbsp;  argv_msg (M_INFO, &amp;argv);=
<br>&nbsp; &nbsp; &nbsp;  openvpn_execve_check (&amp;argv, es, S_FATAL, "Li=
nux ifconfig failed");<br>-&nbsp; &nbsp; &nbsp; if ( do_ipv6 )<br>-&nbsp;&n=
bsp;&nbsp; {<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_printf (&amp;argv,<br>-&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; "%s %s add %s/%=
d",<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; IFC=
ONFIG_PATH,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp; actual,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp; ifconfig_ipv6_local,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp; tt-&gt;netbits_ipv6<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>-&nbsp;&nbsp;&nbsp; &nbsp;
 argv_msg (M_INFO, &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve=
_check (&amp;argv, es, S_FATAL, "Linux ifconfig inet6 failed");<br>-&nbsp;&=
nbsp;&nbsp; }<br>-&nbsp; &nbsp; &nbsp; tt-&gt;did_ifconfig =3D true;<br>-<b=
r> #endif /*ENABLE_IPROUTE*/<br>+&nbsp; &nbsp; &nbsp; tt-&gt;did_ifconfig =
=3D true;<br> #elif defined(TARGET_SOLARIS)<br> <br>&nbsp; &nbsp; &nbsp;  /=
* Solaris 2.6 (and 7?) cannot set all parameters in one go...<br>@@ -824,52=
 +784,6 @@ do_ifconfig (struct tuntap *tt,<br>&nbsp; &nbsp; &nbsp;  if (!op=
envpn_execve_check (&amp;argv, es, 0, "Solaris ifconfig phase-2 failed"))<b=
r> &nbsp;&nbsp;&nbsp; solaris_error_close (tt, es, actual, false);<br> <br>=
-&nbsp; &nbsp; &nbsp; if ( do_ipv6 )<br>-&nbsp; &nbsp; &nbsp; &nbsp; {<br>-=
 &nbsp;&nbsp;&nbsp; &nbsp; argv_printf (&amp;argv, "%s %s inet6 unplumb",<b=
r>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; I=
FCONFIG_PATH, actual );<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_msg (M_INFO,
 &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve_check (&amp;argv,=
 es, 0, NULL);<br>-<br>-&nbsp;&nbsp;&nbsp; &nbsp; if ( tt-&gt;type =3D=3D D=
EV_TYPE_TUN )<br>-&nbsp;&nbsp;&nbsp; &nbsp;  {<br>-&nbsp;&nbsp;&nbsp; &nbsp=
; &nbsp; &nbsp; argv_printf (&amp;argv,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; "%s %s inet6 plumb %s/%d %s up",<br=
>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; IF=
CONFIG_PATH,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp; &nbsp; actual,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp; &nbsp; ifconfig_ipv6_local,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; tt-&gt;netbits_ipv6,<br>-&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; ifconfig_ipv=
6_remote<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
; &nbsp; );<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;
 }<br>-&nbsp;&nbsp;&nbsp; &nbsp; else&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 /* tap mode */<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; {<br>-&nbsp;&nbsp;&nbs=
p; &nbsp; &nbsp; &nbsp; /* base IPv6 tap interface needs to be brought up f=
irst<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  */<br>-&nbsp;&nbsp;&nbsp;=
 &nbsp; &nbsp; &nbsp; argv_printf (&amp;argv, "%s %s inet6 plumb up",<br>-&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; IFCON=
FIG_PATH, actual );<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; argv_msg (M=
_INFO, &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; if (!openvpn=
_execve_check (&amp;argv, es, 0, "Solaris ifconfig IPv6 (prepare) failed"))=
<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; solaris_error_close (tt, es, act=
ual, true);<br>-<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; /* we might ne=
ed to do "ifconfig %s inet6 auto-dhcp drop"<br>-&nbsp;&nbsp;&nbsp;
 &nbsp; &nbsp; &nbsp;  * after the system has noticed the interface and fir=
ed up<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  * the DHCPv6 client - bu=
t this takes quite a while, and the <br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &=
nbsp;  * server will ignore the DHCPv6 packets anyway.&nbsp; So we don't.<b=
r>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  */<br>-<br>-&nbsp;&nbsp;&nbsp; =
&nbsp; &nbsp; &nbsp; /* static IPv6 addresses need to go to a subinterface =
(tap0:1)<br>-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  */<br>-&nbsp;&nbsp;&n=
bsp; &nbsp; &nbsp; &nbsp; argv_printf (&amp;argv,<br>-&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; "%s %s inet6 addif %s/%d =
up",<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &n=
bsp; IFCONFIG_PATH, actual,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp; &nbsp; ifconfig_ipv6_local, tt-&gt;netbits_ipv6 );<br>=
-&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; }<br>-&nbsp;&nbsp;&nbsp; &nbsp;
 argv_msg (M_INFO, &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; if (!openvpn_e=
xecve_check (&amp;argv, es, 0, "Solaris ifconfig IPv6 failed"))<br>-&nbsp;&=
nbsp;&nbsp; &nbsp; &nbsp; solaris_error_close (tt, es, actual, true);<br>-&=
nbsp; &nbsp; &nbsp; &nbsp; }<br>-<br>&nbsp; &nbsp; &nbsp;  if (!tun &amp;&a=
mp; tt-&gt;topology =3D=3D TOP_SUBNET)<br> &nbsp;&nbsp;&nbsp; {<br> &nbsp;&=
nbsp;&nbsp; &nbsp; /* Add a network route for the local tun interface */<br=
>@@ -928,32 +842,9 @@ do_ifconfig (struct tuntap *tt,<br> &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>&nbsp; &nbsp; &nbsp;  =
argv_msg (M_INFO, &amp;argv);<br>&nbsp; &nbsp; &nbsp;  openvpn_execve_check=
 (&amp;argv, es, S_FATAL, "OpenBSD ifconfig failed");<br>-&nbsp; &nbsp; &nb=
sp; if ( do_ipv6 )<br>-&nbsp;&nbsp;&nbsp; {<br>-&nbsp;&nbsp;&nbsp; &nbsp; a=
rgv_printf (&amp;argv,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp; "%s %s inet6 %s/%d",<br>-&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; IFCONFIG_PATH,<br>-&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; actual,<br>-&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; ifconfig_ipv6_local,=
<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; tt-&gt=
;netbits_ipv6<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp; );<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>-&=
nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve_check (&amp;argv, es, S_FATAL, "Ope=
nBSD ifconfig inet6 failed");<br> <br>-&nbsp;&nbsp;&nbsp; &nbsp; /* and, ho=
oray, we explicitely need to add a route... */<br>-&nbsp;&nbsp;&nbsp; &nbsp=
; add_route_connected_v6_net(tt, es);<br>-&nbsp;&nbsp;&nbsp; }<br>&nbsp; &n=
bsp; &nbsp;  tt-&gt;did_ifconfig =3D true;<br>-<br> #elif defined(TARGET_NE=
TBSD)<br>-<br>-/* whether or not NetBSD can do IPv6 can be seen by the avai=
lability of<br>- * the TUNSIFHEAD ioctl() - see next TARGET_NETBSD
 block for more details<br>- */<br>-#ifdef TUNSIFHEAD<br>-# define NETBSD_M=
ULTI_AF<br>-#endif<br>-<br>&nbsp; &nbsp; &nbsp;  if (tun)<br> &nbsp;&nbsp;&=
nbsp; argv_printf (&amp;argv,<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp; "%s %s %s %s mtu %d netmask 255.255.255.255 up",<br>=
@@ -994,26 +885,6 @@ do_ifconfig (struct tuntap *tt,<br>&nbsp; &nbsp; &nbsp=
;  argv_msg (M_INFO, &amp;argv);<br>&nbsp; &nbsp; &nbsp;  openvpn_execve_ch=
eck (&amp;argv, es, S_FATAL, "NetBSD ifconfig failed");<br> <br>-&nbsp; &nb=
sp; &nbsp; if ( do_ipv6 )<br>-&nbsp;&nbsp;&nbsp; {<br>-#ifdef NETBSD_MULTI_=
AF<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_printf (&amp;argv,<br>-&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; "%s %s inet6 %s/%d",<br>-=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; IFCONFIG_PA=
TH,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; act=
ual,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp; ifconfig_ipv6_local,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp; tt-&gt;netbits_ipv6<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_ms=
g (M_INFO, &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve_check (=
&amp;argv, es, S_FATAL, "NetBSD ifconfig inet6 failed");<br>-<br>-&nbsp;&nb=
sp;&nbsp; &nbsp; /* and, hooray, we explicitely need to add a route... */<b=
r>-&nbsp;&nbsp;&nbsp; &nbsp; add_route_connected_v6_net(tt, es);<br>-#else<=
br>-&nbsp;&nbsp;&nbsp; &nbsp; msg( M_INFO, "no IPv6 support for tun interfa=
ces on NetBSD before 4.0 (if your system is newer, recompile openvpn)" );<b=
r>-&nbsp;&nbsp;&nbsp; &nbsp; tt-&gt;ipv6 =3D false;<br>-#endif<br>-&nbsp;&n=
bsp;&nbsp; }<br>&nbsp; &nbsp; &nbsp;  tt-&gt;did_ifconfig =3D true;<br> <br=
> #elif defined(TARGET_DARWIN)<br>@@ -1079,22 +950,6 @@ do_ifconfig (struct=
 tuntap *tt,<br> &nbsp;&nbsp;&nbsp; &nbsp; add_route (&amp;r, tt, 0,
 NULL, es);<br> &nbsp;&nbsp;&nbsp; }<br> <br>-&nbsp; &nbsp; &nbsp; if ( do_=
ipv6 )<br>-&nbsp;&nbsp;&nbsp; {<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; argv=
_printf (&amp;argv,<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "%s %s inet6 %s/%d",<=
br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IFCONFIG_PATH,<br>-&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; actual,<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ifconfig_ipv6_local,<br>-=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; tt-&gt;netbits_ipv6<br>-&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; );<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_msg (M_INFO,
 &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve_check (&amp;argv,=
 es, S_FATAL, "MacOS X ifconfig inet6 failed");<br>-<br>-&nbsp;&nbsp;&nbsp;=
 &nbsp; /* and, hooray, we explicitely need to add a route... */<br>-&nbsp;=
&nbsp;&nbsp; &nbsp; add_route_connected_v6_net(tt, es);<br>-&nbsp;&nbsp;&nb=
sp; }<br>-<br> #elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)<br>=
 <br>&nbsp; &nbsp; &nbsp;  /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu =
1450 netmask 255.255.255.255 up */<br>@@ -1145,19 +1000,6 @@ do_ifconfig (s=
truct tuntap *tt,<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  add_route (&amp;r,=
 tt, 0, NULL, es);<br>&nbsp; &nbsp; &nbsp; &nbsp;  }<br> <br>-&nbsp; &nbsp;=
 &nbsp; if ( do_ipv6 )<br>-&nbsp;&nbsp;&nbsp; {<br>-&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; argv_printf (&amp;argv,<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "%s %=
s inet6 %s/%d",<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IFCONFIG_PATH,<br>=
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; actual,<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if=
config_ipv6_local,<br>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tt-&gt;netbits_ipv6<br=
>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; );<br>-&nbsp;&nbsp;&nbsp; &nbsp; argv_msg (=
M_INFO, &amp;argv);<br>-&nbsp;&nbsp;&nbsp; &nbsp; openvpn_execve_check (&am=
p;argv, es, S_FATAL, "FreeBSD ifconfig inet6 failed");<br>-&nbsp;&nbsp;&nbs=
p; }<br>-<br> #elif defined (WIN32)<br>&nbsp; &nbsp; &nbsp;  {<br> &nbsp;&n=
bsp;&nbsp; /*<br>@@ -1196,35 +1038,192 @@ do_ifconfig (struct tuntap *tt,<b=
r> &nbsp;&nbsp;&nbsp; &nbsp; }<br> &nbsp;&nbsp;&nbsp;
 tt-&gt;did_ifconfig =3D true;<br>&nbsp; &nbsp; &nbsp;  }<br>+#else<br>+&nb=
sp; &nbsp; &nbsp; msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfi=
g' commands on this operating system.&nbsp; You should ifconfig your TUN/TA=
P device manually or use an --up script.");<br>+#endif<br>+&nbsp; &nbsp; &n=
bsp; argv_reset (&amp;argv);<br>+&nbsp; }<br> <br>-&nbsp; &nbsp; /* IPv6 al=
ways uses "netsh" interface */<br>-&nbsp; &nbsp; if ( do_ipv6 )<br>-&nbsp; =
&nbsp; &nbsp; {<br>-&nbsp;&nbsp;&nbsp; char * saved_actual;<br>+&nbsp; if (=
tt-&gt;ipv6 &amp;&amp; tt-&gt;did_ifconfig_ipv6_setup)<br>+&nbsp; &nbsp; {<=
br>+&nbsp; &nbsp; &nbsp; const char *ifconfig_ipv6_local =3D NULL;<br>+&nbs=
p; &nbsp; &nbsp; const char *ifconfig_ipv6_remote =3D NULL;<br> <br>-&nbsp;=
&nbsp;&nbsp; if (!strcmp (actual, "NULL"))<br>-&nbsp;&nbsp;&nbsp; &nbsp; ms=
g (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Wi=
ndows adapter, you must also specify --dev-node");<br>+&nbsp; &nbsp;
 &nbsp; struct argv argv;<br> <br>-&nbsp;&nbsp;&nbsp; /* example: netsh int=
erface ipv6 set address MyTap 2001:608:8003::d store=3Dactive */<br>-&nbsp;=
&nbsp;&nbsp; argv_printf (&amp;argv,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp; &nbsp; "%s%sc interface ipv6 set address %s %s store=3Dactive",<=
br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  get_win_sys_path()=
,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  NETSH_PATH_SUFFI=
X,<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  actual,<br>-&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  ifconfig_ipv6_local );<br=
>+&nbsp; &nbsp; &nbsp; argv_init (&amp;argv);<br> <br>-&nbsp;&nbsp;&nbsp; n=
etsh_command (&amp;argv, 4);<br>+&nbsp; &nbsp; &nbsp; msg( M_INFO, "do_ifco=
nfig, tt-&gt;ipv6=3D%d, tt-&gt;did_ifconfig_ipv6_setup=3D%d",<br>+&nbsp;&nb=
sp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  tt-&gt;ipv6, tt-&gt;did_ifcon=
fig_ipv6_setup );<br> <br>-&nbsp;&nbsp;&nbsp; /* explicit route needed
 */<br>-&nbsp;&nbsp;&nbsp; /* on windows, OpenVPN does ifconfig first, open=
_tun later, so<br>-&nbsp;&nbsp;&nbsp;  * tt-&gt;actual_name might not yet b=
e initialized, but routing code<br>-&nbsp;&nbsp;&nbsp;  * needs to know int=
erface name - point to "actual", restore later<br>-&nbsp;&nbsp;&nbsp;  */<b=
r>-&nbsp;&nbsp;&nbsp; saved_actual =3D tt-&gt;actual_name;<br>-&nbsp;&nbsp;=
&nbsp; tt-&gt;actual_name =3D (char*) actual;<br>-&nbsp;&nbsp;&nbsp; add_ro=
ute_connected_v6_net(tt, es);<br>-&nbsp;&nbsp;&nbsp; tt-&gt;actual_name =3D=
 saved_actual;<br>-&nbsp; &nbsp; &nbsp; }<br>+&nbsp; &nbsp; &nbsp; ifconfig=
_ipv6_local =3D print_in6_addr (tt-&gt;local_ipv6, 0, &amp;gc);<br>+&nbsp; =
&nbsp; &nbsp; ifconfig_ipv6_remote =3D print_in6_addr (tt-&gt;remote_ipv6, =
0, &amp;gc);<br>+<br>+#if defined(TARGET_LINUX)<br>+#ifdef ENABLE_IPROUTE<b=
r>+&nbsp; &nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp; "%s -6 addr add %s/%d dev %s",<br>+&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp; iproute_path,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp; ifconfig_ipv6_local,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp; tt-&gt;netbits_ipv6,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp; actual<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>+&nbsp; =
&nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp; openvp=
n_execve_check (&amp;argv, es, S_FATAL, "Linux ip -6 addr add failed");<br>=
+#else<br>+&nbsp; &nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp; "%s %s add %s/%d",<br>+&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp; IFCONFIG_PATH,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp; actual,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; ifconf=
ig_ipv6_local,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; tt-&gt;netb=
its_ipv6<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>+&nbsp; &nb=
sp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp;
 openvpn_execve_check (&amp;argv, es, S_FATAL, "Linux ifconfig inet6 failed=
");<br>+#endif /*ENABLE_IPROUTE*/<br>+#elif defined(TARGET_SOLARIS)<br>+<br=
>+&nbsp; &nbsp; &nbsp; argv_printf (&amp;argv, "%s %s inet6 unplumb",<br>+&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; IFCONFIG_PATH, actual );<br>+&n=
bsp; &nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp; o=
penvpn_execve_check (&amp;argv, es, 0, NULL);<br>+<br>+&nbsp; &nbsp; &nbsp;=
 if ( tt-&gt;type =3D=3D DEV_TYPE_TUN )<br>+&nbsp;&nbsp;&nbsp; {<br>+&nbsp;=
&nbsp;&nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp; &nbsp; &nbsp; "%s %s inet6 plumb %s/%d %s up",<br>+&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; IFCONFIG_PATH,<br>+&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; actual,<br>+&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; ifconfig_ipv6_local,<br=
>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
 tt-&gt;netbits_ipv6,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbs=
p; &nbsp; ifconfig_ipv6_remote<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp; &nbsp; &nbsp; );<br>+&nbsp;&nbsp;&nbsp; }<br>+&nbsp; &nbsp; &nbsp; els=
e&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* tap mode */<br>+&nbsp;&nbsp;&nbs=
p; {<br>+&nbsp;&nbsp;&nbsp; &nbsp; /* base IPv6 tap interface needs to be b=
rought up first<br>+&nbsp;&nbsp;&nbsp; &nbsp;  */<br>+&nbsp;&nbsp;&nbsp; &n=
bsp; argv_printf (&amp;argv, "%s %s inet6 plumb up",<br>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; IFCONFIG_PATH, actual );<br>+&nbsp=
;&nbsp;&nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp;&nbsp;&nbsp; &=
nbsp; if (!openvpn_execve_check (&amp;argv, es, 0, "Solaris ifconfig IPv6 (=
prepare) failed"))<br>+&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; solaris_error_close=
 (tt, es, actual, true);<br>+<br>+&nbsp;&nbsp;&nbsp; &nbsp; /* we
 might need to do "ifconfig %s inet6 auto-dhcp drop"<br>+&nbsp;&nbsp;&nbsp;=
 &nbsp;  * after the system has noticed the interface and fired up<br>+&nbs=
p;&nbsp;&nbsp; &nbsp;  * the DHCPv6 client - but this takes quite a while, =
and the <br>+&nbsp;&nbsp;&nbsp; &nbsp;  * server will ignore the DHCPv6 pac=
kets anyway.&nbsp; So we don't.<br>+&nbsp;&nbsp;&nbsp; &nbsp;  */<br>+<br>+=
&nbsp;&nbsp;&nbsp; &nbsp; /* static IPv6 addresses need to go to a subinter=
face (tap0:1)<br>+&nbsp;&nbsp;&nbsp; &nbsp;  */<br>+&nbsp;&nbsp;&nbsp; &nbs=
p; argv_printf (&amp;argv,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
 &nbsp; &nbsp; "%s %s inet6 addif %s/%d up",<br>+&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp; &nbsp; &nbsp; IFCONFIG_PATH, actual,<br>+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; ifconfig_ipv6_local, tt-&gt;net=
bits_ipv6 );<br>+&nbsp;&nbsp;&nbsp; }<br>+&nbsp; &nbsp; &nbsp; argv_msg (M_=
INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp; if (!openvpn_execve_check
 (&amp;argv, es, 0, "Solaris ifconfig IPv6 failed"))<br>+&nbsp;&nbsp;&nbsp;=
 solaris_error_close (tt, es, actual, true);<br>+<br>+#elif defined(TARGET_=
OPENBSD)<br>+<br>+&nbsp; &nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; "%s %s inet6 %s/%d",<br>+&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp; IFCONFIG_PATH,<br>+&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp; actual,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p; ifconfig_ipv6_local,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; tt=
-&gt;netbits_ipv6<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>+&=
nbsp; &nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp; =
openvpn_execve_check (&amp;argv, es, S_FATAL, "OpenBSD ifconfig inet6 faile=
d");<br>+<br>+&nbsp; &nbsp; &nbsp; /* and, hooray, we explicitely need to a=
dd a route... */<br>+&nbsp; &nbsp; &nbsp; add_route_connected_v6_net(tt, es=
);<br>+<br>+#elif defined(TARGET_NETBSD)<br>+<br>+/* whether or not
 NetBSD can do IPv6 can be seen by the availability of<br>+ * the TUNSIFHEA=
D ioctl() - see next TARGET_NETBSD block for more details<br>+ */<br>+#ifde=
f TUNSIFHEAD<br>+# define NETBSD_MULTI_AF<br>+#endif<br>+<br>+#ifdef NETBSD=
_MULTI_AF<br>+&nbsp; &nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; "%s %s inet6 %s/%d",<br>+&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp; IFCONFIG_PATH,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp; actual,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; i=
fconfig_ipv6_local,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; tt-&gt=
;netbits_ipv6<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; );<br>+&nbsp=
; &nbsp; &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp; open=
vpn_execve_check (&amp;argv, es, S_FATAL, "NetBSD ifconfig inet6 failed");<=
br>+<br>+&nbsp; &nbsp; &nbsp; /* and, hooray, we explicitely need to add a =
route... */<br>+&nbsp; &nbsp; &nbsp; add_route_connected_v6_net(tt,
 es);<br>+#else<br>+&nbsp; &nbsp; &nbsp; msg( M_INFO, "no IPv6 support for =
tun interfaces on NetBSD before 4.0 (if your system is newer, recompile ope=
nvpn)" );<br>+&nbsp; &nbsp; &nbsp; tt-&gt;ipv6 =3D false;<br>+#endif<br>+<b=
r>+#elif defined(TARGET_DARWIN)<br>+&nbsp; &nbsp; &nbsp; /*<br>+&nbsp; &nbs=
p; &nbsp;  * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour to O=
penBSD...<br>+&nbsp; &nbsp; &nbsp;  */<br>+&nbsp; &nbsp; &nbsp; argv_printf=
 (&amp;argv,<br>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; "%s %s inet6 %s/%d",<br>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; IFCONFIG_PATH,<br>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; actual,<br>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; ifconfig_ipv6_local,<br>+&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tt-&gt;netbits_ipv6<br>+&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; );<br>+&nbsp; &nbsp;
 &nbsp; argv_msg (M_INFO, &amp;argv);<br>+&nbsp; &nbsp; &nbsp; openvpn_exec=
ve_check (&amp;argv, es, S_FATAL, "MacOS X ifconfig inet6 failed");<br>+<br=
>+&nbsp; &nbsp; &nbsp; /* and, hooray, we explicitely need to add a route..=
. */<br>+&nbsp; &nbsp; &nbsp; add_route_connected_v6_net(tt, es);<br>+<br>+=
<br>+#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)<br>+<br>+&nbs=
p; &nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; "%s %s inet6 %s/%d",<br>+&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IFCONFIG_PATH,<br>+&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; actual,<br>+&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ifconfig_ipv6_local,<b=
r>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tt-&gt;ne=
tbits_ipv6<br>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; );<br>+&nbsp; &nbsp; &nbsp; argv_msg (M_INFO,
 &amp;argv);<br>+&nbsp; &nbsp; &nbsp; openvpn_execve_check (&amp;argv, es, =
S_FATAL, "FreeBSD ifconfig inet6 failed");<br>+<br>+#elif defined (WIN32)<b=
r>+&nbsp; &nbsp; &nbsp; /* IPv6 always uses "netsh" interface */<br>+&nbsp;=
 &nbsp; &nbsp; char * saved_actual;<br>+<br>+&nbsp; &nbsp; &nbsp; if (!strc=
mp (actual, "NULL"))<br>+&nbsp; &nbsp; &nbsp; &nbsp; msg (M_FATAL, "Error: =
When using --tun-ipv6, if you have more than one TAP-Windows adapter, you m=
ust also specify --dev-node");<br>+<br>+&nbsp; &nbsp; &nbsp; /* example: ne=
tsh interface ipv6 set address MyTap 2001:608:8003::d store=3Dactive */<br>=
+&nbsp; &nbsp; &nbsp; argv_printf (&amp;argv,<br>+&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp; "%s%sc interface ipv6 set address %s %s store=3Dactive"=
,<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; get_win_sys_path(),<br>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; NETSH_PATH_SUFFIX,<br>+&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; actual,<br>+&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp; ifconfig_ipv6_local );<br>+<br>+&nbsp; &nbsp; &n=
bsp; netsh_command (&amp;argv, 4);<br>+<br>+&nbsp; &nbsp; &nbsp; /* explici=
t route needed */<br>+&nbsp; &nbsp; &nbsp; /* on windows, OpenVPN does ifco=
nfig first, open_tun later, so<br>+&nbsp; &nbsp; &nbsp;  * tt-&gt;actual_na=
me might not yet be initialized, but routing code<br>+&nbsp; &nbsp; &nbsp; =
 * needs to know interface name - point to "actual", restore later<br>+&nbs=
p; &nbsp; &nbsp;  */<br>+&nbsp; &nbsp; &nbsp; saved_actual =3D tt-&gt;actua=
l_name;<br>+&nbsp; &nbsp; &nbsp; tt-&gt;actual_name =3D (char*) actual;<br>=
+&nbsp; &nbsp; &nbsp; add_route_connected_v6_net(tt, es);<br>+&nbsp; &nbsp;=
 &nbsp; tt-&gt;actual_name =3D saved_actual;<br> #else<br>&nbsp; &nbsp; &nb=
sp;  msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands o=
n this operating system.&nbsp; You should ifconfig your TUN/TAP device manu=
ally or use an --up script.");<br> #endif<br>@@ -4932,7 +4931,7 @@
 open_tun (const char *dev, const char *dev_type, const char *dev_node, str=
uct tu<br> <br>&nbsp;  if (tt-&gt;type =3D=3D DEV_TYPE_TUN)<br>&nbsp; &nbsp=
;  {<br>-&nbsp; &nbsp; &nbsp; if (!tt-&gt;did_ifconfig_setup)<br>+&nbsp; &n=
bsp; &nbsp; if (!(tt-&gt;did_ifconfig_setup || tt-&gt;did_ifconfig_ipv6_set=
up))<br> &nbsp;&nbsp;&nbsp; {<br> &nbsp;&nbsp;&nbsp; &nbsp; msg (M_FATAL, "=
ERROR: --dev tun also requires --ifconfig");<br> &nbsp;&nbsp;&nbsp; }<br>--=
 <br>2.0.2<br><br><br><br><br>------------------------------<br><br>Message=
: 4<br>Date: Fri, 08 Aug 2014 10:10:42 +0300<br>From: Samuli Sepp?nen &lt;<=
a ymailto=3D"mailto:samuli@...515..." href=3D"mailto:samuli@...515...">samu=
li@...515...</a>&gt;<br>Subject: [Openvpn-devel] Impact of latest OpenSSL v=
ulnerabilities to<br>&nbsp;&nbsp;&nbsp; OpenVPN<br>To: "<a ymailto=3D"mailt=
o:openvpn-devel@lists.sourceforge.net"
 href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1466...=
urceforge.net</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-d=
evel@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...290...=
net">openvpn-devel@lists.sourceforge.net</a>&gt;,<br>&nbsp;&nbsp;&nbsp; "<a=
 ymailto=3D"mailto:openvpn-users@lists.sourceforge.net" href=3D"mailto:open=
vpn-users@lists.sourceforge.net">openvpn-users@lists.sourceforge.net</a>"<b=
r>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-users@...1768...=
ge.net" href=3D"mailto:openvpn-users@lists.sourceforge.net">openvpn-users@...465...=
ists.sourceforge.net</a>&gt;,<br>&nbsp;&nbsp;&nbsp; "<a ymailto=3D"mailto:o=
penvpn-announce@lists.sourceforge.net" href=3D"mailto:openvpn-announce@...1514...=
s.sourceforge.net">openvpn-announce@lists.sourceforge.net</a>"<br>&nbsp;&nb=
sp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-announce@lists.sourceforge.net"
 href=3D"mailto:openvpn-announce@lists.sourceforge.net">openvpn-announce@...1224...=
sts.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a ymailto=3D"mailto:53E477F=
2.8080003@...515..." href=3D"mailto:53E477F2.8080003@...515...">53E477F2.80=
80003@...515...</a>&gt;<br>Content-Type: text/plain; charset=3Diso-8859-15<=
br><br><br>-----BEGIN PGP SIGNED MESSAGE-----<br>Hash: SHA1<br><br>Hi all,<=
br><br>Information on how the latest OpenSSL vulnerabilities affect OpenVPN=
 is<br>available here:<br><br>&lt;<a href=3D"https://community.openvpn.net/=
openvpn/wiki/VulnerabilitiesFixedInOpenSSL1.0.1i" target=3D"_blank">https:/=
/community.openvpn.net/openvpn/wiki/VulnerabilitiesFixedInOpenSSL1.0.1i</a>=
&gt;<br><br>Yesterday's Windows installer releases bundle OpenSSL 1.0.0i, w=
hich is<br>immune to the two issues which may[1] affect OpenVPN. Updated in=
stallers<br>are available here:<br><br>&lt;<a href=3D"http://openvpn.net/in=
dex.php/download/community-downloads.html"
 target=3D"_blank">http://openvpn.net/index.php/download/community-download=
s.html</a>&gt;<br><br>Best regards,<br><br>- -- <br>Samuli Sepp?nen<br>Comm=
unity Manager<br>OpenVPN Technologies, Inc<br><br>irc freenode net: mattock=
<br><br><br>[1] Depending on it's configuration<br>-----BEGIN PGP SIGNATURE=
-----<br>Version: GnuPG v1<br><br>iEYEARECAAYFAlPkd/IACgkQwp2X7RmNIqOoWwCeL=
R13x//Vxm4LRXilRlwkxhtP<br>XcoAoMwIn+y3iYkofgL9TFiIK4YGMOK8<br>=3DmsAA<br>-=
----END PGP SIGNATURE-----<br><br><br><br><br>-----------------------------=
-<br><br>Message: 5<br>Date: Fri, 08 Aug 2014 11:11:23 +0300<br>From: Samul=
i Sepp?nen &lt;<a ymailto=3D"mailto:samuli@...515..." href=3D"mailto:samuli=
@...515...">samuli@...515...</a>&gt;<br>Subject: Re: [Openvpn-devel] Impact=
 of latest OpenSSL vulnerabilities<br>&nbsp;&nbsp;&nbsp; to&nbsp;&nbsp;&nbs=
p; OpenVPN<br>To: "<a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net"
 href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1466...=
urceforge.net</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-d=
evel@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...290...=
net">openvpn-devel@lists.sourceforge.net</a>&gt;,<br>&nbsp;&nbsp;&nbsp; "<a=
 ymailto=3D"mailto:openvpn-users@lists.sourceforge.net" href=3D"mailto:open=
vpn-users@lists.sourceforge.net">openvpn-users@lists.sourceforge.net</a>"<b=
r>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-users@...1768...=
ge.net" href=3D"mailto:openvpn-users@lists.sourceforge.net">openvpn-users@...465...=
ists.sourceforge.net</a>&gt;,<br>&nbsp;&nbsp;&nbsp; "<a ymailto=3D"mailto:o=
penvpn-announce@lists.sourceforge.net" href=3D"mailto:openvpn-announce@...1514...=
s.sourceforge.net">openvpn-announce@lists.sourceforge.net</a>"<br>&nbsp;&nb=
sp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-announce@lists.sourceforge.net"
 href=3D"mailto:openvpn-announce@lists.sourceforge.net">openvpn-announce@...1224...=
sts.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a ymailto=3D"mailto:53E4862=
B.1080709@...515..." href=3D"mailto:53E4862B.1080709@...515...">53E4862B.10=
80709@...515...</a>&gt;<br>Content-Type: text/plain; charset=3Diso-8859-15<=
br><br><br>-----BEGIN PGP SIGNED MESSAGE-----<br>Hash: SHA1<br><br><br><br>=
&gt; Hi all,<br>&gt;<br>&gt; Information on how the latest OpenSSL vulnerab=
ilities affect OpenVPN is<br>&gt; available here:<br>&gt;<br>&gt;<br>&lt;<a=
 href=3D"https://community.openvpn.net/openvpn/wiki/VulnerabilitiesFixedInO=
penSSL1.0.1i" target=3D"_blank">https://community.openvpn.net/openvpn/wiki/=
VulnerabilitiesFixedInOpenSSL1.0.1i</a>&gt;<br>&gt;<br>&gt; Yesterday's Win=
dows installer releases bundle OpenSSL 1.0.0i, which is<br>&gt; immune to t=
he two issues which may[1] affect OpenVPN. Updated installers<br>&gt; are a=
vailable here:<br>&gt;<br>Responding to myself before somebody else
 corrects me. The Windows<br>installers bundle 1.0.1i (not 1.0.0i).<br><br>=
Sorry for the noise.<br>- -- <br>Samuli Sepp?nen<br>Community Manager<br>Op=
enVPN Technologies, Inc<br><br>irc freenode net: mattock<br>-----BEGIN PGP =
SIGNATURE-----<br>Version: GnuPG v1<br><br>iEYEARECAAYFAlPkhisACgkQwp2X7RmN=
IqPKIgCeNsM6/3Z1Y9IDMMOYKQztHeWQ<br>76cAn1t8clBRaBWhhEAY2pYI8LHbzjSC<br>=3D=
XS4x<br>-----END PGP SIGNATURE-----<br><br><br><br><br>--------------------=
----------<br><br>---------------------------------------------------------=
---------------------<br>Want fast and easy access to all the code in your =
enterprise? Index and<br>search up to 200,000 lines of code with a free cop=
y of Black Duck<br>Code Sight - the same software that powers the world's l=
argest code<br>search on Ohloh, the Black Duck Open Hub! Try it now.<br><a =
href=3D"http://p.sf.net/sfu/bds"
 target=3D"_blank">http://p.sf.net/sfu/bds</a><br><br>---------------------=
---------<br><br>_______________________________________________<br>Openvpn=
-devel mailing list<br><a ymailto=3D"mailto:Openvpn-devel@...282...=
.net" href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1484...=
ts.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/li=
stinfo/openvpn-devel" target=3D"_blank">https://lists.sourceforge.net/lists=
/listinfo/openvpn-devel</a><br><br><br>End of Openvpn-devel Digest, Vol 99,=
 Issue 3<br>********************************************<br><br><br></div> =
 </div> </div>  </div> </div></body></html>=

---1100835386-1270169471-1407524277=:37295--

