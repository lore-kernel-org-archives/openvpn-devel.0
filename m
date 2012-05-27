Date: Sun, 27 May 2012 22:27:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120527202737.GV1161@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Content-Disposition: inline
Subject: [Openvpn-devel] build revolution lost t_client test?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--HcXnUX77nabWBLF4
Content-Type: multipart/mixed; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline

--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

working on the test server, I noticed that t_client.sh was no longer run
from "make check", and that it lost "read t_client.rc from build dir"
(which is needed when building different clients from a common source
dir, and wanting to run t_client with different option sets).

The attached patch restores lost functionality, and adds one extra
feature, optionally waiting longer for OpenVPN startup (if the server
has a high RTT, 10 seconds is not always enough).

David, this has been tested on FreeBSD 7.4 (so far) and is essential=20
for the buildbot client tests :-) - more platform tests will follow
as soon as I have all the server stanzas up and running.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-repair-t_client.sh-test-after-build-system-revolutio.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 125b3c96dc60694eb50dc4a85e758727864e83ee Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 27 May 2012 23:19:11 +0300
Subject: [PATCH] repair t_client.sh test after build system revolution

- run t_client.sh at "make check" time
- in t_client.sh, read t_client.rc from source *or* build dir (as before)
- @IP@ evaluates to "" now (not "ip") if iproute2 not found - adapt script
- introduce $SETUP_TIME_WAIT to delay "waiting for openvpn startup" longer
  than the default delay of 10 seconds - this is needed for test servers
  with a high network RTT

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/Makefile.am    |    5 ++---
 tests/t_client.sh.in |   13 ++++++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6ae845b..b7980e0 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -12,13 +12,12 @@
 MAINTAINERCLEANFILES =3D \
 	$(srcdir)/Makefile.in
=20
-test_scripts =3D t_lpback.sh t_cltsrv.sh
+test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
=20
 TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
 TESTS =3D $(test_scripts)
=20
 dist_noinst_SCRIPTS =3D \
 	$(test_scripts) \
-	t_cltsrv-down.sh \
-	t_client.sh
+	t_cltsrv-down.sh
=20
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7ba124c..92e4d2e 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -14,16 +14,19 @@
=20
 srcdir=3D"${srcdir:-.}"
 top_builddir=3D"${top_builddir:-..}"
-if [ -r "${srcdir}"/t_client.rc ] ; then
+if [ -r "${top_builddir}"/t_client.rc ] ; then
+    . "${top_builddir}"/t_client.rc
+elif [ -r "${srcdir}"/t_client.rc ] ; then
     . "${srcdir}"/t_client.rc
 else
-    echo "$0: cannot find 't_client.rc' in ('${srcdir}'). SKIPPING TEST." =
>&2
+    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" =
>&2
+    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
     exit 77
 fi
=20
 if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
 then
-    echo "no (executable) openvpn binary in current directory. FAIL." >&2
+    echo "no (executable) openvpn binary in current build tree. FAIL." >&2
     exit 1
 fi
=20
@@ -83,7 +86,7 @@ fail()
 get_ifconfig_route()
 {
     # linux / iproute2? (-> if configure got a path)
-    if [ "@IPROUTE@" !=3D "ip" ]
+    if [ "@IPROUTE@" !=3D "" ]
     then
 	echo "-- linux iproute2 --"
 	@IPROUTE@ addr show     | grep -v valid_lft
@@ -236,7 +239,7 @@ do
     trap "$RUN_SUDO kill $opid ; trap - 0 ; exit 1" 1 2 3 15
=20
     echo "wait for connection to establish..."
-    sleep 10
+    sleep ${SETUP_TIME_WAIT:-10}
=20
     # test whether OpenVPN process is still there
     if $RUN_SUDO kill -0 $opid
--=20
1.7.3.5


--XigHxYirkHk2Kxsx--

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8KOOKkuBuNlUUl1AQJ8VQP+J1R3kvlAnmNnTJwZ+P8KTYG8j+Be0IV7
hunhddsIjf4292rsGpJ0oum1MludiO9ufCfqc7fq+/l/Y9a+scoe3B3JZ40e3mXC
FdXzSYlzBm182NfqonRu0PGcnb1DHOUykbWLyvCsagq71nDKuQVPoxQbVuljr7yn
lW6IHh3ZX4M=
=M06r
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--

