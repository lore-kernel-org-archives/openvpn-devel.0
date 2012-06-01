Date: Fri, 1 Jun 2012 17:15:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120601151507.GE400@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
Subject: [Openvpn-devel] t_client.sh iproute2 fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f+W+jCU1fRNres8c
Content-Type: multipart/mixed; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

testing with David on Linux today uncovered differences between
"ip -6 route show" on Gentoo (only shows the active routing table)
and FC14 (also shows the ipv6 route cache).  The route cache is not
interesting, but distorts our tests, as it depends on what else was
going on on the machine instead of "explicit route/ifconfig settings
by OpenVPN".  So work around this.

Also, include the proposed change from Alon to test for iproute2=20
existance with "-n".  More clean that way is.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-t_client.sh-iproute2-script-fixes.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 0f3819a1fa53a32531aa37ea33caef77d8ca7d59 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Fri, 1 Jun 2012 18:13:09 +0300
Subject: [PATCH] t_client.sh iproute2 script fixes

Test for existance of "iproute2" with "-n" (Alon)

Work around "ip -6 route show" behaviour on FC14 where some parts of
the IPv6 route cache would be displayed, which has no relevance to
OpenVPN but breaks before/after comparison.

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 92e4d2e..d58b821 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -86,12 +86,12 @@ fail()
 get_ifconfig_route()
 {
     # linux / iproute2? (-> if configure got a path)
-    if [ "@IPROUTE@" !=3D "" ]
+    if [ -n "@IPROUTE@" ]
     then
 	echo "-- linux iproute2 --"
 	@IPROUTE@ addr show     | grep -v valid_lft
 	@IPROUTE@ route show
-	@IPROUTE@ -6 route show | sed -e 's/expires [0-9]*sec //'
+	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -e 's/expires [0-9]*s=
ec //'
 	return
     fi
=20
--=20
1.7.3.5


--H+4ONPRPur6+Ovig--

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8jceqkuBuNlUUl1AQJeKgP/fxYDlDgGL1jHHX5wTHxwAiu99bca/e0R
JVCKWsZtBylyNeIna5WJombmQP5OpmjlL3HTkWSfHcrhZHWCIWtWyvVzu4T3fHfJ
HVT+Zwwp4+05t398G2RDdPpdJ6zl7qtElT4H4zGIQ1BW3PpwOnrIxV3+6GoPTfnf
2a46RPGQEmo=
=Hk/Z
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

