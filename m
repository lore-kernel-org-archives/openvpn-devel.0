From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Sat, 10 Jun 2017 19:46:46 +0200
Message-ID: <87fuf7u455.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: [Openvpn-devel] Missing include for socket-flags TCP_NODELAY on
 OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain


Issue reported & patch provided by Kurt Miller:

Using "socket-flags TCP_NODELAY" results in

-->8--
Sat Jun 10 19:43:22 2017 NOTE: setsockopt TCP_NODELAY=1 failed (No kernel support)
--8<--
instead of the expected
-->8--
Sat Jun 10 19:44:16 2017 Socket flags: TCP_NODELAY=1 succeeded
--8<--

Patch tested with 2.4.2 and the git master branch.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Missing-include-for-socket-flags-TCP_NODELAY-on-Open.patch

From aab4839b24e4c80f5ab814a0c972a0fb029d2d9f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Courr=C3=A8ges-Anglas?= <jca@...2272...>
Date: Sat, 10 Jun 2017 19:31:21 +0200
Subject: [PATCH] Missing include for socket-flags TCP_NODELAY on OpenBSD

Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
---
 src/openvpn/syshead.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index f4458648..14b6662a 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -288,6 +288,10 @@
 #include <netinet/ip.h>
 #endif
 
+#ifdef HAVE_NETINET_TCP_H
+#include <netinet/tcp.h>
+#endif
+
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
 #endif
-- 
2.13.0


--=-=-=
Content-Type: text/plain


-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

