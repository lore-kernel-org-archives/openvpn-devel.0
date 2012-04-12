From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 12 Apr 2012 08:50:12 +0200
Message-ID: <1334213412-10048-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure sys/un.h autoconf detection includes
	sys/socket.h
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

This is required to build an Android binary.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 70c51e7..dc5bb43 100644
--- a/configure.ac
+++ b/configure.ac
@@ -363,7 +363,7 @@ AC_CHECK_HEADERS([ \
 	windows.h winsock2.h ws2tcpip.h \
 ])
 AC_CHECK_HEADERS([ \
-	sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
+	sys/time.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h \
 	unistd.h signal.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h \
@@ -399,7 +399,7 @@ SOCKET_INCLUDES="
 "
 
 AC_CHECK_HEADERS(
-	[net/if.h netinet/ip.h netinet/if_ether.h resolv.h],
+	[net/if.h netinet/ip.h netinet/if_ether.h resolv.h sys/un.h],
 	,
 	,
 	[[${SOCKET_INCLUDES}]]
-- 
1.7.5.4


