From: Steffan Karger <steffan@...1856...>
Date: Mon, 18 May 2015 21:21:09 +0200
Message-Id: <1431976869-4948-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Updated manpage for --rport and --lport
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
Cc: Robert Fischer <ml-openvpn@...2035...>

[SK: v2, patch taken from trac #127 and updated to current master branch]

Signed-off-by: Robert Fischer <ml-openvpn@...2035...>
Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 23cc789..b9eee0d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -670,18 +670,28 @@ peer on its new IP address.
 .\"*********************************************************
 .TP
 .B \-\-port port
-TCP/UDP port number or port name for both local and remote.  The current
+TCP/UDP port number or port name for both local and remote (sets both
+.B \-\-lport
+and
+.B \-\-rport
+options to given port).  The current
 default of 1194 represents the official IANA port number
 assignment for OpenVPN and has been used since version 2.0-beta17.
 Previous versions used port 5000 as the default.
 .\"*********************************************************
 .TP
 .B \-\-lport port
-TCP/UDP port number or name for bind.
+Set local TCP/UDP port number or name.  Cannot be used together with
+.B \-\-nobind
+option.
 .\"*********************************************************
 .TP
 .B \-\-rport port
-TCP/UDP port number or name for remote.
+Set TCP/UDP port number or name used by the
+.B \-\-remote
+option. The port can also be set directly using the
+.B \-\-remote
+option.
 .\"*********************************************************
 .TP
 .B \-\-bind [ipv6only]
-- 
2.1.4


