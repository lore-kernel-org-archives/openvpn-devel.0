From: Gert Doering <gert@...1296...>
Date: Sat, 23 May 2015 22:47:27 +0200
Message-Id: <1432414047-28674-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Correct note about DNS randomization in
	openvpn.8
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

Commit 4880739c17b502d00a removed DNS randomization, but this fact
never made it into the man page.

Trac #411

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 56e7e80..f6e910c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -265,9 +265,9 @@ not match
 If
 .B host
 is a DNS name which resolves to multiple IP addresses,
-one will be randomly
-chosen, providing a sort of basic load-balancing and
-failover capability.
+the first address returned by the system getaddrinfo() function 
+will be used (no DNS randomization inside OpenVPN 2.3.x, and 
+it will not try multiple addresses).
 .\"*********************************************************
 .TP
 .B \-\-remote\-random\-hostname
-- 
2.3.6


