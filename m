From: Gert Doering <gert@...1296...>
Date: Sat, 17 Sep 2022 13:41:58 +0200
Message-Id: <20220917114158.20687-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] introduce V= level to manage t_client.sh
 output verbosity
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

If t_client.sh is run interactively, more verbose output is useful
to quickly see what it is doing.  If run from a CI environment, going
through lots of output for successful tests just to find the one that
failed is non-useful.

Introduce V=<n> environment variable to control output verbosity

 V=0 - do not print any per-test output at all, just overall summary
 V=1 - print single header line for each successful test
       print full output for failing tests
 V=99 - print full output, always, as before

default is V=1 now

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in | 89 +++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 30 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 76ac9b22..4c217645 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -121,17 +121,43 @@ else
     exit 1
 fi
 
+# verbosity, defaults to "1"
+V="${V:-1}"
+
 exit_code=0
 
 # ----------------------------------------------------------
 # helper functions
 # ----------------------------------------------------------
 
+# output progress information
+#  depending on verbosity level, collect & print only on failure
+output_start()
+{
+    outbuf="\n";
+    case $V in
+	0) outbuf="" ;;			# no per-test output at all
+	1) echo -e "$@" ;;		# compact, details only on failure
+	*) echo -e "\n$@\n" ;;		# print all, with a bit formatting
+    esac
+}
+
+output()
+{
+    NO_NL=''; if [ "X$1" = "-n" ] ; then NO_NL=$1 ; shift ; fi
+    case $V in
+	0) ;;				# no per-test output at all
+	1) outbuf="$outbuf\n$@" 	# print details only on failure
+	   test -z "$NO_NL" && outbuf="$outbuf\n"
+           ;;
+	*) echo -e $NO_NL "$@" ;;	# print everything
+    esac
+}
+
 # print failure message, increase FAIL counter
 fail()
 {
-    echo ""
-    echo "FAIL: $@" >&2
+    output "\nFAIL: $@"
     fail_count=$(( $fail_count + 1 ))
 }
 
@@ -236,7 +262,7 @@ run_ping_tests()
 
     for bytes in $sizes_list
     do
-	echo "run IPv$proto ping tests ($want), $bytes byte packets..."
+	output "run IPv$proto ping tests ($want), $bytes byte packets..."
 
 	echo "$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist" >>$LOGDIR/$SUF:fping.out
 	$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
@@ -287,32 +313,32 @@ do
         up=""
     fi
 
-    echo -e "\n### test run $SUF: '$test_run_title' ###\n"
+    output_start "### test run $SUF: '$test_run_title' ###"
     fail_count=0
 
     if [ -n "$test_prep" ]; then
-        echo -e "running preparation: '$test_prep'"
+        output "running preparation: '$test_prep'"
         eval $test_prep
     fi
 
-    echo "save pre-openvpn ifconfig + route"
+    output "save pre-openvpn ifconfig + route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
 
-    echo -e "\nrun pre-openvpn ping tests - targets must not be reachable..."
+    output "\nrun pre-openvpn ping tests - targets must not be reachable..."
     run_ping_tests 4 want_fail "$ping4_hosts"
     run_ping_tests 6 want_fail "$ping6_hosts"
     if [ "$fail_count" = 0 ] ; then
-        echo -e "OK.\n"
+        output "OK.\n"
     else
-	echo -e "FAIL: make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF".
+	fail "make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF."
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=31
-	continue
+	echo -e "$outbuf" ; continue
     fi
 
     pidfile="${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
     openvpn_conf="$openvpn_conf --writepid $pidfile $up"
-    echo " run openvpn $openvpn_conf"
+    output " run openvpn $openvpn_conf"
     echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
     umask 022
     $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
@@ -335,25 +361,25 @@ do
 
     opid=`cat $pidfile`
     if [ -n "$opid" ]; then
-        echo "  OpenVPN running with PID $opid"
+        output "  OpenVPN running with PID $opid"
     else
-        echo "  Could not read OpenVPN PID file" >&2
+        output "  Could not read OpenVPN PID file"
     fi
 
     # If OpenVPN did not start
     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
-        echo "$0:  OpenVPN did not initialize in a reasonable time" >&2
+        output "$0:  OpenVPN did not initialize in a reasonable time"
         if [ -n "$opid" ]; then
            $RUN_SUDO $KILL_EXEC $opid
         fi
         $RUN_SUDO $KILL_EXEC $sudopid
-	echo "tail -5 $SUF:openvpn.log" >&2
-	tail -5 $LOGDIR/$SUF:openvpn.log >&2
-	echo -e "\nFAIL. skip rest of sub-tests for test run $SUF.\n" >&2
+	output "tail -5 $SUF:openvpn.log"
+	output "`tail -5 $LOGDIR/$SUF:openvpn.log`"
+	fail "skip rest of sub-tests for test run $SUF."
 	trap - 0 1 2 3 15
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=30
-	continue
+	echo -e "$outbuf" ; continue
     fi
 
     # make sure openvpn client is terminated in case shell exits
@@ -361,21 +387,21 @@ do
     trap "$RUN_SUDO $KILL_EXEC $opid ; trap - 0 ; exit 1" 1 2 3 15
 
     # compare whether anything changed in ifconfig/route setup?
-    echo "save ifconfig+route"
+    output "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
 
-    echo -n "compare pre-openvpn ifconfig+route with current values..."
+    output -n "compare pre-openvpn ifconfig+route with current values..."
     if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
 	    $LOGDIR/$SUF:ifconfig_route.txt >/dev/null
     then
 	fail "no differences between ifconfig/route before OpenVPN start and now."
     else
-	echo -e " OK!\n"
+	output " OK!\n"
     fi
 
     # post init script needed?
     if [ -n "$test_postinit" ]; then
-        echo -e "running post-init cmd: '$test_postinit'"
+        output "running post-init cmd: '$test_postinit'"
         eval $test_postinit
     fi
 
@@ -385,9 +411,9 @@ do
 
     run_ping_tests 4 want_ok "$ping4_hosts"
     run_ping_tests 6 want_ok "$ping6_hosts"
-    echo -e "ping tests done.\n"
+    output "ping tests done.\n"
 
-    echo "stopping OpenVPN"
+    output "stopping OpenVPN"
     $RUN_SUDO $KILL_EXEC $opid
     wait $!
     rc=$?
@@ -395,23 +421,26 @@ do
 	fail "OpenVPN return code $rc, expect 0"
     fi
 
-    echo -e "\nsave post-openvpn ifconfig + route..."
+    output "\nsave post-openvpn ifconfig + route..."
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post.txt
 
-    echo -n "compare pre- and post-openvpn ifconfig + route..."
+    output -n "compare pre- and post-openvpn ifconfig + route..."
     if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
 	    $LOGDIR/$SUF:ifconfig_route_post.txt >$LOGDIR/$SUF:ifconfig_route_diff.txt
     then
-	echo -e " OK.\n"
+	output " OK.\n"
     else
-	cat $LOGDIR/$SUF:ifconfig_route_diff.txt >&2
+	output `cat $LOGDIR/$SUF:ifconfig_route_diff.txt`
 	fail "differences between pre- and post-ifconfig/route"
     fi
     if [ "$fail_count" = 0 ] ; then
-        echo -e "test run $SUF: all tests OK.\n"
+        output "test run $SUF: all tests OK.\n"
 	SUMMARY_OK="$SUMMARY_OK $SUF"
     else
-	echo -e "test run $SUF: $fail_count test failures. FAIL.\n";
+	if [ "$V" -gt 0 ] ; then
+	    echo -e "$outbuf"
+	    echo "test run $SUF: $fail_count test failures. FAIL.\n"
+        fi
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=30
     fi
-- 
2.35.1


