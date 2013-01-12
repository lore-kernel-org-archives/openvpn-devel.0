From: Matthias Andree <matthias.andree@...68...>
Date: Sat, 12 Jan 2013 13:41:17 +0100
Message-Id: <1357994477-29981-1-git-send-email-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH] Enable TCP_NODELAY configuration on FreeBSD.
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
Cc: Matthias Andree <matthias.andree@...68...>

The missing #include <netinet/tcp.h> causes a defined(TCP_NODELAY) to
fail.  I have added the patch to the FreeBSD ports OpenVPN 2.2.2 and
2.3.0, and confirmed (with strings ... | grep) that the TCP_NODELAY code
is now part of the executable on amd64, and results in this log output:

Sat Jan 12 13:39:18 2013 Listening for incoming TCP connection on [undef]
Sat Jan 12 13:39:18 2013 Socket flags: TCP_NODELAY=1 succeeded

Obtained from: https://community.openvpn.net/openvpn/ticket/158
Credits to: M. Nottebrock

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 src/openvpn/syshead.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index c81f08a..b14214d 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -307,6 +307,10 @@
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
1.8.1


