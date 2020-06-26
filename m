From: Gert Doering <gert@...1296...>
Date: Fri, 26 Jun 2020 10:27:43 +0200
Message-Id: <20200626082743.15397-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_client.sh: correctly report all failed
 instances in summary
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

t_client.sh reports a summary at the end:

  Test sets succeeded: none.
  Test sets failed: 1 2 3 4 5.

for tests that are skipped due to the pre-test ping check ("vpn target
IP must not ping before VPN ist started") the script forgot to add
the instance number to the summary line.  Fixed.

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 69866fb5..294546be 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -298,6 +298,7 @@ do
         echo -e "OK.\n"
     else
 	echo -e "FAIL: make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF".
+	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=31
 	continue
     fi
-- 
2.26.2


