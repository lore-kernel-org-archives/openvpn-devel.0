From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Jan 2014 16:30:37 +0100
Message-ID: <1389972638-8006-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] make sure sa_family_t is defined
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

On Windows there's no sa_family_t. This patch defines it in
syshead.h is configure did not find it in the system headers.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 configure.ac          |    6 ++++++
 src/openvpn/syshead.h |    7 +++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 636d4e2..65dbc25 100644
--- a/configure.ac
+++ b/configure.ac
@@ -501,6 +501,12 @@ AC_CHECK_TYPE(
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
+        [sa_family_t],
+        [AC_DEFINE([HAVE_SA_FAMILY_T], [1], [struct in_pktinfo needed for IP_PKTINFO support])],
+        ,
+        [[${SOCKET_INCLUDES}]]
+)
+AC_CHECK_TYPE(
 	[struct sockaddr_in6],
 	,
 	[AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transport support.])],
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index ab6fa01..4050d54 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -426,6 +426,13 @@
 #endif
 
 /*
+ * Define type sa_family_t if it isn't defined in the socket headers
+ */
+#ifndef HAVE_SA_FAMILY_T
+typedef unsigned short sa_family_t;
+#endif
+
+/*
  * Disable ESEC
  */
 #if 0
-- 
1.7.9


