Date: Sun, 9 Oct 2016 17:25:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161009152550.GQ78279@...1296...>
References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20161009150659.GP78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2lCmpQ62TRaeIcwq"
Content-Disposition: inline
In-Reply-To: <20161009150659.GP78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--2lCmpQ62TRaeIcwq
Content-Type: multipart/mixed; boundary="22dWWJgtieCGojmV"
Content-Disposition: inline

--22dWWJgtieCGojmV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 09, 2016 at 05:06:59PM +0200, Gert Doering wrote:
> Running more tests with that hunk reverted next...

With the following patch applied on top of Heiko's patch

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4a11d10..1250547 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1373,11 +1373,13 @@ do_ifconfig (struct tuntap *tt,
 	else
 	  {
 	    /* example: netsh interface ipv6 set address interface=3D42 2001:608:=
8003::d store=3Dactive */
+	    char iface[64];
+	    openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu", tt->adapter=
_index );
 	    argv_printf (&argv,
-			 "%s%sc interface ipv6 set address interface=3D%lu %s store=3Dactive",
+			 "%s%sc interface ipv6 set address %s %s store=3Dactive",
 			 get_win_sys_path(),
 			 NETSH_PATH_SUFFIX,
-			 tt->adapter_index,
+			 iface,
 			 ifconfig_ipv6_local );
 	    netsh_command (&argv, 4, M_FATAL);
 	  }


... the resulting binary now actually works :-) - tested on win7, without(!)
iservice (because Heiko already tested that), testing all the variants
of "--ip-win32".  Only a single tap adapter in the system, but will test
with 2-3 taps next (and trying to run multiple instances).

I've done a "v2" of Heiko's patch with that change included, which I'll
append below.  Samuli, could you build us a windows installer with master
plus that patch, for "windows early alpha testing"?  If that change=20
works for people, we are very close to 2.4_alpha1...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--22dWWJgtieCGojmV
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Windows-do_ifconfig-after-open_tun-v2.patch"
Content-Transfer-Encoding: quoted-printable

=46rom a98ac9043ea9445537936a88808d3d1939102e39 Mon Sep 17 00:00:00 2001
=46rom: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 24 Jun 2016 18:01:41 +0200
Subject: [PATCH] Windows: do_ifconfig() after open_tun()

When you had multiple TAP adapters and IPv6 configured you got an error
message about "you must also specify --dev-node" and openvpn exited.
Very inconvenient especially since this is only due to the fact that
Windows tries to set the adapter address before it is opened; for no
good reason.

This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some
initialization code to init_tun, where it belongs, and removes duplicate
code that is now no longer needed.

v2: do not use "%lu" in argv_printf(), crashes non-iservice usage

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 54 ++++++++++++++++++---------------------------------=
---
 src/openvpn/tun.h |  2 +-
 2 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b7a29f7..1250547 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -611,6 +611,21 @@ init_tun (const char *dev,       /* --dev option */
 	  tt->broadcast =3D generate_ifconfig_broadcast_addr (tt->local, tt->remo=
te_netmask);
 	}
=20
+#ifdef WIN32
+      /*
+       * Make sure that both ifconfig addresses are part of the
+       * same .252 subnet.
+       */
+      if (tun)
+        {
+          verify_255_255_255_252 (tt->local, tt->remote_netmask);
+          tt->adapter_netmask =3D ~3;
+        }
+      else
+        {
+          tt->adapter_netmask =3D tt->remote_netmask;
+        }
+#endif
=20
       tt->did_ifconfig_setup =3D true;
     }
@@ -1327,19 +1342,7 @@ do_ifconfig (struct tuntap *tt,
       }
 #elif defined (WIN32)
       {
-	/*
-	 * Make sure that both ifconfig addresses are part of the
-	 * same .252 subnet.
-	 */
-	if (tun)
-	  {
-	    verify_255_255_255_252 (tt->local, tt->remote_netmask);
-	    tt->adapter_netmask =3D ~3;
-	  }
-	else
-	  {
-	    tt->adapter_netmask =3D tt->remote_netmask;
-	  }
+        ASSERT (actual !=3D NULL);
=20
 	switch (tt->options.ip_win32_type)
 	  {
@@ -1350,9 +1353,6 @@ do_ifconfig (struct tuntap *tt,
 		 print_in_addr_t (tt->adapter_netmask, 0, &gc));
 	    break;
 	  case IPW32_SET_NETSH:
-	    if (!strcmp (actual, "NULL"))
-	      msg (M_FATAL, "Error: When using --ip-win32 netsh, if you have more=
 than one TAP-Windows adapter, you must also specify --dev-node");
-
 	    netsh_ifconfig (&tt->options,
 			    actual,
 			    tt->local,
@@ -1366,25 +1366,6 @@ do_ifconfig (struct tuntap *tt,
=20
     if ( do_ipv6 )
       {
-	char * saved_actual;
-	char iface[64];
-	DWORD idx;
-
-	if (!strcmp (actual, "NULL"))
-	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one =
TAP-Windows adapter, you must also specify --dev-node");
-
-	idx =3D get_adapter_index_flexible(actual);
-	openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu", idx);
-
-	/* on windows, OpenVPN does ifconfig first, open_tun later, so
-	 * tt->actual_name might not yet be initialized, but routing code
-	 * needs to know interface name - point to "actual", restore later
-	 */
-	saved_actual =3D tt->actual_name;
-	tt->actual_name =3D (char*) actual;
-	/* we use adapter_index in add_route_ipv6 */
-	tt->adapter_index =3D idx;
-
 	if (tt->options.msg_channel)
 	  {
 	    do_address_service (true, AF_INET6, tt);
@@ -1392,6 +1373,8 @@ do_ifconfig (struct tuntap *tt,
 	else
 	  {
 	    /* example: netsh interface ipv6 set address interface=3D42 2001:608:=
8003::d store=3Dactive */
+	    char iface[64];
+	    openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu", tt->adapter=
_index );
 	    argv_printf (&argv,
 			 "%s%sc interface ipv6 set address %s %s store=3Dactive",
 			 get_win_sys_path(),
@@ -1403,7 +1386,6 @@ do_ifconfig (struct tuntap *tt,
=20
 	/* explicit route needed */
 	add_route_connected_v6_net(tt, es);
-	tt->actual_name =3D saved_actual;
       }
 #else
       msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands=
 on this operating system.  You should ifconfig your TUN/TAP device manuall=
y or use an --up script.");
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4e93a3f..1ccf378 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -301,7 +301,7 @@ ifconfig_order(void)
 #elif defined(TARGET_NETBSD)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(WIN32)
-  return IFCONFIG_BEFORE_TUN_OPEN;
+  return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_ANDROID)
   return IFCONFIG_BEFORE_TUN_OPEN;
 #else
--=20
1.9.1


--22dWWJgtieCGojmV--

--2lCmpQ62TRaeIcwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/phfakuBuNlUUl1AQKAFAP+Lq+7lTCrhsCML2EgkRDz51ReYzOvzhIE
K//g6HQc8uwNwg+AQ1a3GjzZuD6A3sA+mdt3VlmUuIXCrI6kmvXhyLQVaHo1L+0h
RJ+uC0/bMo8B7XRjTWFjdIvLzQ6CtfQPVXsgbQJGF3B2xVvyTStSoTBRDodcXmrn
pE8FUb8l0CI=
=Ajyq
-----END PGP SIGNATURE-----

--2lCmpQ62TRaeIcwq--

