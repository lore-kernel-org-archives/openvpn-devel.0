From: Davide Brini <dave_br@...1278...>
Date: Thu, 15 Apr 2010 19:52:02 +0100
MIME-Version: 1.0
Message-Id: <201004151952.02756.dave_br@...1278...>
Subject: [Openvpn-devel] [PATCH] Mention mssfix default value in the man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The man page does not mention that the default value of "mssfix" is 1450.

--- openvpn-2.1.1/openvpn.8     2010-02-28 22:17:45.000000000 +0000
+++ openvpn-2.1.1-a/openvpn.8   2010-04-15 19:43:53.000000000 +0100
@@ -1223,7 +1223,8 @@ their send packet sizes such that after
 the resulting UDP packet size that OpenVPN sends to its peer will not
 exceed
 .B max
-bytes.
+bytes. The default value is
+.B 1450.

 The
 .B max

-- 
D.

