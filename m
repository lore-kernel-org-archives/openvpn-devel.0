From: Gert Doering <gert@...1296...>
Date: Tue, 13 Sep 2016 22:04:58 +0200
Message-Id: <20160913200458.9906-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Do not abort t_client run if OpenVPN
	instance does not start.
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

Basically, an oversight - if one test instance does not start at all
(due to "tap driver not loaded") the whole script would exit, instead
of logging the failing instance and proceeding to the next test run.

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 9a0af93..62d6730 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -279,10 +279,14 @@ do
     if $RUN_SUDO kill -0 $opid
     then :
     else
-	echo -e "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log).  FAIL.\ntail of logfile follows:\n..." >&2
-	tail $LOGDIR/$SUF:openvpn.log >&2
+	fail "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log)."
+	echo "tail -5 $SUF:openvpn.log" >&2
+	tail -5 $LOGDIR/$SUF:openvpn.log >&2
+	echo -e "\nFAIL. skip rest of sub-tests for test run $SUF.\n" >&2
 	trap - 0 1 2 3 15
-	exit 10
+	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+	exit_code=30
+	continue
     fi
 
     # compare whether anything changed in ifconfig/route setup?
-- 
2.9.0


