Date: Sun, 8 Aug 2010 21:48:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100808194847.GN740@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] RFD: VPN client test framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

as discussed in one of the previous the IRC meetings, I've been working
on a test framework to enable full "fire up openvpn client, establish
VPN connection, run ping tests, clean up, verify cleanup" automated 
tests.

The framework is appended below (as patch, should apply cleanly against
all branches in git) and has been checked & pushed into my feat_ipv6_payload
branch (dazo, feel free to pull & merge wherever you find this useful).

How does it work?

 - you run "sudo make check" (needs root access to configure tun if!)

 - t_client.sh reads t_client.rc from current dir or ${srcdir}

 - t_client.rc defines a number of "test suffixes" to run (could be
   "1" "2" "3" or "p2m", "p2p", "special" or whatever you like), and
   for each suffix, there's config variables to specify

    - how to call OpenVPN
    - which hosts to ping for IPv4 and IPv6 when OpenVPN is up
      (and actually before starting OpenVPN - to make the test more
      meaningful, I have decided that the test hosts must not ping
      before the tests starts)
    - which addresses must show up in the output of "ifconfig" after
      OpenVPN has started
    - all variables except OPENVPN_CONF_<x> are optional

   (this should all be fairly obvious from looking at t_client.rc-sample)

 - the script wants to connect to a well-defined OpenVPN server that
   will assign well-known IPv4 (and IPv6) addresses, have well-defined
   pingable addresse, etc. - so you need to setup the test server before
   the script is useful for you.  (Whether you use certificates or 
   username/password is up to you, you could even mix and match - run
   one test with certs, and one with user/pass against different target
   ports... :-) )

   [we *could* run a "reference server" somewhere and ship a sample
   t_client.rc + cert so that users could use this right away, but I 
   do not currently have the resources to run such a public server]


 - whatever the script does is logged to a newly created directory 
   below the current directory (openvpn output, ifconfig+route before
   starting OpenVPN, while running it, after ending it)

 - important: at least on NetBSD and OpenBSD, the script will print
   one failure, because the tun0 interface created is not destroyed
   after openvpn ends.  For OpenBSD, I have changed close_tun() to 
   do so ("ifconfig tun0 destroy"), for NetBSD I have not yet changed
   anything - but I strongly believe that the output of "ifconfig+route"
   should be reverted to exactly how it looked like before OpenVPN
   was started, so I consider this a bug in the NetBSD-specific bits
   of OpenVPN (and will look into this).

 - the test framework has been tested on Linux, NetBSD and OpenBSD.
   It *should* work fine on FreeBSD and Solaris.
   It works on MacOS X (but the output looks funny, because /bin/sh
   does not implement "echo -e" - need to add configure trickery)

   It will *not* work on Windows yet - I haven't looked into what's
   needed to make it work (background processes and signals in mingw 
   bash?), maybe it's as easy as adding the necessary "ipconfig" and 
   "netsh" commands to print interface + routing config...

 - I have only tested "connect via IPv4 transport, use IPv4+IPv6 payload",
   but the framework is generic enough that "connect via IPv6 transport"
   should work just fine (just setup OPENVPN_CONF_x accordingly in the 
   t_client.rc).

 - this is neither finished nor pretty, but it helps me a *lot* in
   quickly testing whether I broke anything when fiddling system-dependent
   code (tun.c, route.c) across multiple build hosts - so I hope this
   is going to be fairly useful to Samuli and the buildbot :-)

enjoy,

gert



From a75f441b83cf07de2180b67f057c9d41ea2a447d Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 8 Aug 2010 21:24:30 +0200
Subject: [PATCH] full "VPN client connect" test framework for OpenVPN
 run from "make check" if "t_client.rc" is found in workdir or srcdir
 (copy t_client.rc-sample, fill in specifics for your test server)

Signed-off-by: Gert Doering <gert@...1296...>
---
 Makefile.am        |    2 +-
 t_client.rc-sample |   83 +++++++++++++++
 t_client.sh        |  298 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+), 1 deletions(-)
 create mode 100644 t_client.rc-sample
 create mode 100755 t_client.sh

diff --git a/Makefile.am b/Makefile.am
index 7bccc11..73d9892 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -55,7 +55,7 @@ SUBDIRS = \
 	service-win32 \
 	install-win32
 
-TESTS = t_lpback.sh t_cltsrv.sh
+TESTS = t_client.sh t_lpback.sh t_cltsrv.sh
 sbin_PROGRAMS = openvpn
 
 dist_noinst_HEADERS = \
diff --git a/t_client.rc-sample b/t_client.rc-sample
new file mode 100644
index 0000000..ca59c68
--- /dev/null
+++ b/t_client.rc-sample
@@ -0,0 +1,83 @@
+#
+# this is sourced from t_client.sh and defines which openvpn client tests
+# to run
+#
+# (sample config, copy to t_client.rc and adapt to your environment)
+#
+#
+# define these - if empty, no tests will run
+#
+CA_CERT="/home/openvpn-test-ca/keys/ca.crt"
+CLIENT_KEY="/home/openvpn-test-ca/keys/client-test.key"
+CLIENT_CERT="/home/openvpn-test-ca/keys/client-test.crt"
+#
+# remote host (used as macro below)
+#
+REMOTE=mytestserver
+#
+# tests to run (list suffixes for config stanzas below)
+#
+TEST_RUN_LIST="1 2"
+
+#
+# base confic that is the same for all the p2mp test runs
+#
+OPENVPN_BASE_P2MP="--client --ca $CA_CERT \
+	--cert $CLIENT_CERT --key $CLIENT_KEY \
+	--ns-cert-type server --nobind --comp-lzo --verb 3"
+
+# base config for p2p tests
+#
+OPENVPN_BASE_P2P="..."
+
+#
+#
+# now define the individual tests - all variables suffixed with _1, _2 etc
+# will be used in test run "1", "2", etc.
+#
+# if something is not defined here, the corresponding test is not run
+#
+# possible test options:
+#
+# OPENVPN_CONF_x = "how to call ./openvpn" [mandatory]
+# EXPECT_IFCONFIG4_x = "this IPv4 address needs to show up in ifconfig"
+# EXPECT_IFCONFIG6_x = "this IPv6 address needs to show up in ifconfig"
+# PING4_HOSTS_x = "these hosts musts ping when openvpn is up (IPv4 fping)"
+# PING6_HOSTS_x = "these hosts musts ping when openvpn is up (IPv6 fping6)"
+#
+# Test 1: UDP / p2mp tun
+#   specify IPv4+IPv6 addresses expected from server and ping targets
+#
+OPENVPN_CONF_1="$OPENVPN_BASE_P2MP --dev tun --proto udp --remote $REMOTE --port 51194"
+EXPECT_IFCONFIG4_1="10.100.50.6"
+EXPECT_IFCONFIG6_1="2001:dba:a050::1:0"
+PING4_HOSTS_1="10.100.50.1 10.100.0.1"
+PING6_HOSTS_1="2001:dba::1 2001:dba:a050::1"
+
+# Test 2: TCP / p2mp tun
+#
+OPENVPN_CONF_2="$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOTE --port 51194"
+EXPECT_IFCONFIG4_2="10.100.51.6"
+EXPECT_IFCONFIG6_2="2001:dba:a051::1:0"
+PING4_HOSTS_2="10.100.51.1 10.100.0.1"
+PING6_HOSTS_1="2001:dba::1 2001:dba:a051::1"
+
+# Test 3: UDP / p2p tun
+# ...
+
+# Test 4: TCP / p2p tun
+# ...
+
+# Test 5: UDP / p2mp tap
+# ...
+
+# Test 6: TCP / p2mp tun
+# ...
+
+# Test 7: UDP / p2p tap
+# ...
+
+# Test 8: TCP / p2p tap
+# ...
+
+# Test 9: whatever you want to test... :-)
diff --git a/t_client.sh b/t_client.sh
new file mode 100755
index 0000000..3a0dadb
--- /dev/null
+++ b/t_client.sh
@@ -0,0 +1,298 @@
+#!/bin/sh
+#
+# run OpenVPN client against ``test reference'' server
+# - check that ping, http, ... via tunnel works
+# - check that interface config / routes are properly cleaned after test end
+#
+# prerequisites:
+# - openvpn binary in current directory
+# - writable current directory to create subdir for logs
+# - t_client.rc in current directory OR source dir that specifies tests
+# - for "ping4" checks: fping binary in $PATH
+# - for "ping6" checks: fping6 binary in $PATH
+#
+
+if [ ! -x ./openvpn ]
+then
+    echo "no (executable) openvpn binary in current directory. FAIL." >&2
+    exit 1
+fi
+
+if [ ! -w . ]
+then
+    echo "current directory is not writable (required for logging). FAIL." >&2
+    exit 1
+fi
+
+if [ -r ./t_client.rc ] ; then
+    . ./t_client.rc
+elif [ -r "${srcdir}"/t_client.rc ] ; then
+    . "${srcdir}"/t_client.rc
+else
+    echo "cannot find 't_client.rc' in current directory or" >&2
+    echo "source dir ('${srcdir}').  FAIL." >&2
+    exit 1
+fi
+
+if [ -z "$CA_CERT" ] ; then
+    echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
+    exit 0
+fi
+
+if [ -z "$TEST_RUN_LIST" ] ; then
+    echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
+    exit 0
+fi
+
+# make sure we have permissions to run ifconfig/route from OpenVPN
+# can't use "id -u" here - doesn't work on Solaris
+ID=`id`
+if expr "$ID" : "uid=0" >/dev/null
+then :
+else
+    echo "$0: this test must run be as root. SKIP." >&2
+    exit 0
+fi
+
+LOGDIR=t_client-`hostname`-`date +%Y%m%d-%H%M%S`
+if mkdir $LOGDIR
+then :
+else
+    echo "can't create log directory '$LOGDIR'. FAIL." >&2
+    exit 1
+fi
+
+exit_code=0
+
+# ----------------------------------------------------------
+# helper functions
+# ----------------------------------------------------------
+# print failure message, increase FAIL counter
+fail()
+{
+    echo ""
+    echo "FAIL: $@" >&2
+    fail_count=$(( $fail_count + 1 ))
+}
+
+# print "all interface IP addresses" + "all routes"
+# this is higly system dependent...
+get_ifconfig_route()
+{
+    # linux / iproute2?
+    if [ -x /sbin/ip -o -x /usr/sbin/ip ]
+    then
+	echo "-- linux iproute2 --"
+	ip addr show     | grep -v valid_lft
+	ip route show
+	ip -6 route show | sed -e 's/expires [0-9]*sec //'
+	return
+    fi
+
+    # try uname
+    case `uname -s` in
+	Linux)
+	   echo "-- linux / ifconfig --"
+	   LANG=C ifconfig -a |egrep  "( addr:|encap:)"
+	   LANG=C netstat -rn -4 -6
+	   return
+	   ;;
+	FreeBSD|NetBSD|Darwin)
+	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+	   ifconfig -a | egrep "(flags=|inet)"
+	   netstat -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+	   return
+	   ;;
+	OpenBSD)
+	   echo "-- OpenBSD --"
+	   ifconfig -a | egrep "(flags=|inet)" | \
+		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
+	   netstat -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+	   return
+	   ;;
+	SunOS)
+	   echo "-- Solaris --"
+	   ifconfig -a | egrep "(flags=|inet)"
+	   netstat -rn
+	   return
+	   ;;
+    esac
+
+    echo "get_ifconfig_route(): no idea how to get info on your OS.  FAIL." >&2
+    exit 20
+}
+
+# ----------------------------------------------------------
+# check ifconfig
+#  arg1: "4" or "6" -> for message
+#  arg2: IPv4/IPv6 address that must show up in out of "get_ifconfig_route"
+check_ifconfig()
+{
+    proto=$1 ; shift
+    expect_list="$@"
+
+    if [ -z "$expect_list" ] ; then return ; fi
+
+    for expect in $expect_list
+    do
+	if get_ifconfig_route | fgrep "$expect" >/dev/null
+	then :
+	else
+	    fail "check_ifconfig(): expected IPv$proto address '$expect' not found in ifconfig output."
+	fi
+    done
+}
+
+# ----------------------------------------------------------
+# run pings
+#  arg1: "4" or "6" -> fping/fing6
+#  arg2: "want_ok" or "want_fail" (expected ping result)
+#  arg3... -> fping arguments (host list)
+run_ping_tests()
+{
+    proto=$1 ; want=$2 ; shift ; shift
+    targetlist="$@"
+
+    # "no targets" is fine
+    if [ -z "$targetlist" ] ; then return ; fi
+
+    case $proto in
+	4) cmd=fping ;;
+	6) cmd=fping6 ;;
+	*) echo "internal error in run_ping_tests arg 1: '$proto'" >&2
+	   exit 1 ;;
+    esac
+
+    case $want in
+	want_ok)   sizes_list="64 1440 3000" ;;
+	want_fail) sizes_list="64" ;;
+    esac
+
+    for bytes in $sizes_list
+    do
+	echo "run IPv$proto ping tests ($want), $bytes byte packets..."
+
+	echo "$cmd -b $bytes -C 20 -p 250 -q $targetlist" >>$LOGDIR/$SUF:fping.out
+	$cmd -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
+
+	# while OpenVPN is running, pings must succeed (want='want_ok')
+	# before OpenVPN is up, pings must NOT succeed (want='want_fail')
+
+	rc=$?
+	if [ $rc = 0 ] 				# all ping OK
+	then
+	    if [ $want = "want_fail" ]		# not what we want
+	    then
+		fail "IPv$proto ping test succeeded, but needs to *fail*."
+	    fi
+	else					# ping failed
+	    if [ $want = "want_ok" ]		# not what we wanted
+	    then
+		fail "IPv$proto ping test ($bytes bytes) failed, but should succeed."
+	    fi
+	fi
+    done
+}
+
+# ----------------------------------------------------------
+# main test loop
+# ----------------------------------------------------------
+for SUF in $TEST_RUN_LIST
+do
+    echo -e "\n### test run $SUF ###\n"
+    fail_count=0
+
+    echo "save pre-openvpn ifconfig + route"
+    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
+
+    # get config variables
+    eval openvpn_conf=\"\$OPENVPN_CONF_$SUF\"
+    eval expect_ifconfig4=\"\$EXPECT_IFCONFIG4_$SUF\"
+    eval expect_ifconfig6=\"\$EXPECT_IFCONFIG6_$SUF\"
+    eval ping4_hosts=\"\$PING4_HOSTS_$SUF\"
+    eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
+
+    echo -e "\nrun pre-openvpn ping tests - targets must not be reachable..."
+    run_ping_tests 4 want_fail "$ping4_hosts"
+    run_ping_tests 6 want_fail "$ping6_hosts"
+    if [ "$fail_count" = 0 ] ; then
+        echo -e "OK.\n"
+    else
+	echo -e "FAIL: make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF".
+	exit_code=31
+	continue
+    fi
+
+    echo " run ./openvpn $openvpn_conf"
+    ./openvpn $openvpn_conf >$LOGDIR/$SUF:openvpn.log &
+    opid=$!
+
+    # make sure openvpn client is terminated in case shell exits
+    trap "kill $opid" 0
+    trap "kill $opid ; trap - 0 ; exit 1" 1 2 3 15
+
+    echo "wait for connection to establish..."
+    sleep 10
+
+    # test whether OpenVPN process is still there
+    if kill -0 $opid
+    then :
+    else
+	echo -e "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log).  FAIL.\ntail of logfile follows:\n..." >&2
+	tail $LOGDIR/$SUF:openvpn.log >&2
+	trap - 0 1 2 3 15
+	exit 10
+    fi
+
+    # compare whether anything changed in ifconfig/route setup?
+    echo "save ifconfig+route"
+    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
+
+    echo -n "compare pre-openvpn ifconfig+route with current values..."
+    if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+	    $LOGDIR/$SUF:ifconfig_route.txt >/dev/null
+    then
+	fail "no differences between ifconfig/route before OpenVPN start and now."
+    else
+	echo -e " OK!\n"
+    fi
+
+    # expected ifconfig values in there?
+    check_ifconfig 4 "$expect_ifconfig4"
+    check_ifconfig 6 "$expect_ifconfig6"
+
+    run_ping_tests 4 want_ok "$ping4_hosts"
+    run_ping_tests 6 want_ok "$ping6_hosts"
+    echo -e "ping tests done.\n"
+
+    echo "stopping OpenVPN"
+    kill $opid
+    wait $!
+    rc=$?
+    if [ $rc != 0 ] ; then
+	fail "OpenVPN return code $rc, expect 0"
+    fi
+
+    echo -e "\nsave post-openvpn ifconfig + route..."
+    get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post.txt
+
+    echo -n "compare pre- and post-openvpn ifconfig + route..."
+    if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+	    $LOGDIR/$SUF:ifconfig_route_post.txt >$LOGDIR/$SUF:ifconfig_route_diff.txt
+    then
+	echo -e " OK.\n"
+    else
+	cat $LOGDIR/$SUF:ifconfig_route_diff.txt >&2
+	fail "differences between pre- and post-ifconfig/route"
+    fi
+    if [ "$fail_count" = 0 ] ; then
+        echo -e "test run $SUF: all tests OK.\n"
+    else
+	echo -e "test run $SUF: $fail_count test failures. FAIL.\n";
+	exit_code=30
+    fi
+done
+
+# remove trap handler
+trap - 0 1 2 3 15
+exit $exit_code
-- 
1.6.4.4

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

