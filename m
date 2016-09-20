From: Gert Doering <gert@...1296...>
Date: Tue, 20 Sep 2016 11:19:14 +0200
Message-Id: <20160920091914.37585-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix t_client runs on OpenSolaris
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

"grep -q" is not portable to non-GNU grep.  Replace with ">/dev/null".

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index bde07a6..2b9bacf 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -308,7 +308,7 @@ do
     while [ $ovpn_init_check -gt 0 ];
     do
        sleep 3  # Wait for OpenVPN to initialize and have had time to write the pid file
-       grep -q "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log
+       grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
        if [ $? -eq 0 ]; then
            ovpn_init_check=0
            ovpn_init_success=1
-- 
1.5.6.5


