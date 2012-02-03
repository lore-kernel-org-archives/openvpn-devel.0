Date: Fri, 3 Feb 2012 18:12:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120203171243.GM13929@...1296...>
References: <20120203084426.GA24955@...1296...>
	<ae352eb1958ae39e2805169386bb144e@...1528...>
	<20120203151931.GI13929@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20120203151931.GI13929@...1296...>
Subject: Re: [Openvpn-devel] IPv6 enhancement: non-/64 prefix lengths for
	IPv6 [v2]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael <michael-developer@...1528...>
Cc: openvpn-devel@lists.sourceforge.net

--kvUQC+jR9YzypDnK
Content-Type: multipart/mixed; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 03, 2012 at 04:19:31PM +0100, Gert Doering wrote:
> On Fri, Feb 03, 2012 at 03:10:37PM +0100, Michael wrote:
> > the patch does not remove
> >=20
> > +++ b/push.c
> > @@ -245,8 +245,9 @@ send_push_reply (struct context *c)
> >        /* TODO: push "/netbits" as well, to allow non-/64 subnet sizes
> >         *       (needs changes in options.c, options.h, and other=20
> > places)
> >         */

Now it does :-)  - thanks for pointing this out.  v2 patch attached.

"git --reset" is my friend ;-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Implement-IPv6-interface-config-with-non-64-prefix-l.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 53e78848f552235c3270419771f3e3293dfe91ec Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Fri, 3 Feb 2012 17:11:03 +0100
Subject: [PATCH] Implement IPv6 interface config with non-/64 prefix length=
s.

Add "ifconfig_ipv6_netbits_parm" parameter to init_tun(), use that to
initialize tt->netbits_ipv6 (previously: always /64).  Actual interface
setup code already used tt->netbits_ipv6, so no changes needed there.

Remove restrictions on "/netbits" value for --server-ipv6 config option
(can now be /64.../112, previously had to be exactly /64).  Supporting
even smaller networks could cause problems with ipv6-pool handling and
are only allowed for explicit "ifconfig-ipv6", not for "server-ipv6".

Add /netbits to pushed "ifconfig-ipv6" values on server side (client
side always accepted this, but ignored it so far, so this does not
break compatibility).

Tested on Linux/ifconfig, Linux/iproute2 and FreeBSD 7.4

Signed-off-by: Gert Doering <gert@...1296...>
---
 TODO.IPv6 |    2 ++
 helper.c  |    8 +++++---
 init.c    |    1 +
 options.c |    5 +++--
 push.c    |    6 ++----
 tun.c     |    4 +++-
 tun.h     |    1 +
 7 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/TODO.IPv6 b/TODO.IPv6
index 87c47b3..f23cce0 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -77,6 +77,8 @@ tun0: flags=3D8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu =
1500
     of /netbits, and correctly ifconfig'ing this
     (default, if not specified: /64)
=20
+    * done * 2012-02-03
+
 11.) do not add ipv6-routes if tun-ipv6 is not set - complain instead
=20
      * done * 12.1.10
diff --git a/helper.c b/helper.c
index c7333f6..22ea652 100644
--- a/helper.c
+++ b/helper.c
@@ -184,12 +184,14 @@ helper_client_server (struct options *o)
 		print_in6_addr( add_in6_addr( o->server_network_ipv6, 1), 0, &o->gc );
 	o->ifconfig_ipv6_remote =3D=20
 		print_in6_addr( add_in6_addr( o->server_network_ipv6, 2), 0, &o->gc );
+	o->ifconfig_ipv6_netbits =3D o->server_netbits_ipv6;
+
+	/* pool starts at "base address + 0x1000" - leave enough room */
+	ASSERT( o->server_netbits_ipv6 <=3D 112 );	/* want 16 bits */
=20
-	/* pool starts at "base address + 0x10000" */
-	ASSERT( o->server_netbits_ipv6 < 96 );		/* want 32 bits */
 	o->ifconfig_ipv6_pool_defined =3D true;
 	o->ifconfig_ipv6_pool_base =3D=20
-		add_in6_addr( o->server_network_ipv6, 0x10000 );
+		add_in6_addr( o->server_network_ipv6, 0x1000 );
 	o->ifconfig_ipv6_pool_netbits =3D o->server_netbits_ipv6;
=20
 	o->tun_ipv6 =3D true;
diff --git a/init.c b/init.c
index b8cb84f..525f441 100644
--- a/init.c
+++ b/init.c
@@ -1415,6 +1415,7 @@ do_init_tun (struct context *c)
 			   c->options.ifconfig_local,
 			   c->options.ifconfig_remote_netmask,
 			   c->options.ifconfig_ipv6_local,
+			   c->options.ifconfig_ipv6_netbits,
 			   c->options.ifconfig_ipv6_remote,
 			   addr_host (&c->c1.link_socket_addr.local),
 			   addr_host (&c->c1.link_socket_addr.remote),
diff --git a/options.c b/options.c
index 0fbe368..cb9738a 100644
--- a/options.c
+++ b/options.c
@@ -2926,6 +2926,7 @@ options_string (const struct options *o,
 		     o->ifconfig_local,
 		     o->ifconfig_remote_netmask,
 		     o->ifconfig_ipv6_local,
+		     o->ifconfig_ipv6_netbits,
 		     o->ifconfig_ipv6_remote,
 		     (in_addr_t)0,
 		     (in_addr_t)0,
@@ -5396,9 +5397,9 @@ add_option (struct options *options,
 	  msg (msglevel, "error parsing --server-ipv6 parameter");
 	  goto err;
 	}
-      if ( netbits !=3D 64 )
+      if ( netbits < 64 || netbits > 112 )
 	{
-	  msg( msglevel, "--server-ipv6 settings: only /64 supported right now (n=
ot /%d)", netbits );
+	  msg( msglevel, "--server-ipv6 settings: only /64../112 supported right =
now (not /%d)", netbits );
 	  goto err;
 	}
       options->server_ipv6_defined =3D true;
diff --git a/push.c b/push.c
index a8ce356..8a8779d 100644
--- a/push.c
+++ b/push.c
@@ -242,11 +242,9 @@ send_push_reply (struct context *c)
   if ( c->c2.push_ifconfig_ipv6_defined )
     {
       /* IPv6 is put into buffer first, could be lengthy */
-      /* TODO: push "/netbits" as well, to allow non-/64 subnet sizes
-       *       (needs changes in options.c, options.h, and other places)
-       */
-      buf_printf( &buf, ",ifconfig-ipv6 %s %s",
+      buf_printf( &buf, ",ifconfig-ipv6 %s/%d %s",
 		    print_in6_addr( c->c2.push_ifconfig_ipv6_local, 0, &gc),
+		    c->c2.push_ifconfig_ipv6_netbits,
 		    print_in6_addr( c->c2.push_ifconfig_ipv6_remote, 0, &gc) );
       if (BLEN (&buf) >=3D safe_cap)
 	{
diff --git a/tun.c b/tun.c
index c9af168..1527ac8 100644
--- a/tun.c
+++ b/tun.c
@@ -404,6 +404,7 @@ init_tun (const char *dev,       /* --dev option */
 	  const char *ifconfig_local_parm,          /* --ifconfig parm 1 */
 	  const char *ifconfig_remote_netmask_parm, /* --ifconfig parm 2 */
 	  const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
+	  int         ifconfig_ipv6_netbits_parm,
 	  const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
 	  in_addr_t local_public,
 	  in_addr_t remote_public,
@@ -534,7 +535,7 @@ init_tun (const char *dev,       /* --dev option */
 	{
 	  msg( M_FATAL, "init_tun: problem converting IPv6 ifconfig addresses %s =
and %s to binary", ifconfig_ipv6_local_parm, ifconfig_ipv6_remote_parm );
 	}
-      tt->netbits_ipv6 =3D 64;
+      tt->netbits_ipv6 =3D ifconfig_ipv6_netbits_parm;
=20
       /*
        * Set ifconfig parameters
@@ -548,6 +549,7 @@ init_tun (const char *dev,       /* --dev option */
       if (es)
 	{
 	  setenv_str (es, "ifconfig_ipv6_local", ifconfig_ipv6_local);
+	  setenv_int (es, "ifconfig_ipv6_netbits", tt->netbits_ipv6);
 	  setenv_str (es, "ifconfig_ipv6_remote", ifconfig_ipv6_remote);
 	}
       tt->did_ifconfig_ipv6_setup =3D true;
diff --git a/tun.h b/tun.h
index f28b8d8..c0785dd 100644
--- a/tun.h
+++ b/tun.h
@@ -225,6 +225,7 @@ struct tuntap *init_tun (const char *dev,       /* --de=
v option */
 			 const char *ifconfig_local_parm,          /* --ifconfig parm 1 */
 			 const char *ifconfig_remote_netmask_parm, /* --ifconfig parm 2 */
 			 const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 =
*/
+			 int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits =
*/
 			 const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 =
*/
 			 in_addr_t local_public,
 			 in_addr_t remote_public,
--=20
1.7.3.4


--lMM8JwqTlfDpEaS6--

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTywVi6kuBuNlUUl1AQLuOgQAuZknKp//bg/x6Ymx/H9wMTFCPUZ8VOZc
FTooQZ2Of8Ga4pVSo5AHyUuJkcS2saAakZib8lyu278lJg/U9RpWV1Ey0iCrghdH
mdEpkleQLZTQGpFYfwE1B+WOZjwEj5NkQ9RWD1nLyLm8bF/cfgpDqZC4xoug7KBP
iFQ9dTA+p6k=
=2XxA
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--

