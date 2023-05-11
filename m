From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 11 May 2023 12:12:53 +0200
Message-Id: <20230511101253.369196-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tests: Allow to override openvpn binary used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This makes it easy to test an installed binary for
example.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/t_client.sh.in |  7 ++++---
 tests/t_cltsrv.sh    |  5 +++--
 tests/t_lpback.sh    | 13 +++++++------
 tests/t_net.sh       |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index e919456a..99e6f9c6 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -18,6 +18,7 @@ TCLIENT_SKIP_RC="${TCLIENT_SKIP_RC:-77}"
 
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 if [ -r "${top_builddir}"/t_client.rc ] ; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ] ; then
@@ -49,7 +50,7 @@ if [ $? -ne 0 ]; then
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
+if [ ! -x "${openvpn}" ]
 then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
     exit 1
@@ -340,9 +341,9 @@ do
     pidfile="${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
     openvpn_conf="$openvpn_conf --writepid $pidfile $up"
     output " run openvpn $openvpn_conf"
-    echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
+    echo "# ${openvpn} $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
     umask 022
-    $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
+    $RUN_SUDO "${openvpn}" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
     sudopid=$!
 
     # Check if OpenVPN has initialized before continuing.  It will check every 3rd second up
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
index 752251e4..4a8643ae 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -22,6 +22,7 @@ set -e
 srcdir="${srcdir:-.}"
 top_srcdir="${top_srcdir:-..}"
 top_builddir="${top_builddir:-..}"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=
@@ -55,8 +56,8 @@ success=0
 for i in 1 2 3 ; do
   set +e
   (
-  "${top_builddir}/src/openvpn/openvpn" --script-security 2 --cd "${root}" ${addopts} --setenv role srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-server" &
-  "${top_builddir}/src/openvpn/openvpn" --script-security 2 --cd "${top_srcdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-client"
+  "${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-server" &
+  "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-client"
   ) 3>log.$$.signal >log.$$ 2>&1
   e1=$?
   wait $!
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 5aabbd5e..482016a9 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -21,6 +21,7 @@
 
 set -eu
 top_builddir="${top_builddir:-..}"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1" 0 3
 
@@ -71,7 +72,7 @@ fi
 
 
 # Get list of supported ciphers from openvpn --show-ciphers output
-CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
+CIPHERS=$(${openvpn} --show-ciphers | \
             sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*$/d')
 
 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
@@ -90,23 +91,23 @@ fi
 # Also test cipher 'none'
 CIPHERS=${CIPHERS}$(printf "\nnone")
 
-"${top_builddir}/src/openvpn/openvpn" --genkey secret key.$$
+"${openvpn}" --genkey secret key.$$
 set +e
 
 for cipher in ${CIPHERS}
 do
     test_start "Testing cipher ${cipher}... "
-    ( "${top_builddir}/src/openvpn/openvpn" --test-crypto --secret key.$$ --cipher ${cipher} ) >log.$$ 2>&1
+    ( "${openvpn}" --test-crypto --secret key.$$ --cipher ${cipher} ) >log.$$ 2>&1
     test_end $? log.$$
 done
 
 test_start "Testing tls-crypt-v2 server key generation... "
-"${top_builddir}/src/openvpn/openvpn" \
+"${openvpn}" \
     --genkey tls-crypt-v2-server tc-server-key.$$ >log.$$ 2>&1
 test_end $? log.$$
 
 test_start "Testing tls-crypt-v2 key generation (no metadata)... "
-"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+"${openvpn}" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ >log.$$ 2>&1
 test_end $? log.$$
 
@@ -118,7 +119,7 @@ while [ $i -lt 732 ]; do
     i=$(expr $i + 1)
 done
 test_start "Testing tls-crypt-v2 key generation (max length metadata)... "
-"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+"${openvpn}" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ "${METADATA}" \
     >log.$$ 2>&1
 test_end $? log.$$
diff --git a/tests/t_net.sh b/tests/t_net.sh
index bc91f825..8134832c 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -7,7 +7,7 @@ LAST_TEST=8
 
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
-openvpn="${top_builddir}/src/openvpn/openvpn"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 
 
 # bail out right away on non-linux. NetLink (the object of this test) is only
-- 
2.34.1


