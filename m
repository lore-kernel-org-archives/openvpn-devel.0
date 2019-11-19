From: selva.nair@...277...
Date: Tue, 19 Nov 2019 12:03:43 -0500
Message-Id: <1574183023-6136-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1573760407-20662-1-git-send-email-selva.nair@...277...>
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
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
unsupported options unless an additional flag such
as -Werror is used to convert the warning to an error.

The behaviour is unchanged when using gcc as it either
errors or ignores unknown options whether or not -Werror
is present.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
v2: Do not extend the macro to take an extra argument.
Instead, add -Werror while doing the test.

The commit message and comment changed to match this.

 configure.ac | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 807804e5..f4a947d2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1275,11 +1275,14 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+# When testing a compiler option, we add -Werror to force
+# an error when the option is unsupported. This is not
+# required for gcc, but come compilers such as clang needs it.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags="$CFLAGS"
-    CFLAGS="$1 $CFLAGS"
-    AC_MSG_CHECKING([whether the compiler acceppts $1])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])],
+    CFLAGS="$1 -Werror $CFLAGS"
+    AC_MSG_CHECKING([whether the compiler accepts $1])
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS="$1 $old_cflags",
         [AC_MSG_RESULT([no]); CFLAGS="$old_cflags"])]
 )
 
-- 
2.20.1


