From: Gert Doering <gert@...1296...>
Date: Mon, 26 Sep 2022 10:11:58 +0200
Message-Id: <20220926081158.40640-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_client: add per-instance arguments to
 fping
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

In addition to global FPING_EXTRA_ARGS now also evaluate
FPING_ARGGS_<suffix>.

This can be used, for example, for a test instance for "will ToS-tagged
packets be sent properly?" by setting FPING_ARGS_2="-O 0x10".

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 76ac9b22..48ba6e68 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -238,8 +238,8 @@ run_ping_tests()
     do
 	echo "run IPv$proto ping tests ($want), $bytes byte packets..."
 
-	echo "$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist" >>$LOGDIR/$SUF:fping.out
-	$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
+	echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping.out
+	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
 
 	# while OpenVPN is running, pings must succeed (want='want_ok')
 	# before OpenVPN is up, pings must NOT succeed (want='want_fail')
@@ -278,6 +278,7 @@ do
     eval expect_ifconfig6=\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
+    eval fping_args=\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
     # script to generate them dynamically.
-- 
2.37.2


