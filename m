Date: Sun, 22 Jan 2012 22:41:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120122214129.GJ5060@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SAeLYP8kwBCGlqB7"
Content-Disposition: inline
Subject: [Openvpn-devel]  t_client.sh enhancements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--SAeLYP8kwBCGlqB7
Content-Type: multipart/mixed; boundary="lc/+3UtgiEbvMcQ8"
Content-Disposition: inline

--lc/+3UtgiEbvMcQ8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I run all my cross-platform clients tests via t_client.sh, and a few
things started to annoy me:

 - must run "make check" as root (which is problematic for buildbot)
 - just prints "test #4", but doesn't tell me what this particular test
   is doing ("tcp/tap/ipv4-only").

So - add a variable that can be used to call sudo, and add another set
of config variables that will make it print out a user-specified title=20
of what it's doing.  Fairly trivial, really, but might be useful for
someone else as well :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lc/+3UtgiEbvMcQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-add-print-test-titles-and-use-sudo-functionality-to-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom adb6db537a7ed6a4c313bb5b213bfdbbbf6c41ad Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 22 Jan 2012 22:37:25 +0100
Subject: [PATCH] add "print test titles" and "use sudo" functionality to
 t_client.rc

Signed-off-by: Gert Doering <gert@...1296...>
---
 t_client.rc-sample |    9 +++++++++
 t_client.sh.in     |   23 ++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/t_client.rc-sample b/t_client.rc-sample
index ca59c68..e766b5d 100644
--- a/t_client.rc-sample
+++ b/t_client.rc-sample
@@ -20,6 +20,12 @@ REMOTE=3Dmytestserver
 TEST_RUN_LIST=3D"1 2"
=20
 #
+# use "sudo" (etc) to give openvpn the necessary privileges
+# if this is not active, "make check" must be run as root
+#
+#RUN_SUDO=3Dsudo
+
+#
 # base confic that is the same for all the p2mp test runs
 #
 OPENVPN_BASE_P2MP=3D"--client --ca $CA_CERT \
@@ -39,6 +45,7 @@ OPENVPN_BASE_P2P=3D"..."
 #
 # possible test options:
 #
+# RUN_TITLE_x=3D"what is being tested on here" (purely informational)
 # OPENVPN_CONF_x =3D "how to call ./openvpn" [mandatory]
 # EXPECT_IFCONFIG4_x =3D "this IPv4 address needs to show up in ifconfig"
 # EXPECT_IFCONFIG6_x =3D "this IPv6 address needs to show up in ifconfig"
@@ -48,6 +55,7 @@ OPENVPN_BASE_P2P=3D"..."
 # Test 1: UDP / p2mp tun
 #   specify IPv4+IPv6 addresses expected from server and ping targets
 #
+RUN_TITLE_1=3D"testing tun/udp/ipv4+ipv6"
 OPENVPN_CONF_1=3D"$OPENVPN_BASE_P2MP --dev tun --proto udp --remote $REMOT=
E --port 51194"
 EXPECT_IFCONFIG4_1=3D"10.100.50.6"
 EXPECT_IFCONFIG6_1=3D"2001:dba:a050::1:0"
@@ -56,6 +64,7 @@ PING6_HOSTS_1=3D"2001:dba::1 2001:dba:a050::1"
=20
 # Test 2: TCP / p2mp tun
 #
+RUN_TITLE_2=3D"testing tun/tcp/ipv4+ipv6"
 OPENVPN_CONF_2=3D"$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOT=
E --port 51194"
 EXPECT_IFCONFIG4_2=3D"10.100.51.6"
 EXPECT_IFCONFIG6_2=3D"2001:dba:a051::1:0"
diff --git a/t_client.sh.in b/t_client.sh.in
index b273964..a6377db 100755
--- a/t_client.sh.in
+++ b/t_client.sh.in
@@ -50,8 +50,12 @@ ID=3D`id`
 if expr "$ID" : "uid=3D0" >/dev/null
 then :
 else
-    echo "$0: this test must run be as root. SKIP." >&2
-    exit 77
+    if [ -z "$RUN_SUDO" ]
+    then
+        echo "$0: this test must run be as root, or RUN_SUDO=3D... " >&2
+        echo "      must be set correctly in 't_client.rc'. SKIP." >&2
+        exit 77
+    fi
 fi
=20
 LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`
@@ -199,19 +203,20 @@ run_ping_tests()
 # ----------------------------------------------------------
 for SUF in $TEST_RUN_LIST
 do
-    echo -e "\n### test run $SUF ###\n"
-    fail_count=3D0
-
-    echo "save pre-openvpn ifconfig + route"
-    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
-
     # get config variables
+    eval test_run_title=3D\"\$RUN_TITLE_$SUF\"
     eval openvpn_conf=3D\"\$OPENVPN_CONF_$SUF\"
     eval expect_ifconfig4=3D\"\$EXPECT_IFCONFIG4_$SUF\"
     eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\"
=20
+    echo -e "\n### test run $SUF: '$test_run_title' ###\n"
+    fail_count=3D0
+
+    echo "save pre-openvpn ifconfig + route"
+    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
+
     echo -e "\nrun pre-openvpn ping tests - targets must not be reachable.=
.."
     run_ping_tests 4 want_fail "$ping4_hosts"
     run_ping_tests 6 want_fail "$ping6_hosts"
@@ -224,7 +229,7 @@ do
     fi
=20
     echo " run ./openvpn $openvpn_conf"
-    ./openvpn $openvpn_conf >$LOGDIR/$SUF:openvpn.log &
+    $RUN_SUDO ./openvpn $openvpn_conf >$LOGDIR/$SUF:openvpn.log &
     opid=3D$!
=20
     # make sure openvpn client is terminated in case shell exits
--=20
1.7.7


--lc/+3UtgiEbvMcQ8--

--SAeLYP8kwBCGlqB7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTxyCiakuBuNlUUl1AQLpfwQArmZ2T7VBlYnd05r9KanZ2jEQDLs19RQ6
0Dzx+8VpfFEX8/x42gp7NxTK8oiffh6rmBqvxt3GGNXwBL8rwqDL5GDUxXYIr/Yz
lcV5TfoFcd3AQVEUQLl5fPLsf2jqjHP35yhWD/B8BO05cckq9lQ5Rp32cIrYgloX
AlN/NDhXke4=
=Zsue
-----END PGP SIGNATURE-----

--SAeLYP8kwBCGlqB7--

