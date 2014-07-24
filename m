From: Arne Schwabe <arne@...1227...>
Date: Thu, 24 Jul 2014 23:37:46 +0200
Message-Id: <1406237866-9086-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove deprecated --max-routes option from
	manual
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
 doc/openvpn.8 | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index aee0bc8..f2911c0 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1011,13 +1011,6 @@ table (not supported on all OSes).
 address if OpenVPN is being run in client mode, and is undefined in server mode.
 .\"*********************************************************
 .TP
-.B \-\-max-routes n
-Allow a maximum number of n
-.B \-\-route
-options to be specified, either in the local configuration file,
-or pulled from an OpenVPN server.  By default, n=100.
-.\"*********************************************************
-.TP
 .B \-\-route-gateway gw|'dhcp'
 Specify a default gateway
 .B gw
-- 
1.8.5.2 (Apple Git-48)


