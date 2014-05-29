From: Steffan Karger <steffan@...1856...>
Date: Thu, 29 May 2014 12:39:07 +0200
Message-Id: <1401359947-31144-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add (default disabled) --enable-werror
	option to configure
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

Useful for example during development or automated builds, to make the
build error out if new warnings are introduced.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index ea35d73..1073312 100644
--- a/configure.ac
+++ b/configure.ac
@@ -244,6 +244,13 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[werror],
+	[AS_HELP_STRING([--enable-werror], [promote compiler warnings to errors, will cause builds to fail is the compiler issues warnings (debugging option) @<:@default=no@:>@])],
+	,
+	[enable_werror="no"]
+)
+
+AC_ARG_ENABLE(
 	[strict-options],
 	[AS_HELP_STRING([--enable-strict-options], [enable strict options check between peers (debugging option) @<:@default=no@:>@])],
 	,
@@ -1137,6 +1144,9 @@ fi
 if test "${enable_strict}" = "yes"; then
 	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
 fi
+if test "${enable_werror}" = "yes"; then
+	CFLAGS="${CFLAGS} -Werror"
+fi
 
 if test "${WIN32}" = "yes"; then
 	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
-- 
1.9.1


