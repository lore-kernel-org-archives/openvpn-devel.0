From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:33 +0200
Message-Id: <1332575918-3384-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
Subject: [Openvpn-devel] [PATCH 1/6] build: ax_varargs.m4: fixups
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 m4/ax_varargs.m4 |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/m4/ax_varargs.m4 b/m4/ax_varargs.m4
index 37cdebe..c295d21 100644
--- a/m4/ax_varargs.m4
+++ b/m4/ax_varargs.m4
@@ -12,11 +12,12 @@ AC_DEFUN([AX_CPP_VARARG_MACRO_GCC], [dnl
 		[VAR],
 		[AC_COMPILE_IFELSE(
 			[AC_LANG_PROGRAM(
-				,
 				[[
 #define macro(a, b...) func(a, b)
 int func(int a, int b, int c);
-int test() { return macro(1, 2, 3); }
+				]],
+				[[
+int i = macro(1, 2, 3);
 				]]
 			)],
 			[VAR=yes],
@@ -50,11 +51,12 @@ AC_DEFUN([AX_CPP_VARARG_MACRO_ISO], [dnl
 		[VAR],
 		[AC_COMPILE_IFELSE(
 			[AC_LANG_PROGRAM(
-				,
 				[[
 #define macro(a, ...) func(a, __VA_ARGS__)
 int func(int a, int b, int c);
-int test() { return macro(1, 2, 3); }
+				]],
+				[[
+int i = macro(1, 2, 3);
 				]]
 			)],
 			[VAR=yes],
-- 
1.7.3.4


