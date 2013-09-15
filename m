Date: Sun, 15 Sep 2013 14:31:49 +0200
From: Davide Brini <dave_br@...1278...>
Mime-Version: 1.0
Message-ID: <0MTjMy-1VU1I42Lo0-00QV4k@...1825...>
Subject: [Openvpn-devel] [PATCH] Document authfile for socks server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

It looks like it's possible to specify an optional authfile as third
argument of the "socks-proxy" directive. This patch updates the man page to
document that.

Signed-off-by: Davide Brini <dave_br@...1278...>

---
 doc/openvpn.8 |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index c0b209c..ed0fa63 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -554,12 +554,15 @@ Set HTTP "User-Agent" string to
 .B user-agent.
 .\"*********************************************************
 .TP
-.B \-\-socks-proxy server [port]
+.B \-\-socks-proxy server [port] [authfile]
 Connect to remote host through a Socks5 proxy at address
 .B server
 and port
 .B port
 (default=1080).
+.B authfile
+(optional) is a file containing a username and password on 2 lines, or
+"stdin" to prompt from console.
 .\"*********************************************************
 .TP
 .B \-\-socks-proxy-retry

-- 
D.

