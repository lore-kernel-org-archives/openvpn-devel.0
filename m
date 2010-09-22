Date: Wed, 22 Sep 2010 22:33:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100922203311.GA10846@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
Subject: [Openvpn-devel] PULL-REQ: IPv6 bugfix for Linux/iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Fba/0zbH8Xs+Fj9o
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline

--wac7ysb48OaltWcw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here are three patches for the feat_ipv6_payload branch.=20=20

The combination of Linux + iproute2 + "topology subnet" + ipv6 wasn't=20
working, because the "configure IPv6 here!" code was inside the if()
clause that was only executed for "dev tun + topology net30".

(Interesting enough, for "ifconfig", I got this right :-))

Second patch is "the URL in openvpn.8 was wrong".

Third patch is "show the updated IPv6 stuff in openvpn --version".

David, please pull from git://compile.svr01.mucip.net/openvpn-gert.git
(master).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-correct-URL-for-more-information-about-IPv6-patch-is.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 63203e2ed42b951eb5c676d5f5a99ff43ac28944 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 15 Sep 2010 19:23:10 +0200
Subject: [PATCH 1/3] correct URL for "more information about IPv6 patch is =
*here*"

Signed-off-by: Gert Doering <gert@...1296...>
---
 openvpn.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index f1612a7..c269f33 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -4836,7 +4836,7 @@ option can be used BEFORE this option to produce debu=
gging information.
 The following options exist to support IPv6 tunneling in peer-to-peer
 and client-server mode.  As of now, this is just very basic
 documentation of the IPv6-related options. More documentation can be
-found on http://greenie.muc.de/ipv6/openvpn.html.
+found on http://www.greenie.net/ipv6/openvpn.html.
 .TP
 .B --ifconfig-ipv6 ipv6addr/bits ipv6remote
 configure IPv6 address
--=20
1.6.4.4


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-bugfix-for-linux-iproute2-IPv6-ifconfig-code-block-w.patch"
Content-Transfer-Encoding: quoted-printable

=46rom eca3df6b4e5ff461236ec2bce84c2bab76ac0dc5 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 22 Sep 2010 22:18:35 +0200
Subject: [PATCH 2/3] bugfix for linux/iproute2: IPv6 ifconfig code block wa=
s not called for
 "dev tun"+"topology subnet" - moved code out of "if (tun)" block, works.

add more debug information to help diagnose cases where IPv6 isn't working
Signed-off-by: Gert Doering <gert@...1296...>
---
 tun.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tun.c b/tun.c
index 30d3be1..ca30124 100644
--- a/tun.c
+++ b/tun.c
@@ -615,7 +615,8 @@ do_ifconfig (struct tuntap *tt,
=20
       argv_init (&argv);
=20
-      msg( M_INFO, "do_ifconfig, tt->ipv6=3D%d", tt->ipv6 );
+      msg( M_INFO, "do_ifconfig, tt->ipv6=3D%d, tt->did_ifconfig_ipv6_setu=
p=3D%d",
+	           tt->ipv6, tt->did_ifconfig_ipv6_setup );
=20
       /*
        * We only handle TUN/TAP devices here, not --dev null devices.
@@ -681,18 +682,6 @@ do_ifconfig (struct tuntap *tt,
 				  );
 		  argv_msg (M_INFO, &argv);
 		  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip addr add failed");
-		  if ( do_ipv6 )
-		    {
-		      argv_printf( &argv,
-				  "%s -6 addr add %s/%d dev %s",
-				  iproute_path,
-				  ifconfig_ipv6_local,
-				  tt->netbits_ipv6,
-				  actual
-				  );
-		      argv_msg (M_INFO, &argv);
-		      openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr add fa=
iled");
-		    }
 	} else {
 		argv_printf (&argv,
 				  "%s addr add dev %s %s/%d broadcast %s",
@@ -705,7 +694,19 @@ do_ifconfig (struct tuntap *tt,
 		  argv_msg (M_INFO, &argv);
 		  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip addr add failed");
 	}
-	tt->did_ifconfig =3D true;
+      if ( do_ipv6 )
+	{
+	  argv_printf( &argv,
+		      "%s -6 addr add %s/%d dev %s",
+		      iproute_path,
+		      ifconfig_ipv6_local,
+		      tt->netbits_ipv6,
+		      actual
+		      );
+	  argv_msg (M_INFO, &argv);
+	  openvpn_execve_check (&argv, es, S_FATAL, "Linux ip -6 addr add failed"=
);
+	}
+      tt->did_ifconfig =3D true;
 #else
       if (tun)
 	argv_printf (&argv,
--=20
1.6.4.4


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-bump-IPv6-version-number-openvpn-version-to-20100922.patch"
Content-Transfer-Encoding: quoted-printable

=46rom f59331422c0bc00cec81930add98675eeca6dd32 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 22 Sep 2010 22:23:10 +0200
Subject: [PATCH 3/3] bump IPv6 version number (openvpn --version) to 201009=
22-1
 document Linux tun fixes and test results in ChangeLog.IPv6

Signed-off-by: Gert Doering <gert@...1296...>
---
 ChangeLog.IPv6 |   10 ++++++++++
 options.c      |    2 +-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/ChangeLog.IPv6 b/ChangeLog.IPv6
index 19bbad7..252450d 100644
--- a/ChangeLog.IPv6
+++ b/ChangeLog.IPv6
@@ -338,3 +338,13 @@ Thu Sep  2 21:18:32 CEST 2010
=20
   * tun.c: the TAP binary in 2.2-beta3 has the IPv6 related changes, but
     the version number is 9.8 now -> check for 9.8, not 9.7
+
+Wed Sep 22 22:20:37 CEST 2010
+
+  * tun.c: bugfix for Linux/iproute2/"topology subnet".  Works :-)
+
+  * TEST SUCCESS: Linux/ifconfig: client-tun/net30+subnet, v4+v6
+
+  * TEST SUCCESS: Linux/iproute2: client-tun/net30+subnet, v4+v6
+
+  * options.c: tag as 20100922-1 so "allmerged" users can see IPv6 change
diff --git a/options.c b/options.c
index f84d155..fe006f3 100644
--- a/options.c
+++ b/options.c
@@ -73,7 +73,7 @@ const char title_string[] =3D
 #ifdef ENABLE_PKCS11
   " [PKCS11]"
 #endif
-  " [IPv6 payload 20100307-1]"
+  " [IPv6 payload 20100922-1]"
   " built on " __DATE__
 ;
=20
--=20
1.6.4.4


--wac7ysb48OaltWcw--

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTJpoB6kuBuNlUUl1AQKnDgQAquuC4wv10UzOVN+e6NwcIbbQTuCPw2nw
BgP6f892OusKuEIPwcl2yURTkZJv65Hkyijw7NH4k4BXl2GChowSrsyP/Cjm8w93
2o1s3NlKUAWnMfdxVflIHJy0Yd45iZwCv1mVgNs26yg75ekEOczRe+J0T2AJC+w2
HDLODbNisJI=
=W54V
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

