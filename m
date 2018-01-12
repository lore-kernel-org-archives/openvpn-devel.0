From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Jan 2018 17:14:14 +0800
Message-Id: <20180112091414.16271-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] manpage: fix simple typ0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/openvpn.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2b5cab12..43389cd3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1621,7 +1621,7 @@ and
 .B \-\-ping\-restart.
 
 This option can be used on both client and server side, but it is
-in enough to add this on the server side as it will push appropriate
+enough to add this on the server side as it will push appropriate
 .B \-\-ping
 and
 .B \-\-ping\-restart
-- 
2.15.1


