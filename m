From: samuli@...515...
Date: Mon,  3 Oct 2016 13:51:27 +0300
Message-Id: <1475491887-740-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Automatically cache expected IPs for
	t_client.sh on the first run
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Previously one had to manually define correct values for the EXPECT_IFCONFI=
G*
variables based on what IPv4 and IPv6 addresses the test VPN server handed =
out.
This was a tedious process especially with large number of tests, as the IPs
changed for every test client and for every test. With this patch t_client.=
sh
figures out the correct IP addresses using an --up script and caches them t=
o a
separate file for later use.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 .gitignore                   |  1 +
 tests/t_client.rc-sample     | 12 ++++++++----
 tests/t_client.sh.in         |  8 +++++++-
 tests/update_t_client_ips.sh |  7 +++++++
 4 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100755 tests/update_t_client_ips.sh

diff --git a/.gitignore b/.gitignore
index 0eea06e..fc1e223 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@ distro/rpm/openvpn.spec
 tests/t_client.sh
 tests/t_client-*-20??????-??????/
 t_client.rc
+t_client_ips.rc
=20
 src/openvpn/openvpn
 include/openvpn-plugin.h
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 6e66607..fb2abfa 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -11,6 +11,14 @@ top_srcdir=3D"${top_srcdir:-..}"
 CA_CERT=3D"${top_srcdir}/sample/sample-keys/ca.crt"
 CLIENT_KEY=3D"${top_srcdir}/sample/sample-keys/client.key"
 CLIENT_CERT=3D"${top_srcdir}/sample/sample-keys/client.crt"
+
+# Load EXPECT_IFCONFIG* parameters from cache
+if [ -r "${top_srcdir}/t_client_ips.rc" ]; then
+    . "${top_srcdir}/t_client_ips.rc"
+else
+    echo "NOTICE: missing t_client_ips.rc will be auto-generated"
+fi
+
 #
 # remote host (used as macro below)
 #
@@ -58,8 +66,6 @@ OPENVPN_BASE_P2P=3D"..."
 #
 RUN_TITLE_1=3D"testing tun/udp/ipv4+ipv6"
 OPENVPN_CONF_1=3D"$OPENVPN_BASE_P2MP --dev tun --proto udp --remote $REMOT=
E --port 51194"
-EXPECT_IFCONFIG4_1=3D"10.100.50.6"
-EXPECT_IFCONFIG6_1=3D"2001:db8:a050::1:0"
 PING4_HOSTS_1=3D"10.100.50.1 10.100.0.1"
 PING6_HOSTS_1=3D"2001:db8::1 2001:db8:a050::1"
=20
@@ -67,8 +73,6 @@ PING6_HOSTS_1=3D"2001:db8::1 2001:db8:a050::1"
 #
 RUN_TITLE_2=3D"testing tun/tcp/ipv4+ipv6"
 OPENVPN_CONF_2=3D"$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOT=
E --port 51194"
-EXPECT_IFCONFIG4_2=3D"10.100.51.6"
-EXPECT_IFCONFIG6_2=3D"2001:db8:a051::1:0"
 PING4_HOSTS_2=3D"10.100.51.1 10.100.0.1"
 PING6_HOSTS_2=3D"2001:db8::1 2001:db8:a051::1"
=20
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 2b9bacf..d1c5d87 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -271,6 +271,12 @@ do
     eval ping4_hosts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\"
=20
+    # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
+    # script to generate them dynamically.
+    if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
+        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} =
--script-security 2 --up ${top_builddir}/tests/update_t_client_ips.sh"
+    fi
+
     echo -e "\n### test run $SUF: '$test_run_title' ###\n"
     fail_count=3D0
=20
@@ -294,7 +300,7 @@ do
     fi
=20
     pidfile=3D"${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
-    openvpn_conf=3D"$openvpn_conf --writepid $pidfile"
+    openvpn_conf=3D"$openvpn_conf --writepid $pidfile $up"
     echo " run openvpn $openvpn_conf"
     echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
     umask 022
diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
new file mode 100755
index 0000000..e7b58ba
--- /dev/null
+++ b/tests/update_t_client_ips.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+#
+# This --up script caches the IPs handed out by the test VPN server to a f=
ile
+# for later use.
+
+echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $TOP_BUILDDIR/t_clie=
nt_ips.rc
+echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $TOP_BUILDDIR/t=
_client_ips.rc
--=20
2.1.4


