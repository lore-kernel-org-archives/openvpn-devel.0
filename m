From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Aug 2012 19:31:42 +0200
Message-Id: <1344447102-22271-1-git-send-email-arne@...1227...>
In-Reply-To: <20120808103623.GP2535@...1296...>
References: <20120808103623.GP2535@...1296...>
Subject: [Openvpn-devel] [PATCH] Document --management-client and
	--management-signal a bit better
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8 |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 56be29e..845fb9a 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2431,11 +2431,14 @@ be set to 127.0.0.1
 server to local clients. 
 .TP
 .B \-\-management-client
-Management interface will connect as a TCP client to
+Management interface will connect as a TCP/unix domain client to
 .B IP:port
 specified by
 .B \-\-management
-rather than listen as a TCP server.
+rather than listen as a TCP server or on a unix domain socket.
+
+If the client connection fails to connect or is disconnected, 
+a SIGTERM signal will be generated causing OpenVPN to quit.
 .\"*********************************************************
 .TP
 .B \-\-management-query-passwords
@@ -2478,7 +2481,8 @@ command.
 .B \-\-management-signal
 Send SIGUSR1 signal to OpenVPN if management session disconnects.
 This is useful when you wish to disconnect an OpenVPN session on
-user logoff.
+user logoff. For --management-client this option is not needed since
+a disconnect will always generate a SIGTERM.
 .\"*********************************************************
 .TP
 .B \-\-management-log-cache n
-- 
1.7.9.6 (Apple Git-31.1)


