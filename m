From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:47 +0300
Message-Id: <1336850389-23719-15-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 14/16] cleanup: syshead: move SOL_IP
	emulation to autoconf
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |   11 +++++++++++
 src/openvpn/syshead.h |    8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2c80ef4..193d287 100644
--- a/configure.ac
+++ b/configure.ac
@@ -490,6 +490,17 @@ AC_CHECK_DECLS(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
+AC_CHECK_DECLS(
+	[SOL_IP],
+	,
+	[AC_CHECK_DECLS(
+		[IPPROTO_IP],
+		[AC_DEFINE_UNQUOTED([SOL_IP], [IPPROTO_IP], [SOL_IP emulation])],
+		[AC_MSG_ERROR([cannot find SOL_IP or IPPROTO_IP])],
+		[[${SOCKET_INCLUDES}]]
+	)],
+	[[${SOCKET_INCLUDES}]]
+)
 
 dnl We emulate signals in Windows
 AC_CHECK_DECLS(
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index f908752..c4dfd0b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -367,14 +367,6 @@
 #endif
 
 /*
- * Does this platform define SOL_IP
- * or only bsd-style IPPROTO_IP ?
- */
-#ifndef SOL_IP
-#define SOL_IP IPPROTO_IP
-#endif
-
-/*
  * Do we have a syslog capability?
  */
 #if defined(HAVE_OPENLOG) && defined(HAVE_SYSLOG)
-- 
1.7.3.4


