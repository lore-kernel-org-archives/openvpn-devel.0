From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat,  7 Apr 2012 20:39:26 +0300
Message-Id: <1333820366-9480-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: fix some statement left from
	conversion
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index e962323..0f1ca99 100644
--- a/configure.ac
+++ b/configure.ac
@@ -413,37 +413,37 @@ AC_CHECK_TYPES(
 )
 AC_CHECK_TYPE(
 	[struct tun_pi],
-	[AC_DEFINE(HAVE_TUN_PI, 1, [struct tun_pi needed for IPv6 support])],
+	[AC_DEFINE([HAVE_TUN_PI], [1], [struct tun_pi needed for IPv6 support])],
 	,
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
 	[struct iphdr],
-	[AC_DEFINE(HAVE_IPHDR, 1, [struct iphdr needed for IPv6 support])],
+	[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 support])],
 	,
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
 	[struct sock_extended_err],
-	[AC_DEFINE(HAVE_SOCK_EXTENDED_ERR, 1, [struct sock_extended_err needed for extended socket error support])],
+	[AC_DEFINE([HAVE_SOCK_EXTENDED_ERR], [1], [struct sock_extended_err needed for extended socket error support])],
 	,
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
 	[struct msghdr],
-	[AC_DEFINE(HAVE_MSGHDR, 1, [struct msghdr needed for extended socket error support])],
+	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket error support])],
 	,
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
 	[struct cmsghdr],
-	[AC_DEFINE(HAVE_CMSGHDR, 1, [struct cmsghdr needed for extended socket error support])],
+	[AC_DEFINE([HAVE_CMSGHDR], [1], [struct cmsghdr needed for extended socket error support])],
 	,
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
 	[struct in_pktinfo],
-	[AC_DEFINE(HAVE_IN_PKTINFO, 1, [struct in_pktinfo needed for IP_PKTINFO support])],
+	[AC_DEFINE([HAVE_IN_PKTINFO], [1], [struct in_pktinfo needed for IP_PKTINFO support])],
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-- 
1.7.3.4


