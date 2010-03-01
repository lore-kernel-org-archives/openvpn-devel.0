From: "Karl O. Pinc" <kop@...1206...>
Date: Mon,  1 Mar 2010 00:41:05 -0600
Message-Id: <1267425665-10737-1-git-send-email-kop@...1206...>
Subject: [Openvpn-devel] [PATCH] Final frobbing of openvpn(8) --tls-verify
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
 openvpn.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 70e1e68..51d6ac5 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -4236,7 +4236,7 @@ should return 0 to allow the TLS handshake to proceed, or 1 to fail.
 Note that
 .B cmd
 is a command line and as such may (if enclosed in quotes) contain
-arguments separated by whitespace.  The first word of
+whitespace separated arguments.  The first word of
 .B cmd
 is the shell command to execute and the remaining words are its
 arguments.
-- 
1.5.6.5


