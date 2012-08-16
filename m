From: Gert Doering <gert@...1296...>
Date: Thu, 16 Aug 2012 20:31:22 +0200
Message-Id: <1345141883-9889-2-git-send-email-gert@...1296...>
In-Reply-To: <1345141883-9889-1-git-send-email-gert@...1296...>
References: <1345141883-9889-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 1/2] Put actual OpenVPN command line on top
	of corresponding log file.
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

This is useful if a test fails, and the tester wants to run the very
same OpenVPN call with the very same arguments interactively to
pinpoint and fix the problem.

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 8c66033..189eecc 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -234,7 +234,8 @@ do
     fi
 
     echo " run openvpn $openvpn_conf"
-    $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >$LOGDIR/$SUF:openvpn.log &
+    echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
+    $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
     opid=$!
 
     # make sure openvpn client is terminated in case shell exits
-- 
1.7.3.5


