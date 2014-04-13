Date: Sun, 13 Apr 2014 19:06:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413170648.GU16637@...1296...>
References: <20140409232527.GA3061@...1890...>
	<20140413125641.GQ16637@...1296...>
	<20140413133920.GA28182@...1890...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1HlHHhgUeBYuH8cg"
Content-Disposition: inline
In-Reply-To: <20140413133920.GA28182@...1890...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cedric Tabary <cedric+openvpn@...1891...>
Cc: openvpn-devel@lists.sourceforge.net

--1HlHHhgUeBYuH8cg
Content-Type: multipart/mixed; boundary="kiZRxUUXMjjOY8NI"
Content-Disposition: inline

--kiZRxUUXMjjOY8NI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 03:39:20PM +0200, Cedric Tabary wrote:
> Bug is still there in this build,
> I think you patched the route removal but not the ipv6 address removal
> on the interface itself.

Next try.  Thanks for your patience :-) - this patch + installer do the
"store=3Dactive" both on the "address delete" and on the "route delete",
so it would be good to know that it works on both ends of the spectrum,
Win XP and Win 8.1

  http://www.greenie.net/ipv6/openvpn-install-2.3.3-win8fix-I100-i686.exe
  http://www.greenie.net/ipv6/openvpn-install-2.3.3-win8fix-I100-x86_64.exe

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kiZRxUUXMjjOY8NI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-IPv6-address-route-delete-fix-for-Win8.patch"
Content-Transfer-Encoding: quoted-printable

=46rom ee4a33029d1aafd1aa3c85f0317a93612c03ea1a Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 13 Apr 2014 13:12:02 +0200
Subject: [PATCH] IPv6 address/route delete fix for Win8

Use "store=3Dactive" for IPv6 address and route deletion - seems to be
required on Windows 8 and up, and not doing it will break OpenVPN
reconnection (old addresses are not properly deleted, thus address can
not be configured on connect).

Reported-by: Cedric <cedric+openvpn@...1891...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 8 +++++++-
 src/openvpn/tun.c   | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6333ee7..f470f7e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1974,10 +1974,16 @@ delete_route_ipv6 (const struct route_ipv6 *r6, con=
st struct tuntap *tt, unsigne
     argv_printf_cat (&argv, "METRIC %d", r->metric);
 #endif
=20
+  /* Windows XP to 7 "just delete" routes, wherever they came from, but
+   * in Windows 8(.1?), if you create them with "store=3Dactive", this is
+   * how you should delete them as well (pointed out by Cedric Tabary)
+   */
+  argv_printf_cat( &argv, " store=3Dactive" );
+
   argv_msg (D_ROUTE, &argv);
=20
   netcmd_semaphore_lock ();
-  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add ipv6 comma=
nd failed");
+  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete ipv6 co=
mmand failed");
   netcmd_semaphore_release ();
=20
 #elif defined (TARGET_SOLARIS)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 976cc52..ba4b15e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5196,10 +5196,14 @@ close_tun (struct tuntap *tt)
 	  /* remove route pointing to interface */
 	  delete_route_connected_v6_net(tt, NULL);
=20
+	  /* "store=3Dactive" is needed in Windows 8(.1) to delete the
+	   * address we added (pointed out by Cedric Tabary).
+	   */
+
 	  /* netsh interface ipv6 delete address \"%s\" %s */
 	  ifconfig_ipv6_local =3D print_in6_addr (tt->local_ipv6, 0,  &gc);
 	  argv_printf (&argv,
-		    "%s%sc interface ipv6 delete address %s %s",
+		    "%s%sc interface ipv6 delete address %s %s store=3Dactive",
 		     get_win_sys_path(),
 		     NETSH_PATH_SUFFIX,
 		     tt->actual_name,
--=20
1.8.3.2


--kiZRxUUXMjjOY8NI--

--1HlHHhgUeBYuH8cg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0rEKKkuBuNlUUl1AQL+MwQAvCR5J4i9h2FPcOMRs0kF1m8BQ0/HLS6K
pmEg5MdPZYlIxq/R6NyzZ1y65SyPH7ucb4IcqBTUFOuVTqWoq/qn+u6VNZ/mrmRC
yb0QZHkHOR61Ov6f4nDb6MubYKZgx73DYfEXFe3Rztyjk/pqSn7fbdiTnkx9iCyp
3s2XerWWrpg=
=Wpei
-----END PGP SIGNATURE-----

--1HlHHhgUeBYuH8cg--

