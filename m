From: David Sommerseth <davids@...1347...>
Date: Thu, 24 Mar 2011 14:54:04 +0100
Message-Id: <1300974844-23829-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Clarify default value for the --inactive
	option.
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
Cc: David Sommerseth <davids@...1347...>

It is not clear in the manual that this feature is disabled
by default.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 openvpn.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 525ddd5..9639f75 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -1374,7 +1374,7 @@ Causes OpenVPN to exit after
 .B n
 seconds of inactivity on the TUN/TAP device. The time length of
 inactivity is measured since the last incoming or outgoing tunnel
-packet.
+packet.  The default value is 0 seconds, which disables this feature.
 
 If the optional
 .B bytes
-- 
1.7.4


