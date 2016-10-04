From: Gert Doering <gert@...1296...>
Date: Tue,  4 Oct 2016 13:38:54 +0200
Message-Id: <20161004113854.42470-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] add POSTINIT_CMD_suf to t_client.sh and
	sample config
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

We have pre-init and cleanup commands, but some test cases might need
or want to run a shell script after openvpn has initialized, but before
executing any tests (ifconfig comparison and ping).

Example: POSTINIT_CMD_4="sleep 5" on MacOS X for tap tests (IPv6 DAD)

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.rc-sample | 3 +++
 tests/t_client.sh.in     | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index fb2abfa..59f34c7 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -75,6 +75,9 @@ RUN_TITLE_2="testing tun/tcp/ipv4+ipv6"
 OPENVPN_CONF_2="$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOTE --port 51194"
 PING4_HOSTS_2="10.100.51.1 10.100.0.1"
 PING6_HOSTS_2="2001:db8::1 2001:db8:a051::1"
+#
+# run command after openvpn initialization is done - here: delay 5 seconds
+POSTINIT_CMD_2="sleep 5"
 
 # Test 3: UDP / p2p tun
 # ...
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index b2428b9..6c81bc4 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -263,6 +263,7 @@ for SUF in $TEST_RUN_LIST
 do
     # get config variables
     eval test_prep=\"\$PREPARE_$SUF\"
+    eval test_postinit=\"\$POSTINIT_CMD_$SUF\"
     eval test_cleanup=\"\$CLEANUP_$SUF\"
     eval test_run_title=\"\$RUN_TITLE_$SUF\"
     eval openvpn_conf=\"\$OPENVPN_CONF_$SUF\"
@@ -362,6 +363,12 @@ do
 	echo -e " OK!\n"
     fi
 
+    # post init script needed?
+    if [ -n "$test_postinit" ]; then
+        echo -e "running post-init cmd: '$test_postinit'"
+        eval $test_postinit
+    fi
+
     # expected ifconfig values in there?
     check_ifconfig 4 "$expect_ifconfig4"
     check_ifconfig 6 "$expect_ifconfig6"
-- 
2.9.0


