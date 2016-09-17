From: David Sommerseth <davids@...515...>
Date: Sat, 17 Sep 2016 12:20:26 +0300
Message-Id: <1474104026-20615-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] t_client.sh: Make OpenVPN write PID file to
	avoid various sudo issues
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

This resolves an issue where $! returns the PID of the sudo process instead
of the PID of OpenVPN and when sudo does not properly propagate signales
down to OpenVPN.

Trac: #738
Signed-off-by: David Sommerseth <davids@...515...>
---
 tests/t_client.sh.in | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 62d6730..fc82cdb 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -263,10 +263,14 @@ do
 	continue
     fi
 
+    pidfile="${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
+    openvpn_conf="$openvpn_conf --writepid $pidfile"
     echo " run openvpn $openvpn_conf"
     echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
     $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
-    opid=$!
+    sleep 3  # Wait for OpenVPN to initialize and have had time to write the pid file
+    opid=`cat $pidfile`
+    echo "  OpenVPN running with PID $opid"
 
     # make sure openvpn client is terminated in case shell exits
     trap "$RUN_SUDO kill $opid" 0
-- 
1.8.3.1


