From: Arne Schwabe <arne@...1227...>
Date: Mon,  3 Sep 2012 14:16:04 +0200
Message-Id: <1346674564-17260-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Document that keep alive will double the
	second value in server mode and give a short explanation why
	the value is chosen.
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
 doc/openvpn.8 |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f586744..6b10fe4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1584,6 +1584,10 @@ and
 .B \-\-ping-restart
 in server mode configurations.
 
+The server timeout is set twice the value of the second argument. 
+This ensures that a timeout is dectected on client side 
+before the server side drops the connection.
+
 For example,
 .B \-\-keepalive 10 60
 expands as follows:
-- 
1.7.9.5


