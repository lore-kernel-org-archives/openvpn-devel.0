From: openvpn-devel@...2127...
Date: Sat, 21 May 2016 11:22:04 +0200
Message-Id: <1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
In-Reply-To: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
Subject: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Jens Neuhalfen <jens@...2127...>

Move global code into seperate functions. Fixup formatting of code.

Signed-off-by: Jens Neuhalfen <jens@...2127...>
---
 tests/t_client.sh.in | 433 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 255 insertions(+), 178 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 9a0af93..9f0c8f6 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -12,6 +12,12 @@
 # - for "ping6" checks: fping6 binary in $PATH
 #
 
+#
+# Tests are configured via t_client.rc in this direcotry or the top
+# level source directroy.
+#
+
+
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 if [ -r "${top_builddir}"/t_client.rc ] ; then
@@ -85,7 +91,18 @@ else
     exit 1
 fi
 
-exit_code=0
+# ----------------------------------------------------------
+# global variables
+# ----------------------------------------------------------
+
+# list of succeeded tests (e.g. 1 2 3)
+declare  SUMMARY_OK=""
+
+# list of failed tests
+declare  SUMMARY_FAIL=""
+
+# number of failed checks for a test (# of calls to fail())
+declare -i fail_count=0
 
 # ----------------------------------------------------------
 # helper functions
@@ -105,46 +122,46 @@ get_ifconfig_route()
     # linux / iproute2? (-> if configure got a path)
     if [ -n "@IPROUTE@" ]
     then
-	echo "-- linux iproute2 --"
-	@IPROUTE@ addr show     | grep -v valid_lft
-	@IPROUTE@ route show
-	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
-	return
+        echo "-- linux iproute2 --"
+        @IPROUTE@ addr show     | grep -v valid_lft
+        @IPROUTE@ route show
+        @IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
+        return
     fi
 
     # try uname
     case `uname -s` in
-	Linux)
-	   echo "-- linux / ifconfig --"
-	   LANG=C @IFCONFIG@ -a |egrep  "( addr:|encap:)"
-	   LANG=C @NETSTAT@ -rn -4 -6
-	   return
-	   ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   return
-	   ;;
-	OpenBSD)
-	   echo "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)" | \
-		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   return
-	   ;;
-	SunOS)
-	   echo "-- Solaris --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   return
-	   ;;
-	AIX)
-	   echo "-- AIX --"
-	   @IFCONFIG@ -a | egrep "(flags=|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   return
-	   ;;
+    Linux)
+       echo "-- linux / ifconfig --"
+       LANG=C @IFCONFIG@ -a |egrep  "( addr:|encap:)"
+       LANG=C @NETSTAT@ -rn -4 -6
+       return
+       ;;
+    FreeBSD|NetBSD|Darwin)
+       echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+       @IFCONFIG@ -a | egrep "(flags=|inet)"
+       @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+       return
+       ;;
+    OpenBSD)
+       echo "-- OpenBSD --"
+       @IFCONFIG@ -a | egrep "(flags=|inet)" | \
+        sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
+       @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+       return
+       ;;
+    SunOS)
+       echo "-- Solaris --"
+       @IFCONFIG@ -a | egrep "(flags=|inet)"
+       @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+       return
+       ;;
+    AIX)
+       echo "-- AIX --"
+       @IFCONFIG@ -a | egrep "(flags=|inet)"
+       @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+       return
+       ;;
     esac
 
     echo "get_ifconfig_route(): no idea how to get info on your OS.  FAIL." >&2
@@ -164,11 +181,11 @@ check_ifconfig()
 
     for expect in $expect_list
     do
-	if get_ifconfig_route | fgrep "$expect" >/dev/null
-	then :
-	else
-	    fail "check_ifconfig(): expected IPv$proto address '$expect' not found in ifconfig output."
-	fi
+        if get_ifconfig_route | fgrep "$expect" >/dev/null
+        then :
+        else
+            fail "check_ifconfig(): expected IPv$proto address '$expect' not found in ifconfig output."
+        fi
     done
 }
 
@@ -186,166 +203,226 @@ run_ping_tests()
     if [ -z "$targetlist" ] ; then return ; fi
 
     case $proto in
-	4) cmd=fping ;;
-	6) cmd=fping6 ;;
-	*) echo "internal error in run_ping_tests arg 1: '$proto'" >&2
-	   exit 1 ;;
+        4) cmd=fping ;;
+        6) cmd=fping6 ;;
+        *) echo "internal error in run_ping_tests arg 1: '$proto'" >&2
+           exit 1 ;;
     esac
 
     case $want in
-	want_ok)   sizes_list="64 1440 3000" ;;
-	want_fail) sizes_list="64" ;;
+        want_ok)   sizes_list="64 1440 3000" ;;
+        want_fail) sizes_list="64" ;;
     esac
 
     for bytes in $sizes_list
     do
-	echo "run IPv$proto ping tests ($want), $bytes byte packets..."
-
-	echo "$cmd -b $bytes -C 20 -p 250 -q $targetlist" >>$LOGDIR/$SUF:fping.out
-	$cmd -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
-
-	# while OpenVPN is running, pings must succeed (want='want_ok')
-	# before OpenVPN is up, pings must NOT succeed (want='want_fail')
-
-	rc=$?
-	if [ $rc = 0 ] 				# all ping OK
-	then
-	    if [ $want = "want_fail" ]		# not what we want
-	    then
-		fail "IPv$proto ping test succeeded, but needs to *fail*."
-	    fi
-	else					# ping failed
-	    if [ $want = "want_ok" ]		# not what we wanted
-	    then
-		fail "IPv$proto ping test ($bytes bytes) failed, but should succeed."
-	    fi
-	fi
+        echo "run IPv$proto ping tests ($want), $bytes byte packets..."
+
+        echo "$cmd -b $bytes -C 20 -p 250 -q $targetlist" >>$LOGDIR/$SUF:fping.out
+        $cmd -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
+
+        # while OpenVPN is running, pings must succeed (want='want_ok')
+        # before OpenVPN is up, pings must NOT succeed (want='want_fail')
+
+        rc=$?
+        if [ $rc = 0 ]                 # all ping OK
+        then
+            if [ $want = "want_fail" ]        # not what we want
+            then
+            fail "IPv$proto ping test succeeded, but needs to *fail*."
+            fi
+        else                    # ping failed
+            if [ $want = "want_ok" ]        # not what we wanted
+            then
+            fail "IPv$proto ping test ($bytes bytes) failed, but should succeed."
+            fi
+        fi
     done
 }
 
+#
 # ----------------------------------------------------------
-# main test loop
+# run single test
 # ----------------------------------------------------------
-SUMMARY_OK=
-SUMMARY_FAIL=
-
-for SUF in $TEST_RUN_LIST
-do
-    # get config variables
-    eval test_prep=\"\$PREPARE_$SUF\"
-    eval test_cleanup=\"\$CLEANUP_$SUF\"
-    eval test_run_title=\"\$RUN_TITLE_$SUF\"
-    eval openvpn_conf=\"\$OPENVPN_CONF_$SUF\"
-    eval expect_ifconfig4=\"\$EXPECT_IFCONFIG4_$SUF\"
-    eval expect_ifconfig6=\"\$EXPECT_IFCONFIG6_$SUF\"
-    eval ping4_hosts=\"\$PING4_HOSTS_$SUF\"
-    eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
-
-    echo -e "\n### test run $SUF: '$test_run_title' ###\n"
-    fail_count=0
-
-    if [ -n "$test_prep" ]; then
-        echo -e "running preparation: '$test_prep'"
-        eval $test_prep
-    fi
-
-    echo "save pre-openvpn ifconfig + route"
-    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
-
-    echo -e "\nrun pre-openvpn ping tests - targets must not be reachable..."
-    run_ping_tests 4 want_fail "$ping4_hosts"
-    run_ping_tests 6 want_fail "$ping6_hosts"
-    if [ "$fail_count" = 0 ] ; then
-        echo -e "OK.\n"
-    else
-	echo -e "FAIL: make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF".
-	exit_code=31
-	continue
-    fi
-
-    echo " run openvpn $openvpn_conf"
-    echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
-    $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
-    opid=$!
 
-    # make sure openvpn client is terminated in case shell exits
-    trap "$RUN_SUDO kill $opid" 0
-    trap "$RUN_SUDO kill $opid ; trap - 0 ; exit 1" 1 2 3 15
+run_test() {
+     # get config variables
+     test_prep="$1"
+     test_cleanup="$2"
+     test_run_title="$3"
+     openvpn_conf="$4"
+     expect_ifconfig4="$5"
+     expect_ifconfig6="$6"
+     ping4_hosts="$7"
+     ping6_hosts="$8"
+
+     fail_count=0
+
+     echo -e "\n### test run $SUF: '$test_run_title' ###\n"
+
+     if [ -n "$test_prep" ]; then
+         echo -e "running preparation: '$test_prep'"
+         eval $test_prep
+     fi
+
+     echo "save pre-openvpn ifconfig + route"
+     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
+
+     echo -e "\nrun pre-openvpn ping tests - targets must not be reachable..."
+     run_ping_tests 4 want_fail "$ping4_hosts"
+     run_ping_tests 6 want_fail "$ping6_hosts"
+
+     if [ "$fail_count" = 0 ] ; then
+         echo -e "OK.\n"
+     else
+         echo -e "FAIL: make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF".
+         return 31
+     fi
+
+     echo " run openvpn $openvpn_conf"
+     echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
+     $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
+     opid=$!
+
+     # make sure openvpn client is terminated in case shell exits
+     trap "$RUN_SUDO kill $opid" 0
+     trap "$RUN_SUDO kill $opid ; trap - 0 ; exit 1" 1 2 3 15
+
+     echo "wait for connection to establish..."
+     sleep ${SETUP_TIME_WAIT:-10}
+
+     # test whether OpenVPN process is still there
+     if $RUN_SUDO kill -0 $opid
+     then :
+     else
+         echo -e "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log).  FAIL.\ntail of logfile follows:\n..." >&2
+         tail $LOGDIR/$SUF:openvpn.log >&2
+         trap - 0 1 2 3 15
+         return 10
+     fi
+
+     # compare whether anything changed in ifconfig/route setup?
+     echo "save ifconfig+route"
+     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
+
+     echo -n "compare pre-openvpn ifconfig+route with current values..."
+     if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+         $LOGDIR/$SUF:ifconfig_route.txt >/dev/null
+     then
+         fail "no differences between ifconfig/route before OpenVPN start and now."
+     else
+         echo -e " OK!\n"
+     fi
+
+     # expected ifconfig values in there?
+     check_ifconfig 4 "$expect_ifconfig4"
+     check_ifconfig 6 "$expect_ifconfig6"
+
+     run_ping_tests 4 want_ok "$ping4_hosts"
+     run_ping_tests 6 want_ok "$ping6_hosts"
+     echo -e "ping tests done.\n"
+
+     echo "stopping OpenVPN"
+     $RUN_SUDO kill $opid
+     wait $!
+     rc=$?
+     if [ $rc != 0 ] ; then
+         fail "OpenVPN return code $rc, expect 0"
+     fi
+
+     echo -e "\nsave post-openvpn ifconfig + route..."
+     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post.txt
+
+     echo -n "compare pre- and post-openvpn ifconfig + route..."
+     if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+         $LOGDIR/$SUF:ifconfig_route_post.txt >$LOGDIR/$SUF:ifconfig_route_diff.txt
+     then
+         echo -e " OK.\n"
+     else
+         cat $LOGDIR/$SUF:ifconfig_route_diff.txt >&2
+         fail "differences between pre- and post-ifconfig/route"
+     fi
+
+     if [ "$fail_count" = 0 ] ; then
+         echo -e "test run $SUF: all tests OK.\n"
+     else
+         echo -e "test run $SUF: $fail_count test failures. FAIL.\n";
+     fi
+
+     if [ -n "$test_cleanup" ]; then
+         echo -e "cleaning up: '$test_cleanup'"
+         eval $test_cleanup
+     fi
+     return $fail_count
+}
 
-    echo "wait for connection to establish..."
-    sleep ${SETUP_TIME_WAIT:-10}
 
-    # test whether OpenVPN process is still there
-    if $RUN_SUDO kill -0 $opid
-    then :
-    else
-	echo -e "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log).  FAIL.\ntail of logfile follows:\n..." >&2
-	tail $LOGDIR/$SUF:openvpn.log >&2
-	trap - 0 1 2 3 15
-	exit 10
-    fi
+print_test_results(){
+    # see here for an explanation on the calling convention:
+    #   http://stackoverflow.com/questions/1063347/passing-arrays-as-parameters-in-bash
+    local -a test_ids=("${!1}")
+    local -a test_number_of_fails=("${!2}")
 
-    # compare whether anything changed in ifconfig/route setup?
-    echo "save ifconfig+route"
-    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
+    local summary_ok=""
+    local summary_fail=""
 
-    echo -n "compare pre-openvpn ifconfig+route with current values..."
-    if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
-	    $LOGDIR/$SUF:ifconfig_route.txt >/dev/null
-    then
-	fail "no differences between ifconfig/route before OpenVPN start and now."
-    else
-	echo -e " OK!\n"
-    fi
-
-    # expected ifconfig values in there?
-    check_ifconfig 4 "$expect_ifconfig4"
-    check_ifconfig 6 "$expect_ifconfig6"
+    for (( i = 0 ; i < ${#test_ids[@]} ; i++ )) do
+        if [ ${test_number_of_fails[$i]} == 0 ]; then
+            summary_ok="$summary_ok ${test_ids[$i]}"
+        else
+            summary_fail="$summary_fail ${test_ids[$i]}"
+        fi
+    done
 
-    run_ping_tests 4 want_ok "$ping4_hosts"
-    run_ping_tests 6 want_ok "$ping6_hosts"
-    echo -e "ping tests done.\n"
+    if [ -z "$summary_ok" ] ; then summary_ok=" none"; fi
+    if [ -z "$summary_fail" ] ; then summary_fail=" none"; fi
+    echo "Test sets succeded:$summary_ok."
+    echo "Test sets failed:$summary_fail."
 
-    echo "stopping OpenVPN"
-    $RUN_SUDO kill $opid
-    wait $!
-    rc=$?
-    if [ $rc != 0 ] ; then
-	fail "OpenVPN return code $rc, expect 0"
-    fi
+}
+# ----------------------------------------------------------
+# main test loop
+# ----------------------------------------------------------
+run_test_loop() {
+    local test_run_list="$1"
 
-    echo -e "\nsave post-openvpn ifconfig + route..."
-    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post.txt
+    local -i any_test_failed=0
+    local -i number_of_fails_in_test=0
+    local -a test_ids
+    local -a test_number_of_fails
+    local -i current_test_index=0
 
-    echo -n "compare pre- and post-openvpn ifconfig + route..."
-    if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
-	    $LOGDIR/$SUF:ifconfig_route_post.txt >$LOGDIR/$SUF:ifconfig_route_diff.txt
-    then
-	echo -e " OK.\n"
-    else
-	cat $LOGDIR/$SUF:ifconfig_route_diff.txt >&2
-	fail "differences between pre- and post-ifconfig/route"
-    fi
-    if [ "$fail_count" = 0 ] ; then
-        echo -e "test run $SUF: all tests OK.\n"
-	SUMMARY_OK="$SUMMARY_OK $SUF"
-    else
-	echo -e "test run $SUF: $fail_count test failures. FAIL.\n";
-	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
-	exit_code=30
-    fi
+    for SUF in $test_run_list
+    do
+        # get config variables from the sourced t_client.rc
+        eval test_prep=\"\$PREPARE_$SUF\"
+        eval test_cleanup=\"\$CLEANUP_$SUF\"
+        eval test_run_title=\"\$RUN_TITLE_$SUF\"
+        eval openvpn_conf=\"\$OPENVPN_CONF_$SUF\"
+        eval expect_ifconfig4=\"\$EXPECT_IFCONFIG4_$SUF\"
+        eval expect_ifconfig6=\"\$EXPECT_IFCONFIG6_$SUF\"
+        eval ping4_hosts=\"\$PING4_HOSTS_$SUF\"
+        eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
+
+        test_ids[$current_test_index]="$SUF"
+
+        run_test "$test_prep" "$test_cleanup" "$test_run_title" "$openvpn_conf" "$expect_ifconfig4" "$expect_ifconfig6" "$ping4_hosts" "$ping6_hosts"
+        number_of_fails_in_test=$?
+        test_results[$current_test_index]=$number_of_fails_in_test
+
+        if [ $number_of_fails_in_test != 0 ]; then
+            any_test_failed=1
+        fi
+        current_test_index=$((current_test_index + 1))
+    done
 
-    if [ -n "$test_cleanup" ]; then
-        echo -e "cleaning up: '$test_cleanup'"
-        eval $test_cleanup
-    fi
+    print_test_results test_ids[@] test_results[@]
 
-done
+    return $any_test_failed
+}
 
-if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=" none"; fi
-if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=" none"; fi
-echo "Test sets succeded:$SUMMARY_OK."
-echo "Test sets failed:$SUMMARY_FAIL."
+run_test_loop "$TEST_RUN_LIST"
+exit_code=$?
 
 # remove trap handler
 trap - 0 1 2 3 15
-- 
2.8.2


