From: Arne Schwabe <arne@...1227...>
Date: Mon,  3 Sep 2012 13:57:22 +0200
Message-Id: <1346673442-12049-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] Document that keep alive will double
	the second value in server mode and give a short explanation
	why the value is chosen.
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
 doc/openvpn.8 |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f586744..bfc8c25 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1582,7 +1582,11 @@ A helper directive designed to simplify the expression of
 .B \-\-ping
 and
 .B \-\-ping-restart
-in server mode configurations.
+in server mode configurations. 
+
+The server timeout is set twice the value of the second argument. 
+This ensures that a timeout is dectected on client side before the
+before server side drops the connection.
 
 For example,
 .B \-\-keepalive 10 60
-- 
1.7.9.6 (Apple Git-31.1)


