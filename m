Date: Fri, 3 Feb 2012 18:21:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120203172157.GN13929@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
Subject: [Openvpn-devel] more t_client.sh fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--XStn23h1fwudRqtG
Content-Type: multipart/mixed; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline

--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

last patch for "sudo functionality in t_client.sh" was incomplete, and
for some reason I didn't notice on the test system - fell on my feet on
the freebsd 7.4 test client, and is now fixed for good :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-RUN_SUDO-functionality-for-t_client.sh.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 7557b960593aa7240cfe7f9e9b5628e3b4ef55c9 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Fri, 3 Feb 2012 19:18:07 +0200
Subject: [PATCH] Fix RUN_SUDO functionality for t_client.sh

Commit 9c6ee9d1ecd85535c was incomplete - while it will run openvpn with
sudo, it will not use sudo for the "kill" commands needed to test whether
the background process is still there, and for actually stopping openvpn
after the test has finished.

Signed-off-by: Gert Doering <gert@...1296...>
---
 t_client.sh.in |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t_client.sh.in b/t_client.sh.in
index a6377db..47839de 100755
--- a/t_client.sh.in
+++ b/t_client.sh.in
@@ -233,14 +233,14 @@ do
     opid=3D$!
=20
     # make sure openvpn client is terminated in case shell exits
-    trap "kill $opid" 0
-    trap "kill $opid ; trap - 0 ; exit 1" 1 2 3 15
+    trap "$RUN_SUDO kill $opid" 0
+    trap "$RUN_SUDO kill $opid ; trap - 0 ; exit 1" 1 2 3 15
=20
     echo "wait for connection to establish..."
     sleep 10
=20
     # test whether OpenVPN process is still there
-    if kill -0 $opid
+    if $RUN_SUDO kill -0 $opid
     then :
     else
 	echo -e "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:=
openvpn.log).  FAIL.\ntail of logfile follows:\n..." >&2
@@ -271,7 +271,7 @@ do
     echo -e "ping tests done.\n"
=20
     echo "stopping OpenVPN"
-    kill $opid
+    $RUN_SUDO kill $opid
     wait $!
     rc=3D$?
     if [ $rc !=3D 0 ] ; then
--=20
1.7.3.5


--zaRBsRFn0XYhEU69--

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTywXtakuBuNlUUl1AQLrowP/UNl1DEhb27UxoU00M1LQVHtZhxNUEJo8
HQFd6zcl2a5M/MHNDe6+ZCsVeGO+lNXnVKPAYlwSmH1NmOdkpZe3BBw2Zfa7PeAd
XoAK58oJVORRoocWeCOYa3ebjGzjK9qGm8lTJI/swmd0oXhHbZg/dAPhMQXruoV9
GF86WSt7h3k=
=b6Xd
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--

