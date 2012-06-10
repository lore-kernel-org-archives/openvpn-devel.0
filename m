From: Gert Doering <gert@...1296...>
Date: Sun, 10 Jun 2012 17:41:29 +0200
Message-Id: <1339342891-28443-4-git-send-email-gert@...1296...>
In-Reply-To: <1339342891-28443-1-git-send-email-gert@...1296...>
References: <1339342891-28443-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 3/5] Remove warning about "explicit support
	for IPv6 tun devices is not provided for this OS" for MacOS X
	(because it *is*).
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 460684f..1842a97 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2442,7 +2442,7 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
-  open_tun_generic (dev, dev_type, dev_node, false, true, tt);
+  open_tun_generic (dev, dev_type, dev_node, true, true, tt);
 }
 
 void
-- 
1.7.3.4


