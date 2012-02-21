From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:24 +0200
Message-Id: <1329787361-26096-19-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 18/35] build: m4/ax_emptyarray.m4: cleanup
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
 m4/ax_emptyarray.m4 |   49 +++++++++++++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/m4/ax_emptyarray.m4 b/m4/ax_emptyarray.m4
index 0a8755c..c6781c1 100644
--- a/m4/ax_emptyarray.m4
+++ b/m4/ax_emptyarray.m4
@@ -7,21 +7,34 @@ dnl
 dnl @version
 dnl @author James Yonan <jim@...41...>
 AC_DEFUN([AX_EMPTY_ARRAY], [
-  AC_MSG_RESULT([checking for C compiler empty array support])
-  AC_COMPILE_IFELSE([AC_LANG_SOURCE(
-    [
-        struct { int foo; int bar[[0]]; } mystruct;
-    ])], [
-        AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE, 0, [Dimension to use for empty array declaration])
-    ], [
-        AC_COMPILE_IFELSE([AC_LANG_SOURCE(
-	    [
-	        struct { int foo; int bar[[]]; } mystruct;
-	    ])], [
-                AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE,, [Dimension to use for empty array declaration])
-	    ], [
-	        AC_MSG_ERROR([C compiler is unable to creaty empty arrays])
-	    ])
-    ])
-  ]
-)
+	AS_VAR_PUSHDEF([VAR],[ax_cv_c_empty_array])dnl
+	AC_CACHE_CHECK(
+		[for C compiler empty array size],
+		[VAR],
+		[AC_COMPILE_IFELSE(
+			[AC_LANG_PROGRAM(
+				,
+				[[
+struct { int foo; int bar[0]; } mystruct;
+				]]
+			)],
+			[VAR=0],
+			[AC_COMPILE_IFELSE(
+				[AC_LANG_PROGRAM(
+					,
+					[[
+struct { int foo; int bar[]; } mystruct;
+					]]
+				)],
+				[VAR=],
+				[AC_MSG_ERROR([C compiler is unable to creaty empty arrays])]
+			)]
+		)]
+	)dnl
+	AC_DEFINE_UNQUOTED(
+		[EMPTY_ARRAY_SIZE],
+		[$VAR],
+		[Dimension to use for empty array declaration]
+	)dnl
+	AS_VAR_POPDEF([VAR])dnl
+])
-- 
1.7.3.4


