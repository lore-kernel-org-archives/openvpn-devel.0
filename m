From: David Sommerseth <davids@...1347...>
Date: Fri, 26 Aug 2011 10:45:08 +0200
Message-Id: <1314348308-14896-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Define SOL_IP if compiling on OSX
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
Cc: David Sommerseth <davids@...1347...>

OSX Lion does not have SOL_IP defined.  If compiling on TARGET_DARWIN
and SOL_IP is not defined, make it the same as IPPROTO_IP.  This patch
is based upon a patch in the MacPorts bug tracker.

Reference: https://trac.macports.org/ticket/30253
Signed-off-by: David Sommerseth <davids@...1347...>
---
 syshead.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/syshead.h b/syshead.h
index 87cc369..c25fe38 100644
--- a/syshead.h
+++ b/syshead.h
@@ -390,6 +390,10 @@
 #define EXTENDED_SOCKET_ERROR_CAPABILITY 0
 #endif
 
+#if defined(TARGET_DARWIN) && !defined(SOL_IP)
+#define SOL_IP IPPROTO_IP  /* SOL_IP is not defined on OSX Lion */
+#endif /* TARGET_DARWIN && !SOL_IP */
+
 /*
  * Does this platform support linux-style IP_PKTINFO
  * or bsd-style IP_RECVDSTADDR ?
-- 
1.7.4.4


