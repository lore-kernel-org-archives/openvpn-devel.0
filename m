Resent-Message-ID: <20180221185001.GX69387@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-ID: <20180221182823.mtjfu75kulgdudkm@...2379...>
Resent-To: gert@...1296...
From: Steffan Karger <steffan@...1856...>
Date: Tue, 20 Feb 2018 21:25:08 +0100
Message-Id: <20180220202508.16201-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Get rid of ax_check_compile_flag.m4
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

The macro was too new for some of the platforms we still support.  In
particular, centos/rhel 6 and opensolaris 10.  To work around that, we
introduce our own simpler and more tailored ACL_CHECK_ADD_COMPILE_FLAGS
macro, that not only checks but also sets the flags in CFLAGS if it is
accepted.  Since this doesn't use new-and-shine autoconf features, it
should also work on the legacy platforms.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                | 18 ++++++-----
 m4/ax_check_compile_flag.m4 | 74 ---------------------------------------------
 2 files changed, 10 insertions(+), 82 deletions(-)
 delete mode 100644 m4/ax_check_compile_flag.m4

diff --git a/configure.ac b/configure.ac
index 1496fd55..626b4dd4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1292,15 +1292,17 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
-AX_CHECK_COMPILE_FLAG(
-	[-Wno-unused-function],
-	[CFLAGS="-Wno-unused-function ${CFLAGS}"]
+AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
+    old_cflags="$CFLAGS"
+    CFLAGS="$1 $CFLAGS"
+    AC_MSG_CHECKING([whether the compiler acceppts $1])
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])],
+        [AC_MSG_RESULT([no]); CFLAGS="$old_cflags"])]
 )
-AX_CHECK_COMPILE_FLAG(
-	[-Wno-unused-parameter],
-	[CFLAGS="-Wno-unused-parameter ${CFLAGS}"]
-)
-AX_CHECK_COMPILE_FLAG([-Wall], [CFLAGS="-Wall ${CFLAGS}"])
+
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
 
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
diff --git a/m4/ax_check_compile_flag.m4 b/m4/ax_check_compile_flag.m4
deleted file mode 100644
index dcabb92a..00000000
--- a/m4/ax_check_compile_flag.m4
+++ /dev/null
@@ -1,74 +0,0 @@
-# ===========================================================================
-#  https://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
-# ===========================================================================
-#
-# SYNOPSIS
-#
-#   AX_CHECK_COMPILE_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
-#
-# DESCRIPTION
-#
-#   Check whether the given FLAG works with the current language's compiler
-#   or gives an error.  (Warnings, however, are ignored)
-#
-#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
-#   success/failure.
-#
-#   If EXTRA-FLAGS is defined, it is added to the current language's default
-#   flags (e.g. CFLAGS) when the check is done.  The check is thus made with
-#   the flags: "CFLAGS EXTRA-FLAGS FLAG".  This can for example be used to
-#   force the compiler to issue an error when a bad flag is given.
-#
-#   INPUT gives an alternative input source to AC_COMPILE_IFELSE.
-#
-#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
-#   macro in sync with AX_CHECK_{PREPROC,LINK}_FLAG.
-#
-# LICENSE
-#
-#   Copyright (c) 2008 Guido U. Draheim <guidod@...68...>
-#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@...277...>
-#
-#   This program is free software: you can redistribute it and/or modify it
-#   under the terms of the GNU General Public License as published by the
-#   Free Software Foundation, either version 3 of the License, or (at your
-#   option) any later version.
-#
-#   This program is distributed in the hope that it will be useful, but
-#   WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-#   Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License along
-#   with this program. If not, see <https://www.gnu.org/licenses/>.
-#
-#   As a special exception, the respective Autoconf Macro's copyright owner
-#   gives unlimited permission to copy, distribute and modify the configure
-#   scripts that are the output of Autoconf when processing the Macro. You
-#   need not follow the terms of the GNU General Public License when using
-#   or distributing such scripts, even though portions of the text of the
-#   Macro appear in them. The GNU General Public License (GPL) does govern
-#   all other use of the material that constitutes the Autoconf Macro.
-#
-#   This special exception to the GPL applies to versions of the Autoconf
-#   Macro released by the Autoconf Archive. When you make and distribute a
-#   modified version of the Autoconf Macro, you may extend this special
-#   exception to the GPL to apply to your modified version as well.
-
-#serial 5
-
-AC_DEFUN([AX_CHECK_COMPILE_FLAG],
-[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
-AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
-AC_CACHE_CHECK([whether _AC_LANG compiler accepts $1], CACHEVAR, [
-  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
-  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1"
-  AC_COMPILE_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
-    [AS_VAR_SET(CACHEVAR,[yes])],
-    [AS_VAR_SET(CACHEVAR,[no])])
-  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
-AS_VAR_IF(CACHEVAR,yes,
-  [m4_default([$2], :)],
-  [m4_default([$3], :)])
-AS_VAR_POPDEF([CACHEVAR])dnl
-])dnl AX_CHECK_COMPILE_FLAGS
-- 
2.14.1


