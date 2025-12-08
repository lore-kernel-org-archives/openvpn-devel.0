From: Gert Doering <gert@...1296...>
Date: Mon,  8 Dec 2025 20:39:42 +0100
Message-ID: <20251208193950.16969-1-gert@...1296...>
In-Reply-To: <gerrit.1765215972000.Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9@...2715...>
References: <gerrit.1765215972000.Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tests: Allow to override openvpn binary
 used
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

From: Frank Lichtenheld <frank@...2641...>

This makes it easy to test an installed binary for
example.

Change-Id: Ida7a64a299cd5bf7ae4f0cc725756b5f5cc408f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20230511101253.369196-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26648.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1424
(cherry picked from commit d623aa6c29545a7f00daaa73d87818a9c5b1e942)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1424
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 03a0dbf..f6654dd 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -18,6 +18,7 @@
 
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 if [ -r "${top_builddir}"/t_client.rc ] ; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ] ; then
@@ -49,7 +50,7 @@
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
+if [ ! -x "${openvpn}" ]
 then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
     exit 1
@@ -352,9 +353,9 @@
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
index 752251e..4a8643a 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -22,6 +22,7 @@
 srcdir="${srcdir:-.}"
 top_srcdir="${top_srcdir:-..}"
 top_builddir="${top_builddir:-..}"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=
@@ -55,8 +56,8 @@
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
index 5aabbd5..482016a 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -21,6 +21,7 @@
 
 set -eu
 top_builddir="${top_builddir:-..}"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1" 0 3
 
@@ -71,7 +72,7 @@
 
 
 # Get list of supported ciphers from openvpn --show-ciphers output
-CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
+CIPHERS=$(${openvpn} --show-ciphers | \
             sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*$/d')
 
 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
@@ -90,23 +91,23 @@
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
 
@@ -118,7 +119,7 @@
     i=$(expr $i + 1)
 done
 test_start "Testing tls-crypt-v2 key generation (max length metadata)... "
-"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+"${openvpn}" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ "${METADATA}" \
     >log.$$ 2>&1
 test_end $? log.$$
diff --git a/tests/t_net.sh b/tests/t_net.sh
index bc91f82..8134832 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -7,7 +7,7 @@
 
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
-openvpn="${top_builddir}/src/openvpn/openvpn"
+openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 
 
 # bail out right away on non-linux. NetLink (the object of this test) is only

