From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:38 +0300
Message-Id: <1336850389-23719-6-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 05/16] cleanup: syshead: move apple specific
	CPPFLAGS out of syshead
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
 configure.ac          |   18 ++++++++++++++++++
 src/openvpn/syshead.h |    6 ------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6f6a1f4..9fcd7fe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -357,6 +357,24 @@ AC_TYPE_UINT16_T
 AC_TYPE_UINT32_T
 AC_TYPE_UINT64_T
 AC_TYPE_SIGNAL
+
+AC_MSG_CHECKING([Apple specific settings])
+AC_EGREP_CPP(
+	[true],
+	[
+#if defined(__APPLE__)
+#if __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ >= 1070
+true
+#endif
+#endif
+	],
+	[
+		AC_MSG_RESULT([required])
+		CPPFLAGS="${CPPFLAGS} -D__APPLE_USE_RFC_3542=1"
+	],
+	[AC_MSG_RESULT([not required])]
+)
+
 AX_CPP_VARARG_MACRO_ISO
 AX_CPP_VARARG_MACRO_GCC
 AX_TYPE_SOCKLEN_T
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index ccd78af..c5bf4a8 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -45,12 +45,6 @@
 #define srandom srand
 #endif
 
-#if defined(__APPLE__)
-#if __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ >= 1070
-#define __APPLE_USE_RFC_3542  1
-#endif
-#endif
-
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
-- 
1.7.3.4


