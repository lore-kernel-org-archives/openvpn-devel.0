From: Ilya Shipitsin <chipitsine@...277...>
Date: Sun,  9 Jul 2017 19:46:46 +0500
Message-Id: <20170709144646.10352-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] win32 build: check for ENETUNREACH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Currently, we do not check for mingw-gcc version. For example,
Debian 7 is shipped with 4.6.3, which does not know about ENETUNREACH
---

this is for 2.4 and HEAD branches

 configure.ac | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index 60bb465..80b26ff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -708,6 +708,20 @@ m4_define(
 	[setsockopt getsockopt getsockname poll]dnl
 )
 if test "${WIN32}" = "yes"; then
+
+#
+# check for ENETUNREACH 
+# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is too old
+#
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM(
+[[#include <errno.h>
+#if !defined (ENETUNREACH)
+# error ENETUNREACH not defined
+#endif
+]])],
+                   ,
+                   [AC_MSG_ERROR([gcc-mingw is too old, please update])])
+
 # normal autoconf function checking does not find inet_ntop/inet_pton
 # because they need to include the actual header file and link ws2_32.dll
 	LIBS="${LIBS} -lws2_32"
-- 
2.9.4


