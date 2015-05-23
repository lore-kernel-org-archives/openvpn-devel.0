From: Gert Doering <gert@...1296...>
Date: Sat, 23 May 2015 22:56:53 +0200
Message-Id: <1432414613-29015-1-git-send-email-gert@...1296...>
In-Reply-To: <1432414047-28674-1-git-send-email-gert@...1296...>
References: <1432414047-28674-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH (master)] Correct note about DNS
	randomization in openvpn.8
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

Commit 4880739c17b502d00a removed DNS randomization, and the dual-stack
patches for 2.4 completely changed the getaddrinfo() result handling again,
but neither fact ever made it into the man page.

Trac #411

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 67e6ddd..d2b6359 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -268,9 +268,16 @@ not match
 If
 .B host
 is a DNS name which resolves to multiple IP addresses,
-one will be randomly
-chosen, providing a sort of basic load-balancing and
-failover capability.
+OpenVPN will try them in the order that the system getaddrinfo()
+presents them, so priorization and DNS randomization is done
+by the system library.  Unless an IP version is forced by the
+protocol specification (4/6 suffix), OpenVPN will try both IPv4
+and IPv6 addresses, in the order getaddrinfo() returns them.
+(Internally, multiple addresses are mutated into individual
+.B <connection>
+blocks, so
+.B \-\-remote\-random
+will randomize the order across all hosts and addresses)
 .\"*********************************************************
 .TP
 .B \-\-remote\-random\-hostname
-- 
2.3.6


