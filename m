From: selva.nair@...277...
Date: Thu, 14 Nov 2019 14:40:07 -0500
Message-Id: <1573760407-20662-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
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

From: Selva Nair <selva.nair@...277...>

Some compilers (e.g., clang) only issue a warning for
unsupported options unless additional flags such
as -Werror are used to convert the warning to an error.

Add support for extra flags in ACL_CHECK_ADD_COMPILE_FLAGS.

Note: a similar approach is used in AX_CHECK_COMPILE_FLAG
in autoconf archives.

Signed-off-by: Selva Nair <selva.nair@...277...>
---

For successful travis build result see
https://travis-ci.org/selvanair/openvpn/builds/612019849

But this + https://patchwork.openvpn.net/patch/908/
alone does not fix the travis build as clang is not
happy with struct initializers: Like this

crypto.c:1860:31: error: suggest braces around initialization of subobject
      [-Werror,-Wmissing-braces]
    struct key server_key = { 0 };

I think clang wants {{0}} there.

Darn compilers and darn -Werror :)

 configure.ac | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 807804e5..e59bd91b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1275,18 +1275,21 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+# Usage: ACL_CHECK_ADD_COMPILE_FLAGS(flag, [extra-flags])
+# Some compilers require extra flags to trigger an error on
+# unsupported options. E.g., clang requires -Werror.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags="$CFLAGS"
-    CFLAGS="$1 $CFLAGS"
-    AC_MSG_CHECKING([whether the compiler acceppts $1])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])],
+    CFLAGS="$2 $1 $CFLAGS"
+    AC_MSG_CHECKING([whether the compiler accepts $1])
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS="$1 $old_cflags",
         [AC_MSG_RESULT([no]); CFLAGS="$old_cflags"])]
 )
 
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation], [-Werror])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function], [-Werror])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter], [-Werror])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wall], [-Werror])
 
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
-- 
2.20.1


