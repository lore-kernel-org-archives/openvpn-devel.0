From: Gert Doering <gert@...1296...>
Date: Fri, 24 Feb 2017 14:52:22 +0100
Message-Id: <20170224135222.44640-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix "--dev null"
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

To test whether a server is reachable and all the key handling is
right, openvpn can connect with "--dev null --ifconfig-noexec" to
avoid needing to the client with elevated privileges.

This was erroring out for no good reason (because the "set environment
variables appropriately" code didn't know if this is a tun or tap
device...) - treat --dev null as "tap", done.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 31585b32..12ce99d5 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -560,7 +560,9 @@ is_tun_p2p(const struct tuntap *tt)
 {
     bool tun = false;
 
-    if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
+    if (tt->type == DEV_TYPE_TAP ||
+        (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET) ||
+	tt->type == DEV_TYPE_NULL )
     {
         tun = false;
     }
-- 
2.11.1


