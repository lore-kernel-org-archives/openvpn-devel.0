Date: Mon, 23 May 2011 10:46:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110523084620.GB8496@...1296...>
References: <4DC936F3.6000509@...1458...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9JkkYVew5bnwk98f"
Content-Disposition: inline
In-Reply-To: <4DC936F3.6000509@...1458...>
Subject: Re: [Openvpn-devel] Fwd: OpenVPN netsh.exe patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--9JkkYVew5bnwk98f
Content-Type: multipart/mixed; boundary="0zAvg8I2HpXbmZ+A"
Content-Disposition: inline

--0zAvg8I2HpXbmZ+A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 10, 2011 at 03:00:35PM +0200, Seth Mos wrote:
> Here is the tun.c patch for correction of the netsh.exe commands.

So.  Took me a while to incorporate it, and I took the opportunity to
do more windows ipv6 related cleanups:

 - add routes with "store=3Dactive" as well (so if the machine crashes while
   OpenVPN is connectes, routes don't survive)

 - remove ifconfig and routes on disconnect - the latter part needed changes
   in more generic parts of route.c, route.h and tun.c

I have built and tested the resulting code on Linux, OpenBSD (because that
would be affected by a breakage in the changed route.c code), WinXP and
Win7 - and I also got independent test success reports for Win7 from=20
Tony Lim (thanks!), so I consider this code sane :-)

Patches attached for review.

David: please pull from git://compile.svr01.mucip.net/openvpn-gert.git,
       all that is in the "feat_ipv6_payload_2.3" branch

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0zAvg8I2HpXbmZ+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Change-the-netsh.exe-command-from-add-to-set.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 39990a2b83308baf1372bbc8846136036a55cf50 Mon Sep 17 00:00:00 2001
From: smos <seth.mos@...1458...>
Date: Tue, 10 May 2011 10:01:48 +0200
Subject: [PATCH 1/2] Change the netsh.exe command from "add" to "set".

This prevents the netsh.exe command from exiting with a status 1
when the address already exists. By adding store=3Dactive the address
will not survive a reboot and be assigned temporarily.

Tested on Windows 7 and Windows XP SP 2.

Signed-off-by: smos <seth.mos@...1458...>
Acked-by: Gert Doering <gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 tun.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tun.c b/tun.c
index 45db2b5..55d66e1 100644
--- a/tun.c
+++ b/tun.c
@@ -1167,9 +1167,9 @@ do_ifconfig (struct tuntap *tt,
 	if (!strcmp (actual, "NULL"))
 	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one =
TAP-Win32 adapter, you must also specify --dev-node");
=20
-	/* example: netsh interface ipv6 add address MyTap 2001:608:8003::d */
+	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d store=
=3Dactive */
 	argv_printf (&argv,
-		    "%s%sc interface ipv6 add address %s %s",
+		    "%s%sc interface ipv6 set address %s %s store=3Dactive",
 		     get_win_sys_path(),
 		     NETSH_PATH_SUFFIX,
 		     actual,
--=20
1.7.3.4


--0zAvg8I2HpXbmZ+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-Windows-IPv6-cleanup-properly-remove-IPv6-routes-and.patch"
Content-Transfer-Encoding: quoted-printable

=46rom b55e49bd69484fdd440098f9485de159251e1cce Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 22 May 2011 19:02:39 +0200
Subject: [PATCH 2/2] Windows IPv6 cleanup - properly remove IPv6 routes and=
 interface config
 after tunnel shutdown.  Needs to make delete_route_ipv6() visible from
 tun.c (route.c, route.h) and to properly zero-out host bits from IPv6
 "network" at interface route clearing.  Further, add IPv6 routes with
 "store=3Dactive" to make sure nothing lingers after a system crash while
 OpenVPN was running.

While at it, small Solaris cleanup - use CLEAR() to zero-out "ifr" struct.

Tested on Windows XP SP3 and Win7 by Gert Doering and Tony Lim.

Signed-off-by: Gert Doering <gert@...1296...>
---
 ChangeLog.IPv6 |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 options.c      |    2 +-
 route.c        |   52 +++++++++++++++++++++++++++++++---------------------
 route.h        |    1 +
 tun.c          |   30 ++++++++++++++++++++++++++++--
 5 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/ChangeLog.IPv6 b/ChangeLog.IPv6
index 38f4446..283fe6e 100644
--- a/ChangeLog.IPv6
+++ b/ChangeLog.IPv6
@@ -392,3 +392,49 @@ So 24. Apr 16:51:45 CEST 2011
=20
   * TEST SUCCESS: Linux/iproute2: client-tun/net30+subnet, v4+v6
=20
+Thu Apr 28 19:10:01 CEST 2011
+
+  * rebase to "origin/release/2.2" branch (at v2.2.0 tag)
+
+Thu May 19 20:51:12 CEST 2011
+
+  * include Windows "netsh add" -> "netsh set ... store=3Dactive" patch fr=
om
+    Seth Mos, to fix restart problems on Windows due to persistant address=
es
+
+  * TEST SUCCESS: Windows XP SP3: client-tun/net30, v4+v6
+
+Sat May 21 17:03:20 CEST 2011
+
+  * tun.c: Solaris cleanup (use CLEAR() to zero-out "ifr")
+
+  * tun.c: Windows cleanup: remove route and IPv6 address on disconnect
+
+  * route.c, route.h: remove "static" from delete_route_ipv6(), needed
+    for ipv6-route cleanup on disconnect
+
+  * TEST SUCCESS: Windows XP SP3: client-tun/net30, v4+v6
+
+  * TEST SUCCESS: Windows 7 Home Premium: client-tun/net30, v4+v6
+
+So 22. Mai 14:46:12 CEST 2011
+
+  * Tony Lim: removing routes fails on windows if certain bits are set
+    in the "host part" (others are silently ignored) -->
+
+  * route.c: create print_in6_addr_netbits_only() helper, call from=20
+    add_route_ipv6() and delete_route_ipv6() to get only network part
+    of route-to-be-modified
+
+  * route.c: set 'store=3Dactive' on adding routes on WIN32 as well (Tony =
Lim)
+
+  * options.c: bump IPv6 release to 20110522-1
+
+  * TEST SUCCESS: Linux/iproute2: client-tun/net30+subnet, v4+v6
+
+  * TEST SUCCESS: Windows XP SP3: client-tun/net30, v4+v6
+
+  * TEST SUCCESS: Windows 7 Home Premium: client-tun/net30, v4+v6
+
+  * TEST SUCCESS: OpenBSD 4.7: client-tun/net30, v4+v6
+    TEST FAIL: OpenBSD 4.7: client-tun/subnet, v4
+    (seems to be due to "topology subnet has just not been implemented yet=
")
diff --git a/options.c b/options.c
index 6f98d14..824492e 100644
--- a/options.c
+++ b/options.c
@@ -80,7 +80,7 @@ const char title_string[] =3D
 #ifdef ENABLE_EUREPHIA
   " [eurephia]"
 #endif
-  " [IPv6 payload 20110424-2 (2.2RC2)]"
+  " [IPv6 payload 20110522-1 (2.2.0)]"
   " built on " __DATE__
 ;
=20
diff --git a/route.c b/route.c
index 9cf07be..7c81f75 100644
--- a/route.c
+++ b/route.c
@@ -40,7 +40,6 @@
 #include "memdbg.h"
=20
 static void delete_route (const struct route *r, const struct tuntap *tt, =
unsigned int flags, const struct env_set *es);
-static void delete_route_ipv6 (const struct route_ipv6 *r, const struct tu=
ntap *tt, unsigned int flags, const struct env_set *es);
 static void get_bypass_addresses (struct route_bypass *rb, const unsigned =
int flags);
=20
 #ifdef ENABLE_DEBUG
@@ -1264,6 +1263,29 @@ add_route (struct route *r, const struct tuntap *tt,=
 unsigned int flags, const s
   gc_free (&gc);
 }
=20
+
+static const char *=20
+print_in6_addr_netbits_only( struct in6_addr network_copy, int netbits,=20
+                             struct gc_arena * gc)
+{
+  /* clear host bit parts of route=20
+   * (needed if routes are specified improperly, or if we need to=20
+   * explicitely setup/clear the "connected" network routes on some OSes)
+   */
+  int byte =3D 15;
+  int bits_to_clear =3D 128 - netbits;
+
+  while( byte >=3D 0 && bits_to_clear > 0 )
+    {
+      if ( bits_to_clear >=3D 8 )
+	{ network_copy.s6_addr[byte--] =3D 0; bits_to_clear -=3D 8; }
+      else
+	{ network_copy.s6_addr[byte--] &=3D (~0 << bits_to_clear); bits_to_clear =
=3D 0; }
+    }
+
+  return print_in6_addr( network_copy, 0, gc);
+}
+
 void
 add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned i=
nt flags, const struct env_set *es)
 {
@@ -1274,8 +1296,6 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct t=
untap *tt, unsigned int fla
   const char *gateway;
   bool status =3D false;
   const char *device =3D tt->actual_name;
-  int byte, bits_to_clear;
-  struct in6_addr network_copy =3D r6->network;
=20
   if (!r6->defined)
     return;
@@ -1283,22 +1303,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct =
tuntap *tt, unsigned int fla
   gc_init (&gc);
   argv_init (&argv);
=20
-  /* clear host bit parts of route=20
-   * (needed if routes are specified improperly, or if we need to=20
-   * explicitely setup the "connected" network routes on some OSes)
-   */
-  byte =3D 15;
-  bits_to_clear =3D 128 - r6->netbits;
-
-  while( byte >=3D 0 && bits_to_clear > 0 )
-    {
-      if ( bits_to_clear >=3D 8 )
-	{ network_copy.s6_addr[byte--] =3D 0; bits_to_clear -=3D 8; }
-      else
-	{ network_copy.s6_addr[byte--] &=3D (~0 << bits_to_clear); bits_to_clear =
=3D 0; }
-    }
-
-  network =3D print_in6_addr( network_copy, 0, &gc);
+  network =3D print_in6_addr_netbits_only( r6->network, r6->netbits, &gc);
   gateway =3D print_in6_addr( r6->gateway, 0, &gc);
=20
   if ( !tt->ipv6 )
@@ -1363,6 +1368,11 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct =
tuntap *tt, unsigned int fla
     argv_printf_cat (&argv, " METRIC %d", r->metric);
 #endif
=20
+  /* in some versions of Windows, routes are persistent across reboots by
+   * default, unless "store=3Dactive" is set (pointed out by Tony Lim, tha=
nks)
+   */
+  argv_printf_cat( &argv, " store=3Dactive" );
+
   argv_msg (D_ROUTE, &argv);
=20
   netcmd_semaphore_lock ();
@@ -1573,7 +1583,7 @@ delete_route (const struct route *r, const struct tun=
tap *tt, unsigned int flags
   gc_free (&gc);
 }
=20
-static void
+void
 delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, u=
nsigned int flags, const struct env_set *es)
 {
   struct gc_arena gc;
@@ -1588,7 +1598,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const=
 struct tuntap *tt, unsigne
   gc_init (&gc);
   argv_init (&argv);
=20
-  network =3D print_in6_addr( r6->network, 0, &gc);
+  network =3D print_in6_addr_netbits_only( r6->network, r6->netbits, &gc);
   gateway =3D print_in6_addr( r6->gateway, 0, &gc);
=20
   if ( !tt->ipv6 )
diff --git a/route.h b/route.h
index 739d12d..6a7704f 100644
--- a/route.h
+++ b/route.h
@@ -176,6 +176,7 @@ struct route_ipv6_list *new_route_ipv6_list (const int =
max_routes, struct gc_are
=20
 void add_route (struct route *r, const struct tuntap *tt, unsigned int fla=
gs, const struct env_set *es);
 void add_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, unsign=
ed int flags, const struct env_set *es);
+void delete_route_ipv6 (const struct route_ipv6 *r, const struct tuntap *t=
t, unsigned int flags, const struct env_set *es);
=20
 void add_route_to_option_list (struct route_option_list *l,
 			       const char *network,
diff --git a/tun.c b/tun.c
index 55d66e1..cea1784 100644
--- a/tun.c
+++ b/tun.c
@@ -591,6 +591,18 @@ void add_route_connected_v6_net(struct tuntap * tt,
     r6.gateway =3D tt->local_ipv6;
     add_route_ipv6 (&r6, tt, 0, es);
 }
+
+void delete_route_connected_v6_net(struct tuntap * tt,
+	                           const struct env_set *es)
+{
+    struct route_ipv6 r6;
+
+    r6.defined =3D true;
+    r6.network =3D tt->local_ipv6;
+    r6.netbits =3D tt->netbits_ipv6;
+    r6.gateway =3D tt->local_ipv6;
+    delete_route_ipv6 (&r6, tt, 0, es);
+}
 #endif
=20
=20
@@ -1649,7 +1661,7 @@ open_tun (const char *dev, const char *dev_type, cons=
t char *dev_node, struct tu
    * http://www.whiteboard.ne.jp/~admin2/tuntap/
    * has IPv6 support
    */
-  memset(&ifr, 0x0, sizeof(ifr));
+  CLEAR(ifr);
=20
   if (tt->type =3D=3D DEV_TYPE_NULL)
     {
@@ -4851,9 +4863,23 @@ close_tun (struct tuntap *tt)
     {
       if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
         {
+	  struct argv argv;
+	  argv_init (&argv);
+
+	  /* remove route pointing to interface */
+	  delete_route_connected_v6_net(tt, NULL);
+
 	  /* netsh interface ipv6 delete address \"%s\" %s */
 	  const char * ifconfig_ipv6_local =3D print_in6_addr (tt->local_ipv6, 0,=
 &gc);
-	  msg( M_WARN, "TODO: remove IPv6 address %s", ifconfig_ipv6_local );
+	  argv_printf (&argv,
+		    "%s%sc interface ipv6 delete address %s %s",
+		     get_win_sys_path(),
+		     NETSH_PATH_SUFFIX,
+		     tt->actual_name,
+		     ifconfig_ipv6_local );
+
+	  netsh_command (&argv, 1);
+          argv_reset (&argv);
 	}
 #if 1
       if (tt->ipapi_context_defined)
--=20
1.7.3.4


--0zAvg8I2HpXbmZ+A--

--9JkkYVew5bnwk98f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTdoe3KkuBuNlUUl1AQJMPAP9HcjDQHB3xg0EZiLfsgEfNINkQV6L4zvc
lMkfSWmcVpr1sALP+wlg30rA4WFFatOJgCrwczWatAl+Yc+0+hUEG2XWLF+kT/S5
Hmeg0Q+u/0CeYxNwo0Wy65Gz/Zrdqneht+STzUjQW/gt2+whU76sX8bqHPdDQWju
DClnwGUauuM=
=y5Sh
-----END PGP SIGNATURE-----

--9JkkYVew5bnwk98f--

