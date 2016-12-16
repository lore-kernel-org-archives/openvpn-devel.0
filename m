From: Julien Muchembled <jm@...1926...>
Date: Fri, 16 Dec 2016 19:26:59 +0100
Message-Id: <20161216182659.18194-1-jm@...1926...>
In-Reply-To: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
Subject: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
	compiler supports them
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
Cc: kirr@...1926...

The bug in Trac #792 (pointer wrongly truncated as 'int', leading to segfaults)
would have been understood faster with either
  -Werror=implicit or -Werror=format
(and above all, before running buggy executables in production)

Debian already compiles with -Werror=format-security, and it's indeed a good
idea for a sensitive software like OpenVPN to use it.
---
> Yes, please!
> 
> You can put the macro in m4/
> 

OK. Not sure about the license. It's GPL3+
I also don't include the latest version, which has (among other changes):
-[AC_PREREQ(2.59)dnl for _AC_LANG_PREFIX
+[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF

configure.ac                |  7 +++++
 m4/ax_check_compile_flag.m4 | 74 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 m4/ax_check_compile_flag.m4

diff --git a/configure.ac b/configure.ac
index 4f086ea..3357ea0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -412,6 +412,13 @@ ifdef(
 	]
 )
 
+AX_CHECK_COMPILE_FLAG([ -Werror=implicit ], [
+    CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror=implicit"
+])
+AX_CHECK_COMPILE_FLAG([ -Werror=format -Werror=format-security ], [
+    CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror=format -Werror=format-security"
+])
+
 AC_C_CONST
 AC_C_INLINE
 AC_C_VOLATILE
diff --git a/m4/ax_check_compile_flag.m4 b/m4/ax_check_compile_flag.m4
new file mode 100644
index 0000000..51df0c0
--- /dev/null
+++ b/m4/ax_check_compile_flag.m4
@@ -0,0 +1,74 @@
+# ===========================================================================
+#   http://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_CHECK_COMPILE_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
+#
+# DESCRIPTION
+#
+#   Check whether the given FLAG works with the current language's compiler
+#   or gives an error.  (Warnings, however, are ignored)
+#
+#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
+#   success/failure.
+#
+#   If EXTRA-FLAGS is defined, it is added to the current language's default
+#   flags (e.g. CFLAGS) when the check is done.  The check is thus made with
+#   the flags: "CFLAGS EXTRA-FLAGS FLAG".  This can for example be used to
+#   force the compiler to issue an error when a bad flag is given.
+#
+#   INPUT gives an alternative input source to AC_COMPILE_IFELSE.
+#
+#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
+#   macro in sync with AX_CHECK_{PREPROC,LINK}_FLAG.
+#
+# LICENSE
+#
+#   Copyright (c) 2008 Guido U. Draheim <guidod@...68...>
+#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@...277...>
+#
+#   This program is free software: you can redistribute it and/or modify it
+#   under the terms of the GNU General Public License as published by the
+#   Free Software Foundation, either version 3 of the License, or (at your
+#   option) any later version.
+#
+#   This program is distributed in the hope that it will be useful, but
+#   WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+#   Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License along
+#   with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+#   As a special exception, the respective Autoconf Macro's copyright owner
+#   gives unlimited permission to copy, distribute and modify the configure
+#   scripts that are the output of Autoconf when processing the Macro. You
+#   need not follow the terms of the GNU General Public License when using
+#   or distributing such scripts, even though portions of the text of the
+#   Macro appear in them. The GNU General Public License (GPL) does govern
+#   all other use of the material that constitutes the Autoconf Macro.
+#
+#   This special exception to the GPL applies to versions of the Autoconf
+#   Macro released by the Autoconf Archive. When you make and distribute a
+#   modified version of the Autoconf Macro, you may extend this special
+#   exception to the GPL to apply to your modified version as well.
+
+#serial 3
+
+AC_DEFUN([AX_CHECK_COMPILE_FLAG],
+[AC_PREREQ(2.59)dnl for _AC_LANG_PREFIX
+AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
+AC_CACHE_CHECK([whether _AC_LANG compiler accepts $1], CACHEVAR, [
+  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
+  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1"
+  AC_COMPILE_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
+    [AS_VAR_SET(CACHEVAR,[yes])],
+    [AS_VAR_SET(CACHEVAR,[no])])
+  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
+AS_IF([test x"AS_VAR_GET(CACHEVAR)" = xyes],
+  [m4_default([$2], :)],
+  [m4_default([$3], :)])
+AS_VAR_POPDEF([CACHEVAR])dnl
+])dnl AX_CHECK_COMPILE_FLAGS
-- 
2.10.2.2.g19ca937.dirty


