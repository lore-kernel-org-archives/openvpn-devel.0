From: "Karl O. Pinc" <kop@...1206...>
Date: Sun, 28 Feb 2010 23:48:57 -0600
Message-Id: <1267422537-10119-1-git-send-email-kop@...1206...>
Subject: [Openvpn-devel] [PATCH] More improvments to openvpn(8) --tls-verify
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
Cc: Peter Stuge <peter@...1287...>

From: Karl O. Pinc <kop@...1304...>

---
 openvpn.8 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 0150ba7..9512fc3 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -4235,14 +4235,14 @@ should return 0 to allow the TLS handshake to proceed, or 1 to fail.
 
 Note that
 .B cmd
-may contain whitespace (if enclosed in quotes), in which case the first
-word of
+is a command line and as such may contain arguments separated by
+whitespace (if enclosed in quotes).  The first word of
 .B cmd
 is the shell command to execute and the remaining words are its
 arguments.
 When
 .B cmd
-is executed it is passed two (additional) arguments, as follows:
+is executed two arguments are appended, as follows:
 
 .B cmd certificate_depth X509_NAME_oneline
 
-- 
1.5.6.5


