Resent-Message-Id: <201209111200.q8BC0b4R007651@...1295...>
From: Gert Doering <gert@...1296...>
Date: Tue, 11 Sep 2012 13:56:55 +0200
Message-Id: <1347364615-26878-1-git-send-email-gert@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH] make "ipv6 ifconfig" on linux compatible
	with busybox ifconfig
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

We used to call "ifconfig tun0 inet6 add...".  The "inet6" part is optional,
and not understood by busybox.  So now we call "ifconfig tun0 add ...",
which works on all supported Linux variants.

Tested on Gentoo, RHEL5+, Debian Lenny & up.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3d60857..4b0365d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -760,7 +760,7 @@ do_ifconfig (struct tuntap *tt,
       if ( do_ipv6 )
 	{
 	  argv_printf (&argv,
-			  "%s %s inet6 add %s/%d",
+			  "%s %s add %s/%d",
 			  IFCONFIG_PATH,
 			  actual,
 			  ifconfig_ipv6_local,
-- 
1.7.8.6


