From: Gert Doering <gert@...1296...>
Date: Sun, 24 Nov 2013 17:13:04 +0100
Message-Id: <1385309584-23209-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Remove fields from "ip -6 route show"
	output that distort results.
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

"ip -6 route show" prints stuff like "rtt 38ms rttvar 38ms cwnd 10", which
sometimes changes while an OpenVPN test is running, resulting in spurious
failures in the "ifconfig/route must be restored identically after
OpenVPN ends" test.  Not all fields are there all the time, so use "sed"
to get rid of whatever is printed this time.

Only relevant to linux builds with "--enable-iproute2".

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 9b83e14..6c9de6c 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -103,7 +103,7 @@ get_ifconfig_route()
 	echo "-- linux iproute2 --"
 	@IPROUTE@ addr show     | grep -v valid_lft
 	@IPROUTE@ route show
-	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -e 's/expires [0-9]*sec//'
+	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
 	return
     fi
 
-- 
1.8.1.5


