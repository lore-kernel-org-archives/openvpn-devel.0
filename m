From: Gert Doering <gert@...1296...>
Date: Tue,  4 Oct 2022 10:25:32 +0200
Message-Id: <20221004082532.84741-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] denoise tests/t_lpback.sh
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

Introduce V=<nn> levels to t_lpback.sh self test

 V=0  - do not print any output at all
 V=1  - print intro line, summary at end, and "FAIL"+Log for failing tests
 V=99 - print everything + summary

code-wise, introduce test_start() / test_end() functions which do
the $? check as well, so the actual testing code is streamlined.

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_lpback.sh | 88 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 67952994..4cf29d26 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -24,6 +24,52 @@ top_builddir="${top_builddir:-..}"
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
 trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1" 0 3
 
+# verbosity, defaults to "1"
+V="${V:-1}"
+tests_passed=0
+tests_failed=0
+
+# ----------------------------------------------------------
+# helper functions
+# ----------------------------------------------------------
+
+# output progress information
+#  depending on verbosity level, collect & print only on failure
+test_start()
+{
+    case $V in
+	0) outbuf="" ;;			# no per-test output at all
+	1) outbuf="$@" ;;		# compact, details only on failure
+	*) printf "$@" ;;		# print all
+    esac
+}
+test_end()
+{
+    RC=$1 ; LOG=$2
+    if [ $RC != 0 ]
+    then
+	case $V in
+	    0) ;;				# no per-test output
+	    1) echo "$outbuf" "FAIL (RC=$RC)"; cat $LOG ;;
+	    *) echo "FAIL (RC=$RC)"; cat $LOG ;;
+	esac
+        e=1
+	tests_failed=$(( $tests_failed + 1 ))
+    else
+	case $V in
+	    0|1) ;;				# no per-test output for 'OK'
+	    *) echo "OK" ;;			# print all
+	esac
+	tests_passed=$(( $tests_passed + 1 ))
+    fi
+}
+
+# if running with V=1, give an indication what test runs now
+if [ "$V" == 1  ] ; then
+    echo "$0: running with V=$V, only printing test fails"
+fi
+
+
 # Get list of supported ciphers from openvpn --show-ciphers output
 CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
             sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*$/d')
@@ -49,38 +95,20 @@ set +e
 
 for cipher in ${CIPHERS}
 do
-    printf "Testing cipher ${cipher}... "
+    test_start "Testing cipher ${cipher}... "
     ( "${top_builddir}/src/openvpn/openvpn" --test-crypto --secret key.$$ --cipher ${cipher} ) >log.$$ 2>&1
-    if [ $? != 0 ] ; then
-        echo "FAILED"
-        cat log.$$
-        e=1
-    else
-        echo "OK"
-    fi
+    test_end $? log.$$
 done
 
-printf "Testing tls-crypt-v2 server key generation... "
+test_start "Testing tls-crypt-v2 server key generation... "
 "${top_builddir}/src/openvpn/openvpn" \
     --genkey tls-crypt-v2-server tc-server-key.$$ >log.$$ 2>&1
-if [ $? != 0 ] ; then
-    echo "FAILED"
-    cat log.$$
-    e=1
-else
-    echo "OK"
-fi
+test_end $? log.$$
 
-printf "Testing tls-crypt-v2 key generation (no metadata)... "
+test_start "Testing tls-crypt-v2 key generation (no metadata)... "
 "${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ >log.$$ 2>&1
-if [ $? != 0 ] ; then
-    echo "FAILED"
-    cat log.$$
-    e=1
-else
-    echo "OK"
-fi
+test_end $? log.$$
 
 # Generate max-length base64 metadata ('A' is 0b000000 in base64)
 METADATA=""
@@ -89,16 +117,14 @@ while [ $i -lt 732 ]; do
     METADATA="${METADATA}A"
     i=$(expr $i + 1)
 done
-printf "Testing tls-crypt-v2 key generation (max length metadata)... "
+test_start "Testing tls-crypt-v2 key generation (max length metadata)... "
 "${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ "${METADATA}" \
     >log.$$ 2>&1
-if [ $? != 0 ] ; then
-    echo "FAILED"
-    cat log.$$
-    e=1
-else
-    echo "OK"
+test_end $? log.$$
+
+if [ "$V" -ge 1  ] ; then
+    echo "$0: tests passed: $tests_passed  failed: $tests_failed"
 fi
 
 rm key.$$ tc-server-key.$$ tc-client-key.$$ log.$$
-- 
2.37.3


