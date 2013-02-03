Message-ID: <510E4344.6010608@...1147...>
Date: Sun, 03 Feb 2013 12:00:20 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] man page patch for missing options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi all,

attached is a man page patch to include the options that were made 
connection-entry specific (by a patch of mine, which is included in 2.3.0).

see you in a bit,

JJK

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2ed5201..829bbd2 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -346,20 +346,27 @@ block:
 .B connect-retry,
 .B connect-retry-max,
 .B connect-timeout,
+.B explicit-exit-notify,
 .B float,
+.B fragment,
 .B http-proxy,
 .B http-proxy-option,
 .B http-proxy-retry,
 .B http-proxy-timeout,
+.B link-mtu,
 .B local,
 .B lport,
+.B mssfix,
+.B mtu-disc,
 .B nobind,
 .B port,
 .B proto,
 .B remote,
 .B rport,
-.B socks-proxy, and
-.B socks-proxy-retry.
+.B socks-proxy,
+.B socks-proxy-retry,
+.B tun-mtu and
+.B tun-mtu-extra.
 
 A defaulting mechanism exists for specifying options to apply to
 all


