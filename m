From: Christian Hesse <list@...1798...>
Date: Fri, 24 Feb 2017 13:22:52 +0100
Message-Id: <20170224122252.15199-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] fix typo in notification message
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ff1551e..7da0061 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -567,7 +567,7 @@ context_init_1(struct context *c)
      * do any fork due to daemon() a future call.
      * See possibly_become_daemon() [init.c] for more details.
      */
-    sd_notifyf(0, "READY=1\nSTATUS=Pre-connection initialization succesfull\nMAINPID=%lu",
+    sd_notifyf(0, "READY=1\nSTATUS=Pre-connection initialization successful\nMAINPID=%lu",
                (unsigned long) getpid());
 #endif
 
-- 
2.11.1


