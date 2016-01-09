From: ValdikSS <iam@...2070...>
Date: Sat,  9 Jan 2016 18:53:45 +0300
Message-Id: <1452354825-5096-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH] Clarify mssfix documentation
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

---
 doc/openvpn.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 9760e8b..ef77b29 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1381,7 +1381,11 @@ parameter is interpreted in the same way as the
 .B \-\-link\-mtu
 parameter, i.e. the UDP packet size after encapsulation
 overhead has been added in, but not including
-the UDP header itself.
+the UDP header itself. Resulting packet would be at most 28
+bytes larger for IPv4 and 48 bytes for IPv6 (20/40 bytes for IP
+header and 8 bytes for UDP header). Default value of 1450 allows
+IPv4 packets to be transmitted over a link with MTU 1473 or higher
+without IP level fragmentation.
 
 The
 .B \-\-mssfix
-- 
2.7.0


