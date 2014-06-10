From: Gert Doering <gert@...1296...>
Date: Tue, 10 Jun 2014 16:04:33 +0200
Message-Id: <1402409073-54067216-5-git-send-email-gert@...1296...>
In-Reply-To: <1402409073-54067216-4-git-send-email-gert@...1296...>
References: <1402409073-54067216-1-git-send-email-gert@...1296...>
	<1402409073-54067216-2-git-send-email-gert@...1296...>
	<1402409073-54067216-3-git-send-email-gert@...1296...>
	<1402409073-54067216-4-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 4/4] Make t_client.sh work on AIX.
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
Cc: Gert Doering <gd@...1505...>

From: Gert Doering <gd@...1505...>

Teach it how to run ifconfig/route on AIX to have meaningful results.

Signed-off-by: Gert Doering <gd@...1505...>
---
 tests/t_client.sh.in |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 52c5ed1..d4f7c4a 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -134,6 +134,12 @@ get_ifconfig_route()
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
 	   return
 	   ;;
+	AIX)
+	   echo "-- AIX --"
+	   @IFCONFIG@ -a | egrep "(flags=|inet)"
+	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+	   return
+	   ;;
     esac
 
     echo "get_ifconfig_route(): no idea how to get info on your OS.  FAIL." >&2
-- 
1.6.4


