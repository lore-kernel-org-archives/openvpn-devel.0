From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 16:18:54 -0500
Message-Id: <1479676734-21630-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Do not set ipv6 address if '--ip-win32
	manual' is used
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

This also applies to --ifconfig-noexec.

Resolves Trac #723

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/tun.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 77ae72f..36e0b15 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1372,7 +1372,13 @@ do_ifconfig (struct tuntap *tt,
 
     if ( do_ipv6 )
       {
-	if (tt->options.msg_channel)
+	if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
+	  {
+	    msg (M_INFO, "******** NOTE:  Please manually set the v6 IP of '%s' to %s (if it is not already set)",
+	         actual,
+	         ifconfig_ipv6_local);
+          }
+	else if (tt->options.msg_channel)
 	  {
 	    do_address_service (true, AF_INET6, tt);
 	  }
@@ -1391,7 +1397,10 @@ do_ifconfig (struct tuntap *tt,
 	  }
 
 	/* explicit route needed */
-	add_route_connected_v6_net(tt, es);
+	if (tt->options.ip_win32_type != IPW32_SET_MANUAL)
+	  {
+	    add_route_connected_v6_net(tt, es);
+	  }
       }
 #else
       msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
-- 
2.1.4


