From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Aug 2012 00:45:13 +0200
Message-Id: <1344379513-10871-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] management-signal maps disconnect to
	SIGTERM if used with management-client
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
 doc/openvpn.8 |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 56be29e..2b54d9b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2478,7 +2478,8 @@ command.
 .B \-\-management-signal
 Send SIGUSR1 signal to OpenVPN if management session disconnects.
 This is useful when you wish to disconnect an OpenVPN session on
-user logoff.
+user logoff. When used in conjuction with --management-client SIGTERM
+will be sent.
 .\"*********************************************************
 .TP
 .B \-\-management-log-cache n
-- 
1.7.9.6 (Apple Git-31.1)


